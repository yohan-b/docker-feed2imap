#!/bin/bash
# stop service and clean up here
function shut_down() {
reset
echo "exited $0"
exit 0
}

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap "shut_down" SIGINT SIGTERM SIGKILL

echo "Launching feed2imap..."
/usr/bin/feed2imap -f /root/feed2imaprc
last=$(date +%s)

while true
do
        sleep 3
	#echo $last
	# if date '+%s'` - $last > 1800 (seconds) ==> feed2imap and $last = date '+%s'`
	if [ $(($(date +%s) - $last)) -gt 1800 ]
	then
		echo "Launching feed2imap..."
		/usr/bin/feed2imap -f /root/feed2imaprc
		last=$(date +%s)
	fi
done
shut_down

