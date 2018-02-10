Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbeBJK3O (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 05:29:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbeBJK3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 05:29:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B3F21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Sat, 10 Feb 2018 11:29:09 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 4/6] sched/isolation: Residual 1Hz scheduler tick offload
Message-ID: <20180210102908.GC14047@lerouge>
References: <1518112779-30196-1-git-send-email-frederic@kernel.org>
 <1518112779-30196-5-git-send-email-frederic@kernel.org>
 <20180209071612.uubujtfjxidrad5r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209071612.uubujtfjxidrad5r@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 08:16:12AM +0100, Ingo Molnar wrote:
> 
> * Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> > When a CPU runs in full dynticks mode, a 1Hz tick remains in order to
> > keep the scheduler stats alive. However this residual tick is a burden
> > for bare metal tasks that can't stand any interruption at all, or want
> > to minimize them.
> > 
> > The usual boot parameters "nohz_full=" or "isolcpus=nohz" will now
> > outsource these scheduler ticks to the global workqueue so that a
> > housekeeping CPU handles those remotely. The sched_class::task_tick()
> > implementations have been audited and look safe to be called remotely
> > as the target runqueue and its current task are passed in parameter
> > and don't seem to be accessed locally.
> > 
> > Note that in the case of using isolcpus, it's still up to the user to
> > affine the global workqueues to the housekeeping CPUs through
> > /sys/devices/virtual/workqueue/cpumask or domains isolation
> > "isolcpus=nohz,domain".
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Chris Metcalf <cmetcalf@mellanox.com>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Luiz Capitulino <lcapitulino@redhat.com>
> > Cc: Mike Galbraith <efault@gmx.de>
> > Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Rik van Riel <riel@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Wanpeng Li <kernellwp@gmail.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > ---
> >  kernel/sched/core.c      | 91 +++++++++++++++++++++++++++++++++++++++++++++++-
> >  kernel/sched/isolation.c |  4 +++
> >  kernel/sched/sched.h     |  2 ++
> >  3 files changed, 96 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index fc9fa25..5c0e8b6 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3120,7 +3120,94 @@ u64 scheduler_tick_max_deferment(void)
> >  
> >  	return jiffies_to_nsecs(next - now);
> >  }
> > -#endif
> > +
> > +struct tick_work {
> > +	int			cpu;
> > +	struct delayed_work	work;
> > +};
> > +
> > +static struct tick_work __percpu *tick_work_cpu;
> > +
> > +static void sched_tick_remote(struct work_struct *work)
> > +{
> > +	struct delayed_work *dwork = to_delayed_work(work);
> > +	struct tick_work *twork = container_of(dwork, struct tick_work, work);
> > +	int cpu = twork->cpu;
> > +	struct rq *rq = cpu_rq(cpu);
> > +	struct rq_flags rf;
> > +
> > +	/*
> > +	 * Handle the tick only if it appears the remote CPU is running
> > +	 * in full dynticks mode. The check is racy by nature, but
> > +	 * missing a tick or having one too much is no big deal.
> 
> I'd suggest pointing out why it's no big deal:
> 
> 	 * missing a tick or having one too much is no big deal,
>          * because the scheduler tick updates statistics and checks
> 	 * timeslices in a time-independent way, regardless of when
> 	 * exactly it is running.
> 
> > +	 */
> > +	if (!idle_cpu(cpu) && tick_nohz_tick_stopped_cpu(cpu)) {
> > +		struct task_struct *curr;
> > +		u64 delta;
> > +
> > +		rq_lock_irq(rq, &rf);
> > +		update_rq_clock(rq);
> > +		curr = rq->curr;
> > +		delta = rq_clock_task(rq) - curr->se.exec_start;
> > +		/* Make sure we tick in a reasonable amount of time */
> > +		WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
> 
> 
> Please add a newline before the comment, and I'd also suggest this wording:
> 
> 		/* Make sure the next tick runs within a reasonable amount of time: */
> 
> > +	/*
> > +	 * Perform remote tick every second. The arbitrary frequence is
> > +	 * large enough to avoid overload and short enough to keep sched
> > +	 * internal stats alive.
> > +	 */
> > +	queue_delayed_work(system_unbound_wq, dwork, HZ);
> > +}
> 
> Typo. I'd also suggest somewhat clearer wording:
> 
> 	/*
> 	 * Run the remote tick once per second (1Hz). This arbitrary
> 	 * frequency is large enough to avoid overload but short enough
> 	 * to keep scheduler internal stats reasonably up to date.
> 	 */
> 
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +static void sched_tick_stop(int cpu)
> > +{
> > +	struct tick_work *twork;
> > +
> > +	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
> > +		return;
> > +
> > +	WARN_ON_ONCE(!tick_work_cpu);
> > +
> > +	twork = per_cpu_ptr(tick_work_cpu, cpu);
> > +	cancel_delayed_work_sync(&twork->work);
> > +}
> > +#endif /* CONFIG_HOTPLUG_CPU */
> > +
> > +int __init sched_tick_offload_init(void)
> > +{
> > +	tick_work_cpu = alloc_percpu(struct tick_work);
> > +	if (!tick_work_cpu) {
> > +		pr_err("Can't allocate remote tick struct\n");
> > +		return -ENOMEM;
> 
> Printing a warning is not enough. If tick_work_cpu ends up being NULL, then the 
> tick will crash AFAICS, due to:
> 
>   > +	twork = per_cpu_ptr(tick_work_cpu, cpu);
>   > +	cancel_delayed_work_sync(&twork->work);
> 
> ... it's much better to crash straight away - i.e. we should use panic().
> 
> > +#else
> > +static void sched_tick_start(int cpu) { }
> > +static void sched_tick_stop(int cpu) { }
> > +#endif /* CONFIG_NO_HZ_FULL */
> 
> So if we are using #if/else/endif markers, please use them in the #else branch 
> when it's so short, where they are actually useful:
> 
> > +#else /* !CONFIG_NO_HZ_FULL: */
> > +static void sched_tick_start(int cpu) { }
> > +static void sched_tick_stop(int cpu) { }
> > +#endif
> 
> (also note the inversion)

Ok for everything there, I'll fix.

Thanks!
