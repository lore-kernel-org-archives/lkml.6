Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbeDIQ4p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:56:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58550 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753746AbeDIQ4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:56:41 -0400
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
Subject: [PATCH 4/7] sched/core: uclamp: add utilization clamping to the CPU controller
Date: Mon,  9 Apr 2018 17:56:12 +0100
Message-Id: <20180409165615.2326-5-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180409165615.2326-1-patrick.bellasi@arm.com>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cgroup's CPU controller allows to assign a specified (maximum)
bandwidth to the tasks of a group. However this bandwidth is defined and
enforced only on a temporal base, without considering the actual
frequency a CPU is running on. Thus, the amount of computation completed
by a task within an allocated bandwidth can be very different depending
on the actual frequency the CPU is running that task.

With the availability of schedutil, the scheduler is now able
to drive frequency selections based on the actual tasks utilization.
Moreover, the utilization clamping support provides a mechanism to
constraint the frequency selection operated by schedutil depending on
constraints assigned to the tasks currently active on a CPU.

Give the above mechanisms, it is now possible to extend the cpu
controller to specify what is the minimum (or maximum) utilization which
a task is allowed to generate. By adding new constraints on minimum and
maximum utilization allowed for tasks in a cpu control group it will
also be possible to better control the actual amount of CPU bandwidth
consumed by these tasks.

The ultimate goal of this new pair of constraints is to enable:

- boosting: by selecting a higher execution frequency for small tasks
	    which are affecting the user interactive experience

- capping: by selecting lower execution frequency, which usually improves
	   energy efficiency, for big tasks which are mainly related to
	   background activities, and thus without a direct impact on
           the user experience.

This patch extends the CPU controller by adding a couple of new attributes,
util_min and util_max, which can be used to enforce frequency boosting and
capping. Specifically:

- util_min: defines the minimum CPU utilization which should be considered,
	    e.g. when  schedutil selects the frequency for a CPU while a
	    task in this group is RUNNABLE.
	    i.e. the task will run at least at a minimum frequency which
	         corresponds to the min_util utilization

- util_max: defines the maximum CPU utilization which should be considered,
	    e.g. when schedutil selects the frequency for a CPU while a
	    task in this group is RUNNABLE.
	    i.e. the task will run up to a maximum frequency which
	         corresponds to the max_util utilization

These attributes:
a) are tunable at all hierarchy levels, i.e. at root group level too, thus
   allowing to define the minimum and maximum frequency constraints for all
   otherwise non-classified tasks (e.g. autogroups) and to be a sort-of
   replacement for cpufreq's powersave, ondemand and performance
   governors.
b) allow to create subgroups of tasks which are not violating the
   utilization constraints defined by the parent group.

Tasks on a subgroup can only be more boosted and/or capped, which is
matching with the "limits" schema proposed by the "Resource Distribution
Model (RDM)" suggested by the CGroups v2 documentation:
   Documentation/cgroup-v2.txt

This patch provides the basic support to expose the two new attributes and
to validate their run-time update based on the "limits" of the
aforementioned RDM schema.

We first ensure that, whenever a task group is assigned a specific
clamp_value, this is properly translated into a unique clamp group to be
used in the fast-path (i.e. at enqueue/dequeue time). This is done by
slightly refactoring uclamp_group_get to accept a *cgroup_subsys_state
alongside *task_struct.

When uclamp_group_get is called with a valid *cgroup_subsys_state, a
clamp group is assigned to the task, which is possibly different than
the task specific clamp group. We then ensure to update the current
clamp group accounting for all the tasks which are currently runnable on
the cgroup via a new uclamp_group_get_tg() call.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
The actual aggregation of per-task and per-task_group utilization
constraints is provided in a separate patch to make it more clear and
documented how this aggregation is performed.
---
 init/Kconfig         |  22 +++++
 kernel/sched/core.c  | 271 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  21 ++++
 3 files changed, 311 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 977aa4d1e42a..d999879f8625 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -795,6 +795,28 @@ config RT_GROUP_SCHED
 
 endif #CGROUP_SCHED
 
+config UCLAMP_TASK_GROUP
+	bool "Utilization clamping per group of tasks"
+	depends on CGROUP_SCHED
+	depends on UCLAMP_TASK
+	default n
+	help
+	  This feature enables the scheduler to track the clamped utilization
+	  of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
+
+	  When this option is enabled, the user can specify a min and max
+	  CPU bandwidth which is allowed for each single task in a group.
+	  The max bandwidth allows to clamp the maximum frequency a task
+	  can use, while the min bandwidth allows to define a minimum
+	  frequency a task will alwasy use.
+
+	  When task group based utilization clamping is enabled,  an eventually
+          specified task-specific clamp value is constrained by the cgroup
+	  specified clamp value. Both minimum and maximum task clamping cannot
+          be bigger then the corresponing clamping defined at task group level.
+
+	  If in doubt, say N.
+
 config CGROUP_PIDS
 	bool "PIDs controller"
 	help
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6ee4f380aba6..b8299a4f03e7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1130,8 +1130,22 @@ static inline void uclamp_group_put(int clamp_id, int group_id)
 	raw_spin_unlock_irqrestore(&uc_map[group_id].se_lock, flags);
 }
 
+static inline void uclamp_group_get_tg(struct cgroup_subsys_state *css,
+				       int clamp_id, unsigned int group_id)
+{
+	struct css_task_iter it;
+	struct task_struct *p;
+
+	/* Update clamp groups for RUNNABLE tasks in this TG */
+	css_task_iter_start(css, 0, &it);
+	while ((p = css_task_iter_next(&it)))
+		uclamp_task_update_active(p, clamp_id, group_id);
+	css_task_iter_end(&it);
+}
+
 /**
  * uclamp_group_get: increase the reference count for a clamp group
+ * @css: reference to the task group to account
  * @clamp_id: the clamp index affected by the task group
  * @uc_se: the utilization clamp data for the task group
  * @clamp_value: the new clamp value for the task group
@@ -1145,6 +1159,7 @@ static inline void uclamp_group_put(int clamp_id, int group_id)
  * Return: -ENOSPC if there are not available clamp groups, 0 on success.
  */
 static inline int uclamp_group_get(struct task_struct *p,
+				   struct cgroup_subsys_state *css,
 				   int clamp_id, struct uclamp_se *uc_se,
 				   unsigned int clamp_value)
 {
@@ -1172,8 +1187,13 @@ static inline int uclamp_group_get(struct task_struct *p,
 	uc_map[next_group_id].se_count += 1;
 	raw_spin_unlock_irqrestore(&uc_map[next_group_id].se_lock, flags);
 
+	/* Newly created TG don't have tasks assigned */
+	if (css)
+		uclamp_group_get_tg(css, clamp_id, next_group_id);
+
 	/* Update current task if task specific clamp has been changed */
-	uclamp_task_update_active(p, clamp_id, next_group_id);
+	if (p)
+		uclamp_task_update_active(p, clamp_id, next_group_id);
 
 	/* Release the previous clamp group */
 	uclamp_group_put(clamp_id, prev_group_id);
@@ -1181,6 +1201,103 @@ static inline int uclamp_group_get(struct task_struct *p,
 	return 0;
 }
 
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+/**
+ * init_uclamp_sched_group: initialize data structures required for TG's
+ *                          utilization clamping
+ */
+static inline void init_uclamp_sched_group(void)
+{
+	struct uclamp_map *uc_map;
+	struct uclamp_se *uc_se;
+	int group_id;
+	int clamp_id;
+
+	/* Root TG's are initialized to the first clamp group */
+	group_id = 0;
+
+	/* Initialize root TG's to default (none) clamp values */
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		uc_map = &uclamp_maps[clamp_id][0];
+
+		/* Map root TG's clamp value */
+		uclamp_group_init(clamp_id, group_id, uclamp_none(clamp_id));
+
+		/* Init root TG's clamp group */
+		uc_se = &root_task_group.uclamp[clamp_id];
+		uc_se->value = uclamp_none(clamp_id);
+		uc_se->group_id = group_id;
+
+		/* Attach root TG's clamp group */
+		uc_map[group_id].se_count = 1;
+	}
+}
+
+/**
+ * alloc_uclamp_sched_group: initialize a new TG's for utilization clamping
+ * @tg: the newly created task group
+ * @parent: its parent task group
+ *
+ * A newly created task group inherits its utilization clamp values, for all
+ * clamp indexes, from its parent task group.
+ * This ensures that its values are properly initialized and that the task
+ * group is accounted in the same parent's group index.
+ *
+ * Return: !0 on error
+ */
+static inline int alloc_uclamp_sched_group(struct task_group *tg,
+					   struct task_group *parent)
+{
+	struct uclamp_se *uc_se;
+	int clamp_id;
+	int ret = 1;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		uc_se = &tg->uclamp[clamp_id];
+
+		uc_se->value = parent->uclamp[clamp_id].value;
+		uc_se->group_id = UCLAMP_NONE;
+
+		if (uclamp_group_get(NULL, NULL, clamp_id, uc_se,
+				     parent->uclamp[clamp_id].value)) {
+			ret = 0;
+			goto out;
+		}
+	}
+
+out:
+	return ret;
+}
+
+/**
+ * release_uclamp_sched_group: release utilization clamp references of a TG
+ * @tg: the task group being removed
+ *
+ * An empty task group can be removed only when it has no more tasks or child
+ * groups. This means that we can also safely release all the reference
+ * counting to clamp groups.
+ */
+static inline void free_uclamp_sched_group(struct task_group *tg)
+{
+	struct uclamp_se *uc_se;
+	int clamp_id;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		uc_se = &tg->uclamp[clamp_id];
+		uclamp_group_put(clamp_id, uc_se->group_id);
+	}
+}
+
+#else /* CONFIG_UCLAMP_TASK_GROUP */
+static inline void init_uclamp_sched_group(void) { }
+static inline void free_uclamp_sched_group(struct task_group *tg) { }
+static inline int alloc_uclamp_sched_group(struct task_group *tg,
+					   struct task_group *parent)
+{
+	return 1;
+}
+#endif /* CONFIG_UCLAMP_TASK_GROUP */
+
 static inline int __setscheduler_uclamp(struct task_struct *p,
 					const struct sched_attr *attr)
 {
@@ -1196,12 +1313,12 @@ static inline int __setscheduler_uclamp(struct task_struct *p,
 
 	/* Update min utilization clamp */
 	uc_se = &p->uclamp[UCLAMP_MIN];
-	retval |= uclamp_group_get(p, UCLAMP_MIN, uc_se,
+	retval |= uclamp_group_get(p, NULL, UCLAMP_MIN, uc_se,
 				   attr->sched_util_min);
 
 	/* Update max utilization clamp */
 	uc_se = &p->uclamp[UCLAMP_MAX];
-	retval |= uclamp_group_get(p, UCLAMP_MAX, uc_se,
+	retval |= uclamp_group_get(p, NULL, UCLAMP_MAX, uc_se,
 				   attr->sched_util_max);
 
 	mutex_unlock(&uclamp_mutex);
@@ -1243,10 +1360,18 @@ static inline void init_uclamp(void)
 			memset(uc_cpu, UCLAMP_NONE, sizeof(struct uclamp_cpu));
 		}
 	}
+
+	init_uclamp_sched_group();
 }
 
 #else /* CONFIG_UCLAMP_TASK */
 static inline void uclamp_task_update(struct rq *rq, struct task_struct *p) { }
+static inline void free_uclamp_sched_group(struct task_group *tg) { }
+static inline int alloc_uclamp_sched_group(struct task_group *tg,
+					   struct task_group *parent)
+{
+	return 1;
+}
 static inline int __setscheduler_uclamp(struct task_struct *p,
 					const struct sched_attr *attr)
 {
@@ -6823,6 +6948,7 @@ static DEFINE_SPINLOCK(task_group_lock);
 
 static void sched_free_group(struct task_group *tg)
 {
+	free_uclamp_sched_group(tg);
 	free_fair_sched_group(tg);
 	free_rt_sched_group(tg);
 	autogroup_free(tg);
@@ -6844,6 +6970,9 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+	if (!alloc_uclamp_sched_group(tg, parent))
+		goto err;
+
 	return tg;
 
 err:
@@ -7064,6 +7193,130 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 		sched_move_task(task);
 }
 
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
+				  struct cftype *cftype, u64 min_value)
+{
+	struct cgroup_subsys_state *pos;
+	struct uclamp_se *uc_se;
+	struct task_group *tg;
+	int ret = -EINVAL;
+
+	if (min_value > SCHED_CAPACITY_SCALE)
+		return ret;
+
+	mutex_lock(&uclamp_mutex);
+	rcu_read_lock();
+
+	tg = css_tg(css);
+
+	/* Already at the required value */
+	if (tg->uclamp[UCLAMP_MIN].value == min_value) {
+		ret = 0;
+		goto out;
+	}
+
+	/* Ensure to not exceed the maximum clamp value */
+	if (tg->uclamp[UCLAMP_MAX].value < min_value)
+		goto out;
+
+	/* Ensure min clamp fits within parent's clamp value */
+	if (tg->parent &&
+	    tg->parent->uclamp[UCLAMP_MIN].value > min_value)
+		goto out;
+
+	/* Ensure each child is a restriction of this TG */
+	css_for_each_child(pos, css) {
+		if (css_tg(pos)->uclamp[UCLAMP_MIN].value < min_value)
+			goto out;
+	}
+
+	/* Update TG's reference count */
+	uc_se = &tg->uclamp[UCLAMP_MIN];
+	ret = uclamp_group_get(NULL, css, UCLAMP_MIN, uc_se, min_value);
+
+out:
+	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
+
+	return ret;
+}
+
+static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
+				  struct cftype *cftype, u64 max_value)
+{
+	struct cgroup_subsys_state *pos;
+	struct uclamp_se *uc_se;
+	struct task_group *tg;
+	int ret = -EINVAL;
+
+	if (max_value > SCHED_CAPACITY_SCALE)
+		return ret;
+
+	mutex_lock(&uclamp_mutex);
+	rcu_read_lock();
+
+	tg = css_tg(css);
+
+	/* Already at the required value */
+	if (tg->uclamp[UCLAMP_MAX].value == max_value) {
+		ret = 0;
+		goto out;
+	}
+
+	/* Ensure to not go below the minimum clamp value */
+	if (tg->uclamp[UCLAMP_MIN].value > max_value)
+		goto out;
+
+	/* Ensure max clamp fits within parent's clamp value */
+	if (tg->parent &&
+	    tg->parent->uclamp[UCLAMP_MAX].value < max_value)
+		goto out;
+
+	/* Ensure each child is a restriction of this TG */
+	css_for_each_child(pos, css) {
+		if (css_tg(pos)->uclamp[UCLAMP_MAX].value > max_value)
+			goto out;
+	}
+
+	/* Update TG's reference count */
+	uc_se = &tg->uclamp[UCLAMP_MAX];
+	ret = uclamp_group_get(NULL, css, UCLAMP_MAX, uc_se, max_value);
+
+out:
+	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
+
+	return ret;
+}
+
+static inline u64 cpu_uclamp_read(struct cgroup_subsys_state *css,
+				  enum uclamp_id clamp_id)
+{
+	struct task_group *tg;
+	u64 util_clamp;
+
+	rcu_read_lock();
+	tg = css_tg(css);
+	util_clamp = tg->uclamp[clamp_id].value;
+	rcu_read_unlock();
+
+	return util_clamp;
+}
+
+static u64 cpu_util_min_read_u64(struct cgroup_subsys_state *css,
+				 struct cftype *cft)
+{
+	return cpu_uclamp_read(css, UCLAMP_MIN);
+}
+
+static u64 cpu_util_max_read_u64(struct cgroup_subsys_state *css,
+				 struct cftype *cft)
+{
+	return cpu_uclamp_read(css, UCLAMP_MAX);
+}
+#endif /* CONFIG_UCLAMP_TASK_GROUP */
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cftype, u64 shareval)
@@ -7391,6 +7644,18 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_rt_period_read_uint,
 		.write_u64 = cpu_rt_period_write_uint,
 	},
+#endif
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	{
+		.name = "util_min",
+		.read_u64 = cpu_util_min_read_u64,
+		.write_u64 = cpu_util_min_write_u64,
+	},
+	{
+		.name = "util_max",
+		.read_u64 = cpu_util_max_read_u64,
+		.write_u64 = cpu_util_max_write_u64,
+	},
 #endif
 	{ }	/* Terminate */
 };
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 25c2011ecc41..a91b9cd162a3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -388,6 +388,11 @@ struct task_group {
 #endif
 
 	struct cfs_bandwidth	cfs_bandwidth;
+
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	struct			uclamp_se uclamp[UCLAMP_CNT];
+#endif
+
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -460,6 +465,22 @@ struct uclamp_cpu {
 	struct uclamp_group group[CONFIG_UCLAMP_GROUPS_COUNT + 1];
 };
 
+/**
+ * uclamp_none: default value for a clamp
+ *
+ * This returns the default value for each clamp
+ * - 0 for a min utilization clamp
+ * - SCHED_CAPACITY_SCALE for a max utilization clamp
+ *
+ * Return: the default value for a given utilization clamp
+ */
+static inline unsigned int uclamp_none(int clamp_id)
+{
+	if (clamp_id == UCLAMP_MIN)
+		return 0;
+	return SCHED_CAPACITY_SCALE;
+}
+
 /**
  * uclamp_task_affects: check if a task affects a utilization clamp
  * @p: the task to consider
-- 
2.15.1
