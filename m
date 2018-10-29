Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA170C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864C12080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864C12080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbeJ3DYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:24:15 -0400
Received: from foss.arm.com ([217.140.101.70]:44778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbeJ3DYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:24:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB4131684;
        Mon, 29 Oct 2018 11:34:23 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA3CD3F6A8;
        Mon, 29 Oct 2018 11:34:20 -0700 (PDT)
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
Subject: [PATCH v5 15/15] sched/core: uclamp: update CPU's refcount on TG's clamp changes
Date:   Mon, 29 Oct 2018 18:33:11 +0000
Message-Id: <20181029183311.29175-18-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181029183311.29175-1-patrick.bellasi@arm.com>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task group refcounts a new clamp group, we need to ensure that
the new clamp values are immediately enforced to all its tasks which are
currently RUNNABLE. This is to ensure that all currently RUNNABLE tasks
are boosted and/or clamped as requested as soon as possible.

Let's ensure that, whenever a new clamp group is refcounted by a task
group, all its RUNNABLE tasks are correctly accounted in their
respective CPUs. We do that by slightly refactoring uclamp_group_get()
to get an additional parameter *cgroup_subsys_state which, when
provided, it's used to walk the list of tasks in the corresponding TGs
and update the RUNNABLE ones.

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
Changes in v5:
 Others:
 - rebased in v4.19

Changes in v4:
 Others:
 - rebased on v4.19-rc1
Changes in v3:
 - rebased on tip/sched/core
 - fixed some typos
Changes in v2:
 - rebased on v4.18-rc4
 - this code has been split from a previous patch to simplify the review
---
 kernel/sched/core.c     | 65 ++++++++++++++++++++++++++++++++---------
 kernel/sched/features.h |  5 ++++
 2 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f2e35b0a1f0c..06f0c98a1b32 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1197,9 +1197,30 @@ static void uclamp_group_put(unsigned int clamp_id, unsigned int group_id)
 		goto retry;
 }
 
+static inline void uclamp_group_get_tg(struct cgroup_subsys_state *css,
+				       int clamp_id, unsigned int group_id)
+{
+	struct css_task_iter it;
+	struct task_struct *p;
+
+	/*
+	 * In lazy update mode, tasks will be accounted into the right clamp
+	 * group the next time they will be requeued.
+	 */
+	if (unlikely(sched_feat(UCLAMP_LAZY_UPDATE)))
+		return;
+
+	/* Update clamp groups for RUNNABLE tasks in this TG */
+	css_task_iter_start(css, 0, &it);
+	while ((p = css_task_iter_next(&it)))
+		uclamp_task_update_active(p, clamp_id);
+	css_task_iter_end(&it);
+}
+
 /**
  * uclamp_group_get: increase the reference count for a clamp group
  * @p: the task which clamp value must be tracked
+ * @css: the task group which clamp value must be tracked
  * @uc_se: the utilization clamp data for the task
  * @clamp_id: the clamp index affected by the task
  * @clamp_value: the new clamp value for the task
@@ -1210,7 +1231,9 @@ static void uclamp_group_put(unsigned int clamp_id, unsigned int group_id)
  * reference count the corresponding clamp value while the task is enqueued on
  * a CPU.
  */
-static void uclamp_group_get(struct task_struct *p, struct uclamp_se *uc_se,
+static void uclamp_group_get(struct task_struct *p,
+			     struct cgroup_subsys_state *css,
+			     struct uclamp_se *uc_se,
 			     unsigned int clamp_id, unsigned int clamp_value)
 {
 	union uclamp_map *uc_maps = &uclamp_maps[clamp_id][0];
@@ -1279,6 +1302,10 @@ static void uclamp_group_get(struct task_struct *p, struct uclamp_se *uc_se,
 	uc_se->value = clamp_value;
 	uc_se->group_id = group_id;
 
+	/* Newly created TG don't have tasks assigned */
+	if (css)
+		uclamp_group_get_tg(css, clamp_id, group_id);
+
 	/* Update CPU's clamp group refcounts of RUNNABLE task */
 	if (p)
 		uclamp_task_update_active(p, clamp_id);
@@ -1314,11 +1341,11 @@ int sched_uclamp_handler(struct ctl_table *table, int write,
 	}
 
 	if (old_min != sysctl_sched_uclamp_util_min) {
-		uclamp_group_get(NULL, &uclamp_default[UCLAMP_MIN],
+		uclamp_group_get(NULL, NULL, &uclamp_default[UCLAMP_MIN],
 				 UCLAMP_MIN, sysctl_sched_uclamp_util_min);
 	}
 	if (old_max != sysctl_sched_uclamp_util_max) {
-		uclamp_group_get(NULL, &uclamp_default[UCLAMP_MAX],
+		uclamp_group_get(NULL, NULL, &uclamp_default[UCLAMP_MAX],
 				 UCLAMP_MAX, sysctl_sched_uclamp_util_max);
 	}
 	goto done;
@@ -1355,12 +1382,12 @@ static int __setscheduler_uclamp(struct task_struct *p,
 	/* Update each required clamp group */
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		p->uclamp[UCLAMP_MIN].user_defined = true;
-		uclamp_group_get(p, &p->uclamp[UCLAMP_MIN],
+		uclamp_group_get(p, NULL, &p->uclamp[UCLAMP_MIN],
 				 UCLAMP_MIN, lower_bound);
 	}
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
 		p->uclamp[UCLAMP_MAX].user_defined = true;
-		uclamp_group_get(p, &p->uclamp[UCLAMP_MAX],
+		uclamp_group_get(p, NULL, &p->uclamp[UCLAMP_MAX],
 				 UCLAMP_MAX, upper_bound);
 	}
 
@@ -1410,7 +1437,7 @@ static void uclamp_fork(struct task_struct *p, bool reset)
 
 		p->uclamp[clamp_id].mapped = false;
 		p->uclamp[clamp_id].active = false;
-		uclamp_group_get(NULL, &p->uclamp[clamp_id],
+		uclamp_group_get(NULL, NULL, &p->uclamp[clamp_id],
 				 clamp_id, clamp_value);
 	}
 }
@@ -1432,19 +1459,23 @@ static void __init init_uclamp(void)
 	memset(uclamp_maps, 0, sizeof(uclamp_maps));
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
 		uc_se = &init_task.uclamp[clamp_id];
-		uclamp_group_get(NULL, uc_se, clamp_id, uclamp_none(clamp_id));
+		uclamp_group_get(NULL, NULL, uc_se, clamp_id,
+				 uclamp_none(clamp_id));
 
 		uc_se = &uclamp_default[clamp_id];
-		uclamp_group_get(NULL, uc_se, clamp_id, uclamp_none(clamp_id));
+		uclamp_group_get(NULL, NULL, uc_se, clamp_id,
+				 uclamp_none(clamp_id));
 
 		/* RT tasks by default will go to max frequency */
 		uc_se = &uclamp_default_perf[clamp_id];
-		uclamp_group_get(NULL, uc_se, clamp_id, uclamp_none(UCLAMP_MAX));
+		uclamp_group_get(NULL, NULL, uc_se, clamp_id,
+				 uclamp_none(UCLAMP_MAX));
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 		/* Init root TG's clamp group */
 		uc_se = &root_task_group.uclamp[clamp_id];
-		uclamp_group_get(NULL, uc_se, clamp_id, uclamp_none(UCLAMP_MAX));
+		uclamp_group_get(NULL, NULL, uc_se, clamp_id,
+				 uclamp_none(UCLAMP_MAX));
 		uc_se->effective.group_id = uc_se->group_id;
 		uc_se->effective.value = uc_se->value;
 #endif
@@ -7053,8 +7084,8 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
 	int clamp_id;
 
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
-		uclamp_group_get(NULL, &tg->uclamp[clamp_id], clamp_id,
-				 parent->uclamp[clamp_id].value);
+		uclamp_group_get(NULL, NULL, &tg->uclamp[clamp_id],
+				 clamp_id, parent->uclamp[clamp_id].value);
 		tg->uclamp[clamp_id].effective.value =
 			parent->uclamp[clamp_id].effective.value;
 		tg->uclamp[clamp_id].effective.group_id =
@@ -7390,6 +7421,10 @@ static void cpu_util_update_hier(struct cgroup_subsys_state *css,
 
 		uc_se->effective.value = value;
 		uc_se->effective.group_id = group_id;
+
+		/* Immediately updated descendants active tasks */
+		if (css != top_css)
+			uclamp_group_get_tg(css, clamp_id, group_id);
 	}
 }
 
@@ -7414,7 +7449,8 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 	}
 
 	/* Update TG's reference count */
-	uclamp_group_get(NULL, &tg->uclamp[UCLAMP_MIN], UCLAMP_MIN, min_value);
+	uclamp_group_get(NULL, css, &tg->uclamp[UCLAMP_MIN],
+			 UCLAMP_MIN, min_value);
 
 	/* Update effective clamps to track the most restrictive value */
 	cpu_util_update_hier(css, UCLAMP_MIN, tg->uclamp[UCLAMP_MIN].group_id,
@@ -7448,7 +7484,8 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 	}
 
 	/* Update TG's reference count */
-	uclamp_group_get(NULL, &tg->uclamp[UCLAMP_MAX], UCLAMP_MAX, max_value);
+	uclamp_group_get(NULL, css, &tg->uclamp[UCLAMP_MAX],
+			 UCLAMP_MAX, max_value);
 
 	/* Update effective clamps to track the most restrictive value */
 	cpu_util_update_hier(css, UCLAMP_MAX, tg->uclamp[UCLAMP_MAX].group_id,
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 85ae8488039c..aad826aa55f8 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -90,3 +90,8 @@ SCHED_FEAT(WA_BIAS, true)
  * UtilEstimation. Use estimated CPU utilization.
  */
 SCHED_FEAT(UTIL_EST, true)
+
+/*
+ * Utilization clamping lazy update.
+ */
+SCHED_FEAT(UCLAMP_LAZY_UPDATE, false)
-- 
2.18.0

