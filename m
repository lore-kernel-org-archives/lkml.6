Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0FAC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0069621A18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0069621A18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbeHFSud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:50:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41766 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbeHFSuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E12D415AD;
        Mon,  6 Aug 2018 09:40:38 -0700 (PDT)
Received: from e110439-lin.Cambridge.Arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1FE543F5D0;
        Mon,  6 Aug 2018 09:40:35 -0700 (PDT)
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
Subject: [PATCH v3 03/14] sched/core: uclamp: add CPU's clamp groups accounting
Date:   Mon,  6 Aug 2018 17:39:35 +0100
Message-Id: <20180806163946.28380-4-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806163946.28380-1-patrick.bellasi@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilization clamping allows to clamp the utilization of a CPU within a
[util_min, util_max] range. This range depends on the set of currently
RUNNABLE tasks on a CPU, where each task references two "clamp groups"
defining the util_min and the util_max clamp values to be considered for
that task. The clamp value mapped by a clamp group applies to a CPU only
when there is at least one task RUNNABLE referencing that clamp group.

When tasks are enqueued/dequeued on/from a CPU, the set of clamp groups
active on that CPU can change. Since each clamp group enforces a
different utilization clamp value, once the set of these groups changes
it can be required to re-compute what is the new "aggregated" clamp
value to apply on that CPU.

Clamp values are always MAX aggregated for both util_min and util_max.
This is to ensure that no tasks can affect the performance of other
co-scheduled tasks which are either more boosted (i.e.  with higher
util_min clamp) or less capped (i.e. with higher util_max clamp).

Here we introduce the required support to properly reference count clamp
groups at each task enqueue/dequeue time.

Tasks have a:
   task_struct::uclamp::group_id[clamp_idx]
indexing, for each clamp index (i.e. util_{min,max}), the clamp group in
which they should refcount at enqueue time.

CPUs rq have a:
   rq::uclamp::group[clamp_idx][group_idx].tasks
which is used to reference count how many tasks are currently RUNNABLE on
that CPU for each clamp group of each clamp index..

The clamp value of each clamp group is tracked by
rq::uclamp::group[][].value, thus making rq::uclamp::group[][] an
unordered array of clamp values. However, the MAX aggregation of the
currently active clamp groups is implemented to minimize the number of
times we need to scan the complete (unordered) clamp group array to
figure out the new max value. This operation indeed happens only when we
dequeue last task of the clamp group corresponding to the current max
clamp, and thus the CPU is either entering IDLE or going to schedule a
less boosted or more clamped task.
Moreover, the expected number of different clamp values, which can be
configured at build time, is usually so small that a more advanced
ordering algorithm is not needed. In real use-cases we expect less then
10 different values.

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
 - add WARN on unlikely un-referenced decrement in uclamp_cpu_put_id()
 - rename UCLAMP_NONE into UCLAMP_NOT_VALID
 Message-ID: <CAJuCfpGaKvxKcO=RLcmveHRB9qbMrvFs2yFVrk=k-v_m7JkxwQ@mail.gmail.com>
 - few typos fixed
 Other:
 - rebased on tip/sched/core

Changes in v2:

 Message-ID: <20180413093822.GM4129@hirez.programming.kicks-ass.net>
 - refactored struct rq::uclamp_cpu to be more cache efficient
   no more holes, re-arranged vectors to match cache lines with expected
   data locality

 Message-ID: <20180413094615.GT4043@hirez.programming.kicks-ass.net>
 - use *rq as parameter whenever already available
 - add scheduling class's uclamp_enabled marker
 - get rid of the "confusing" single callback uclamp_task_update()
   and use uclamp_cpu_{get,put}() directly from {en,de}queue_task()
 - fix/remove "bad" comments

 Message-ID: <20180413113337.GU14248@e110439-lin>
 - remove inline from init_uclamp, flag it __init

 Other:
 - rabased on v4.18-rc4
 - improved documentation to make more explicit some concepts.
---
 kernel/sched/core.c  | 195 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c  |   4 +
 kernel/sched/rt.c    |   4 +
 kernel/sched/sched.h |  71 ++++++++++++++++
 4 files changed, 274 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4caa2686644b..f058ceb14d25 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -825,9 +825,19 @@ static inline void uclamp_group_init(int clamp_id, int group_id,
 				     unsigned int clamp_value)
 {
 	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+	struct uclamp_cpu *uc_cpu;
+	int cpu;
 
+	/* Set clamp group map */
 	uc_map[group_id].value = clamp_value;
 	uc_map[group_id].se_count = 0;
+
+	/* Set clamp groups on all CPUs */
+	for_each_possible_cpu(cpu) {
+		uc_cpu = &cpu_rq(cpu)->uclamp;
+		uc_cpu->group[clamp_id][group_id].value = clamp_value;
+		uc_cpu->group[clamp_id][group_id].tasks = 0;
+	}
 }
 
 /**
@@ -882,6 +892,179 @@ uclamp_group_find(int clamp_id, unsigned int clamp_value)
 	return -ENOSPC;
 }
 
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
+ * clamp to use until the next change on the set of RUNNABLE tasks on that CPU.
+ */
+static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
+{
+	struct uclamp_group *uc_grp = &rq->uclamp.group[clamp_id][0];
+	int max_value = UCLAMP_NOT_VALID;
+	unsigned int group_id;
+
+	for (group_id = 0; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
+		/* Ignore inactive clamp groups, i.e. no RUNNABLE tasks */
+		if (!uclamp_group_active(uc_grp, group_id))
+			continue;
+
+		/* Both min and max clamp are MAX aggregated */
+		max_value = max(max_value, uc_grp[group_id].value);
+
+		/* Stop if we reach the max possible clamp */
+		if (max_value >= SCHED_CAPACITY_SCALE)
+			break;
+	}
+	rq->uclamp.value[clamp_id] = max_value;
+}
+
+/**
+ * uclamp_cpu_get_id(): increase reference count for a clamp group on a CPU
+ * @p: the task being enqueued on a CPU
+ * @rq: the CPU's rq where the clamp group has to be reference counted
+ * @clamp_id: the utilization clamp (e.g. min or max utilization) to reference
+ *
+ * Once a task is enqueued on a CPU's RQ, the clamp group currently defined by
+ * the task's uclamp.group_id is reference counted on that CPU.
+ */
+static inline void uclamp_cpu_get_id(struct task_struct *p,
+				     struct rq *rq, int clamp_id)
+{
+	struct uclamp_group *uc_grp;
+	struct uclamp_cpu *uc_cpu;
+	int clamp_value;
+	int group_id;
+
+	/* No task specific clamp values: nothing to do */
+	group_id = p->uclamp[clamp_id].group_id;
+	if (group_id == UCLAMP_NOT_VALID)
+		return;
+
+	/* Reference count the task into its current group_id */
+	uc_grp = &rq->uclamp.group[clamp_id][0];
+	uc_grp[group_id].tasks += 1;
+
+	/*
+	 * If this is the new max utilization clamp value, then we can update
+	 * straight away the CPU clamp value. Otherwise, the current CPU clamp
+	 * value is still valid and we are done.
+	 */
+	uc_cpu = &rq->uclamp;
+	clamp_value = p->uclamp[clamp_id].value;
+	if (uc_cpu->value[clamp_id] < clamp_value)
+		uc_cpu->value[clamp_id] = clamp_value;
+}
+
+/**
+ * uclamp_cpu_put_id(): decrease reference count for a clamp group on a CPU
+ * @p: the task being dequeued from a CPU
+ * @cpu: the CPU from where the clamp group has to be released
+ * @clamp_id: the utilization clamp (e.g. min or max utilization) to release
+ *
+ * When a task is dequeued from a CPU's RQ, the CPU's clamp group reference
+ * counted by the task is decreased.
+ * If this was the last task defining the current max clamp group, then the
+ * CPU clamping is updated to find the new max for the specified clamp
+ * index.
+ */
+static inline void uclamp_cpu_put_id(struct task_struct *p,
+				     struct rq *rq, int clamp_id)
+{
+	struct uclamp_group *uc_grp;
+	struct uclamp_cpu *uc_cpu;
+	unsigned int clamp_value;
+	int group_id;
+
+	/* No task specific clamp values: nothing to do */
+	group_id = p->uclamp[clamp_id].group_id;
+	if (group_id == UCLAMP_NOT_VALID)
+		return;
+
+	/* Decrement the task's reference counted group index */
+	uc_grp = &rq->uclamp.group[clamp_id][0];
+#ifdef SCHED_DEBUG
+	if (unlikely(uc_grp[group_id].tasks == 0)) {
+		WARN(1, "invalid CPU[%d] clamp group [%d:%d] refcount\n",
+		     cpu_of(rq), clamp_id, group_id);
+		uc_grp[group_id].tasks = 1;
+	}
+#endif
+	uc_grp[group_id].tasks -= 1;
+
+	/* If this is not the last task, no updates are required */
+	if (uc_grp[group_id].tasks > 0)
+		return;
+
+	/*
+	 * Update the CPU only if this was the last task of the group
+	 * defining the current clamp value.
+	 */
+	uc_cpu = &rq->uclamp;
+	clamp_value = uc_grp[group_id].value;
+	if (clamp_value >= uc_cpu->value[clamp_id])
+		uclamp_cpu_update(rq, clamp_id);
+}
+
+/**
+ * uclamp_cpu_get(): increase CPU's clamp group refcount
+ * @rq: the CPU's rq where the clamp group has to be refcounted
+ * @p: the task being enqueued
+ *
+ * Once a task is enqueued on a CPU's rq, all the clamp groups currently
+ * enforced on a task are reference counted on that rq.
+ * Not all scheduling classes have utilization clamping support, their tasks
+ * will be silently ignored.
+ *
+ * This method updates the utilization clamp constraints considering the
+ * requirements for the specified task. Thus, this update must be done before
+ * calling into the scheduling classes, which will eventually update schedutil
+ * considering the new task requirements.
+ */
+static inline void uclamp_cpu_get(struct rq *rq, struct task_struct *p)
+{
+	int clamp_id;
+
+	if (unlikely(!p->sched_class->uclamp_enabled))
+		return;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
+		uclamp_cpu_get_id(p, rq, clamp_id);
+}
+
+/**
+ * uclamp_cpu_put(): decrease CPU's clamp group refcount
+ * @cpu: the CPU's rq where the clamp group refcount has to be decreased
+ * @p: the task being dequeued
+ *
+ * When a task is dequeued from a CPU's rq, all the clamp groups the task has
+ * been reference counted at task's enqueue time have to be decreased for that
+ * CPU.
+ *
+ * This method updates the utilization clamp constraints considering the
+ * requirements for the specified task. Thus, this update must be done before
+ * calling into the scheduling classes, which will eventually update schedutil
+ * considering the new task requirements.
+ */
+static inline void uclamp_cpu_put(struct rq *rq, struct task_struct *p)
+{
+	int clamp_id;
+
+	if (unlikely(!p->sched_class->uclamp_enabled))
+		return;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id)
+		uclamp_cpu_put_id(p, rq, clamp_id);
+}
+
 /**
  * uclamp_group_put: decrease the reference count for a clamp group
  * @clamp_id: the clamp index which was affected by a task group
@@ -1026,9 +1209,17 @@ static inline int __setscheduler_uclamp(struct task_struct *p,
 static void __init init_uclamp(void)
 {
 	int clamp_id;
+	int cpu;
 
 	mutex_init(&uclamp_mutex);
 
+	/* Init CPU's clamp groups */
+	for_each_possible_cpu(cpu) {
+		struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp;
+
+		memset(uc_cpu, UCLAMP_NOT_VALID, sizeof(struct uclamp_cpu));
+	}
+
 	/* Init SE's clamp map */
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
 		struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
@@ -1042,6 +1233,8 @@ static void __init init_uclamp(void)
 }
 
 #else /* CONFIG_UCLAMP_TASK */
+static inline void uclamp_cpu_get(struct rq *rq, struct task_struct *p) { }
+static inline void uclamp_cpu_put(struct rq *rq, struct task_struct *p) { }
 static inline int __setscheduler_uclamp(struct task_struct *p,
 					const struct sched_attr *attr)
 {
@@ -1058,6 +1251,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & ENQUEUE_RESTORE))
 		sched_info_queued(rq, p);
 
+	uclamp_cpu_get(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
 }
 
@@ -1069,6 +1263,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & DEQUEUE_SAVE))
 		sched_info_dequeued(rq, p);
 
+	uclamp_cpu_put(rq, p);
 	p->sched_class->dequeue_task(rq, p, flags);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 309c93fcc604..c3d87780764c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10054,6 +10054,10 @@ const struct sched_class fair_sched_class = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	.task_change_group	= task_change_group_fair,
 #endif
+
+#ifdef CONFIG_UCLAMP_TASK
+	.uclamp_enabled		= 1,
+#endif
 };
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2e2955a8cf8f..06ec33467dd9 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2404,6 +2404,10 @@ const struct sched_class rt_sched_class = {
 	.switched_to		= switched_to_rt,
 
 	.update_curr		= update_curr_rt,
+
+#ifdef CONFIG_UCLAMP_TASK
+	.uclamp_enabled		= 1,
+#endif
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a2e8cae63c4..8f96926703fc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -764,6 +764,50 @@ extern void rto_push_irq_work_func(struct irq_work *work);
 #endif
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_UCLAMP_TASK
+/**
+ * struct uclamp_group - Utilization clamp Group
+ * @value: utilization clamp value for tasks on this clamp group
+ * @tasks: number of RUNNABLE tasks on this clamp group
+ *
+ * Keep track of how many tasks are RUNNABLE for a given utilization
+ * clamp value.
+ */
+struct uclamp_group {
+	int value;
+	int tasks;
+};
+
+/**
+ * struct uclamp_cpu - CPU's utilization clamp
+ * @value: currently active clamp values for a CPU
+ * @group: utilization clamp groups affecting a CPU
+ *
+ * Keep track of RUNNABLE tasks on a CPUs to aggregate their clamp values.
+ * A clamp value is affecting a CPU where there is at least one task RUNNABLE
+ * (or actually running) with that value.
+ *
+ * We have up to UCLAMP_CNT possible different clamp value, which are
+ * currently only two: minmum utilization and maximum utilization.
+ *
+ * All utilization clamping values are MAX aggregated, since:
+ * - for util_min: we want to run the CPU at least at the max of the minimum
+ *   utilization required by its currently RUNNABLE tasks.
+ * - for util_max: we want to allow the CPU to run up to the max of the
+ *   maximum utilization allowed by its currently RUNNABLE tasks.
+ *
+ * Since on each system we expect only a limited number of different
+ * utilization clamp values (CONFIG_UCLAMP_GROUPS_COUNT), we use a simple
+ * array to track the metrics required to compute all the per-CPU utilization
+ * clamp values. The additional slot is used to track the default clamp
+ * values, i.e. no min/max clamping at all.
+ */
+struct uclamp_cpu {
+	int value[UCLAMP_CNT];
+	struct uclamp_group group[UCLAMP_CNT][CONFIG_UCLAMP_GROUPS_COUNT + 1];
+};
+#endif /* CONFIG_UCLAMP_TASK */
+
 /*
  * This is the main, per-CPU runqueue data structure.
  *
@@ -801,6 +845,11 @@ struct rq {
 	unsigned long		nr_load_updates;
 	u64			nr_switches;
 
+#ifdef CONFIG_UCLAMP_TASK
+	/* Utilization clamp values based on CPU's RUNNABLE tasks */
+	struct uclamp_cpu	uclamp ____cacheline_aligned;
+#endif
+
 	struct cfs_rq		cfs;
 	struct rt_rq		rt;
 	struct dl_rq		dl;
@@ -1560,6 +1609,10 @@ struct sched_class {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	void (*task_change_group)(struct task_struct *p, int type);
 #endif
+
+#ifdef CONFIG_UCLAMP_TASK
+	int uclamp_enabled;
+#endif
 };
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
@@ -2139,6 +2192,24 @@ static inline u64 irq_time_read(int cpu)
 }
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
+#ifdef CONFIG_UCLAMP_TASK
+/**
+ * uclamp_group_active: check if a clamp group is active on a CPU
+ * @uc_grp: the clamp groups for a CPU
+ * @group_id: the clamp group to check
+ *
+ * A clamp group affects a CPU if it has at least one RUNNABLE task.
+ *
+ * Return: true if the specified CPU has at least one RUNNABLE task
+ *         for the specified clamp group.
+ */
+static inline bool uclamp_group_active(struct uclamp_group *uc_grp,
+				       int group_id)
+{
+	return uc_grp[group_id].tasks > 0;
+}
+#endif /* CONFIG_UCLAMP_TASK */
+
 #ifdef CONFIG_CPU_FREQ
 DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
 
-- 
2.18.0

