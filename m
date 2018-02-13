Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935067AbeBMMM5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:12:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46983 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935049AbeBMMMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:12:53 -0500
Date: Tue, 13 Feb 2018 04:12:41 -0800
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-52a37001d51a320c1019269fb3ba473a1363650d@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
        acme@redhat.com, heiko.carstens@de.ibm.com, tglx@linutronix.de,
        schwidefsky@de.ibm.com
Reply-To: acme@redhat.com, tmricht@linux.vnet.ibm.com,
        brueckner@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, schwidefsky@de.ibm.com,
        tglx@linutronix.de, heiko.carstens@de.ibm.com
In-Reply-To: <20180117083831.101001-1-tmricht@linux.vnet.ibm.com>
References: <20180117083831.101001-1-tmricht@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test: Fix test trace+probe_libc_inet_pton.sh
 for s390x
Git-Commit-ID: 52a37001d51a320c1019269fb3ba473a1363650d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  52a37001d51a320c1019269fb3ba473a1363650d
Gitweb:     https://git.kernel.org/tip/52a37001d51a320c1019269fb3ba473a1363650d
Author:     Thomas Richter <tmricht@linux.vnet.ibm.com>
AuthorDate: Wed, 17 Jan 2018 09:38:31 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Feb 2018 10:46:58 -0300

perf test: Fix test trace+probe_libc_inet_pton.sh for s390x

On Intel test case trace+probe_libc_inet_pton.sh succeeds and the
output is:

[root@f27 perf]# ./perf trace --no-syscalls
                  -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.037 ms

 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.037/0.037/0.037/0.000 ms
     0.000 probe_libc:inet_pton:(7fa40ac618a0))
              __GI___inet_pton (/usr/lib64/libc-2.26.so)
              getaddrinfo (/usr/lib64/libc-2.26.so)
              main (/usr/bin/ping)

The kernel stack unwinder is used, it is specified implicitly
as call-graph=fp (frame pointer).

On s390x only dwarf is available for stack unwinding. It is also
done in user space. This requires different parameter setup
and result checking for s390x and Intel.

This patch adds separate perf trace setup and result checking
for Intel and s390x. On s390x specify this command line to
get a call-graph and handle the different call graph result
checking:

[root@s35lp76 perf]# ./perf trace --no-syscalls
	-e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.041 ms

 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.041/0.041/0.041/0.000 ms
     0.000 probe_libc:inet_pton:(3ffb9942060))
            __GI___inet_pton (/usr/lib64/libc-2.26.so)
            gaih_inet (inlined)
            __GI_getaddrinfo (inlined)
            main (/usr/bin/ping)
            __libc_start_main (/usr/lib64/libc-2.26.so)
            _start (/usr/bin/ping)
[root@s35lp76 perf]#

Before:
[root@s8360047 perf]# ./perf test -vv 58
58: probe libc's inet_pton & backtrace it with ping       :
 --- start ---
test child forked, pid 26349
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.079 ms
 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.079/0.079/0.079/0.000 ms
0.000 probe_libc:inet_pton:(3ff925c2060))
test child finished with -1
 ---- end ----
probe libc's inet_pton & backtrace it with ping: FAILED!
[root@s8360047 perf]#

After:
[root@s35lp76 perf]# ./perf test -vv 57
57: probe libc's inet_pton & backtrace it with ping       :
 --- start ---
test child forked, pid 38708
PING ::1(::1) 56 data bytes
64 bytes from ::1: icmp_seq=1 ttl=64 time=0.038 ms
 --- ::1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.038/0.038/0.038/0.000 ms
0.000 probe_libc:inet_pton:(3ff87342060))
__GI___inet_pton (/usr/lib64/libc-2.26.so)
gaih_inet (inlined)
__GI_getaddrinfo (inlined)
main (/usr/bin/ping)
__libc_start_main (/usr/lib64/libc-2.26.so)
_start (/usr/bin/ping)
test child finished with 0
 ---- end ----
probe libc's inet_pton & backtrace it with ping: Ok
[root@s35lp76 perf]#

On Intel the test case runs unchanged and succeeds.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180117083831.101001-1-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh | 23 +++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
index 8b3da21..c446c89 100755
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
@@ -22,10 +22,23 @@ trace_libc_inet_pton_backtrace() {
 	expected[4]="rtt min.*"
 	expected[5]="[0-9]+\.[0-9]+[[:space:]]+probe_libc:inet_pton:\([[:xdigit:]]+\)"
 	expected[6]=".*inet_pton[[:space:]]\($libc\)$"
-	expected[7]="getaddrinfo[[:space:]]\($libc\)$"
-	expected[8]=".*\(.*/bin/ping.*\)$"
-
-	perf trace --no-syscalls -e probe_libc:inet_pton/max-stack=3/ ping -6 -c 1 ::1 2>&1 | grep -v ^$ | while read line ; do
+	case "$(uname -m)" in
+	s390x)
+		eventattr='call-graph=dwarf'
+		expected[7]="gaih_inet[[:space:]]\(inlined\)$"
+		expected[8]="__GI_getaddrinfo[[:space:]]\(inlined\)$"
+		expected[9]="main[[:space:]]\(.*/bin/ping.*\)$"
+		expected[10]="__libc_start_main[[:space:]]\($libc\)$"
+		expected[11]="_start[[:space:]]\(.*/bin/ping.*\)$"
+		;;
+	*)
+		eventattr='max-stack=3'
+		expected[7]="getaddrinfo[[:space:]]\($libc\)$"
+		expected[8]=".*\(.*/bin/ping.*\)$"
+		;;
+	esac
+
+	perf trace --no-syscalls -e probe_libc:inet_pton/$eventattr/ ping -6 -c 1 ::1 2>&1 | grep -v ^$ | while read line ; do
 		echo $line
 		echo "$line" | egrep -q "${expected[$idx]}"
 		if [ $? -ne 0 ] ; then
@@ -33,7 +46,7 @@ trace_libc_inet_pton_backtrace() {
 			exit 1
 		fi
 		let idx+=1
-		[ $idx -eq 9 ] && break
+		[ -z "${expected[$idx]}" ] && break
 	done
 }
 
