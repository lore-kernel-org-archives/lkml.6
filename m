Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753414AbeCTNGP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:06:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:40460 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753222AbeCTNGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:06:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="213218207"
Subject: [PATCH v1 3/3] perf script: extend misc field deconding with switch
 out event type
From: Alexey Budankov <alexey.budankov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4857e3ba-a42f-a9a2-2668-91ca9b44727c@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2b9852a2-cfac-2c12-1504-a94a9eba03f2@linux.intel.com>
Date: Tue, 20 Mar 2018 16:06:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4857e3ba-a42f-a9a2-2668-91ca9b44727c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Append 'y' sign to 'S' tag designating the type of context switch out event so 
'S' means preemption context switch and 'Sy' means synchronization context 
switch. Documentation is extended to cover new presentation changes.

perf script --show-switch-events -F +misc -I -i system-wide.perf:

amplxe-perf  7681 [005] S     15663.273151: PERF_RECORD_SWITCH_CPU_WIDE OUT  next pid/tid:    39/39   
migration/5    39 [005]       15663.273152: PERF_RECORD_SWITCH_CPU_WIDE IN   prev pid/tid:  7681/7681 
amplxe-perf  7680 [007] K     15663.273153:          1                                                                                                                                       context-switch: 
                  aaa488 schedule ([kernel.kallsyms])
                  1a9f50 __poll_nocancel (inlined)

amplxe-perf  7680 [007] Sy    15663.273156: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:     0/0    
migration/5    39 [005] K     15663.273157:

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-script.txt | 17 +++++++++--------
 tools/perf/builtin-script.c              |  5 ++++-
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 36ec0257f8d3..80e94cbbf520 100644
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
+	  PERF_RECORD_MISC_SWITCH_OUT_YIELD     Sy
 
 	  $ perf script -F +misc ...
 	   sched-messaging  1414 K     28690.636582:       4590 cycles ...
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index cce926aeb0c0..06d7fe73886f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -657,8 +657,11 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 			break;
 		case PERF_RECORD_SWITCH:
 		case PERF_RECORD_SWITCH_CPU_WIDE:
-			if (has(SWITCH_OUT))
+			if (has(SWITCH_OUT)) {
 				ret += fprintf(fp, "S");
+				if (sample->misc & PERF_RECORD_MISC_SWITCH_OUT_YIELD)
+					ret += fprintf(fp, "y");
+			}
 		default:
 			break;
 		}
