Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeCIJEG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:04:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51199 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeCIJED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:04:03 -0500
Date: Fri, 9 Mar 2018 01:03:42 -0800
From: tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-f643ea2207010db26f17fca99db031bad87c8461@git.kernel.org>
Cc: mingo@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, peterz@infradead.org
Reply-To: tglx@linutronix.de, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org, peterz@infradead.org
In-Reply-To: <1518517879-2280-2-git-send-email-vincent.guittot@linaro.org>
References: <1518517879-2280-2-git-send-email-vincent.guittot@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/nohz: Stop NOHZ stats when decayed
Git-Commit-ID: f643ea2207010db26f17fca99db031bad87c8461
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f643ea2207010db26f17fca99db031bad87c8461
Gitweb:     https://git.kernel.org/tip/f643ea2207010db26f17fca99db031bad87c8461
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Tue, 13 Feb 2018 11:31:17 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 07:59:21 +0100

sched/nohz: Stop NOHZ stats when decayed

Stopped the periodic update of blocked load when all idle CPUs have fully
decayed. We introduce a new nohz.has_blocked that reflect if some idle
CPUs has blocked load that have to be periodiccally updated. nohz.has_blocked
is set everytime that a Idle CPU can have blocked load and it is then clear
when no more blocked load has been detected during an update. We don't need
atomic operation but only to make cure of the right ordering when updating
nohz.idle_cpus_mask and nohz.has_blocked.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: brendan.jackman@arm.com
Cc: dietmar.eggemann@arm.com
Cc: morten.rasmussen@foss.arm.com
Cc: valentin.schneider@arm.com
Link: http://lkml.kernel.org/r/1518517879-2280-2-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 116 ++++++++++++++++++++++++++++++++++++++++++---------
 kernel/sched/sched.h |   1 +
 2 files changed, 97 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e8f5efe2936c..78b06a0814d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5387,8 +5387,9 @@ decay_load_missed(unsigned long load, unsigned long missed_updates, int idx)
 static struct {
 	cpumask_var_t idle_cpus_mask;
 	atomic_t nr_cpus;
+	int has_blocked;		/* Idle CPUS has blocked load */
 	unsigned long next_balance;     /* in jiffy units */
-	unsigned long next_stats;
+	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
 } nohz ____cacheline_aligned;
 
 #endif /* CONFIG_NO_HZ_COMMON */
@@ -7038,6 +7039,7 @@ enum fbq_type { regular, remote, all };
 #define LBF_DST_PINNED  0x04
 #define LBF_SOME_PINNED	0x08
 #define LBF_NOHZ_STATS	0x10
+#define LBF_NOHZ_AGAIN	0x20
 
 struct lb_env {
 	struct sched_domain	*sd;
@@ -7422,8 +7424,6 @@ static void attach_tasks(struct lb_env *env)
 	rq_unlock(env->dst_rq, &rf);
 }
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
-
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
 	if (cfs_rq->load.weight)
@@ -7441,11 +7441,14 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	return true;
 }
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+
 static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq, *pos;
 	struct rq_flags rf;
+	bool done = true;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
@@ -7475,10 +7478,14 @@ static void update_blocked_averages(int cpu)
 		 */
 		if (cfs_rq_is_decayed(cfs_rq))
 			list_del_leaf_cfs_rq(cfs_rq);
+		else
+			done = false;
 	}
 
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
+	if (done)
+		rq->has_blocked_load = 0;
 #endif
 	rq_unlock_irqrestore(rq, &rf);
 }
@@ -7541,6 +7548,8 @@ static inline void update_blocked_averages(int cpu)
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
+	if (cfs_rq_is_decayed(cfs_rq))
+		rq->has_blocked_load = 0;
 #endif
 	rq_unlock_irqrestore(rq, &rf);
 }
@@ -7876,18 +7885,25 @@ group_type group_classify(struct sched_group *group,
 	return group_other;
 }
 
-static void update_nohz_stats(struct rq *rq)
+static bool update_nohz_stats(struct rq *rq)
 {
 #ifdef CONFIG_NO_HZ_COMMON
 	unsigned int cpu = rq->cpu;
 
+	if (!rq->has_blocked_load)
+		return false;
+
 	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
-		return;
+		return false;
 
 	if (!time_after(jiffies, rq->last_blocked_load_update_tick))
-		return;
+		return true;
 
 	update_blocked_averages(cpu);
+
+	return rq->has_blocked_load;
+#else
+	return false;
 #endif
 }
 
@@ -7913,8 +7929,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
 
-		if (env->flags & LBF_NOHZ_STATS)
-			update_nohz_stats(rq);
+		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq))
+			env->flags |= LBF_NOHZ_AGAIN;
 
 		/* Bias balancing toward CPUs of our domain: */
 		if (local_group)
@@ -8072,12 +8088,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		prefer_sibling = 1;
 
 #ifdef CONFIG_NO_HZ_COMMON
-	if (env->idle == CPU_NEWLY_IDLE) {
+	if (env->idle == CPU_NEWLY_IDLE && READ_ONCE(nohz.has_blocked))
 		env->flags |= LBF_NOHZ_STATS;
-
-		if (cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd)))
-			nohz.next_stats = jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD);
-	}
 #endif
 
 	load_idx = get_sd_load_idx(env->sd, env->idle);
@@ -8133,6 +8145,15 @@ next_group:
 		sg = sg->next;
 	} while (sg != env->sd->groups);
 
+#ifdef CONFIG_NO_HZ_COMMON
+	if ((env->flags & LBF_NOHZ_AGAIN) &&
+	    cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
+
+		WRITE_ONCE(nohz.next_blocked,
+			   jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD));
+	}
+#endif
+
 	if (env->sd->flags & SD_NUMA)
 		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
 
@@ -9174,7 +9195,8 @@ static void nohz_balancer_kick(struct rq *rq)
 	if (likely(!atomic_read(&nohz.nr_cpus)))
 		return;
 
-	if (time_after(now, nohz.next_stats))
+	if (READ_ONCE(nohz.has_blocked) &&
+	    time_after(now, READ_ONCE(nohz.next_blocked)))
 		flags = NOHZ_STATS_KICK;
 
 	if (time_before(now, nohz.next_balance))
@@ -9293,8 +9315,21 @@ void nohz_balance_enter_idle(int cpu)
 	if (!housekeeping_cpu(cpu, HK_FLAG_SCHED))
 		return;
 
+	/*
+	 * Can be set safely without rq->lock held
+	 * If a clear happens, it will have evaluated last additions because
+	 * rq->lock is held during the check and the clear
+	 */
+	rq->has_blocked_load = 1;
+
+	/*
+	 * The tick is still stopped but load could have been added in the
+	 * meantime. We set the nohz.has_blocked flag to trig a check of the
+	 * *_avg. The CPU is already part of nohz.idle_cpus_mask so the clear
+	 * of nohz.has_blocked can only happen after checking the new load
+	 */
 	if (rq->nohz_tick_stopped)
-		return;
+		goto out;
 
 	/* If we're a completely isolated CPU, we don't play: */
 	if (on_null_domain(rq))
@@ -9305,7 +9340,21 @@ void nohz_balance_enter_idle(int cpu)
 	cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
 	atomic_inc(&nohz.nr_cpus);
 
+	/*
+	 * Ensures that if nohz_idle_balance() fails to observe our
+	 * @idle_cpus_mask store, it must observe the @has_blocked
+	 * store.
+	 */
+	smp_mb__after_atomic();
+
 	set_cpu_sd_state_idle(cpu);
+
+out:
+	/*
+	 * Each time a cpu enter idle, we assume that it has blocked load and
+	 * enable the periodic update of the load of idle cpus
+	 */
+	WRITE_ONCE(nohz.has_blocked, 1);
 }
 #else
 static inline void nohz_balancer_kick(struct rq *rq) { }
@@ -9439,7 +9488,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 	/* Earliest time when we have to do rebalance again */
 	unsigned long now = jiffies;
 	unsigned long next_balance = now + 60*HZ;
-	unsigned long next_stats = now + msecs_to_jiffies(LOAD_AVG_PERIOD);
+	bool has_blocked_load = false;
 	int update_next_balance = 0;
 	int this_cpu = this_rq->cpu;
 	unsigned int flags;
@@ -9458,6 +9507,22 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 
 	SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
 
+	/*
+	 * We assume there will be no idle load after this update and clear
+	 * the has_blocked flag. If a cpu enters idle in the mean time, it will
+	 * set the has_blocked flag and trig another update of idle load.
+	 * Because a cpu that becomes idle, is added to idle_cpus_mask before
+	 * setting the flag, we are sure to not clear the state and not
+	 * check the load of an idle cpu.
+	 */
+	WRITE_ONCE(nohz.has_blocked, 0);
+
+	/*
+	 * Ensures that if we miss the CPU, we must see the has_blocked
+	 * store from nohz_balance_enter_idle().
+	 */
+	smp_mb();
+
 	for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
 		if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
 			continue;
@@ -9467,11 +9532,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 		 * work being done for other CPUs. Next load
 		 * balancing owner will pick it up.
 		 */
-		if (need_resched())
-			break;
+		if (need_resched()) {
+			has_blocked_load = true;
+			goto abort;
+		}
 
 		rq = cpu_rq(balance_cpu);
 
+		update_blocked_averages(rq->cpu);
+		has_blocked_load |= rq->has_blocked_load;
+
 		/*
 		 * If time for next balance is due,
 		 * do the balance.
@@ -9484,7 +9554,6 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 			cpu_load_update_idle(rq);
 			rq_unlock_irq(rq, &rf);
 
-			update_blocked_averages(rq->cpu);
 			if (flags & NOHZ_BALANCE_KICK)
 				rebalance_domains(rq, CPU_IDLE);
 		}
@@ -9499,7 +9568,13 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 	if (flags & NOHZ_BALANCE_KICK)
 		rebalance_domains(this_rq, CPU_IDLE);
 
-	nohz.next_stats = next_stats;
+	WRITE_ONCE(nohz.next_blocked,
+		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
+
+abort:
+	/* There is still blocked load, enable periodic update */
+	if (has_blocked_load)
+		WRITE_ONCE(nohz.has_blocked, 1);
 
 	/*
 	 * next_balance will be updated only when there is a need.
@@ -10135,6 +10210,7 @@ __init void init_sched_fair_class(void)
 
 #ifdef CONFIG_NO_HZ_COMMON
 	nohz.next_balance = jiffies;
+	nohz.next_blocked = jiffies;
 	zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
 #endif
 #endif /* SMP */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 818f22dbc7ea..22909ffc04fb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -763,6 +763,7 @@ struct rq {
 #ifdef CONFIG_SMP
 	unsigned long		last_load_update_tick;
 	unsigned long		last_blocked_load_update_tick;
+	unsigned int		has_blocked_load;
 #endif /* CONFIG_SMP */
 	unsigned int		nohz_tick_stopped;
 	atomic_t nohz_flags;
