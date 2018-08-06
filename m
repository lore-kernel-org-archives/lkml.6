Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCFAC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFB321A6A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFB321A6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbeHFSu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:50:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41912 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387692AbeHFSu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6226215AB;
        Mon,  6 Aug 2018 09:41:03 -0700 (PDT)
Received: from e110439-lin.Cambridge.Arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94FDA3F5D0;
        Mon,  6 Aug 2018 09:41:00 -0700 (PDT)
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
Subject: [PATCH v3 11/14] sched/core: uclamp: use TG's clamps to restrict Task's clamps
Date:   Mon,  6 Aug 2018 17:39:43 +0100
Message-Id: <20180806163946.28380-12-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806163946.28380-1-patrick.bellasi@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task's util_clamp value is configured via sched_setattr(2), this
value has to be properly accounted in the corresponding clamp group
every time the task is enqueued and dequeued. When cgroups are also in
use, per-task clamp values have to be aggregated to those of the CPU's
controller's Task Group (TG) in which the task is currently living.

Let's update uclamp_cpu_get() to provide aggregation between the task
and the TG clamp values. Every time a task is enqueued, it will be
accounted in the clamp_group which defines the smaller clamp between the
task specific value and its TG effective value.

This also mimics what already happen for a task's CPU affinity mask when
the task is also living in a cpuset. The overall idea is that cgroup
attributes are always used to restrict the per-task attributes.

Thus, this implementation allows to:

1. ensure cgroup clamps are always used to restrict task specific
   requests, i.e. boosted only up to the effective granted value or
   clamped at least to a certain value
2. implements a "nice-like" policy, where tasks are still allowed to
   request less then what enforced by their current TG

For this mecanisms to work properly, we add the concept of "active"
clamp group, which is used to track the currently most restrictive clamp
value each task is subject to.
The active clamp is computed at enqueue time, by using an additional
   task_struct::uclamp_group_id
to keep track of the clamp group in which each task is currently
accounted into. This allows to update task constrains on
demand, only when a task becames RUNNABLE, thus always using the most
restrictive clamp depending on the current TG's settings.

This solution allows also to better decouple the slow-path, where task
and task group clamp values are updated, from the fast-path, where the
most appropriate clamp value is tracked by refcounting clamp groups.

For consistency purposes, as well as to properly inform userspace, the
sched_getattr(2) call is updated to always return the properly
aggregated constrains as described above. This will also make
sched_getattr(2) a convenient userpace API to know the utilization
constraints enforced on a task by the cgroup's CPU controller.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v3:
 Message-ID: <CAJuCfpFnj2g3+ZpR4fP4yqfxs0zd=c-Zehr2XM7m_C+WdL9jNA@mail.gmail.com>
 - rename UCLAMP_NONE into UCLAMP_NOT_VALID
 - fix not required override
 - fix typos in changelog
 Others:
 - clean up uclamp_cpu_get_id()/sched_getattr() code by moving task's
   clamp group_id/value code into dedicated getter functions:
   uclamp_task_group_id(), uclamp_group_value() and uclamp_task_value()
 - rebased on tip/sched/core

Changes in v2:
 OSPM discussion:
 - implement a "nice" semantics where cgroup clamp values are always
   used to restrict task specific clamp values, i.e. tasks running on a
   TG are only allowed to demote themself.
 Other:
 - rabased on v4.18-rc4
 - this code has been split from a previous patch to simplify the review
---
 include/linux/sched.h |  2 ++
 kernel/sched/core.c   | 78 ++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h  |  2 +-
 3 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 04f3b47a31bc..753d10cd25f1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -681,6 +681,8 @@ struct task_struct {
 	struct sched_dl_entity		dl;
 
 #ifdef CONFIG_UCLAMP_TASK
+	/* Clamp group the task is currently accounted into */
+	int				uclamp_group_id[UCLAMP_CNT];
 	/* Utlization clamp values for this task */
 	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 01229864fd93..f54fd9bda9a7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -941,14 +941,65 @@ static inline void uclamp_cpu_update(struct rq *rq, int clamp_id,
 	rq->uclamp.value[clamp_id] = max_value;
 }
 
+static inline int uclamp_task_group_id(struct task_struct *p, int clamp_id)
+{
+	struct uclamp_se *uc_se;
+	int clamp_value;
+	int group_id;
+
+	/* Taks currently accounted into a clamp group */
+	if (uclamp_task_affects(p, clamp_id))
+		return p->uclamp_group_id[clamp_id];
+
+	/* Task specific clamp value */
+	uc_se = &p->uclamp[clamp_id];
+	clamp_value = uc_se->value;
+	group_id = uc_se->group_id;
+
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	/* Use TG's clamp value to limit task specific values */
+	uc_se = &task_group(p)->uclamp[clamp_id];
+	if (group_id == UCLAMP_NOT_VALID ||
+	    clamp_value > uc_se->effective.value) {
+		group_id = uc_se->effective.group_id;
+	}
+#endif
+
+	return group_id;
+}
+
+static inline int uclamp_group_value(int clamp_id, int group_id)
+{
+	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
+
+	if (group_id == UCLAMP_NOT_VALID)
+		return uclamp_none(clamp_id);
+
+	return uc_map[group_id].value;
+}
+
+static inline int uclamp_task_value(struct task_struct *p, int clamp_id)
+{
+	int group_id = uclamp_task_group_id(p, clamp_id);
+
+	return uclamp_group_value(clamp_id, group_id);
+}
+
 /**
  * uclamp_cpu_get_id(): increase reference count for a clamp group on a CPU
  * @p: the task being enqueued on a CPU
  * @rq: the CPU's rq where the clamp group has to be reference counted
  * @clamp_id: the utilization clamp (e.g. min or max utilization) to reference
  *
- * Once a task is enqueued on a CPU's RQ, the clamp group currently defined by
- * the task's uclamp.group_id is reference counted on that CPU.
+ * Once a task is enqueued on a CPU's RQ, the most restrictive clamp group,
+ * among the task specific and that of the task's cgroup one, is reference
+ * counted on that CPU.
+ *
+ * Since the CPUs reference counted clamp group can be either that of the task
+ * or of its cgroup, we keep track of the reference counted clamp group by
+ * storing its index (group_id) into the task's task_struct::uclamp_group_id.
+ * This group index will then be used at task's dequeue time to release the
+ * correct refcount.
  */
 static inline void uclamp_cpu_get_id(struct task_struct *p,
 				     struct rq *rq, int clamp_id)
@@ -959,17 +1010,20 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
 	int group_id;
 
 	/* No task specific clamp values: nothing to do */
-	group_id = p->uclamp[clamp_id].group_id;
+	group_id = uclamp_task_group_id(p, clamp_id);
 	if (group_id == UCLAMP_NOT_VALID)
 		return;
+	clamp_value = uclamp_group_value(clamp_id, group_id);
 
 	/* Reference count the task into its current group_id */
 	uc_grp = &rq->uclamp.group[clamp_id][0];
 	uc_grp[group_id].tasks += 1;
 
+	/* Track the effective clamp group */
+	p->uclamp_group_id[clamp_id] = group_id;
+
 	/* Force clamp update on idle exit */
 	uc_cpu = &rq->uclamp;
-	clamp_value = p->uclamp[clamp_id].value;
 	if (unlikely(uc_cpu->flags & UCLAMP_FLAG_IDLE)) {
 		/*
 		 * This function is called for both UCLAMP_MIN (before) and
@@ -1012,7 +1066,7 @@ static inline void uclamp_cpu_put_id(struct task_struct *p,
 	int group_id;
 
 	/* No task specific clamp values: nothing to do */
-	group_id = p->uclamp[clamp_id].group_id;
+	group_id = p->uclamp_group_id[clamp_id];
 	if (group_id == UCLAMP_NOT_VALID)
 		return;
 
@@ -1027,6 +1081,9 @@ static inline void uclamp_cpu_put_id(struct task_struct *p,
 #endif
 	uc_grp[group_id].tasks -= 1;
 
+	/* Flag the task as not affecting any clamp index */
+	p->uclamp_group_id[clamp_id] = UCLAMP_NOT_VALID;
+
 	/* If this is not the last task, no updates are required */
 	if (uc_grp[group_id].tasks > 0)
 		return;
@@ -2885,6 +2942,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 #endif
 
 #ifdef CONFIG_UCLAMP_TASK
+	memset(&p->uclamp_group_id, UCLAMP_NOT_VALID,
+	       sizeof(p->uclamp_group_id));
 	p->uclamp[UCLAMP_MIN].value = 0;
 	p->uclamp[UCLAMP_MIN].group_id = UCLAMP_NOT_VALID;
 	p->uclamp[UCLAMP_MAX].value = SCHED_CAPACITY_SCALE;
@@ -5467,8 +5526,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		attr.sched_nice = task_nice(p);
 
 #ifdef CONFIG_UCLAMP_TASK
-	attr.sched_util_min = p->uclamp[UCLAMP_MIN].value;
-	attr.sched_util_max = p->uclamp[UCLAMP_MAX].value;
+	attr.sched_util_min = uclamp_task_value(p, UCLAMP_MIN);
+	attr.sched_util_max = uclamp_task_value(p, UCLAMP_MAX);
 #endif
 
 	rcu_read_unlock();
@@ -7285,8 +7344,11 @@ static void cpu_util_update_hier(struct cgroup_subsys_state *css,
 		 * groups we consider their current value.
 		 */
 		uc_se = &css_tg(css)->uclamp[clamp_id];
-		if (css != top_css)
+		if (css != top_css) {
 			value = uc_se->value;
+			group_id = uc_se->effective.group_id;
+		}
+
 		/*
 		 * Skip the whole subtrees if the current effective clamp is
 		 * alredy matching the TG's clamp value.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a443b2c22cb7..a296b6463f1e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2229,7 +2229,7 @@ static inline bool uclamp_group_active(struct uclamp_group *uc_grp,
  */
 static inline bool uclamp_task_affects(struct task_struct *p, int clamp_id)
 {
-	return (p->uclamp[clamp_id].group_id != UCLAMP_NOT_VALID);
+	return (p->uclamp_group_id[clamp_id] != UCLAMP_NOT_VALID);
 }
 
 /**
-- 
2.18.0

