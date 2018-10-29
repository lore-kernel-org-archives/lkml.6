Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9B3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27CE2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27CE2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbeJ3DXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:23:40 -0400
Received: from foss.arm.com ([217.140.101.70]:44604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729391AbeJ3DXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:23:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 754601682;
        Mon, 29 Oct 2018 11:33:48 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 844DE3F6A8;
        Mon, 29 Oct 2018 11:33:45 -0700 (PDT)
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
Subject: [PATCH v5 05/15] sched/core: uclamp: update CPU's refcount on clamp changes
Date:   Mon, 29 Oct 2018 18:33:00 +0000
Message-Id: <20181029183311.29175-7-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181029183311.29175-1-patrick.bellasi@arm.com>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilization clamp values enforced on a CPU by a task can be updated at
run-time, for example via a sched_setattr syscall, while a task is
currently RUNNABLE on that CPU. In these cases, the task is already
refcounting a clamp group for its CPU and thus we need to update this
reference to ensure the new constraints are immediately enforced.

Since a clamp value change always implies a clamp group refcount update,
this patch hooks into uclamp_group_get() to trigger a CPU refcount
syncup, via uclamp_cpu_{put,get}_id(), whenever a task is RUNNABLE.

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
 - remove not required uclamp_task_affects() since now all tasks always
   have a valid clamp group assigned
 Others:
 - consistently use "unsigned int" for both clamp_id and group_id
 - fixup documentation
 - reduced usage of inline comments
 - rebased on v4.19

Changes in v4:
 Message-ID: <20180816132249.GA2960@e110439-lin>
 - inline uclamp_task_active() code into uclamp_task_update_active()
 - get rid of the now unused uclamp_task_active()
 Other:
 - allow to call uclamp_group_get() without a task pointer, which is
   used to refcount the initial clamp group for all the global objects
   (init_task, root_task_group and system_defaults)
 - rebased on v4.19-rc1
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
 kernel/sched/core.c | 60 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a98a96a7d9f1..21f6251a1d44 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -936,6 +936,48 @@ static inline void uclamp_cpu_put(struct rq *rq, struct task_struct *p)
 		uclamp_cpu_put_id(p, rq, clamp_id);
 }
 
+/**
+ * uclamp_task_update_active: update the clamp group of a RUNNABLE task
+ * @p: the task which clamp groups must be updated
+ * @clamp_id: the clamp index to consider
+ *
+ * Each time the clamp value of a task group is changed, the old and new clamp
+ * groups must be updated for each CPU containing a RUNNABLE task belonging to
+ * that task group. Sleeping tasks are not updated since they will be enqueued
+ * with the proper clamp group index at their next activation.
+ */
+static inline void
+uclamp_task_update_active(struct task_struct *p, unsigned int clamp_id)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	/*
+	 * Lock the task and the CPU where the task is (or was) queued.
+	 *
+	 * We might lock the (previous) rq of a !RUNNABLE task, but that's the
+	 * price to pay to safely serialize util_{min,max} updates with
+	 * enqueues, dequeues and migration operations.
+	 * This is the same locking schema used by __set_cpus_allowed_ptr().
+	 */
+	rq = task_rq_lock(p, &rf);
+
+	/*
+	 * The setting of the clamp group is serialized by task_rq_lock().
+	 * Thus, if the task is not yet RUNNABLE and its task_struct is not
+	 * affecting a valid clamp group, then the next time it's going to be
+	 * enqueued it will already see the updated clamp group value.
+	 */
+	if (!p->uclamp[clamp_id].active)
+		goto done;
+
+	uclamp_cpu_put_id(p, rq, clamp_id);
+	uclamp_cpu_get_id(p, rq, clamp_id);
+
+done:
+	task_rq_unlock(rq, p, &rf);
+}
+
 /**
  * uclamp_group_put: decrease the reference count for a clamp group
  * @clamp_id: the clamp index which was affected by a task group
@@ -970,6 +1012,7 @@ static void uclamp_group_put(unsigned int clamp_id, unsigned int group_id)
 
 /**
  * uclamp_group_get: increase the reference count for a clamp group
+ * @p: the task which clamp value must be tracked
  * @uc_se: the utilization clamp data for the task
  * @clamp_id: the clamp index affected by the task
  * @clamp_value: the new clamp value for the task
@@ -980,8 +1023,8 @@ static void uclamp_group_put(unsigned int clamp_id, unsigned int group_id)
  * reference count the corresponding clamp value while the task is enqueued on
  * a CPU.
  */
-static void uclamp_group_get(struct uclamp_se *uc_se, unsigned int clamp_id,
-			     unsigned int clamp_value)
+static void uclamp_group_get(struct task_struct *p, struct uclamp_se *uc_se,
+			     unsigned int clamp_id, unsigned int clamp_value)
 {
 	union uclamp_map *uc_maps = &uclamp_maps[clamp_id][0];
 	unsigned int prev_group_id = uc_se->group_id;
@@ -1046,6 +1089,10 @@ static void uclamp_group_get(struct uclamp_se *uc_se, unsigned int clamp_id,
 	uc_se->value = clamp_value;
 	uc_se->group_id = group_id;
 
+	/* Update CPU's clamp group refcounts of RUNNABLE task */
+	if (p)
+		uclamp_task_update_active(p, clamp_id);
+
 	/* Release the previous clamp group */
 	if (uc_se->mapped)
 		uclamp_group_put(clamp_id, prev_group_id);
@@ -1073,11 +1120,11 @@ static int __setscheduler_uclamp(struct task_struct *p,
 
 	/* Update each required clamp group */
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
-		uclamp_group_get(&p->uclamp[UCLAMP_MIN],
+		uclamp_group_get(p, &p->uclamp[UCLAMP_MIN],
 				 UCLAMP_MIN, lower_bound);
 	}
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
-		uclamp_group_get(&p->uclamp[UCLAMP_MAX],
+		uclamp_group_get(p, &p->uclamp[UCLAMP_MAX],
 				 UCLAMP_MAX, upper_bound);
 	}
 
@@ -1125,7 +1172,8 @@ static void uclamp_fork(struct task_struct *p, bool reset)
 
 		p->uclamp[clamp_id].mapped = false;
 		p->uclamp[clamp_id].active = false;
-		uclamp_group_get(&p->uclamp[clamp_id], clamp_id, clamp_value);
+		uclamp_group_get(NULL, &p->uclamp[clamp_id],
+				 clamp_id, clamp_value);
 	}
 }
 
@@ -1146,7 +1194,7 @@ static void __init init_uclamp(void)
 	memset(uclamp_maps, 0, sizeof(uclamp_maps));
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
 		uc_se = &init_task.uclamp[clamp_id];
-		uclamp_group_get(uc_se, clamp_id, uclamp_none(clamp_id));
+		uclamp_group_get(NULL, uc_se, clamp_id, uclamp_none(clamp_id));
 	}
 }
 
-- 
2.18.0

