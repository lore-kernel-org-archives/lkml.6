Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934400AbeBMKcL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:32:11 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38558 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933849AbeBMKbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:31:31 -0500
X-Google-Smtp-Source: AH8x225KmdBfWV15AgRnR51iepjA31Aj9diHXzQ1H1R6I/sorWsiBmZNx5XihA3hEc2PYC29lCKy3g==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Cc: morten.rasmussen@foss.arm.com, brendan.jackman@arm.com,
        dietmar.eggemann@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/3] sched: update blocked load when newly idle
Date: Tue, 13 Feb 2018 11:31:19 +0100
Message-Id: <1518517879-2280-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518517879-2280-1-git-send-email-vincent.guittot@linaro.org>
References: <1518517879-2280-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When NEWLY_IDLE load balance is not triggered, we might need to update the
blocked load anyway. We can kick an ilb so an idle CPU will take care of
updating blocked load or we can try to update them locally before entering
idle. In the latter case, we reuse part of the nohz_idle_balance.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 324 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 193 insertions(+), 131 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9183fee..cb1ab5c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8832,120 +8832,6 @@ update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
 }
 
 /*
- * idle_balance is called by schedule() if this_cpu is about to become
- * idle. Attempts to pull tasks from other CPUs.
- */
-static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
-{
-	unsigned long next_balance = jiffies + HZ;
-	int this_cpu = this_rq->cpu;
-	struct sched_domain *sd;
-	int pulled_task = 0;
-	u64 curr_cost = 0;
-
-	/*
-	 * We must set idle_stamp _before_ calling idle_balance(), such that we
-	 * measure the duration of idle_balance() as idle time.
-	 */
-	this_rq->idle_stamp = rq_clock(this_rq);
-
-	/*
-	 * Do not pull tasks towards !active CPUs...
-	 */
-	if (!cpu_active(this_cpu))
-		return 0;
-
-	/*
-	 * This is OK, because current is on_cpu, which avoids it being picked
-	 * for load-balance and preemption/IRQs are still disabled avoiding
-	 * further scheduler activity on it and we're being very careful to
-	 * re-start the picking loop.
-	 */
-	rq_unpin_lock(this_rq, rf);
-
-	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !this_rq->rd->overload) {
-		rcu_read_lock();
-		sd = rcu_dereference_check_sched_domain(this_rq->sd);
-		if (sd)
-			update_next_balance(sd, &next_balance);
-		rcu_read_unlock();
-
-		goto out;
-	}
-
-	raw_spin_unlock(&this_rq->lock);
-
-	update_blocked_averages(this_cpu);
-	rcu_read_lock();
-	for_each_domain(this_cpu, sd) {
-		int continue_balancing = 1;
-		u64 t0, domain_cost;
-
-		if (!(sd->flags & SD_LOAD_BALANCE))
-			continue;
-
-		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
-			update_next_balance(sd, &next_balance);
-			break;
-		}
-
-		if (sd->flags & SD_BALANCE_NEWIDLE) {
-			t0 = sched_clock_cpu(this_cpu);
-
-			pulled_task = load_balance(this_cpu, this_rq,
-						   sd, CPU_NEWLY_IDLE,
-						   &continue_balancing);
-
-			domain_cost = sched_clock_cpu(this_cpu) - t0;
-			if (domain_cost > sd->max_newidle_lb_cost)
-				sd->max_newidle_lb_cost = domain_cost;
-
-			curr_cost += domain_cost;
-		}
-
-		update_next_balance(sd, &next_balance);
-
-		/*
-		 * Stop searching for tasks to pull if there are
-		 * now runnable tasks on this rq.
-		 */
-		if (pulled_task || this_rq->nr_running > 0)
-			break;
-	}
-	rcu_read_unlock();
-
-	raw_spin_lock(&this_rq->lock);
-
-	if (curr_cost > this_rq->max_idle_balance_cost)
-		this_rq->max_idle_balance_cost = curr_cost;
-
-	/*
-	 * While browsing the domains, we released the rq lock, a task could
-	 * have been enqueued in the meantime. Since we're not going idle,
-	 * pretend we pulled a task.
-	 */
-	if (this_rq->cfs.h_nr_running && !pulled_task)
-		pulled_task = 1;
-
-out:
-	/* Move the next balance forward */
-	if (time_after(this_rq->next_balance, next_balance))
-		this_rq->next_balance = next_balance;
-
-	/* Is there a task of a high priority class? */
-	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
-		pulled_task = -1;
-
-	if (pulled_task)
-		this_rq->idle_stamp = 0;
-
-	rq_repin_lock(this_rq, rf);
-
-	return pulled_task;
-}
-
-/*
  * active_load_balance_cpu_stop is run by cpu stopper. It pushes
  * running tasks off the busiest CPU onto idle CPUs. It requires at
  * least 1 task to be running on each physical CPU where possible, and
@@ -9413,10 +9299,14 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 
 #ifdef CONFIG_NO_HZ_COMMON
 /*
- * In CONFIG_NO_HZ_COMMON case, the idle balance kickee will do the
- * rebalancing for all the cpus for whom scheduler ticks are stopped.
+ * Internal function that runs load balance for all idle cpus. The load balance
+ * can be a simple update of blocked load or a complete load balance with
+ * tasks movement depending of flags.
+ * The function returns false if the loop has stopped before running
+ * through all idle CPUs.
  */
-static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
+static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
+			       enum cpu_idle_type idle)
 {
 	/* Earliest time when we have to do rebalance again */
 	unsigned long now = jiffies;
@@ -9424,20 +9314,10 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 	bool has_blocked_load = false;
 	int update_next_balance = 0;
 	int this_cpu = this_rq->cpu;
-	unsigned int flags;
 	int balance_cpu;
+	int ret = false;
 	struct rq *rq;
 
-	if (!(atomic_read(nohz_flags(this_cpu)) & NOHZ_KICK_MASK))
-		return false;
-
-	if (idle != CPU_IDLE) {
-		atomic_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
-		return false;
-	}
-
-	flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
-
 	SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
 
 	/*
@@ -9482,10 +9362,10 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 		if (time_after_eq(jiffies, rq->next_balance)) {
 			struct rq_flags rf;
 
-			rq_lock_irq(rq, &rf);
+			rq_lock_irqsave(rq, &rf);
 			update_rq_clock(rq);
 			cpu_load_update_idle(rq);
-			rq_unlock_irq(rq, &rf);
+			rq_unlock_irqrestore(rq, &rf);
 
 			if (flags & NOHZ_BALANCE_KICK)
 				rebalance_domains(rq, CPU_IDLE);
@@ -9497,13 +9377,21 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 		}
 	}
 
-	update_blocked_averages(this_cpu);
+	/* Newly idle CPU doesn't need an update */
+	if (idle != CPU_NEWLY_IDLE) {
+		update_blocked_averages(this_cpu);
+		has_blocked_load |= this_rq->has_blocked_load;
+	}
+
 	if (flags & NOHZ_BALANCE_KICK)
 		rebalance_domains(this_rq, CPU_IDLE);
 
 	WRITE_ONCE(nohz.next_blocked,
 		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
 
+	/* The full idle balance loop has been done */
+	ret = true;
+
 abort:
 	/* There is still blocked load, enable periodic update */
 	if (has_blocked_load)
@@ -9517,6 +9405,35 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 	if (likely(update_next_balance))
 		nohz.next_balance = next_balance;
 
+	return ret;
+}
+
+/*
+ * In CONFIG_NO_HZ_COMMON case, the idle balance kickee will do the
+ * rebalancing for all the cpus for whom scheduler ticks are stopped.
+ */
+static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
+{
+	int this_cpu = this_rq->cpu;
+	unsigned int flags;
+
+	if (!(atomic_read(nohz_flags(this_cpu)) & NOHZ_KICK_MASK))
+		return false;
+
+	if (idle != CPU_IDLE) {
+		atomic_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
+		return false;
+	}
+
+	/*
+	 * barrier, pairs with nohz_balance_enter_idle(), ensures ...
+	 */
+	flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
+	if (!(flags & NOHZ_KICK_MASK))
+		return false;
+
+	_nohz_idle_balance(this_rq, flags, idle);
+
 	return true;
 }
 #else
@@ -9527,6 +9444,151 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 #endif
 
 /*
+ * idle_balance is called by schedule() if this_cpu is about to become
+ * idle. Attempts to pull tasks from other CPUs.
+ */
+static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
+{
+	unsigned long next_balance = jiffies + HZ;
+	int this_cpu = this_rq->cpu;
+	struct sched_domain *sd;
+	int pulled_task = 0;
+	u64 curr_cost = 0;
+
+	/*
+	 * We must set idle_stamp _before_ calling idle_balance(), such that we
+	 * measure the duration of idle_balance() as idle time.
+	 */
+	this_rq->idle_stamp = rq_clock(this_rq);
+
+	/*
+	 * Do not pull tasks towards !active CPUs...
+	 */
+	if (!cpu_active(this_cpu))
+		return 0;
+
+	/*
+	 * This is OK, because current is on_cpu, which avoids it being picked
+	 * for load-balance and preemption/IRQs are still disabled avoiding
+	 * further scheduler activity on it and we're being very careful to
+	 * re-start the picking loop.
+	 */
+	rq_unpin_lock(this_rq, rf);
+
+	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
+	    !this_rq->rd->overload) {
+#ifdef CONFIG_NO_HZ_COMMON
+		unsigned long has_blocked = READ_ONCE(nohz.has_blocked);
+		unsigned long next_blocked = READ_ONCE(nohz.next_blocked);
+#endif
+		rcu_read_lock();
+		sd = rcu_dereference_check_sched_domain(this_rq->sd);
+		if (sd)
+			update_next_balance(sd, &next_balance);
+		rcu_read_unlock();
+
+#ifdef CONFIG_NO_HZ_COMMON
+		/*
+		 * This CPU doesn't want to be disturbed by scheduler
+		 * houskeeping
+		 */
+		if (!housekeeping_cpu(this_cpu, HK_FLAG_SCHED))
+			goto out;
+
+		/* Will wake up very soon. No time for fdoing anything else*/
+		if (this_rq->avg_idle < sysctl_sched_migration_cost)
+			goto out;
+
+		/* Don't need to update blocked load of idle CPUs*/
+		if (!has_blocked || time_after_eq(jiffies, next_blocked))
+			goto out;
+
+		raw_spin_unlock(&this_rq->lock);
+		/*
+		 * This CPU is going to be idle and blocked load of idle CPUs
+		 * need to be updated. Run the ilb locally as it is a good
+		 * candidate for ilb instead of waking up another idle CPU.
+		 * Kick an normal ilb if we failed to do the update.
+		 */
+		if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
+			kick_ilb(NOHZ_STATS_KICK);
+		raw_spin_lock(&this_rq->lock);
+#endif
+		goto out;
+	}
+
+	raw_spin_unlock(&this_rq->lock);
+
+	update_blocked_averages(this_cpu);
+	rcu_read_lock();
+	for_each_domain(this_cpu, sd) {
+		int continue_balancing = 1;
+		u64 t0, domain_cost;
+
+		if (!(sd->flags & SD_LOAD_BALANCE))
+			continue;
+
+		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
+			update_next_balance(sd, &next_balance);
+			break;
+		}
+
+		if (sd->flags & SD_BALANCE_NEWIDLE) {
+			t0 = sched_clock_cpu(this_cpu);
+
+			pulled_task = load_balance(this_cpu, this_rq,
+						   sd, CPU_NEWLY_IDLE,
+						   &continue_balancing);
+
+			domain_cost = sched_clock_cpu(this_cpu) - t0;
+			if (domain_cost > sd->max_newidle_lb_cost)
+				sd->max_newidle_lb_cost = domain_cost;
+
+			curr_cost += domain_cost;
+		}
+
+		update_next_balance(sd, &next_balance);
+
+		/*
+		 * Stop searching for tasks to pull if there are
+		 * now runnable tasks on this rq.
+		 */
+		if (pulled_task || this_rq->nr_running > 0)
+			break;
+	}
+	rcu_read_unlock();
+
+	raw_spin_lock(&this_rq->lock);
+
+	if (curr_cost > this_rq->max_idle_balance_cost)
+		this_rq->max_idle_balance_cost = curr_cost;
+
+	/*
+	 * While browsing the domains, we released the rq lock, a task could
+	 * have been enqueued in the meantime. Since we're not going idle,
+	 * pretend we pulled a task.
+	 */
+	if (this_rq->cfs.h_nr_running && !pulled_task)
+		pulled_task = 1;
+
+out:
+	/* Move the next balance forward */
+	if (time_after(this_rq->next_balance, next_balance))
+		this_rq->next_balance = next_balance;
+
+	/* Is there a task of a high priority class? */
+	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
+		pulled_task = -1;
+
+	if (pulled_task)
+		this_rq->idle_stamp = 0;
+
+	rq_repin_lock(this_rq, rf);
+
+	return pulled_task;
+}
+
+/*
  * run_rebalance_domains is triggered when needed from the scheduler tick.
  * Also triggered for nohz idle balancing (with nohz_balancing_kick set).
  */
-- 
2.7.4
