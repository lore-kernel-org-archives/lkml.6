Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753740AbeDIQ4j (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:56:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58518 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752666AbeDIQ4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:56:35 -0400
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
Subject: [PATCH 2/7] sched/core: uclamp: map TASK clamp values into CPU clamp groups
Date: Mon,  9 Apr 2018 17:56:10 +0100
Message-Id: <20180409165615.2326-3-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180409165615.2326-1-patrick.bellasi@arm.com>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilization clamping requires each CPU to know which clamp values are
assigned to tasks, which are currently active on that CPU, and multiple
tasks can be assigned the same clamp value, for a given clamp index
(clamp_id := util_{min,max}). Thus, it is required to map clamp values
to a data structure which is suitable for fast and efficient aggregation
of the clamp values required for by active tasks.

To this purpose we use a per-CPU array of reference counters,
where each slot is used to account how many tasks requiring a certain
clamp value are currently active on each CPU.
Each clamp value corresponds to a "clamp index" which identifies the
position within the reference counters array.

                                 :
                                 :
             SLOW PATH           :             FAST PATH
    task_struct::uclamp::value   :     sched/core::enqueue/dequeue
                                 :         cpufreq_schedutil
                                 :
  +----------------+    +--------------------+     +-------------------+
  |      TASK      |    |     CLAMP GROUP    |     |    CPU CLAMPS     |
  +----------------+    +--------------------+     +-------------------+
  |                |    |   clamp_{min,max}  |     |  clamp_{min,max}  |
  | util_{min,max} |    |      tg_count      |     |    tasks count    |
  +----------------+    +--------------------+     +-------------------+
                                 :
           +------------------>  :  +------------------->
     map(clamp_value, group_id)  :  ref_count(group_id)
                                 :
                                 :

This patch introduces the support to map tasks to "clamp groups".
Specifically it introduces the required functions to translate a clamp
value into a clamp group index (group_id).

Only a limited number of (different) clamp values are supported since:
1. there are usually only few classes of workloads for which it makes
   sense to boost/cap to different frequencies
   e.g. background vs foreground, interactive vs low-priority
2. it allows a simpler and more memory/time efficient tracking of
   the per-CPU clamp values in the fast path

The number of possible different clamp values is currently defined at
compile time. Thus, setting a new clamp value for a task can result into
a -ENOSPC error in case this will exceed the number of maximum different
clamp values supported.

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
 kernel/sched/core.c  | 294 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  21 ++++
 2 files changed, 315 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 009e65cbd4f4..a602b7b9d5f9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -747,6 +747,168 @@ static void set_load_weight(struct task_struct *p, bool update_load)
  */
 static DEFINE_MUTEX(uclamp_mutex);
 
+/**
+ * uclamp_map: reference counts a utilization "clamp value"
+ * @value:    the utilization "clamp value" required
+ * @se_count: the number of scheduling entities requiring the "clamp value"
+ * @se_lock:  serialize reference count updates by protecting se_count
+ */
+struct uclamp_map {
+	int value;
+	int se_count;
+	raw_spinlock_t se_lock;
+};
+
+/**
+ * uclamp_maps: maps each SEs "clamp value" into a CPUs "clamp group"
+ *
+ * Since only a limited number of different "clamp values" are supported, we
+ * need to map each possible "clamp value" into a "clamp group" to be used by
+ * the per-CPU accounting in the fast-path (i.e.  tasks enqueuing/dequeuing).
+ * We also support different kind of utilization clamping, min and max
+ * utilization, each representing a "clamp index" (clamp_id).
+ *
+ * A matrix is thus required to map clamp values to clamp groups (group_id)
+ * for each clamp index (clamp_id), where:
+ * - rows are indexed by clamp_id and collect the clamp groups for a given
+ *   clamp index, i.e. min or max utilization;
+ * - columns are indexed by group_id and collect the clamp values which maps
+ *   to that clamp group, i.e. actual uclamp_map instances;
+ *
+ * Thus, the column index of a given (clamp_id, value) pair represents the
+ * clamp group (group_id) used by the fast-path's per-CPU accounting.
+ *
+ * NOTE: first clamp group (group_id=0) is reserved for tracking of non
+ * clamped tasks.  Thus we allocate one more slot than the value of
+ * CONFIG_UCLAMP_GROUPS_COUNT.
+ *
+ * Here is the map layout and, right below, how entries are accessed by the
+ * following code.
+ *
+ *                          uclamp_maps is a matrix of
+ *          +------- UCLAMP_CNT by CONFIG_UCLAMP_GROUPS_COUNT+1 entries
+ *          |                                |
+ *          |                /---------------+---------------\
+ *          |               +------------+       +------------+
+ *          |  / UCLAMP_MIN | value      |       | value      |
+ *          |  |            | se_count   |...... | se_count   |
+ *          |  |            +------------+       +------------+
+ *          +--+            +------------+       +------------+
+ *             |            | value      |       | value      |
+ *             \ UCLAMP_MAX | se_count   |...... | se_count   |
+ *                          +-----^------+       +----^-------+
+ *                                |                   |
+ *                      uc_map =  +                   |
+ *                     &uclamp_maps[clamp_id][0]      +
+ *                                                clamp_value =
+ *                                       uc_map[group_id].value
+ */
+static struct uclamp_map uclamp_maps[UCLAMP_CNT][CONFIG_UCLAMP_GROUPS_COUNT + 1];
+
+/**
+ * uclamp_group_available: checks if a clamp group is available
+ * @clamp_id: the utilization clamp index (i.e. min or max clamp)
+ * @group_id: the group index in the given clamp_id
+ *
+ * A clamp group is not free if there is at least one TG's using a clamp value
+ * mapped on the specified clamp_id. These TG's are reference counted by the
+ * se_count of a uclamp_map entry.
+ *
+ * Return: true if there are no TG's mapped on the specified clamp
+ *         index and group
+ */
+static inline bool uclamp_group_available(int clamp_id, int group_id)
+{
+	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+
+	return (uc_map[group_id].value == UCLAMP_NONE);
+}
+
+/**
+ * uclamp_group_init: maps a clamp value on a specified clamp group
+ * @clamp_id: the utilization clamp index (i.e. min or max clamp)
+ * @group_id: the group index to map a given clamp_value
+ * @clamp_value: the utilization clamp value to map
+ *
+ * Each different clamp value, for a given clamp index (i.e. min/max
+ * utilization clamp), is mapped by a clamp group which index is use by the
+ * fast-path code to keep track of active tasks requiring a certain clamp
+ * value.
+ *
+ * This function initializes a clamp group to track tasks from the fast-path.
+ */
+static inline void uclamp_group_init(int clamp_id, int group_id,
+				     unsigned int clamp_value)
+{
+	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+	struct uclamp_cpu *uc_cpu;
+	int cpu;
+
+	/* Set clamp group map */
+	uc_map[group_id].value = clamp_value;
+	uc_map[group_id].se_count = 0;
+
+	/* Set clamp groups on all CPUs */
+	for_each_possible_cpu(cpu) {
+		uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
+		uc_cpu->group[group_id].value = clamp_value;
+		uc_cpu->group[group_id].tasks = 0;
+	}
+}
+
+/**
+ * uclamp_group_reset: resets a specified clamp group
+ * @clamp_id: the utilization clamp index (i.e. min or max clamping)
+ * @group_id: the group index to release
+ *
+ * A clamp group can be reset every time there are no more TGs using the
+ * clamp value it maps for a given clamp index.
+ */
+static inline void uclamp_group_reset(int clamp_id, int group_id)
+{
+	uclamp_group_init(clamp_id, group_id, UCLAMP_NONE);
+}
+
+/**
+ * uclamp_group_find: finds the group index of a utilization clamp group
+ * @clamp_id: the utilization clamp index (i.e. min or max clamping)
+ * @clamp_value: the utilization clamping value lookup for
+ *
+ * Verify if a group has been assigned to a certain clamp value and return
+ * its index to be used for accounting.
+ *
+ * Since only a limited number of utilization clamp groups are allowed, if no
+ * groups have been assigned for the specified value, a new group is assigned
+ * if possible. Otherwise an error is returned, meaning that a different clamp
+ * value is not (currently) supported.
+ */
+static int
+uclamp_group_find(int clamp_id, unsigned int clamp_value)
+{
+	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+	int free_group_id = UCLAMP_NONE;
+	unsigned int group_id = 0;
+
+	for ( ; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
+		/* Keep track of first free clamp group */
+		if (uclamp_group_available(clamp_id, group_id)) {
+			if (free_group_id == UCLAMP_NONE)
+				free_group_id = group_id;
+			continue;
+		}
+		/* Return index of first group with same clamp value */
+		if (uc_map[group_id].value == clamp_value)
+			return group_id;
+	}
+	/* Default to first free clamp group */
+	if (group_id > CONFIG_UCLAMP_GROUPS_COUNT)
+		group_id = free_group_id;
+	/* All clamp group already tracking different clamp values */
+	if (group_id == UCLAMP_NONE)
+		return -ENOSPC;
+	return group_id;
+}
+
 /**
  * uclamp_cpu_update: updates the utilization clamp of a CPU
  * @cpu: the CPU which utilization clamp has to be updated
@@ -896,18 +1058,150 @@ static inline void uclamp_task_update(struct rq *rq, struct task_struct *p)
 	}
 }
 
+/**
+ * uclamp_task_update_active: update the clamp group of a RUNNABLE task
+ * @p: the task which clamp groups must be updated
+ * @clamp_id: the clamp index to consider
+ * @group_id: the clamp group to update
+ *
+ * Each time the clamp value of a task group is changed, the old and new clamp
+ * groups have to be updated for each CPU containing a RUNNABLE task belonging
+ * to this tasks group. Sleeping tasks are not updated since they will be
+ * enqueued with the proper clamp group index at their next activation.
+ */
+static inline void
+uclamp_task_update_active(struct task_struct *p, int clamp_id, int group_id)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	/*
+	 * Lock the task and the CPU where the task is (or was) queued.
+	 *
+	 * We might lock the (previous) RQ of a !RUNNABLE task, but that's the
+	 * price to pay to safely serialize util_{min,max} updates with
+	 * enqueues, dequeues and migration operations.
+	 * This is the same locking schema used by __set_cpus_allowed_ptr().
+	 */
+	rq = task_rq_lock(p, &rf);
+
+	/*
+	 * The setting of the clamp group is serialized by task_rq_lock().
+	 * Thus, if the task's task_struct is not referencing a valid group
+	 * index, then that task is not yet RUNNABLE or it's going to be
+	 * enqueued with the proper clamp group value.
+	 */
+	if (!uclamp_task_active(p))
+		goto done;
+
+	/* Release p's currently referenced clamp group */
+	uclamp_cpu_put(p, task_cpu(p), clamp_id);
+
+	/* Get p's new clamp group */
+	uclamp_cpu_get(p, task_cpu(p), clamp_id);
+
+done:
+	task_rq_unlock(rq, p, &rf);
+}
+
+/**
+ * uclamp_group_put: decrease the reference count for a clamp group
+ * @clamp_id: the clamp index which was affected by a task group
+ * @uc_se: the utilization clamp data for that task group
+ *
+ * When the clamp value for a task group is changed we decrease the reference
+ * count for the clamp group mapping its current clamp value. A clamp group is
+ * released when there are no more task groups referencing its clamp value.
+ */
+static inline void uclamp_group_put(int clamp_id, int group_id)
+{
+	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+	unsigned long flags;
+
+	/* Ignore SE's not yet attached */
+	if (group_id == UCLAMP_NONE)
+		return;
+
+	/* Remove SE from this clamp group */
+	raw_spin_lock_irqsave(&uc_map[group_id].se_lock, flags);
+	uc_map[group_id].se_count -= 1;
+	if (uc_map[group_id].se_count == 0)
+		uclamp_group_reset(clamp_id, group_id);
+	raw_spin_unlock_irqrestore(&uc_map[group_id].se_lock, flags);
+}
+
+/**
+ * uclamp_group_get: increase the reference count for a clamp group
+ * @clamp_id: the clamp index affected by the task group
+ * @uc_se: the utilization clamp data for the task group
+ * @clamp_value: the new clamp value for the task group
+ *
+ * Each time a task group changes the utilization clamp value, for a specified
+ * clamp index, we need to find an available clamp group which can be used
+ * to track its new clamp value. The corresponding clamp group index will be
+ * used by tasks in this task group to reference count the clamp value on CPUs
+ * where they are enqueued.
+ *
+ * Return: -ENOSPC if there are not available clamp groups, 0 on success.
+ */
+static inline int uclamp_group_get(struct task_struct *p,
+				   int clamp_id, struct uclamp_se *uc_se,
+				   unsigned int clamp_value)
+{
+	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+	int prev_group_id = uc_se->group_id;
+	int next_group_id = UCLAMP_NONE;
+	unsigned long flags;
+
+	/* Lookup for a usable utilization clamp group */
+	next_group_id = uclamp_group_find(clamp_id, clamp_value);
+	if (next_group_id < 0) {
+		pr_err("Cannot allocate more than %d utilization clamp groups\n",
+		       CONFIG_UCLAMP_GROUPS_COUNT);
+		return -ENOSPC;
+	}
+
+	/* Allocate new clamp group for this clamp value */
+	if (uclamp_group_available(clamp_id, next_group_id))
+		uclamp_group_init(clamp_id, next_group_id, clamp_value);
+
+	/* Update SE's clamp values and attach it to new clamp group */
+	raw_spin_lock_irqsave(&uc_map[next_group_id].se_lock, flags);
+	uc_se->value = clamp_value;
+	uc_se->group_id = next_group_id;
+	uc_map[next_group_id].se_count += 1;
+	raw_spin_unlock_irqrestore(&uc_map[next_group_id].se_lock, flags);
+
+	/* Update current task if task specific clamp has been changed */
+	uclamp_task_update_active(p, clamp_id, next_group_id);
+
+	/* Release the previous clamp group */
+	uclamp_group_put(clamp_id, prev_group_id);
+
+	return 0;
+}
+
 /**
  * init_uclamp: initialize data structures required for utilization clamping
  */
 static inline void init_uclamp(void)
 {
 	struct uclamp_cpu *uc_cpu;
+	struct uclamp_map *uc_map;
+	int group_id;
 	int clamp_id;
 	int cpu;
 
 	mutex_init(&uclamp_mutex);
 
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		uc_map = &uclamp_maps[clamp_id][0];
+		/* Init SE's clamp map */
+		group_id = 0;
+		for ( ; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
+			uc_map[group_id].value = UCLAMP_NONE;
+			raw_spin_lock_init(&uc_map[group_id].se_lock);
+		}
 		/* Init CPU's clamp groups */
 		for_each_possible_cpu(cpu) {
 			uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be93d833ad6b..25c2011ecc41 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -481,6 +481,27 @@ static inline bool uclamp_task_affects(struct task_struct *p, int clamp_id)
 	return (task_group_id != UCLAMP_NONE);
 }
 
+/**
+ * uclamp_task_active: check if a task is currently clamping a CPU
+ * @p: the task to check
+ *
+ * A task affects the utilization clamp of a CPU if it references a valid
+ * clamp group index for at least one clamp index.
+ *
+ * Return: true if p is currently clamping the utilization of its CPU.
+ */
+static inline bool uclamp_task_active(struct task_struct *p)
+{
+	int clamp_id;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		if (uclamp_task_affects(p, clamp_id))
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * uclamp_group_active: check if a clamp group is active on a CPU
  * @uc_cpu: the array of clamp groups for a CPU
-- 
2.15.1
