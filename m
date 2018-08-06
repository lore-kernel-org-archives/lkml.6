Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AB1C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1259D21A6C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1259D21A6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbeHFSvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:51:17 -0400
Received: from foss.arm.com ([217.140.101.70]:41952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387720AbeHFSvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:51:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F80380D;
        Mon,  6 Aug 2018 09:41:09 -0700 (PDT)
Received: from e110439-lin.Cambridge.Arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B27DB3F5D0;
        Mon,  6 Aug 2018 09:41:06 -0700 (PDT)
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
Subject: [PATCH v3 13/14] sched/core: uclamp: update CPU's refcount on TG's clamp changes
Date:   Mon,  6 Aug 2018 17:39:45 +0100
Message-Id: <20180806163946.28380-14-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806163946.28380-1-patrick.bellasi@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
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

This is a "brute force" solution which allows to reuse the same refcount
update code already used by the per-task API. That's also the only way
to ensure a prompt enforcement of new clamp constraints on RUNNABLE
tasks, as soon as a task group attribute is tweaked.

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
 - rebased on tip/sched/core
 - fixed some typos

Changes in v2:
 - rebased on v4.18-rc4
 - this code has been split from a previous patch to simplify the review
---
 kernel/sched/core.c     | 44 ++++++++++++++++++++++++++++++++++-------
 kernel/sched/features.h |  5 +++++
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 48458fea2d5e..6db307803047 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1255,9 +1255,30 @@ static inline void uclamp_group_put(int clamp_id, int group_id)
 	raw_spin_unlock_irqrestore(&uc_map[group_id].se_lock, flags);
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
+		uclamp_task_update_active(p, clamp_id, group_id);
+	css_task_iter_end(&it);
+}
+
 /**
  * uclamp_group_get: increase the reference count for a clamp group
  * @p: the task which clamp value must be tracked
+ * @css: the task group which clamp value must be tracked
  * @clamp_id: the clamp index affected by the task
  * @next_group_id: the clamp group to refcount
  * @uc_se: the utilization clamp data for the task
@@ -1269,6 +1290,7 @@ static inline void uclamp_group_put(int clamp_id, int group_id)
  * the task to reference count the clamp value on CPUs while enqueued.
  */
 static inline void uclamp_group_get(struct task_struct *p,
+				    struct cgroup_subsys_state *css,
 				    int clamp_id, int next_group_id,
 				    struct uclamp_se *uc_se,
 				    unsigned int clamp_value)
@@ -1288,6 +1310,10 @@ static inline void uclamp_group_get(struct task_struct *p,
 	uc_map[next_group_id].se_count += 1;
 	raw_spin_unlock_irqrestore(&uc_map[next_group_id].se_lock, flags);
 
+	/* Newly created TG don't have tasks assigned */
+	if (css)
+		uclamp_group_get_tg(css, clamp_id, next_group_id);
+
 	/* Update CPU's clamp group refcounts of RUNNABLE task */
 	if (p)
 		uclamp_task_update_active(p, clamp_id, next_group_id);
@@ -1344,12 +1370,12 @@ int sched_uclamp_handler(struct ctl_table *table, int write,
 	/* Update each required clamp group */
 	if (old_min != sysctl_sched_uclamp_util_min) {
 		uc_se = &uclamp_default[UCLAMP_MIN];
-		uclamp_group_get(NULL, UCLAMP_MIN, group_id[UCLAMP_MIN],
+		uclamp_group_get(NULL, NULL, UCLAMP_MIN, group_id[UCLAMP_MIN],
 				 uc_se, sysctl_sched_uclamp_util_min);
 	}
 	if (old_max != sysctl_sched_uclamp_util_max) {
 		uc_se = &uclamp_default[UCLAMP_MAX];
-		uclamp_group_get(NULL, UCLAMP_MAX, group_id[UCLAMP_MAX],
+		uclamp_group_get(NULL, NULL, UCLAMP_MAX, group_id[UCLAMP_MAX],
 				 uc_se, sysctl_sched_uclamp_util_max);
 	}
 
@@ -1441,7 +1467,7 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
 			return 0;
 		}
 #endif
-		uclamp_group_get(NULL, clamp_id, group_id, uc_se,
+		uclamp_group_get(NULL, NULL, clamp_id, group_id, uc_se,
 				 parent->uclamp[clamp_id].value);
 	}
 
@@ -1532,12 +1558,12 @@ static inline int __setscheduler_uclamp(struct task_struct *p,
 	/* Update each required clamp group */
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		uc_se = &p->uclamp[UCLAMP_MIN];
-		uclamp_group_get(p, UCLAMP_MIN, group_id[UCLAMP_MIN],
+		uclamp_group_get(p, NULL, UCLAMP_MIN, group_id[UCLAMP_MIN],
 				 uc_se, attr->sched_util_min);
 	}
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
 		uc_se = &p->uclamp[UCLAMP_MAX];
-		uclamp_group_get(p, UCLAMP_MAX, group_id[UCLAMP_MAX],
+		uclamp_group_get(p, NULL, UCLAMP_MAX, group_id[UCLAMP_MAX],
 				 uc_se, attr->sched_util_max);
 	}
 
@@ -7468,6 +7494,10 @@ static void cpu_util_update_hier(struct cgroup_subsys_state *css,
 
 		uc_se->effective.value = value;
 		uc_se->effective.group_id = group_id;
+
+		/* Immediately updated descendants active tasks */
+		if (css != top_css)
+			uclamp_group_get_tg(css, clamp_id, group_id);
 	}
 }
 
@@ -7508,7 +7538,7 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 
 	/* Update TG's reference count */
 	uc_se = &tg->uclamp[UCLAMP_MIN];
-	uclamp_group_get(NULL, UCLAMP_MIN, group_id, uc_se, min_value);
+	uclamp_group_get(NULL, css, UCLAMP_MIN, group_id, uc_se, min_value);
 
 out:
 	rcu_read_unlock();
@@ -7554,7 +7584,7 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 
 	/* Update TG's reference count */
 	uc_se = &tg->uclamp[UCLAMP_MAX];
-	uclamp_group_get(NULL, UCLAMP_MAX, group_id, uc_se, max_value);
+	uclamp_group_get(NULL, css, UCLAMP_MAX, group_id, uc_se, max_value);
 
 out:
 	rcu_read_unlock();
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index a3ca449e36c1..ced86cfd8fcd 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -91,6 +91,11 @@ SCHED_FEAT(WA_BIAS, true)
  */
 SCHED_FEAT(UTIL_EST, true)
 
+/*
+ * Utilization clamping lazy update.
+ */
+SCHED_FEAT(UCLAMP_LAZY_UPDATE, false)
+
 /*
  * Per class CPU's utilization clamping.
  */
-- 
2.18.0

