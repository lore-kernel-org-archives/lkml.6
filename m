Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbeCTLIV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:08:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33375 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbeCTLIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:08:11 -0400
Date: Tue, 20 Mar 2018 04:07:30 -0700
From: tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-7f65ea42eb00bc902f1c37a71e984e4f4064cfa9@git.kernel.org>
Cc: pjt@google.com, torvalds@linux-foundation.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, joelaf@google.com,
        tkjos@android.com, viresh.kumar@linaro.org, dietmar.eggemann@arm.com,
        hpa@zytor.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rafael.j.wysocki@intel.com, peterz@infradead.org, smuckle@google.com
Reply-To: mingo@kernel.org, pjt@google.com, torvalds@linux-foundation.org,
        tkjos@android.com, joelaf@google.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, hpa@zytor.com, patrick.bellasi@arm.com,
        morten.rasmussen@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, rafael.j.wysocki@intel.com, peterz@infradead.org,
        smuckle@google.com
In-Reply-To: <20180309095245.11071-2-patrick.bellasi@arm.com>
References: <20180309095245.11071-2-patrick.bellasi@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Add util_est on top of PELT
Git-Commit-ID: 7f65ea42eb00bc902f1c37a71e984e4f4064cfa9
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

Commit-ID:  7f65ea42eb00bc902f1c37a71e984e4f4064cfa9
Gitweb:     https://git.kernel.org/tip/7f65ea42eb00bc902f1c37a71e984e4f4064cfa9
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Fri, 9 Mar 2018 09:52:42 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 08:11:06 +0100

sched/fair: Add util_est on top of PELT

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

    util_est(task) = max(task::util_avg, f(task::util_avg@dequeue))

This allows to remember how big a task has been reported by PELT in its
previous activations via f(task::util_avg@dequeue), which is the new
_task_util_est(struct task_struct*) function added by this patch.

If a task should change its behavior and it runs longer in a new
activation, after a certain time its util_est will just track the
original PELT signal (i.e. task::util_avg).

The estimated utilization of cfs_rq is defined only for root ones.
That's because the only sensible consumer of this signal are the
scheduler and schedutil when looking for the overall CPU utilization
due to FAIR tasks.

For this reason, the estimated utilization of a root cfs_rq is simply
defined as:

    util_est(cfs_rq) = max(cfs_rq::util_avg, cfs_rq::util_est::enqueued)

where:

    cfs_rq::util_est::enqueued = sum(_task_util_est(task))
                                 for each RUNNABLE task on that root cfs_rq

It's worth noting that the estimated utilization is tracked only for
objects of interests, specifically:

 - Tasks: to better support tasks placement decisions
 - root cfs_rqs: to better support both tasks placement decisions as
                 well as frequencies selection

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@android.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Link: http://lkml.kernel.org/r/20180309095245.11071-2-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h   |  29 ++++++++++++
 kernel/sched/debug.c    |   4 ++
 kernel/sched/fair.c     | 122 +++++++++++++++++++++++++++++++++++++++++++++---
 kernel/sched/features.h |   5 ++
 4 files changed, 154 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 21b1168da951..f228c6033832 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -274,6 +274,34 @@ struct load_weight {
 	u32				inv_weight;
 };
 
+/**
+ * struct util_est - Estimation utilization of FAIR tasks
+ * @enqueued: instantaneous estimated utilization of a task/cpu
+ * @ewma:     the Exponential Weighted Moving Average (EWMA)
+ *            utilization of a task
+ *
+ * Support data structure to track an Exponential Weighted Moving Average
+ * (EWMA) of a FAIR task's utilization. New samples are added to the moving
+ * average each time a task completes an activation. Sample's weight is chosen
+ * so that the EWMA will be relatively insensitive to transient changes to the
+ * task's workload.
+ *
+ * The enqueued attribute has a slightly different meaning for tasks and cpus:
+ * - task:   the task's util_avg at last task dequeue time
+ * - cfs_rq: the sum of util_est.enqueued for each RUNNABLE task on that CPU
+ * Thus, the util_est.enqueued of a task represents the contribution on the
+ * estimated utilization of the CPU where that task is currently enqueued.
+ *
+ * Only for tasks we track a moving average of the past instantaneous
+ * estimated utilization. This allows to absorb sporadic drops in utilization
+ * of an otherwise almost periodic task.
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
@@ -335,6 +363,7 @@ struct sched_avg {
 	unsigned long			load_avg;
 	unsigned long			runnable_load_avg;
 	unsigned long			util_avg;
+	struct util_est			util_est;
 };
 
 struct sched_statistics {
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 644d9a464380..332303be4beb 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -541,6 +541,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->avg.runnable_load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
 			cfs_rq->avg.util_avg);
+	SEQ_printf(m, "  .%-30s: %u\n", "util_est_enqueued",
+			cfs_rq->avg.util_est.enqueued);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed.load_avg",
 			cfs_rq->removed.load_avg);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed.util_avg",
@@ -989,6 +991,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.runnable_load_avg);
 	P(se.avg.util_avg);
 	P(se.avg.last_update_time);
+	P(se.avg.util_est.ewma);
+	P(se.avg.util_est.enqueued);
 #endif
 	P(policy);
 	P(prio);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3582117e1580..22b59a7facd2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3873,6 +3873,113 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 
 static int idle_balance(struct rq *this_rq, struct rq_flags *rf);
 
+static inline unsigned long task_util(struct task_struct *p)
+{
+	return READ_ONCE(p->se.avg.util_avg);
+}
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
+	return max(task_util(p), _task_util_est(p));
+}
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
+	enqueued  = cfs_rq->avg.util_est.enqueued;
+	enqueued += _task_util_est(p);
+	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
+}
+
+/*
+ * Check if a (signed) value is within a specified (unsigned) margin,
+ * based on the observation that:
+ *
+ *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
+ *
+ * NOTE: this only works when value + maring < INT_MAX.
+ */
+static inline bool within_margin(int value, int margin)
+{
+	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
+}
+
+static void
+util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
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
+		ue.enqueued  = cfs_rq->avg.util_est.enqueued;
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
+	ue = p->se.avg.util_est;
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
 #else /* CONFIG_SMP */
 
 static inline int
@@ -3902,6 +4009,13 @@ static inline int idle_balance(struct rq *rq, struct rq_flags *rf)
 	return 0;
 }
 
+static inline void
+util_est_enqueue(struct cfs_rq *cfs_rq, struct task_struct *p) {}
+
+static inline void
+util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p,
+		 bool task_sleep) {}
+
 #endif /* CONFIG_SMP */
 
 static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -5249,6 +5363,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!se)
 		add_nr_running(rq, 1);
 
+	util_est_enqueue(&rq->cfs, p);
 	hrtick_update(rq);
 }
 
@@ -5308,6 +5423,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!se)
 		sub_nr_running(rq, 1);
 
+	util_est_dequeue(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
 
@@ -5835,7 +5951,6 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	return target;
 }
 
-static inline unsigned long task_util(struct task_struct *p);
 static unsigned long cpu_util_wake(int cpu, struct task_struct *p);
 
 static unsigned long capacity_spare_wake(int cpu, struct task_struct *p)
@@ -6351,11 +6466,6 @@ static unsigned long cpu_util(int cpu)
 	return (util >= capacity) ? capacity : util;
 }
 
-static inline unsigned long task_util(struct task_struct *p)
-{
-	return p->se.avg.util_avg;
-}
-
 /*
  * cpu_util_wake: Compute CPU utilization with any contributions from
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
