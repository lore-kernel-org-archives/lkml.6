Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932128AbeCEOhP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751989AbeCEOab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:30:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0C921486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/28] perf tests: Switch trace+probe_libc_inet_pton to use record
Date: Mon,  5 Mar 2018 11:29:11 -0300
Message-Id: <20180305142932.16921-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's a problem with relying on backtrace data from 'perf trace' the
way the trace+probe_libc_inet_pton does. This test inserts uprobe within
ping binary and checks that it gets its sample using 'perf trace'.

It also checks it gets proper backtrace from sample and that's where the
issue is.

The 'perf trace' does not sort events (by definition) so it can happen
that it processes the event sample before the ping binary memory map
event. This can (very rarely) happen as proved by this events dump
output (from custom added debug output):

  ...
  7680/7680: [0x7f4e29718000(0x204000) @ 0 fd:00 33611321 4230892504]: r-xp /usr/lib64/libdl-2.17.so
  7680/7680: [0x7f4e29502000(0x216000) @ 0 fd:00 33617257 2606846872]: r-xp /usr/lib64/libz.so.1.2.7
  (IP, 0x2): 7680/7680: 0x7f4e29c2ed60 period: 1 addr: 0
  7680/7680: [0x564842ef0000(0x233000) @ 0 fd:00 83 1989280200]: r-xp /usr/bin/ping
  7680/7680: [0x7f4e2aca2000(0x224000) @ 0 fd:00 33611308 1219144940]: r-xp /usr/lib64/ld-2.17.so
  ...

In this case 'perf trace' fails to resolve the last callchain IP (within
the ping binary) because it does not know about the ping binary memory
map yet and the test fails like this:

  PING ::1(::1) 56 data bytes
  64 bytes from ::1: icmp_seq=1 ttl=64 time=0.037 ms
  --- ::1 ping statistics ---
  1 packets transmitted, 1 received, 0% packet loss, time 0ms
  rtt min/avg/max/mdev = 0.037/0.037/0.037/0.000 ms
  0.000 probe_libc:inet_pton:(7f4e29c2ed60))
  __GI___inet_pton (/usr/lib64/libc-2.17.so)
  getaddrinfo (/usr/lib64/libc-2.17.so)
  [0] ([unknown])
  FAIL: expected backtrace entry 8 ".*\(.*/bin/ping.*\)$" got "[0] ([unknown])"

Switching the test to use 'perf record' and 'perf script' instead of
'perf trace'.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180301165215.6780-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh | 30 +++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
index 8c4ab0b390c0..52c3ee701a89 100755
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -15,30 +15,28 @@ nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 
 trace_libc_inet_pton_backtrace() {
 	idx=0
-	expected[0]="PING.*bytes"
-	expected[1]="64 bytes from ::1.*"
-	expected[2]=".*ping statistics.*"
-	expected[3]=".*packets transmitted.*"
-	expected[4]="rtt min.*"
-	expected[5]="[0-9]+\.[0-9]+[[:space:]]+probe_libc:inet_pton:\([[:xdigit:]]+\)"
-	expected[6]=".*inet_pton[[:space:]]\($libc|inlined\)$"
+	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
+	expected[1]=".*inet_pton[[:space:]]\($libc\)$"
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf'
-		expected[7]="gaih_inet.*[[:space:]]\($libc|inlined\)$"
-		expected[8]="__GI_getaddrinfo[[:space:]]\($libc|inlined\)$"
-		expected[9]="main[[:space:]]\(.*/bin/ping.*\)$"
-		expected[10]="__libc_start_main[[:space:]]\($libc\)$"
-		expected[11]="_start[[:space:]]\(.*/bin/ping.*\)$"
+		expected[2]="gaih_inet.*[[:space:]]\($libc|inlined\)$"
+		expected[3]="__GI_getaddrinfo[[:space:]]\($libc|inlined\)$"
+		expected[4]="main[[:space:]]\(.*/bin/ping.*\)$"
+		expected[5]="__libc_start_main[[:space:]]\($libc\)$"
+		expected[6]="_start[[:space:]]\(.*/bin/ping.*\)$"
 		;;
 	*)
 		eventattr='max-stack=3'
-		expected[7]="getaddrinfo[[:space:]]\($libc\)$"
-		expected[8]=".*\(.*/bin/ping.*\)$"
+		expected[2]="getaddrinfo[[:space:]]\($libc\)$"
+		expected[3]=".*\(.*/bin/ping.*\)$"
 		;;
 	esac
 
-	perf trace --no-syscalls -e probe_libc:inet_pton/$eventattr/ ping -6 -c 1 ::1 2>&1 | grep -v ^$ | while read line ; do
+	file=`mktemp -u /tmp/perf.data.XXX`
+
+	perf record -e probe_libc:inet_pton/$eventattr/ -o $file ping -6 -c 1 ::1 > /dev/null 2>&1
+	perf script -i $file | while read line ; do
 		echo $line
 		echo "$line" | egrep -q "${expected[$idx]}"
 		if [ $? -ne 0 ] ; then
@@ -48,6 +46,8 @@ trace_libc_inet_pton_backtrace() {
 		let idx+=1
 		[ -z "${expected[$idx]}" ] && break
 	done
+
+	rm -f $file
 }
 
 # Check for IPv6 interface existence
-- 
2.14.3
