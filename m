Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754309AbeDMLPS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:15:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41418 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754045AbeDMLPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:15:16 -0400
Date: Fri, 13 Apr 2018 12:15:10 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20180413111510.GS14248@e110439-lin>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-2-patrick.bellasi@arm.com>
 <20180413084302.GR4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413084302.GR4043@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Apr 10:43, Peter Zijlstra wrote:
> On Mon, Apr 09, 2018 at 05:56:09PM +0100, Patrick Bellasi wrote:
> > +static inline void uclamp_task_update(struct rq *rq, struct task_struct *p)
> > +{
> > +	int cpu = cpu_of(rq);
> > +	int clamp_id;
> > +
> > +	/* The idle task does not affect CPU's clamps */
> > +	if (unlikely(p->sched_class == &idle_sched_class))
> > +		return;
> > +	/* DEADLINE tasks do not affect CPU's clamps */
> > +	if (unlikely(p->sched_class == &dl_sched_class))
> > +		return;
> > +
> > +	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> > +		if (uclamp_task_affects(p, clamp_id))
> > +			uclamp_cpu_put(p, cpu, clamp_id);
> > +		else
> > +			uclamp_cpu_get(p, cpu, clamp_id);
> > +	}
> > +}
> 
> Is that uclamp_task_affects() thing there to fix up the fact you failed
> to propagate the calling context (enqueue/dequeue) ?

Not really, it's intended by design: we back annotate the clamp_group
a task has been refcounted in.

The uclamp_task_affects() tells if we are refcounted now and then we
know from the back-annotation from which refcounter we need to remove
the task.

I found this solution much less racy and effective in avoiding to
screw up the refcounter whenever we look at a task at either
dequeue/migration time and these operations can overlaps with the
slow-path. Meaning, when we change the task specific clamp_group
either via syscall or cgroups attributes.

IOW, the back annotation allows to decouple refcounting from
clamp_group configuration in a lockless way.

> I find this code _really_ hard to read...

Hope the explanation above clarifies the logic... do you have
alternative proposals?

> > @@ -743,6 +929,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
> >  	if (!(flags & ENQUEUE_RESTORE))
> >  		sched_info_queued(rq, p);
> >  
> > +	uclamp_task_update(rq, p);
> >  	p->sched_class->enqueue_task(rq, p, flags);
> >  }
> >  
> > @@ -754,6 +941,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> >  	if (!(flags & DEQUEUE_SAVE))
> >  		sched_info_dequeued(rq, p);
> >  
> > +	uclamp_task_update(rq, p);
> >  	p->sched_class->dequeue_task(rq, p, flags);
> >  }
> >  

-- 
#include <best/regards.h>

Patrick Bellasi
