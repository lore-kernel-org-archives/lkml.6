Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033320AbeCAQwb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:52:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033105AbeCAQwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:52:22 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 2/2] perf tests: Rename trace+probe_libc_inet_pton to record+probe_libc_inet_pton
Date: Thu,  1 Mar 2018 17:52:15 +0100
Message-Id: <20180301165215.6780-2-jolsa@kernel.org>
In-Reply-To: <20180301165215.6780-1-jolsa@kernel.org>
References: <20180301165215.6780-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the test is no longer using perf trace but perf record instead.

Link: http://lkml.kernel.org/n/tip-7wcnqqxmepd0e7qfp7bo8ur1@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../tests/shell/record+probe_libc_inet_pton.sh     | 62 ++++++++++++++++++++++
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh | 62 ----------------------
 2 files changed, 62 insertions(+), 62 deletions(-)
 create mode 100755 tools/perf/tests/shell/record+probe_libc_inet_pton.sh
 delete mode 100755 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
new file mode 100755
index 000000000000..52c3ee701a89
--- /dev/null
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -0,0 +1,62 @@
+# probe libc's inet_pton & backtrace it with ping
+
+# Installs a probe on libc's inet_pton function, that will use uprobes,
+# then use 'perf trace' on a ping to localhost asking for just one packet
+# with the a backtrace 3 levels deep, check that it is what we expect.
+# This needs no debuginfo package, all is done using the libc ELF symtab
+# and the CFI info in the binaries.
+
+# Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
+
+. $(dirname $0)/lib/probe.sh
+
+libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1/g')
+nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
+
+trace_libc_inet_pton_backtrace() {
+	idx=0
+	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
+	expected[1]=".*inet_pton[[:space:]]\($libc\)$"
+	case "$(uname -m)" in
+	s390x)
+		eventattr='call-graph=dwarf'
+		expected[2]="gaih_inet.*[[:space:]]\($libc|inlined\)$"
+		expected[3]="__GI_getaddrinfo[[:space:]]\($libc|inlined\)$"
+		expected[4]="main[[:space:]]\(.*/bin/ping.*\)$"
+		expected[5]="__libc_start_main[[:space:]]\($libc\)$"
+		expected[6]="_start[[:space:]]\(.*/bin/ping.*\)$"
+		;;
+	*)
+		eventattr='max-stack=3'
+		expected[2]="getaddrinfo[[:space:]]\($libc\)$"
+		expected[3]=".*\(.*/bin/ping.*\)$"
+		;;
+	esac
+
+	file=`mktemp -u /tmp/perf.data.XXX`
+
+	perf record -e probe_libc:inet_pton/$eventattr/ -o $file ping -6 -c 1 ::1 > /dev/null 2>&1
+	perf script -i $file | while read line ; do
+		echo $line
+		echo "$line" | egrep -q "${expected[$idx]}"
+		if [ $? -ne 0 ] ; then
+			printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "${expected[$idx]}" "$line"
+			exit 1
+		fi
+		let idx+=1
+		[ -z "${expected[$idx]}" ] && break
+	done
+
+	rm -f $file
+}
+
+# Check for IPv6 interface existence
+ip a sh lo | fgrep -q inet6 || exit 2
+
+skip_if_no_perf_probe && \
+perf probe -q $libc inet_pton && \
+trace_libc_inet_pton_backtrace
+err=$?
+rm -f ${file}
+perf probe -q -d probe_libc:inet_pton
+exit $err
diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
deleted file mode 100755
index 52c3ee701a89..000000000000
--- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
+++ /dev/null
@@ -1,62 +0,0 @@
-# probe libc's inet_pton & backtrace it with ping
-
-# Installs a probe on libc's inet_pton function, that will use uprobes,
-# then use 'perf trace' on a ping to localhost asking for just one packet
-# with the a backtrace 3 levels deep, check that it is what we expect.
-# This needs no debuginfo package, all is done using the libc ELF symtab
-# and the CFI info in the binaries.
-
-# Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
-
-. $(dirname $0)/lib/probe.sh
-
-libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1/g')
-nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
-
-trace_libc_inet_pton_backtrace() {
-	idx=0
-	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
-	expected[1]=".*inet_pton[[:space:]]\($libc\)$"
-	case "$(uname -m)" in
-	s390x)
-		eventattr='call-graph=dwarf'
-		expected[2]="gaih_inet.*[[:space:]]\($libc|inlined\)$"
-		expected[3]="__GI_getaddrinfo[[:space:]]\($libc|inlined\)$"
-		expected[4]="main[[:space:]]\(.*/bin/ping.*\)$"
-		expected[5]="__libc_start_main[[:space:]]\($libc\)$"
-		expected[6]="_start[[:space:]]\(.*/bin/ping.*\)$"
-		;;
-	*)
-		eventattr='max-stack=3'
-		expected[2]="getaddrinfo[[:space:]]\($libc\)$"
-		expected[3]=".*\(.*/bin/ping.*\)$"
-		;;
-	esac
-
-	file=`mktemp -u /tmp/perf.data.XXX`
-
-	perf record -e probe_libc:inet_pton/$eventattr/ -o $file ping -6 -c 1 ::1 > /dev/null 2>&1
-	perf script -i $file | while read line ; do
-		echo $line
-		echo "$line" | egrep -q "${expected[$idx]}"
-		if [ $? -ne 0 ] ; then
-			printf "FAIL: expected backtrace entry %d \"%s\" got \"%s\"\n" $idx "${expected[$idx]}" "$line"
-			exit 1
-		fi
-		let idx+=1
-		[ -z "${expected[$idx]}" ] && break
-	done
-
-	rm -f $file
-}
-
-# Check for IPv6 interface existence
-ip a sh lo | fgrep -q inet6 || exit 2
-
-skip_if_no_perf_probe && \
-perf probe -q $libc inet_pton && \
-trace_libc_inet_pton_backtrace
-err=$?
-rm -f ${file}
-perf probe -q -d probe_libc:inet_pton
-exit $err
-- 
2.13.6
