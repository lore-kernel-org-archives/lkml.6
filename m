Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C57C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80622080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80622080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbeJ3DYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:24:09 -0400
Received: from foss.arm.com ([217.140.101.70]:44746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbeJ3DYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:24:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5552C1596;
        Mon, 29 Oct 2018 11:34:17 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6438B3F6A8;
        Mon, 29 Oct 2018 11:34:14 -0700 (PDT)
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
Subject: [PATCH v5 14/15] sched/core: uclamp: use TG's clamps to restrict Task's clamps
Date:   Mon, 29 Oct 2018 18:33:09 +0000
Message-Id: <20181029183311.29175-16-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181029183311.29175-1-patrick.bellasi@arm.com>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
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
 include/linux/sched.h |  9 +++++++
 kernel/sched/core.c   | 58 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7698e7554892..4b61fbcb0797 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -609,12 +609,21 @@ struct sched_dl_entity {
  * The active bit is set whenever a task has got an effective clamp group
  * and value assigned, which can be different from the user requested ones.
  * This allows to know a task is actually refcounting a CPU's clamp group.
+ *
+ * The user_defined bit is set whenever a task has got a task-specific clamp
+ * value requested from userspace, i.e. the system defaults applies to this
+ * task just as a restriction. This allows to relax TG's clamps when a less
+ * restrictive task specific value has been defined, thus allowing to
+ * implement a "nice" semantic when both task group and task specific values
+ * are used. For example, a task running on a 20% boosted TG can still drop
+ * its own boosting to 0%.
  */
 struct uclamp_se {
 	unsigned int value		: SCHED_CAPACITY_SHIFT + 1;
 	unsigned int group_id		: order_base_2(UCLAMP_GROUPS);
 	unsigned int mapped		: 1;
 	unsigned int active		: 1;
+	unsigned int user_defined	: 1;
 	/*
 	 * Clamp group and value actually used by a scheduling entity,
 	 * i.e. a (RUNNABLE) task or a task group.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e2292c698e3b..2ce84d22ab17 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -875,6 +875,28 @@ static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id,
 	rq->uclamp.value[clamp_id] = max_value;
 }
 
+/**
+ * uclamp_apply_defaults: check if p is subject to system default clamps
+ * @p: the task to check
+ *
+ * Tasks in the root group or autogroups are always and only limited by system
+ * defaults. All others instead are limited by their TG's specific value.
+ * This method checks the conditions under witch a task is subject to system
+ * default clamps.
+ */
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+static inline bool uclamp_apply_defaults(struct task_struct *p)
+{
+	if (task_group_is_autogroup(task_group(p)))
+		return true;
+	if (task_group(p) == &root_task_group)
+		return true;
+	return false;
+}
+#else
+#define uclamp_apply_defaults(p) true
+#endif
+
 /**
  * uclamp_effective_group_id: get the effective clamp group index of a task
  * @p: the task to get the effective clamp value for
@@ -882,9 +904,11 @@ static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id,
  *
  * The effective clamp group index of a task depends on:
  * - the task specific clamp value, explicitly requested from userspace
+ * - the task group effective clamp value, for tasks not in the root group or
+ *   in an autogroup
  * - the system default clamp value, defined by the sysadmin
- * and tasks specific's clamp values are always restricted by system
- * defaults clamp values.
+ * and tasks specific's clamp values are always restricted, with increasing
+ * priority, by their task group first and the system defaults after.
  *
  * This method returns the effective group index for a task, depending on its
  * status and a proper aggregation of the clamp values listed above.
@@ -908,6 +932,22 @@ static inline unsigned int uclamp_effective_group_id(struct task_struct *p,
 	clamp_value = p->uclamp[clamp_id].value;
 	group_id = p->uclamp[clamp_id].group_id;
 
+	if (!uclamp_apply_defaults(p)) {
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+		unsigned int clamp_max =
+			task_group(p)->uclamp[clamp_id].effective.value;
+		unsigned int group_max =
+			task_group(p)->uclamp[clamp_id].effective.group_id;
+
+		if (!p->uclamp[clamp_id].user_defined ||
+		    clamp_value > clamp_max) {
+			clamp_value = clamp_max;
+			group_id = group_max;
+		}
+#endif
+		goto done;
+	}
+
 	/* RT tasks have different default values */
 	default_clamp = task_has_rt_policy(p)
 		? uclamp_default_perf
@@ -924,6 +964,8 @@ static inline unsigned int uclamp_effective_group_id(struct task_struct *p,
 		group_id = default_clamp[clamp_id].group_id;
 	}
 
+done:
+
 	p->uclamp[clamp_id].effective.value = clamp_value;
 	p->uclamp[clamp_id].effective.group_id = group_id;
 
@@ -936,8 +978,10 @@ static inline unsigned int uclamp_effective_group_id(struct task_struct *p,
  * @rq: the CPU's rq where the clamp group has to be reference counted
  * @clamp_id: the clamp index to update
  *
- * Once a task is enqueued on a CPU's rq, the clamp group currently defined by
- * the task's uclamp::group_id is reference counted on that CPU.
+ * Once a task is enqueued on a CPU's rq, with increasing priority, we
+ * reference count the most restrictive clamp group between the task specific
+ * clamp value, the clamp value of its task group and the system default clamp
+ * value.
  */
 static inline void uclamp_cpu_get_id(struct task_struct *p, struct rq *rq,
 				     unsigned int clamp_id)
@@ -1312,10 +1356,12 @@ static int __setscheduler_uclamp(struct task_struct *p,
 
 	/* Update each required clamp group */
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+		p->uclamp[UCLAMP_MIN].user_defined = true;
 		uclamp_group_get(p, &p->uclamp[UCLAMP_MIN],
 				 UCLAMP_MIN, lower_bound);
 	}
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+		p->uclamp[UCLAMP_MAX].user_defined = true;
 		uclamp_group_get(p, &p->uclamp[UCLAMP_MAX],
 				 UCLAMP_MAX, upper_bound);
 	}
@@ -1359,8 +1405,10 @@ static void uclamp_fork(struct task_struct *p, bool reset)
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
 		unsigned int clamp_value = p->uclamp[clamp_id].value;
 
-		if (unlikely(reset))
+		if (unlikely(reset)) {
 			clamp_value = uclamp_none(clamp_id);
+			p->uclamp[clamp_id].user_defined = false;
+		}
 
 		p->uclamp[clamp_id].mapped = false;
 		p->uclamp[clamp_id].active = false;
-- 
2.18.0

