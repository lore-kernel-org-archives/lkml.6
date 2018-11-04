Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F413ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 00:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5225F20843
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 00:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5225F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbeKDJ12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 04:27:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33145 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeKDJ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 04:27:28 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA40EEjn3851484
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 3 Nov 2018 17:14:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA40EDd73851481;
        Sat, 3 Nov 2018 17:14:13 -0700
Date:   Sat, 3 Nov 2018 17:14:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Muchun Song <tipbot@zytor.com>
Message-ID: <tip-ff1cdc94de4d336be45336d70709dfcf3d682514@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, smuchun@gmail.com
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          mingo@kernel.org, tglx@linutronix.de, smuchun@gmail.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20181026131743.21786-1-smuchun@gmail.com>
References: <20181026131743.21786-1-smuchun@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Introduce set_next_task() helper for
 better code readability
Git-Commit-ID: ff1cdc94de4d336be45336d70709dfcf3d682514
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ff1cdc94de4d336be45336d70709dfcf3d682514
Gitweb:     https://git.kernel.org/tip/ff1cdc94de4d336be45336d70709dfcf3d682514
Author:     Muchun Song <smuchun@gmail.com>
AuthorDate: Fri, 26 Oct 2018 21:17:43 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 4 Nov 2018 00:59:24 +0100

sched/core: Introduce set_next_task() helper for better code readability

When we pick the next task, we will do the following for the task:

  1) p->se.exec_start = rq_clock_task(rq);
  2) dequeue_pushable(_dl)_task(rq, p);

When we call set_curr_task(), we also need to do the same thing
above. In rt.c, the code at 1) is in the _pick_next_task_rt()
and the code at 2) is in the pick_next_task_rt(). If we put two
operations in one function, maybe better. So, we introduce a new
function set_next_task(), which is responsible for doing the above.

By introducing the function we can get rid of calling the
dequeue_pushable(_dl)_task() directly(We can call set_next_task())
in pick_next_task() and have better code readability and reuse.
In set_curr_task_rt(), we also can call set_next_task().

Do this things such that we end up with:

  static struct task_struct *pick_next_task(struct rq *rq,
  					    struct task_struct *prev,
  					    struct rq_flags *rf)
  {
  	/* do something else ... */

  	put_prev_task(rq, prev);

  	/* pick next task p */

  	set_next_task(rq, p);

  	/* do something else ... */
  }

put_prev_task() can match set_next_task(), which can make the
code more readable.

Signed-off-by: Muchun Song <smuchun@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181026131743.21786-1-smuchun@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/deadline.c | 19 ++++++++++---------
 kernel/sched/rt.c       | 24 +++++++++++-------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 91e4202b0634..470ba6b464fe 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1695,6 +1695,14 @@ static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
 }
 #endif
 
+static inline void set_next_task(struct rq *rq, struct task_struct *p)
+{
+	p->se.exec_start = rq_clock_task(rq);
+
+	/* You can't push away the running task */
+	dequeue_pushable_dl_task(rq, p);
+}
+
 static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
 						   struct dl_rq *dl_rq)
 {
@@ -1750,10 +1758,8 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	BUG_ON(!dl_se);
 
 	p = dl_task_of(dl_se);
-	p->se.exec_start = rq_clock_task(rq);
 
-	/* Running task will never be pushed. */
-       dequeue_pushable_dl_task(rq, p);
+	set_next_task(rq, p);
 
 	if (hrtick_enabled(rq))
 		start_hrtick_dl(rq, p);
@@ -1808,12 +1814,7 @@ static void task_fork_dl(struct task_struct *p)
 
 static void set_curr_task_dl(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
-
-	p->se.exec_start = rq_clock_task(rq);
-
-	/* You can't push away the running task */
-	dequeue_pushable_dl_task(rq, p);
+	set_next_task(rq, rq->curr);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a21ea6021929..9aa3287ce301 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1498,6 +1498,14 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 #endif
 }
 
+static inline void set_next_task(struct rq *rq, struct task_struct *p)
+{
+	p->se.exec_start = rq_clock_task(rq);
+
+	/* The running task is never eligible for pushing */
+	dequeue_pushable_task(rq, p);
+}
+
 static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
 						   struct rt_rq *rt_rq)
 {
@@ -1518,7 +1526,6 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
 static struct task_struct *_pick_next_task_rt(struct rq *rq)
 {
 	struct sched_rt_entity *rt_se;
-	struct task_struct *p;
 	struct rt_rq *rt_rq  = &rq->rt;
 
 	do {
@@ -1527,10 +1534,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 		rt_rq = group_rt_rq(rt_se);
 	} while (rt_rq);
 
-	p = rt_task_of(rt_se);
-	p->se.exec_start = rq_clock_task(rq);
-
-	return p;
+	return rt_task_of(rt_se);
 }
 
 static struct task_struct *
@@ -1573,8 +1577,7 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	p = _pick_next_task_rt(rq);
 
-	/* The running task is never eligible for pushing */
-	dequeue_pushable_task(rq, p);
+	set_next_task(rq, p);
 
 	rt_queue_push_tasks(rq);
 
@@ -2355,12 +2358,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 
 static void set_curr_task_rt(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
-
-	p->se.exec_start = rq_clock_task(rq);
-
-	/* The running task is never eligible for pushing */
-	dequeue_pushable_task(rq, p);
+	set_next_task(rq, rq->curr);
 }
 
 static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
