Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753764AbeDIQ5n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:57:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58532 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753704AbeDIQ4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:56:38 -0400
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: [PATCH 3/7] sched/core: uclamp: extend sched_setattr to support utilization clamping
Date: Mon,  9 Apr 2018 17:56:11 +0100
Message-Id: <20180409165615.2326-4-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180409165615.2326-1-patrick.bellasi@arm.com>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCHED_DEADLINE scheduling class provides an advanced and formal
model to define task requirements which can be translated into proper
decisions for both task placements and frequencies selections.
Other classes have a simpler model which is essentially based on
the relatively simple concept of POSIX priorities.

Such a simple priority based model however does not allow to exploit
some of the more advanced features of the Linux scheduler like, for
example, driving frequencies selection via the schedutil cpufreq
governor. However, also for non SCHED_DEADLINE tasks, it's still
interesting to define tasks properties which can be used to better
support certain scheduler decisions.

Utilization clamping aims at exposing to user-space a new set of
per-task attribute which can be used to provide the scheduler with some
hints about the expected/required utilization should consider for a
task. This will allow to implement a more advanced per-task frequency
control mechanism which is not based just on a "passive" measured task
utilization but on a more "proactive" approach. For example, it could be
possible to boost interactive tasks, thus getting better performance, or
cap background tasks, thus being more energy efficient.
Ultimately, such a mechanism, can be considered similar to the cpufreq's
powersave, performance and userspace governor but with a much more fine
grained and per-task control.

Let's introduce a new API to set utilization clamping values for a
specified task by extending sched_setattr, a syscall which already
allows to define task specific properties for different scheduling
classes.
Specifically, a new pair of attributes allows to specify a minimum and
maximum utilization which the scheduler should consider for a task.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Paul Turner <pjt@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
The solution proposed here exposes the concept of "utilization" to
userspace. This should be a quite generic concept, maybe if we abstract
it a bit to be considered just as a percentage of the CPU capacity, and
thus in the range [0..100] instead of [0..SCHED_CAPACITY_SCALE] as it is
now.

If such a defined utilization should still be considered too much of an
implementation detail, a possible alternative proposal can be that do
"recycle" the usage of:
   sched_runtime
   sched_period
to be translated internally into a proper utilization.

Such a model, although being slightly more complicated from a coding
standpoint, it would allow to have a more abstract description of the
expected task utilization and, combined with in-kernel knowledge
of the math governing PELT, can probably be translated into a better
min/max utilization clamp value.

For this first proposal, I've opted to present the most simple solution
based on a and simple "abstract" utilization metric.
---
 include/uapi/linux/sched.h       |  4 ++-
 include/uapi/linux/sched/types.h | 65 ++++++++++++++++++++++++++++++++++------
 kernel/sched/core.c              | 52 ++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 22627f80063e..c27d6e81517b 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -50,9 +50,11 @@
 #define SCHED_FLAG_RESET_ON_FORK	0x01
 #define SCHED_FLAG_RECLAIM		0x02
 #define SCHED_FLAG_DL_OVERRUN		0x04
+#define SCHED_FLAG_UTIL_CLAMP		0x08
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
-			 SCHED_FLAG_DL_OVERRUN)
+			 SCHED_FLAG_DL_OVERRUN		| \
+			 SCHED_FLAG_UTIL_CLAMP)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index 10fbb8031930..c243288465b2 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -21,8 +21,33 @@ struct sched_param {
  * the tasks may be useful for a wide variety of application fields, e.g.,
  * multimedia, streaming, automation and control, and many others.
  *
- * This variant (sched_attr) is meant at describing a so-called
- * sporadic time-constrained task. In such model a task is specified by:
+ * This variant (sched_attr) allows to define additional attributes to
+ * improve the scheduler knowledge about task requirements.
+ *
+ * Scheduling Class Attributes
+ * ===========================
+ *
+ * A subset of sched_attr attributes specifys the
+ * scheduling policy and relative POSIX attributes:
+ *
+ *  @size		size of the structure, for fwd/bwd compat.
+ *
+ *  @sched_policy	task's scheduling policy
+ *  @sched_nice		task's nice value      (SCHED_NORMAL/BATCH)
+ *  @sched_priority	task's static priority (SCHED_FIFO/RR)
+ *
+ * Certain more advanced scheduling features can be controlled by a
+ * predefined set of flags via the attribute:
+ *
+ *  @sched_flags	for customizing the scheduler behaviour
+ *
+ * Sporadic Time-Constrained Tasks Attributes
+ * ==========================================
+ *
+ * A subset of sched_attr attributes allows to describe a so-called
+ * sporadic time-constrained task.
+ *
+ * In such model a task is specified by:
  *  - the activation period or minimum instance inter-arrival time;
  *  - the maximum (or average, depending on the actual scheduling
  *    discipline) computation time of all instances, a.k.a. runtime;
@@ -34,14 +59,8 @@ struct sched_param {
  * than the runtime and must be completed by time instant t equal to
  * the instance activation time + the deadline.
  *
- * This is reflected by the actual fields of the sched_attr structure:
+ * This is reflected by the following fields of the sched_attr structure:
  *
- *  @size		size of the structure, for fwd/bwd compat.
- *
- *  @sched_policy	task's scheduling policy
- *  @sched_flags	for customizing the scheduler behaviour
- *  @sched_nice		task's nice value      (SCHED_NORMAL/BATCH)
- *  @sched_priority	task's static priority (SCHED_FIFO/RR)
  *  @sched_deadline	representative of the task's deadline
  *  @sched_runtime	representative of the task's runtime
  *  @sched_period	representative of the task's period
@@ -53,6 +72,29 @@ struct sched_param {
  * As of now, the SCHED_DEADLINE policy (sched_dl scheduling class) is the
  * only user of this new interface. More information about the algorithm
  * available in the scheduling class file or in Documentation/.
+ *
+ * Task Utilization Attributes
+ * ===========================
+ *
+ * A subset of sched_attr attributes allows to specify the utilization which
+ * should be expected by a task. These attributes allows to inform the
+ * scheduler about the utilization boundaries within which is safe to schedule
+ * the task. These utilization boundaries are valuable information to support
+ * scheduler decisions on both task placement and frequencies selection.
+ *
+ *  @sched_min_utilization	represents the minimum CPU utilization
+ *  @sched_max_utilization	represents the maximum CPU utilization
+ *
+ * Utilization is a value in the range [0..1023] which represents the
+ * percentage of CPU time used by a task when running at the maximum frequency
+ * in the highest capacity CPU of the system. Thus, for example, a 20%
+ * utilization task is a task running for 2ms every 10ms on a cpu with the
+ * highest capacity in the system.
+ *
+ * A task with a min utilization value bigger then 0 is more likely to be
+ * scheduled on a CPU which can support that utilization level.
+ * A task with a max utilization value smaller then 1024 is more likely to be
+ * scheduled on a CPU which do not support more then that utilization level.
  */
 struct sched_attr {
 	__u32 size;
@@ -70,6 +112,11 @@ struct sched_attr {
 	__u64 sched_runtime;
 	__u64 sched_deadline;
 	__u64 sched_period;
+
+	/* Utilization hints */
+	__u32 sched_util_min;
+	__u32 sched_util_max;
+
 };
 
 #endif /* _UAPI_LINUX_SCHED_TYPES_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a602b7b9d5f9..6ee4f380aba6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1181,6 +1181,41 @@ static inline int uclamp_group_get(struct task_struct *p,
 	return 0;
 }
 
+static inline int __setscheduler_uclamp(struct task_struct *p,
+					const struct sched_attr *attr)
+{
+	struct uclamp_se *uc_se;
+	int retval = 0;
+
+	if (attr->sched_util_min > attr->sched_util_max)
+		return -EINVAL;
+	if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
+		return -EINVAL;
+
+	mutex_lock(&uclamp_mutex);
+
+	/* Update min utilization clamp */
+	uc_se = &p->uclamp[UCLAMP_MIN];
+	retval |= uclamp_group_get(p, UCLAMP_MIN, uc_se,
+				   attr->sched_util_min);
+
+	/* Update max utilization clamp */
+	uc_se = &p->uclamp[UCLAMP_MAX];
+	retval |= uclamp_group_get(p, UCLAMP_MAX, uc_se,
+				   attr->sched_util_max);
+
+	mutex_unlock(&uclamp_mutex);
+
+	/*
+	 * If one of the two clamp values should fail,
+	 * let's the userspace know
+	 */
+	if (retval)
+		return -ENOSPC;
+
+	return 0;
+}
+
 /**
  * init_uclamp: initialize data structures required for utilization clamping
  */
@@ -1212,6 +1247,11 @@ static inline void init_uclamp(void)
 
 #else /* CONFIG_UCLAMP_TASK */
 static inline void uclamp_task_update(struct rq *rq, struct task_struct *p) { }
+static inline int __setscheduler_uclamp(struct task_struct *p,
+					const struct sched_attr *attr)
+{
+	return -EINVAL;
+}
 static inline void init_uclamp(void) { }
 #endif /* CONFIG_UCLAMP_TASK */
 
@@ -4720,6 +4760,13 @@ static int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
+	/* Configure utilization clamps for the task */
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
+		retval = __setscheduler_uclamp(p, attr);
+		if (retval)
+			return retval;
+	}
+
 	/*
 	 * Make sure no PI-waiters arrive (or leave) while we are
 	 * changing the priority of the task:
@@ -5226,6 +5273,11 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	else
 		attr.sched_nice = task_nice(p);
 
+#ifdef CONFIG_UCLAMP_TASK
+	attr.sched_util_min = p->uclamp[UCLAMP_MIN].value;
+	attr.sched_util_max = p->uclamp[UCLAMP_MAX].value;
+#endif
+
 	rcu_read_unlock();
 
 	retval = sched_read_attr(uattr, &attr, size);
-- 
2.15.1
