Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940C2217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iKFMSAWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389362AbfBRRko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:40:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388727AbfBRRkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qa/iAb2+MKDNHlrJAJ7vmM6JHXm33Y4+EAhvheOGht8=; b=iKFMSAWo2IfZMZb3dKJOdGaIdP
        y0QTPESSqxkcsMb45rlkp2/5wcc7l/ut5RzJGOfi1s21DK2M1IA7658VuC1xuXVTlNksK5N/XfI4e
        Hpi9mm7BgrHWu0lQWV96p6PbVuRe9DLRtBjrE3fMkNbY46aXiKZTOrGKaVCW1TDqpdipoeCg/n/rE
        e0OoLNrln19PEsOt+sLQY+653CHrg9gv2XgC+XgY0Fn7iO3LL8+3DeuIuZ1psIGdHnI2n1Xs6iv3C
        SbZGml67A1xexOP27z5rK1uj7FsCAMQ5GhwlmgsYTHWX1mTbmpc3OgdJsz6fEdZNIqUVqv5QK8Fck
        TPwtDGDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvmu4-0005zM-EO; Mon, 18 Feb 2019 17:40:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 519EC2848B881; Mon, 18 Feb 2019 18:40:23 +0100 (CET)
Message-Id: <20190218173514.796920915@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Feb 2019 17:56:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC][PATCH 15/16] sched: Trivial forced-newidle balancer
References: <20190218165620.383905466@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a sibling is forced-idle to match the core-cookie; search for
matching tasks to fill the core.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    1 
 kernel/sched/core.c   |  131 +++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/idle.c   |    1 
 kernel/sched/sched.h  |    6 ++
 4 files changed, 138 insertions(+), 1 deletion(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -640,6 +640,7 @@ struct task_struct {
 #ifdef CONFIG_SCHED_CORE
 	struct rb_node			core_node;
 	unsigned long			core_cookie;
+	unsigned int			core_occupation;
 #endif
 
 #ifdef CONFIG_CGROUP_SCHED
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -198,6 +198,21 @@ struct task_struct *sched_core_find(stru
 	return match;
 }
 
+struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
+{
+	struct rb_node *node = &p->core_node;
+
+	node = rb_next(node);
+	if (!node)
+		return NULL;
+
+	p = container_of(node, struct task_struct, core_node);
+	if (p->core_cookie != cookie)
+		return NULL;
+
+	return p;
+}
+
 /*
  * The static-key + stop-machine variable are needed such that:
  *
@@ -3650,7 +3665,7 @@ pick_next_task(struct rq *rq, struct tas
 	struct task_struct *next, *max = NULL;
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
-	int i, j, cpu;
+	int i, j, cpu, occ = 0;
 
 	if (!sched_core_enabled(rq))
 		return __pick_next_task(rq, prev, rf);
@@ -3741,6 +3756,9 @@ pick_next_task(struct rq *rq, struct tas
 				goto done;
 			}
 
+			if (!is_idle_task(p))
+				occ++;
+
 			rq_i->core_pick = p;
 
 			/*
@@ -3764,6 +3782,7 @@ pick_next_task(struct rq *rq, struct tas
 
 						cpu_rq(j)->core_pick = NULL;
 					}
+					occ = 1;
 					goto again;
 				}
 			}
@@ -3786,6 +3805,8 @@ next_class:;
 
 		WARN_ON_ONCE(!rq_i->core_pick);
 
+		rq_i->core_pick->core_occupation = occ;
+
 		if (i == cpu)
 			continue;
 
@@ -3801,6 +3822,114 @@ next_class:;
 	return next;
 }
 
+static bool try_steal_cookie(int this, int that)
+{
+	struct rq *dst = cpu_rq(this), *src = cpu_rq(that);
+	struct task_struct *p;
+	unsigned long cookie;
+	bool success = false;
+
+	local_irq_disable();
+	double_rq_lock(dst, src);
+
+	cookie = dst->core->core_cookie;
+	if (!cookie)
+		goto unlock;
+
+	if (dst->curr != dst->idle)
+		goto unlock;
+
+	p = sched_core_find(src, cookie);
+	if (p == src->idle)
+		goto unlock;
+
+	do {
+		if (p == src->core_pick || p == src->curr)
+			goto next;
+
+		if (!cpumask_test_cpu(this, &p->cpus_allowed))
+			goto next;
+
+		if (p->core_occupation > dst->idle->core_occupation)
+			goto next;
+
+		p->on_rq = TASK_ON_RQ_MIGRATING;
+		deactivate_task(src, p, 0);
+		set_task_cpu(p, this);
+		activate_task(dst, p, 0);
+		p->on_rq = TASK_ON_RQ_QUEUED;
+
+		resched_curr(dst);
+
+		success = true;
+		break;
+
+next:
+		p = sched_core_next(p, cookie);
+	} while (p);
+
+unlock:
+	double_rq_unlock(dst, src);
+	local_irq_enable();
+
+	return success;
+}
+
+static bool steal_cookie_task(int cpu, struct sched_domain *sd)
+{
+	int i;
+
+	for_each_cpu_wrap(i, sched_domain_span(sd), cpu) {
+		if (i == cpu)
+			continue;
+
+		if (need_resched())
+			break;
+
+		if (try_steal_cookie(cpu, i))
+			return true;
+	}
+
+	return false;
+}
+
+static void sched_core_balance(struct rq *rq)
+{
+	struct sched_domain *sd;
+	int cpu = cpu_of(rq);
+
+	rcu_read_lock();
+	raw_spin_unlock_irq(rq_lockp(rq));
+	for_each_domain(cpu, sd) {
+		if (!(sd->flags & SD_LOAD_BALANCE))
+			break;
+
+		if (need_resched())
+			break;
+
+		if (steal_cookie_task(cpu, sd))
+			break;
+	}
+	raw_spin_lock_irq(rq_lockp(rq));
+	rcu_read_unlock();
+}
+
+static DEFINE_PER_CPU(struct callback_head, core_balance_head);
+
+void queue_core_balance(struct rq *rq)
+{
+	if (!sched_core_enabled(rq))
+		return;
+
+	if (!rq->core->core_cookie)
+		return;
+
+	if (!rq->nr_running) /* not forced idle */
+		return;
+
+	queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_core_balance);
+}
+
 #else /* !CONFIG_SCHED_CORE */
 
 static struct task_struct *
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -387,6 +387,7 @@ static void set_next_task_idle(struct rq
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
+	queue_core_balance(rq);
 }
 
 static struct task_struct *
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1013,6 +1013,8 @@ static inline raw_spinlock_t *rq_lockp(s
 	return &rq->__lock;
 }
 
+extern void queue_core_balance(struct rq *rq);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1025,6 +1027,10 @@ static inline raw_spinlock_t *rq_lockp(s
 	return &rq->__lock;
 }
 
+static inline void queue_core_balance(struct rq *rq)
+{
+}
+
 #endif /* CONFIG_SCHED_CORE */
 
 #ifdef CONFIG_SCHED_SMT


