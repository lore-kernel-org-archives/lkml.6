Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958B0C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DDD2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DDD2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbeJ3DXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:23:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44570 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728488AbeJ3DXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:23:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10E32341;
        Mon, 29 Oct 2018 11:33:42 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1FC033F6A8;
        Mon, 29 Oct 2018 11:33:38 -0700 (PDT)
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
Subject: [PATCH v5 04/15] sched/core: uclamp: add CPU's clamp groups accounting
Date:   Mon, 29 Oct 2018 18:32:58 +0000
Message-Id: <20181029183311.29175-5-patrick.bellasi@arm.com>
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

Utilization clamping allows to clamp the utilization of a CPU within a
[util_min, util_max] range which depends on the set of currently
RUNNABLE tasks on that CPU.
Each task references two "clamp groups" defining the minimum and maximum
utilization clamp values to be considered for that task. These clamp
value are mapped by a clamp group which is enforced on a CPU only when
there is at least one RUNNABLE task referencing that clamp group.

When tasks are enqueued/dequeued on/from a CPU, the set of clamp groups
active on that CPU can change. Since each clamp group enforces a
different utilization clamp value, once the set of these groups changes
it's required to re-compute what is the new "aggregated" clamp value to
apply on that CPU.

Clamp values are always MAX aggregated for both util_min and util_max.
This is to ensure that no tasks can affect the performance of other
co-scheduled tasks which are either more boosted (i.e. with higher
util_min clamp) or less capped (i.e. with higher util_max clamp).

Here we introduce the required support to properly reference count clamp
groups at each task enqueue/dequeue time.

Tasks have a:
   task_struct::uclamp::group_id[clamp_idx]
indexing, for each clamp index (i.e. util_{min,max}), the clamp group
they have to refcount at enqueue time.

CPUs rq have a:
   rq::uclamp::group[clamp_idx][group_idx].tasks
which is used to reference count how many tasks are currently RUNNABLE on
that CPU for each clamp group of each clamp index.

The clamp value of each clamp group is tracked by
   rq::uclamp::group[][].value
thus making rq::uclamp::group[][] an unordered array of clamp values.
However, the MAX aggregation of the currently active clamp groups is
implemented to minimize the number of times we need to scan the complete
(unordered) clamp group array to figure out the new max value. This
operation indeed happens only when we dequeue the last task of the clamp
group corresponding to the current max clamp, and thus the CPU is either
entering IDLE or going to schedule a less boosted or more clamped task.
Moreover, the expected number of different clamp values, which can be
configured at build time, is usually so small that a more advanced
ordering algorithm is not needed. In real use-cases we expect less then
10 different clamp values for each clamp index.

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
Changes in v5:
 Message-ID: <20180914134128.GP1413@e110439-lin>
 - remove not required check for (group_id == UCLAMP_NOT_VALID)
   in uclamp_cpu_put_id
 Message-ID: <20180912174456.GJ1413@e110439-lin>
 - use bitfields to compress uclamp_group
 Others:
 - consistently use "unsigned int" for both clamp_id and group_id
 - fixup documentation
 - reduced usage of inline comments
 - rebased on v4.19.0

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
 include/linux/sched.h |   5 ++
 kernel/sched/core.c   | 185 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  |  49 +++++++++++
 3 files changed, 239 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index facace271ea1..3ab1cbd4e3b1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -604,11 +604,16 @@ struct sched_dl_entity {
  * The mapped bit is set whenever a task has been mapped on a clamp group for
  * the first time. When this bit is set, any clamp group get (for a new clamp
  * value) will be matches by a clamp group put (for the old clamp value).
+ *
+ * The active bit is set whenever a task has got an effective clamp group
+ * and value assigned, which can be different from the user requested ones.
+ * This allows to know a task is actually refcounting a CPU's clamp group.
  */
 struct uclamp_se {
 	unsigned int value		: SCHED_CAPACITY_SHIFT + 1;
 	unsigned int group_id		: order_base_2(UCLAMP_GROUPS);
 	unsigned int mapped		: 1;
+	unsigned int active		: 1;
 };
 #endif /* CONFIG_UCLAMP_TASK */
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 654327d7f212..a98a96a7d9f1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -783,6 +783,159 @@ union uclamp_map {
  */
 static union uclamp_map uclamp_maps[UCLAMP_CNT][UCLAMP_GROUPS];
 
+/**
+ * uclamp_cpu_update: updates the utilization clamp of a CPU
+ * @rq: the CPU's rq which utilization clamp has to be updated
+ * @clamp_id: the clamp index to update
+ *
+ * When tasks are enqueued/dequeued on/from a CPU, the set of currently active
+ * clamp groups can change. Since each clamp group enforces a different
+ * utilization clamp value, once the set of active groups changes it can be
+ * required to re-compute what is the new clamp value to apply for that CPU.
+ *
+ * For the specified clamp index, this method computes the new CPU utilization
+ * clamp to use until the next change on the set of active clamp groups.
+ */
+static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id)
+{
+	unsigned int group_id;
+	int max_value = 0;
+
+	for (group_id = 0; group_id < UCLAMP_GROUPS; ++group_id) {
+		if (!rq->uclamp.group[clamp_id][group_id].tasks)
+			continue;
+		/* Both min and max clamps are MAX aggregated */
+		if (max_value < rq->uclamp.group[clamp_id][group_id].value)
+			max_value = rq->uclamp.group[clamp_id][group_id].value;
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
+ * @clamp_id: the clamp index to update
+ *
+ * Once a task is enqueued on a CPU's rq, the clamp group currently defined by
+ * the task's uclamp::group_id is reference counted on that CPU.
+ */
+static inline void uclamp_cpu_get_id(struct task_struct *p, struct rq *rq,
+				     unsigned int clamp_id)
+{
+	unsigned int group_id;
+
+	if (unlikely(!p->uclamp[clamp_id].mapped))
+		return;
+
+	group_id = p->uclamp[clamp_id].group_id;
+	p->uclamp[clamp_id].active = true;
+
+	rq->uclamp.group[clamp_id][group_id].tasks += 1;
+
+	if (rq->uclamp.value[clamp_id] < p->uclamp[clamp_id].value)
+		rq->uclamp.value[clamp_id] = p->uclamp[clamp_id].value;
+}
+
+/**
+ * uclamp_cpu_put_id(): decrease reference count for a clamp group on a CPU
+ * @p: the task being dequeued from a CPU
+ * @rq: the CPU's rq from where the clamp group has to be released
+ * @clamp_id: the clamp index to update
+ *
+ * When a task is dequeued from a CPU's rq, the CPU's clamp group reference
+ * counted by the task is released.
+ * If this was the last task reference coutning the current max clamp group,
+ * then the CPU clamping is updated to find the new max for the specified
+ * clamp index.
+ */
+static inline void uclamp_cpu_put_id(struct task_struct *p, struct rq *rq,
+				     unsigned int clamp_id)
+{
+	unsigned int clamp_value;
+	unsigned int group_id;
+
+	if (unlikely(!p->uclamp[clamp_id].mapped))
+		return;
+
+	group_id = p->uclamp[clamp_id].group_id;
+	p->uclamp[clamp_id].active = false;
+
+	if (likely(rq->uclamp.group[clamp_id][group_id].tasks))
+		rq->uclamp.group[clamp_id][group_id].tasks -= 1;
+#ifdef CONFIG_SCHED_DEBUG
+	else {
+		WARN(1, "invalid CPU[%d] clamp group [%u:%u] refcount\n",
+		     cpu_of(rq), clamp_id, group_id);
+	}
+#endif
+
+	if (likely(rq->uclamp.group[clamp_id][group_id].tasks))
+		return;
+
+	clamp_value = rq->uclamp.group[clamp_id][group_id].value;
+#ifdef CONFIG_SCHED_DEBUG
+	if (unlikely(clamp_value > rq->uclamp.value[clamp_id])) {
+		WARN(1, "invalid CPU[%d] clamp group [%u:%u] value\n",
+		     cpu_of(rq), clamp_id, group_id);
+	}
+#endif
+	if (clamp_value >= rq->uclamp.value[clamp_id])
+		uclamp_cpu_update(rq, clamp_id);
+}
+
+/**
+ * uclamp_cpu_get(): increase CPU's clamp group refcount
+ * @rq: the CPU's rq where the task is enqueued
+ * @p: the task being enqueued
+ *
+ * When a task is enqueued on a CPU's rq, all the clamp groups currently
+ * enforced on a task are reference counted on that rq. Since not all
+ * scheduling classes have utilization clamping support, their tasks will
+ * be silently ignored.
+ *
+ * This method updates the utilization clamp constraints considering the
+ * requirements for the specified task. Thus, this update must be done before
+ * calling into the scheduling classes, which will eventually update schedutil
+ * considering the new task requirements.
+ */
+static inline void uclamp_cpu_get(struct rq *rq, struct task_struct *p)
+{
+	unsigned int clamp_id;
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
+ * @rq: the CPU's rq from where the task is dequeued
+ * @p: the task being dequeued
+ *
+ * When a task is dequeued from a CPU's rq, all the clamp groups the task has
+ * reference counted at enqueue time are now released.
+ *
+ * This method updates the utilization clamp constraints considering the
+ * requirements for the specified task. Thus, this update must be done before
+ * calling into the scheduling classes, which will eventually update schedutil
+ * considering the new task requirements.
+ */
+static inline void uclamp_cpu_put(struct rq *rq, struct task_struct *p)
+{
+	unsigned int clamp_id;
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
@@ -836,6 +989,7 @@ static void uclamp_group_get(struct uclamp_se *uc_se, unsigned int clamp_id,
 	unsigned int free_group_id;
 	unsigned int group_id;
 	unsigned long res;
+	int cpu;
 
 retry:
 
@@ -866,6 +1020,28 @@ static void uclamp_group_get(struct uclamp_se *uc_se, unsigned int clamp_id,
 	if (res != uc_map_old.data)
 		goto retry;
 
+	/* Ensure each CPU tracks the correct value for this clamp group */
+	if (likely(uc_map_new.se_count > 1))
+		goto done;
+	for_each_possible_cpu(cpu) {
+		struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp;
+
+		/* Refcounting is expected to be always 0 for free groups */
+		if (unlikely(uc_cpu->group[clamp_id][group_id].tasks)) {
+			uc_cpu->group[clamp_id][group_id].tasks = 0;
+#ifdef CONFIG_SCHED_DEBUG
+			WARN(1, "invalid CPU[%d] clamp group [%u:%u] refcount\n",
+			     cpu, clamp_id, group_id);
+#endif
+		}
+
+		if (uc_cpu->group[clamp_id][group_id].value == clamp_value)
+			continue;
+		uc_cpu->group[clamp_id][group_id].value = clamp_value;
+	}
+
+done:
+
 	/* Update SE's clamp values and attach it to new clamp group */
 	uc_se->value = clamp_value;
 	uc_se->group_id = group_id;
@@ -948,6 +1124,7 @@ static void uclamp_fork(struct task_struct *p, bool reset)
 			clamp_value = uclamp_none(clamp_id);
 
 		p->uclamp[clamp_id].mapped = false;
+		p->uclamp[clamp_id].active = false;
 		uclamp_group_get(&p->uclamp[clamp_id], clamp_id, clamp_value);
 	}
 }
@@ -959,9 +1136,13 @@ static void __init init_uclamp(void)
 {
 	struct uclamp_se *uc_se;
 	unsigned int clamp_id;
+	int cpu;
 
 	mutex_init(&uclamp_mutex);
 
+	for_each_possible_cpu(cpu)
+		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_cpu));
+
 	memset(uclamp_maps, 0, sizeof(uclamp_maps));
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
 		uc_se = &init_task.uclamp[clamp_id];
@@ -970,6 +1151,8 @@ static void __init init_uclamp(void)
 }
 
 #else /* CONFIG_UCLAMP_TASK */
+static inline void uclamp_cpu_get(struct rq *rq, struct task_struct *p) { }
+static inline void uclamp_cpu_put(struct rq *rq, struct task_struct *p) { }
 static inline int __setscheduler_uclamp(struct task_struct *p,
 					const struct sched_attr *attr)
 {
@@ -987,6 +1170,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & ENQUEUE_RESTORE))
 		sched_info_queued(rq, p);
 
+	uclamp_cpu_get(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
 }
 
@@ -998,6 +1182,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & DEQUEUE_SAVE))
 		sched_info_dequeued(rq, p);
 
+	uclamp_cpu_put(rq, p);
 	p->sched_class->dequeue_task(rq, p, flags);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 947ab14d3d5b..1755c9c9f4f0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -766,6 +766,50 @@ extern void rto_push_irq_work_func(struct irq_work *work);
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
+	unsigned long value : SCHED_CAPACITY_SHIFT + 1;
+	unsigned long tasks : BITS_PER_LONG - SCHED_CAPACITY_SHIFT - 1;
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
@@ -804,6 +848,11 @@ struct rq {
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
-- 
2.18.0

