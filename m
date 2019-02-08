Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F01CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491AE2080A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfBHKHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:07:07 -0500
Received: from foss.arm.com ([217.140.101.70]:47712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfBHKHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:07:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80236A78;
        Fri,  8 Feb 2019 02:07:03 -0800 (PST)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 691B83F557;
        Fri,  8 Feb 2019 02:07:00 -0800 (PST)
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
Subject: [PATCH v7 15/15] sched/core: uclamp: Update CPU's refcount on TG's clamp changes
Date:   Fri,  8 Feb 2019 10:05:54 +0000
Message-Id: <20190208100554.32196-16-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208100554.32196-1-patrick.bellasi@arm.com>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On updates of task group (TG) clamp values, ensure that these new values
are enforced on all RUNNABLE tasks of the task group, i.e. all RUNNABLE
tasks are immediately boosted and/or clamped as requested.

Do that by slightly refactoring uclamp_bucket_inc(). An additional
parameter *cgroup_subsys_state (css) is used to walk the list of tasks
in the TGs and update the RUNNABLE ones. Do that by taking the rq
lock for each task, the same mechanism used for cpu affinity masks
updates.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6f8f68d18d0f..e0fdc98b3663 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1030,6 +1030,51 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 		uclamp_rq_dec_id(p, rq, clamp_id);
 }
 
+static inline void
+uclamp_update_active(struct task_struct *p, unsigned int clamp_id)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	/*
+	 * Lock the task and the rq where the task is (or was) queued.
+	 *
+	 * We might lock the (previous) rq of a !RUNNABLE task, but that's the
+	 * price to pay to safely serialize util_{min,max} updates with
+	 * enqueues, dequeues and migration operations.
+	 * This is the same locking schema used by __set_cpus_allowed_ptr().
+	 */
+	rq = task_rq_lock(p, &rf);
+
+	/*
+	 * Setting the clamp bucket is serialized by task_rq_lock().
+	 * If the task is not yet RUNNABLE and its task_struct is not
+	 * affecting a valid clamp bucket, the next time it's enqueued,
+	 * it will already see the updated clamp bucket value.
+	 */
+	if (!p->uclamp[clamp_id].active)
+		goto done;
+
+	uclamp_rq_dec_id(p, rq, clamp_id);
+	uclamp_rq_inc_id(p, rq, clamp_id);
+
+done:
+
+	task_rq_unlock(rq, p, &rf);
+}
+
+static inline void
+uclamp_update_active_tasks(struct cgroup_subsys_state *css, int clamp_id)
+{
+	struct css_task_iter it;
+	struct task_struct *p;
+
+	css_task_iter_start(css, 0, &it);
+	while ((p = css_task_iter_next(&it)))
+		uclamp_update_active(p, clamp_id);
+	css_task_iter_end(&it);
+}
+
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 static void cpu_util_update_hier(struct cgroup_subsys_state *css,
 				 unsigned int clamp_id, unsigned int bucket_id,
@@ -7128,6 +7173,7 @@ static void cpu_util_update_hier(struct cgroup_subsys_state *css,
 
 		uc_se->effective.value = value;
 		uc_se->effective.bucket_id = bucket_id;
+		uclamp_update_active_tasks(css, clamp_id);
 	}
 }
 
-- 
2.20.1

