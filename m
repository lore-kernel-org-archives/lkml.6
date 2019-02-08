Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AE5C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2882080A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfBHKHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:07:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47694 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbfBHKHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:07:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2891FA78;
        Fri,  8 Feb 2019 02:07:00 -0800 (PST)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11B263F557;
        Fri,  8 Feb 2019 02:06:56 -0800 (PST)
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
Subject: [PATCH v7 14/15] sched/core: uclamp: Use TG's clamps to restrict TASK's clamps
Date:   Fri,  8 Feb 2019 10:05:53 +0000
Message-Id: <20190208100554.32196-15-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208100554.32196-1-patrick.bellasi@arm.com>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
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
 kernel/sched/core.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 35e9f06af08d..6f8f68d18d0f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -823,10 +823,44 @@ static inline void uclamp_rq_update(struct rq *rq, unsigned int clamp_id,
 	WRITE_ONCE(rq->uclamp[clamp_id].value, max_value);
 }
 
+static inline bool
+uclamp_tg_restricted(struct task_struct *p, unsigned int clamp_id,
+		     unsigned int *clamp_value, unsigned int *bucket_id)
+{
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	unsigned int clamp_max, bucket_max;
+	struct uclamp_se *tg_clamp;
+
+	/*
+	 * Tasks in an autogroup or the root task group are restricted by
+	 * system defaults.
+	 */
+	if (task_group_is_autogroup(task_group(p)))
+		return false;
+	if (task_group(p) == &root_task_group)
+		return false;
+
+	tg_clamp = &task_group(p)->uclamp[clamp_id];
+	bucket_max = tg_clamp->effective.bucket_id;
+	clamp_max = tg_clamp->effective.value;
+
+	if (!p->uclamp[clamp_id].user_defined || *clamp_value > clamp_max) {
+		*clamp_value = clamp_max;
+		*bucket_id = bucket_max;
+	}
+
+	return true;
+#else
+	return false;
+#endif
+}
+
 /*
  * The effective clamp bucket index of a task depends on, by increasing
  * priority:
  * - the task specific clamp value, when explicitly requested from userspace
+ * - the task group effective clamp value, for tasks not either in the root
+ *   group or in an autogroup
  * - the system default clamp value, defined by the sysadmin
  *
  * As a side effect, update the task's effective value:
@@ -841,7 +875,13 @@ uclamp_effective_get(struct task_struct *p, unsigned int clamp_id,
 	*bucket_id = p->uclamp[clamp_id].bucket_id;
 	*clamp_value = p->uclamp[clamp_id].value;
 
-	/* Always apply system default restrictions */
+	/*
+	 * If we have task groups and we are running in a child group, system
+	 * default are already affecting the group's clamp values.
+	 */
+	if (uclamp_tg_restricted(p, clamp_id, clamp_value, bucket_id))
+		return;
+
 	if (unlikely(*clamp_value > uclamp_default[clamp_id].value)) {
 		*clamp_value = uclamp_default[clamp_id].value;
 		*bucket_id = uclamp_default[clamp_id].bucket_id;
-- 
2.20.1

