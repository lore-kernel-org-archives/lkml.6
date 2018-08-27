Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F09BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A0721735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A0721735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=monom.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeH0LBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:01:37 -0400
Received: from mail.monom.org ([188.138.9.77]:54544 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbeH0LBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:01:37 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id CA0D4500B31;
        Mon, 27 Aug 2018 09:16:07 +0200 (CEST)
Received: from helium.monom.org (ppp-93-104-166-104.dynamic.mnet-online.de [93.104.166.104])
        by mail.monom.org (Postfix) with ESMTPSA id 7C44450032F;
        Mon, 27 Aug 2018 09:16:06 +0200 (CEST)
Subject: Re: [ANNOUNCE] 4.4.148-rt165
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
References: <20180816202709.69869500B0B@mail.monom.org>
Message-ID: <4d878d3e-bd1b-3d6e-bdde-4ce840191093@monom.org>
Date:   Mon, 27 Aug 2018 09:16:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180816202709.69869500B0B@mail.monom.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Known issues:
> 
> - 'stress-ng --ptrace 4' is able to trigger a latency spike of
>     several ms. Usually around 2 - 3ms on two different x86_64 boxes I can
>     test on. 4.9-rt seems to have the same problem. 4.14-rt and 4.16-rt
>     work just fine. Still debugging the issue.

I have a good reproducer for this problem. 

- start 'stress-ng --ptrace 4' in the background
- start 'cyclictest -P 80 -n -m -S -b 2000'  (*)
- start 'trace-cmd start -e all -p function -l '*mutex*'

Few observations:
 - Running cyclictest with '-i 1000 -d 0' -> no latency spikes
 - Tracing spinlocks via "-l '*locks'*" -> no latency spikes

In the trace below the latency spike is on CPU0. It looks like it
doesn't make any progress after signal_generate:


stress-n-1931    0d..11  5060.891219: function:             __try_to_take_rt_mutex
stress-n-1931    0d..11  5060.891219: function:                rt_mutex_dequeue
stress-n-1931    0d..21  5060.891220: function:                rt_mutex_enqueue_pi
stress-n-1931    0....2  5060.891220: signal_generate:      sig=17 errno=0 code=262148 comm=stress-ng-ptrac pid=1928 grp=1 res=1
stress-n-1931    0d..21  5060.894114: function:             rt_mutex_dequeue_pi
stress-n-1931    0d.h11  5060.894115: local_timer_entry:    vector=239


While on CPU1 at the same time this happens:


stress-n-1928    1....0  5060.891215: sys_enter:            NR 101 (18, 78b, 0, 0, 17, 788)
stress-n-1928    1d..11  5060.891216: function:             __try_to_take_rt_mutex
stress-n-1928    1d..21  5060.891216: function:                rt_mutex_enqueue_pi
stress-n-1928    1d..21  5060.891217: function:             rt_mutex_dequeue_pi
stress-n-1928    1....1  5060.891217: function:             rt_mutex_adjust_prio
stress-n-1928    1d..11  5060.891218: function:                __rt_mutex_adjust_prio
stress-n-1928    1d.h10  5060.894114: local_timer_entry:    vector=239


That is what I have at this point. I looks like rt_mutex could be 
involved in this problem. 

Thanks,
Daniel

(*) In the trace below I am using my rewrite of cyclictest called
    jitterdebugger. Does the same thing just without all the
    whistle and bells. For example it doesn't play with the
    tracer, which allows my to write something like

	cnt=0
	while true ; do
	    trace-cmd start -e all -p function -l '*mutex*' > /dev/null
	    ~/jitterdebugger -b 1000 -f jt-$cnt.json -v
	    trace-cmd extract -o trace-$cnt.dat > /dev/null
	    cnt=$(($cnt + 1))
	done




cpu 0: only

stress-n-1931    0d..20  5060.891195: sched_stat_runtime:   comm=stress-ng-ptrac pid=1931 runtime=6708 [ns] vruntime=1977715609843 [ns]
stress-n-1931    0d..20  5060.891196: sched_stat_wait:      comm=stress-ng-ptrac pid=1927 delay=17045 [ns]
stress-n-1931    0d..20  5060.891196: sched_switch:         stress-ng-ptrac:1931 [120] D ==> stress-ng-ptrac:1927 [120]
stress-n-1931    0d..20  5060.891197: tlb_flush:            pages=-1 reason=flush on task switch (0)
stress-n-1927    0d..21  5060.891198: function:             rt_mutex_dequeue_pi
stress-n-1927    0d..11  5060.891199: sched_waking:         comm=stress-ng-ptrac pid=1928 prio=120 target_cpu=001
stress-n-1927    0d..21  5060.891200: sched_stat_runtime:   comm=stress-ng-ptrac pid=1932 runtime=3621 [ns] vruntime=2068053558563 [ns]
stress-n-1927    0d..21  5060.891201: sched_stat_blocked:   comm=stress-ng-ptrac pid=1928 delay=14885 [ns]
stress-n-1927    0d..21  5060.891202: sched_wakeup:         stress-ng-ptrac:1928 [120] success=1 CPU:001
stress-n-1927    0....1  5060.891202: function:             rt_mutex_adjust_prio
stress-n-1927    0d..11  5060.891203: function:                __rt_mutex_adjust_prio
stress-n-1927    0d..20  5060.891203: sched_wait_task:      comm=stress-ng-ptrac pid=1930 prio=120
stress-n-1927    0d..10  5060.891204: sched_waking:         comm=stress-ng-ptrac pid=1930 prio=120 target_cpu=000
stress-n-1927    0d..20  5060.891204: sched_stat_runtime:   comm=stress-ng-ptrac pid=1927 runtime=9515 [ns] vruntime=1977720093354 [ns]
stress-n-1927    0d..20  5060.891205: sched_wakeup:         stress-ng-ptrac:1930 [120] success=1 CPU:000
stress-n-1927    0...10  5060.891205: rcu_utilization:      Start context switch
stress-n-1927    0...10  5060.891206: rcu_utilization:      End context switch
stress-n-1927    0d..20  5060.891206: sched_stat_runtime:   comm=stress-ng-ptrac pid=1927 runtime=2013 [ns] vruntime=1977720095367 [ns]
stress-n-1927    0d..20  5060.891207: sched_stat_wait:      comm=stress-ng-ptrac pid=1930 delay=2013 [ns]
stress-n-1927    0d..20  5060.891207: sched_switch:         stress-ng-ptrac:1927 [120] R ==> stress-ng-ptrac:1930 [120]
stress-n-1927    0d..20  5060.891208: tlb_flush:            pages=-1 reason=flush on task switch (0)
stress-n-1930    0d..11  5060.891210: function:             __try_to_take_rt_mutex
stress-n-1930    0d..21  5060.891211: function:                rt_mutex_enqueue_pi
stress-n-1930    0....2  5060.891211: signal_generate:      sig=17 errno=0 code=262148 comm=stress-ng-ptrac pid=1927 grp=1 res=1
stress-n-1930    0d..21  5060.891212: function:             rt_mutex_dequeue_pi
stress-n-1930    0....1  5060.891213: function:             rt_mutex_adjust_prio
stress-n-1930    0d..11  5060.891214: function:                __rt_mutex_adjust_prio
stress-n-1930    0...10  5060.891214: rcu_utilization:      Start context switch
stress-n-1930    0...10  5060.891214: rcu_utilization:      End context switch
stress-n-1930    0d..20  5060.891215: sched_stat_runtime:   comm=stress-ng-ptrac pid=1930 runtime=3639 [ns] vruntime=1977714643707 [ns]
stress-n-1930    0d..20  5060.891216: sched_stat_wait:      comm=stress-ng-ptrac pid=1931 delay=3639 [ns]
stress-n-1930    0d..20  5060.891217: sched_switch:         stress-ng-ptrac:1930 [120] t|W ==> stress-ng-ptrac:1931 [120]
stress-n-1930    0d..20  5060.891217: tlb_flush:            pages=-1 reason=flush on task switch (0)
stress-n-1931    0d..11  5060.891219: function:             __try_to_take_rt_mutex
stress-n-1931    0d..11  5060.891219: function:                rt_mutex_dequeue
stress-n-1931    0d..21  5060.891220: function:                rt_mutex_enqueue_pi
stress-n-1931    0....2  5060.891220: signal_generate:      sig=17 errno=0 code=262148 comm=stress-ng-ptrac pid=1928 grp=1 res=1
stress-n-1931    0d..21  5060.894114: function:             rt_mutex_dequeue_pi
stress-n-1931    0d.h11  5060.894115: local_timer_entry:    vector=239
stress-n-1931    0d.h21  5060.894115: hrtimer_cancel:       hrtimer=0xffff8800c7fabe38
stress-n-1931    0d.h11  5060.894115: hrtimer_expire_entry: hrtimer=0xffff8800c7fabe38 now=5061028001164 function=hrtimer_wakeup/0x0
stress-n-1931    0d.h21  5060.894116: sched_waking:         comm=jitterdebugger pid=2530 prio=19 target_cpu=000
stress-n-1931    0dNh31  5060.894117: sched_wakeup:         jitterdebugger:2530 [19] success=1 CPU:000
stress-n-1931    0dNh11  5060.894117: hrtimer_expire_exit:  hrtimer=0xffff8800c7fabe38
stress-n-1931    0dNh21  5060.894117: hrtimer_cancel:       hrtimer=0xffff88012fc10d80
stress-n-1931    0dNh11  5060.894118: hrtimer_expire_entry: hrtimer=0xffff88012fc10d80 now=5061028001164 function=tick_sched_timer/0x0
stress-n-1931    0dNh21  5060.894119: sched_stat_runtime:   comm=stress-ng-ptrac pid=1931 runtime=2904713 [ns] vruntime=1977718514556 [ns]
stress-n-1931    0dNh11  5060.894121: softirq_raise:        vec=7 [action=SCHED]
stress-n-1931    0dNh11  5060.894121: softirq_raise:        vec=1 [action=TIMER]
stress-n-1931    0dNh11  5060.894122: rcu_utilization:      Start scheduler-tick
stress-n-1931    0dNh11  5060.894122: rcu_utilization:      End scheduler-tick
stress-n-1931    0dNh11  5060.894123: hrtimer_expire_exit:  hrtimer=0xffff88012fc10d80
stress-n-1931    0dNh21  5060.894123: hrtimer_start:        hrtimer=0xffff88012fc10d80 function=tick_sched_timer/0x0 expires=5061032000000 softexpires=5061032000000
stress-n-1931    0dNh11  5060.894124: local_timer_exit:     vector=239
stress-n-1931    0dN.21  5060.894124: sched_waking:         comm=ksoftirqd/0 pid=3 prio=120 target_cpu=000
stress-n-1931    0dN.31  5060.894125: sched_stat_sleep:     comm=ksoftirqd/0 pid=3 delay=3977690 [ns]
stress-n-1931    0dN.31  5060.894125: sched_wakeup:         ksoftirqd/0:3 [120] success=1 CPU:000
stress-n-1931    0dN.21  5060.894126: sched_waking:         comm=ktimersoftd/0 pid=4 prio=98 target_cpu=000
stress-n-1931    0dN.31  5060.894127: sched_wakeup:         ktimersoftd/0:4 [98] success=1 CPU:000
stress-n-1931    0.N.11  5060.894127: rcu_utilization:      Start context switch
stress-n-1931    0.N.11  5060.894128: rcu_utilization:      End context switch
stress-n-1931    0dN.21  5060.894128: sched_stat_runtime:   comm=stress-ng-ptrac pid=1931 runtime=7046 [ns] vruntime=1977718521602 [ns]
stress-n-1931    0d..21  5060.894129: sched_switch:         stress-ng-ptrac:1931 [120] R ==> jitterdebugger:2530 [19]
stress-n-1931    0d..21  5060.894130: tlb_flush:            pages=-1 reason=flush on task switch (0)
jitterde-2530    0....0  5060.894131: sys_exit:             NR 230 = 0
jitterde-2530    0....0  5060.894140: sys_enter:            NR 1 (5, 7f25ae652eb0, 10, 75, 1, 10)
jitterde-2530    0....0  5060.894140: function:             _mutex_lock
jitterde-2530    0....0  5060.894141: function:                rt_mutex_lock
jitterde-2530    0....1  5060.894144: print:                tracing_mark_write: Hit latency 2696
jitterde-2530    0....0  5060.894145: function:             _mutex_unlock
jitterde-2530    0....0  5060.894145: function:                rt_mutex_unlock
jitterde-2530    0....0  5060.894145: sys_exit:             NR 1 = 16
jitterde-2530    0....0  5060.894146: sys_enter:            NR 1 (4, 402194, 2, 75, 1, 10)
jitterde-2530    0....0  5060.894147: function:             _mutex_lock
jitterde-2530    0....0  5060.894147: function:                rt_mutex_lock
jitterde-2530    0....0  5060.894149: function:             _mutex_lock
jitterde-2530    0....0  5060.894149: function:                rt_mutex_lock



cpu 1 only

stress-n-1929    1d..20  5060.891169: sched_stat_runtime:   comm=stress-ng-ptrac pid=1929 runtime=5688 [ns] vruntime=2068054001980 [ns]
stress-n-1929    1d..20  5060.891170: sched_stat_wait:      comm=stress-ng-ptrac pid=1928 delay=5688 [ns]
stress-n-1929    1d..20  5060.891170: sched_switch:         stress-ng-ptrac:1929 [120] R ==> stress-ng-ptrac:1928 [120]
stress-n-1929    1d..20  5060.891171: tlb_flush:            pages=-1 reason=flush on task switch (0)
stress-n-1928    1....0  5060.891172: sys_exit:             NR 61 = 1931
stress-n-1928    1....0  5060.891173: sys_enter:            NR 101 (18, 78b, 0, 0, 17, 788)
stress-n-1928    1d..20  5060.891174: sched_wait_task:      comm=stress-ng-ptrac pid=1931 prio=120
stress-n-1928    1d..10  5060.891175: sched_waking:         comm=stress-ng-ptrac pid=1931 prio=120 target_cpu=000
stress-n-1928    1d..20  5060.891176: sched_stat_runtime:   comm=stress-ng-ptrac pid=1927 runtime=7937 [ns] vruntime=1977720081607 [ns]
stress-n-1928    1d..20  5060.891177: sched_wakeup:         stress-ng-ptrac:1931 [120] success=1 CPU:000
stress-n-1928    1....0  5060.891178: sys_exit:             NR 101 = 0
stress-n-1928    1....0  5060.891178: sys_enter:            NR 61 (78b, 7fff38c319f4, 0, 0, 17, 788)
stress-n-1928    1....0  5060.891179: sched_process_wait:   comm=stress-ng-ptrac pid=1931 prio=120
stress-n-1928    1d..11  5060.891179: function:             __try_to_take_rt_mutex
stress-n-1928    1d..11  5060.891180: function:             task_blocks_on_rt_mutex
stress-n-1928    1d..21  5060.891180: function:                __rt_mutex_adjust_prio
stress-n-1928    1d..21  5060.891180: function:                rt_mutex_enqueue
stress-n-1928    1d..21  5060.891180: function:                rt_mutex_dequeue_pi
stress-n-1928    1d..21  5060.891181: function:                rt_mutex_enqueue_pi
stress-n-1928    1d..21  5060.891181: function:                __rt_mutex_adjust_prio
stress-n-1928    1d..11  5060.891181: function:             __try_to_take_rt_mutex
stress-n-1928    1...10  5060.891184: rcu_utilization:      Start context switch
stress-n-1928    1...10  5060.891184: rcu_utilization:      End context switch
stress-n-1928    1d..20  5060.891185: sched_stat_runtime:   comm=stress-ng-ptrac pid=1928 runtime=16814 [ns] vruntime=2068049707094 [ns]
stress-n-1928    1d..20  5060.891186: sched_stat_wait:      comm=stress-ng-ptrac pid=1929 delay=16814 [ns]
stress-n-1928    1d..20  5060.891187: sched_switch:         stress-ng-ptrac:1928 [120] D ==> stress-ng-ptrac:1929 [120]
stress-n-1928    1d..20  5060.891187: tlb_flush:            pages=-1 reason=flush on task switch (0)
stress-n-1929    1d..20  5060.891188: sched_wait_task:      comm=stress-ng-ptrac pid=1932 prio=120
stress-n-1929    1d..10  5060.891188: sched_waking:         comm=stress-ng-ptrac pid=1932 prio=120 target_cpu=001
stress-n-1929    1d..20  5060.891189: sched_stat_runtime:   comm=stress-ng-ptrac pid=1929 runtime=4262 [ns] vruntime=2068054006242 [ns]
stress-n-1929    1d..20  5060.891190: sched_wakeup:         stress-ng-ptrac:1932 [120] success=1 CPU:001
stress-n-1929    1....0  5060.891191: sys_exit:             NR 101 = 0
stress-n-1929    1....0  5060.891192: sys_enter:            NR 61 (78c, 7fff38c319f4, 0, 0, 17, 789)
stress-n-1929    1....0  5060.891192: sched_process_wait:   comm=stress-ng-ptrac pid=1932 prio=120
stress-n-1929    1d..11  5060.891194: function:             __try_to_take_rt_mutex
stress-n-1929    1d..11  5060.891194: function:             task_blocks_on_rt_mutex
stress-n-1929    1d..21  5060.891194: function:                __rt_mutex_adjust_prio
stress-n-1929    1d..21  5060.891195: function:                rt_mutex_enqueue
stress-n-1929    1d..11  5060.891195: function:             __try_to_take_rt_mutex
stress-n-1929    1...10  5060.891195: rcu_utilization:      Start context switch
stress-n-1929    1...10  5060.891196: rcu_utilization:      End context switch
stress-n-1929    1d..20  5060.891196: sched_stat_runtime:   comm=stress-ng-ptrac pid=1929 runtime=7002 [ns] vruntime=2068054013244 [ns]
stress-n-1929    1d..20  5060.891197: sched_stat_wait:      comm=stress-ng-ptrac pid=1932 delay=7002 [ns]
stress-n-1929    1d..20  5060.891198: sched_switch:         stress-ng-ptrac:1929 [120] D ==> stress-ng-ptrac:1932 [120]
stress-n-1929    1d..20  5060.891198: tlb_flush:            pages=-1 reason=flush on task switch (0)
stress-n-1932    1d..11  5060.891200: function:             __try_to_take_rt_mutex
stress-n-1932    1d..21  5060.891201: function:                rt_mutex_enqueue_pi
stress-n-1932    1....2  5060.891201: signal_generate:      sig=17 errno=0 code=262148 comm=stress-ng-ptrac pid=1929 grp=1 res=1
stress-n-1932    1d.h.3  5060.891202: reschedule_entry:     vector=253
stress-n-1932    1d.h.3  5060.891202: reschedule_exit:      vector=253
stress-n-1932    1d..21  5060.891203: function:             rt_mutex_dequeue_pi
stress-n-1932    1....1  5060.891204: function:             rt_mutex_adjust_prio
stress-n-1932    1d..11  5060.891204: function:                __rt_mutex_adjust_prio
stress-n-1932    1...10  5060.891204: rcu_utilization:      Start context switch
stress-n-1932    1...10  5060.891205: rcu_utilization:      End context switch
stress-n-1932    1d..20  5060.891206: sched_stat_runtime:   comm=stress-ng-ptrac pid=1932 runtime=5495 [ns] vruntime=2068053564058 [ns]
stress-n-1932    1d..20  5060.891206: sched_stat_wait:      comm=stress-ng-ptrac pid=1928 delay=5495 [ns]
stress-n-1932    1d..20  5060.891207: sched_switch:         stress-ng-ptrac:1932 [120] R ==> stress-ng-ptrac:1928 [120]
stress-n-1932    1d..20  5060.891207: tlb_flush:            pages=-1 reason=flush on task switch (0)
stress-n-1928    1d..11  5060.891208: function:             __try_to_take_rt_mutex
stress-n-1928    1d..11  5060.891208: function:                rt_mutex_dequeue
stress-n-1928    1d..21  5060.891209: function:                rt_mutex_enqueue_pi
stress-n-1928    1d..21  5060.891210: function:             rt_mutex_dequeue_pi
stress-n-1928    1d..11  5060.891210: sched_waking:         comm=stress-ng-ptrac pid=1931 prio=120 target_cpu=000
stress-n-1928    1d..21  5060.891211: sched_stat_runtime:   comm=stress-ng-ptrac pid=1930 runtime=4893 [ns] vruntime=1977714640068 [ns]
stress-n-1928    1d..21  5060.891212: sched_stat_blocked:   comm=stress-ng-ptrac pid=1931 delay=16421 [ns]
stress-n-1928    1d..21  5060.891213: sched_wakeup:         stress-ng-ptrac:1931 [120] success=1 CPU:000
stress-n-1928    1....1  5060.891213: function:             rt_mutex_adjust_prio
stress-n-1928    1d..11  5060.891214: function:                __rt_mutex_adjust_prio
stress-n-1928    1....0  5060.891214: sys_exit:             NR 61 = 1931
stress-n-1928    1....0  5060.891215: sys_enter:            NR 101 (18, 78b, 0, 0, 17, 788)
stress-n-1928    1d..11  5060.891216: function:             __try_to_take_rt_mutex
stress-n-1928    1d..21  5060.891216: function:                rt_mutex_enqueue_pi
stress-n-1928    1d..21  5060.891217: function:             rt_mutex_dequeue_pi
stress-n-1928    1....1  5060.891217: function:             rt_mutex_adjust_prio
stress-n-1928    1d..11  5060.891218: function:                __rt_mutex_adjust_prio
stress-n-1928    1d.h10  5060.894114: local_timer_entry:    vector=239
stress-n-1928    1d.h20  5060.894115: hrtimer_cancel:       hrtimer=0xffff88012fc90d80
stress-n-1928    1d.h10  5060.894115: hrtimer_expire_entry: hrtimer=0xffff88012fc90d80 now=5061028000906 function=tick_sched_timer/0x0
stress-n-1928    1d.h20  5060.894116: sched_stat_runtime:   comm=stress-ng-ptrac pid=1928 runtime=2911118 [ns] vruntime=2068052618212 [ns]
stress-n-1928    1d.h10  5060.894118: softirq_raise:        vec=7 [action=SCHED]
stress-n-1928    1d.h10  5060.894118: softirq_raise:        vec=1 [action=TIMER]
stress-n-1928    1d.h10  5060.894119: rcu_utilization:      Start scheduler-tick
stress-n-1928    1d.h10  5060.894119: rcu_utilization:      End scheduler-tick
stress-n-1928    1d.h10  5060.894120: hrtimer_expire_exit:  hrtimer=0xffff88012fc90d80
stress-n-1928    1d.h20  5060.894120: hrtimer_start:        hrtimer=0xffff88012fc90d80 function=tick_sched_timer/0x0 expires=5061032000000 softexpires=5061032000000
stress-n-1928    1d.h10  5060.894121: local_timer_exit:     vector=239
stress-n-1928    1d..20  5060.894121: sched_waking:         comm=ksoftirqd/1 pid=18 prio=120 target_cpu=001
stress-n-1928    1d..30  5060.894122: sched_stat_sleep:     comm=ksoftirqd/1 pid=18 delay=3989353 [ns]
stress-n-1928    1d..30  5060.894123: sched_wakeup:         ksoftirqd/1:18 [120] success=1 CPU:001
stress-n-1928    1d..20  5060.894123: sched_waking:         comm=ktimersoftd/1 pid=17 prio=98 target_cpu=001
stress-n-1928    1dN.30  5060.894124: sched_wakeup:         ktimersoftd/1:17 [98] success=1 CPU:001
stress-n-1928    1.N.10  5060.894125: rcu_utilization:      Start context switch
stress-n-1928    1.N.10  5060.894125: rcu_utilization:      End context switch
stress-n-1928    1dN.20  5060.894126: sched_stat_runtime:   comm=stress-ng-ptrac pid=1928 runtime=7454 [ns] vruntime=2068052625666 [ns]
stress-n-1928    1d..20  5060.894127: sched_switch:         stress-ng-ptrac:1928 [120] R ==> ktimersoftd/1:17 [98]
ktimerso-17      1....1  5060.894128: softirq_entry:        vec=1 [action=TIMER]
ktimerso-17      1....1  5060.894129: softirq_exit:         vec=1 [action=TIMER]
ktimerso-17      1...10  5060.894129: rcu_utilization:      Start context switch
ktimerso-17      1...10  5060.894130: rcu_utilization:      End context switch
ktimerso-17      1d..20  5060.894131: sched_stat_wait:      comm=ksoftirqd/1 pid=18 delay=8463 [ns]
ktimerso-17      1d..20  5060.894131: sched_switch:         ktimersoftd/1:17 [98] S ==> ksoftirqd/1:18 [120]
ksoftirq-18      1....1  5060.894132: softirq_entry:        vec=7 [action=SCHED]
ksoftirq-18      1....1  5060.894133: softirq_exit:         vec=7 [action=SCHED]
ksoftirq-18      1...10  5060.894134: rcu_utilization:      Start context switch
ksoftirq-18      1...10  5060.894134: rcu_utilization:      End context switch
ksoftirq-18      1d..20  5060.894134: sched_stat_runtime:   comm=ksoftirqd/1 pid=18 runtime=4140 [ns] vruntime=8977334018960 [ns]
ksoftirq-18      1d..20  5060.894135: sched_stat_wait:      comm=stress-ng-ptrac pid=1928 delay=10680 [ns]
ksoftirq-18      1d..20  5060.894136: sched_switch:         ksoftirqd/1:18 [120] S ==> stress-ng-ptrac:1928 [120]
stress-n-1928    1d..20  5060.894137: sched_wait_task:      comm=stress-ng-ptrac pid=1931 prio=120
stress-n-1928    1....0  5060.894137: hrtimer_init:         hrtimer=0xffff8800c8043dc0 clockid=CLOCK_MONOTONIC mode=0x1
stress-n-1928    1d..10  5060.894137: hrtimer_start:        hrtimer=0xffff8800c8043dc0 function=hrtimer_wakeup/0x0 expires=5061032023604 softexpires=5061032023604
stress-n-1928    1...10  5060.894138: rcu_utilization:      Start context switch
stress-n-1928    1...10  5060.894138: rcu_utilization:      End context switch
stress-n-1928    1d..20  5060.894139: sched_stat_runtime:   comm=stress-ng-ptrac pid=1928 runtime=4271 [ns] vruntime=2068052629937 [ns]
stress-n-1928    1d..20  5060.894140: sched_stat_wait:      comm=stress-ng-ptrac pid=1932 delay=2933523 [ns]
stress-n-1928    1d..20  5060.894140: sched_switch:         stress-ng-ptrac:1928 [120] D ==> stress-ng-ptrac:1932 [120]
stress-n-1928    1d..20  5060.894141: tlb_flush:            pages=-1 reason=flush on task switch (0)
stress-n-1932    1...10  5060.894142: rcu_utilization:      Start context switch
stress-n-1932    1...10  5060.894142: rcu_utilization:      End context switch
stress-n-1932    1d..20  5060.894142: sched_stat_runtime:   comm=stress-ng-ptrac pid=1932 runtime=3690 [ns] vruntime=2068053567748 [ns]
stress-n-1932    1d..20  5060.894143: sched_switch:         stress-ng-ptrac:1932 [120] t|W ==> swapper/1:0 [120]
  <idle>-0       1d..10  5060.894145: cpu_idle:             state=1 cpu_id=1




cpu 0 and 1:

stress-n-1932    1d..20  5060.891207: sched_switch:         stress-ng-ptrac:1932 [120] R ==> stress-ng-ptrac:1928 [120]
stress-n-1927    0d..20  5060.891207: sched_stat_wait:      comm=stress-ng-ptrac pid=1930 delay=2013 [ns]
stress-n-1927    0d..20  5060.891207b: sched_switch:         stress-ng-ptrac:1927 [120] R ==> stress-ng-ptrac:1930 [120]
stress-n-1932    1d..20  5060.891207: tlb_flush:            pages=-1 reason=flush on task switch (0)
stress-n-1927    0d..20  5060.891208: tlb_flush:            pages=-1 reason=flush on task switch (0)
stress-n-1928    1d..11  5060.891208: function:             __try_to_take_rt_mutex
stress-n-1928    1d..11  5060.891208: function:                rt_mutex_dequeue
stress-n-1928    1d..21  5060.891209: function:                rt_mutex_enqueue_pi
stress-n-1928    1d..21  5060.891210: function:             rt_mutex_dequeue_pi
stress-n-1930    0d..11  5060.891210: function:             __try_to_take_rt_mutex
stress-n-1928    1d..11  5060.891210: sched_waking:         comm=stress-ng-ptrac pid=1931 prio=120 target_cpu=000
stress-n-1930    0d..21  5060.891211: function:                rt_mutex_enqueue_pi
stress-n-1930    0....2  5060.891211: signal_generate:      sig=17 errno=0 code=262148 comm=stress-ng-ptrac pid=1927 grp=1 res=1
stress-n-1928    1d..21  5060.891211: sched_stat_runtime:   comm=stress-ng-ptrac pid=1930 runtime=4893 [ns] vruntime=1977714640068 [ns]
stress-n-1930    0d..21  5060.891212: function:             rt_mutex_dequeue_pi
stress-n-1928    1d..21  5060.891212: sched_stat_blocked:   comm=stress-ng-ptrac pid=1931 delay=16421 [ns]
stress-n-1928    1d..21  5060.891213: sched_wakeup:         stress-ng-ptrac:1931 [120] success=1 CPU:000
stress-n-1928    1....1  5060.891213: function:             rt_mutex_adjust_prio
stress-n-1930    0....1  5060.891213: function:             rt_mutex_adjust_prio
stress-n-1928    1d..11  5060.891214: function:                __rt_mutex_adjust_prio
stress-n-1930    0d..11  5060.891214: function:                __rt_mutex_adjust_prio
stress-n-1930    0...10  5060.891214: rcu_utilization:      Start context switch
stress-n-1930    0...10  5060.891214: rcu_utilization:      End context switch
stress-n-1928    1....0  5060.891214: sys_exit:             NR 61 = 1931
stress-n-1930    0d..20  5060.891215: sched_stat_runtime:   comm=stress-ng-ptrac pid=1930 runtime=3639 [ns] vruntime=1977714643707 [ns]
stress-n-1928    1....0  5060.891215: sys_enter:            NR 101 (18, 78b, 0, 0, 17, 788)
stress-n-1928    1d..11  5060.891216: function:             __try_to_take_rt_mutex
stress-n-1930    0d..20  5060.891216: sched_stat_wait:      comm=stress-ng-ptrac pid=1931 delay=3639 [ns]
stress-n-1928    1d..21  5060.891216: function:                rt_mutex_enqueue_pi
stress-n-1930    0d..20  5060.891217: sched_switch:         stress-ng-ptrac:1930 [120] t|W ==> stress-ng-ptrac:1931 [120]
stress-n-1928    1d..21  5060.891217: function:             rt_mutex_dequeue_pi
stress-n-1930    0d..20  5060.891217: tlb_flush:            pages=-1 reason=flush on task switch (0)
stress-n-1928    1....1  5060.891217: function:             rt_mutex_adjust_prio
stress-n-1928    1d..11  5060.891218: function:                __rt_mutex_adjust_prio
stress-n-1931    0d..11  5060.891219: function:             __try_to_take_rt_mutex
stress-n-1931    0d..11  5060.891219: function:                rt_mutex_dequeue
stress-n-1931    0d..21  5060.891220: function:                rt_mutex_enqueue_pi
stress-n-1931    0....2  5060.891220: signal_generate:      sig=17 errno=0 code=262148 comm=stress-ng-ptrac pid=1928 grp=1 res=1
stress-n-1931    0d..21  5060.894114: function:             rt_mutex_dequeue_pi
stress-n-1928    1d.h10  5060.894114: local_timer_entry:    vector=239
stress-n-1931    0d.h11  5060.894115: local_timer_entry:    vector=239
stress-n-1928    1d.h20  5060.894115: hrtimer_cancel:       hrtimer=0xffff88012fc90d80
stress-n-1931    0d.h21  5060.894115: hrtimer_cancel:       hrtimer=0xffff8800c7fabe38
stress-n-1928    1d.h10  5060.894115: hrtimer_expire_entry: hrtimer=0xffff88012fc90d80 now=5061028000906 function=tick_sched_timer/0x0
stress-n-1931    0d.h11  5060.894115: hrtimer_expire_entry: hrtimer=0xffff8800c7fabe38 now=5061028001164 function=hrtimer_wakeup/0x0
stress-n-1931    0d.h21  5060.894116: sched_waking:         comm=jitterdebugger pid=2530 prio=19 target_cpu=000
stress-n-1928    1d.h20  5060.894116: sched_stat_runtime:   comm=stress-ng-ptrac pid=1928 runtime=2911118 [ns] vruntime=2068052618212 [ns]
stress-n-1931    0dNh31  5060.894117: sched_wakeup:         jitterdebugger:2530 [19] success=1 CPU:000
stress-n-1931    0dNh11  5060.894117: hrtimer_expire_exit:  hrtimer=0xffff8800c7fabe38
stress-n-1931    0dNh21  5060.894117: hrtimer_cancel:       hrtimer=0xffff88012fc10d80
