Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeC3FDN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 01:03:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:49464 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeC3FDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 01:03:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,380,1517904000";
   d="scan'208";a="30126343"
Subject: [PATCH v5 3/3] perf script: extend misc field decoding with switch
 out event type
From: Alexey Budankov <alexey.budankov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <45f6ea8a-a420-d176-50aa-9b3975c0ea7a@linux.intel.com>
Organization: Intel Corp.
Message-ID: <58fabd67-ee0c-da50-af2a-05321011355a@linux.intel.com>
Date: Fri, 30 Mar 2018 08:02:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <45f6ea8a-a420-d176-50aa-9b3975c0ea7a@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Append 'p' sign to 'S' tag designating the type of context switch out event so 
'Sp' means preemption context switch. Documentation is extended to cover 
new presentation changes.

perf script --show-switch-events -F +misc -I -i perf.data:

          hdparm  4073 [004] U       762.198265:     380194 cycles:ppp:      7faf727f5a23 strchr (/usr/lib64/ld-2.26.so)
          hdparm  4073 [004] K       762.198366:     441572 cycles:ppp:  ffffffffb9218435 alloc_set_pte (/lib/modules/4.16.0-rc6+/build/vmlinux)
          hdparm  4073 [004] S       762.198391: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:     0/0    
         swapper     0 [004]         762.198392: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:  4073/4073 
         swapper     0 [004] Sp      762.198477: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:  4073/4073 
          hdparm  4073 [004]         762.198478: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0    
         swapper     0 [007] K       762.198514:    2303073 cycles:ppp:  ffffffffb98b0c66 intel_idle (/lib/modules/4.16.0-rc6+/build/vmlinux)
         swapper     0 [007] Sp      762.198561: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:  1134/1134 
  kworker/u16:18  1134 [007]         762.198562: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0    
  kworker/u16:18  1134 [007] S       762.198567: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:     0/0    

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
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
index 313c42423393..0f916e8e1835 100644
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
