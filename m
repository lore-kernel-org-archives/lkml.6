Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34A8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA5420779
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA5420779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbeGPI4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:56:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54478 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731687AbeGPI4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:56:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D237EED1;
        Mon, 16 Jul 2018 01:30:05 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.210.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 103AE3F5A0;
        Mon, 16 Jul 2018 01:30:02 -0700 (PDT)
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
Subject: [PATCH v2 11/12] sched/core: uclamp: update CPU's refcount on TG's clamp changes
Date:   Mon, 16 Jul 2018 09:29:05 +0100
Message-Id: <20180716082906.6061-12-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716082906.6061-1-patrick.bellasi@arm.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task group refcounts a new clamp group, we need to ensure that
the new clamp values are immediately enforced to all its tasks which are
currently RUNNABLE. This is to ensure that all currently RUNNABLE task
are boosted and/or clamped as requested as soon as possible.

Let's ensure that, whenever a new clamp group is refcounted by a task
group, all its RUNNABLE tasks are correctly accounted in their
respective CPUs. We do that by slightly refactoring uclamp_group_get()
to get an additional parameter *cgroup_subsys_state which, when
provided, it's used to walk the list of tasks in the correspond TGs and
update the RUNNABLE ones.

This is a "brute force" solution which allows to reuse the same refcount
update code already used by the per-task API. That's also the only way
to ensure a prompt enforcement of new clamp constraints on RUNNABLE
tasks, as soon as a task group attribute is tweaked.

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
 kernel/sched/core.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 50613d3d5b83..42cff5ffddae 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1198,21 +1198,43 @@ static inline void uclamp_group_put(int clamp_id, int group_id)
 	raw_spin_unlock_irqrestore(&uc_map[group_id].se_lock, flags);
 }
 
+static inline void uclamp_group_get_tg(struct cgroup_subsys_state *css,
+				       int clamp_id, unsigned int group_id)
+{
+	struct css_task_iter it;
+	struct task_struct *p;
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
- * @clamp_id: the clamp index affected by the task
- * @uc_se: the utilization clamp data for the task
- * @clamp_value: the new clamp value for the task
+ * @css: the task group which clamp value must be tracked
+ * @clamp_id: the clamp index affected by the task (group)
+ * @uc_se: the utilization clamp data for the task (group)
+ * @clamp_value: the new clamp value for the task (group)
  *
  * Each time a task changes its utilization clamp value, for a specified clamp
  * index, we need to find an available clamp group which can be used to track
  * this new clamp value. The corresponding clamp group index will be used by
  * the task to reference count the clamp value on CPUs while enqueued.
  *
+ * When the cgroup's cpu controller utilization clamping support is enabled,
+ * each task group has a set of clamp values which are used to restrict the
+ * corresponding task specific clamp values.
+ * When a clamp value for a task group is changed, all the (active) tasks
+ * belonging to that task group must be update to ensure they are refcounting
+ * the correct CPU's clamp value.
+ *
  * Return: -ENOSPC if there are no available clamp groups, 0 on success.
  */
 static inline int uclamp_group_get(struct task_struct *p,
+				   struct cgroup_subsys_state *css,
 				   int clamp_id, struct uclamp_se *uc_se,
 				   unsigned int clamp_value)
 {
@@ -1240,6 +1262,10 @@ static inline int uclamp_group_get(struct task_struct *p,
 	uc_map[next_group_id].se_count += 1;
 	raw_spin_unlock_irqrestore(&uc_map[next_group_id].se_lock, flags);
 
+	/* Newly created TG don't have tasks assigned */
+	if (css)
+		uclamp_group_get_tg(css, clamp_id, next_group_id);
+
 	/* Update CPU's clamp group refcounts of RUNNABLE task */
 	if (p)
 		uclamp_task_update_active(p, clamp_id, next_group_id);
@@ -1307,7 +1333,7 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
 		uc_se->value = parent->uclamp[clamp_id].value;
 		uc_se->group_id = UCLAMP_NONE;
 
-		if (uclamp_group_get(NULL, clamp_id, uc_se,
+		if (uclamp_group_get(NULL, NULL, clamp_id, uc_se,
 				     parent->uclamp[clamp_id].value)) {
 			ret = 0;
 			goto out;
@@ -1362,12 +1388,12 @@ static inline int __setscheduler_uclamp(struct task_struct *p,
 
 	/* Update min utilization clamp */
 	uc_se = &p->uclamp[UCLAMP_MIN];
-	retval |= uclamp_group_get(p, UCLAMP_MIN, uc_se,
+	retval |= uclamp_group_get(p, NULL, UCLAMP_MIN, uc_se,
 				   attr->sched_util_min);
 
 	/* Update max utilization clamp */
 	uc_se = &p->uclamp[UCLAMP_MAX];
-	retval |= uclamp_group_get(p, UCLAMP_MAX, uc_se,
+	retval |= uclamp_group_get(p, NULL, UCLAMP_MAX, uc_se,
 				   attr->sched_util_max);
 
 	mutex_unlock(&uclamp_mutex);
@@ -7274,7 +7300,7 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 
 	/* Update TG's reference count */
 	uc_se = &tg->uclamp[UCLAMP_MIN];
-	ret = uclamp_group_get(NULL, UCLAMP_MIN, uc_se, min_value);
+	ret = uclamp_group_get(NULL, css, UCLAMP_MIN, uc_se, min_value);
 
 out:
 	rcu_read_unlock();
@@ -7306,7 +7332,7 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 
 	/* Update TG's reference count */
 	uc_se = &tg->uclamp[UCLAMP_MAX];
-	ret = uclamp_group_get(NULL, UCLAMP_MAX, uc_se, max_value);
+	ret = uclamp_group_get(NULL, css, UCLAMP_MAX, uc_se, max_value);
 
 out:
 	rcu_read_unlock();
-- 
2.17.1

