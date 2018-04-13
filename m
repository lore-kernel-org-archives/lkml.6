Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754726AbeDMLhE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:37:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36716 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbeDMLhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:37:02 -0400
Date: Fri, 13 Apr 2018 13:36:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 1/7] sched/core: uclamp: add CPU clamp groups accounting
Message-ID: <20180413113650.GR4064@hirez.programming.kicks-ass.net>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-2-patrick.bellasi@arm.com>
 <20180413084302.GR4043@hirez.programming.kicks-ass.net>
 <20180413111510.GS14248@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413111510.GS14248@e110439-lin>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 12:15:10PM +0100, Patrick Bellasi wrote:
> On 13-Apr 10:43, Peter Zijlstra wrote:
> > On Mon, Apr 09, 2018 at 05:56:09PM +0100, Patrick Bellasi wrote:
> > > +static inline void uclamp_task_update(struct rq *rq, struct task_struct *p)
> > > +{
> > > +	int cpu = cpu_of(rq);
> > > +	int clamp_id;
> > > +
> > > +	/* The idle task does not affect CPU's clamps */
> > > +	if (unlikely(p->sched_class == &idle_sched_class))
> > > +		return;
> > > +	/* DEADLINE tasks do not affect CPU's clamps */
> > > +	if (unlikely(p->sched_class == &dl_sched_class))
> > > +		return;
> > > +
> > > +	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> > > +		if (uclamp_task_affects(p, clamp_id))
> > > +			uclamp_cpu_put(p, cpu, clamp_id);
> > > +		else
> > > +			uclamp_cpu_get(p, cpu, clamp_id);
> > > +	}
> > > +}
> > 
> > Is that uclamp_task_affects() thing there to fix up the fact you failed
> > to propagate the calling context (enqueue/dequeue) ?
> 
> Not really, it's intended by design: we back annotate the clamp_group
> a task has been refcounted in.
> 
> The uclamp_task_affects() tells if we are refcounted now and then we
> know from the back-annotation from which refcounter we need to remove
> the task.
> 
> I found this solution much less racy and effective in avoiding to
> screw up the refcounter whenever we look at a task at either
> dequeue/migration time and these operations can overlaps with the
> slow-path. Meaning, when we change the task specific clamp_group
> either via syscall or cgroups attributes.
> 
> IOW, the back annotation allows to decouple refcounting from
> clamp_group configuration in a lockless way.

But it adds extra state and logic, to a fastpath, for no reason.

I suspect you messed up the cgroup side; because the syscall should
already have done task_rq_lock() and hold both p->pi_lock and rq->lock
and have dequeued the task when changing the attribute.

It is actually really hard to make the syscall do it wrong.
