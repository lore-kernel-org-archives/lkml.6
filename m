Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935917AbeBLOeu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:34:50 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36768 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933097AbeBLOet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:34:49 -0500
X-Google-Smtp-Source: AH8x224gTs4ebyDXEnPVNezUVwbysXMDG6vJ5igw9s6LN/wLil898QjgfbDxRthwHV8kr3B1gbya1Q==
Date: Mon, 12 Feb 2018 15:34:44 +0100
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, morten.rasmussen@foss.arm.com,
        brendan.jackman@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/3] sched: update blocked load when newly idle
Message-ID: <20180212143444.GA12378@linaro.org>
References: <1518422874-13216-1-git-send-email-vincent.guittot@linaro.org>
 <1518422874-13216-4-git-send-email-vincent.guittot@linaro.org>
 <20180212120411.GT25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180212120411.GT25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Monday 12 Feb 2018 à 13:04:11 (+0100), Peter Zijlstra a écrit :
> On Mon, Feb 12, 2018 at 09:07:54AM +0100, Vincent Guittot wrote:
> > @@ -8863,12 +8866,26 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
> >  
> >  	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
> >  	    !this_rq->rd->overload) {
> > +		unsigned long has_blocked = READ_ONCE(nohz.has_blocked);
> > +		unsigned long next_blocked = READ_ONCE(nohz.next_blocked);
> > +
> >  		rcu_read_lock();
> >  		sd = rcu_dereference_check_sched_domain(this_rq->sd);
> >  		if (sd)
> >  			update_next_balance(sd, &next_balance);
> >  		rcu_read_unlock();
> >  
> > +		/*
> > +		 * Update blocked idle load if it has not been done for a
> > +		 * while. Try to do it locally before entering idle but kick a
> > +		 * ilb if it takes too much time and/or might delay next local
> > +		 * wake up
> > +		 */
> > +		if (has_blocked && time_after_eq(jiffies, next_blocked) &&
> > +				(this_rq->avg_idle < sysctl_sched_migration_cost ||
> > +				!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE)))
> > +			kick_ilb(NOHZ_STATS_KICK);
> > +
> >  		goto out;
> >  	}
> 
> So I really hate this one, also I suspect its broken, because we do this
> check before dropping rq->lock and _nohz_idle_balance() will take
> rq->lock.

yes. it will take both newly idle rq and idle rq lock

>
> 
> Aside from the above being an unreadable mess, I dislike that it breaks
> the various isolation crud, we should not touch CPUs outside of our
> domain.
>
> 
> Maybe something like the below? (unfinished)
>

good catch. I completely miss the isolation stuff.
But isn't already the case when kicking ilb ? I mean that an idle CPU touches
all idle CPUs and some can be outside its domain during ilb.

The goal of this call to _nohz_idle_balance was to consider this cpu as idle
because that's what will happen as it will not try to pull other task.
We save the kick of an already idle cpu for doing the update of blocked load

Shouldn't we test housekeeping_cpu(cpu, HK_FLAG_SCHED) instead if we want to
make sure that an isolated/full nohz CPU will not be used for updating blocked
load of CPUs outside its domain ?

Is something below more readable:
 
 		/*
-		 * Update blocked idle load if it has not been done for a
-		 * while. Try to do it locally before entering idle but kick a
-		 * ilb if it takes too much time and/or might delay next local
-		 * wake up
+		 * This CPU doesn't want to be disturbed by scheduler
+		 * houskeeping
 		 */
-		if (has_blocked && time_after_eq(jiffies, next_blocked) &&
-				(this_rq->avg_idle < sysctl_sched_migration_cost ||
-				!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE)))
+		if (!housekeeping_cpu(cpu, HK_FLAG_SCHED))
+			goto out;
+
+		/* Will wake up very soon. No time for doing anything else*/
+		if (this_rq->avg_idle < sysctl_sched_migration_cost)
+			goto out;
+
+		/* Don't need to update blocked load of idle CPUs*/
+		if (!has_blocked || time_after_eq(jiffies, next_blocked)
+			goto out;
+
+		raw_spin_unlock(&this_rq->lock);
+		/*
+		 * This CPU is going to be idle and blocked load of idle CPUs
+		 * need to be updated. Run the ilb locally as it is a good
+		 * candidate for ilb instead of waking up another idle CPU.
+		 * Kick an normal ilb if we failed to do the update.
+		 */
+		if !_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
 			kick_ilb(NOHZ_STATS_KICK);
+		raw_spin_lock(&this_rq->lock);
 
 		goto out;

> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7839,7 +7839,7 @@ group_type group_classify(struct sched_g
>  	return group_other;
>  }
>  
> -static bool update_nohz_stats(struct rq *rq)
> +static bool update_nohz_stats(struct rq *rq, bool force)
>  {
>  #ifdef CONFIG_NO_HZ_COMMON
>  	unsigned int cpu = rq->cpu;
> @@ -7850,7 +7850,7 @@ static bool update_nohz_stats(struct rq
>  	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
>  		return false;
>  
> -	if (!time_after(jiffies, rq->last_blocked_load_update_tick))
> +	if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))

This fix the concern raised on the other thread, isn't it ?

>  		return true;
>  
>  	update_blocked_averages(cpu);
> @@ -7883,7 +7883,7 @@ static inline void update_sg_lb_stats(st
>  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>  		struct rq *rq = cpu_rq(i);
>  
> -		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq))
> +		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
>  			env->flags |= LBF_NOHZ_AGAIN;
>  
>  		/* Bias balancing toward cpus of our domain */
> @@ -8857,6 +8857,29 @@ update_next_balance(struct sched_domain
>  		*next_balance = next;
>  }
>  
> +static int nohz_age(struct sched_domain *sd)
> +{
> +	struct cpumask *cpus = this_cpu_cpumask_var_ptr(load_balance_mask);
> +	bool has_blocked_load;
> +
> +	WRITE_ONCE(nohz.has_blocked, 0);
> +
> +	smp_mb();
> +
> +	cpumask_and(cpus, sched_domain_span(sd), nohz.idle_cpus_mask);
> +
> +	has_blocked_load = cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(sd));
> +
> +	for_each_cpu(cpu, cpus) {
> +		struct rq *rq = cpu_rq(cpu);
> +
> +		has_blocked_load |= update_nohz_stats(rq, true);
> +	}
> +
> +	if (has_blocked_load)
> +		WRITE_ONCE(nohz.has_blocked, 1);
> +}
> +

we duplicate what is done in nohe_idle_balance

>  /*
>   * idle_balance is called by schedule() if this_cpu is about to become
>   * idle. Attempts to pull tasks from other CPUs.
> @@ -8868,6 +8891,7 @@ static int idle_balance(struct rq *this_
>  	struct sched_domain *sd;
>  	int pulled_task = 0;
>  	u64 curr_cost = 0;
> +	bool nohz_blocked = false;
>  
>  	/*
>  	 * We must set idle_stamp _before_ calling idle_balance(), such that we
> @@ -8889,8 +8913,8 @@ static int idle_balance(struct rq *this_
>  	 */
>  	rq_unpin_lock(this_rq, rf);
>  
> -	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
> -	    !this_rq->rd->overload) {
> +	if (this_rq->avg_idle < sysctl_sched_migration_cost) {
> +short_idle:
>  		rcu_read_lock();
>  		sd = rcu_dereference_check_sched_domain(this_rq->sd);
>  		if (sd)
> @@ -8900,6 +8924,18 @@ static int idle_balance(struct rq *this_
>  		goto out;
>  	}
>  
> +	if (!this_rq->rd->overload) {
> +#ifdef CONFIG_NO_HZ_COMMON
> +		unsigned int has_blocked = READ_ONCE(nohz.has_blocked);
> +		unsigned long next_blocked = READ_ONE(nohz.next_blocked);
> +
> +		if (has_blocked && time_after_eq(jiffies, next_blocked))
> +			nohz_blocked = true;
> +		else
> +#endif
> +		goto short_idle;
> +	}
> +
>  	raw_spin_unlock(&this_rq->lock);
>  
>  	update_blocked_averages(this_cpu);
> @@ -8919,9 +8955,13 @@ static int idle_balance(struct rq *this_
>  		if (sd->flags & SD_BALANCE_NEWIDLE) {
>  			t0 = sched_clock_cpu(this_cpu);
>  
> -			pulled_task = load_balance(this_cpu, this_rq,
> -						   sd, CPU_NEWLY_IDLE,
> -						   &continue_balancing);
> +			if (nohz_blocked) {
> +				nohz_age(sd);

Do we really need to loop all sched_domain of newly idle CPU and call
nohz_age for each level ?
Can't we only call  nohz_age with the widest/last sched_domain level ?

Furthermore, we use sd->max_newidle_lb_cost to decide to abort the loop.
But this is updated with full load balancing which is longer than just
updating blocked load.
This will increase the chance to abort before reaching the last level.

> +			} else {
> +				pulled_task = load_balance(this_cpu, this_rq,
> +						sd, CPU_NEWLY_IDLE,
> +						&continue_balancing);
> +			}
>  
>  			domain_cost = sched_clock_cpu(this_cpu) - t0;
>  			if (domain_cost > sd->max_newidle_lb_cost)

We have to kick an ilb if we must abort before looping all levels and all
idle CPUs otherwise we can have situation where the load of some idle CPus
could stay blocked

> @@ -9497,8 +9537,7 @@ static bool nohz_idle_balance(struct rq
>  
>  		rq = cpu_rq(balance_cpu);
>  
> -		update_blocked_averages(rq->cpu);
> -		has_blocked_load |= rq->has_blocked_load;
> +		has_blocked_load |= update_nohz_stats(rq, true);
>  
>  		/*
>  		 * If time for next balance is due,
