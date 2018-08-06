Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1725C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F5E21A28
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F5E21A28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbeHFSug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:50:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41786 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbeHFSuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFA7015B2;
        Mon,  6 Aug 2018 09:40:41 -0700 (PDT)
Received: from e110439-lin.Cambridge.Arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E6823F5D0;
        Mon,  6 Aug 2018 09:40:39 -0700 (PDT)
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
Subject: [PATCH v3 04/14] sched/core: uclamp: update CPU's refcount on clamp changes
Date:   Mon,  6 Aug 2018 17:39:36 +0100
Message-Id: <20180806163946.28380-5-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806163946.28380-1-patrick.bellasi@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilization clamp values enforced on a CPU by a task can be updated at
run-time, for example via a sched_setattr syscall, while a task is
currently RUNNABLE on that CPU. In these cases, the task can be already
refcounting a clamp group for its CPU and thus we need to update this
reference to ensure the new constraints are immediately enforced.

Since a clamp value change always implies a clamp group refcount update,
this patch hooks into the clamp group refcount getter to trigger a CPU
refcount syncup. Such a syncup is required only by currently RUNNABLE
tasks which are also referencing at least one valid clamp group.

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
 - rename UCLAMP_NONE into UCLAMP_NOT_VALID
 Other:
 - rabased on tip/sched/core

Changes in v2:
 Message-ID: <20180413111900.GF4082@hirez.programming.kicks-ass.net>
 - get rid of the group_id back annotation
   which is not requires at this stage where we have only per-task
   clamping support. It will be introduce later when CGroups support is
   added.
 Other:
 - rabased on v4.18-rc4
 - this code has been split from a previous patch to simplify the review
---
 kernel/sched/core.c  | 61 ++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h | 45 ++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f058ceb14d25..bc2beedec7bf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1065,6 +1065,52 @@ static inline void uclamp_cpu_put(struct rq *rq, struct task_struct *p)
 		uclamp_cpu_put_id(p, rq, clamp_id);
 }
 
+/**
+ * uclamp_task_update_active: update the clamp group of a RUNNABLE task
+ * @p: the task which clamp groups must be updated
+ * @clamp_id: the clamp index to consider
+ * @group_id: the clamp group to update
+ *
+ * Each time the clamp value of a task group is changed, the old and new clamp
+ * groups have to be updated for each CPU containing a RUNNABLE task belonging
+ * to this tasks group. Sleeping tasks are not updated since they will be
+ * enqueued with the proper clamp group index at their next activation.
+ */
+static inline void
+uclamp_task_update_active(struct task_struct *p, int clamp_id, int group_id)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	/*
+	 * Lock the task and the CPU where the task is (or was) queued.
+	 *
+	 * We might lock the (previous) RQ of a !RUNNABLE task, but that's the
+	 * price to pay to safely serialize util_{min,max} updates with
+	 * enqueues, dequeues and migration operations.
+	 * This is the same locking schema used by __set_cpus_allowed_ptr().
+	 */
+	rq = task_rq_lock(p, &rf);
+
+	/*
+	 * The setting of the clamp group is serialized by task_rq_lock().
+	 * Thus, if the task's task_struct is not referencing a valid group
+	 * index, then that task is not yet RUNNABLE and it's going to be
+	 * enqueued with the proper clamp group value.
+	 */
+	if (!uclamp_task_active(p))
+		goto done;
+
+	/* Release p's currently referenced clamp group */
+	uclamp_cpu_put_id(p, rq, clamp_id);
+
+	/* Get p's new clamp group */
+	uclamp_cpu_get_id(p, rq, clamp_id);
+
+done:
+	task_rq_unlock(rq, p, &rf);
+}
+
 /**
  * uclamp_group_put: decrease the reference count for a clamp group
  * @clamp_id: the clamp index which was affected by a task group
@@ -1100,6 +1146,7 @@ static inline void uclamp_group_put(int clamp_id, int group_id)
 
 /**
  * uclamp_group_get: increase the reference count for a clamp group
+ * @p: the task which clamp value must be tracked
  * @clamp_id: the clamp index affected by the task
  * @next_group_id: the clamp group to refcount
  * @uc_se: the utilization clamp data for the task
@@ -1110,9 +1157,10 @@ static inline void uclamp_group_put(int clamp_id, int group_id)
  * this new clamp value. The corresponding clamp group index will be used by
  * the task to reference count the clamp value on CPUs while enqueued.
  */
-static inline void uclamp_group_get(int clamp_id, int next_group_id,
-				   struct uclamp_se *uc_se,
-				   unsigned int clamp_value)
+static inline void uclamp_group_get(struct task_struct *p,
+				    int clamp_id, int next_group_id,
+				    struct uclamp_se *uc_se,
+				    unsigned int clamp_value)
 {
 	struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
 	int prev_group_id = uc_se->group_id;
@@ -1129,6 +1177,9 @@ static inline void uclamp_group_get(int clamp_id, int next_group_id,
 	uc_map[next_group_id].se_count += 1;
 	raw_spin_unlock_irqrestore(&uc_map[next_group_id].se_lock, flags);
 
+	/* Update CPU's clamp group refcounts of RUNNABLE task */
+	uclamp_task_update_active(p, clamp_id, next_group_id);
+
 	/* Release the previous clamp group */
 	uclamp_group_put(clamp_id, prev_group_id);
 }
@@ -1188,12 +1239,12 @@ static inline int __setscheduler_uclamp(struct task_struct *p,
 	/* Update each required clamp group */
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		uc_se = &p->uclamp[UCLAMP_MIN];
-		uclamp_group_get(UCLAMP_MIN, group_id[UCLAMP_MIN],
+		uclamp_group_get(p, UCLAMP_MIN, group_id[UCLAMP_MIN],
 				 uc_se, attr->sched_util_min);
 	}
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
 		uc_se = &p->uclamp[UCLAMP_MAX];
-		uclamp_group_get(UCLAMP_MAX, group_id[UCLAMP_MAX],
+		uclamp_group_get(p, UCLAMP_MAX, group_id[UCLAMP_MAX],
 				 uc_se, attr->sched_util_max);
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8f96926703fc..c9df61d39a03 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2208,6 +2208,51 @@ static inline bool uclamp_group_active(struct uclamp_group *uc_grp,
 {
 	return uc_grp[group_id].tasks > 0;
 }
+
+/**
+ * uclamp_task_affects: check if a task affects a utilization clamp
+ * @p: the task to consider
+ * @clamp_id: the utilization clamp to check
+ *
+ * A task affects a clamp index if:
+ * - it's currently enqueued on a CPU
+ * - it references a valid clamp group index for the specified clamp index
+ *
+ * Return: true if p currently affects the specified clamp_id
+ */
+static inline bool uclamp_task_affects(struct task_struct *p, int clamp_id)
+{
+	return (p->uclamp[clamp_id].group_id != UCLAMP_NOT_VALID);
+}
+
+/**
+ * uclamp_task_active: check if a task is currently clamping a CPU
+ * @p: the task to check
+ *
+ * A task actively affects the utilization clamp of a CPU if:
+ * - it's currently enqueued or running on that CPU
+ * - it's refcounted in at least one clamp group of that CPU
+ *
+ * Return: true if p is currently clamping the utilization of its CPU.
+ */
+static inline bool uclamp_task_active(struct task_struct *p)
+{
+	struct rq *rq = task_rq(p);
+	int clamp_id;
+
+	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_held(&rq->lock);
+
+	if (!task_on_rq_queued(p) && !p->on_cpu)
+		return false;
+
+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
+		if (uclamp_task_affects(p, clamp_id))
+			return true;
+	}
+
+	return false;
+}
 #endif /* CONFIG_UCLAMP_TASK */
 
 #ifdef CONFIG_CPU_FREQ
-- 
2.18.0

