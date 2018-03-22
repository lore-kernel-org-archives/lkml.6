Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751669AbeCVQQh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:16:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:35710 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbeCVQQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:16:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,345,1517904000";
   d="scan'208";a="37237711"
Subject: [PATCH v2 3/3] perf script: extend misc field decoding with switch
 out event type
From: Alexey Budankov <alexey.budankov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
References: <713750a0-7cc1-0a27-7253-12ff4f3c9a8d@linux.intel.com>
Organization: Intel Corp.
Message-ID: <61fcf81c-f72e-d745-a7e7-52b761b7ec2d@linux.intel.com>
Date: Thu, 22 Mar 2018 19:16:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <713750a0-7cc1-0a27-7253-12ff4f3c9a8d@linux.intel.com>
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

  rcu_sched     8 [003]       113800.748548: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid:     0/0    
       perf 31479 [000] S     113800.748548: PERF_RECORD_SWITCH_CPU_WIDE OUT        next pid/tid:    59/59   
kworker/0:1    59 [000]       113800.748549: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid: 31479/31479
  rcu_sched     8 [003] Sy    113800.748551: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:     0/0    
    swapper     0 [003]       113800.748551: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid:     8/8

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
index 313c42423393..c0a3a7297c8a 100644
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
