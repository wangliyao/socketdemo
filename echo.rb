require 'em-websocket'
require 'rails'

connection = EM::Channel.new
EM::WebSocket.start(:host => 'localhost', :port => 3000) do |ws|
  ws.onopen do
    connection << ws
    puts connection
    connection.subscribe{|message| ws.send(message) }
  end

  ws.onmessage do |message|
    puts message
    connection.push(message)
  end
end
