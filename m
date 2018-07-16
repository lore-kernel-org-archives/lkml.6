Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AE4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E146C20779
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E146C20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbeGPI4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:56:18 -0400
Received: from foss.arm.com ([217.140.101.70]:54458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731687AbeGPI4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:56:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0997880D;
        Mon, 16 Jul 2018 01:30:02 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.210.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D1F93F5A0;
        Mon, 16 Jul 2018 01:29:59 -0700 (PDT)
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
Subject: [PATCH v2 10/12] sched/core: uclamp: use TG's clamps to restrict Task's clamps
Date:   Mon, 16 Jul 2018 09:29:04 +0100
Message-Id: <20180716082906.6061-11-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716082906.6061-1-patrick.bellasi@arm.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
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
task specific value and its TG value.

This also mimics what already happen for a task's CPU affinity mask when
the task is also living in a cpuset.  he overall idea is that cgroup
attributes are always used to restrict the per-task attributes.

Thus, this implementation allows to:

1. ensure cgroup clamps are always used to restrict task specific
   requests, i.e. boosted only up to a granted value or clamped at least
   to a certain value
2. implements a "nice-like" policy, where tasks are still allowed to
   request less then what enforced by their current TG

For this mecanisms to work properly, we need to implement a concept of
"effective" clamp group, which is used to track the currently most
restrictive clamp value each task is subject to.
The effective clamp is computed at enqueue time, by using an additional
   task_struct::uclamp_group_id
to keep track of the clamp group in which each task is currently
accounted into. This solution allows to update task constrains on
demand, only when they became RUNNABLE, to always get the least
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
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 include/linux/sched.h |  2 ++
 kernel/sched/core.c   | 40 +++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h  |  2 +-
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 260aa8d3fca9..5dd76a27ec17 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -676,6 +676,8 @@ struct task_struct {
 	struct sched_dl_entity		dl;
 
 #ifdef CONFIG_UCLAMP_TASK
+	/* Clamp group the task is currently accounted into */
+	int				uclamp_group_id[UCLAMP_CNT];
 	/* Utlization clamp values for this task */
 	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04e758224e22..50613d3d5b83 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -971,8 +971,15 @@ static inline void uclamp_cpu_update(struct rq *rq, int clamp_id,
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
@@ -982,18 +989,30 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
 	int clamp_value;
 	int group_id;
 
-	/* No task specific clamp values: nothing to do */
 	group_id = p->uclamp[clamp_id].group_id;
+	clamp_value = p->uclamp[clamp_id].value;
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	/* Use TG's clamp value to limit task specific values */
+	if (group_id == UCLAMP_NONE ||
+	    clamp_value >= task_group(p)->uclamp[clamp_id].value) {
+		clamp_value = task_group(p)->uclamp[clamp_id].value;
+		group_id = task_group(p)->uclamp[clamp_id].group_id;
+	}
+#else
+	/* No task specific clamp values: nothing to do */
 	if (group_id == UCLAMP_NONE)
 		return;
+#endif
 
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
 		if (clamp_id == UCLAMP_MAX)
 			uc_cpu->flags &= ~UCLAMP_FLAG_IDLE;
@@ -1031,7 +1050,7 @@ static inline void uclamp_cpu_put_id(struct task_struct *p,
 	int group_id;
 
 	/* No task specific clamp values: nothing to do */
-	group_id = p->uclamp[clamp_id].group_id;
+	group_id = p->uclamp_group_id[clamp_id];
 	if (group_id == UCLAMP_NONE)
 		return;
 
@@ -1039,6 +1058,9 @@ static inline void uclamp_cpu_put_id(struct task_struct *p,
 	uc_grp = &rq->uclamp.group[clamp_id][0];
 	uc_grp[group_id].tasks -= 1;
 
+	/* Flag the task as not affecting any clamp index */
+	p->uclamp_group_id[clamp_id] = UCLAMP_NONE;
+
 	/* If this is not the last task, no updates are required */
 	if (uc_grp[group_id].tasks > 0)
 		return;
@@ -2848,6 +2870,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 #endif
 
 #ifdef CONFIG_UCLAMP_TASK
+	memset(&p->uclamp_group_id, UCLAMP_NONE, sizeof(p->uclamp_group_id));
 	p->uclamp[UCLAMP_MIN].value = 0;
 	p->uclamp[UCLAMP_MIN].group_id = UCLAMP_NONE;
 	p->uclamp[UCLAMP_MAX].value = SCHED_CAPACITY_SCALE;
@@ -5437,6 +5460,13 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 #ifdef CONFIG_UCLAMP_TASK
 	attr.sched_util_min = p->uclamp[UCLAMP_MIN].value;
 	attr.sched_util_max = p->uclamp[UCLAMP_MAX].value;
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	/*  Use cgroup enforced clamps to restrict task specific clamps */
+	if (task_group(p)->uclamp[UCLAMP_MIN].value < attr.sched_util_min)
+		attr.sched_util_min = task_group(p)->uclamp[UCLAMP_MIN].value;
+	if (task_group(p)->uclamp[UCLAMP_MAX].value < attr.sched_util_max)
+		attr.sched_util_max = task_group(p)->uclamp[UCLAMP_MAX].value;
+#endif
 #endif
 
 	rcu_read_unlock();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1471a23e8f57..e3d5a2bc2f6c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2220,7 +2220,7 @@ static inline bool uclamp_group_active(struct uclamp_group *uc_grp,
  */
 static inline bool uclamp_task_affects(struct task_struct *p, int clamp_id)
 {
-	return (p->uclamp[clamp_id].group_id != UCLAMP_NONE);
+	return (p->uclamp_group_id[clamp_id] != UCLAMP_NONE);
 }
 
 /**
-- 
2.17.1

