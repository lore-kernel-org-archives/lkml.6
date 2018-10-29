Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A265C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C275F2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C275F2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbeJ3DXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:23:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44552 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729456AbeJ3DXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:23:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2F3B165C;
        Mon, 29 Oct 2018 11:33:38 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BDBE03F6A8;
        Mon, 29 Oct 2018 11:33:35 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v5 03/15] sched/core: uclamp: map TASK's clamp values into CPU's clamp groups
Date:   Mon, 29 Oct 2018 18:32:57 +0000
Message-Id: <20181029183311.29175-4-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181029183311.29175-1-patrick.bellasi@arm.com>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilization clamping requires each CPU to know which clamp values are
assigned to tasks that are currently RUNNABLE on that CPU: multiple
tasks can be assigned the same clamp value and tasks with different
clamp values can be concurrently active on the same CPU.

A proper data structure is required to support a fast and efficient
aggregation of the clamp values required by the currently RUNNABLE
tasks. To this purpose, a per-CPU array of reference counters can be
used, where each slot tracks how many tasks, requiring the same clamp
value, are currently RUNNABLE on each CPU.

Thus we need a mechanism to map each "clamp value" into a corresponding
"clamp index" which identifies the position within a reference counters
array used to track RUNNABLE tasks.

Let's introduce the support to map tasks to "clamp groups".
Specifically we introduce the required functions to translate a
"clamp value" (clamp_value) into a clamp's "group index" (group_id).

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

Only a limited number of (different) clamp values are supported since:
1. there are usually only few classes of workloads for which it makes
   sense to boost/limit to different frequencies,
   e.g. background vs foreground, interactive vs low-priority
2. it allows a simpler and more memory/time efficient tracking of
   the per-CPU clamp values in the fast path.

The number of possible different clamp values is currently defined at
compile time. Thus, setting a new clamp value for a task can result into
the impossibility to map it into a dedicated clamp index.
Those tasks will be flagged as "not mapped" and not tracked at
enqueue/dequeue time.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Turner <pjt@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---

A following patch:

   sched/core: uclamp: add clamp group bucketing support

will fix the "not mapped" tasks not being tracked.

Changes in v5:
 Message-ID: <20180912161218.GW24082@hirez.programming.kicks-ass.net>
 - use bitfields and atomic_long_cmpxchg() operations to both compress
   the clamp maps and avoid usage of spinlock.
 - remove enforced __cacheline_aligned_in_smp on uclamp_map since it's
   accessed from the slow path only and we don't care about performance
 - better describe the usage of uclamp_map::se_lock
 Message-ID: <20180912162427.GA24106@hirez.programming.kicks-ass.net>
 - remove inline from uclamp_group_{get,put}() and __setscheduler_uclamp()
 - set lower/upper bounds at the beginning of __setscheduler_uclamp()
 - avoid usage of pr_err from unprivileged syscall paths
   in  __setscheduler_uclamp(), replaced by ratelimited version
 Message-ID: <20180914134128.GP1413@e110439-lin>
 - remove/limit usage of UCLAMP_NOT_VALID whenever not strictly required
 Message-ID: <20180905104545.GB20267@localhost.localdomain>
 - allow sched_setattr() syscall to sleep on mutex
 - fix return value for successfull uclamp syscalls
 Message-ID: <CAJuCfpF36-VZm0JVVNnOnGm-ukVejzxbPhH33X3z9gAQ06t9gQ@mail.gmail.com>
 - reorder conditions in uclamp_group_find() loop
 - use uc_se->xxx in uclamp_fork()
 Others:
 - use UCLAMP_GROUPS to track (CONFIG_UCLAMP_GROUPS_COUNT+1)
 - rebased on v4.19

Changes in v4:
 Message-ID: <20180814112509.GB2661@codeaurora.org>
 - add uclamp_exit_task() to release clamp refcount from do_exit()
 Message-ID: <20180816133249.GA2964@e110439-lin>
 - keep the WARN but butify a bit that code
 Message-ID: <20180413082648.GP4043@hirez.programming.kicks-ass.net>
 - move uclamp_enabled at the top of sched_class to keep it on the same
   cache line of other main wakeup time callbacks
 Others:
 - init uclamp for the init_task and refcount its clamp groups
 - add uclamp specific fork time code into uclamp_fork
 - add support for SCHED_FLAG_RESET_ON_FORK
   default clamps are now set for init_task and inherited/reset at
   fork time (when then flag is set for the parent)
 - enable uclamp only for FAIR tasks, RT class will be enabled only
   by a following patch which also integrate the class to schedutil
 - define uclamp_maps ____cacheline_aligned_in_smp
 - in uclamp_group_get() ensure to include uclamp_group_available() and
   uclamp_group_init() into the atomic section defined by:
      uc_map[next_group_id].se_lock
 - do not use mutex_lock(&uclamp_mutex) in uclamp_exit_task
   which is also not needed since refcounting is already guarded by
   the uc_map[group_id].se_lock spinlock
 - rebased on v4.19-rc1
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
 include/linux/sched.h          |  39 ++++-
 include/linux/sched/task.h     |   6 +
 include/linux/sched/topology.h |   6 -
 include/uapi/linux/sched.h     |   5 +-
 init/Kconfig                   |  20 +++
 init/init_task.c               |   4 -
 kernel/exit.c                  |   1 +
 kernel/sched/core.c            | 283 ++++++++++++++++++++++++++++++---
 kernel/sched/fair.c            |   4 +
 kernel/sched/sched.h           |  28 +++-
 10 files changed, 363 insertions(+), 33 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 880a0c5c1f87..facace271ea1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -318,6 +318,12 @@ struct sched_info {
 # define SCHED_FIXEDPOINT_SHIFT		10
 # define SCHED_FIXEDPOINT_SCALE		(1L << SCHED_FIXEDPOINT_SHIFT)
 
+/*
+ * Increase resolution of cpu_capacity calculations
+ */
+#define SCHED_CAPACITY_SHIFT	SCHED_FIXEDPOINT_SHIFT
+#define SCHED_CAPACITY_SCALE	(1L << SCHED_CAPACITY_SHIFT)
+
 struct load_weight {
 	unsigned long			weight;
 	u32				inv_weight;
@@ -575,6 +581,37 @@ struct sched_dl_entity {
 	struct hrtimer inactive_timer;
 };
 
+#ifdef CONFIG_UCLAMP_TASK
+/*
+ * Number of utiliation clamp groups
+ *
+ * The first clamp group (group_id=0) is used to track non clamped tasks, i.e.
+ * util_{min,max} (0,SCHED_CAPACITY_SCALE). Thus we allocate one more group in
+ * addition to the configured number.
+ */
+#define UCLAMP_GROUPS (CONFIG_UCLAMP_GROUPS_COUNT + 1)
+
+/**
+ * Utilization clamp group
+ *
+ * A utilization clamp group maps a:
+ *   clamp value (value), i.e.
+ *   util_{min,max} value requested from userspace
+ * to a:
+ *   clamp group index (group_id), i.e.
+ *   index of the per-cpu RUNNABLE tasks refcounting array
+ *
+ * The mapped bit is set whenever a task has been mapped on a clamp group for
+ * the first time. When this bit is set, any clamp group get (for a new clamp
+ * value) will be matches by a clamp group put (for the old clamp value).
+ */
+struct uclamp_se {
+	unsigned int value		: SCHED_CAPACITY_SHIFT + 1;
+	unsigned int group_id		: order_base_2(UCLAMP_GROUPS);
+	unsigned int mapped		: 1;
+};
+#endif /* CONFIG_UCLAMP_TASK */
+
 union rcu_special {
 	struct {
 		u8			blocked;
@@ -659,7 +696,7 @@ struct task_struct {
 
 #ifdef CONFIG_UCLAMP_TASK
 	/* Utlization clamp values for this task */
-	int				uclamp[UCLAMP_CNT];
+	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 108ede99e533..36c81c364112 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -68,6 +68,12 @@ static inline void exit_thread(struct task_struct *tsk)
 #endif
 extern void do_group_exit(int);
 
+#ifdef CONFIG_UCLAMP_TASK
+extern void uclamp_exit_task(struct task_struct *p);
+#else
+static inline void uclamp_exit_task(struct task_struct *p) { }
+#endif /* CONFIG_UCLAMP_TASK */
+
 extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 26347741ba50..350043d203db 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -6,12 +6,6 @@
 
 #include <linux/sched/idle.h>
 
-/*
- * Increase resolution of cpu_capacity calculations
- */
-#define SCHED_CAPACITY_SHIFT	SCHED_FIXEDPOINT_SHIFT
-#define SCHED_CAPACITY_SCALE	(1L << SCHED_CAPACITY_SHIFT)
-
 /*
  * sched-domains (multiprocessor balancing) declarations:
  */
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 62498d749bec..e6f2453eb5a5 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -53,7 +53,10 @@
 #define SCHED_FLAG_RECLAIM		0x02
 #define SCHED_FLAG_DL_OVERRUN		0x04
 #define SCHED_FLAG_TUNE_POLICY		0x08
-#define SCHED_FLAG_UTIL_CLAMP		0x10
+#define SCHED_FLAG_UTIL_CLAMP_MIN	0x10
+#define SCHED_FLAG_UTIL_CLAMP_MAX	0x20
+#define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
+				 SCHED_FLAG_UTIL_CLAMP_MAX)
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
diff --git a/init/Kconfig b/init/Kconfig
index 738974c4f628..4c5475030286 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -633,7 +633,27 @@ config UCLAMP_TASK
 
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
+	       per-CPU clamp values.
+
+	  If in doubt, use the default value.
+
 endmenu
+
 #
 # For architectures that want to enable the support for NUMA-affine scheduler
 # balancing logic:
diff --git a/init/init_task.c b/init/init_task.c
index 5bfdcc3fb839..7f77741b6a9b 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -92,10 +92,6 @@ struct task_struct init_task
 #endif
 #ifdef CONFIG_CGROUP_SCHED
 	.sched_task_group = &root_task_group,
-#endif
-#ifdef CONFIG_UCLAMP_TASK
-	.uclamp[UCLAMP_MIN] = 0,
-	.uclamp[UCLAMP_MAX] = SCHED_CAPACITY_SCALE,
 #endif
 	.ptraced	= LIST_HEAD_INIT(init_task.ptraced),
 	.ptrace_entry	= LIST_HEAD_INIT(init_task.ptrace_entry),
diff --git a/kernel/exit.c b/kernel/exit.c
index 0e21e6d21f35..feb540558051 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -877,6 +877,7 @@ void __noreturn do_exit(long code)
 
 	sched_autogroup_exit_task(tsk);
 	cgroup_exit(tsk);
+	uclamp_exit_task(tsk);
 
 	/*
 	 * FIXME: do that only when needed, using sched_exit tracepoint
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2e12eaa377..654327d7f212 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -717,25 +717,266 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 }
 
 #ifdef CONFIG_UCLAMP_TASK
-static inline int __setscheduler_uclamp(struct task_struct *p,
-					const struct sched_attr *attr)
+/**
+ * uclamp_mutex: serializes updates of utilization clamp values
+ *
+ * Utilization clamp value updates are triggered from user-space (slow-path)
+ * but require refcounting updates on data structures used by scheduler's
+ * enqueue/dequeue operations (fast-path).
+ * While fast-path refcounting is enforced by atomic operations, this mutex
+ * ensures that we serialize user-space requests thus avoiding the risk of
+ * conflicting updates or API abuses.
+ */
+static DEFINE_MUTEX(uclamp_mutex);
+
+/**
+ * uclamp_map: reference count utilization clamp groups
+ * @value:    the utilization "clamp value" tracked by this clamp group
+ * @se_count: the number of scheduling entities using this "clamp value"
+ */
+union uclamp_map {
+	struct {
+		unsigned long value	: SCHED_CAPACITY_SHIFT + 1;
+		unsigned long se_count	: BITS_PER_LONG -
+					  SCHED_CAPACITY_SHIFT - 1;
+	};
+	unsigned long data;
+	atomic_long_t adata;
+};
+
+/**
+ * uclamp_maps: map SEs "clamp value" into CPUs "clamp group"
+ *
+ * Since only a limited number of different "clamp values" are supported, we
+ * map each value into a "clamp group" (group_id) used at tasks {en,de}queued
+ * time to update a per-CPU refcounter tracking the number or RUNNABLE tasks
+ * requesting that clamp value.
+ * A "clamp index" (clamp_id) is used to define the kind of clamping, i.e. min
+ * and max utilization.
+ *
+ * A matrix is thus required to map "clamp values" (value) to "clamp groups"
+ * (group_id), for each "clamp index" (clamp_id), where:
+ * - rows are indexed by clamp_id and they collect the clamp groups for a
+ *   given clamp index
+ * - columns are indexed by group_id and they collect the clamp values which
+ *   maps to that clamp group
+ *
+ * Thus, the column index of a given (clamp_id, value) pair represents the
+ * clamp group (group_id) used by the fast-path's per-CPU refcounter.
+ *
+ *                          uclamp_maps is a matrix of
+ *          +------- UCLAMP_CNT by UCLAMP_GROUPS entries
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
+ *                                                    |
+ *                                                    |
+ *                                                    +
+ *                          uclamp_maps[clamp_id][group_id].value
+ */
+static union uclamp_map uclamp_maps[UCLAMP_CNT][UCLAMP_GROUPS];
+
+/**
+ * uclamp_group_put: decrease the reference count for a clamp group
+ * @clamp_id: the clamp index which was affected by a task group
+ * @group_id: the clamp group to release
+ *
+ * When the clamp value for a task group is changed we decrease the reference
+ * count for the clamp group mapping its current clamp value.
+ */
+static void uclamp_group_put(unsigned int clamp_id, unsigned int group_id)
 {
-	if (attr->sched_util_min > attr->sched_util_max)
-		return -EINVAL;
-	if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
+	union uclamp_map *uc_maps = &uclamp_maps[clamp_id][0];
+	union uclamp_map uc_map_old, uc_map_new;
+	long res;
+
+retry:
+
+	uc_map_old.data = atomic_long_read(&uc_maps[group_id].adata);
+#ifdef CONFIG_SCHED_DEBUG
+#define UCLAMP_GRPERR "invalid SE clamp group [%u:%u] refcount\n"
+	if (unlikely(!uc_map_old.se_count)) {
+		pr_err_ratelimited(UCLAMP_GRPERR, clamp_id, group_id);
+		return;
+	}
+#endif
+	uc_map_new = uc_map_old;
+	uc_map_new.se_count -= 1;
+	res = atomic_long_cmpxchg(&uc_maps[group_id].adata,
+				  uc_map_old.data, uc_map_new.data);
+	if (res != uc_map_old.data)
+		goto retry;
+}
+
+/**
+ * uclamp_group_get: increase the reference count for a clamp group
+ * @uc_se: the utilization clamp data for the task
+ * @clamp_id: the clamp index affected by the task
+ * @clamp_value: the new clamp value for the task
+ *
+ * Each time a task changes its utilization clamp value, for a specified clamp
+ * index, we need to find an available clamp group which can be used to track
+ * this new clamp value. The corresponding clamp group index will be used to
+ * reference count the corresponding clamp value while the task is enqueued on
+ * a CPU.
+ */
+static void uclamp_group_get(struct uclamp_se *uc_se, unsigned int clamp_id,
+			     unsigned int clamp_value)
+{
+	union uclamp_map *uc_maps = &uclamp_maps[clamp_id][0];
+	unsigned int prev_group_id = uc_se->group_id;
+	union uclamp_map uc_map_old, uc_map_new;
+	unsigned int free_group_id;
+	unsigned int group_id;
+	unsigned long res;
+
+retry:
+
+	free_group_id = UCLAMP_GROUPS;
+	for (group_id = 0; group_id < UCLAMP_GROUPS; ++group_id) {
+		uc_map_old.data = atomic_long_read(&uc_maps[group_id].adata);
+		if (free_group_id == UCLAMP_GROUPS && !uc_map_old.se_count)
+			free_group_id = group_id;
+		if (uc_map_old.value == clamp_value)
+			break;
+	}
+	if (group_id >= UCLAMP_GROUPS) {
+#ifdef CONFIG_SCHED_DEBUG
+#define UCLAMP_MAPERR "clamp value [%u] mapping to clamp group failed\n"
+		if (unlikely(free_group_id == UCLAMP_GROUPS)) {
+			pr_err_ratelimited(UCLAMP_MAPERR, clamp_value);
+			return;
+		}
+#endif
+		group_id = free_group_id;
+		uc_map_old.data = atomic_long_read(&uc_maps[group_id].adata);
+	}
+
+	uc_map_new.se_count = uc_map_old.se_count + 1;
+	uc_map_new.value = clamp_value;
+	res = atomic_long_cmpxchg(&uc_maps[group_id].adata,
+				  uc_map_old.data, uc_map_new.data);
+	if (res != uc_map_old.data)
+		goto retry;
+
+	/* Update SE's clamp values and attach it to new clamp group */
+	uc_se->value = clamp_value;
+	uc_se->group_id = group_id;
+
+	/* Release the previous clamp group */
+	if (uc_se->mapped)
+		uclamp_group_put(clamp_id, prev_group_id);
+	uc_se->mapped = true;
+}
+
+static int __setscheduler_uclamp(struct task_struct *p,
+				 const struct sched_attr *attr)
+{
+	unsigned int lower_bound = p->uclamp[UCLAMP_MIN].value;
+	unsigned int upper_bound = p->uclamp[UCLAMP_MAX].value;
+	int result = 0;
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
+		lower_bound = attr->sched_util_min;
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
+		upper_bound = attr->sched_util_max;
+
+	if (lower_bound > upper_bound ||
+	    upper_bound > SCHED_CAPACITY_SCALE)
 		return -EINVAL;
 
-	p->uclamp[UCLAMP_MIN] = attr->sched_util_min;
-	p->uclamp[UCLAMP_MAX] = attr->sched_util_max;
+	mutex_lock(&uclamp_mutex);
 
-	return 0;
+	/* Update each required clamp group */
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+		uclamp_group_get(&p->uclamp[UCLAMP_MIN],
+				 UCLAMP_MIN, lower_bound);
+	}
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+		uclamp_group_get(&p->uclamp[UCLAMP_MAX],
+				 UCLAMP_MAX, upper_bound);
+	}
+
+	mutex_unlock(&uclamp_mutex);
+
+	return result;
+}
+
+/**
+ * uclamp_exit_task: release referenced clamp groups
+ * @p: the task exiting
+ *
+ * When a task terminates, release all its (eventually) refcounted
+ * task-specific clamp groups.
+ */
+void uclamp_exit_task(struct task_struct *p)
+{
+	unsigned int clamp_id;
+
+	if (unlikely(!p->sched_class->uclamp_enabled))
+		return;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		if (!p->uclamp[clamp_id].mapped)
+			continue;
+		uclamp_group_put(clamp_id, p->uclamp[clamp_id].group_id);
+	}
+}
+
+/**
+ * uclamp_fork: refcount task-specific clamp values for a new task
+ */
+static void uclamp_fork(struct task_struct *p, bool reset)
+{
+	unsigned int clamp_id;
+
+	if (unlikely(!p->sched_class->uclamp_enabled))
+		return;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		unsigned int clamp_value = p->uclamp[clamp_id].value;
+
+		if (unlikely(reset))
+			clamp_value = uclamp_none(clamp_id);
+
+		p->uclamp[clamp_id].mapped = false;
+		uclamp_group_get(&p->uclamp[clamp_id], clamp_id, clamp_value);
+	}
+}
+
+/**
+ * init_uclamp: initialize data structures required for utilization clamping
+ */
+static void __init init_uclamp(void)
+{
+	struct uclamp_se *uc_se;
+	unsigned int clamp_id;
+
+	mutex_init(&uclamp_mutex);
+
+	memset(uclamp_maps, 0, sizeof(uclamp_maps));
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		uc_se = &init_task.uclamp[clamp_id];
+		uclamp_group_get(uc_se, clamp_id, uclamp_none(clamp_id));
+	}
 }
+
 #else /* CONFIG_UCLAMP_TASK */
 static inline int __setscheduler_uclamp(struct task_struct *p,
 					const struct sched_attr *attr)
 {
 	return -EINVAL;
 }
+static inline void uclamp_fork(struct task_struct *p, bool reset) { }
+static inline void init_uclamp(void) { }
 #endif /* CONFIG_UCLAMP_TASK */
 
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
@@ -2314,6 +2555,7 @@ static inline void init_schedstats(void) {}
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
 	unsigned long flags;
+	bool reset;
 
 	__sched_fork(clone_flags, p);
 	/*
@@ -2331,7 +2573,8 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	/*
 	 * Revert to default priority/policy on fork if requested.
 	 */
-	if (unlikely(p->sched_reset_on_fork)) {
+	reset = p->sched_reset_on_fork;
+	if (unlikely(reset)) {
 		if (task_has_dl_policy(p) || task_has_rt_policy(p)) {
 			p->policy = SCHED_NORMAL;
 			p->static_prio = NICE_TO_PRIO(0);
@@ -2342,11 +2585,6 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = __normal_prio(p);
 		set_load_weight(p, false);
 
-#ifdef CONFIG_UCLAMP_TASK
-		p->uclamp[UCLAMP_MIN] = 0;
-		p->uclamp[UCLAMP_MAX] = SCHED_CAPACITY_SCALE;
-#endif
-
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
@@ -2363,6 +2601,8 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 	init_entity_runnable_average(&p->se);
 
+	uclamp_fork(p, reset);
+
 	/*
 	 * The child is not yet in the pid-hash so no cgroup attach races,
 	 * and the cgroup is pinned to this child due to cgroup_fork()
@@ -4610,10 +4850,15 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 	rcu_read_lock();
 	retval = -ESRCH;
 	p = find_process_by_pid(pid);
-	if (p != NULL)
-		retval = sched_setattr(p, &attr);
+	if (likely(p))
+		get_task_struct(p);
 	rcu_read_unlock();
 
+	if (likely(p)) {
+		retval = sched_setattr(p, &attr);
+		put_task_struct(p);
+	}
+
 	return retval;
 }
 
@@ -4765,8 +5010,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		attr.sched_nice = task_nice(p);
 
 #ifdef CONFIG_UCLAMP_TASK
-	attr.sched_util_min = p->uclamp[UCLAMP_MIN];
-	attr.sched_util_max = p->uclamp[UCLAMP_MAX];
+	attr.sched_util_min = p->uclamp[UCLAMP_MIN].value;
+	attr.sched_util_max = p->uclamp[UCLAMP_MAX].value;
 #endif
 
 	rcu_read_unlock();
@@ -6116,6 +6361,8 @@ void __init sched_init(void)
 
 	init_schedstats();
 
+	init_uclamp();
+
 	scheduler_running = 1;
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 908c9cdae2f0..6c92cd2d637a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10157,6 +10157,10 @@ const struct sched_class fair_sched_class = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	.task_change_group	= task_change_group_fair,
 #endif
+
+#ifdef CONFIG_UCLAMP_TASK
+	.uclamp_enabled		= 1,
+#endif
 };
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9683f458aec7..947ab14d3d5b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1504,10 +1504,12 @@ extern const u32		sched_prio_to_wmult[40];
 struct sched_class {
 	const struct sched_class *next;
 
+#ifdef CONFIG_UCLAMP_TASK
+	int uclamp_enabled;
+#endif
+
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
-	void (*yield_task)   (struct rq *rq);
-	bool (*yield_to_task)(struct rq *rq, struct task_struct *p, bool preempt);
 
 	void (*check_preempt_curr)(struct rq *rq, struct task_struct *p, int flags);
 
@@ -1540,7 +1542,6 @@ struct sched_class {
 	void (*set_curr_task)(struct rq *rq);
 	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
 	void (*task_fork)(struct task_struct *p);
-	void (*task_dead)(struct task_struct *p);
 
 	/*
 	 * The switched_from() call is allowed to drop rq->lock, therefore we
@@ -1557,12 +1558,17 @@ struct sched_class {
 
 	void (*update_curr)(struct rq *rq);
 
+	void (*yield_task)   (struct rq *rq);
+	bool (*yield_to_task)(struct rq *rq, struct task_struct *p, bool preempt);
+
 #define TASK_SET_GROUP		0
 #define TASK_MOVE_GROUP		1
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	void (*task_change_group)(struct task_struct *p, int type);
 #endif
+
+	void (*task_dead)(struct task_struct *p);
 };
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
@@ -2180,6 +2186,22 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
 static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
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
 #ifdef arch_scale_freq_capacity
 # ifndef arch_scale_freq_invariant
 #  define arch_scale_freq_invariant()	true
-- 
2.18.0

