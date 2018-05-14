Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755119AbeENQcN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:32:13 -0400
Received: from foss.arm.com ([217.140.101.70]:46190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753569AbeENQcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:32:11 -0400
Date: Mon, 14 May 2018 17:32:06 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 3/3] sched/fair: schedutil: explicit update only when
 required
Message-ID: <20180514163206.GF30654@e110439-lin>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-4-patrick.bellasi@arm.com>
 <20180513060443.GB64158@joelaf.mtv.corp.google.com>
 <20180513062538.GA116730@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180513062538.GA116730@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-May 23:25, Joel Fernandes wrote:
> On Sat, May 12, 2018 at 11:04:43PM -0700, Joel Fernandes wrote:
> > On Thu, May 10, 2018 at 04:05:53PM +0100, Patrick Bellasi wrote:
> > > Schedutil updates for FAIR tasks are triggered implicitly each time a
> > > cfs_rq's utilization is updated via cfs_rq_util_change(), currently
> > > called by update_cfs_rq_load_avg(), when the utilization of a cfs_rq has
> > > changed, and {attach,detach}_entity_load_avg().
> > > 
> > > This design is based on the idea that "we should callback schedutil
> > > frequently enough" to properly update the CPU frequency at every
> > > utilization change. However, such an integration strategy has also
> > > some downsides:
> > 
> > Hi Patrick,

Hi Joel,

> > I agree making the call explicit would make schedutil integration easier so
> > that's really awesome. However I also fear that if some path in the fair
> > class in the future changes the utilization but forgets to update schedutil
> > explicitly (because they forgot to call the explicit public API) then the
> > schedutil update wouldn't go through. In this case the previous design of
> > doing the schedutil update in the wrapper kind of was a nice to have

I cannot see right now other possible future paths where we can
actually change the utilization signal without considering that,
eventually, we should call an existing API to update schedutil if it
makes sense.

What I can see more likely instead, also because it already happened a
couple of time, is that because of code changes in fair.c we end up
calling (implicitly) schedutil with a wrong utilization value.

To note this kind of broken dependency it has already been more
difficult than possibly noticing an update of the utilization without
a corresponding explicit call of the public API.

> > Just thinking out loud but is there a way you could make the implicit call
> > anyway incase the explicit call wasn't requested for some reason? That's
> > probably hard to do correctly though..
> > 
> > Some more comments below:
> > 

[...]

> > > 
> > >  - it makes it hard to integrate new features since it could require to
> > >    change other function prototypes just to pass in an additional flag,
> > >    as it happened for example in commit:
> > > 
> > >       ea14b57e8a18 ("sched/cpufreq: Provide migration hint")

IMHO, the point above is also a good example of how convoluted is
to add support for one new simple feature because of the current
implicit updates.

[...]

> > > @@ -4028,13 +4000,12 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> > >  
> > >  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
> > >  {
> > > -	cfs_rq_util_change(cfs_rq, 0);
> > 
> > How about kill that extra line by doing:
> > 
> > static inline void update_load_avg(struct cfs_rq *cfs_rq,
> > 				   struct sched_entity *se, int not_used1) {}
> > 
> > >  }

Right, that could make sense, thanks!

[...]

> > > @@ -5397,9 +5366,27 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >  		update_cfs_group(se);
> > >  	}
> > >  
> > > -	if (!se)
> > > +	/* The task is visible from the root cfs_rq */
> > > +	if (!se) {
> > > +		unsigned int flags = 0;
> > > +
> > >  		add_nr_running(rq, 1);
> > >  
> > > +		if (p->in_iowait)
> > > +			flags |= SCHED_CPUFREQ_IOWAIT;
> > > +
> > > +		/*
> > > +		 * !last_update_time means we've passed through
> > > +		 * migrate_task_rq_fair() indicating we migrated.
> > > +		 *
> > > +		 * IOW we're enqueueing a task on a new CPU.
> > > +		 */
> > > +		if (!p->se.avg.last_update_time)
> > > +			flags |= SCHED_CPUFREQ_MIGRATION;
> > > +
> > > +		cpufreq_update_util(rq, flags);
> > > +	}
> > > +
> > >  	hrtick_update(rq);
> > >  }
> > >  
> > > @@ -5456,10 +5443,12 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >  		update_cfs_group(se);
> > >  	}
> > >  
> > > +	/* The task is no more visible from the root cfs_rq */
> > >  	if (!se)
> > >  		sub_nr_running(rq, 1);
> > >  
> > >  	util_est_dequeue(&rq->cfs, p, task_sleep);
> > > +	cpufreq_update_util(rq, 0);
> > 
> > One question about this change. In enqueue, throttle and unthrottle - you are
> > conditionally calling cpufreq_update_util incase the task was
> > visible/not-visible in the hierarchy.
> > 
> > But in dequeue you're unconditionally calling it. Seems a bit inconsistent.
> > Is this because of util_est or something? Could you add a comment here
> > explaining why this is so?
> 
> The big question I have is incase se != NULL, then its still visible at the
> root RQ level.

My understanding it that you get !se at dequeue time when we are
dequeuing a task from a throttled RQ. Isn't it?

Thus, this means you are dequeuing a throttled task, I guess for
example because of a migration.
However, the point is that a task dequeue from a throttled RQ _is
already_ not visible from the root RQ, because of the sub_nr_running()
done by throttle_cfs_rq().

> In that case should we still call the util_est_dequeue and the
> cpufreq_update_util?

I had a better look at the different code paths and I've possibly come
up with some interesting observations. Lemme try to resume theme here.

First of all, we need to distinguish from estimated utilization
updates and schedutil updates, since they respond to two very
different goals.


.:: Estimated utilization updates
=================================

Goal: account for the amount of utilization we are going to
      expect on a CPU

At {en,de}queue time, util_est_{en,de}queue() is always
unconditionally called because it tracks the utilization which is
estimated to be generated by all the RUNNABLE tasks.

We do not care about throttled/un-throttled RQ here because the effect
of throttling is already folded into the estimated utilization.

For example, a 100% tasks which is placed into a 50% bandwidth
limited TG will generate a 50% (estimated) utilization. Thus, when the
task is enqueued we can account immediately for that utilization
although the RQ can be currently throttled.


.:: Schedutil updates
=====================

Goal: select a better frequency, if and _when_ required

At enqueue time, if the task is visible at the root RQ the it's
expected to run within a scheduler latency period. Thus, it makes
sense to call immediately schedutil to account for its estimated
utilization to possibly increase the OPP.

If instead the task is enqueued into a throttled RQ, then I'm
skipping the update since the task will not run until the RQ is
actually un-throttled.

HOWEVER, I would say that in general we could skip this last
optimization and always unconditionally update schedutil at enqueue
time considering the fact that the effects of a throttled RQ are
always reflected into the (estimated) utilization of a task.

At dequeue time instead, since we certainly removed some estimated
utilization, then I unconditionally updated schedutil.

HOWEVER, I was not considering these two things:

1. for a task going to sleep, we still have its blocked utilization
   accounted in the cfs_rq utilization.

2. for a task being migrated, at dequeue time we still have not
   removed the task's utilization from the cfs_rq's utilization.
   This usually happens later, for example we can have:

      move_queued_task()
         dequeue_task()                      --> CFS task dequeued
         set_task_cpu()                         --> schedutil updated
            migrate_task_rq_fair()
               detach_entity_cfs_rq()
                  detach_entity_load_avg()   --> CFS util removal
         enqueue_task()

Moreover, the "CFS util removal" actually affects the cfs_rq only if
we hold the RQ lock, otherwise we know that it's just back annotated
as "removed" utilization and the actual cfs_rq utilization is fixed up
at the next chance we have the RQ lock.

Thus, I would say that in both cases, at dequeue time it does not make
sense to update schedutil since we always see the task's utilization
in the cfs_rq and thus we will not reduce the frequency.

NOTE, this is true independently from the refactoring I'm proposing.
At dequeue time, although we call update_load_avg() on the root RQ,
it does not make sense to update schedutil since we still see either
the blocked utilization of a sleeping task or the not yet removed
utilization of a migrating task. In both cases the risk is to ask for
an higher OPP right when a CPU is going to be IDLE.

Moreover, it seems that in general we prefer a "conservative" approach
in frequency reduction.
For example it could be harmful to trigger a frequency reduction when
a task is migrating off a CPU, if right after another task should be
instead migrated into the same CPU.


.:: Conclusions
===============

All that considered, I think I've convinced myself that we really need
to notify schedutil only in these cases:

 1. enqueue time
    because of the changes in estimated utilization and the
    possibility to just straight to a better OPP

 2. task tick time
    because of the possible ramp-up of the utilization

Another case is related to remote CPUs blocked utilization update,
after the recent Vincent's patches. Currently indeed:

  update_blocked_averages()
     update_load_avg()
        --> update schedutil

and thus, potentially we wake up an IDLE cluster just to reduce its
OPP. If the cluster is in a deep idle state, I'm not entirely sure
this is good from an energy saving standpoint.
However, with the patch I'm proposing we are missing that support,
meaning that an IDLE cluster will get its utilization decayed but we
don't wake it up just to drop its frequency.

Perhaps we should better pass in this information to schedutil via a
flag (e.g. SCHED_FREQ_REMOTE_UPDATE) and implement there a policy to
decide if and when it makes sense to drop the OPP. Or otherwise find a
way for the special DL tasks to always run on the lower capacity_orig
CPUs.

> Sorry if I missed something obvious.

Thanks for the question it has actually triggered a better analysis of
what we have and what we need.

Looking forward to some feedbacks about the above before posting a new
version of this last patch.

> thanks!
> 
> - Joel

-- 
#include <best/regards.h>

Patrick Bellasi
