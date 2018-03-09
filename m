Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751114AbeCIJGt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:06:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34707 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeCIJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:06:47 -0500
Date: Fri, 9 Mar 2018 01:06:26 -0800
From: tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-31e77c93e432dec79c7d90b888bbfc3652592741@git.kernel.org>
Cc: vincent.guittot@linaro.org, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        vincent.guittot@linaro.org
In-Reply-To: <1518622006-16089-4-git-send-email-vincent.guittot@linaro.org>
References: <1518622006-16089-4-git-send-email-vincent.guittot@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Update blocked load when newly idle
Git-Commit-ID: 31e77c93e432dec79c7d90b888bbfc3652592741
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

Commit-ID:  31e77c93e432dec79c7d90b888bbfc3652592741
Gitweb:     https://git.kernel.org/tip/31e77c93e432dec79c7d90b888bbfc3652592741
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Wed, 14 Feb 2018 16:26:46 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 07:59:28 +0100

sched/fair: Update blocked load when newly idle

When NEWLY_IDLE load balance is not triggered, we might need to update the
blocked load anyway. We can kick an ilb so an idle CPU will take care of
updating blocked load or we can try to update them locally before entering
idle. In the latter case, we reuse part of the nohz_idle_balance.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: brendan.jackman@arm.com
Cc: dietmar.eggemann@arm.com
Cc: morten.rasmussen@foss.arm.com
Cc: valentin.schneider@arm.com
Link: http://lkml.kernel.org/r/1518622006-16089-4-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 105 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 87 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 058badcfa94b..3582117e1580 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9375,10 +9375,14 @@ out:
 }
 
 /*
- * In CONFIG_NO_HZ_COMMON case, the idle balance kickee will do the
- * rebalancing for all the CPUs for whom scheduler ticks are stopped.
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
@@ -9386,20 +9390,10 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
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
@@ -9443,10 +9437,10 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
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
@@ -9458,13 +9452,21 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
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
@@ -9478,15 +9480,79 @@ abort:
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
+
+static void nohz_newidle_balance(struct rq *this_rq)
+{
+	int this_cpu = this_rq->cpu;
+
+	/*
+	 * This CPU doesn't want to be disturbed by scheduler
+	 * housekeeping
+	 */
+	if (!housekeeping_cpu(this_cpu, HK_FLAG_SCHED))
+		return;
+
+	/* Will wake up very soon. No time for doing anything else*/
+	if (this_rq->avg_idle < sysctl_sched_migration_cost)
+		return;
+
+	/* Don't need to update blocked load of idle CPUs*/
+	if (!READ_ONCE(nohz.has_blocked) ||
+	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))
+		return;
+
+	raw_spin_unlock(&this_rq->lock);
+	/*
+	 * This CPU is going to be idle and blocked load of idle CPUs
+	 * need to be updated. Run the ilb locally as it is a good
+	 * candidate for ilb instead of waking up another idle CPU.
+	 * Kick an normal ilb if we failed to do the update.
+	 */
+	if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
+		kick_ilb(NOHZ_STATS_KICK);
+	raw_spin_lock(&this_rq->lock);
+}
+
 #else /* !CONFIG_NO_HZ_COMMON */
 static inline void nohz_balancer_kick(struct rq *rq) { }
 
-static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
+static inline bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 {
 	return false;
 }
+
+static inline void nohz_newidle_balance(struct rq *this_rq) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
@@ -9523,12 +9589,15 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
 	    !this_rq->rd->overload) {
+
 		rcu_read_lock();
 		sd = rcu_dereference_check_sched_domain(this_rq->sd);
 		if (sd)
 			update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
 
+		nohz_newidle_balance(this_rq);
+
 		goto out;
 	}
 
