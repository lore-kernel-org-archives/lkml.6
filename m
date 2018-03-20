Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeCTLIu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:08:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45939 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbeCTLIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:08:43 -0400
Date: Tue, 20 Mar 2018 04:08:02 -0700
From: tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-f9be3e5961c5554879a491961187472e923f5ee0@git.kernel.org>
Cc: peterz@infradead.org, hpa@zytor.com, dietmar.eggemann@arm.com,
        torvalds@linux-foundation.org, pjt@google.com,
        vincent.guittot@linaro.org, morten.rasmussen@arm.com,
        rafael.j.wysocki@intel.com, smuckle@google.com, tglx@linutronix.de,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        joelaf@google.com, juri.lelli@redhat.com, patrick.bellasi@arm.com,
        mingo@kernel.org, tkjos@android.com
Reply-To: patrick.bellasi@arm.com, juri.lelli@redhat.com, tkjos@android.com,
        mingo@kernel.org, joelaf@google.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, smuckle@google.com, viresh.kumar@linaro.org,
        rafael.j.wysocki@intel.com, vincent.guittot@linaro.org, pjt@google.com,
        torvalds@linux-foundation.org, morten.rasmussen@arm.com, hpa@zytor.com,
        peterz@infradead.org, dietmar.eggemann@arm.com
In-Reply-To: <20180309095245.11071-3-patrick.bellasi@arm.com>
References: <20180309095245.11071-3-patrick.bellasi@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Use util_est in LB and WU paths
Git-Commit-ID: f9be3e5961c5554879a491961187472e923f5ee0
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

Commit-ID:  f9be3e5961c5554879a491961187472e923f5ee0
Gitweb:     https://git.kernel.org/tip/f9be3e5961c5554879a491961187472e923f5ee0
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Fri, 9 Mar 2018 09:52:43 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 08:11:07 +0100

sched/fair: Use util_est in LB and WU paths

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
in the wakeup path, via cpu_util_wake(), as well as in the load-balance
path, via cpu_util() which is used by update_sg_lb_stats().

The estimated utilization of a CPU is defined to be the maximum between
its PELT's utilization and the sum of the estimated utilization (at
previous dequeue time) of all the tasks currently RUNNABLE on that CPU.
This allows to properly represent the spare capacity of a CPU which, for
example, has just got a big task running since a long sleep period.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@android.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Link: http://lkml.kernel.org/r/20180309095245.11071-3-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 84 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 22b59a7facd2..570b8d056282 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6432,11 +6432,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	return target;
 }
 
-/*
- * cpu_util returns the amount of capacity of a CPU that is used by CFS
- * tasks. The unit of the return value must be the one of capacity so we can
- * compare the utilization with the capacity of the CPU that is available for
- * CFS task (ie cpu_capacity).
+/**
+ * Amount of capacity of a CPU that is (estimated to be) used by CFS tasks
+ * @cpu: the CPU to get the utilization of
+ *
+ * The unit of the return value must be the one of capacity so we can compare
+ * the utilization with the capacity of the CPU that is available for CFS task
+ * (ie cpu_capacity).
  *
  * cfs_rq.avg.util_avg is the sum of running time of runnable tasks plus the
  * recent utilization of currently non-runnable tasks on a CPU. It represents
@@ -6447,6 +6449,14 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
  * current capacity (capacity_curr <= capacity_orig) of the CPU because it is
  * the running time on this CPU scaled by capacity_curr.
  *
+ * The estimated utilization of a CPU is defined to be the maximum between its
+ * cfs_rq.avg.util_avg and the sum of the estimated utilization of the tasks
+ * currently RUNNABLE on that CPU.
+ * This allows to properly represent the expected utilization of a CPU which
+ * has just got a big task running since a long sleep period. At the same time
+ * however it preserves the benefits of the "blocked utilization" in
+ * describing the potential for other tasks waking up on the same CPU.
+ *
  * Nevertheless, cfs_rq.avg.util_avg can be higher than capacity_curr or even
  * higher than capacity_orig because of unfortunate rounding in
  * cfs.avg.util_avg or just after migrating tasks and new task wakeups until
@@ -6457,13 +6467,21 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
  * available capacity. We allow utilization to overshoot capacity_curr (but not
  * capacity_orig) as it useful for predicting the capacity required after task
  * migrations (scheduler-driven DVFS).
+ *
+ * Return: the (estimated) utilization for the specified CPU
  */
-static unsigned long cpu_util(int cpu)
+static inline unsigned long cpu_util(int cpu)
 {
-	unsigned long util = cpu_rq(cpu)->cfs.avg.util_avg;
-	unsigned long capacity = capacity_orig_of(cpu);
+	struct cfs_rq *cfs_rq;
+	unsigned int util;
+
+	cfs_rq = &cpu_rq(cpu)->cfs;
+	util = READ_ONCE(cfs_rq->avg.util_avg);
+
+	if (sched_feat(UTIL_EST))
+		util = max(util, READ_ONCE(cfs_rq->avg.util_est.enqueued));
 
-	return (util >= capacity) ? capacity : util;
+	return min_t(unsigned long, util, capacity_orig_of(cpu));
 }
 
 /*
@@ -6472,16 +6490,54 @@ static unsigned long cpu_util(int cpu)
  */
 static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
 {
-	unsigned long util, capacity;
+	struct cfs_rq *cfs_rq;
+	unsigned int util;
 
 	/* Task has no contribution or is new */
-	if (cpu != task_cpu(p) || !p->se.avg.last_update_time)
+	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
 		return cpu_util(cpu);
 
-	capacity = capacity_orig_of(cpu);
-	util = max_t(long, cpu_rq(cpu)->cfs.avg.util_avg - task_util(p), 0);
+	cfs_rq = &cpu_rq(cpu)->cfs;
+	util = READ_ONCE(cfs_rq->avg.util_avg);
+
+	/* Discount task's blocked util from CPU's util */
+	util -= min_t(unsigned int, util, task_util(p));
 
-	return (util >= capacity) ? capacity : util;
+	/*
+	 * Covered cases:
+	 *
+	 * a) if *p is the only task sleeping on this CPU, then:
+	 *      cpu_util (== task_util) > util_est (== 0)
+	 *    and thus we return:
+	 *      cpu_util_wake = (cpu_util - task_util) = 0
+	 *
+	 * b) if other tasks are SLEEPING on this CPU, which is now exiting
+	 *    IDLE, then:
+	 *      cpu_util >= task_util
+	 *      cpu_util > util_est (== 0)
+	 *    and thus we discount *p's blocked utilization to return:
+	 *      cpu_util_wake = (cpu_util - task_util) >= 0
+	 *
+	 * c) if other tasks are RUNNABLE on that CPU and
+	 *      util_est > cpu_util
+	 *    then we use util_est since it returns a more restrictive
+	 *    estimation of the spare capacity on that CPU, by just
+	 *    considering the expected utilization of tasks already
+	 *    runnable on that CPU.
+	 *
+	 * Cases a) and b) are covered by the above code, while case c) is
+	 * covered by the following code when estimated utilization is
+	 * enabled.
+	 */
+	if (sched_feat(UTIL_EST))
+		util = max(util, READ_ONCE(cfs_rq->avg.util_est.enqueued));
+
+	/*
+	 * Utilization (estimated) can exceed the CPU capacity, thus let's
+	 * clamp to the maximum CPU capacity to ensure consistency with
+	 * the cpu_util call.
+	 */
+	return min_t(unsigned long, util, capacity_orig_of(cpu));
 }
 
 /*
