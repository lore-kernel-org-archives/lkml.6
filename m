Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933398AbeBVRC1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:02:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45246 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933193AbeBVRCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:02:19 -0500
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
Subject: [PATCH v5 1/4] sched/fair: add util_est on top of PELT
Date: Thu, 22 Feb 2018 17:01:50 +0000
Message-Id: <20180222170153.673-2-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180222170153.673-1-patrick.bellasi@arm.com>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The util_avg signal computed by PELT is too variable for some use-cases.
For example, a big task waking up after a long sleep period will have its
utilization almost completely decayed. This introduces some latency before
schedutil will be able to pick the best frequency to run a task.

The same issue can affect task placement. Indeed, since the task
utilization is already decayed at wakeup, when the task is enqueued in a
CPU, this can result in a CPU running a big task as being temporarily
represented as being almost empty. This leads to a race condition where
other tasks can be potentially allocated on a CPU which just started to run
a big task which slept for a relatively long period.

Moreover, the PELT utilization of a task can be updated every [ms], thus
making it a continuously changing value for certain longer running
tasks. This means that the instantaneous PELT utilization of a RUNNING
task is not really meaningful to properly support scheduler decisions.

For all these reasons, a more stable signal can do a better job of
representing the expected/estimated utilization of a task/cfs_rq.
Such a signal can be easily created on top of PELT by still using it as
an estimator which produces values to be aggregated on meaningful
events.

This patch adds a simple implementation of util_est, a new signal built on
top of PELT's util_avg where:

    util_est(task) = max(task::util_avg, f(task::util_avg@dequeue_times))

This allows to remember how big a task has been reported by PELT in its
previous activations via the function: f(task::util_avg@dequeue_times).

If a task should change its behavior and it runs even longer in a new
activation, after a certain time its util_est will just track the
original PELT signal (i.e. task::util_avg).

The estimated utilization of cfs_rq is defined only for root ones.
That's because the only sensible consumer of this signal are the
scheduler and schedutil when looking for the overall CPU utilization due
to FAIR tasks.
For this reason, the estimated utilization of a root cfs_rq is simply
defined as:

    util_est(cfs_rq) = max(cfs_rq::util_avg, cfs_rq::util_est_runnable)

where:

    cfs_rq::util_est_runnable = sum(util_est(task))
                                for each RUNNABLE task on that root cfs_rq

It's worth to note that the estimated utilization is tracked only for
objects of interests, specifically:
 - Tasks: to better support tasks placement decisions
 - root cfs_rqs: to better support both tasks placement decisions as
                 well as frequencies selection

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
 - add documentation for "struct util_est"
 - always use int instead of long whenever possible (Peter)
 - pass cfs_rq to util_est_{en,de}queue (Peter)
 - pass task_sleep to util_est_dequeue
 - use singe WRITE_ONCE at dequeue time
 - add some other missing {READ,WRITE}_ONCE
 - add task_util_est() for code consistency

Changes in v4:
 - rebased on today's tip/sched/core (commit 460e8c3340a2)
 - renamed util_est's "last" into "enqueued"
 - using util_est's "enqueued" for both se and cfs_rqs (Joel)
 - update margin check to use more ASM friendly code (Peter)
 - optimize EWMA updates (Peter)

Changes in v3:
 - rebased on today's tip/sched/core (commit 07881166a892)
 - moved util_est into sched_avg (Peter)
 - use {READ,WRITE}_ONCE() for EWMA updates (Peter)
 - using unsigned int to fit all sched_avg into a single 64B cache line

Changes in v2:
 - rebase on top of v4.15-rc2
 - tested that overhauled PELT code does not affect the util_est
---
 include/linux/sched.h   |  29 +++++++++++++
 kernel/sched/debug.c    |   4 ++
 kernel/sched/fair.c     | 109 +++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/features.h |   5 +++
 4 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b161ef8a902e..14b1a6ce6298 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -275,6 +275,34 @@ struct load_weight {
 	u32				inv_weight;
 };
 
+/**
+ * Estimation Utilization for FAIR tasks.
+ *
+ * Support data structure to track an Exponential Weighted Moving Average
+ * (EWMA) of a FAIR task's utilization. New samples are added to the moving
+ * average each time a task completes an activation. Sample's weight is
+ * chosen so that the EWMA will be relatively insensitive to transient changes
+ * to the task's workload.
+ *
+ * @enqueued: instantaneous estimated utilization of a task/cpu
+ *      task: the task's util_avg at last task dequeue time
+ *    cfs_rq: the sum of util_est.enqueued for each RUNNABLE task on that CPU
+ *
+ *  Thus, the util_est.enqueued of a task represents the contribution on the
+ *  estimated utilization of the CPU where that task is currently enqueued.
+ *
+ * @ewma: the Exponential Weighted Moving Average (EWMA) utilization of a task
+ *  Only for tasks we track a moving average of the past instantaneous
+ *  estimated utilization. This allows to absorb sporadic drops in
+ *  utilization of an otherwise almost periodic task.
+ *
+ */
+struct util_est {
+	unsigned int			enqueued;
+	unsigned int			ewma;
+#define UTIL_EST_WEIGHT_SHIFT		2
+};
+
 /*
  * The load_avg/util_avg accumulates an infinite geometric series
  * (see __update_load_avg() in kernel/sched/fair.c).
@@ -336,6 +364,7 @@ struct sched_avg {
 	unsigned long			load_avg;
 	unsigned long			runnable_load_avg;
 	unsigned long			util_avg;
+	struct util_est			util_est;
 };
 
 struct sched_statistics {
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1ca0130ed4f9..d4eb5532ea6b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -567,6 +567,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->avg.runnable_load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
 			cfs_rq->avg.util_avg);
+	SEQ_printf(m, "  .%-30s: %u\n", "util_est_enqueued",
+			cfs_rq->avg.util_est.enqueued);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed.load_avg",
 			cfs_rq->removed.load_avg);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed.util_avg",
@@ -1018,6 +1020,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.runnable_load_avg);
 	P(se.avg.util_avg);
 	P(se.avg.last_update_time);
+	P(se.avg.util_est.ewma);
+	P(se.avg.util_est.enqueued);
 #endif
 	P(policy);
 	P(prio);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e1febd252a84..c8526687f107 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5205,6 +5205,23 @@ static inline void hrtick_update(struct rq *rq)
 }
 #endif
 
+static inline unsigned long task_util(struct task_struct *p);
+static inline unsigned long _task_util_est(struct task_struct *p);
+
+static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
+				    struct task_struct *p)
+{
+	unsigned int enqueued;
+
+	if (!sched_feat(UTIL_EST))
+		return;
+
+	/* Update root cfs_rq's estimated utilization */
+	enqueued  = READ_ONCE(cfs_rq->avg.util_est.enqueued);
+	enqueued += _task_util_est(p);
+	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -5257,9 +5274,86 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!se)
 		add_nr_running(rq, 1);
 
+	util_est_enqueue(&rq->cfs, p);
 	hrtick_update(rq);
 }
 
+/*
+ * Check if a (signed) value is within a specified (unsigned) margin,
+ * based on the observation that:
+ *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
+ *
+ * NOTE: this only works when value + maring < INT_MAX.
+ */
+static inline bool within_margin(int value, int margin)
+{
+	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
+}
+
+static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
+				    struct task_struct *p,
+				    bool task_sleep)
+{
+	long last_ewma_diff;
+	struct util_est ue;
+
+	if (!sched_feat(UTIL_EST))
+		return;
+
+	/*
+	 * Update root cfs_rq's estimated utilization
+	 *
+	 * If *p is the last task then the root cfs_rq's estimated utilization
+	 * of a CPU is 0 by definition.
+	 */
+	ue.enqueued = 0;
+	if (cfs_rq->nr_running) {
+		ue.enqueued  = READ_ONCE(cfs_rq->avg.util_est.enqueued);
+		ue.enqueued -= min_t(unsigned int, ue.enqueued,
+				     _task_util_est(p));
+	}
+	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
+
+	/*
+	 * Skip update of task's estimated utilization when the task has not
+	 * yet completed an activation, e.g. being migrated.
+	 */
+	if (!task_sleep)
+		return;
+
+	/*
+	 * Skip update of task's estimated utilization when its EWMA is
+	 * already ~1% close to its last activation value.
+	 */
+	ue = READ_ONCE(p->se.avg.util_est);
+	ue.enqueued = task_util(p);
+	last_ewma_diff = ue.enqueued - ue.ewma;
+	if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
+		return;
+
+	/*
+	 * Update Task's estimated utilization
+	 *
+	 * When *p completes an activation we can consolidate another sample
+	 * of the task size. This is done by storing the current PELT value
+	 * as ue.enqueued and by using this value to update the Exponential
+	 * Weighted Moving Average (EWMA):
+	 *
+	 *  ewma(t) = w *  task_util(p) + (1-w) * ewma(t-1)
+	 *          = w *  task_util(p) +         ewma(t-1)  - w * ewma(t-1)
+	 *          = w * (task_util(p) -         ewma(t-1)) +     ewma(t-1)
+	 *          = w * (      last_ewma_diff            ) +     ewma(t-1)
+	 *          = w * (last_ewma_diff  +  ewma(t-1) / w)
+	 *
+	 * Where 'w' is the weight of new samples, which is configured to be
+	 * 0.25, thus making w=1/4 ( >>= UTIL_EST_WEIGHT_SHIFT)
+	 */
+	ue.ewma <<= UTIL_EST_WEIGHT_SHIFT;
+	ue.ewma  += last_ewma_diff;
+	ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
+	WRITE_ONCE(p->se.avg.util_est, ue);
+}
+
 static void set_next_buddy(struct sched_entity *se);
 
 /*
@@ -5316,6 +5410,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!se)
 		sub_nr_running(rq, 1);
 
+	util_est_dequeue(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
 
@@ -5834,7 +5929,6 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	return target;
 }
 
-static inline unsigned long task_util(struct task_struct *p);
 static unsigned long cpu_util_wake(int cpu, struct task_struct *p);
 
 static unsigned long capacity_spare_wake(int cpu, struct task_struct *p)
@@ -6356,6 +6450,19 @@ static inline unsigned long task_util(struct task_struct *p)
 	return p->se.avg.util_avg;
 }
 
+
+static inline unsigned long _task_util_est(struct task_struct *p)
+{
+	struct util_est ue = READ_ONCE(p->se.avg.util_est);
+
+	return max(ue.ewma, ue.enqueued);
+}
+
+static inline unsigned long task_util_est(struct task_struct *p)
+{
+	return max(READ_ONCE(p->se.avg.util_avg), _task_util_est(p));
+}
+
 /*
  * cpu_util_wake: Compute cpu utilization with any contributions from
  * the waking task p removed.
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 9552fd5854bf..c459a4b61544 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -85,3 +85,8 @@ SCHED_FEAT(ATTACH_AGE_LOAD, true)
 SCHED_FEAT(WA_IDLE, true)
 SCHED_FEAT(WA_WEIGHT, true)
 SCHED_FEAT(WA_BIAS, true)
+
+/*
+ * UtilEstimation. Use estimated CPU utilization.
+ */
+SCHED_FEAT(UTIL_EST, false)
-- 
2.15.1
