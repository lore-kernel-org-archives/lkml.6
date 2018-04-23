Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754617AbeDWIYo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:24:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754256AbeDWIYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:24:39 -0400
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf test: Adapt test case record+probe_libc_inet_pton.sh for s390
Date: Mon, 23 Apr 2018 10:24:28 +0200
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18042308-0040-0000-0000-000004506CC8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042308-0041-0000-0000-000020F4D25C
Message-Id: <20180423082428.7930-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230092
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf test case 58 (record+probe_libc_inet_pton.sh)
executed on s390x using kernel 4.16.0rc3
displays this result:
 # ./perf trace --no-syscalls
           -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
     probe_libc:inet_pton: (3ffa0240448)
	      __GI___inet_pton (/usr/lib64/libc-2.26.so)
	      gaih_inet (inlined)
	      __GI_getaddrinfo (inlined)
	      main (/usr/bin/ping)
	      __libc_start_main (/usr/lib64/libc-2.26.so)
	     _start (/usr/bin/ping)

After I installed kernel 4.16.0 the same tests uses
commands
 # perf record -e probe_libc:inet_pton/call-graph=dwarf/
      -o /tmp/perf.data.abc ping -6 -c 1 ::1
 # perf script -i /tmp/perf.data.abc
and displays:
 ping 39048 [006] 84230.381198: probe_libc:inet_pton: (3ffa0240448)
	       140448 __GI___inet_pton (/usr/lib64/libc-2.26.so)
	       fbde1 gaih_inet (inlined)
	       fe2b9 __GI_getaddrinfo (inlined)
	        398d main (/usr/bin/ping)

Nothing else changed including glibc elfutils and other libraries
picked up by the build.
The entries for __libc_start_main and _start are missing.

I bisected missing __libc_start_main and _start to commit
3d20c6246690219881786de10d2dda93f616d0ac
("perf unwind: Unwind with libdw doesn't take symfs into account")

When I undo this commit I get this call stack on s390:
 [root@s35lp76 perf]# ./perf script  -i /tmp/perf.data.abc
 ping 39048 [006] 84230.381198: probe_libc:inet_pton: (3ffa0240448)
	140448 __GI___inet_pton (/usr/lib64/libc-2.26.so)
	 fbde1 gaih_inet (inlined)
	 fe2b9 __GI_getaddrinfo (inlined)
	  398d main (/usr/bin/ping)
	 22fbd __libc_start_main (/usr/lib64/libc-2.26.so)
	  457b _start (/usr/bin/ping)

Looks like dwarf functions dwfl_xxx  create different call back
stack trace when using file
/usr/lib/debug/usr/bin/ping-20161105-7.fc27.s390x.debug instead of
file /usr/bin/ping.

Fix this test case on s390 and do not expect any call back stack
entry after the main() function. Also be more robust and accept a
leading __GI_ prefix in front of getaddrinfo.

On x86 this test case shows the same call stack using
both kernel versions 4.16.0rc3 and 4.16.0 and also
stops at main:

[root@f27 perf]# ./perf script -i /tmp/perf.data.tmr
ping  4446 [000]   172.027088: probe_libc:inet_pton: (7fdfa08c93c0)
	           1393c0 __GI___inet_pton (/usr/lib64/libc-2.26.so)
	            fe60d getaddrinfo (/usr/lib64/libc-2.26.so)
	             2f40 main (/usr/bin/ping)

[root@f27 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 1ecc1f0ff84a..016882dbbc16 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -19,12 +19,10 @@ trace_libc_inet_pton_backtrace() {
 	expected[1]=".*inet_pton[[:space:]]\($libc\)$"
 	case "$(uname -m)" in
 	s390x)
-		eventattr='call-graph=dwarf'
+		eventattr='call-graph=dwarf,max-stack=4'
 		expected[2]="gaih_inet.*[[:space:]]\($libc|inlined\)$"
-		expected[3]="__GI_getaddrinfo[[:space:]]\($libc|inlined\)$"
+		expected[3]="(__GI_)?getaddrinfo[[:space:]]\($libc|inlined\)$"
 		expected[4]="main[[:space:]]\(.*/bin/ping.*\)$"
-		expected[5]="__libc_start_main[[:space:]]\($libc\)$"
-		expected[6]="_start[[:space:]]\(.*/bin/ping.*\)$"
 		;;
 	*)
 		eventattr='max-stack=3'
-- 
2.14.3
