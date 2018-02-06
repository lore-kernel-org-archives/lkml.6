Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbeBFPvW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:51:22 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58010 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeBFPvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:51:16 -0500
Date: Tue, 6 Feb 2018 16:50:56 +0100
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
Subject: Re: [PATCH v4 1/3] sched/fair: add util_est on top of PELT
Message-ID: <20180206155056.GF2269@hirez.programming.kicks-ass.net>
References: <20180206144131.31233-1-patrick.bellasi@arm.com>
 <20180206144131.31233-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206144131.31233-2-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mostly nice, I almost applied, except too many nits below.



On Tue, Feb 06, 2018 at 02:41:29PM +0000, Patrick Bellasi wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7b6535987500..118f49c39b60 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5193,6 +5193,20 @@ static inline void hrtick_update(struct rq *rq)
>  }
>  #endif
>  
> +static inline unsigned long task_util(struct task_struct *p);
> +static inline unsigned long _task_util_est(struct task_struct *p);

What's with the leading underscore? I don't see one without it.

> +
> +static inline void util_est_enqueue(struct task_struct *p)

Also pass @rq from enqueue_task_fair() ? I see no point in computing
task_rq(p) if we already have the value around.

> +{
> +	struct cfs_rq *cfs_rq = &task_rq(p)->cfs;
> +
> +	if (!sched_feat(UTIL_EST))
> +		return;
> +
> +	/* Update root cfs_rq's estimated utilization */
> +	cfs_rq->avg.util_est.enqueued += _task_util_est(p);
> +}


> +/*
> + * Check if the specified (signed) value is within a specified margin,
> + * based on the observation that:
> + *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)

    * Note: this only works when x+y < INT_MAX.

> + */
> +static inline bool within_margin(long value, unsigned int margin)

This mixing of long and int is dodgy, do we want to consistently use int
here?

> +{
> +	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
> +}
> +
> +static inline void util_est_dequeue(struct task_struct *p, int flags)
> +{
> +	struct cfs_rq *cfs_rq = &task_rq(p)->cfs;
> +	unsigned long util_last;
> +	long last_ewma_diff;
> +	unsigned long ewma;
> +	long util_est = 0;

Why long?

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
> +	if (cfs_rq->nr_running) {
> +		util_est  = READ_ONCE(cfs_rq->avg.util_est.enqueued);

Because util_est.enqueued is of type 'unsigned int'.

> +		util_est -= min_t(long, util_est, _task_util_est(p));
> +	}
> +	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, util_est);

long to int truncate

> +
> +	/*
> +	 * Skip update of task's estimated utilization when the task has not
> +	 * yet completed an activation, e.g. being migrated.
> +	 */
> +	if (!(flags & DEQUEUE_SLEEP))
> +		return;
> +
> +	ewma = READ_ONCE(p->se.avg.util_est.ewma);
> +	util_last = task_util(p);

Again, all kinds of long, while the ewma type itself is of 'unsigned
int'.

> +
> +	/*
> +	 * Skip update of task's estimated utilization when its EWMA is
> +	 * already ~1% close to its last activation value.
> +	 */
> +	last_ewma_diff = util_last - ewma;
> +	if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
> +		return;
> +
> +	/*
> +	 * Update Task's estimated utilization
> +	 *
> +	 * When *p completes an activation we can consolidate another sample
> +	 * about the task size. This is done by storing the last PELT value
> +	 * for this task and using this value to load another sample in the
> +	 * exponential weighted moving average:
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
> +	ewma   = last_ewma_diff + (ewma << UTIL_EST_WEIGHT_SHIFT);
> +	ewma >>= UTIL_EST_WEIGHT_SHIFT;
> +
> +	WRITE_ONCE(p->se.avg.util_est.ewma, ewma);
> +	WRITE_ONCE(p->se.avg.util_est.enqueued, util_last);

Two stores to that word... can we fix that nicely?

> +}

> +static inline unsigned long _task_util_est(struct task_struct *p)
> +{
> +	return max(p->se.avg.util_est.ewma, p->se.avg.util_est.enqueued);
> +}

Aside from the underscore thing I already noted, why is this here and
not where the fwd declaration is?

> +/*
> + * UtilEstimation. Use estimated CPU utilization.
> + */
> +SCHED_FEAT(UTIL_EST, false)

Since you couldn't measure it, do we wants it true?
