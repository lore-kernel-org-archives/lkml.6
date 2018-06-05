Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeFETdV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:33:21 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33255 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeFETdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:33:19 -0400
X-Google-Smtp-Source: ADUXVKJEESrb+xOQIN5QO0teP62sUf6QDN58GsicNtgH4xOEQAIP0dd+2wrsTT6siD/5t2ZlXBbXvA==
Date: Tue, 5 Jun 2018 12:33:17 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
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
Message-ID: <20180605193317.GA239272@joelaf.mtv.corp.google.com>
References: <20180604160600.22052-1-patrick.bellasi@arm.com>
 <20180604160600.22052-3-patrick.bellasi@arm.com>
 <20180604174618.GA222053@joelaf.mtv.corp.google.com>
 <20180605152156.GD32302@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605152156.GD32302@e110439-lin>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 04:21:56PM +0100, Patrick Bellasi wrote:
[..]
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index f74441be3f44..5d54d6a4c31f 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -3161,6 +3161,8 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
> > >  		sa->runnable_load_sum =
> > >  			decay_load(sa->runnable_load_sum, periods);
> > >  		sa->util_sum = decay_load((u64)(sa->util_sum), periods);
> > > +		if (running)
> > > +			sa->running_sum = decay_load(sa->running_sum, periods);
> > >  
> > >  		/*
> > >  		 * Step 2
> > > @@ -3176,8 +3178,10 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
> > >  		sa->load_sum += load * contrib;
> > >  	if (runnable)
> > >  		sa->runnable_load_sum += runnable * contrib;
> > > -	if (running)
> > > +	if (running) {
> > >  		sa->util_sum += contrib * scale_cpu;
> > > +		sa->running_sum += contrib * scale_cpu;
> > > +	}
> > >  
> > >  	return periods;
> > >  }
> > > @@ -3963,6 +3967,12 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
> > >  	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
> > >  }
> > 
> > PELT changes look nice and makes sense :)
> 
> That's not strictly speaking a PELT change... it's still more in the
> idea to work "on top of PELT" to make it more effective in measuring
> the tasks expected required CPU bandwidth.

I meant "PELT change" as in change to the code that calculates PELT signals..

> > > +static inline void util_est_enqueue_running(struct task_struct *p)
> > > +{
> > > +	/* Initilize the (non-preempted) utilization */
> > > +	p->se.avg.running_sum = p->se.avg.util_sum;
> > > +}
> > > +
> > >  /*
> > >   * Check if a (signed) value is within a specified (unsigned) margin,
> > >   * based on the observation that:
> > > @@ -4018,7 +4028,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
> > >  	 * Skip update of task's estimated utilization when its EWMA is
> > >  	 * already ~1% close to its last activation value.
> > >  	 */
> > > -	ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
> > > +	ue.enqueued = p->se.avg.running_sum / LOAD_AVG_MAX;
> > 
> > I guess we are doing extra division here which adds some cost. Does
> > performance look Ok with the change?
> 
> This extra division is there and done only at dequeue time instead of
> doing it at each update_load_avg.

I know. :)

> To be more precise, at each ___update_load_avg we should really update
> running_avg by:
> 
>    u32 divider = LOAD_AVG_MAX - 1024 + sa->period_contrib;
>    sa->running_avg = sa->running_sum / divider;
> 
> but, this would imply tracking an additional signal in sched_avg and
> doing an additional division at ___update_load_avg() time.
> 
> Morten suggested that, if we accept the rounding errors due to
> considering
> 
>       divider ~= LOAD_AVG_MAX
> 
> thus discarding the (sa->period_contrib - 1024) correction, then we
> can completely skip the tracking of running_avg (thus saving space in
> sched_avg) and approximate it at dequeue time as per the code line,
> just to compute the new util_est sample to accumulate.
> 
> Does that make sense now?

The patch always made sense to me.. I was just pointing out the extra
division this patch adds. I agree since its done on dequeue-only, then its
probably Ok to do..

thanks,

 - Joel
