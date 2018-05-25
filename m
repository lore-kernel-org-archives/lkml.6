Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967205AbeEYPyo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:54:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35734 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966912AbeEYPym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:54:42 -0400
Date: Fri, 25 May 2018 16:54:37 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, quentin.perret@arm.com
Subject: Re: [PATCH v5 02/10] sched/rt: add rt_rq utilization tracking
Message-ID: <20180525155437.GE30654@e110439-lin>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-3-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527253951-22709-3-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-May 15:12, Vincent Guittot wrote:
> schedutil governor relies on cfs_rq's util_avg to choose the OPP when cfs
                                                                       ^
                                                                     only
otherwise, while RT tasks are running we go to max.

> tasks are running.
> When the CPU is overloaded by cfs and rt tasks, cfs tasks
                  ^^^^^^^^^^
I would say we always have the provlem whenever an RT task preempt a
CFS one, even just for few ms, isn't it?

> are preempted by rt tasks and in this case util_avg reflects the remaining
> capacity but not what cfs want to use. In such case, schedutil can select a
> lower OPP whereas the CPU is overloaded. In order to have a more accurate
> view of the utilization of the CPU, we track the utilization that is
> "stolen" by rt tasks.
> 
> rt_rq uses rq_clock_task and cfs_rq uses cfs_rq_clock_task but they are
> the same at the root group level, so the PELT windows of the util_sum are
> aligned.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c  | 15 ++++++++++++++-
>  kernel/sched/pelt.c  | 23 +++++++++++++++++++++++
>  kernel/sched/pelt.h  |  7 +++++++
>  kernel/sched/rt.c    |  8 ++++++++
>  kernel/sched/sched.h |  7 +++++++
>  5 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6390c66..fb18bcc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7290,6 +7290,14 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
>  	return false;
>  }
>  
> +static inline bool rt_rq_has_blocked(struct rq *rq)
> +{
> +	if (rq->avg_rt.util_avg)

Should use READ_ONCE?

> +		return true;
> +
> +	return false;

What about just:

       return READ_ONCE(rq->avg_rt.util_avg);

?

> +}
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  
>  static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> @@ -7349,6 +7357,10 @@ static void update_blocked_averages(int cpu)
>  		if (cfs_rq_has_blocked(cfs_rq))
>  			done = false;
>  	}
> +	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
> +	/* Don't need periodic decay once load/util_avg are null */
> +	if (rt_rq_has_blocked(rq))
> +		done = false;
>  
>  #ifdef CONFIG_NO_HZ_COMMON
>  	rq->last_blocked_load_update_tick = jiffies;
> @@ -7414,9 +7426,10 @@ static inline void update_blocked_averages(int cpu)
>  	rq_lock_irqsave(rq, &rf);
>  	update_rq_clock(rq);
>  	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
> +	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
>  #ifdef CONFIG_NO_HZ_COMMON
>  	rq->last_blocked_load_update_tick = jiffies;
> -	if (!cfs_rq_has_blocked(cfs_rq))
> +	if (!cfs_rq_has_blocked(cfs_rq) && !rt_rq_has_blocked(rq))
>  		rq->has_blocked_load = 0;
>  #endif
>  	rq_unlock_irqrestore(rq, &rf);
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index e6ecbb2..213b922 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -309,3 +309,26 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
>  
>  	return 0;
>  }
> +
> +/*
> + * rt_rq:
> + *
> + *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
> + *   util_sum = cpu_scale * load_sum
> + *   runnable_load_sum = load_sum
> + *
> + */
> +
> +int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
> +{
> +	if (___update_load_sum(now, rq->cpu, &rq->avg_rt,
> +				running,
> +				running,
> +				running)) {
> +

Not needed empty line?

> +		___update_load_avg(&rq->avg_rt, 1, 1);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index 9cac73e..b2983b7 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -3,6 +3,7 @@
>  int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se);
>  int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se);
>  int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
> +int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>  
>  /*
>   * When a task is dequeued, its estimated utilization should not be update if
> @@ -38,6 +39,12 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  	return 0;
>  }
>  
> +static inline int
> +update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
> +{
> +	return 0;
> +}
> +
>  #endif
>  
>  
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index ef3c4e6..b4148a9 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -5,6 +5,8 @@
>   */
>  #include "sched.h"
>  
> +#include "pelt.h"
> +
>  int sched_rr_timeslice = RR_TIMESLICE;
>  int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
>  
> @@ -1572,6 +1574,9 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  
>  	rt_queue_push_tasks(rq);
>  
> +	update_rt_rq_load_avg(rq_clock_task(rq), rq,
> +		rq->curr->sched_class == &rt_sched_class);
> +
>  	return p;
>  }
>  
> @@ -1579,6 +1584,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
>  {
>  	update_curr_rt(rq);
>  
> +	update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
> +
>  	/*
>  	 * The previous task needs to be made eligible for pushing
>  	 * if it is still active
> @@ -2308,6 +2315,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
>  	struct sched_rt_entity *rt_se = &p->rt;
>  
>  	update_curr_rt(rq);
> +	update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);

Mmm... not entirely sure... can't we fold
   update_rt_rq_load_avg() into update_curr_rt() ?

Currently update_curr_rt() is used in:
   dequeue_task_rt
   pick_next_task_rt
   put_prev_task_rt
   task_tick_rt

while we update_rt_rq_load_avg() only in:
   pick_next_task_rt
   put_prev_task_rt
   task_tick_rt
and
   update_blocked_averages
 
Why we don't we need to update at dequeue_task_rt() time ?

>  
>  	watchdog(rq, p);
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 757a3ee..7a16de9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -592,6 +592,7 @@ struct rt_rq {
>  	unsigned long		rt_nr_total;
>  	int			overloaded;
>  	struct plist_head	pushable_tasks;
> +
>  #endif /* CONFIG_SMP */
>  	int			rt_queued;
>  
> @@ -847,6 +848,7 @@ struct rq {
>  
>  	u64			rt_avg;
>  	u64			age_stamp;
> +	struct sched_avg	avg_rt;
>  	u64			idle_stamp;
>  	u64			avg_idle;
>  
> @@ -2205,4 +2207,9 @@ static inline unsigned long cpu_util_cfs(struct rq *rq)
>  
>  	return util;
>  }
> +
> +static inline unsigned long cpu_util_rt(struct rq *rq)
> +{
> +	return rq->avg_rt.util_avg;

READ_ONCE?

> +}
>  #endif
> -- 
> 2.7.4
> 

-- 
#include <best/regards.h>

Patrick Bellasi
