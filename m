Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933355AbeBVRCZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:02:25 -0500
Received: from foss.arm.com ([217.140.101.70]:45254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933317AbeBVRCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:02:22 -0500
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: [PATCH v5 2/4] sched/fair: use util_est in LB and WU paths
Date: Thu, 22 Feb 2018 17:01:51 +0000
Message-Id: <20180222170153.673-3-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180222170153.673-1-patrick.bellasi@arm.com>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the scheduler looks at the CPU utilization, the current PELT value
for a CPU is returned straight away. In certain scenarios this can have
undesired side effects on task placement.

For example, since the task utilization is decayed at wakeup time, when
a long sleeping big task is enqueued it does not add immediately a
significant contribution to the target CPU.
As a result we generate a race condition where other tasks can be placed
on the same CPU while it is still considered relatively empty.

In order to reduce this kind of race conditions, this patch introduces the
required support to integrate the usage of the CPU's estimated utilization
in cpu_util_wake as well as in update_sg_lb_stats.

The estimated utilization of a CPU is defined to be the maximum between
its PELT's utilization and the sum of the estimated utilization of the
tasks currently RUNNABLE on that CPU.
This allows to properly represent the spare capacity of a CPU which, for
example, has just got a big task running since a long sleep period.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Paul Turner <pjt@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v5:
 - always use int instead of long whenever possible (Peter)
 - add missing READ_ONCE barriers (Peter)

Changes in v4:
 - rebased on today's tip/sched/core (commit 460e8c3340a2)
 - ensure cpu_util_wake() is cpu_capacity_orig()'s clamped (Pavan)

Changes in v3:
 - rebased on today's tip/sched/core (commit 07881166a892)

Changes in v2:
 - rebase on top of v4.15-rc2
 - tested that overhauled PELT code does not affect the util_est
---
 kernel/sched/fair.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c8526687f107..8364771f7301 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6445,6 +6445,41 @@ static unsigned long cpu_util(int cpu)
 	return (util >= capacity) ? capacity : util;
 }
 
+/**
+ * cpu_util_est: estimated utilization for the specified CPU
+ * @cpu: the CPU to get the estimated utilization for
+ *
+ * The estimated utilization of a CPU is defined to be the maximum between its
+ * PELT's utilization and the sum of the estimated utilization of the tasks
+ * currently RUNNABLE on that CPU.
+ *
+ * This allows to properly represent the expected utilization of a CPU which
+ * has just got a big task running since a long sleep period. At the same time
+ * however it preserves the benefits of the "blocked utilization" in
+ * describing the potential for other tasks waking up on the same CPU.
+ *
+ * Return: the estimated utilization for the specified CPU
+ */
+static inline unsigned long cpu_util_est(int cpu)
+{
+	unsigned int util, util_est;
+	unsigned int capacity;
+	struct cfs_rq *cfs_rq;
+
+	if (!sched_feat(UTIL_EST))
+		return cpu_util(cpu);
+
+	cfs_rq = &cpu_rq(cpu)->cfs;
+	util = READ_ONCE(cfs_rq->avg.util_avg);
+	util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
+	util_est = max(util, util_est);
+
+	capacity = capacity_orig_of(cpu);
+	util_est = min(util_est, capacity);
+
+	return util_est;
+}
+
 static inline unsigned long task_util(struct task_struct *p)
 {
 	return p->se.avg.util_avg;
@@ -6469,16 +6504,52 @@ static inline unsigned long task_util_est(struct task_struct *p)
  */
 static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
 {
-	unsigned long util, capacity;
+	unsigned int util, util_est;
+	unsigned int capacity;
 
 	/* Task has no contribution or is new */
 	if (cpu != task_cpu(p) || !p->se.avg.last_update_time)
-		return cpu_util(cpu);
+		return cpu_util_est(cpu);
+
+	/* Discount task's blocked util from CPU's util */
+	util  = cpu_util(cpu);
+	util -= min_t(unsigned int, util, task_util(p));
+
+	if (!sched_feat(UTIL_EST))
+		return util;
+
+	/*
+	 * Covered cases:
+	 * - if *p is the only task sleeping on this CPU, then:
+	 *      cpu_util (== task_util) > util_est (== 0)
+	 *   and thus we return:
+	 *      cpu_util_wake = (cpu_util - task_util) = 0
+	 *
+	 * - if other tasks are SLEEPING on the same CPU, which is just waking
+	 *   up, then:
+	 *      cpu_util >= task_util
+	 *      cpu_util > util_est (== 0)
+	 *   and thus we discount *p's blocked utilization to return:
+	 *      cpu_util_wake = (cpu_util - task_util) >= 0
+	 *
+	 * - if other tasks are RUNNABLE on that CPU and
+	 *      util_est > cpu_util
+	 *   then we use util_est since it returns a more restrictive
+	 *   estimation of the spare capacity on that CPU, by just considering
+	 *   the expected utilization of tasks already runnable on that CPU.
+	 */
+	util_est = READ_ONCE(cpu_rq(cpu)->cfs.avg.util_est.enqueued);
+	util = max(util, util_est);
 
+	/*
+	 * Estimated utilization can exceed the CPU capacity, thus let's clamp
+	 * to the maximum CPU capacity to ensure consistency with other
+	 * cpu_util[_est] calls.
+	 */
 	capacity = capacity_orig_of(cpu);
-	util = max_t(long, cpu_rq(cpu)->cfs.avg.util_avg - task_util(p), 0);
+	util = min(util, capacity);
 
-	return (util >= capacity) ? capacity : util;
+	return util;
 }
 
 /*
@@ -8005,7 +8076,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			load = source_load(i, load_idx);
 
 		sgs->group_load += load;
-		sgs->group_util += cpu_util(i);
+		sgs->group_util += cpu_util_est(i);
 		sgs->sum_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
-- 
2.15.1
