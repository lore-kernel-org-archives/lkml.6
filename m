Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425724AbeBOQVg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:21:36 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57130 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425708AbeBOQVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:21:34 -0500
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCH 6/7] sched: Rename root_domain->overload to should_idle_balance
Date: Thu, 15 Feb 2018 16:20:53 +0000
Message-Id: <1518711654-23503-7-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

The name "overload" is not very explicit, especially since it doesn't
use any concept of "load" coming from load-tracking signals. For now it
simply tracks if any of the CPUs in root_domain has more than one
runnable task, and is then used to decide whether idle balance should be
performed.

As such, this commit changes that flag's name to 'should_idle_balance',
which makes its role more explicit.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c  | 18 +++++++++---------
 kernel/sched/sched.h | 12 ++++++++----
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1439b784b1f0..2d2302b7b584 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7830,12 +7830,12 @@ group_type group_classify(struct sched_group *group,
  * @load_idx: Load index of sched_domain of this_cpu for load calc.
  * @local_group: Does group contain this_cpu.
  * @sgs: variable to hold the statistics for this group.
- * @overload: Indicate more than one runnable task for any CPU.
+ * @should_idle_balance: Indicate groups could need idle balance.
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
 			struct sched_group *group, int load_idx,
 			int local_group, struct sg_lb_stats *sgs,
-			bool *overload)
+			bool *should_idle_balance)
 {
 	unsigned long load;
 	int i, nr_running;
@@ -7857,7 +7857,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		nr_running = rq->nr_running;
 		if (nr_running > 1)
-			*overload = true;
+			*should_idle_balance = true;
 
 #ifdef CONFIG_NUMA_BALANCING
 		sgs->nr_numa_running += rq->nr_numa_running;
@@ -8016,7 +8016,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
 	int load_idx, prefer_sibling = 0;
-	bool overload = false;
+	bool should_idle_balance = false;
 
 	if (child && child->flags & SD_PREFER_SIBLING)
 		prefer_sibling = 1;
@@ -8038,7 +8038,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		}
 
 		update_sg_lb_stats(env, sg, load_idx, local_group, sgs,
-						&overload);
+						&should_idle_balance);
 
 		if (local_group)
 			goto next_group;
@@ -8078,9 +8078,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
 
 	if (!env->sd->parent) {
-		/* update overload indicator if we are at root domain */
-		if (env->dst_rq->rd->overload != overload)
-			env->dst_rq->rd->overload = overload;
+		/* update idle_balance indicator if we are at root domain */
+		if (env->dst_rq->rd->should_idle_balance != should_idle_balance)
+			env->dst_rq->rd->should_idle_balance = should_idle_balance;
 	}
 }
 
@@ -8878,7 +8878,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	rq_unpin_lock(this_rq, rf);
 
 	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !this_rq->rd->overload) {
+	    !this_rq->rd->should_idle_balance) {
 		rcu_read_lock();
 		sd = rcu_dereference_check_sched_domain(this_rq->sd);
 		if (sd)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7d324b706e67..4215438667e5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -650,8 +650,12 @@ struct root_domain {
 	cpumask_var_t span;
 	cpumask_var_t online;
 
-	/* Indicate more than one runnable task for any CPU */
-	bool overload;
+	/*
+	 * Indicate whether the idle balance can be used to solve
+	 * imbalance within the root domain.
+	 * e.g. There is more than one runnable task for any CPU
+	 */
+	bool should_idle_balance;
 
 	/*
 	 * The bit corresponding to a CPU gets set here if such CPU has more
@@ -1610,8 +1614,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 
 	if (prev_nr < 2 && rq->nr_running >= 2) {
 #ifdef CONFIG_SMP
-		if (!rq->rd->overload)
-			rq->rd->overload = true;
+		if (!rq->rd->should_idle_balance)
+			rq->rd->should_idle_balance = true;
 #endif
 	}
 
-- 
2.7.4
