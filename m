Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC4EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78CE20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfAOKQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:16:21 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47044 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbfAOKQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:16:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3096C1596;
        Tue, 15 Jan 2019 02:16:17 -0800 (PST)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A0A23F70D;
        Tue, 15 Jan 2019 02:16:13 -0800 (PST)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org
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
Subject: [PATCH v6 15/16] sched/core: uclamp: Use TG's clamps to restrict TASK's clamps
Date:   Tue, 15 Jan 2019 10:15:12 +0000
Message-Id: <20190115101513.2822-16-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190115101513.2822-1-patrick.bellasi@arm.com>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task specific clamp value is configured via sched_setattr(2),
this value is accounted in the corresponding clamp bucket every time the
task is {en,de}qeued. However, when cgroups are also in use, the task
specific clamp values could be restricted by the task_group (TG)
clamp values.

Update uclamp_cpu_inc() to aggregate task and TG clamp values. Every
time a task is enqueued, it's accounted in the clamp_bucket defining the
smaller clamp between the task specific value and its TG effective
value. This allows to:

1. ensure cgroup clamps are always used to restrict task specific
   requests, i.e. boosted only up to the effective granted value or
   clamped at least to a certain value

2. implement a "nice-like" policy, where tasks are still allowed to
   request less then what enforced by their current TG

This mimics what already happens for a task's CPU affinity mask when the
task is also in a cpuset, i.e. cgroup attributes are always used to
restrict per-task attributes.

Do this by exploiting the concept of "effective" clamp, which is already
used by a TG to track parent enforced restrictions.

Apply task group clamp restrictions only to tasks belonging to a child
group. While, for tasks in the root group or in an autogroup, only
system defaults are enforced.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>

---
Changes in v6:
 Others:
 - wholesale s/group/bucket/
---
 include/linux/sched.h | 10 ++++++++++
 kernel/sched/core.c   | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3f02128fe6b2..bb4e3b1085f9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -602,6 +602,7 @@ struct sched_dl_entity {
  * @bucket_id:		the bucket index used by the fast-path
  * @mapped:		the bucket index is valid
  * @active:		the se is currently refcounted in a CPU's clamp bucket
+ * @user_defined:	calmp value explicitly required from user-space
  *
  * A utilization clamp bucket maps a:
  *   clamp value (value), i.e.
@@ -619,12 +620,21 @@ struct sched_dl_entity {
  * The active bit is set whenever a task has got an effective clamp bucket
  * and value assigned, and it allows to know a task is actually refcounting a
  * CPU's clamp bucket.
+ *
+ * The user_defined bit is set whenever a task has got a task-specific clamp
+ * value requested from userspace, i.e. the system defaults apply to this
+ * task just as a restriction. This allows to relax TG's clamps when a less
+ * restrictive task specific value has been defined, thus allowing to
+ * implement a "nice" semantic when both task bucket and task specific values
+ * are used. For example, a task running on a 20% boosted TG can still drop
+ * its own boosting to 0%.
  */
 struct uclamp_se {
 	unsigned int value		: bits_per(SCHED_CAPACITY_SCALE);
 	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
 	unsigned int mapped		: 1;
 	unsigned int active		: 1;
+	unsigned int user_defined	: 1;
 	/*
 	 * Clamp bucket and value actually used by a scheduling entity,
 	 * i.e. a (RUNNABLE) task or a task group.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 734b769db2ca..c8d1fc9880ff 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -845,10 +845,23 @@ static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id,
 	WRITE_ONCE(rq->uclamp[clamp_id].value, max_value);
 }
 
+static inline bool uclamp_apply_defaults(struct task_struct *p)
+{
+	if (!IS_ENABLED(CONFIG_UCLAMP_TASK_GROUP))
+		return true;
+	if (task_group_is_autogroup(task_group(p)))
+		return true;
+	if (task_group(p) == &root_task_group)
+		return true;
+	return false;
+}
+
 /*
  * The effective clamp bucket index of a task depends on, by increasing
  * priority:
  * - the task specific clamp value, explicitly requested from userspace
+ * - the task group effective clamp value, for tasks not in the root group or
+ *   in an autogroup
  * - the system default clamp value, defined by the sysadmin
  *
  * As a side effect, update the task's effective value:
@@ -865,6 +878,29 @@ uclamp_effective_get(struct task_struct *p, unsigned int clamp_id,
 	*clamp_value = p->uclamp[clamp_id].value;
 	*bucket_id = p->uclamp[clamp_id].bucket_id;
 
+	if (!uclamp_apply_defaults(p)) {
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+		unsigned int clamp_max, bucket_max;
+		struct uclamp_se *tg_clamp;
+
+		tg_clamp = &task_group(p)->uclamp[clamp_id];
+		clamp_max = tg_clamp->effective.value;
+		bucket_max = tg_clamp->effective.bucket_id;
+
+		if (!p->uclamp[clamp_id].user_defined ||
+		    *clamp_value > clamp_max) {
+			*clamp_value = clamp_max;
+			*bucket_id = bucket_max;
+		}
+#endif
+		/*
+		 * If we have task groups and we are running in a child group,
+		 * system default does not apply anymore since we assume task
+		 * group clamps are properly configured.
+		 */
+		return;
+	}
+
 	/* RT tasks have different default values */
 	default_clamp = task_has_rt_policy(p)
 		? uclamp_default_perf
@@ -1223,10 +1259,12 @@ static int __setscheduler_uclamp(struct task_struct *p,
 
 	mutex_lock(&uclamp_mutex);
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+		p->uclamp[UCLAMP_MIN].user_defined = true;
 		uclamp_bucket_inc(p, &p->uclamp[UCLAMP_MIN],
 				  UCLAMP_MIN, lower_bound);
 	}
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+		p->uclamp[UCLAMP_MAX].user_defined = true;
 		uclamp_bucket_inc(p, &p->uclamp[UCLAMP_MAX],
 				  UCLAMP_MAX, upper_bound);
 	}
@@ -1259,8 +1297,10 @@ static void uclamp_fork(struct task_struct *p, bool reset)
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
2.19.2

