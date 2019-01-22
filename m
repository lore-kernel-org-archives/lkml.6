Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8E2C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9692F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfAVQZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:25:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56920 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbfAVQZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:25:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE674A78;
        Tue, 22 Jan 2019 08:25:30 -0800 (PST)
Received: from e107985-lin.cambridge.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 428A43F6A8;
        Tue, 22 Jan 2019 08:25:29 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Call post_init_entity_util_avg() with task_struct pointer argument
Date:   Tue, 22 Jan 2019 16:25:01 +0000
Message-Id: <20190122162501.12000-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d03266910a53 ("sched/fair: Fix task group initialization")
the utilization of a sched entity representing a task group is no longer
initialized to any other value than 0. So post_init_entity_util_avg() is
only used for tasks.

Make this clear by calling it with a task_struct pointer argument which
also eliminates the entity_is_task(se) if condition in the fork path and
get rid of the stale comment in remove_entity_load_avg() accordingly.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/fair.c  | 38 ++++++++++++++++----------------------
 kernel/sched/sched.h |  2 +-
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d4d3514c4fe9..20eab0d96a8d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2418,7 +2418,7 @@ void wake_up_new_task(struct task_struct *p)
 #endif
 	rq = __task_rq_lock(p, &rf);
 	update_rq_clock(rq);
-	post_init_entity_util_avg(&p->se);
+	post_init_entity_util_avg(p);
 
 	activate_task(rq, p, ENQUEUE_NOCLOCK);
 	p->on_rq = TASK_ON_RQ_QUEUED;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e2ff4b69dcf6..732711ed3cf3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -744,8 +744,9 @@ static void attach_entity_cfs_rq(struct sched_entity *se);
  * Finally, that extrapolated util_avg is clamped to the cap (util_avg_cap)
  * if util_avg > util_avg_cap.
  */
-void post_init_entity_util_avg(struct sched_entity *se)
+void post_init_entity_util_avg(struct task_struct *p)
 {
+	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	struct sched_avg *sa = &se->avg;
 	long cpu_scale = arch_scale_cpu_capacity(NULL, cpu_of(rq_of(cfs_rq)));
@@ -763,22 +764,19 @@ void post_init_entity_util_avg(struct sched_entity *se)
 		}
 	}
 
-	if (entity_is_task(se)) {
-		struct task_struct *p = task_of(se);
-		if (p->sched_class != &fair_sched_class) {
-			/*
-			 * For !fair tasks do:
-			 *
-			update_cfs_rq_load_avg(now, cfs_rq);
-			attach_entity_load_avg(cfs_rq, se, 0);
-			switched_from_fair(rq, p);
-			 *
-			 * such that the next switched_to_fair() has the
-			 * expected state.
-			 */
-			se->avg.last_update_time = cfs_rq_clock_task(cfs_rq);
-			return;
-		}
+	if (p->sched_class != &fair_sched_class) {
+		/*
+		 * For !fair tasks do:
+		 *
+		update_cfs_rq_load_avg(now, cfs_rq);
+		attach_entity_load_avg(cfs_rq, se, 0);
+		switched_from_fair(rq, p);
+		 *
+		 * such that the next switched_to_fair() has the
+		 * expected state.
+		 */
+		se->avg.last_update_time = cfs_rq_clock_task(cfs_rq);
+		return;
 	}
 
 	attach_entity_cfs_rq(se);
@@ -788,7 +786,7 @@ void post_init_entity_util_avg(struct sched_entity *se)
 void init_entity_runnable_average(struct sched_entity *se)
 {
 }
-void post_init_entity_util_avg(struct sched_entity *se)
+void post_init_entity_util_avg(struct task_struct *p)
 {
 }
 static void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
@@ -3577,10 +3575,6 @@ void remove_entity_load_avg(struct sched_entity *se)
 	 * tasks cannot exit without having gone through wake_up_new_task() ->
 	 * post_init_entity_util_avg() which will have added things to the
 	 * cfs_rq, so we can remove unconditionally.
-	 *
-	 * Similarly for groups, they will have passed through
-	 * post_init_entity_util_avg() before unregister_sched_fair_group()
-	 * calls this.
 	 */
 
 	sync_entity_load_avg(se);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d27c1a5d4e25..ac0a2c0cd33e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1781,7 +1781,7 @@ extern void init_dl_rq_bw_ratio(struct dl_rq *dl_rq);
 unsigned long to_ratio(u64 period, u64 runtime);
 
 extern void init_entity_runnable_average(struct sched_entity *se);
-extern void post_init_entity_util_avg(struct sched_entity *se);
+extern void post_init_entity_util_avg(struct task_struct *p);
 
 #ifdef CONFIG_NO_HZ_FULL
 extern bool sched_can_stop_tick(struct rq *rq);
-- 
2.17.1

