Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4691AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7212085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EI4Xo4R0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbfBRRkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:40:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47710 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388990AbfBRRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uM0ZWUoum7E8t4f6OYHHgc13deTWanDlcXfF9qflM+g=; b=EI4Xo4R0zozvF5t4ZbKfQPjeLD
        eu3pfGvodv5HeWD5TvGFVwuVnveZ67BWHJay7tDj2umIl3ldltaJXsKB5sEc2E3utplumEr2sgtnB
        ys6L8p3d+s+XpWERahTqjmInTv3B0YtMLKQkZl7IvlkZuNx02AryPGyvPLKf1ZJ0i1MJ/ecHJISq0
        nGhYvgx4VmyJeLB9x9tXVvelpJtOYDulAQE2xJDdELj/MJUbjCIR1u/Ptchw6M774pq63d9D4Tb3A
        uvmEl9srH3ftGLwURj+h+XGEz6YYMdqjdJ4rtknVfIpsnfEWJz4QC0a2Ri787El7h73mDVPm3GGwq
        Y9eEqrTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvmu2-0001Ex-GM; Mon, 18 Feb 2019 17:40:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 339452848B87B; Mon, 18 Feb 2019 18:40:23 +0100 (CET)
Message-Id: <20190218173514.418814864@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Feb 2019 17:56:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC][PATCH 09/16] sched: Introduce sched_class::pick_task()
References: <20190218165620.383905466@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because sched_class::pick_next_task() also implies
sched_class::set_next_task() (and possibly put_prev_task() and
newidle_balance) it is not state invariant. This makes it unsuitable
for remote task selection.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c  |   21 ++++++++++++++++-----
 kernel/sched/fair.c      |   30 ++++++++++++++++++++++++++++++
 kernel/sched/idle.c      |   10 +++++++++-
 kernel/sched/rt.c        |   21 ++++++++++++++++-----
 kernel/sched/sched.h     |    2 ++
 kernel/sched/stop_task.c |   21 ++++++++++++++++-----
 6 files changed, 89 insertions(+), 16 deletions(-)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1723,15 +1723,12 @@ static struct sched_dl_entity *pick_next
 	return rb_entry(left, struct sched_dl_entity, rb_node);
 }
 
-static struct task_struct *
-pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static struct task_struct *pick_task_dl(struct rq *rq)
 {
 	struct sched_dl_entity *dl_se;
 	struct task_struct *p;
 	struct dl_rq *dl_rq;
 
-	WARN_ON_ONCE(prev || rf);
-
 	dl_rq = &rq->dl;
 
 	if (unlikely(!dl_rq->dl_nr_running))
@@ -1742,7 +1739,19 @@ pick_next_task_dl(struct rq *rq, struct
 
 	p = dl_task_of(dl_se);
 
-	set_next_task_dl(rq, p);
+	return p;
+}
+
+static struct task_struct *
+pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	struct task_struct *p;
+
+	WARN_ON_ONCE(prev || rf);
+
+	p = pick_task_dl(rq);
+	if (p)
+		set_next_task_dl(rq, p);
 
 	return p;
 }
@@ -2389,6 +2398,8 @@ const struct sched_class dl_sched_class
 	.set_next_task		= set_next_task_dl,
 
 #ifdef CONFIG_SMP
+	.pick_task		= pick_task_dl,
+
 	.select_task_rq		= select_task_rq_dl,
 	.migrate_task_rq	= migrate_task_rq_dl,
 	.set_cpus_allowed       = set_cpus_allowed_dl,
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6937,6 +6937,34 @@ static void check_preempt_wakeup(struct
 }
 
 static struct task_struct *
+pick_task_fair(struct rq *rq)
+{
+	struct cfs_rq *cfs_rq = &rq->cfs;
+	struct sched_entity *se;
+
+	if (!cfs_rq->nr_running)
+		return NULL;
+
+	do {
+		struct sched_entity *curr = cfs_rq->curr;
+
+		se = pick_next_entity(cfs_rq, NULL);
+
+		if (curr) {
+			if (se && curr->on_rq)
+				update_curr(cfs_rq);
+
+			if (!se || entity_before(curr, se))
+				se = curr;
+		}
+
+		cfs_rq = group_cfs_rq(se);
+	} while (cfs_rq);
+
+	return task_of(se);
+}
+
+static struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct cfs_rq *cfs_rq = &rq->cfs;
@@ -10604,6 +10632,8 @@ const struct sched_class fair_sched_clas
 	.set_next_task          = set_next_task_fair,
 
 #ifdef CONFIG_SMP
+	.pick_task		= pick_task_fair,
+
 	.select_task_rq		= select_task_rq_fair,
 	.migrate_task_rq	= migrate_task_rq_fair,
 
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -373,6 +373,12 @@ static void check_preempt_curr_idle(stru
 	resched_curr(rq);
 }
 
+static struct task_struct *
+pick_task_idle(struct rq *rq)
+{
+	return rq->idle;
+}
+
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 }
@@ -386,11 +392,12 @@ static void set_next_task_idle(struct rq
 static struct task_struct *
 pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct task_struct *next = rq->idle;
+	struct task_struct *next;
 
 	if (prev)
 		put_prev_task(rq, prev);
 
+	next = pick_task_idle(rq);
 	set_next_task_idle(rq, next);
 
 	return next;
@@ -458,6 +465,7 @@ const struct sched_class idle_sched_clas
 	.set_next_task          = set_next_task_idle,
 
 #ifdef CONFIG_SMP
+	.pick_task		= pick_task_idle,
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1548,20 +1548,29 @@ static struct task_struct *_pick_next_ta
 	return rt_task_of(rt_se);
 }
 
-static struct task_struct *
-pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+static struct task_struct *pick_task_rt(struct rq *rq)
 {
 	struct task_struct *p;
 	struct rt_rq *rt_rq = &rq->rt;
 
-	WARN_ON_ONCE(prev || rf);
-
 	if (!rt_rq->rt_queued)
 		return NULL;
 
 	p = _pick_next_task_rt(rq);
 
-	set_next_task_rt(rq, p);
+	return p;
+}
+
+static struct task_struct *
+pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	struct task_struct *p;
+
+	WARN_ON_ONCE(prev || rf);
+
+	p = pick_task_rt(rq);
+	if (p)
+		set_next_task_rt(rq, p);
 
 	return p;
 }
@@ -2364,6 +2373,8 @@ const struct sched_class rt_sched_class
 	.set_next_task          = set_next_task_rt,
 
 #ifdef CONFIG_SMP
+	.pick_task		= pick_task_rt,
+
 	.select_task_rq		= select_task_rq_rt,
 
 	.set_cpus_allowed       = set_cpus_allowed_common,
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1682,6 +1682,8 @@ struct sched_class {
 	void (*set_next_task)(struct rq *rq, struct task_struct *p);
 
 #ifdef CONFIG_SMP
+	struct task_struct * (*pick_task)(struct rq *rq);
+
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -29,20 +29,30 @@ static void set_next_task_stop(struct rq
 }
 
 static struct task_struct *
-pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+pick_task_stop(struct rq *rq)
 {
 	struct task_struct *stop = rq->stop;
 
-	WARN_ON_ONCE(prev || rf);
-
 	if (!stop || !task_on_rq_queued(stop))
 		return NULL;
 
-	set_next_task_stop(rq, stop);
-
 	return stop;
 }
 
+static struct task_struct *
+pick_next_task_stop(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	struct task_struct *p;
+
+	WARN_ON_ONCE(prev || rf);
+
+	p = pick_task_stop(rq);
+	if (p)
+		set_next_task_stop(rq, p);
+
+	return p;
+}
+
 static void
 enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 {
@@ -129,6 +139,7 @@ const struct sched_class stop_sched_clas
 	.set_next_task          = set_next_task_stop,
 
 #ifdef CONFIG_SMP
+	.pick_task		= pick_task_stop,
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif


