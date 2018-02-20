Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbeBTNDP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:03:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46636 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752134AbeBTNCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:02:09 -0500
Date: Tue, 20 Feb 2018 12:59:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, morten.rasmussen@foss.arm.com,
        brendan.jackman@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v5 3/3] sched: update blocked load when newly idle
Message-ID: <20180220115917.GA25201@hirez.programming.kicks-ass.net>
References: <1518622006-16089-1-git-send-email-vincent.guittot@linaro.org>
 <1518622006-16089-4-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518622006-16089-4-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 04:26:46PM +0100, Vincent Guittot wrote:
> When NEWLY_IDLE load balance is not triggered, we might need to update the
> blocked load anyway. We can kick an ilb so an idle CPU will take care of
> updating blocked load or we can try to update them locally before entering
> idle. In the latter case, we reuse part of the nohz_idle_balance.

So I still don't like this, but then I couldn't come up with anything I
did like either. Munged the patch a bit, I pulled out the code movement
into a separate patch and otherwise reduced #ifdeffery a bit.

---
Subject: sched: update blocked load when newly idle
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 14 Feb 2018 16:26:46 +0100

When NEWLY_IDLE load balance is not triggered, we might need to update the
blocked load anyway. We can kick an ilb so an idle CPU will take care of
updating blocked load or we can try to update them locally before entering
idle. In the latter case, we reuse part of the nohz_idle_balance.

Cc: valentin.schneider@arm.com
Cc: mingo@kernel.org
Cc: brendan.jackman@arm.com
Cc: dietmar.eggemann@arm.com
Cc: morten.rasmussen@foss.arm.com
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1518622006-16089-4-git-send-email-vincent.guittot@linaro.org
---
 kernel/sched/fair.c |  105 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 87 insertions(+), 18 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9394,10 +9394,14 @@ void nohz_balance_enter_idle(int cpu)
 }
 
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
@@ -9405,20 +9409,10 @@ static bool nohz_idle_balance(struct rq
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
@@ -9462,10 +9456,10 @@ static bool nohz_idle_balance(struct rq
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
@@ -9477,13 +9471,21 @@ static bool nohz_idle_balance(struct rq
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
@@ -9497,15 +9499,79 @@ static bool nohz_idle_balance(struct rq
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
@@ -9542,12 +9608,15 @@ static int idle_balance(struct rq *this_
 
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
 
