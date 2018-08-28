Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1FBC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D032084C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D032084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeH1RyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:54:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38750 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbeH1RyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:54:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57D8118A;
        Tue, 28 Aug 2018 06:54:06 -0700 (PDT)
Received: from e110439-lin.Cambridge.arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 66B783F5BD;
        Tue, 28 Aug 2018 06:54:03 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v4 03/16] sched/core: uclamp: add CPU's clamp groups accounting
Date:   Tue, 28 Aug 2018 14:53:11 +0100
Message-Id: <20180828135324.21976-4-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828135324.21976-1-patrick.bellasi@arm.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
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
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v4:
 Message-ID: <20180816133249.GA2964@e110439-lin>
 - keep the WARN in uclamp_cpu_put_id() but beautify a bit that code
 - add another WARN on the unexpected condition of releasing a refcount
   from a CPU which has a lower clamp value active
 Other:
 - ensure (and check) that all tasks have a valid group_id at
   uclamp_cpu_get_id()
 - rework uclamp_cpu layout to better fit into just 2x64B cache lines
 - fix some s/SCHED_DEBUG/CONFIG_SCHED_DEBUG/
 - rebased on v4.19-rc1

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
 kernel/sched/core.c  | 207 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  67 ++++++++++++++
 2 files changed, 273 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2668990b96d1..8f908035701f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -829,9 +829,19 @@ static inline void uclamp_group_init(int clamp_id, int group_id,
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
@@ -886,6 +896,190 @@ uclamp_group_find(int clamp_id, unsigned int clamp_value)
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
+	/* Every task must reference a clamp group */
+	group_id = p->uclamp[clamp_id].group_id;
+#ifdef CONFIG_SCHED_DEBUG
+	if (unlikely(group_id == UCLAMP_NOT_VALID)) {
+		WARN(1, "invalid task [%d:%s] clamp group\n",
+		     p->pid, p->comm);
+		return;
+	}
+#endif
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
+	/* New tasks don't have a previous clamp group */
+	group_id = p->uclamp[clamp_id].group_id;
+	if (group_id == UCLAMP_NOT_VALID)
+		return;
+
+	/* Decrement the task's reference counted group index */
+	uc_grp = &rq->uclamp.group[clamp_id][0];
+	if (likely(uc_grp[group_id].tasks))
+		uc_grp[group_id].tasks -= 1;
+#ifdef CONFIG_SCHED_DEBUG
+	else {
+		WARN(1, "invalid CPU[%d] clamp group [%d:%d] refcount\n",
+		     cpu_of(rq), clamp_id, group_id);
+	}
+#endif
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
+#ifdef CONFIG_SCHED_DEBUG
+	if (unlikely(clamp_value > uc_cpu->value[clamp_id])) {
+		WARN(1, "invalid CPU[%d] clamp group [%d:%d] value\n",
+		     cpu_of(rq), clamp_id, group_id);
+	}
+#endif
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
@@ -908,7 +1102,7 @@ static inline void uclamp_group_put(int clamp_id, int group_id)
 	raw_spin_lock_irqsave(&uc_map[group_id].se_lock, flags);
 	if (likely(uc_map[group_id].se_count))
 		uc_map[group_id].se_count -= 1;
-#ifdef SCHED_DEBUG
+#ifdef CONFIG_SCHED_DEBUG
 	else {
 		WARN(1, "invalid SE clamp group [%d:%d] refcount\n",
 		     clamp_id, group_id);
@@ -1073,9 +1267,16 @@ static void __init init_uclamp(void)
 {
 	struct uclamp_se *uc_se;
 	int clamp_id;
+	int cpu;
 
 	mutex_init(&uclamp_mutex);
 
+	for_each_possible_cpu(cpu) {
+		struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp;
+
+		memset(uc_cpu, UCLAMP_NOT_VALID, sizeof(struct uclamp_cpu));
+	}
+
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
 		struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
 		int group_id = 0;
@@ -1093,6 +1294,8 @@ static void __init init_uclamp(void)
 }
 
 #else /* CONFIG_UCLAMP_TASK */
+static inline void uclamp_cpu_get(struct rq *rq, struct task_struct *p) { }
+static inline void uclamp_cpu_put(struct rq *rq, struct task_struct *p) { }
 static inline int __setscheduler_uclamp(struct task_struct *p,
 					const struct sched_attr *attr)
 {
@@ -1110,6 +1313,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & ENQUEUE_RESTORE))
 		sched_info_queued(rq, p);
 
+	uclamp_cpu_get(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
 }
 
@@ -1121,6 +1325,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & DEQUEUE_SAVE))
 		sched_info_dequeued(rq, p);
 
+	uclamp_cpu_put(rq, p);
 	p->sched_class->dequeue_task(rq, p, flags);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 72df2dc779bc..513608ae4908 100644
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
+	struct uclamp_group group[UCLAMP_CNT][CONFIG_UCLAMP_GROUPS_COUNT + 1];
+	int value[UCLAMP_CNT];
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
@@ -2145,6 +2194,24 @@ static inline u64 irq_time_read(int cpu)
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

