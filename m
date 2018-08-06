Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFDDC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A18721A67
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A18721A67
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbeHFSus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:50:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41860 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387522AbeHFSur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35B6815AD;
        Mon,  6 Aug 2018 09:40:54 -0700 (PDT)
Received: from e110439-lin.Cambridge.Arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 68B023F5D0;
        Mon,  6 Aug 2018 09:40:51 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 08/14] sched/core: uclamp: extend cpu's cgroup controller
Date:   Mon,  6 Aug 2018 17:39:40 +0100
Message-Id: <20180806163946.28380-9-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806163946.28380-1-patrick.bellasi@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cgroup's CPU controller allows to assign a specified (maximum)
bandwidth to the tasks of a group. However this bandwidth is defined and
enforced only on a temporal base, without considering the actual
frequency a CPU is running on. Thus, the amount of computation completed
by a task within an allocated bandwidth can be very different depending
on the actual frequency the CPU is running that task.
The amount of computation can be affected also by the specific CPU a
task is running on, especially when running on asymmetric capacity
systems like Arm's big.LITTLE.

With the availability of schedutil, the scheduler is now able
to drive frequency selections based on actual task utilization.
Moreover, the utilization clamping support provides a mechanism to
bias the frequency selection operated by schedutil depending on
constraints assigned to the tasks currently RUNNABLE on a CPU.

Give the above mechanisms, it is now possible to extend the cpu
controller to specify what is the minimum (or maximum) utilization which
a task is expected (or allowed) to generate.
Constraints on minimum and maximum utilization allowed for tasks in a
CPU cgroup can improve the control on the actual amount of CPU bandwidth
consumed by tasks.

Utilization clamping constraints are useful not only to bias frequency
selection, when a task is running, but also to better support certain
scheduler decisions regarding task placement. For example, on
asymmetric capacity systems, a utilization clamp value can be
conveniently used to enforce important interactive tasks on more capable
CPUs or to run low priority and background tasks on more energy
efficient CPUs.

The ultimate goal of utilization clamping is thus to enable:

- boosting: by selecting an higher capacity CPU and/or higher execution
            frequency for small tasks which are affecting the user
            interactive experience.

- capping: by selecting more energy efficiency CPUs or lower execution
           frequency, for big tasks which are mainly related to
           background activities, and thus without a direct impact on
           the user experience.

Thus, a proper extension of the cpu controller with utilization clamping
support will make this controller even more suitable for integration
with advanced system management software (e.g. Android).
Indeed, an informed user-space can provide rich information hints to the
scheduler regarding the tasks it's going to schedule.

This patch extends the CPU controller by adding a couple of new
attributes, util.min and util.max, which can be used to enforce task's
utilization boosting and capping. Specifically:

- util.min: defines the minimum utilization which should be considered,
            e.g. when schedutil selects the frequency for a CPU while a
            task in this group is RUNNABLE.
            i.e. the task will run at least at a minimum frequency which
                corresponds to the min_util utilization

- util.max: defines the maximum utilization which should be considered,
            e.g. when schedutil selects the frequency for a CPU while a
            task in this group is RUNNABLE.
            i.e. the task will run up to a maximum frequency which
                corresponds to the max_util utilization

These attributes:

a) are available only for non-root nodes, both on default and legacy
   hierarchies
b) do not enforce any constraints and/or dependency between the parent
   and its child nodes, thus relying on the delegation model and
   permission settings defined by the system management software
c) allow to (eventually) further restrict task-specific clamps defined
   via sched_setattr(2)

This patch provides the basic support to expose the two new attributes
and to validate their run-time updates. However, we do not actually
allocated clamp groups and thus the write calls added by this patch
always returns -EINVAL. Following patches will provide the missing bits.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v3:
 Message-ID: <CAJuCfpFnj2g3+ZpR4fP4yqfxs0zd=c-Zehr2XM7m_C+WdL9jNA@mail.gmail.com>
 - rename UCLAMP_NONE into UCLAMP_NOT_VALID
 Message-ID: <20180409222417.GK3126663@devbig577.frc2.facebook.com>
 - use "." notation for attributes naming
   i.e. s/util_{min,max}/util.{min,max}/
 Others
 - rebased on tip/sched/core

Changes in v2:
 Message-ID: <20180409222417.GK3126663@devbig577.frc2.facebook.com>
 - make attributes available only on non-root nodes
   a system wide API seems of not immediate interest and thus it's not
   supported anymore
 - remove implicit parent-child constraints and dependencies
 Message-ID: <20180410200514.GA793541@devbig577.frc2.facebook.com>
 - add some cgroup-v2 documentation for the new attributes
 - (hopefully) better explain intended use-cases
   the changelog above has been extended to better justify the naming
   proposed by the new attributes
 Others:
 - rebased on v4.18-rc4
 - reduced code to simplify the review of this patch
   which now provides just the basic code for CGroups integration
 - add attributes to the default hierarchy as well as the legacy one
 - use -ERANGE as range violation error

These additional bits:
 - refcounting of clamp groups
 - RUNNABLE tasks refcount updates
 - aggregation of per-task and per-task_group utilization constraints
are provided in separate and following patches to make it more clear and
documented how they are performed.
---
 Documentation/admin-guide/cgroup-v2.rst |  25 ++++
 init/Kconfig                            |  22 +++
 kernel/sched/core.c                     | 186 ++++++++++++++++++++++++
 kernel/sched/sched.h                    |   5 +
 4 files changed, 238 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8a2c52d5c53b..71244b55d901 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -904,6 +904,12 @@ controller implements weight and absolute bandwidth limit models for
 normal scheduling policy and absolute bandwidth allocation model for
 realtime scheduling policy.
 
+Cycles distribution is based, by default, on a temporal base and it
+does not account for the frequency at which tasks are executed.
+The (optional) utilization clamping support allows to enforce a minimum
+bandwidth, which should always be provided by a CPU, and a maximum bandwidth,
+which should never be exceeded by a CPU.
+
 WARNING: cgroup2 doesn't yet support control of realtime processes and
 the cpu controller can only be enabled when all RT processes are in
 the root cgroup.  Be aware that system management software may already
@@ -963,6 +969,25 @@ All time durations are in microseconds.
 	$PERIOD duration.  "max" for $MAX indicates no limit.  If only
 	one number is written, $MAX is updated.
 
+  cpu.util.min
+        A read-write single value file which exists on non-root cgroups.
+        The default is "0", i.e. no bandwidth boosting.
+
+        The minimum utilization in the range [0, 1023].
+
+        This interface allows reading and setting minimum utilization clamp
+        values similar to the sched_setattr(2). This minimum utilization
+        value is used to clamp the task specific minimum utilization clamp.
+
+  cpu.util.max
+        A read-write single value file which exists on non-root cgroups.
+        The default is "1023". i.e. no bandwidth clamping
+
+        The maximum utilization in the range [0, 1023].
+
+        This interface allows reading and setting maximum utilization clamp
+        values similar to the sched_setattr(2). This maximum utilization
+        value is used to clamp the task specific maximum utilization clamp.
 
 Memory
 ------
diff --git a/init/Kconfig b/init/Kconfig
index 701300e8f0eb..592164e0b117 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -790,6 +790,28 @@ config RT_GROUP_SCHED
 
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
+	  frequency a task will always use.
+
+	  When task group based utilization clamping is enabled, an eventually
+          specified task-specific clamp value is constrained by the cgroup
+	  specified clamp value. Both minimum and maximum task clamping cannot
+          be bigger than the corresponding clamping defined at task group level.
+
+	  If in doubt, say N.
+
 config CGROUP_PIDS
 	bool "PIDs controller"
 	help
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ff76b000bbe8..2ba55a4afffb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1211,6 +1211,74 @@ static inline void uclamp_group_get(struct task_struct *p,
 	uclamp_group_put(clamp_id, prev_group_id);
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
+	/* Root TG's is statically assigned to the first clamp group */
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
+ * Return: 0 on error
+ */
+static inline int alloc_uclamp_sched_group(struct task_group *tg,
+					   struct task_group *parent)
+{
+	struct uclamp_se *uc_se;
+	int clamp_id;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		uc_se = &tg->uclamp[clamp_id];
+
+		uc_se->value = parent->uclamp[clamp_id].value;
+		uc_se->group_id = UCLAMP_NOT_VALID;
+	}
+
+	return 1;
+}
+#else /* CONFIG_UCLAMP_TASK_GROUP */
+static inline void init_uclamp_sched_group(void) { }
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
@@ -1308,11 +1376,18 @@ static void __init init_uclamp(void)
 			raw_spin_lock_init(&uc_map[group_id].se_lock);
 		}
 	}
+
+	init_uclamp_sched_group();
 }
 
 #else /* CONFIG_UCLAMP_TASK */
 static inline void uclamp_cpu_get(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_cpu_put(struct rq *rq, struct task_struct *p) { }
+static inline int alloc_uclamp_sched_group(struct task_group *tg,
+					   struct task_group *parent)
+{
+	return 1;
+}
 static inline int __setscheduler_uclamp(struct task_struct *p,
 					const struct sched_attr *attr)
 {
@@ -6898,6 +6973,9 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+	if (!alloc_uclamp_sched_group(tg, parent))
+		goto err;
+
 	return tg;
 
 err:
@@ -7118,6 +7196,88 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 		sched_move_task(task);
 }
 
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
+				  struct cftype *cftype, u64 min_value)
+{
+	struct task_group *tg;
+	int ret = -EINVAL;
+
+	if (min_value > SCHED_CAPACITY_SCALE)
+		return -ERANGE;
+
+	mutex_lock(&uclamp_mutex);
+	rcu_read_lock();
+
+	tg = css_tg(css);
+	if (tg->uclamp[UCLAMP_MIN].value == min_value) {
+		ret = 0;
+		goto out;
+	}
+	if (tg->uclamp[UCLAMP_MAX].value < min_value)
+		goto out;
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
+	struct task_group *tg;
+	int ret = -EINVAL;
+
+	if (max_value > SCHED_CAPACITY_SCALE)
+		return -ERANGE;
+
+	mutex_lock(&uclamp_mutex);
+	rcu_read_lock();
+
+	tg = css_tg(css);
+	if (tg->uclamp[UCLAMP_MAX].value == max_value) {
+		ret = 0;
+		goto out;
+	}
+	if (tg->uclamp[UCLAMP_MIN].value > max_value)
+		goto out;
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
@@ -7455,6 +7615,18 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_rt_period_read_uint,
 		.write_u64 = cpu_rt_period_write_uint,
 	},
+#endif
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	{
+		.name = "util.min",
+		.read_u64 = cpu_util_min_read_u64,
+		.write_u64 = cpu_util_min_write_u64,
+	},
+	{
+		.name = "util.max",
+		.read_u64 = cpu_util_max_read_u64,
+		.write_u64 = cpu_util_max_write_u64,
+	},
 #endif
 	{ }	/* Terminate */
 };
@@ -7622,6 +7794,20 @@ static struct cftype cpu_files[] = {
 		.seq_show = cpu_max_show,
 		.write = cpu_max_write,
 	},
+#endif
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	{
+		.name = "util_min",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_util_min_read_u64,
+		.write_u64 = cpu_util_min_write_u64,
+	},
+	{
+		.name = "util_max",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_util_max_read_u64,
+		.write_u64 = cpu_util_max_write_u64,
+	},
 #endif
 	{ }	/* terminate */
 };
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d5855babb9c9..a443b2c22cb7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -389,6 +389,11 @@ struct task_group {
 #endif
 
 	struct cfs_bandwidth	cfs_bandwidth;
+
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	struct			uclamp_se uclamp[UCLAMP_CNT];
+#endif
+
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.18.0

