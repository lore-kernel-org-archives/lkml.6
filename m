Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeDEApZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 20:45:25 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:34563 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752582AbeDEApY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 20:45:24 -0400
X-Google-Smtp-Source: AIpwx49OjMUnd4MUnX7I5tLVL2WvBOrY21bh95UsdKbxfr/HjQt8N/eh9vEQsaI/eagYHhKKp578zQ==
Date: Thu, 5 Apr 2018 10:45:12 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rcu_process_callbacks irqsoff latency caused by taking spinlock
 with irqs disabled
Message-ID: <20180405104512.25ada2bb@roar.ozlabs.ibm.com>
In-Reply-To: <20180405001358.GK3948@linux.vnet.ibm.com>
References: <20180405093414.2273203e@roar.ozlabs.ibm.com>
        <20180405001358.GK3948@linux.vnet.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018 17:13:58 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Thu, Apr 05, 2018 at 09:34:14AM +1000, Nicholas Piggin wrote:
> > Hi Paul,
> > 
> > Just looking at latencies, and RCU showed up as one of the maximums.
> > This is a 2 socket system with (176 CPU threads). Just doing a
> > `make -j 352` kernel build. Got a max latency of 3ms. I don't think
> > that's anything to worry about really, but I wanted to check the
> > cause.  
> 
> Well, that 3 milliseconds would cause serious problems for some workloads...

True.

> > # tracer: irqsoff
> > #
> > # irqsoff latency trace v1.1.5 on 4.16.0-01530-g43d1859f0994
> > # --------------------------------------------------------------------
> > # latency: 3055 us, #19/19, CPU#135 | (M:server VP:0, KP:0, SP:0 HP:0 #P:176)
> > #    -----------------
> > #    | task: cc1-58689 (uid:1003 nice:0 policy:0 rt_prio:0)
> > #    -----------------
> > #  => started at: rcu_process_callbacks
> > #  => ended at:   _raw_spin_unlock_irqrestore
> > #
> > #
> > #                  _------=> CPU#            
> > #                 / _-----=> irqs-off        
> > #                | / _----=> need-resched    
> > #                || / _---=> hardirq/softirq 
> > #                ||| / _--=> preempt-depth   
> > #                |||| /     delay            
> > #  cmd     pid   ||||| time  |   caller      
> > #     \   /      |||||  \    |   /         
> >    <...>-58689 135d.s.    0us : rcu_process_callbacks
> >    <...>-58689 135d.s.    1us : cpu_needs_another_gp <-rcu_process_callbacks
> >    <...>-58689 135d.s.    2us : rcu_segcblist_future_gp_needed <-cpu_needs_another_gp
> >    <...>-58689 135d.s.    3us#: _raw_spin_lock <-rcu_process_callbacks
> >    <...>-58689 135d.s. 3047us : rcu_start_gp <-rcu_process_callbacks
> >    <...>-58689 135d.s. 3048us : rcu_advance_cbs <-rcu_start_gp
> >    <...>-58689 135d.s. 3049us : rcu_segcblist_pend_cbs <-rcu_advance_cbs
> >    <...>-58689 135d.s. 3049us : rcu_segcblist_advance <-rcu_advance_cbs
> >    <...>-58689 135d.s. 3050us : rcu_accelerate_cbs <-rcu_start_gp
> >    <...>-58689 135d.s. 3050us : rcu_segcblist_pend_cbs <-rcu_accelerate_cbs
> >    <...>-58689 135d.s. 3051us : rcu_segcblist_accelerate <-rcu_accelerate_cbs
> >    <...>-58689 135d.s. 3052us : trace_rcu_future_gp.isra.0 <-rcu_accelerate_cbs
> >    <...>-58689 135d.s. 3052us : trace_rcu_future_gp.isra.0 <-rcu_accelerate_cbs
> >    <...>-58689 135d.s. 3053us : rcu_start_gp_advanced.isra.35 <-rcu_start_gp
> >    <...>-58689 135d.s. 3053us : cpu_needs_another_gp <-rcu_start_gp_advanced.isra.35
> >    <...>-58689 135d.s. 3054us : _raw_spin_unlock_irqrestore <-rcu_process_callbacks
> >    <...>-58689 135d.s. 3055us : _raw_spin_unlock_irqrestore
> >    <...>-58689 135d.s. 3056us : trace_hardirqs_on <-_raw_spin_unlock_irqrestore
> >    <...>-58689 135d.s. 3061us : <stack trace>
> > 
> > So it's taking a contende lock with interrupts disabled:
> > 
> > static void
> > __rcu_process_callbacks(struct rcu_state *rsp)
> > {
> >         unsigned long flags;
> >         bool needwake;
> >         struct rcu_data *rdp = raw_cpu_ptr(rsp->rda);
> > 
> >         WARN_ON_ONCE(!rdp->beenonline);
> > 
> >         /* Update RCU state based on any recent quiescent states. */
> >         rcu_check_quiescent_state(rsp, rdp);
> > 
> >         /* Does this CPU require a not-yet-started grace period? */
> >         local_irq_save(flags);
> >         if (cpu_needs_another_gp(rsp, rdp)) {
> >                 raw_spin_lock_rcu_node(rcu_get_root(rsp)); /* irqs disabled. */
> >                 needwake = rcu_start_gp(rsp);
> >                 raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(rsp), flags);
> >                 if (needwake)
> >                         rcu_gp_kthread_wake(rsp);
> >         } else {
> >                 local_irq_restore(flags);
> >         }
> > 
> > Because irqs are disabled before taking the lock, we can't spin with
> > interrupts enabled.
> > 
> > cpu_needs_another_gp needs interrupts off to prevent races with normal
> > callback registry, but that doesn't seem to be preventing any wider
> > races in this code, because we immediately re-enable interrupts anyway
> > if no gp is needed. So an interrupt can come in right after that and
> > queue something up.
> > 
> > So then the question is whether it's safe-albeit-racy to call with
> > interrupts ensabled? Would be nice to move it to a spin_lock_irqsave.  
> 
> If I recall correctly, the issue is that an unsynchronized (due to
> interrupts being enabled) check in the "if" statement can cause extra
> unneeded grace periods.

If the check is relatively cheap, perhaps you could do a second race
free verification after taking the lock and disabling interrupts?

> I am guessing that the long latency is caused by lots of CPUs suddenly
> needing a new grace period at about the same time.  If so, this is
> a bottleneck that I have been expecting for some time, and one that
> I would resolve by introducing funnel locking, sort of like SRCU and
> expedited grace periods already use.
> 
> Or am I confused about the source of the contention?

The irqsoff tracer doesn't give you a lot of detail about locking
and concurrency, so it's hard for me to say. Any particular tests
or details I could try to get, that would help?

Note that rcu doesn't show up consistently at the top, this was
just one that looked *maybe* like it can be improved. So I don't
know how reproducible it is.

Thanks,
Nick
