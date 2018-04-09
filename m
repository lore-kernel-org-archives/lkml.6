Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753672AbeDIQ4e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:56:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58504 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753089AbeDIQ4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:56:30 -0400
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
Subject: [PATCH 1/7] sched/core: uclamp: add CPU clamp groups accounting
Date: Mon,  9 Apr 2018 17:56:09 +0100
Message-Id: <20180409165615.2326-2-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180409165615.2326-1-patrick.bellasi@arm.com>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilization clamping allows to clamp the utilization of a CPU within a
[util_min, util_max] range. This range depends on the set of currently
active tasks on a CPU, where each task references two "clamp groups"
defining the util_min and the util_max clamp values to be considered for
that task. The clamp value mapped by a clamp group applies to a CPU only
when there is at least one task active referencing that clamp group.

When tasks are enqueued/dequeued on/from a CPU, the set of clamp groups
active on that CPU can change. Since each clamp group enforces a
different utilization clamp value, once the set of these groups changes
it can be required to re-compute what is the new "aggregated" clamp
value to apply on that CPU.

Clamp values are always MAX aggregated for both util_min and util_max.
This is to ensure that no tasks can affect the performances of other
co-scheduled tasks which are either more boosted (i.e.  with higher
util_min clamp) or less capped (i.e. with higher util_max clamp).

Here we introduce the required support to properly reference count clamp
groups at each task enqueue/dequeue time.

Tasks have a task_struct::uclamp::group_id indexing the clamp group in
which they should be accounted into at enqueue time. This index is
cached into task_struct::uclamp_group_id once a task is enqueued in a
CPU to ensure a consistent and efficient update of the reference count
at dequeue time.

CPUs rq have a rq::uclamp::group[].tasks which is used to reference
count how many tasks are currently active on that CPU for each clamp
group. The clamp value of each clamp group is tracked by
rq::uclamp::group[].value, thus making rq::uclamp::group[] an unordered
array of clamp values. However, the MAX aggregation of the currently
active clamp groups is implemented to minimizes the number of times we
need to scan the complete (unordered) clamp group array to figure out
the new max value. This operation indeed happens only when we dequeue
last task of the clamp group corresponding to the current max clamp, and
thus the CPU is either entering IDLE or going to schedule a less boosted
or more clamped task.
Moreover, the expected number of different clamp values, which can be
configured at build time, is usually so small to make not worth a more
advanced ordering algorithm. In real use-cases we expect less then 10
different values.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Turner <pjt@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 include/linux/sched.h |  34 +++++++++
 init/Kconfig          |  42 +++++++++++
 kernel/sched/core.c   | 198 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  |  79 ++++++++++++++++++++
 4 files changed, 353 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f228c6033832..d25460754d03 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -238,6 +238,17 @@ struct vtime {
 	u64			gtime;
 };
 
+enum uclamp_id {
+	/* No utilization clamp group assigned */
+	UCLAMP_NONE = -1,
+
+	UCLAMP_MIN = 0, /* Minimum utilization */
+	UCLAMP_MAX,     /* Maximum utilization */
+
+	/* Utilization clamping constraints count */
+	UCLAMP_CNT
+};
+
 struct sched_info {
 #ifdef CONFIG_SCHED_INFO
 	/* Cumulative counters: */
@@ -526,6 +537,22 @@ struct sched_dl_entity {
 	struct hrtimer inactive_timer;
 };
 
+/**
+ * Utilization's clamp group
+ *
+ * A utilization clamp group maps a "clamp value" (value), i.e.
+ * util_{min,max}, to a "clamp group index" (group_id).
+ *
+ * Thus, the same "group_id" is used by all the TG's which enforce the same
+ * clamp "value" for a given clamp index.
+ */
+struct uclamp_se {
+	/* Utilization constraint for tasks in this group */
+	unsigned int value;
+	/* Utilization clamp group for this constraint */
+	unsigned int group_id;
+};
+
 union rcu_special {
 	struct {
 		u8			blocked;
@@ -608,6 +635,13 @@ struct task_struct {
 #endif
 	struct sched_dl_entity		dl;
 
+#ifdef CONFIG_UCLAMP_TASK
+	/* Clamp group the task is currently accounted into */
+	int				uclamp_group_id[UCLAMP_CNT];
+	/* Utlization clamp values for this task */
+	struct uclamp_se		uclamp[UCLAMP_CNT];
+#endif
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	/* List of struct preempt_notifier: */
 	struct hlist_head		preempt_notifiers;
diff --git a/init/Kconfig b/init/Kconfig
index e37f4b2a6445..977aa4d1e42a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -585,6 +585,48 @@ config HAVE_UNSTABLE_SCHED_CLOCK
 config GENERIC_SCHED_CLOCK
 	bool
 
+menu "Scheduler features"
+
+config UCLAMP_TASK
+	bool "Enabled utilization clamping for RT/FAIR tasks"
+	depends on CPU_FREQ_GOV_SCHEDUTIL
+	default false
+	help
+	  This feature enables the scheduler to track the clamped utilization
+	  of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
+
+	  When this option is enabled, the user can specify a min and max CPU
+          bandwidth which is allowed for a task.
+	  The max bandwidth allows to clamp the maximum frequency a task can
+	  use, while the min bandwidth allows to define a minimum frequency a
+          task will alwasy use.
+
+	  If in doubt, say N.
+
+
+config UCLAMP_GROUPS_COUNT
+	int "Number of different utilization clamp values supported"
+	range 0 16
+	default 4
+	depends on UCLAMP_TASK
+	help
+	  This defines the maximum number of different utilization clamp
+	  values which can be concurrently enforced for each utilization
+	  clamp index (i.e. minimum and maximum utilization).
+
+	  Only a limited number of clamp values are supported because:
+	    1. there are usually only few classes of workloads for which is
+	       makes sense to boost/cap for different frequencies
+	       e.g. background vs foreground, interactive vs low-priority
+	    2. it allows a simpler and more memory/time efficient tracking of
+	       the per-CPU clamp values.
+
+	  Set to 0 (default value) to disable the utilization clamping feature.
+
+	  If in doubt, use the default value.
+
+endmenu
+
 #
 # For architectures that want to enable the support for NUMA-affine scheduler
 # balancing logic:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index de440456f15c..009e65cbd4f4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -735,6 +735,192 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	}
 }
 
+#ifdef CONFIG_UCLAMP_TASK
+/**
+ * uclamp_mutex: serializes updates of utilization clamp values
+ *
+ * A utilization clamp value update is usually triggered from a user-space
+ * process (slow-path) but it requires a synchronization with the scheduler's
+ * (fast-path) enqueue/dequeue operations.
+ * While the fast-path synchronization is protected by RQs spinlock, this
+ * mutex ensure that we sequentially serve user-space requests.
+ */
+static DEFINE_MUTEX(uclamp_mutex);
+
+/**
+ * uclamp_cpu_update: updates the utilization clamp of a CPU
+ * @cpu: the CPU which utilization clamp has to be updated
+ * @clamp_id: the clamp index to update
+ *
+ * When tasks are enqueued/dequeued on/from a CPU, the set of currently active
+ * clamp groups is subject to change. Since each clamp group enforces a
+ * different utilization clamp value, once the set of these groups changes it
+ * can be required to re-compute what is the new clamp value to apply for that
+ * CPU.
+ *
+ * For the specified clamp index, this method computes the new CPU utilization
+ * clamp to use until the next change on the set of active tasks on that CPU.
+ */
+static inline void uclamp_cpu_update(int cpu, int clamp_id)
+{
+	struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
+	int max_value = UCLAMP_NONE;
+	unsigned int group_id;
+
+	for (group_id = 0; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
+		/* Ignore inactive clamp groups, i.e. no RUNNABLE tasks */
+		if (!uclamp_group_active(uc_cpu, group_id))
+			continue;
+
+		/* Both min and max clamp are MAX aggregated */
+		max_value = max(max_value, uc_cpu->group[group_id].value);
+
+		/* Stop if we reach the max possible clamp */
+		if (max_value >= SCHED_CAPACITY_SCALE)
+			break;
+	}
+	uc_cpu->value = max_value;
+}
+
+/**
+ * uclamp_cpu_get(): increase reference count for a clamp group on a CPU
+ * @p: the task being enqueued on a CPU
+ * @cpu: the CPU where the clamp group has to be reference counted
+ * @clamp_id: the utilization clamp (e.g. min or max utilization) to reference
+ *
+ * Once a task is enqueued on a CPU's RQ, the clamp group currently defined by
+ * the task's uclamp.group_id is reference counted on that CPU.
+ * We keep track of the reference counted clamp group by storing its index
+ * (group_id) into the task's task_struct::uclamp_group_id, which will then be
+ * used at task's dequeue time to release the reference count.
+ */
+static inline void uclamp_cpu_get(struct task_struct *p, int cpu, int clamp_id)
+{
+	struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
+	int clamp_value;
+	int group_id;
+
+	/* Get task's specific clamp value */
+	clamp_value = p->uclamp[clamp_id].value;
+	group_id = p->uclamp[clamp_id].group_id;
+
+	/* No task specific clamp values: nothing to do */
+	if (group_id == UCLAMP_NONE)
+		return;
+
+	/* Increment the current group_id */
+	uc_cpu->group[group_id].tasks += 1;
+
+	/* Mark task as enqueued for this clamp index */
+	p->uclamp_group_id[clamp_id] = group_id;
+
+	/*
+	 * If this is the new max utilization clamp value, then we can update
+	 * straight away the CPU clamp value. Otherwise, the current CPU clamp
+	 * value is still valid and we are done.
+	 */
+	if (uc_cpu->value < clamp_value)
+		uc_cpu->value = clamp_value;
+}
+
+/**
+ * uclamp_cpu_put(): decrease reference count for a clamp group on a CPU
+ * @p: the task being dequeued from a CPU
+ * @cpu: the CPU from where the clamp group has to be released
+ * @clamp_id: the utilization clamp (e.g. min or max utilization) to release
+ *
+ * When a task is dequeued from a CPU's RQ, the clamp group reference counted
+ * by the task, which is reported by task_struct::uclamp_group_id, is decrease
+ * for that CPU. If this was the last task defining the current max clamp
+ * group, then the CPU clamping is updated to find out the new max for the
+ * specified clamp index.
+ */
+static inline void uclamp_cpu_put(struct task_struct *p, int cpu, int clamp_id)
+{
+	struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
+	unsigned int clamp_value;
+	int group_id;
+
+	/* Decrement the task's reference counted group index */
+	group_id = p->uclamp_group_id[clamp_id];
+	uc_cpu->group[group_id].tasks -= 1;
+
+	/* Mark task as dequeued for this clamp IDX */
+	p->uclamp_group_id[clamp_id] = UCLAMP_NONE;
+
+	/* If this is not the last task, no updates are required */
+	if (uc_cpu->group[group_id].tasks > 0)
+		return;
+
+	/*
+	 * Update the CPU only if this was the last task of the group
+	 * defining the current clamp value.
+	 */
+	clamp_value = uc_cpu->group[group_id].value;
+	if (clamp_value >= uc_cpu->value)
+		uclamp_cpu_update(cpu, clamp_id);
+}
+
+/**
+ * uclamp_task_update: update clamp group referenced by a task
+ * @rq: the RQ the task is going to be enqueued/dequeued to/from
+ * @p: the task being enqueued/dequeued
+ *
+ * Utilization clamp constraints for a CPU depend on tasks which are active
+ * (i.e. RUNNABLE or RUNNING) on that CPU. To keep track of tasks
+ * requirements, each active task reference counts a clamp group in the CPU
+ * they are currently enqueued for execution.
+ *
+ * This method updates the utilization clamp constraints considering the
+ * requirements for the specified task. Thus, this update must be done before
+ * calling into the scheduling classes, which will eventually update schedutil
+ * considering the new task requirements.
+ */
+static inline void uclamp_task_update(struct rq *rq, struct task_struct *p)
+{
+	int cpu = cpu_of(rq);
+	int clamp_id;
+
+	/* The idle task does not affect CPU's clamps */
+	if (unlikely(p->sched_class == &idle_sched_class))
+		return;
+	/* DEADLINE tasks do not affect CPU's clamps */
+	if (unlikely(p->sched_class == &dl_sched_class))
+		return;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		if (uclamp_task_affects(p, clamp_id))
+			uclamp_cpu_put(p, cpu, clamp_id);
+		else
+			uclamp_cpu_get(p, cpu, clamp_id);
+	}
+}
+
+/**
+ * init_uclamp: initialize data structures required for utilization clamping
+ */
+static inline void init_uclamp(void)
+{
+	struct uclamp_cpu *uc_cpu;
+	int clamp_id;
+	int cpu;
+
+	mutex_init(&uclamp_mutex);
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		/* Init CPU's clamp groups */
+		for_each_possible_cpu(cpu) {
+			uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
+			memset(uc_cpu, UCLAMP_NONE, sizeof(struct uclamp_cpu));
+		}
+	}
+}
+
+#else /* CONFIG_UCLAMP_TASK */
+static inline void uclamp_task_update(struct rq *rq, struct task_struct *p) { }
+static inline void init_uclamp(void) { }
+#endif /* CONFIG_UCLAMP_TASK */
+
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (!(flags & ENQUEUE_NOCLOCK))
@@ -743,6 +929,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & ENQUEUE_RESTORE))
 		sched_info_queued(rq, p);
 
+	uclamp_task_update(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
 }
 
@@ -754,6 +941,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & DEQUEUE_SAVE))
 		sched_info_dequeued(rq, p);
 
+	uclamp_task_update(rq, p);
 	p->sched_class->dequeue_task(rq, p, flags);
 }
 
@@ -2154,6 +2342,14 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.cfs_rq			= NULL;
 #endif
 
+#ifdef CONFIG_UCLAMP_TASK
+	memset(&p->uclamp_group_id, UCLAMP_NONE, sizeof(p->uclamp_group_id));
+	p->uclamp[UCLAMP_MIN].value = 0;
+	p->uclamp[UCLAMP_MIN].group_id = UCLAMP_NONE;
+	p->uclamp[UCLAMP_MAX].value = SCHED_CAPACITY_SCALE;
+	p->uclamp[UCLAMP_MAX].group_id = UCLAMP_NONE;
+#endif
+
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
 	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
@@ -6108,6 +6304,8 @@ void __init sched_init(void)
 
 	init_schedstats();
 
+	init_uclamp();
+
 	scheduler_running = 1;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c3deaee7a7a2..be93d833ad6b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -423,6 +423,80 @@ static inline int walk_tg_tree(tg_visitor down, tg_visitor up, void *data)
 
 extern int tg_nop(struct task_group *tg, void *data);
 
+#ifdef CONFIG_UCLAMP_TASK
+/**
+ * Utilization clamp Group
+ *
+ * Keep track of how many tasks are RUNNABLE for a given utilization
+ * clamp value.
+ */
+struct uclamp_group {
+	/* Utilization clamp value for tasks on this clamp group */
+	int value;
+	/* Number of RUNNABLE tasks on this clamp group */
+	int tasks;
+};
+
+/**
+ * CPU's utilization clamp
+ *
+ * Keep track of active tasks on a CPUs to aggregate their clamp values.  A
+ * clamp value is affecting a CPU where there is at least one task RUNNABLE
+ * (or actually running) with that value.
+ * All utilization clamping values are MAX aggregated, since:
+ * - for util_min: we wanna run the CPU at least at the max of the minimum
+ *   utilization required by its currently active tasks.
+ * - for util_max: we wanna allow the CPU to run up to the max of the
+ *   maximum utilization allowed by its currently active tasks.
+ *
+ * Since on each system we expect only a limited number of utilization clamp
+ * values, we can use a simple array to track the metrics required to compute
+ * all the per-CPU utilization clamp values.
+ */
+struct uclamp_cpu {
+	/* Utilization clamp value for a CPU */
+	int value;
+	/* Utilization clamp groups affecting this CPU */
+	struct uclamp_group group[CONFIG_UCLAMP_GROUPS_COUNT + 1];
+};
+
+/**
+ * uclamp_task_affects: check if a task affects a utilization clamp
+ * @p: the task to consider
+ * @clamp_id: the utilization clamp to check
+ *
+ * A task affects a clamp index if its task_struct::uclamp_group_id is a
+ * valid clamp group index for the specified clamp index.
+ * Once a task is dequeued from a CPU, its clamp group indexes are reset to
+ * UCLAMP_NONE. A valid clamp group index is assigned to a task only when it
+ * is RUNNABLE on a CPU and it represents the clamp group which is currently
+ * reference counted by that task.
+ *
+ * Return: true if p currently affects the specified clamp_id
+ */
+static inline bool uclamp_task_affects(struct task_struct *p, int clamp_id)
+{
+	int task_group_id = p->uclamp_group_id[clamp_id];
+
+	return (task_group_id != UCLAMP_NONE);
+}
+
+/**
+ * uclamp_group_active: check if a clamp group is active on a CPU
+ * @uc_cpu: the array of clamp groups for a CPU
+ * @group_id: the clamp group to check
+ *
+ * A clamp group affects a CPU if it as at least one "active" task.
+ *
+ * Return: true if the specified CPU has at least one active task for
+ *         the specified clamp group.
+ */
+static inline bool uclamp_group_active(struct uclamp_cpu *uc_cpu, int group_id)
+{
+	return uc_cpu->group[group_id].tasks > 0;
+}
+#endif /* CONFIG_UCLAMP_TASK */
+
 extern void free_fair_sched_group(struct task_group *tg);
 extern int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent);
 extern void online_fair_sched_group(struct task_group *tg);
@@ -811,6 +885,11 @@ struct rq {
 	unsigned long		cpu_capacity;
 	unsigned long		cpu_capacity_orig;
 
+#ifdef CONFIG_UCLAMP_TASK
+	/* util_{min,max} clamp values based on CPU's active tasks */
+	struct uclamp_cpu uclamp[UCLAMP_CNT];
+#endif
+
 	struct callback_head	*balance_callback;
 
 	unsigned char		idle_balance;
-- 
2.15.1
