Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4FDC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1791F21A60
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1791F21A60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbeHFSuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:50:55 -0400
Received: from foss.arm.com ([217.140.101.70]:41892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387623AbeHFSuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54B5715A2;
        Mon,  6 Aug 2018 09:41:00 -0700 (PDT)
Received: from e110439-lin.Cambridge.Arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 861A93F5D0;
        Mon,  6 Aug 2018 09:40:57 -0700 (PDT)
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
Subject: [PATCH v3 10/14] sched/core: uclamp: map TG's clamp values into CPU's clamp groups
Date:   Mon,  6 Aug 2018 17:39:42 +0100
Message-Id: <20180806163946.28380-11-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806163946.28380-1-patrick.bellasi@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilization clamping requires to map each different clamp value
into one of the available clamp groups used by the scheduler's fast-path
to account for RUNNABLE tasks. Thus, each time a TG's clamp value is
updated we need to get a reference to the new value's clamp group and
release a reference to the previous one.

Let's ensure that, whenever a task group is assigned a specific
clamp_value, this is properly translated into a unique clamp group to be
used in the fast-path (i.e. at enqueue/dequeue time).
We do that by slightly refactoring uclamp_group_get() to make the
*task_struct parameter optional. This allows to re-use the code already
available to support the per-task API.

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
 Message-ID: <CAJuCfpF6=L=0LrmNnJrTNPazT4dWKqNv+thhN0dwpKCgUzs9sg@mail.gmail.com>
 - add explicit calls to uclamp_group_find(), which is now not more
   part of uclamp_group_get()
 Others:
 - rebased on tip/sched/core
Changes in v2:
 - rebased on v4.18-rc4
 - this code has been split from a previous patch to simplify the review
---
 include/linux/sched.h |   2 +
 kernel/sched/core.c   | 114 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 111 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3fac2d098084..04f3b47a31bc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -583,6 +583,8 @@ struct sched_dl_entity {
  *
  * A utilization clamp group maps a "clamp value" (value), i.e.
  * util_{min,max}, to a "clamp group index" (group_id).
+ * The same "group_id" can be used by multiple TG's to enforce the same
+ * clamp "value" for a given clamp index.
  */
 struct uclamp_se {
 	/* Utilization constraint for tasks in this group */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f692df3787bd..01229864fd93 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1205,7 +1205,8 @@ static inline void uclamp_group_get(struct task_struct *p,
 	raw_spin_unlock_irqrestore(&uc_map[next_group_id].se_lock, flags);
 
 	/* Update CPU's clamp group refcounts of RUNNABLE task */
-	uclamp_task_update_active(p, clamp_id, next_group_id);
+	if (p)
+		uclamp_task_update_active(p, clamp_id, next_group_id);
 
 	/* Release the previous clamp group */
 	uclamp_group_put(clamp_id, prev_group_id);
@@ -1262,22 +1263,60 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
 {
 	struct uclamp_se *uc_se;
 	int clamp_id;
+	int group_id;
 
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
 		uc_se = &tg->uclamp[clamp_id];
 
 		uc_se->value = parent->uclamp[clamp_id].value;
 		uc_se->group_id = UCLAMP_NOT_VALID;
+
 		uc_se->effective.value =
 			parent->uclamp[clamp_id].effective.value;
 		uc_se->effective.group_id =
 			parent->uclamp[clamp_id].effective.group_id;
+
+		/*
+		 * Find a valid group_id.
+		 * Since it's a parent clone this will never fail.
+		 */
+		group_id = uclamp_group_find(clamp_id, uc_se->value);
+#ifdef SCHED_DEBUG
+		if (unlikely(group_id == -ENOSPC)) {
+			WARN(1, "invalid clamp group [%d:%d] cloning\n",
+			     clamp_id, parent->uclamp[clamp_id].group_id);
+			return 0;
+		}
+#endif
+		uclamp_group_get(NULL, clamp_id, group_id, uc_se,
+				 parent->uclamp[clamp_id].value);
 	}
 
 	return 1;
 }
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
 #else /* CONFIG_UCLAMP_TASK_GROUP */
 static inline void init_uclamp_sched_group(void) { }
+static inline void free_uclamp_sched_group(struct task_group *tg) { }
 static inline int alloc_uclamp_sched_group(struct task_group *tg,
 					   struct task_group *parent)
 {
@@ -1389,6 +1428,7 @@ static void __init init_uclamp(void)
 #else /* CONFIG_UCLAMP_TASK */
 static inline void uclamp_cpu_get(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_cpu_put(struct rq *rq, struct task_struct *p) { }
+static inline void free_uclamp_sched_group(struct task_group *tg) { }
 static inline int alloc_uclamp_sched_group(struct task_group *tg,
 					   struct task_group *parent)
 {
@@ -6958,6 +6998,7 @@ static DEFINE_SPINLOCK(task_group_lock);
 
 static void sched_free_group(struct task_group *tg)
 {
+	free_uclamp_sched_group(tg);
 	free_fair_sched_group(tg);
 	free_rt_sched_group(tg);
 	autogroup_free(tg);
@@ -7203,8 +7244,36 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 }
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
+/**
+ * cpu_util_update_hier: propagete effective clamp down the hierarchy
+ * @css: the task group to update
+ * @clamp_id: the clamp index to update
+ * @value: the new task group clamp value
+ * @group_id: the group index mapping the new task clamp value
+ *
+ * The effective clamp for a TG is expected to track the most restrictive
+ * value between the TG's clamp value and it's parent effective clamp value.
+ * This method achieve that:
+ * 1. updating the current TG effective value
+ * 2. walking all the descendant task group that needs an update
+ *
+ * A TG's effective clamp needs to be updated when its current value is not
+ * matching the TG's clamp value. In this case indeed either:
+ * a) the parent has got a more relaxed clamp value
+ *    thus potentially we can relax the effective value for this group
+ * b) the parent has got a more strict clamp value
+ *    thus potentially we have to restrict the effective value of this group
+ *
+ * Restriction and relaxation of current TG's effective clamp values needs to
+ * be propagated down to all the descendants. When a subgroup is found which
+ * has already its effective clamp value matching its clamp value, then we can
+ * safely skip all its descendants which are granted to be already in sync.
+ *
+ * The TG's group_id is also updated to ensure it tracks the effective clamp
+ * value.
+ */
 static void cpu_util_update_hier(struct cgroup_subsys_state *css,
-				 int clamp_id, int value)
+				 int clamp_id, int value, int group_id)
 {
 	struct cgroup_subsys_state *top_css = css;
 	struct uclamp_se *uc_se, *uc_parent;
@@ -7232,20 +7301,25 @@ static void cpu_util_update_hier(struct cgroup_subsys_state *css,
 		}
 
 		/* Propagate the most restrictive effective value */
-		if (uc_parent->effective.value < value)
+		if (uc_parent->effective.value < value) {
 			value = uc_parent->effective.value;
+			group_id = uc_parent->effective.group_id;
+		}
 		if (uc_se->effective.value == value)
 			continue;
 
 		uc_se->effective.value = value;
+		uc_se->effective.group_id = group_id;
 	}
 }
 
 static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 				  struct cftype *cftype, u64 min_value)
 {
+	struct uclamp_se *uc_se;
 	struct task_group *tg;
 	int ret = -EINVAL;
+	int group_id;
 
 	if (min_value > SCHED_CAPACITY_SCALE)
 		return -ERANGE;
@@ -7261,8 +7335,22 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 	if (tg->uclamp[UCLAMP_MAX].value < min_value)
 		goto out;
 
+	/* Find a valid group_id */
+	ret = uclamp_group_find(UCLAMP_MIN, min_value);
+	if (ret == -ENOSPC) {
+		pr_err("Cannot allocate more than %d UTIL_MIN clamp groups\n",
+		       CONFIG_UCLAMP_GROUPS_COUNT);
+		goto out;
+	}
+	group_id = ret;
+	ret = 0;
+
 	/* Update effective clamps to track the most restrictive value */
-	cpu_util_update_hier(css, UCLAMP_MIN, min_value);
+	cpu_util_update_hier(css, UCLAMP_MIN, min_value, group_id);
+
+	/* Update TG's reference count */
+	uc_se = &tg->uclamp[UCLAMP_MIN];
+	uclamp_group_get(NULL, UCLAMP_MIN, group_id, uc_se, min_value);
 
 out:
 	rcu_read_unlock();
@@ -7274,8 +7362,10 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 				  struct cftype *cftype, u64 max_value)
 {
+	struct uclamp_se *uc_se;
 	struct task_group *tg;
 	int ret = -EINVAL;
+	int group_id;
 
 	if (max_value > SCHED_CAPACITY_SCALE)
 		return -ERANGE;
@@ -7291,8 +7381,22 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 	if (tg->uclamp[UCLAMP_MIN].value > max_value)
 		goto out;
 
+	/* Find a valid group_id */
+	ret = uclamp_group_find(UCLAMP_MAX, max_value);
+	if (ret == -ENOSPC) {
+		pr_err("Cannot allocate more than %d UTIL_MAX clamp groups\n",
+		       CONFIG_UCLAMP_GROUPS_COUNT);
+		goto out;
+	}
+	group_id = ret;
+	ret = 0;
+
 	/* Update effective clamps to track the most restrictive value */
-	cpu_util_update_hier(css, UCLAMP_MAX, max_value);
+	cpu_util_update_hier(css, UCLAMP_MAX, max_value, group_id);
+
+	/* Update TG's reference count */
+	uc_se = &tg->uclamp[UCLAMP_MAX];
+	uclamp_group_get(NULL, UCLAMP_MAX, group_id, uc_se, max_value);
 
 out:
 	rcu_read_unlock();
-- 
2.18.0

