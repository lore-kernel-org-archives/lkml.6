Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeDEHoR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 03:44:17 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:36624 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDEHoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 03:44:16 -0400
X-Google-Smtp-Source: AIpwx4/aFLYHXE0q2Q2mcJAAuQcc7VYDg3a+LZrwL5IuFt6TXTAdkktzqjYk1XFVG7OTS0RWqaGlZg==
Date: Thu, 5 Apr 2018 17:44:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: sched_rt_period_timer causing large latencies
Message-ID: <20180405174405.175008c7@roar.ozlabs.ibm.com>
In-Reply-To: <1522910817.8945.1.camel@gmx.de>
References: <20180405091138.6ef14d15@roar.ozlabs.ibm.com>
        <1522910817.8945.1.camel@gmx.de>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Apr 2018 08:46:57 +0200
Mike Galbraith <efault@gmx.de> wrote:

> On Thu, 2018-04-05 at 09:11 +1000, Nicholas Piggin wrote:
> > Hi,
> > 
> > I'm seeing some pretty big latencies on a ~idle system when a CPU wakes
> > out of a nohz idle. Looks like it's due to the taking a lot of remote
> > locks and cache lines. irqoff trace:
> > 
> > latency: 407 us, #608/608, CPU#3 | (M:server VP:0, KP:0, SP:0 HP:0 #P:176)
> > 
> >   <idle>-0       3d...    0us : decrementer_common
> >   <idle>-0       3d...    1us : timer_interrupt <-decrementer_common
> >   <idle>-0       3d...    2us : irq_enter <-timer_interrupt
> >   <idle>-0       3d...    2us : rcu_irq_enter <-irq_enter
> >   <idle>-0       3d...    3us : rcu_nmi_enter <-irq_enter
> >   <idle>-0       3d...    4us : rcu_dynticks_eqs_exit <-rcu_nmi_enter
> >   <idle>-0       3d...    4us : __local_bh_disable_ip <-irq_enter
> >   <idle>-0       3d...    5us : tick_irq_enter <-irq_enter
> >   <idle>-0       3d...    6us : tick_check_oneshot_broadcast_this_cpu <-tick_irq_enter
> >   <idle>-0       3d...    6us : ktime_get <-tick_irq_enter
> >   <idle>-0       3d...    7us : update_ts_time_stats <-tick_irq_enter
> >   <idle>-0       3d...    8us : nr_iowait_cpu <-update_ts_time_stats
> >   <idle>-0       3d...    9us : _local_bh_enable <-irq_enter
> >   <idle>-0       3d...   10us : __local_bh_enable <-irq_enter
> >   <idle>-0       3d.h.   10us : __timer_interrupt <-timer_interrupt
> >   <idle>-0       3d.h.   11us : hrtimer_interrupt <-__timer_interrupt
> >   <idle>-0       3d.h.   12us : _raw_spin_lock_irqsave <-hrtimer_interrupt
> >   <idle>-0       3d.h.   13us : ktime_get_update_offsets_now <-hrtimer_interrupt
> >   <idle>-0       3d.h.   13us : __hrtimer_run_queues <-hrtimer_interrupt
> >   <idle>-0       3d.h.   14us : __remove_hrtimer <-__hrtimer_run_queues
> >   <idle>-0       3d.h.   15us : _raw_spin_unlock_irqrestore <-__hrtimer_run_queues
> >   <idle>-0       3d.h.   16us : tick_sched_timer <-__hrtimer_run_queues
> >   <idle>-0       3d.h.   16us : ktime_get <-tick_sched_timer
> >   <idle>-0       3d.h.   17us : tick_sched_do_timer <-tick_sched_timer
> >   <idle>-0       3d.h.   18us : tick_sched_handle.isra.5 <-tick_sched_timer
> >   <idle>-0       3d.h.   19us : update_process_times <-tick_sched_handle.isra.5
> >   <idle>-0       3d.h.   19us : account_process_tick <-update_process_times
> >   <idle>-0       3d.h.   20us : run_local_timers <-update_process_times
> >   <idle>-0       3d.h.   21us : hrtimer_run_queues <-run_local_timers
> >   <idle>-0       3d.h.   21us : raise_softirq <-run_local_timers
> >   <idle>-0       3d.h.   22us : __raise_softirq_irqoff <-raise_softirq
> >   <idle>-0       3d.h.   23us : rcu_check_callbacks <-update_process_times
> >   <idle>-0       3d.h.   24us : rcu_sched_qs <-rcu_check_callbacks
> >   <idle>-0       3d.h.   25us : rcu_bh_qs <-rcu_check_callbacks
> >   <idle>-0       3d.h.   25us : rcu_segcblist_ready_cbs <-rcu_check_callbacks
> >   <idle>-0       3d.h.   26us : cpu_needs_another_gp <-rcu_check_callbacks
> >   <idle>-0       3d.h.   27us : invoke_rcu_core <-rcu_check_callbacks
> >   <idle>-0       3d.h.   28us : raise_softirq <-invoke_rcu_core
> >   <idle>-0       3d.h.   28us : __raise_softirq_irqoff <-raise_softirq
> >   <idle>-0       3d.h.   29us : scheduler_tick <-update_process_times
> >   <idle>-0       3d.h.   30us : _raw_spin_lock <-scheduler_tick
> >   <idle>-0       3d.h.   31us : update_rq_clock <-scheduler_tick
> >   <idle>-0       3d.h.   31us : task_tick_idle <-scheduler_tick
> >   <idle>-0       3d.h.   32us : cpu_load_update_active <-scheduler_tick
> >   <idle>-0       3d.h.   33us : tick_nohz_tick_stopped <-cpu_load_update_active
> >   <idle>-0       3d.h.   33us : cpu_load_update <-scheduler_tick
> >   <idle>-0       3d.h.   34us : sched_avg_update <-cpu_load_update
> >   <idle>-0       3d.h.   35us : calc_global_load_tick <-scheduler_tick
> >   <idle>-0       3d.h.   36us : trigger_load_balance <-scheduler_tick
> >   <idle>-0       3d.h.   36us : raise_softirq <-trigger_load_balance
> >   <idle>-0       3d.h.   37us : __raise_softirq_irqoff <-raise_softirq
> >   <idle>-0       3d.h.   38us : run_posix_cpu_timers <-update_process_times
> >   <idle>-0       3d.h.   39us : profile_tick <-tick_sched_handle.isra.5
> >   <idle>-0       3d.h.   39us : hrtimer_forward <-tick_sched_timer
> >   <idle>-0       3d.h.   40us : _raw_spin_lock_irq <-__hrtimer_run_queues
> >   <idle>-0       3d.h.   41us : enqueue_hrtimer <-__hrtimer_run_queues
> >   <idle>-0       3d.h.   42us : __remove_hrtimer <-__hrtimer_run_queues
> >   <idle>-0       3d.h.   42us : _raw_spin_unlock_irqrestore <-__hrtimer_run_queues
> >   <idle>-0       3d.h.   44us : sched_rt_period_timer <-__hrtimer_run_queues
> >   <idle>-0       3d.h.   44us : _raw_spin_lock <-sched_rt_period_timer
> >   <idle>-0       3d.h.   45us : ktime_get <-sched_rt_period_timer
> >   <idle>-0       3d.h.   46us : hrtimer_forward <-sched_rt_period_timer
> >   <idle>-0       3d.h.   47us : _raw_spin_lock <-sched_rt_period_timer
> >   <idle>-0       3d.h.   48us : _raw_spin_lock <-sched_rt_period_timer
> >   ... 527 more locks snipped ...
> >   <idle>-0       3d.h.  403us : ktime_get <-sched_rt_period_timer
> >   <idle>-0       3d.h.  403us : hrtimer_forward <-sched_rt_period_timer
> >   <idle>-0       3d.h.  404us : _raw_spin_lock_irq <-__hrtimer_run_queues
> >   <idle>-0       3d.h.  404us : __hrtimer_get_next_event <-hrtimer_interrupt
> >   <idle>-0       3d.h.  404us : __hrtimer_next_event_base <-__hrtimer_get_next_event
> >   <idle>-0       3d.h.  405us : __hrtimer_next_event_base <-hrtimer_interrupt
> >   <idle>-0       3d.h.  405us : _raw_spin_unlock_irqrestore <-hrtimer_interrupt
> >   <idle>-0       3d.h.  405us : tick_program_event <-hrtimer_interrupt
> >   <idle>-0       3d.h.  406us : clockevents_program_event <-tick_program_event
> >   <idle>-0       3d.h.  406us : ktime_get <-clockevents_program_event
> >   <idle>-0       3d.h.  406us : decrementer_set_next_event <-clockevents_program_event
> >   <idle>-0       3d.h.  407us : irq_exit <-timer_interrupt
> >   <idle>-0       3d...  407us : __do_softirq <-irq_exit
> >   <idle>-0       3d...  407us : __local_bh_disable_ip <-__do_softirq
> >   <idle>-0       3d.s.  408us : __do_softirq
> >   <idle>-0       3d.s.  408us : trace_hardirqs_on <-__do_softirq
> >   <idle>-0       3d.s.  411us : <stack trace>
> > 
> > This is only a 2 socket system with 176 CPUs, so not huge or extreme
> > remote latency. I suspect this contributes to significantly higher
> > occasional latency spikes when it hits some runqueue lock contention.
> > 
> > Any way this can be improved? Any config options or settings should be
> > changed?  
> 
> Settings wise, you probably want skew_tick=1 on the commandline or in
> your .config CONFIG_CMDLINE.

Hey, thanks for the suggestion I'll give it a test.

> My method of dealing with the throttle beast from hell for ~big box RT
> is to stomp it flat during boot, as otherwise jitter is awful.

How do you stomp it flat?

If there could be some basic detection for throttling on a per-CPU
basis before invoking the best from hell, would that be possible to
move this out of normal paths?

Alternatively I think most/all of the RT runtime is coming from
kernel threads, could they be exempted so this doesn't hit? Although
it would be sad to suddenly inflict these latencies on someone who
starts up an RT program :)

I guess this is a lot of CPUs mainly due to SMT4, but everyone's
slowly going up. Intel, ARM, AMD all increasing cores and threads
quite steadily in average servers.

I accept defaults for average desktop/workstation is fine though...
Maybe a CONFIG_ option for it? (Just because some environments are
adverse to adding command line options for some reason)

Thanks,
Nick
