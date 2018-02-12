Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753876AbeBLMET (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:04:19 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44878 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbeBLMER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:04:17 -0500
Date: Mon, 12 Feb 2018 13:04:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, morten.rasmussen@foss.arm.com,
        brendan.jackman@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/3] sched: update blocked load when newly idle
Message-ID: <20180212120411.GT25201@hirez.programming.kicks-ass.net>
References: <1518422874-13216-1-git-send-email-vincent.guittot@linaro.org>
 <1518422874-13216-4-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518422874-13216-4-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 09:07:54AM +0100, Vincent Guittot wrote:
> @@ -8863,12 +8866,26 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>  
>  	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
>  	    !this_rq->rd->overload) {
> +		unsigned long has_blocked = READ_ONCE(nohz.has_blocked);
> +		unsigned long next_blocked = READ_ONCE(nohz.next_blocked);
> +
>  		rcu_read_lock();
>  		sd = rcu_dereference_check_sched_domain(this_rq->sd);
>  		if (sd)
>  			update_next_balance(sd, &next_balance);
>  		rcu_read_unlock();
>  
> +		/*
> +		 * Update blocked idle load if it has not been done for a
> +		 * while. Try to do it locally before entering idle but kick a
> +		 * ilb if it takes too much time and/or might delay next local
> +		 * wake up
> +		 */
> +		if (has_blocked && time_after_eq(jiffies, next_blocked) &&
> +				(this_rq->avg_idle < sysctl_sched_migration_cost ||
> +				!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE)))
> +			kick_ilb(NOHZ_STATS_KICK);
> +
>  		goto out;
>  	}

So I really hate this one, also I suspect its broken, because we do this
check before dropping rq->lock and _nohz_idle_balance() will take
rq->lock.

Aside from the above being an unreadable mess, I dislike that it breaks
the various isolation crud, we should not touch CPUs outside of our
domain.

Maybe something like the below? (unfinished)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7839,7 +7839,7 @@ group_type group_classify(struct sched_g
 	return group_other;
 }
 
-static bool update_nohz_stats(struct rq *rq)
+static bool update_nohz_stats(struct rq *rq, bool force)
 {
 #ifdef CONFIG_NO_HZ_COMMON
 	unsigned int cpu = rq->cpu;
@@ -7850,7 +7850,7 @@ static bool update_nohz_stats(struct rq
 	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
 		return false;
 
-	if (!time_after(jiffies, rq->last_blocked_load_update_tick))
+	if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
 		return true;
 
 	update_blocked_averages(cpu);
@@ -7883,7 +7883,7 @@ static inline void update_sg_lb_stats(st
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
 
-		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq))
+		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
 			env->flags |= LBF_NOHZ_AGAIN;
 
 		/* Bias balancing toward cpus of our domain */
@@ -8857,6 +8857,29 @@ update_next_balance(struct sched_domain
 		*next_balance = next;
 }
 
+static int nohz_age(struct sched_domain *sd)
+{
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(load_balance_mask);
+	bool has_blocked_load;
+
+	WRITE_ONCE(nohz.has_blocked, 0);
+
+	smp_mb();
+
+	cpumask_and(cpus, sched_domain_span(sd), nohz.idle_cpus_mask);
+
+	has_blocked_load = cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(sd));
+
+	for_each_cpu(cpu, cpus) {
+		struct rq *rq = cpu_rq(cpu);
+
+		has_blocked_load |= update_nohz_stats(rq, true);
+	}
+
+	if (has_blocked_load)
+		WRITE_ONCE(nohz.has_blocked, 1);
+}
+
 /*
  * idle_balance is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
@@ -8868,6 +8891,7 @@ static int idle_balance(struct rq *this_
 	struct sched_domain *sd;
 	int pulled_task = 0;
 	u64 curr_cost = 0;
+	bool nohz_blocked = false;
 
 	/*
 	 * We must set idle_stamp _before_ calling idle_balance(), such that we
@@ -8889,8 +8913,8 @@ static int idle_balance(struct rq *this_
 	 */
 	rq_unpin_lock(this_rq, rf);
 
-	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !this_rq->rd->overload) {
+	if (this_rq->avg_idle < sysctl_sched_migration_cost) {
+short_idle:
 		rcu_read_lock();
 		sd = rcu_dereference_check_sched_domain(this_rq->sd);
 		if (sd)
@@ -8900,6 +8924,18 @@ static int idle_balance(struct rq *this_
 		goto out;
 	}
 
+	if (!this_rq->rd->overload) {
+#ifdef CONFIG_NO_HZ_COMMON
+		unsigned int has_blocked = READ_ONCE(nohz.has_blocked);
+		unsigned long next_blocked = READ_ONE(nohz.next_blocked);
+
+		if (has_blocked && time_after_eq(jiffies, next_blocked))
+			nohz_blocked = true;
+		else
+#endif
+		goto short_idle;
+	}
+
 	raw_spin_unlock(&this_rq->lock);
 
 	update_blocked_averages(this_cpu);
@@ -8919,9 +8955,13 @@ static int idle_balance(struct rq *this_
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
 			t0 = sched_clock_cpu(this_cpu);
 
-			pulled_task = load_balance(this_cpu, this_rq,
-						   sd, CPU_NEWLY_IDLE,
-						   &continue_balancing);
+			if (nohz_blocked) {
+				nohz_age(sd);
+			} else {
+				pulled_task = load_balance(this_cpu, this_rq,
+						sd, CPU_NEWLY_IDLE,
+						&continue_balancing);
+			}
 
 			domain_cost = sched_clock_cpu(this_cpu) - t0;
 			if (domain_cost > sd->max_newidle_lb_cost)
@@ -9497,8 +9537,7 @@ static bool nohz_idle_balance(struct rq
 
 		rq = cpu_rq(balance_cpu);
 
-		update_blocked_averages(rq->cpu);
-		has_blocked_load |= rq->has_blocked_load;
+		has_blocked_load |= update_nohz_stats(rq, true);
 
 		/*
 		 * If time for next balance is due,
