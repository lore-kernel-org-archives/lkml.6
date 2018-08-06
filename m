Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA678C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9EF21A18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9EF21A18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbeHFSua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:50:30 -0400
Received: from foss.arm.com ([217.140.101.70]:41744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbeHFSua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2A9315AB;
        Mon,  6 Aug 2018 09:40:35 -0700 (PDT)
Received: from e110439-lin.Cambridge.Arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E1FE03F5D0;
        Mon,  6 Aug 2018 09:40:32 -0700 (PDT)
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
Subject: [PATCH v3 02/14] sched/core: uclamp: map TASK's clamp values into CPU's clamp groups
Date:   Mon,  6 Aug 2018 17:39:34 +0100
Message-Id: <20180806163946.28380-3-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806163946.28380-1-patrick.bellasi@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilization clamping requires each CPU to know which clamp values are
assigned to tasks that are currently RUNNABLE on that CPU.
Multiple tasks can be assigned the same clamp value and tasks with
different clamp values can be concurrently active on the same CPU.
Thus, a proper data structure is required to support a fast and
efficient aggregation of the clamp values required by the currently
RUNNABLE tasks.

For this purpose we use a per-CPU array of reference counters,
where each slot is used to account how many tasks require a certain
clamp value are currently RUNNABLE on each CPU.
Each clamp value corresponds to a "clamp index" which identifies the
position within the array of reference couters.

                                 :
       (user-space changes)      :      (kernel space / scheduler)
                                 :
             SLOW PATH           :             FAST PATH
                                 :
    task_struct::uclamp::value   :     sched/core::enqueue/dequeue
                                 :         cpufreq_schedutil
                                 :
  +----------------+    +--------------------+     +-------------------+
  |      TASK      |    |     CLAMP GROUP    |     |    CPU CLAMPS     |
  +----------------+    +--------------------+     +-------------------+
  |                |    |   clamp_{min,max}  |     |  clamp_{min,max}  |
  | util_{min,max} |    |      se_count      |     |    tasks count    |
  +----------------+    +--------------------+     +-------------------+
                                 :
           +------------------>  :  +------------------->
    group_id = map(clamp_value)  :  ref_count(group_id)
                                 :
                                 :

Let's introduce the support to map tasks to "clamp groups".
Specifically we introduce the required functions to translate a
"clamp value" into a clamp's "group index" (group_id).

Only a limited number of (different) clamp values are supported since:
1. there are usually only few classes of workloads for which it makes
   sense to boost/limit to different frequencies,
   e.g. background vs foreground, interactive vs low-priority
2. it allows a simpler and more memory/time efficient tracking of
   the per-CPU clamp values in the fast path.

The number of possible different clamp values is currently defined at
compile time. Thus, setting a new clamp value for a task can result into
a -ENOSPC error in case this will exceed the number of maximum different
clamp values supported.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Turner <pjt@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v3:
 Message-ID: <CAJuCfpF6=L=0LrmNnJrTNPazT4dWKqNv+thhN0dwpKCgUzs9sg@mail.gmail.com>
 - rename UCLAMP_NONE into UCLAMP_NOT_VALID
 - remove not necessary checks in uclamp_group_find()
 - add WARN on unlikely un-referenced decrement in uclamp_group_put()
 - make __setscheduler_uclamp() able to set just one clamp value
 - make __setscheduler_uclamp() failing if both clamps are required but
   there is no clamp groups available for one of them
 - remove uclamp_group_find() from uclamp_group_get() which now takes a
   group_id as a parameter
Others:
- rebased on tip/sched/core

Changes in v2:
 - rabased on v4.18-rc4
 - set UCLAMP_GROUPS_COUNT=2 by default
   which allows to fit all the hot-path CPU clamps data, partially
   intorduced also by the following patches, into a single cache line
   while still supporting up to 2 different {min,max}_utiql clamps.
---
 include/linux/sched.h      |  18 +-
 include/uapi/linux/sched.h |   6 +-
 init/Kconfig               |  20 +++
 kernel/sched/core.c        | 338 +++++++++++++++++++++++++++++++++++--
 4 files changed, 369 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 42f6439378e1..8f48e64fb8a6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -279,6 +279,9 @@ struct vtime {
 	u64			gtime;
 };
 
+/* Clamp not valid, i.e. group not assigned or invalid value */
+#define UCLAMP_NOT_VALID -1
+
 enum uclamp_id {
 	UCLAMP_MIN = 0, /* Minimum utilization */
 	UCLAMP_MAX,     /* Maximum utilization */
@@ -575,6 +578,19 @@ struct sched_dl_entity {
 	struct hrtimer inactive_timer;
 };
 
+/**
+ * Utilization's clamp group
+ *
+ * A utilization clamp group maps a "clamp value" (value), i.e.
+ * util_{min,max}, to a "clamp group index" (group_id).
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
@@ -659,7 +675,7 @@ struct task_struct {
 
 #ifdef CONFIG_UCLAMP_TASK
 	/* Utlization clamp values for this task */
-	int				uclamp[UCLAMP_CNT];
+	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index c27d6e81517b..ae7e12de32ca 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -50,7 +50,11 @@
 #define SCHED_FLAG_RESET_ON_FORK	0x01
 #define SCHED_FLAG_RECLAIM		0x02
 #define SCHED_FLAG_DL_OVERRUN		0x04
-#define SCHED_FLAG_UTIL_CLAMP		0x08
+
+#define SCHED_FLAG_UTIL_CLAMP_MIN	0x10
+#define SCHED_FLAG_UTIL_CLAMP_MAX	0x20
+#define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
+				 SCHED_FLAG_UTIL_CLAMP_MAX)
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
diff --git a/init/Kconfig b/init/Kconfig
index 1d45a6877d6f..701300e8f0eb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -601,7 +601,27 @@ config UCLAMP_TASK
 
 	  If in doubt, say N.
 
+config UCLAMP_GROUPS_COUNT
+	int "Number of different utilization clamp values supported"
+	range 0 32
+	default 5
+	depends on UCLAMP_TASK
+	help
+	  This defines the maximum number of different utilization clamp
+	  values which can be concurrently enforced for each utilization
+	  clamp index (i.e. minimum and maximum utilization).
+
+	  Only a limited number of clamp values are supported because:
+	    1. there are usually only few classes of workloads for which it
+	       makes sense to boost/cap for different frequencies,
+	       e.g. background vs foreground, interactive vs low-priority.
+	    2. it allows a simpler and more memory/time efficient tracking of
+	       the per-CPU clamp values.
+
+	  If in doubt, use the default value.
+
 endmenu
+
 #
 # For architectures that want to enable the support for NUMA-affine scheduler
 # balancing logic:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2cabbbcaa447..4caa2686644b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -717,25 +717,337 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 }
 
 #ifdef CONFIG_UCLAMP_TASK
+/**
+ * uclamp_mutex: serializes updates of utilization clamp values
+ *
+ * A utilization clamp value update is usually triggered from a user-space
+ * process (slow-path) but it requires a synchronization with the scheduler's
+ * (fast-path) enqueue/dequeue operations.
+ * While the fast-path synchronization is protected by RQs spinlock, this
+ * mutex ensures that we sequentially serve user-space requests.
+ */
+static DEFINE_MUTEX(uclamp_mutex);
+
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
+ * need to map each different clamp value into a "clamp group" (group_id) to
+ * be used by the per-CPU accounting in the fast-path, when tasks are
+ * enqueued and dequeued.
+ * We also support different kind of utilization clamping, min and max
+ * utilization for example, each representing what we call a "clamp index"
+ * (clamp_id).
+ *
+ * A matrix is thus required to map "clamp values" to "clamp groups"
+ * (group_id), for each "clamp index" (clamp_id), where:
+ * - rows are indexed by clamp_id and they collect the clamp groups for a
+ *   given clamp index
+ * - columns are indexed by group_id and they collect the clamp values which
+ *   maps to that clamp group
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
+static struct uclamp_map uclamp_maps[UCLAMP_CNT]
+				    [CONFIG_UCLAMP_GROUPS_COUNT + 1];
+
+/**
+ * uclamp_group_available: checks if a clamp group is available
+ * @clamp_id: the utilization clamp index (i.e. min or max clamp)
+ * @group_id: the group index in the given clamp_id
+ *
+ * A clamp group is not free if there is at least one SE which is sing a clamp
+ * value mapped on the specified clamp_id. These SEs are reference counted by
+ * the se_count of a uclamp_map entry.
+ *
+ * Return: true if there are no SE's mapped on the specified clamp
+ *         index and group
+ */
+static inline bool uclamp_group_available(int clamp_id, int group_id)
+{
+	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+
+	return (uc_map[group_id].value == UCLAMP_NOT_VALID);
+}
+
+/**
+ * uclamp_group_init: maps a clamp value on a specified clamp group
+ * @clamp_id: the utilization clamp index (i.e. min or max clamp)
+ * @group_id: the group index to map a given clamp_value
+ * @clamp_value: the utilization clamp value to map
+ *
+ * Initializes a clamp group to track tasks from the fast-path.
+ * Each different clamp value, for a given clamp index (i.e. min/max
+ * utilization clamp), is mapped by a clamp group which index is used by the
+ * fast-path code to keep track of RUNNABLE tasks requiring a certain clamp
+ * value.
+ *
+ */
+static inline void uclamp_group_init(int clamp_id, int group_id,
+				     unsigned int clamp_value)
+{
+	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+
+	uc_map[group_id].value = clamp_value;
+	uc_map[group_id].se_count = 0;
+}
+
+/**
+ * uclamp_group_reset: resets a specified clamp group
+ * @clamp_id: the utilization clamp index (i.e. min or max clamping)
+ * @group_id: the group index to release
+ *
+ * A clamp group can be reset every time there are no more task groups using
+ * the clamp value it maps for a given clamp index.
+ */
+static inline void uclamp_group_reset(int clamp_id, int group_id)
+{
+	uclamp_group_init(clamp_id, group_id, UCLAMP_NOT_VALID);
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
+ * groups have been assigned for the specified value, a new group is assigned,
+ * if possible.
+ * Otherwise an error is returned, meaning that an additional clamp value is
+ * not (currently) supported.
+ */
+static int
+uclamp_group_find(int clamp_id, unsigned int clamp_value)
+{
+	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+	int free_group_id = UCLAMP_NOT_VALID;
+	unsigned int group_id = 0;
+
+	for ( ; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
+		/* Keep track of first free clamp group */
+		if (uclamp_group_available(clamp_id, group_id)) {
+			if (free_group_id == UCLAMP_NOT_VALID)
+				free_group_id = group_id;
+			continue;
+		}
+		/* Return index of first group with same clamp value */
+		if (uc_map[group_id].value == clamp_value)
+			return group_id;
+	}
+
+	if (likely(free_group_id != UCLAMP_NOT_VALID))
+		return free_group_id;
+
+	return -ENOSPC;
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
+	if (group_id == UCLAMP_NOT_VALID)
+		return;
+
+	/* Remove SE from this clamp group */
+	raw_spin_lock_irqsave(&uc_map[group_id].se_lock, flags);
+#ifdef SCHED_DEBUG
+	if (unlikely(uc_map[group_id].se_count == 0)) {
+		WARN(1, "invalid SE clamp group [%d:%d] refcount\n",
+		     clamp_id, group_id);
+		uc_map[group_id].se_count = 1;
+	}
+#endif
+	uc_map[group_id].se_count -= 1;
+	if (uc_map[group_id].se_count == 0)
+		uclamp_group_reset(clamp_id, group_id);
+	raw_spin_unlock_irqrestore(&uc_map[group_id].se_lock, flags);
+}
+
+/**
+ * uclamp_group_get: increase the reference count for a clamp group
+ * @clamp_id: the clamp index affected by the task
+ * @next_group_id: the clamp group to refcount
+ * @uc_se: the utilization clamp data for the task
+ * @clamp_value: the new clamp value for the task
+ *
+ * Each time a task changes its utilization clamp value, for a specified clamp
+ * index, we need to find an available clamp group which can be used to track
+ * this new clamp value. The corresponding clamp group index will be used by
+ * the task to reference count the clamp value on CPUs while enqueued.
+ */
+static inline void uclamp_group_get(int clamp_id, int next_group_id,
+				   struct uclamp_se *uc_se,
+				   unsigned int clamp_value)
+{
+	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+	int prev_group_id = uc_se->group_id;
+	unsigned long flags;
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
+	/* Release the previous clamp group */
+	uclamp_group_put(clamp_id, prev_group_id);
+}
+
 static inline int __setscheduler_uclamp(struct task_struct *p,
 					const struct sched_attr *attr)
 {
-	if (attr->sched_util_min > attr->sched_util_max)
-		return -EINVAL;
-	if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
-		return -EINVAL;
+	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
+	struct uclamp_se *uc_se;
+	int result = 0;
 
-	p->uclamp[UCLAMP_MIN] = attr->sched_util_min;
-	p->uclamp[UCLAMP_MAX] = attr->sched_util_max;
+	mutex_lock(&uclamp_mutex);
 
-	return 0;
+	/* Find a valid group_id for each required clamp value */
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+		int upper_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
+			? attr->sched_util_max
+			: p->uclamp[UCLAMP_MAX].value;
+
+		if (upper_bound == UCLAMP_NOT_VALID)
+			upper_bound = SCHED_CAPACITY_SCALE;
+		if (attr->sched_util_min > upper_bound) {
+			result = -EINVAL;
+			goto done;
+		}
+
+		result = uclamp_group_find(UCLAMP_MIN, attr->sched_util_min);
+		if (result == -ENOSPC) {
+			pr_err("Cannot allocate more than %d UTIL_MIN clamp groups\n",
+			       CONFIG_UCLAMP_GROUPS_COUNT);
+			goto done;
+		}
+		group_id[UCLAMP_MIN] = result;
+	}
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+		int lower_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
+			? attr->sched_util_min
+			: p->uclamp[UCLAMP_MIN].value;
+
+		if (lower_bound == UCLAMP_NOT_VALID)
+			lower_bound = 0;
+		if (attr->sched_util_max < lower_bound ||
+		    attr->sched_util_max > SCHED_CAPACITY_SCALE) {
+			result = -EINVAL;
+			goto done;
+		}
+
+		result = uclamp_group_find(UCLAMP_MAX, attr->sched_util_max);
+		if (result == -ENOSPC) {
+			pr_err("Cannot allocate more than %d UTIL_MAX clamp groups\n",
+			       CONFIG_UCLAMP_GROUPS_COUNT);
+			goto done;
+		}
+		group_id[UCLAMP_MAX] = result;
+	}
+
+	/* Update each required clamp group */
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+		uc_se = &p->uclamp[UCLAMP_MIN];
+		uclamp_group_get(UCLAMP_MIN, group_id[UCLAMP_MIN],
+				 uc_se, attr->sched_util_min);
+	}
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+		uc_se = &p->uclamp[UCLAMP_MAX];
+		uclamp_group_get(UCLAMP_MAX, group_id[UCLAMP_MAX],
+				 uc_se, attr->sched_util_max);
+	}
+
+done:
+	mutex_unlock(&uclamp_mutex);
+
+	return result;
 }
+
+/**
+ * init_uclamp: initialize data structures required for utilization clamping
+ */
+static void __init init_uclamp(void)
+{
+	int clamp_id;
+
+	mutex_init(&uclamp_mutex);
+
+	/* Init SE's clamp map */
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+		int group_id = 0;
+
+		for ( ; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
+			uc_map[group_id].value = UCLAMP_NOT_VALID;
+			raw_spin_lock_init(&uc_map[group_id].se_lock);
+		}
+	}
+}
+
 #else /* CONFIG_UCLAMP_TASK */
 static inline int __setscheduler_uclamp(struct task_struct *p,
 					const struct sched_attr *attr)
 {
 	return -EINVAL;
 }
+static inline void init_uclamp(void) { }
 #endif /* CONFIG_UCLAMP_TASK */
 
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
@@ -2179,8 +2491,10 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 #endif
 
 #ifdef CONFIG_UCLAMP_TASK
-	p->uclamp[UCLAMP_MIN] = 0;
-	p->uclamp[UCLAMP_MAX] = SCHED_CAPACITY_SCALE;
+	p->uclamp[UCLAMP_MIN].value = 0;
+	p->uclamp[UCLAMP_MIN].group_id = UCLAMP_NOT_VALID;
+	p->uclamp[UCLAMP_MAX].value = SCHED_CAPACITY_SCALE;
+	p->uclamp[UCLAMP_MAX].group_id = UCLAMP_NOT_VALID;
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
@@ -4759,8 +5073,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		attr.sched_nice = task_nice(p);
 
 #ifdef CONFIG_UCLAMP_TASK
-	attr.sched_util_min = p->uclamp[UCLAMP_MIN];
-	attr.sched_util_max = p->uclamp[UCLAMP_MAX];
+	attr.sched_util_min = p->uclamp[UCLAMP_MIN].value;
+	attr.sched_util_max = p->uclamp[UCLAMP_MAX].value;
 #endif
 
 	rcu_read_unlock();
@@ -6117,6 +6431,8 @@ void __init sched_init(void)
 
 	init_schedstats();
 
+	init_uclamp();
+
 	scheduler_running = 1;
 }
 
-- 
2.18.0

