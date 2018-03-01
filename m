Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033441AbeCARm4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:42:56 -0500
Received: from foss.arm.com ([217.140.101.70]:42580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033261AbeCARmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:42:55 -0500
Date: Thu, 1 Mar 2018 17:42:42 +0000
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v5 1/4] sched/fair: add util_est on top of PELT
Message-ID: <20180301174231.GA26235@e110439-lin>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222170153.673-2-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is missing the below #ifdef guards, adding here has a note for
the next resping on list.

On 22-Feb 17:01, Patrick Bellasi wrote:

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e1febd252a84..c8526687f107 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5205,6 +5205,23 @@ static inline void hrtick_update(struct rq *rq)
>  }
>  #endif
> 

#ifdef CONFIG_SMP

> +static inline unsigned long task_util(struct task_struct *p);
> +static inline unsigned long _task_util_est(struct task_struct *p);
> +
> +static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
> +				    struct task_struct *p)
> +{
> +	unsigned int enqueued;
> +
> +	if (!sched_feat(UTIL_EST))
> +		return;
> +
> +	/* Update root cfs_rq's estimated utilization */
> +	enqueued  = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> +	enqueued += _task_util_est(p);
> +	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
> +}
> +

#else
static inline void util_est_enqueue(struct cfs_rq *cfs_rq
                                    struct task_struct *p)
{
}
#endif /* CONFIG_SMP */

>  /*
>   * The enqueue_task method is called before nr_running is
>   * increased. Here we update the fair scheduling stats and
> @@ -5257,9 +5274,86 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	if (!se)
>  		add_nr_running(rq, 1);
> 
> +	util_est_enqueue(&rq->cfs, p);
>  	hrtick_update(rq);
>  }
> 
> +/*
> + * Check if a (signed) value is within a specified (unsigned) margin,
> + * based on the observation that:
> + *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
> + *
> + * NOTE: this only works when value + maring < INT_MAX.
> + */
> +static inline bool within_margin(int value, int margin)
> +{
> +	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
> +}
> +
> +static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
> +				    struct task_struct *p,
> +				    bool task_sleep)
> +{

#ifdef CONFIG_SMP

> +	long last_ewma_diff;
> +	struct util_est ue;
> +
> +	if (!sched_feat(UTIL_EST))
> +		return;
> +
> +	/*
> +	 * Update root cfs_rq's estimated utilization
> +	 *
> +	 * If *p is the last task then the root cfs_rq's estimated utilization
> +	 * of a CPU is 0 by definition.
> +	 */
> +	ue.enqueued = 0;
> +	if (cfs_rq->nr_running) {
> +		ue.enqueued  = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> +		ue.enqueued -= min_t(unsigned int, ue.enqueued,
> +				     _task_util_est(p));
> +	}
> +	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
> +
> +	/*
> +	 * Skip update of task's estimated utilization when the task has not
> +	 * yet completed an activation, e.g. being migrated.
> +	 */
> +	if (!task_sleep)
> +		return;
> +
> +	/*
> +	 * Skip update of task's estimated utilization when its EWMA is
> +	 * already ~1% close to its last activation value.
> +	 */
> +	ue = READ_ONCE(p->se.avg.util_est);
> +	ue.enqueued = task_util(p);
> +	last_ewma_diff = ue.enqueued - ue.ewma;
> +	if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
> +		return;
> +
> +	/*
> +	 * Update Task's estimated utilization
> +	 *
> +	 * When *p completes an activation we can consolidate another sample
> +	 * of the task size. This is done by storing the current PELT value
> +	 * as ue.enqueued and by using this value to update the Exponential
> +	 * Weighted Moving Average (EWMA):
> +	 *
> +	 *  ewma(t) = w *  task_util(p) + (1-w) * ewma(t-1)
> +	 *          = w *  task_util(p) +         ewma(t-1)  - w * ewma(t-1)
> +	 *          = w * (task_util(p) -         ewma(t-1)) +     ewma(t-1)
> +	 *          = w * (      last_ewma_diff            ) +     ewma(t-1)
> +	 *          = w * (last_ewma_diff  +  ewma(t-1) / w)
> +	 *
> +	 * Where 'w' is the weight of new samples, which is configured to be
> +	 * 0.25, thus making w=1/4 ( >>= UTIL_EST_WEIGHT_SHIFT)
> +	 */
> +	ue.ewma <<= UTIL_EST_WEIGHT_SHIFT;
> +	ue.ewma  += last_ewma_diff;
> +	ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
> +	WRITE_ONCE(p->se.avg.util_est, ue);

#endif /* CONFIG_SMP */

> +}
> +
>  static void set_next_buddy(struct sched_entity *se);
> 
>  /*
> @@ -5316,6 +5410,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	if (!se)
>  		sub_nr_running(rq, 1);
> 
> +	util_est_dequeue(&rq->cfs, p, task_sleep);
>  	hrtick_update(rq);
>  }
> 

-- 
#include <best/regards.h>

Patrick Bellasi
