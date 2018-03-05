Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934457AbeCELme (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:42:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:59764 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933550AbeCELmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:42:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="scan'208";a="35559428"
Subject: [PATCH v1 3/3] perf script: extend misc field deconding with switch
 out event type
From: Alexey Budankov <alexey.budankov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitri Prokhorov <Dmitry.Prohorov@intel.com>
References: <6db586f3-36da-285c-b008-f2722419fbf8@linux.intel.com>
Organization: Intel Corp.
Message-ID: <7dd86202-bf3d-6057-34ff-7784813aed36@linux.intel.com>
Date: Mon, 5 Mar 2018 14:42:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6db586f3-36da-285c-b008-f2722419fbf8@linux.intel.com>
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
