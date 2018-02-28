Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeB1OZ5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:25:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752241AbeB1OZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:25:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE91B21782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Wed, 28 Feb 2018 23:25:51 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        ananth@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, oleg@redhat.com
Subject: Re: [RFC 0/4] trace_uprobe: Support SDT markers having semaphore
Message-Id: <20180228232551.5e99736b4b4fd209e492cd4d@kernel.org>
In-Reply-To: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

Thank you for your great work!

On Wed, 28 Feb 2018 13:23:41 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> Userspace Statically Defined Tracepoints[1] are dtrace style markers
> inside userspace applications. These markers are added by developer at
> important places in the code. Each marker source expands to a single
> nop instruction in the compiled code but there may be additional
> overhead for computing the marker arguments which expands to couple of
> instructions. If this computaion is quite more, execution of it can be
> ommited by runtime if() condition when no one is tracing on the marker:
> 
>     if (semaphore > 0) {
>         Execute marker instructions;
>     }
> 
> Default value of semaphore is 0. Tracer has to increment the semaphore
> before recording on a marker and decrement it at the end of tracing.
> 
> Currently, perf tool has limited supports for SDT markers. I.e. it
> can not trace markers surrounded by semaphore. Also, it's not easy
> to add semaphore flip logic in userspace tool like perf, so basic
> idea for this patchset is to add semaphore flip logic in the
> trace_uprobe infrastructure. Ex,[2]
> 
>   # cat tick.c
>     ... 
>     for (i = 0; i < 100; i++) {
> 	DTRACE_PROBE1(tick, loop1, i);
>         if (TICK_LOOP2_ENABLED()) {
>             DTRACE_PROBE1(tick, loop2, i); 
>         }
>         printf("hi: %d\n", i); 
>         sleep(1);
>     }   
>     ... 
> 
> Here tick:loop1 is marker without semaphore where as tick:loop2 is
> surrounded by semaphore.
> 
> 
>   # perf buildid-cache --add /tmp/tick
>   # perf probe sdt_tick:loop1
>   # perf probe sdt_tick:loop2
> 
>   # perf stat -e sdt_tick:loop1,sdt_tick:loop2 -- /tmp/tick
>   hi: 0
>   hi: 1
>   hi: 2
>   ^C
>   Performance counter stats for '/tmp/tick':
>              3      sdt_tick:loop1
>              0      sdt_tick:loop2
>      2.747086086 seconds time elapsed
> 
> 
> Perf failed to record data for tick:loop2. Same experiment with this
> patch series:
> 
> 
>   # readelf -n ./tick
>   Provider: tick
>   Name: loop2
>   ... Semaphore: 0x0000000010020036
> 
>   # readelf -SW ./tick | grep probes
>   [25] .probes           PROGBITS        0000000010020034 010034
> 
> 
> Semaphore offset is 0x10036. I don't have educated 'perf probe'
> about semaphore. So instead of using 'perf probe' command, I'm
> manually adding entry in the <tracefs>/uprobe_events file.

Ok, it is easy to pass semaphore address via perf probe :)

> Special char * denotes semaphore offset.
> 
> 
>   # echo "p:sdt_tick/loop2 /tmp/tick:0x6e4 *0x10036" > uprobe_events

IMHO, this syntax is no good, separate with space is only for arguments.
Since the semaphore is per-probe-point based, that should be specified with probe point.
(there are no 2 or more semaphores on 1 event, are there?)
So something like

# echo "p:sdt_tick/loop2 /tmp/tick:0x6e4(0x10036)" > uprobe_events

would be better to me.

Thank you,

> 
>   # perf stat -e sdt_tick:loop2 -- /tmp/tick
>   hi: 0
>   hi: 1
>   hi: 2
>   hi: 3
>   ^C
>   Performance counter stats for '/tmp/tick':
>               4      sdt_tick:loop2                                              
>      3.359047827 seconds time elapsed
> 
> 
> Feedback?
> 
> TODO:
>  - Educate perf tool about semaphore.
>  - perf_event_open() now suppoers {k,u}probe event creation[3]. If we
>    can supply semaphore offset in perf_event_attr, perf_event_open()
>    can be educated to probe SDT marker having semaphore. Though, both
>    config1 and config2 are already being used for uprobe and I don't
>    see any other attribute which I can use for semaphore offset. Can
>    we introduce one more config there? config3?
> 
> [1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
> [2] https://github.com/iovisor/bcc/issues/327#issuecomment-200576506
> [3] https://lkml.org/lkml/2017/12/6/976
> 
> 
> Ravi Bangoria (4):
>   Uprobe: Rename map_info to uprobe_map_info
>   Uprobe: Export few functions / data structures
>   trace_uprobe: Support SDT markers having semaphore
>   trace_uprobe: Fix multiple update of same semaphores
> 
>  include/linux/uprobes.h     |  25 +++++
>  kernel/events/uprobes.c     |  43 ++++----
>  kernel/trace/trace_uprobe.c | 244 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 290 insertions(+), 22 deletions(-)
> 
> -- 
> 1.8.3.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
