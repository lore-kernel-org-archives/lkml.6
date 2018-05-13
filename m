Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbeEMGEu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 02:04:50 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34604 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeEMGEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 02:04:48 -0400
X-Google-Smtp-Source: AB8JxZqVmiECH/Pxa9Q/xu6AJTxrD8OFWU6XPp6wALnTxUGVYh9hxajIGXERYLJP7Dvea5MHTeVyxQ==
Date: Sat, 12 May 2018 23:04:43 -0700
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
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 3/3] sched/fair: schedutil: explicit update only when
 required
Message-ID: <20180513060443.GB64158@joelaf.mtv.corp.google.com>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510150553.28122-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 04:05:53PM +0100, Patrick Bellasi wrote:
> Schedutil updates for FAIR tasks are triggered implicitly each time a
> cfs_rq's utilization is updated via cfs_rq_util_change(), currently
> called by update_cfs_rq_load_avg(), when the utilization of a cfs_rq has
> changed, and {attach,detach}_entity_load_avg().
> 
> This design is based on the idea that "we should callback schedutil
> frequently enough" to properly update the CPU frequency at every
> utilization change. However, such an integration strategy has also
> some downsides:

Hi Patrick,

I agree making the call explicit would make schedutil integration easier so
that's really awesome. However I also fear that if some path in the fair
class in the future changes the utilization but forgets to update schedutil
explicitly (because they forgot to call the explicit public API) then the
schedutil update wouldn't go through. In this case the previous design of
doing the schedutil update in the wrapper kind of was a nice to have

Just thinking out loud but is there a way you could make the implicit call
anyway incase the explicit call wasn't requested for some reason? That's
probably hard to do correctly though..

Some more comments below:

> 
>  - schedutil updates are triggered by RQ's load updates, which makes
>    sense in general but it does not allow to know exactly which other RQ
>    related information have been updated.
>    Recently, for example, we had issues due to schedutil dependencies on
>    cfs_rq->h_nr_running and estimated utilization updates.
> 
>  - cfs_rq_util_change() is mainly a wrapper function for an already
>    existing "public API", cpufreq_update_util(), which is required
>    just to ensure we actually update schedutil only when we are updating
>    a root cfs_rq.
>    Thus, especially when task groups are in use, most of the calls to
>    this wrapper function are not required.
> 
>  - the usage of a wrapper function is not completely consistent across
>    fair.c, since we could still need additional explicit calls to
>    cpufreq_update_util().
>    For example this already happens to report the IOWAIT boot flag in
>    the wakeup path.
> 
>  - it makes it hard to integrate new features since it could require to
>    change other function prototypes just to pass in an additional flag,
>    as it happened for example in commit:
> 
>       ea14b57e8a18 ("sched/cpufreq: Provide migration hint")
> 
> All the above considered, let's make schedutil updates more explicit in
> fair.c by removing the cfs_rq_util_change() wrapper function in favour
> of the existing cpufreq_update_util() public API.
> This can be done by calling cpufreq_update_util() explicitly in the few
> call sites where it really makes sense and when all the (potentially)
> required cfs_rq's information have been updated.
> 
> This patch mainly removes code and adds explicit schedutil updates
> only when we:
>  - {enqueue,dequeue}_task_fair() a task to/from the root cfs_rq
>  - (un)throttle_cfs_rq() a set of tasks up to the root cfs_rq
>  - task_tick_fair() to update the utilization of the root cfs_rq
> 
> All the other code paths, currently _indirectly_ covered by a call to
> update_load_avg(), are still covered. Indeed, some paths already imply
> enqueue/dequeue calls:
>  - switch_{to,from}_fair()
>  - sched_move_task()
> while others are followed by enqueue/dequeue calls:
>  - cpu_cgroup_fork() and
>    post_init_entity_util_avg():
>      are used at wakeup_new_task() time and thus already followed by an
>      enqueue_task_fair()
>  - migrate_task_rq_fair():
>      updates the removed utilization but not the actual cfs_rq
>      utilization, which is updated by a following sched event
> 
> This new proposal allows also to better aggregate schedutil related
> flags, which are required only at enqueue_task_fair() time.
> IOWAIT and MIGRATION flags are now requested only when a task is
> actually visible at the root cfs_rq level.
> 
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> 
> ---
> 
> NOTE: this patch changes the behavior of the IOWAIT flag: in case of a
> task waking up on a throttled RQ we do not assert the flag to schedutil
> anymore. However, this seems to make sense since the task will not be
> running anyway.
> ---
>  kernel/sched/fair.c | 81 ++++++++++++++++++++++++-----------------------------
>  1 file changed, 36 insertions(+), 45 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 01dfc47541e6..87f092151a6e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -772,7 +772,7 @@ void post_init_entity_util_avg(struct sched_entity *se)
>  			 * For !fair tasks do:
>  			 *
>  			update_cfs_rq_load_avg(now, cfs_rq);
> -			attach_entity_load_avg(cfs_rq, se, 0);
> +			attach_entity_load_avg(cfs_rq, se);
>  			switched_from_fair(rq, p);
>  			 *
>  			 * such that the next switched_to_fair() has the
> @@ -3009,29 +3009,6 @@ static inline void update_cfs_group(struct sched_entity *se)
>  }
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>  
> -static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
> -{
> -	struct rq *rq = rq_of(cfs_rq);
> -
> -	if (&rq->cfs == cfs_rq || (flags & SCHED_CPUFREQ_MIGRATION)) {
> -		/*
> -		 * There are a few boundary cases this might miss but it should
> -		 * get called often enough that that should (hopefully) not be
> -		 * a real problem.
> -		 *
> -		 * It will not get called when we go idle, because the idle
> -		 * thread is a different class (!fair), nor will the utilization
> -		 * number include things like RT tasks.
> -		 *
> -		 * As is, the util number is not freq-invariant (we'd have to
> -		 * implement arch_scale_freq_capacity() for that).
> -		 *
> -		 * See cpu_util().
> -		 */
> -		cpufreq_update_util(rq, flags);
> -	}
> -}
> -
>  #ifdef CONFIG_SMP
>  /*
>   * Approximate:
> @@ -3712,9 +3689,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  	cfs_rq->load_last_update_time_copy = sa->last_update_time;
>  #endif
>  
> -	if (decayed)
> -		cfs_rq_util_change(cfs_rq, 0);
> -
>  	return decayed;
>  }
>  
> @@ -3726,7 +3700,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>   * Must call update_cfs_rq_load_avg() before this, since we rely on
>   * cfs_rq->avg.last_update_time being current.
>   */
> -static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> +static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
>  	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
>  
> @@ -3762,7 +3736,6 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  
>  	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
>  
> -	cfs_rq_util_change(cfs_rq, flags);
>  }
>  
>  /**
> @@ -3781,7 +3754,6 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  
>  	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
>  
> -	cfs_rq_util_change(cfs_rq, 0);
>  }
>  
>  /*
> @@ -3818,7 +3790,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  		 *
>  		 * IOW we're enqueueing a task on a new CPU.
>  		 */
> -		attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATION);
> +		attach_entity_load_avg(cfs_rq, se);
>  		update_tg_load_avg(cfs_rq, 0);
>  
>  	} else if (decayed && (flags & UPDATE_TG))
> @@ -4028,13 +4000,12 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  
>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
>  {
> -	cfs_rq_util_change(cfs_rq, 0);

How about kill that extra line by doing:

static inline void update_load_avg(struct cfs_rq *cfs_rq,
				   struct sched_entity *se, int not_used1) {}

>  }
>  
>  static inline void remove_entity_load_avg(struct sched_entity *se) {}
>  
>  static inline void
> -attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags) {}
> +attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
>  static inline void
>  detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
>  
> @@ -4762,8 +4733,11 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  			dequeue = 0;
>  	}
>  
> -	if (!se)
> +	/* The tasks are no more visible from the root cfs_rq */
> +	if (!se) {
>  		sub_nr_running(rq, task_delta);
> +		cpufreq_update_util(rq, 0);
> +	}
>  
>  	cfs_rq->throttled = 1;
>  	cfs_rq->throttled_clock = rq_clock(rq);
> @@ -4825,8 +4799,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  			break;
>  	}
>  
> -	if (!se)
> +	/* The tasks are now visible from the root cfs_rq */
> +	if (!se) {
>  		add_nr_running(rq, task_delta);
> +		cpufreq_update_util(rq, 0);
> +	}
>  
>  	/* Determine whether we need to wake up potentially idle CPU: */
>  	if (rq->curr == rq->idle && rq->cfs.nr_running)
> @@ -5359,14 +5336,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	/* Estimated utilization must be updated before schedutil */
>  	util_est_enqueue(&rq->cfs, p);
>  
>  -	/*
> -	 * If in_iowait is set, the code below may not trigger any cpufreq
> -	 * utilization updates, so do it here explicitly with the IOWAIT flag
> -	 * passed.
> -	 */
> -	if (p->in_iowait)
> -		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> -
>  	for_each_sched_entity(se) {
>  		if (se->on_rq)
>  			break;
> @@ -5397,9 +5366,27 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		update_cfs_group(se);
>  	}
>  
> -	if (!se)
> +	/* The task is visible from the root cfs_rq */
> +	if (!se) {
> +		unsigned int flags = 0;
> +
>  		add_nr_running(rq, 1);
>  
> +		if (p->in_iowait)
> +			flags |= SCHED_CPUFREQ_IOWAIT;
> +
> +		/*
> +		 * !last_update_time means we've passed through
> +		 * migrate_task_rq_fair() indicating we migrated.
> +		 *
> +		 * IOW we're enqueueing a task on a new CPU.
> +		 */
> +		if (!p->se.avg.last_update_time)
> +			flags |= SCHED_CPUFREQ_MIGRATION;
> +
> +		cpufreq_update_util(rq, flags);
> +	}
> +
>  	hrtick_update(rq);
>  }
>  
> @@ -5456,10 +5443,12 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		update_cfs_group(se);
>  	}
>  
> +	/* The task is no more visible from the root cfs_rq */
>  	if (!se)
>  		sub_nr_running(rq, 1);
>  
>  	util_est_dequeue(&rq->cfs, p, task_sleep);
> +	cpufreq_update_util(rq, 0);

One question about this change. In enqueue, throttle and unthrottle - you are
conditionally calling cpufreq_update_util incase the task was
visible/not-visible in the hierarchy.

But in dequeue you're unconditionally calling it. Seems a bit inconsistent.
Is this because of util_est or something? Could you add a comment here
explaining why this is so?

thanks,

- Joel
