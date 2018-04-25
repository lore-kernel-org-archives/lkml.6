Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755664AbeDYQDh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755563AbeDYQA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:00:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B86F217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Martin Vuille <jpmv27@aim.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/12] perf test: Adapt test case record+probe_libc_inet_pton.sh for s390
Date: Wed, 25 Apr 2018 12:59:59 -0300
Message-Id: <20180425160008.3407-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180425160008.3407-1-acme@kernel.org>
References: <20180425160008.3407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

perf test case 58 (record+probe_libc_inet_pton.sh) executed on s390x
using kernel 4.16.0rc3 displays this result:

 # perf trace --no-syscalls -e probe_libc:inet_pton/call-graph=dwarf/ ping -6 -c 1 ::1
     probe_libc:inet_pton: (3ffa0240448)
	      __GI___inet_pton (/usr/lib64/libc-2.26.so)
	      gaih_inet (inlined)
	      __GI_getaddrinfo (inlined)
	      main (/usr/bin/ping)
	      __libc_start_main (/usr/lib64/libc-2.26.so)
	     _start (/usr/bin/ping)

After I installed kernel 4.16.0 the same tests uses commands:

 # perf record -e probe_libc:inet_pton/call-graph=dwarf/
      -o /tmp/perf.data.abc ping -6 -c 1 ::1
 # perf script -i /tmp/perf.data.abc

and displays:

 ping 39048 [006] 84230.381198: probe_libc:inet_pton: (3ffa0240448)
	       140448 __GI___inet_pton (/usr/lib64/libc-2.26.so)
	       fbde1 gaih_inet (inlined)
	       fe2b9 __GI_getaddrinfo (inlined)
	        398d main (/usr/bin/ping)

Nothing else changed including glibc elfutils and other libraries picked
up by the build.

The entries for __libc_start_main and _start are missing.

I bisected missing __libc_start_main and _start to commit

Fixes: 3d20c6246690 ("perf unwind: Unwind with libdw doesn't take symfs into account")

When I undo this commit I get this call stack on s390:
 [root@s35lp76 perf]# ./perf script  -i /tmp/perf.data.abc
 ping 39048 [006] 84230.381198: probe_libc:inet_pton: (3ffa0240448)
	140448 __GI___inet_pton (/usr/lib64/libc-2.26.so)
	 fbde1 gaih_inet (inlined)
	 fe2b9 __GI_getaddrinfo (inlined)
	  398d main (/usr/bin/ping)
	 22fbd __libc_start_main (/usr/lib64/libc-2.26.so)
	  457b _start (/usr/bin/ping)

Looks like dwarf functions dwfl_xxx create different call back stack
trace when using file /usr/lib/debug/usr/bin/ping-20161105-7.fc27.s390x.debug
instead of file /usr/bin/ping.

Fix this test case on s390 and do not expect any call back stack entry
after the main() function. Also be more robust and accept a leading
__GI_ prefix in front of getaddrinfo.

On x86 this test case shows the same call stack using both kernel
versions 4.16.0rc3 and 4.16.0 and also stops at main:

  [root@f27 perf]# ./perf script -i /tmp/perf.data.tmr
  ping  4446 [000]   172.027088: probe_libc:inet_pton: (7fdfa08c93c0)
	             1393c0 __GI___inet_pton (/usr/lib64/libc-2.26.so)
	              fe60d getaddrinfo (/usr/lib64/libc-2.26.so)
	               2f40 main (/usr/bin/ping)
  [root@f27 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Martin Vuille <jpmv27@aim.com>
Link: http://lkml.kernel.org/r/20180423082428.7930-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
