Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeCGKjH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:39:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43266 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeCGKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:39:04 -0500
Date: Wed, 7 Mar 2018 11:38:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v5 4/4] sched/fair: update util_est only on util_avg
 updates
Message-ID: <20180307103852.GJ25201@hirez.programming.kicks-ass.net>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-5-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222170153.673-5-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 05:01:53PM +0000, Patrick Bellasi wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8364771f7301..1bf9a86ebc39 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3047,6 +3047,29 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
>  	}
>  }
>  
> +/*
> + * When a task is dequeued, its estimated utilization should not be update if
> + * its util_avg has not been updated at least once.
> + * This flag is used to synchronize util_avg updates with util_est updates.
> + * We map this information into the LSB bit of the utilization saved at
> + * dequeue time (i.e. util_est.dequeued).
> + */
> +#define UTIL_EST_NEED_UPDATE_FLAG 0x1
> +
> +static inline void cfs_se_util_change(struct sched_avg *avg)
> +{
	if (!sched_feat(UTIL_EST))
		return;

> +	if (sched_feat(UTIL_EST)) {
> +		struct util_est ue = READ_ONCE(avg->util_est);
> +
> +		if (!(ue.enqueued & UTIL_EST_NEED_UPDATE_FLAG))
> +			return;
> +
> +		/* Reset flag to report util_avg has been updated */
> +		ue.enqueued &= ~UTIL_EST_NEED_UPDATE_FLAG;
> +		WRITE_ONCE(avg->util_est, ue);
> +	}

and loose the indent. Also, since we only update the enqueued value, we
don't need to load/store the entire util_est thing here.

> +}
> +
>  #ifdef CONFIG_SMP
>  /*
>   * Approximate:
> @@ -3308,6 +3331,7 @@ __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entit
>  				cfs_rq->curr == se)) {
>  
>  		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
> +		cfs_se_util_change(&se->avg);
>  		return 1;
>  	}
>  

So we only clear the bit for @se updates.

> @@ -5218,7 +5242,7 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
>  
>  	/* Update root cfs_rq's estimated utilization */
>  	enqueued  = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> -	enqueued += _task_util_est(p);
> +	enqueued += (_task_util_est(p) | 0x1);

UTIL_EST_NEED_UPDATE_FLAG, although I do agree that 0x1 is much easier
to type ;-)

But you set it for the cfs_rq value ?! That doesn't seem right.

>  	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
>  }
>  
> @@ -5310,7 +5334,7 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
>  	if (cfs_rq->nr_running) {
>  		ue.enqueued  = READ_ONCE(cfs_rq->avg.util_est.enqueued);
>  		ue.enqueued -= min_t(unsigned int, ue.enqueued,
> -				     _task_util_est(p));
> +				     (_task_util_est(p) | UTIL_EST_NEED_UPDATE_FLAG));
>  	}
>  	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
>  

Would it be really horrible if you separate the value and flag using a
bitfield/shifts?

> @@ -5321,12 +5345,19 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
>  	if (!task_sleep)
>  		return;
>  
> +	/*
> +	 * Skip update of task's estimated utilization if the PELT signal has
> +	 * never been updated (at least once) since last enqueue time.
> +	 */
> +	ue = READ_ONCE(p->se.avg.util_est);
> +	if (ue.enqueued & UTIL_EST_NEED_UPDATE_FLAG)
> +		return;
> +
>  	/*
>  	 * Skip update of task's estimated utilization when its EWMA is
>  	 * already ~1% close to its last activation value.
>  	 */
> +	ue.enqueued = (task_util(p) | UTIL_EST_NEED_UPDATE_FLAG);
>  	last_ewma_diff = ue.enqueued - ue.ewma;
>  	if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
>  		return;


I see what you do, but Yuck! that's really nasty. Then again, I've not
actually got a better suggestion.
