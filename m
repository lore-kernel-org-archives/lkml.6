Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbeDUHsU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:48:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45451 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbeDUHsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:48:16 -0400
Date: Sat, 21 Apr 2018 00:47:54 -0700
From: tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-bf30cc1882d2c65aaf92842cc9bcf06565eab73c@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, alexey.budankov@linux.intel.com,
        namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, acme@redhat.com,
        jolsa@redhat.com, ak@linux.intel.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com,
        ak@linux.intel.com, mingo@kernel.org, acme@redhat.com,
        alexey.budankov@linux.intel.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <5fc65ce7-8ca5-53ae-8858-8ddd27290575@linux.intel.com>
References: <5fc65ce7-8ca5-53ae-8858-8ddd27290575@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Extend misc field decoding with
 switch out event type
Git-Commit-ID: bf30cc1882d2c65aaf92842cc9bcf06565eab73c
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

Commit-ID:  bf30cc1882d2c65aaf92842cc9bcf06565eab73c
Gitweb:     https://git.kernel.org/tip/bf30cc1882d2c65aaf92842cc9bcf06565eab73c
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Mon, 9 Apr 2018 10:26:46 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 17 Apr 2018 09:47:39 -0300

perf script: Extend misc field decoding with switch out event type

Append 'p' sign to 'S' tag designating the type of context switch out event so
'Sp' means preemption context switch. Documentation is extended to cover
new presentation changes.

  $ perf script --show-switch-events -F +misc -I -i perf.data:

          hdparm 4073 [004] U  762.198265:     380194 cycles:ppp:      7faf727f5a23 strchr (/usr/lib64/ld-2.26.so)
          hdparm 4073 [004] K  762.198366:     441572 cycles:ppp:  ffffffffb9218435 alloc_set_pte (/lib/modules/4.16.0-rc6+/build/vmlinux)
          hdparm 4073 [004] S  762.198391: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:    0/0
         swapper    0 [004]    762.198392: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid: 4073/4073
         swapper    0 [004] Sp 762.198477: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid: 4073/4073
          hdparm 4073 [004]    762.198478: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:    0/0
         swapper    0 [007] K  762.198514:    2303073 cycles:ppp:  ffffffffb98b0c66 intel_idle (/lib/modules/4.16.0-rc6+/build/vmlinux)
         swapper    0 [007] Sp 762.198561: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid: 1134/1134
  kworker/u16:18 1134 [007]    762.198562: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:    0/0
  kworker/u16:18 1134 [007] S  762.198567: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:    0/0

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/5fc65ce7-8ca5-53ae-8858-8ddd27290575@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 17 +++++++++--------
 tools/perf/builtin-script.c              |  5 ++++-
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 36ec0257f8d3..afdafe2110a1 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -228,14 +228,15 @@ OPTIONS
 	For sample events it's possible to display misc field with -F +misc option,
 	following letters are displayed for each bit:
 
-	  PERF_RECORD_MISC_KERNEL        K
-	  PERF_RECORD_MISC_USER          U
-	  PERF_RECORD_MISC_HYPERVISOR    H
-	  PERF_RECORD_MISC_GUEST_KERNEL  G
-	  PERF_RECORD_MISC_GUEST_USER    g
-	  PERF_RECORD_MISC_MMAP_DATA*    M
-	  PERF_RECORD_MISC_COMM_EXEC     E
-	  PERF_RECORD_MISC_SWITCH_OUT    S
+	  PERF_RECORD_MISC_KERNEL               K
+	  PERF_RECORD_MISC_USER                 U
+	  PERF_RECORD_MISC_HYPERVISOR           H
+	  PERF_RECORD_MISC_GUEST_KERNEL         G
+	  PERF_RECORD_MISC_GUEST_USER           g
+	  PERF_RECORD_MISC_MMAP_DATA*           M
+	  PERF_RECORD_MISC_COMM_EXEC            E
+	  PERF_RECORD_MISC_SWITCH_OUT           S
+	  PERF_RECORD_MISC_SWITCH_OUT_PREEMPT   Sp
 
 	  $ perf script -F +misc ...
 	   sched-messaging  1414 K     28690.636582:       4590 cycles ...
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b17edbcd98cc..e0a9845b6cbc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -657,8 +657,11 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 			break;
 		case PERF_RECORD_SWITCH:
 		case PERF_RECORD_SWITCH_CPU_WIDE:
-			if (has(SWITCH_OUT))
+			if (has(SWITCH_OUT)) {
 				ret += fprintf(fp, "S");
+				if (sample->misc & PERF_RECORD_MISC_SWITCH_OUT_PREEMPT)
+					ret += fprintf(fp, "p");
+			}
 		default:
 			break;
 		}
