Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19FBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520E22087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520E22087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeH1Rrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:47:32 -0400
Received: from foss.arm.com ([217.140.101.70]:38668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbeH1Rq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:46:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 931E91993;
        Tue, 28 Aug 2018 06:54:30 -0700 (PDT)
Received: from e110439-lin.Cambridge.arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A1DC93F5BD;
        Tue, 28 Aug 2018 06:54:27 -0700 (PDT)
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
Subject: [PATCH v4 10/16] sched/core: uclamp: use TG's clamps to restrict Task's clamps
Date:   Tue, 28 Aug 2018 14:53:18 +0100
Message-Id: <20180828135324.21976-11-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828135324.21976-1-patrick.bellasi@arm.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
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

For this mechanisms to work properly, we exploit the concept of
"effective" clamp, which is already used by a TG to track parent
enforced restrictions.
In this patch we re-use the same variable:
   task_struct::uclamp::effective::group_id
to track the currently most restrictive clamp group each task is
subject to and thus it's also currently refcounted into.

This solution allows also to better decouple the slow-path, where task
and task group clamp values are updated, from the fast-path, where the
most appropriate clamp value is tracked by refcounting clamp groups.

For consistency purposes, as well as to properly inform userspace, the
sched_getattr(2) call is updated to always return the properly
aggregated constrains as described above. This will also make
sched_getattr(2) a convenient userspace API to know the utilization
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
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v4:
 Message-ID: <20180816140731.GD2960@e110439-lin>
 - reuse already existing:
     task_struct::uclamp::effective::group_id
   instead of adding:
     task_struct::uclamp_group_id
   to back annotate the effective clamp group in which a task has been
   refcounted
 Others:
 - small documentation fixes
 - rebased on v4.19-rc1

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
 kernel/sched/core.c  | 86 ++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h |  2 +-
 2 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e617a7b18f2d..da0b3bd41e96 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -950,14 +950,75 @@ static inline void uclamp_cpu_update(struct rq *rq, int clamp_id,
 	rq->uclamp.value[clamp_id] = max_value;
 }
 
+/**
+ * uclamp_task_group_id: get the effective clamp group index of a task
+ *
+ * The effective clamp group index of a task depends on its status, RUNNABLE
+ * or SLEEPING, and on:
+ * - the task specific clamp value, when !UCLAMP_NOT_VALID
+ * - its task group effective clamp value, for tasks not in the root group
+ * - the system default clamp value, for tasks in the root group
+ *
+ * This method returns the effective group index for a task, depending on its
+ * status and a proper aggregation of the clamp values listed above.
+ */
+static inline int uclamp_task_group_id(struct task_struct *p, int clamp_id)
+{
+	struct uclamp_se *uc_se;
+	int clamp_value;
+	int group_id;
+
+	/* Taks currently accounted into a clamp group */
+	if (uclamp_task_affects(p, clamp_id))
+		return p->uclamp[clamp_id].effective.group_id;
+
+	/* Task specific clamp value */
+	uc_se = &p->uclamp[clamp_id];
+	clamp_value = uc_se->value;
+	group_id = uc_se->group_id;
+
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	/* Use TG's clamp value to limit task specific values */
+	uc_se = &task_group(p)->uclamp[clamp_id];
+	if (clamp_value > uc_se->effective.value)
+		group_id = uc_se->effective.group_id;
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
+ * storing its index (group_id) into task_struct::uclamp::effective::group_id.
+ * This group index will then be used at task's dequeue time to release the
+ * correct refcount.
  */
 static inline void uclamp_cpu_get_id(struct task_struct *p,
 				     struct rq *rq, int clamp_id)
@@ -968,7 +1029,7 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
 	int group_id;
 
 	/* Every task must reference a clamp group */
-	group_id = p->uclamp[clamp_id].group_id;
+	group_id = uclamp_task_group_id(p, clamp_id);
 #ifdef CONFIG_SCHED_DEBUG
 	if (unlikely(group_id == UCLAMP_NOT_VALID)) {
 		WARN(1, "invalid task [%d:%s] clamp group\n",
@@ -977,6 +1038,9 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
 	}
 #endif
 
+	/* Track the effective clamp group */
+	p->uclamp[clamp_id].effective.group_id = group_id;
+
 	/* Reference count the task into its current group_id */
 	uc_grp = &rq->uclamp.group[clamp_id][0];
 	uc_grp[group_id].tasks += 1;
@@ -1025,7 +1089,7 @@ static inline void uclamp_cpu_put_id(struct task_struct *p,
 	int group_id;
 
 	/* New tasks don't have a previous clamp group */
-	group_id = p->uclamp[clamp_id].group_id;
+	group_id = p->uclamp[clamp_id].effective.group_id;
 	if (group_id == UCLAMP_NOT_VALID)
 		return;
 
@@ -1040,6 +1104,9 @@ static inline void uclamp_cpu_put_id(struct task_struct *p,
 	}
 #endif
 
+	/* Flag the task as not affecting any clamp index */
+	p->uclamp[clamp_id].effective.group_id = UCLAMP_NOT_VALID;
+
 	/* If this is not the last task, no updates are required */
 	if (uc_grp[group_id].tasks > 0)
 		return;
@@ -1402,6 +1469,8 @@ static void uclamp_fork(struct task_struct *p, bool reset)
 			next_group_id = 0;
 			p->uclamp[clamp_id].value = uclamp_none(clamp_id);
 		}
+		/* Forked tasks are not yet enqueued */
+		p->uclamp[clamp_id].effective.group_id = UCLAMP_NOT_VALID;
 
 		p->uclamp[clamp_id].group_id = UCLAMP_NOT_VALID;
 		uclamp_group_get(NULL, clamp_id, next_group_id, uc_se,
@@ -5497,8 +5566,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		attr.sched_nice = task_nice(p);
 
 #ifdef CONFIG_UCLAMP_TASK
-	attr.sched_util_min = p->uclamp[UCLAMP_MIN].value;
-	attr.sched_util_max = p->uclamp[UCLAMP_MAX].value;
+	attr.sched_util_min = uclamp_task_value(p, UCLAMP_MIN);
+	attr.sched_util_max = uclamp_task_value(p, UCLAMP_MAX);
 #endif
 
 	rcu_read_unlock();
@@ -7308,8 +7377,11 @@ static void cpu_util_update_hier(struct cgroup_subsys_state *css,
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
index 489d7403affe..72b022b9a407 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2240,7 +2240,7 @@ static inline bool uclamp_group_active(struct uclamp_group *uc_grp,
  */
 static inline bool uclamp_task_affects(struct task_struct *p, int clamp_id)
 {
-	return (p->uclamp[clamp_id].group_id != UCLAMP_NOT_VALID);
+	return (p->uclamp[clamp_id].effective.group_id != UCLAMP_NOT_VALID);
 }
 #endif /* CONFIG_UCLAMP_TASK */
 
-- 
2.18.0

