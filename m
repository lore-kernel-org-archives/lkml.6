Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425706AbeBOQVb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:21:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57094 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425690AbeBOQV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:21:27 -0500
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCH 2/7] sched/fair: Add group_misfit_task load-balance type
Date: Thu, 15 Feb 2018 16:20:49 +0000
Message-Id: <1518711654-23503-3-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To maximize throughput in systems with asymmetric cpu capacities (e.g.
ARM big.LITTLE) load-balancing has to consider task and cpu utilization
as well as per-cpu compute capacity when load-balancing in addition to
the current average load based load-balancing policy. Tasks with high
utilization that are scheduled on a lower capacity cpu need to be
identified and migrated to a higher capacity cpu if possible to maximize
throughput.

To implement this additional policy an additional group_type
(load-balance scenario) is added: group_misfit_task. This represents
scenarios where a sched_group has one or more tasks that are not
suitable for its per-cpu capacity. group_misfit_task is only considered
if the system is not overloaded or imbalanced (group_imbalanced or
group_overloaded).

Identifying misfit tasks requires the rq lock to be held. To avoid
taking remote rq locks to examine source sched_groups for misfit tasks,
each cpu is responsible for tracking misfit tasks themselves and update
the rq->misfit_task flag. This means checking task utilization when
tasks are scheduled and on sched_tick.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c  | 57 +++++++++++++++++++++++++++++++++++++++++++---------
 kernel/sched/sched.h |  2 ++
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 452ad2e6f1a0..bdca97ea516e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -712,6 +712,7 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
 static unsigned long task_h_load(struct task_struct *p);
+static unsigned long capacity_of(int cpu);
 
 /* Give new sched_entity start runnable values to heavy its load in infant time */
 void init_entity_runnable_average(struct sched_entity *se)
@@ -1422,7 +1423,6 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 static unsigned long weighted_cpuload(struct rq *rq);
 static unsigned long source_load(int cpu, int type);
 static unsigned long target_load(int cpu, int type);
-static unsigned long capacity_of(int cpu);
 
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
@@ -3869,6 +3869,30 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 
 static int idle_balance(struct rq *this_rq, struct rq_flags *rf);
 
+static inline unsigned long task_util(struct task_struct *p);
+static inline int task_fits_capacity(struct task_struct *p, long capacity)
+{
+	return capacity * 1024 > task_util(p) * capacity_margin;
+}
+
+static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
+{
+	if (!static_branch_unlikely(&sched_asym_cpucapacity))
+		return;
+
+	if (!p) {
+		rq->misfit_task_load = 0;
+		return;
+	}
+
+	if (task_fits_capacity(p, capacity_of(cpu_of(rq)))) {
+		rq->misfit_task_load = 0;
+		return;
+	}
+
+	rq->misfit_task_load = task_h_load(p);
+}
+
 #else /* CONFIG_SMP */
 
 static inline int
@@ -3898,6 +3922,8 @@ static inline int idle_balance(struct rq *rq, struct rq_flags *rf)
 	return 0;
 }
 
+static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
+
 #endif /* CONFIG_SMP */
 
 static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -5767,7 +5793,6 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	return affine;
 }
 
-static inline unsigned long task_util(struct task_struct *p);
 static unsigned long cpu_util_wake(int cpu, struct task_struct *p);
 
 static unsigned long capacity_spare_wake(int cpu, struct task_struct *p)
@@ -6304,7 +6329,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 	/* Bring task utilization in sync with prev_cpu */
 	sync_entity_load_avg(&p->se);
 
-	return min_cap * 1024 < task_util(p) * capacity_margin;
+	return task_fits_capacity(p, min_cap);
 }
 
 /*
@@ -6733,9 +6758,12 @@ done: __maybe_unused
 	if (hrtick_enabled(rq))
 		hrtick_start_fair(rq, p);
 
+	update_misfit_status(p, rq);
+
 	return p;
 
 idle:
+	update_misfit_status(NULL, rq);
 	new_tasks = idle_balance(rq, rf);
 
 	/*
@@ -6941,6 +6969,13 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
 
 enum fbq_type { regular, remote, all };
 
+enum group_type {
+	group_other = 0,
+	group_misfit_task,
+	group_imbalanced,
+	group_overloaded,
+};
+
 #define LBF_ALL_PINNED	0x01
 #define LBF_NEED_BREAK	0x02
 #define LBF_DST_PINNED  0x04
@@ -7453,12 +7488,6 @@ static unsigned long task_h_load(struct task_struct *p)
 
 /********** Helpers for find_busiest_group ************************/
 
-enum group_type {
-	group_other = 0,
-	group_imbalanced,
-	group_overloaded,
-};
-
 /*
  * sg_lb_stats - stats of a sched_group required for load_balancing
  */
@@ -7474,6 +7503,7 @@ struct sg_lb_stats {
 	unsigned int group_weight;
 	enum group_type group_type;
 	int group_no_capacity;
+	int group_misfit_task_load; /* A cpu has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
@@ -7773,6 +7803,9 @@ group_type group_classify(struct sched_group *group,
 	if (sg_imbalanced(group))
 		return group_imbalanced;
 
+	if (sgs->group_misfit_task_load)
+		return group_misfit_task;
+
 	return group_other;
 }
 
@@ -7822,6 +7855,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		 */
 		if (!nr_running && idle_cpu(i))
 			sgs->idle_cpus++;
+
+		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
+		    !sgs->group_misfit_task_load && rq->misfit_task_load)
+			sgs->group_misfit_task_load = rq->misfit_task_load;
 	}
 
 	/* Adjust by relative CPU capacity of the group */
@@ -9436,6 +9473,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
+
+	update_misfit_status(curr, rq);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a06184906640..7d324b706e67 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -771,6 +771,8 @@ struct rq {
 	struct callback_head *balance_callback;
 
 	unsigned char idle_balance;
+
+	unsigned int misfit_task_load;
 	/* For active balancing */
 	int active_balance;
 	int push_cpu;
-- 
2.7.4
