Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeCVQIc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:08:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:26546 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751811AbeCVQIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:08:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,345,1517904000";
   d="scan'208";a="27974439"
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v2 0/3] perf/core: expose thread context switch out event type
 to user space
Organization: Intel Corp.
Message-ID: <713750a0-7cc1-0a27-7253-12ff4f3c9a8d@linux.intel.com>
Date: Thu, 22 Mar 2018 19:08:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implementation of exposing context-switch-out type event as a part 
of PERF_RECORD_SWITCH[_CPU_WIDE] record.

Introduced types of events assumed to be:
a) preempt: when task->state == TASK_RUNNING
b) yield: !preempt, encoding is done using new bit 
   PERF_RECORD_MISC_SWITCH_OUT_YIELD like this:
   
   event_header->misc &= 
	PERF_RECORD_MISC_SWITCH_OUT|PERF_RECORD_MISC_SWITCH_OUT_YIELD

Perf tool report and script commands output has been extended to decode 
new yield bit and the updated output looks like in the examples below.

The documentation has been updated to mention yield switch out events 
and its decoding symbols in perf script output.

The changes have been manually tested on Fedora 27 with the patched kernel:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core

perf report -D -i system-wide.perf | grep _SWITCH: 

1 113807080924003 0x26db26 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE OUT        next pid/tid: 20495/20495
1 113807080925644 0x26db4e [0x28]: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid: 31479/31479
1 113807080937266 0x26db76 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:    16/16   
1 113807080938445 0x26db9e [0x28]: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid: 20495/20495
1 113807080945455 0x26dbc6 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid: 20495/20495

perf script --show-switch-events -F +misc -I -i system-wide.perf:

  rcu_sched     8 [003]       113800.748548: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid:     0/0    
       perf 31479 [000] S     113800.748548: PERF_RECORD_SWITCH_CPU_WIDE OUT        next pid/tid:    59/59   
kworker/0:1    59 [000]       113800.748549: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid: 31479/31479
  rcu_sched     8 [003] Sy    113800.748551: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:     0/0    
    swapper     0 [003]       113800.748551: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid:     8/8

---
 Alexey Budankov (3):
	perf/core: store context switch out type into Perf trace
	perf report: extend raw dump (-D) out with switch out event type
	perf script: extend misc field decoding with switch out event type

 include/uapi/linux/perf_event.h          |  5 +++++
 kernel/events/core.c                     |  4 +++-
 tools/include/uapi/linux/perf_event.h    |  5 +++++
 tools/perf/Documentation/perf-script.txt | 17 +++++++++--------
 tools/perf/builtin-script.c              |  5 ++++-
 tools/perf/util/event.c                  |  4 +++-
 6 files changed, 29 insertions(+), 11 deletions(-)
