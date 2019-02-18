Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE335C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88A521872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nlKtbGb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388860AbfBRRkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:40:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbfBRRkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/NkJ9MZbFQlDIN/zSYRcWfjemARLrtuDdONoVLXsV84=; b=nlKtbGb08muYYlEo0LBdsV7Tbo
        GVs5hJng5+UVhuMWor8txqcihBn9DqDmzWK/+lgGA8CPkKU/y0zzeAVcaVs5ALMJSyYaIZ9LHTb8Y
        Ni6ViegwhInkzh5hziC3bnxkceA+uXMT4DE1jjX1Cv17mxN093JknnouOnt6x983oCzX25zj41L8B
        0iow5d+f2EjqOhjM/gBp/9HN/jx/Kugn6Uvk+9DOYGS4YXFFo354pWLQhr/d9MATQoi8T9ToTt2/e
        R1q0tivqZfnWaJNyygQLqpEBfiAiounTYLgbNq/4tvzouDUal+NtpF9cLiTcAKSa9BQCHn+B1DBqq
        oXk1Stjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvmu1-0005ye-07; Mon, 18 Feb 2019 17:40:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 224092848B876; Mon, 18 Feb 2019 18:40:23 +0100 (CET)
Message-Id: <20190218173514.123649591@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Feb 2019 17:56:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC][PATCH 04/16] sched/{rt,deadline}: Fix set_next_task vs pick_next_task
References: <20190218165620.383905466@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because pick_next_task() implies set_curr_task() and some of the
details haven't matter too much, some of what _should_ be in
set_curr_task() ended up in pick_next_task, correct this.

This prepares the way for a pick_next_task() variant that does not
affect the current state; allowing remote picking.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c |   23 ++++++++++++-----------
 kernel/sched/rt.c       |   27 ++++++++++++++-------------
 2 files changed, 26 insertions(+), 24 deletions(-)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1695,12 +1695,21 @@ static void start_hrtick_dl(struct rq *r
 }
 #endif
 
-static inline void set_next_task(struct rq *rq, struct task_struct *p)
+static void set_next_task_dl(struct rq *rq, struct task_struct *p)
 {
 	p->se.exec_start = rq_clock_task(rq);
 
 	/* You can't push away the running task */
 	dequeue_pushable_dl_task(rq, p);
+
+	if (hrtick_enabled(rq))
+		start_hrtick_dl(rq, p);
+
+	if (rq->curr->sched_class != &dl_sched_class)
+		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+
+	if (rq->curr != p)
+		deadline_queue_push_tasks(rq);
 }
 
 static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
@@ -1759,15 +1768,7 @@ pick_next_task_dl(struct rq *rq, struct
 
 	p = dl_task_of(dl_se);
 
-	set_next_task(rq, p);
-
-	if (hrtick_enabled(rq))
-		start_hrtick_dl(rq, p);
-
-	deadline_queue_push_tasks(rq);
-
-	if (rq->curr->sched_class != &dl_sched_class)
-		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+	set_next_task_dl(rq, p);
 
 	return p;
 }
@@ -1814,7 +1815,7 @@ static void task_fork_dl(struct task_str
 
 static void set_curr_task_dl(struct rq *rq)
 {
-	set_next_task(rq, rq->curr);
+	set_next_task_dl(rq, rq->curr);
 }
 
 #ifdef CONFIG_SMP
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1498,12 +1498,23 @@ static void check_preempt_curr_rt(struct
 #endif
 }
 
-static inline void set_next_task(struct rq *rq, struct task_struct *p)
+static inline void set_next_task_rt(struct rq *rq, struct task_struct *p)
 {
 	p->se.exec_start = rq_clock_task(rq);
 
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
+
+	/*
+	 * If prev task was rt, put_prev_task() has already updated the
+	 * utilization. We only care of the case where we start to schedule a
+	 * rt task
+	 */
+	if (rq->curr->sched_class != &rt_sched_class)
+		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+
+	if (rq->curr != p)
+		rt_queue_push_tasks(rq);
 }
 
 static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
@@ -1577,17 +1588,7 @@ pick_next_task_rt(struct rq *rq, struct
 
 	p = _pick_next_task_rt(rq);
 
-	set_next_task(rq, p);
-
-	rt_queue_push_tasks(rq);
-
-	/*
-	 * If prev task was rt, put_prev_task() has already updated the
-	 * utilization. We only care of the case where we start to schedule a
-	 * rt task
-	 */
-	if (rq->curr->sched_class != &rt_sched_class)
-		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+	set_next_task_rt(rq, p);
 
 	return p;
 }
@@ -2356,7 +2357,7 @@ static void task_tick_rt(struct rq *rq,
 
 static void set_curr_task_rt(struct rq *rq)
 {
-	set_next_task(rq, rq->curr);
+	set_next_task_rt(rq, rq->curr);
 }
 
 static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)


