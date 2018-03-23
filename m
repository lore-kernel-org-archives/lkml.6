Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeCWJYe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:24:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751668AbeCWJYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:24:33 -0400
Date: Fri, 23 Mar 2018 10:24:30 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 0/3] perf/core: expose thread context switch out event
 type to user space
Message-ID: <20180323092430.GB4096@krava>
References: <713750a0-7cc1-0a27-7253-12ff4f3c9a8d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <713750a0-7cc1-0a27-7253-12ff4f3c9a8d@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 07:08:25PM +0300, Alexey Budankov wrote:
> 
> Implementation of exposing context-switch-out type event as a part 
> of PERF_RECORD_SWITCH[_CPU_WIDE] record.
> 
> Introduced types of events assumed to be:
> a) preempt: when task->state == TASK_RUNNING
> b) yield: !preempt, encoding is done using new bit 
>    PERF_RECORD_MISC_SWITCH_OUT_YIELD like this:
>    
>    event_header->misc &= 
> 	PERF_RECORD_MISC_SWITCH_OUT|PERF_RECORD_MISC_SWITCH_OUT_YIELD
> 
> Perf tool report and script commands output has been extended to decode 
> new yield bit and the updated output looks like in the examples below.
> 
> The documentation has been updated to mention yield switch out events 
> and its decoding symbols in perf script output.
> 
> The changes have been manually tested on Fedora 27 with the patched kernel:
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
> 
> perf report -D -i system-wide.perf | grep _SWITCH: 
> 
> 1 113807080924003 0x26db26 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE OUT        next pid/tid: 20495/20495
> 1 113807080925644 0x26db4e [0x28]: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid: 31479/31479
> 1 113807080937266 0x26db76 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:    16/16   
> 1 113807080938445 0x26db9e [0x28]: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid: 20495/20495
> 1 113807080945455 0x26dbc6 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid: 20495/20495
> 
> perf script --show-switch-events -F +misc -I -i system-wide.perf:
> 
>   rcu_sched     8 [003]       113800.748548: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid:     0/0    
>        perf 31479 [000] S     113800.748548: PERF_RECORD_SWITCH_CPU_WIDE OUT        next pid/tid:    59/59   
> kworker/0:1    59 [000]       113800.748549: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid: 31479/31479
>   rcu_sched     8 [003] Sy    113800.748551: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:     0/0    
>     swapper     0 [003]       113800.748551: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid:     8/8

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> ---
>  Alexey Budankov (3):
> 	perf/core: store context switch out type into Perf trace
> 	perf report: extend raw dump (-D) out with switch out event type
> 	perf script: extend misc field decoding with switch out event type
> 
>  include/uapi/linux/perf_event.h          |  5 +++++
>  kernel/events/core.c                     |  4 +++-
>  tools/include/uapi/linux/perf_event.h    |  5 +++++
>  tools/perf/Documentation/perf-script.txt | 17 +++++++++--------
>  tools/perf/builtin-script.c              |  5 ++++-
>  tools/perf/util/event.c                  |  4 +++-
>  6 files changed, 29 insertions(+), 11 deletions(-)
