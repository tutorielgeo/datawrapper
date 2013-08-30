
root._ = require 'underscore'
root.Globalize = require 'globalize'
vows = require 'vows'
assert = require 'assert'
dw = require '../dw-2.0.js'


Globalize.culture "de"

formats =
    'dates':
        '1st': new Date(1990, 0, 1)
        'values': [new Date(1990, 0, 1), new Date(1990, 6, 1), new Date(1991, 11, 1)]
    'years':
        '1st': new Date(1985, 0, 1)
        'values': ['1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992', '1993', '1994', '1995', '1996', '1997', '1998', '1999', '2000', '2001', '2002', '2003', '2004', '2005', '2006', '2007', '2008', '2009', '2010']
    'half':
        '1st': new Date(1990, 6, 1)
        'values': ['1990 H2', '1991 H1', '1991 H2', '1992 H1', '1992 H2', '1993 H1', '1993 H2'],
    'quarter':
        '1st': new Date(1990, 3, 1)
        'values': ['1990Q2', '1990Q3', '1990Q4', '1991Q1', '1991Q2', '1991Q3', '1991Q4', '1992Q1', '1992Q2', '1992Q3', '1992Q4']
    'quarter ':
        '1st': new Date(1990, 6, 1)
        'values': ['1990 Q3', '1990 Q4', '1991 Q1', '1991 Q2', '1991 Q3', '1991 Q4', '1992 Q1', '1992 Q2', '1992 Q3', '1992 Q4']
    'quarter/':
        '1st': new Date(1990, 0, 1)
        'values': ['1990/Q1', '1990/Q2', '1990/Q3', '1990/Q4', '1991/Q1', '1991/Q2', '1991/Q3', '1991/Q4', '1992/Q1', '1992/Q2', '1992/Q3', '1992/Q4']
    'quarter-':
        '1st': new Date(1990, 0, 1)
        'values': ['1990/Q1', '1990/Q2', '1990/Q3', '1990/Q4', '1991/Q1', '1991/Q2', '1991/Q3', '1991/Q4', '1992/Q1', '1992/Q2', '1992/Q3', '1992/Q4']
    'quarter2/':
        '1st': new Date(1990, 0, 1)
        'values': ['Q1/1990', 'Q2/1990', 'Q3/1990', 'Q4/1990', 'Q1/1991', 'Q2/1991', 'Q3/1991', 'Q4/1991', 'Q1/1992', 'Q2/1992', 'Q3/1992', 'Q4/1992']
    'quarter2-':
        '1st': new Date(1990, 0, 1)
        'values': ['Q1-1990', 'Q2-1990', 'Q3-1990', 'Q4-1990', 'Q1-1991', 'Q2-1991', 'Q3-1991', 'Q4-1991', 'Q1-1992', 'Q2-1992', 'Q3-1992', 'Q4-1992']
    'month1':
        '1st': new Date(1999, 6, 1)
        'values': ['1999-07', '1999-08', '1999-09', '1999-10', '1999-11', '1999-12', '2000-01', '2000-02', '2000-03', '2000-04', '2000-05', '2000-06']
    'month2':
        '1st': new Date(1999, 6, 1)
        'values': ['1999/07', '1999/08', '1999/09', '1999/10', '1999/11', '1999/12', '2000/01', '2000/02', '2000/03', '2000/04', '2000/05', '2000/06']
    'month3':
        '1st': new Date(1999, 6, 1)
        'values': ['1999 7', '1999 8', '1999 9', '1999 10', '1999 11', '1999 12', '2000 1', '2000 2', '2000 3', '2000 4', '2000 5', '2000 6']
    'month4':
        '1st': new Date(1999, 6, 1)
        'values': ['1999/7', '1999/8', '1999/9', '1999/10', '1999/11', '1999/12', '2000/1', '2000/2', '2000/3', '2000/4', '2000/5', '2000/6']
    'month5':
        '1st': new Date(1999, 6, 1)
        'values': ['7/1999', '8/1999', '9/1999', '10/1999', '11/1999', '12/1999', '1/2000', '2/2000', '3/2000', '4/2000', '5/2000', '6/2000'],
    'date-iso':
        '1st': new Date(1999, 11, 27)
        'values': ['1999-12-27', '1999-12-28', '1999-12-29', '1999-12-30', '1999-12-31', '2000-01-01', '2000-01-02', '2000-01-03', '2000-01-04', '2000-01-05', '2000-01-06', '2000-01-07']
    'date-german':
        '1st': new Date(1999, 11, 27)
        'values': ['27.12.1999', '28.12.1999', '29.12.1999', '30.12.1999', '31.12.1999', '01.01.2000', '02.01.2000', '03.01.2000', '04.01.2000', '05.01.2000', '06.01.2000', '07.01.2000']
    'date-french':
        '1st': new Date(1999, 11, 27)
        'values': ['27/12/1999', '28/12/1999', '29/12/1999', '30/12/1999', '31/12/1999', '01/01/2000', '02/01/2000', '03/01/2000', '04/01/2000', '05/01/2000', '06/01/2000', '07/01/2000']
    'date-us':
        '1st': new Date(1999, 11, 27)
        'values': ['12/27/1999', '12/28/1999', '12/29/1999', '12/30/1999', '12/31/1999', '01/01/2000', '01/02/2000', '01/03/2000', '01/04/2000', '01/05/2000', '01/06/2000', '01/07/2000']
    'date-iso-time':
        '1st': new Date(1999, 11, 27, 22)
        'values': ['1999-12-27 22:00', '1999-12-27 22:30', '1999-12-27 23:00', '1999-12-27 23:30', '1999-12-28 00:00', '1999-12-28 00:30', '1999-12-28 01:00', '1999-12-28 01:30', '1999-12-28 02:00', '1999-12-28 02:30', '1999-12-28 03:00', '1999-12-28 03:30']
    'date-us-time':
        '1st': new Date(1999, 11, 31, 23, 59, 45)
        'values': ['12/31/1999 23:59:45', '12/31/1999 23:59:50', '12/31/1999 23:59:55', '01/01/2000 00:00:00', '01/01/2000 00:00:05', '01/01/2000 00:00:10', '01/01/2000 00:00:15', '01/01/2000 00:00:20']
    'english month names':
        '1st': new Date(2010, 11, 1)
        'values': ['2010 December', '2011 January', '2011 February', '2011 March', '2011 April']

batch = {}
for k of formats
    batch[k] =
        'topic': formats[k]
        'type is date': (topic) ->
            assert.equal dw.column('', topic.values).type(), 'date'
        'parsed correctly': (topic) ->
            assert.deepEqual dw.column('', topic.values).val(0), topic['1st']

vows
    .describe('Some tests for different number formats')
    .addBatch(batch)
    .export module
