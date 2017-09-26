cronJob = require('cron').CronJob

envelope = room: "#mining"

module.exports = (robot) ->
  robot.respond /zec (.*)/i, (msg) ->
    zec(robot, parseFloat(msg.match[1]))
  robot.respond /btc (.*)/i, (msg) ->
    btc(robot, parseFloat(msg.match[1]))
  robot.respond /eth (.*)/i, (msg) ->
    eth(robot, parseFloat(msg.match[1]))

zec = (robot, amount) ->
  http = robot.http('https://coincheck.com/api/rate/zec_btc').get()
  http (err, res, body) ->
    json = JSON.parse body
    robot.send envelope, parseFloat(json['rate']) * amount  + 'btc'
  http = robot.http('https://coincheck.com/api/rate/zec_jpy').get()
  http (err, res, body) ->
    json = JSON.parse body
    robot.send envelope, parseFloat(json['rate']) * amount  + '円'

eth = (robot, amount) ->
  http = robot.http('https://coincheck.com/api/rate/eth_btc').get()
  http (err, res, body) ->
    json = JSON.parse body
    robot.send envelope, parseFloat(json['rate']) * amount  + 'btc'
  http = robot.http('https://coincheck.com/api/rate/eth_jpy').get()
  http (err, res, body) ->
    json = JSON.parse body
    robot.send envelope, parseFloat(json['rate']) * amount  + '円'

btc = (robot, amount) ->
  http = robot.http('https://coincheck.com/api/rate/btc_jpy').get()
  http (err, res, body) ->
    json = JSON.parse body
    robot.send envelope, parseFloat(json['rate']) * amount  + '円'
