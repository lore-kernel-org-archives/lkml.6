Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeESLps (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:45:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38809 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeESLpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:45:46 -0400
Date: Sat, 19 May 2018 04:45:37 -0700
From: tip-bot for Sandipan Das <tipbot@zytor.com>
Message-ID: <tip-7903a70867230d9edbd5e886cd8b8a2b248f418f@git.kernel.org>
Cc: hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, mingo@kernel.org,
        ravi.bangoria@linux.ibm.com, tglx@linutronix.de, jolsa@redhat.com,
        sandipan@linux.vnet.ibm.com
Reply-To: mingo@kernel.org, sandipan@linux.vnet.ibm.com, jolsa@redhat.com,
        tglx@linutronix.de, ravi.bangoria@linux.ibm.com, acme@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        naveen.n.rao@linux.vnet.ibm.com
In-Reply-To: <20180517063326.6319-2-sandipan@linux.vnet.ibm.com>
References: <20180517063326.6319-2-sandipan@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script: Show symbol offsets by default
Git-Commit-ID: 7903a70867230d9edbd5e886cd8b8a2b248f418f
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

Commit-ID:  7903a70867230d9edbd5e886cd8b8a2b248f418f
Gitweb:     https://git.kernel.org/tip/7903a70867230d9edbd5e886cd8b8a2b248f418f
Author:     Sandipan Das <sandipan@linux.vnet.ibm.com>
AuthorDate: Thu, 17 May 2018 12:03:26 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 18 May 2018 16:31:40 -0300

perf script: Show symbol offsets by default

Since the ip shown for a symbol is now always a virtual address, it
becomes difficult to correlate this with objdump output and determine
the exact instruction address. So, we always show the offset from the
start of the symbol.

This can be verified on a powerpc64le system running Fedora 27 as
follows:

  # perf probe -a sys_write
  # perf record -e probe:sys_write -g ~/test

Before applying this patch:

  # perf script

  test  9710 [013] 95614.332431: probe:sys_write: (c0000000004025b0)
          c0000000004025b0 sys_write (/lib/modules/4.17.0-rc4+/build/vmlinux)
          c00000000000b9e0 system_call (/lib/modules/4.17.0-rc4+/build/vmlinux)
              7fffb70d8234 __GI___libc_write (/usr/lib64/libc-2.26.so)
              7fffb7052c74 _IO_file_write@@GLIBC_2.17 (/usr/lib64/libc-2.26.so)
                  5afc1818 [unknown] ([unknown])
              7fffb7051a60 new_do_write (/usr/lib64/libc-2.26.so)
              7fffb7054638 _IO_do_write@@GLIBC_2.17 (/usr/lib64/libc-2.26.so)
              7fffb7054bbc _IO_file_overflow@@GLIBC_2.17 (/usr/lib64/libc-2.26.so)
              7fffb7055a24 __overflow (/usr/lib64/libc-2.26.so)
              7fffb7044548 _IO_puts (/usr/lib64/libc-2.26.so)
                  10000440 main (/home/sandipan/test)
              7fffb6fe36a0 generic_start_main.isra.0 (/usr/lib64/libc-2.26.so)
              7fffb6fe3898 __libc_start_main (/usr/lib64/libc-2.26.so)
                         0 [unknown] ([unknown])
  ...

After applying this patch:

  # perf script

  test  9710 [013] 95614.332431: probe:sys_write: (c0000000004025b0)
          c0000000004025b0 sys_write+0x10 (/lib/modules/4.17.0-rc4+/build/vmlinux)
          c00000000000b9e0 system_call+0x58 (/lib/modules/4.17.0-rc4+/build/vmlinux)
              7fffb70d8234 __GI___libc_write+0x24 (/usr/lib64/libc-2.26.so)
              7fffb7052c74 _IO_file_write@@GLIBC_2.17+0x44 (/usr/lib64/libc-2.26.so)
                  5afc1818 [unknown] ([unknown])
              7fffb7051a60 new_do_write+0x90 (/usr/lib64/libc-2.26.so)
              7fffb7054638 _IO_do_write@@GLIBC_2.17+0x38 (/usr/lib64/libc-2.26.so)
              7fffb7054bbc _IO_file_overflow@@GLIBC_2.17+0x14c (/usr/lib64/libc-2.26.so)
              7fffb7055a24 __overflow+0x64 (/usr/lib64/libc-2.26.so)
              7fffb7044548 _IO_puts+0x218 (/usr/lib64/libc-2.26.so)
                  10000440 main+0x20 (/home/sandipan/test)
              7fffb6fe36a0 generic_start_main.isra.0+0x140 (/usr/lib64/libc-2.26.so)
              7fffb6fe3898 __libc_start_main+0xb8 (/usr/lib64/libc-2.26.so)
                         0 [unknown] ([unknown])
  ...

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lkml.kernel.org/r/20180517063326.6319-2-sandipan@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c                        | 26 ++++++++++++----------
 .../tests/shell/record+probe_libc_inet_pton.sh     | 12 +++++-----
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index fa2c7a288750..cefc8813e91e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -153,8 +153,8 @@ static struct {
 		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
 			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
 			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
-			      PERF_OUTPUT_SYM | PERF_OUTPUT_DSO |
-			      PERF_OUTPUT_PERIOD,
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -165,8 +165,9 @@ static struct {
 		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
 			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
 			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
-			      PERF_OUTPUT_SYM | PERF_OUTPUT_DSO |
-			      PERF_OUTPUT_PERIOD | PERF_OUTPUT_BPF_OUTPUT,
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD |
+			      PERF_OUTPUT_BPF_OUTPUT,
 
 		.invalid_fields = PERF_OUTPUT_TRACE,
 	},
@@ -185,10 +186,10 @@ static struct {
 		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
 			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
 			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
-			      PERF_OUTPUT_SYM | PERF_OUTPUT_DSO |
-			      PERF_OUTPUT_PERIOD |  PERF_OUTPUT_ADDR |
-			      PERF_OUTPUT_DATA_SRC | PERF_OUTPUT_WEIGHT |
-			      PERF_OUTPUT_PHYS_ADDR,
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD |
+			      PERF_OUTPUT_ADDR | PERF_OUTPUT_DATA_SRC |
+			      PERF_OUTPUT_WEIGHT | PERF_OUTPUT_PHYS_ADDR,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -199,8 +200,8 @@ static struct {
 		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
 			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
 			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
-			      PERF_OUTPUT_SYM | PERF_OUTPUT_DSO |
-			      PERF_OUTPUT_PERIOD,
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -211,8 +212,8 @@ static struct {
 		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
 			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
 			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
-			      PERF_OUTPUT_SYM | PERF_OUTPUT_DSO |
-			      PERF_OUTPUT_SYNTH,
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_SYNTH,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -544,6 +545,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 			if (attr->sample_type & PERF_SAMPLE_CALLCHAIN) {
 				output[j].fields |= PERF_OUTPUT_IP;
 				output[j].fields |= PERF_OUTPUT_SYM;
+				output[j].fields |= PERF_OUTPUT_SYMOFFSET;
 				output[j].fields |= PERF_OUTPUT_DSO;
 				set_print_ip_opts(attr);
 				goto out;
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index ee86473643be..650b208f700f 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -16,18 +16,18 @@ nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
 trace_libc_inet_pton_backtrace() {
 	idx=0
 	expected[0]="ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)"
-	expected[1]=".*inet_pton[[:space:]]\($libc|inlined\)$"
+	expected[1]=".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf,max-stack=4'
-		expected[2]="gaih_inet.*[[:space:]]\($libc|inlined\)$"
-		expected[3]="(__GI_)?getaddrinfo[[:space:]]\($libc|inlined\)$"
-		expected[4]="main[[:space:]]\(.*/bin/ping.*\)$"
+		expected[2]="gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
+		expected[3]="(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$"
+		expected[4]="main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
 		;;
 	*)
 		eventattr='max-stack=3'
-		expected[2]="getaddrinfo[[:space:]]\($libc\)$"
-		expected[3]=".*\(.*/bin/ping.*\)$"
+		expected[2]="getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$"
+		expected[3]=".*\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
 		;;
 	esac
 
