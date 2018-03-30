Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbeC3Eyy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 00:54:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:29899 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbeC3Eyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 00:54:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,380,1517904000";
   d="scan'208";a="38073326"
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v5 0/3] perf/core: expose thread context switch out event type
 to user space
Organization: Intel Corp.
Message-ID: <45f6ea8a-a420-d176-50aa-9b3975c0ea7a@linux.intel.com>
Date: Fri, 30 Mar 2018 07:54:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement preempting context switch out event as a part of 
PERF_RECORD_SWITCH[_CPU_WIDE] record. The event is treated as preemption 
one when task->state value of the thread being switched out is TASK_RUNNING;

Percentage of preempting and non-preempting context switches help 
understanding the nature of workloads (CPU or IO bound) that are running 
on the machine;

Event type encoding is implemented using a new
PERF_RECORD_MISC_SWITCH_OUT_PREEMPT bit in misc field of event record header;

Perf tool report and script commands have been extended to decode 
new PREEMPT bit and the updated output looks like this:

tools/perf/perf report -D -i perf.data | grep _SWITCH

0 768361415226 0x27f076 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     8/8    
4 768362216813 0x28f45e [0x28]: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:     0/0    
4 768362217824 0x28f486 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:  4073/4073 
0 768362414027 0x27f0ce [0x28]: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:     8/8    
0 768362414367 0x27f0f6 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0    

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

The documentation has been updated to mention PREEMPT switch out events 
and its decoding symbols in perf script output.

The changes have been manually tested on Fedora 27 with the patched kernel:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core

---
 Alexey Budankov (3):
	perf/core: store context switch out type into Perf trace
	perf report: extend raw dump (-D) out with switch out event type
	perf script: extend misc field decoding with switch out event type

 include/uapi/linux/perf_event.h          | 18 +++++++++++++++---
 kernel/events/core.c                     |  4 ++++
 tools/include/uapi/linux/perf_event.h    | 18 +++++++++++++++---
 tools/perf/Documentation/perf-script.txt | 17 +++++++++--------
 tools/perf/builtin-script.c              |  5 ++++-
 tools/perf/util/event.c                  |  4 +++-
 6 files changed, 50 insertions(+), 16 deletions(-)
