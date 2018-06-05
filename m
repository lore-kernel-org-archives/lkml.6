Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752329AbeFEPWD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:22:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57240 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbeFEPWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:22:01 -0400
Date: Tue, 5 Jun 2018 16:21:56 +0100
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
        Steve Muckle <smuckle@google.com>, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 2/2] sched/fair: util_est: add running_sum tracking
Message-ID: <20180605152156.GD32302@e110439-lin>
References: <20180604160600.22052-1-patrick.bellasi@arm.com>
 <20180604160600.22052-3-patrick.bellasi@arm.com>
 <20180604174618.GA222053@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604174618.GA222053@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-Jun 10:46, Joel Fernandes wrote:
> Hi Patrick,
> 
> On Mon, Jun 04, 2018 at 05:06:00PM +0100, Patrick Bellasi wrote:
> > The estimated utilization of a task is affected by the task being
> > preempted, either by another FAIR task of by a task of an higher
> > priority class (i.e. RT or DL). Indeed, when a preemption happens, the
> > PELT utilization of the preempted task is going to be decayed a bit.
> > That's actually correct for utilization, which goal is to measure the
> > actual CPU bandwidth consumed by a task.
> > 
> > However, the above behavior does not allow to know exactly what is the
> > utilization a task "would have used" if it was running without
> > being preempted. Thus, this reduces the effectiveness of util_est for a
> > task because it does not always allow to predict how much CPU a task is
> > likely to require.
> > 
> > Let's improve the estimated utilization by adding a new "sort-of" PELT
> > signal, explicitly only for SE which has the following behavior:
> >  a) at each enqueue time of a task, its value is the (already decayed)
> >     util_avg of the task being enqueued
> >  b) it's updated at each update_load_avg
> >  c) it can just increase, whenever the task is actually RUNNING on a
> >     CPU, while it's kept stable while the task is RUNNANBLE but not
> >     actively consuming CPU bandwidth
> > 
> > Such a defined signal is exactly equivalent to the util_avg for a task
> > running alone on a CPU while, in case the task is preempted, it allows
> > to know at dequeue time how much would have been the task utilization if
> > it was running alone on that CPU.
> > 
> > This new signal is named "running_avg", since it tracks the actual
> > RUNNING time of a task by ignoring any form of preemption.
> > 
> > From an implementation standpoint, since the sched_avg should fit into a
> > single cache line, we save space by tracking only a new runnable sum:
> >    p->se.avg.running_sum
> > while the conversion into a running_avg is done on demand whenever we
> > need it, which is at task dequeue time when a new util_est sample has to
> > be collected.
> > 
> > The conversion from "running_sum" to "running_avg" is done by performing
> > a single division by LOAD_AVG_MAX, which introduces a small error since
> > in the division we do not consider the (sa->period_contrib - 1024)
> > compensation factor used in ___update_load_avg(). However:
> >  a) this error is expected to be limited (~2-3%)
> >  b) it can be safely ignored since the estimated utilization is the only
> >     consumer which is already subject to small estimation errors
> > 
> > The additional corresponding benefit is that, at run-time, we pay the
> > cost for a additional sum and multiply, while the more expensive
> > division is required only at dequeue time.
> > 
> > Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Joel Fernandes <joelaf@google.com>
> > Cc: Steve Muckle <smuckle@google.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---
> >  include/linux/sched.h |  1 +
> >  kernel/sched/fair.c   | 16 ++++++++++++++--
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 9d8732dab264..2bd5f1c68da9 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -399,6 +399,7 @@ struct sched_avg {
> >  	u64				load_sum;
> >  	u64				runnable_load_sum;
> >  	u32				util_sum;
> > +	u32				running_sum;
> >  	u32				period_contrib;
> >  	unsigned long			load_avg;
> >  	unsigned long			runnable_load_avg;
> 
> Should update the documentation comments above the struct too?
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index f74441be3f44..5d54d6a4c31f 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3161,6 +3161,8 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
> >  		sa->runnable_load_sum =
> >  			decay_load(sa->runnable_load_sum, periods);
> >  		sa->util_sum = decay_load((u64)(sa->util_sum), periods);
> > +		if (running)
> > +			sa->running_sum = decay_load(sa->running_sum, periods);
> >  
> >  		/*
> >  		 * Step 2
> > @@ -3176,8 +3178,10 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
> >  		sa->load_sum += load * contrib;
> >  	if (runnable)
> >  		sa->runnable_load_sum += runnable * contrib;
> > -	if (running)
> > +	if (running) {
> >  		sa->util_sum += contrib * scale_cpu;
> > +		sa->running_sum += contrib * scale_cpu;
> > +	}
> >  
> >  	return periods;
> >  }
> > @@ -3963,6 +3967,12 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
> >  	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
> >  }
> 
> PELT changes look nice and makes sense :)

That's not strictly speaking a PELT change... it's still more in the
idea to work "on top of PELT" to make it more effective in measuring
the tasks expected required CPU bandwidth.

> > +static inline void util_est_enqueue_running(struct task_struct *p)
> > +{
> > +	/* Initilize the (non-preempted) utilization */
> > +	p->se.avg.running_sum = p->se.avg.util_sum;
> > +}
> > +
> >  /*
> >   * Check if a (signed) value is within a specified (unsigned) margin,
> >   * based on the observation that:
> > @@ -4018,7 +4028,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
> >  	 * Skip update of task's estimated utilization when its EWMA is
> >  	 * already ~1% close to its last activation value.
> >  	 */
> > -	ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
> > +	ue.enqueued = p->se.avg.running_sum / LOAD_AVG_MAX;
> 
> I guess we are doing extra division here which adds some cost. Does
> performance look Ok with the change?

This extra division is there and done only at dequeue time instead of
doing it at each update_load_avg.

To be more precise, at each ___update_load_avg we should really update
running_avg by:

   u32 divider = LOAD_AVG_MAX - 1024 + sa->period_contrib;
   sa->running_avg = sa->running_sum / divider;

but, this would imply tracking an additional signal in sched_avg and
doing an additional division at ___update_load_avg() time.

Morten suggested that, if we accept the rounding errors due to
considering

      divider ~= LOAD_AVG_MAX

thus discarding the (sa->period_contrib - 1024) correction, then we
can completely skip the tracking of running_avg (thus saving space in
sched_avg) and approximate it at dequeue time as per the code line,
just to compute the new util_est sample to accumulate.

Does that make sense now?

-- 
#include <best/regards.h>

Patrick Bellasi
