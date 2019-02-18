Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C0CC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988442085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Aovg/uqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389153AbfBRRkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:40:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388669AbfBRRkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q9bdcq87HzYS6o27z60OEbaBxirTDiLY2tVqzYQ4H38=; b=Aovg/uqx4qT+P46JTeTOkpQWG9
        tjNsuQj2ft8eaf6+QvVr2QqtDq20dRNyL2vUIwKgbiyD2sNE98jlWHuqZwJnTS7+lM2WSb/f/A1eS
        usKVQcIKdJPuYHdVErWWfY7dUG8U3vXwuCPvpVutCsPvHdzAvunYAh0r0ZlKMC0kd1vXNKNhI5Ft+
        MTHnxdiEMMX4YpMPRoZeX4D87h6T1d4NwfqJF/3Lo0WwBTmbHDopaXZMXNuLQmu18w9tfIGz4E3ey
        3vghA6kkI+N/3ISsazmcUNRtjr0iqyBH33ndZ/Jq3WzFLJhlsi0l89SoQnoYy7uNYFONZXx14M2MM
        yScjwMMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvmu4-0005zO-EE; Mon, 18 Feb 2019 17:40:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 56B032848B882; Mon, 18 Feb 2019 18:40:23 +0100 (CET)
Message-Id: <20190218173514.856366309@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Feb 2019 17:56:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC][PATCH 16/16] sched: Debug bits...
References: <20190218165620.383905466@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
---
 kernel/sched/core.c |   36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -91,6 +91,10 @@ static inline bool __prio_less(struct ta
 {
 	int pa = __task_prio(a), pb = __task_prio(b);
 
+	trace_printk("(%s/%d;%d,%Lu,%Lu) ?< (%s/%d;%d,%Lu,%Lu)\n",
+			a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
+			b->comm, b->pid, pa, b->se.vruntime, b->dl.deadline);
+
 	if (-pa < -pb)
 		return true;
 
@@ -245,6 +249,8 @@ static void __sched_core_enable(void)
 
 	static_branch_enable(&__sched_core_enabled);
 	stop_machine(__sched_core_stopper, (void *)true, NULL);
+
+	printk("core sched enabled\n");
 }
 
 static void __sched_core_disable(void)
@@ -253,6 +259,8 @@ static void __sched_core_disable(void)
 
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
+
+	printk("core sched disabled\n");
 }
 
 void sched_core_get(void)
@@ -3684,6 +3692,14 @@ pick_next_task(struct rq *rq, struct tas
 			put_prev_task(rq, prev);
 			set_next_task(rq, next);
 		}
+
+		trace_printk("pick pre selected (%u %u %u): %s/%d %lx\n",
+				rq->core->core_task_seq,
+				rq->core->core_pick_seq,
+				rq->core_sched_seq,
+				next->comm, next->pid,
+				next->core_cookie);
+
 		return next;
 	}
 
@@ -3753,6 +3769,10 @@ pick_next_task(struct rq *rq, struct tas
 			 */
 			if (i == cpu && !rq->core->core_cookie && !p->core_cookie) {
 				next = p;
+
+				trace_printk("unconstrained pick: %s/%d %lx\n",
+						next->comm, next->pid, next->core_cookie);
+
 				goto done;
 			}
 
@@ -3761,6 +3781,9 @@ pick_next_task(struct rq *rq, struct tas
 
 			rq_i->core_pick = p;
 
+			trace_printk("cpu(%d): selected: %s/%d %lx\n",
+					i, p->comm, p->pid, p->core_cookie);
+
 			/*
 			 * If this new candidate is of higher priority than the
 			 * previous; and they're incompatible; we need to wipe
@@ -3774,6 +3797,7 @@ pick_next_task(struct rq *rq, struct tas
 
 				rq->core->core_cookie = p->core_cookie;
 				max = p;
+				trace_printk("max: %s/%d %lx\n", max->comm, max->pid, max->core_cookie);
 
 				if (old_max && !cookie_match(old_max, p)) {
 					for_each_cpu(j, smt_mask) {
@@ -3810,13 +3834,17 @@ next_class:;
 		if (i == cpu)
 			continue;
 
-		if (rq_i->curr != rq_i->core_pick)
+		if (rq_i->curr != rq_i->core_pick) {
 			resched_curr(rq_i);
+			trace_printk("IPI(%d)\n", i);
+		}
 	}
 
 	rq->core_sched_seq = rq->core->core_pick_seq;
 	next = rq->core_pick;
 
+	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
+
 done:
 	set_next_task(rq, next);
 	return next;
@@ -3853,6 +3881,10 @@ static bool try_steal_cookie(int this, i
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
 
+		trace_printk("core fill: %s/%d (%d->%d) %d %d %lx\n",
+				p->comm, p->pid, that, this,
+				p->core_occupation, dst->idle->core_occupation, cookie);
+
 		p->on_rq = TASK_ON_RQ_MIGRATING;
 		deactivate_task(src, p, 0);
 		set_task_cpu(p, this);
@@ -6434,6 +6466,8 @@ int sched_cpu_starting(unsigned int cpu)
 		WARN_ON_ONCE(rq->core && rq->core != core_rq);
 		rq->core = core_rq;
 	}
+
+	printk("core: %d -> %d\n", cpu, cpu_of(core_rq));
 #endif /* CONFIG_SCHED_CORE */
 
 	sched_rq_cpu_starting(cpu);


