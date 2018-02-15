Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166870AbeBOSpQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:45:16 -0500
Received: from foss.arm.com ([217.140.101.70]:55842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162499AbeBOPW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:22:56 -0500
Date: Thu, 15 Feb 2018 15:22:47 +0000
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, morten.rasmussen@foss.arm.com,
        brendan.jackman@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v5 1/3] sched: Stop nohz stats when decayed
Message-ID: <20180215152247.GA25247@e110439-lin>
References: <1518622006-16089-1-git-send-email-vincent.guittot@linaro.org>
 <1518622006-16089-2-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518622006-16089-2-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,
here are some possible small code improvement suggestions from my side.

Cheers Patrick

On 14-Feb 16:26, Vincent Guittot wrote:
> > Stopped the periodic update of blocked load when all idle CPUs have fully
> > decayed. We introduce a new nohz.has_blocked that reflect if some idle
> > CPUs has blocked load that have to be periodiccally updated. nohz.has_blocked
> > is set everytime that a Idle CPU can have blocked load and it is then clear
> > when no more blocked load has been detected during an update. We don't need
> > atomic operation but only to make cure of the right ordering when updating
> > nohz.idle_cpus_mask and nohz.has_blocked.
> >
> > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c  | 122 ++++++++++++++++++++++++++++++++++++++++++---------
> >  kernel/sched/sched.h |   1 +
> >  2 files changed, 102 insertions(+), 21 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 7af1fa9..5a6835e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5383,8 +5383,9 @@ decay_load_missed(unsigned long load, unsigned long missed_updates, int idx)
> >  static struct {
> >  	cpumask_var_t idle_cpus_mask;
> >  	atomic_t nr_cpus;
> > +	int has_blocked;		/* Idle CPUS has blocked load */

Why not "bool"?

What about "has_blocked_load", which makes it more clear the meaning
and is also more consistent with the RQ flags "aggregated" by this
one... as well as some other local variables you already name like
that?

>  	unsigned long next_balance;     /* in jiffy units */
> -	unsigned long next_stats;
> +	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
>  } nohz ____cacheline_aligned;
>
>  #endif /* CONFIG_NO_HZ_COMMON */
> @@ -6951,6 +6952,7 @@ enum fbq_type { regular, remote, all };
>  #define LBF_DST_PINNED  0x04
>  #define LBF_SOME_PINNED	0x08
>  #define LBF_NOHZ_STATS	0x10
> +#define LBF_NOHZ_AGAIN	0x20
>
>  struct lb_env {
>  	struct sched_domain	*sd;
> @@ -7335,8 +7337,6 @@ static void attach_tasks(struct lb_env *env)
>  	rq_unlock(env->dst_rq, &rf);
>  }
>
> -#ifdef CONFIG_FAIR_GROUP_SCHED
> -
>  static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  {
>  	if (cfs_rq->load.weight)
> @@ -7354,11 +7354,14 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  	return true;
>  }
>
> +#ifdef CONFIG_FAIR_GROUP_SCHED
> +
>  static void update_blocked_averages(int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
>  	struct cfs_rq *cfs_rq, *pos;
>  	struct rq_flags rf;
> +	bool done = true;
>
>  	rq_lock_irqsave(rq, &rf);
>  	update_rq_clock(rq);
> @@ -7388,10 +7391,14 @@ static void update_blocked_averages(int cpu)
>  		 */
>  		if (cfs_rq_is_decayed(cfs_rq))
>  			list_del_leaf_cfs_rq(cfs_rq);
> +		else
> +			done = false;
>  	}
>
>  #ifdef CONFIG_NO_HZ_COMMON
>  	rq->last_blocked_load_update_tick = jiffies;
> +	if (done)
> +		rq->has_blocked_load = 0;
>  #endif
>  	rq_unlock_irqrestore(rq, &rf);
>  }
> @@ -7454,6 +7461,8 @@ static inline void update_blocked_averages(int cpu)
>  	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
>  #ifdef CONFIG_NO_HZ_COMMON
>  	rq->last_blocked_load_update_tick = jiffies;
> +	if (cfs_rq_is_decayed(cfs_rq))
> +		rq->has_blocked_load = 0;
>  #endif
>  	rq_unlock_irqrestore(rq, &rf);
>  }
> @@ -7789,18 +7798,25 @@ group_type group_classify(struct sched_group *group,
>  	return group_other;
>  }
>
> -static void update_nohz_stats(struct rq *rq)
> +static bool update_nohz_stats(struct rq *rq)
>  {
>  #ifdef CONFIG_NO_HZ_COMMON
>  	unsigned int cpu = rq->cpu;
>
> +	if (!rq->has_blocked_load)
> +		return false;
> +
>  	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> -		return;
> +		return false;
>
>  	if (!time_after(jiffies, rq->last_blocked_load_update_tick))
> -		return;
> +		return true;
>
>  	update_blocked_averages(cpu);
> +
> +	return rq->has_blocked_load;
> +#else
> +	return false;
>  #endif
>  }
>
> @@ -7826,8 +7842,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>  		struct rq *rq = cpu_rq(i);
>
> -		if (env->flags & LBF_NOHZ_STATS)
> -			update_nohz_stats(rq);
> +		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq))
> +			env->flags |= LBF_NOHZ_AGAIN;
>
>  		/* Bias balancing toward cpus of our domain */
>  		if (local_group)
> @@ -7979,18 +7995,17 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  	struct sg_lb_stats *local = &sds->local_stat;
>  	struct sg_lb_stats tmp_sgs;
>  	int load_idx, prefer_sibling = 0;
> +#ifdef CONFIG_NO_HZ_COMMON
> +	int has_blocked = READ_ONCE(nohz.has_blocked);
> +#endif
>  	bool overload = false;
>
>  	if (child && child->flags & SD_PREFER_SIBLING)
>  		prefer_sibling = 1;
>
>  #ifdef CONFIG_NO_HZ_COMMON
> -	if (env->idle == CPU_NEWLY_IDLE) {
> +	if (env->idle == CPU_NEWLY_IDLE && has_blocked)

Why using a local "has_blocked" here?

Is not better to inline directly the READ_ONCE, we avoid the above
idfed and also (maybe?) save the load if the previous checks should fail?

>  		env->flags |= LBF_NOHZ_STATS;
> -
> -		if (cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd)))
> -			nohz.next_stats = jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD);
> -	}
>  #endif
>
>  	load_idx = get_sd_load_idx(env->sd, env->idle);
> @@ -8046,6 +8061,15 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  		sg = sg->next;
>  	} while (sg != env->sd->groups);
>
> +#ifdef CONFIG_NO_HZ_COMMON
> +	if ((env->flags & LBF_NOHZ_AGAIN) &&
> +	    cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
> +
> +		WRITE_ONCE(nohz.next_blocked,
> +				jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD));
> +	}
> +#endif
> +

Moreover, the above two ifdef maybe can be better moved into compile
time inline functions to keep update_sg_lb_stats more streamlined,
e.g. something like:

---8<---
#ifdef CONFIG_NO_HZ_COMMON
static inline void nohz_update_next_stats(struct lb_env *env)
{
        if (env->idle != CPU_NEWLY_IDLE || READ_ONCE(nohz.has_blocked))
                return;
        eenv->flags |= LBF_NOHZ_STATS;
        etc...
}

static inline void nohz_update_next_blocked(struct lb_env *env)
{
        if (!(env->flags & LBF_NOHZ_AGAIN)
                return
        if (!cpumask_subset(nohz.idle_cpus_mask,
                            sched_domain_span(env->sd)))
                return
        WRITE_ONCE();
}
#else
#define nohz_update_next_stats(env) do {} while(false);
#define nohz_update_blocked(env) do {} while(false);
#endif
---8<---

>  	if (env->sd->flags & SD_NUMA)
>  		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
>
> @@ -9069,6 +9093,8 @@ static void nohz_balancer_kick(struct rq *rq)
>  	struct sched_domain *sd;
>  	int nr_busy, i, cpu = rq->cpu;
>  	unsigned int flags = 0;
> +	unsigned long has_blocked = READ_ONCE(nohz.has_blocked);
> +	unsigned long next_blocked = READ_ONCE(nohz.next_blocked);
>
>  	if (unlikely(rq->idle_balance))
>  		return;
> @@ -9086,7 +9112,7 @@ static void nohz_balancer_kick(struct rq *rq)
>  	if (likely(!atomic_read(&nohz.nr_cpus)))
>  		return;
>
> -	if (time_after(now, nohz.next_stats))
> +	if (time_after(now, next_blocked) && has_blocked)

Why not using READ_ONCE right here, these are the only two usages in
this function, isn't it?
This would allow also to skip (some of) the loads if some of the
checks should fails.  Ins't it?

>  		flags = NOHZ_STATS_KICK;
>
>  	if (time_before(now, nohz.next_balance))
> @@ -9207,13 +9233,26 @@ void nohz_balance_enter_idle(int cpu)
>  	if (!housekeeping_cpu(cpu, HK_FLAG_SCHED))
>  		return;
>
> +	/*
> +	 * Can be set safely without rq->lock held
> +	 * If a clear happens, it will have evaluated last additions because
> +	 * rq->lock is held during the check and the clear
> +	 */
> +	rq->has_blocked_load = 1;
> +
> +	/*
> +	 * The tick is still stopped but load could have been added in the
> +	 * meantime. We set the nohz.has_blocked flag to trig a check of the
> +	 * *_avg. The CPU is already part of nohz.idle_cpus_mask so the clear
> +	 * of nohz.has_blocked can only happen after checking the new load
> +	 */
>  	if (rq->nohz_tick_stopped)
> -		return;
> +		goto out;
>
>  	/*
>  	 * If we're a completely isolated CPU, we don't play.
>  	 */
> -	if (on_null_domain(cpu_rq(cpu)))
> +	if (on_null_domain(rq))
>  		return;
>
>  	rq->nohz_tick_stopped = 1;
> @@ -9221,7 +9260,21 @@ void nohz_balance_enter_idle(int cpu)
>  	cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
>  	atomic_inc(&nohz.nr_cpus);
>
> +	/*
> +	 * Ensures that if nohz_idle_balance() fails to observe our
> +	 * @idle_cpus_mask store, it must observe the @has_blocked
> +	 * store.
> +	 */
> +	smp_mb__after_atomic();
> +
>  	set_cpu_sd_state_idle(cpu);
> +
> +out:
> +	/*
> +	 * Each time a cpu enter idle, we assume that it has blocked load and
> +	 * enable the periodic update of the load of idle cpus
> +	 */
> +	WRITE_ONCE(nohz.has_blocked, 1);
>  }
>  #else
>  static inline void nohz_balancer_kick(struct rq *rq) { }
> @@ -9355,7 +9408,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  	/* Earliest time when we have to do rebalance again */
>  	unsigned long now = jiffies;
>  	unsigned long next_balance = now + 60*HZ;
> -	unsigned long next_stats = now + msecs_to_jiffies(LOAD_AVG_PERIOD);
> +	bool has_blocked_load = false;
>  	int update_next_balance = 0;
>  	int this_cpu = this_rq->cpu;
>  	unsigned int flags;
> @@ -9374,6 +9427,22 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>
>  	SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
>
> +	/*
> +	 * We assume there will be no idle load after this update and clear
> +	 * the has_blocked flag. If a cpu enters idle in the mean time, it will
> +	 * set the has_blocked flag and trig another update of idle load.
> +	 * Because a cpu that becomes idle, is added to idle_cpus_mask before
> +	 * setting the flag, we are sure to not clear the state and not
> +	 * check the load of an idle cpu.
> +	 */
> +	WRITE_ONCE(nohz.has_blocked, 0);
> +
> +	/*
> +	 * Ensures that if we miss the CPU, we must see the has_blocked
> +	 * store from nohz_balance_enter_idle().
> +	 */
> +	smp_mb();
> +
>  	for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
>  		if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
>  			continue;
> @@ -9383,11 +9452,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  		 * work being done for other cpus. Next load
>  		 * balancing owner will pick it up.
>  		 */
> -		if (need_resched())
> -			break;
> +		if (need_resched()) {
> +			has_blocked_load = true;
> +			goto abort;
> +		}
>
>  		rq = cpu_rq(balance_cpu);
>
> +		update_blocked_averages(rq->cpu);
> +		has_blocked_load |= rq->has_blocked_load;
> +
>  		/*
>  		 * If time for next balance is due,
>  		 * do the balance.
> @@ -9400,7 +9474,6 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  			cpu_load_update_idle(rq);
>  			rq_unlock_irq(rq, &rf);
>
> -			update_blocked_averages(rq->cpu);
>  			if (flags & NOHZ_BALANCE_KICK)
>  				rebalance_domains(rq, CPU_IDLE);
>  		}
> @@ -9415,7 +9488,13 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  	if (flags & NOHZ_BALANCE_KICK)
>  		rebalance_domains(this_rq, CPU_IDLE);
>
> -	nohz.next_stats = next_stats;
> +	WRITE_ONCE(nohz.next_blocked,
> +		now + msecs_to_jiffies(LOAD_AVG_PERIOD));

Is it not slightly more clear to still use a local? I.e.

        next_stats = now + msecs_to_jiffies(LOAD_AVG_PERIOD);
        WRITE_ONCE(nohz.next_blocked, next_stats);

> +
> +abort:
> +	/* There is still blocked load, enable periodic update */
> +	if (has_blocked_load)
> +		WRITE_ONCE(nohz.has_blocked, 1);
>
>  	/*
>  	 * next_balance will be updated only when there is a need.
> @@ -10046,6 +10125,7 @@ __init void init_sched_fair_class(void)
>
>  #ifdef CONFIG_NO_HZ_COMMON
>  	nohz.next_balance = jiffies;
> +	nohz.next_blocked = jiffies;
>  	zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
>  #endif
>  #endif /* SMP */
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e200045..ad9b929 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -723,6 +723,7 @@ struct rq {
>  #ifdef CONFIG_SMP
>  	unsigned long last_load_update_tick;
>  	unsigned long last_blocked_load_update_tick;
> +	unsigned int has_blocked_load;
>  #endif /* CONFIG_SMP */
>  	unsigned int nohz_tick_stopped;
>  	atomic_t nohz_flags;
> > --
> > 2.7.4
> >

--
#include <best/regards.h>

Patrick Bellasi
