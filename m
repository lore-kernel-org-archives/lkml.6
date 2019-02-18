Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC0AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715D12085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WzPlNBQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbfBRRlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:41:10 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47746 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389072AbfBRRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9rRKmqDuo9tZaFJPqI1veVDO2ifEyhERfvM4EsJURj4=; b=WzPlNBQFbXqfj2wHAsAfC6oMJD
        upSevvqsUJoMRaRMmffdrPsY/0JHAWOecN0EUb6DhiYr8p5+aiIddCN4zkyq0xM8gLHwbQ2e8Npqq
        7V2KoO6kc2DD/85/0yhSaZSSEZu7K0Hnl2z6VtSpSPfp03NkctolrUEd35uLHsNsklXiGx2x2gwZS
        /v13BK1o0efO/82a2//jaeLOfeQsQJKH3k2yn100yqsWdTl2yTY90k96JO/qPF89NVpdaHjVm/pEC
        MiY+MRTJwqOLSk8Mm2tonGTm2AR0g3DYuq8qRx7YP8CtgdXsNvrcMvEsN/sgT8Ls4vw/e489Ck5iu
        vKyuM0pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvmu2-0001Et-E8; Mon, 18 Feb 2019 17:40:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 277B22848B877; Mon, 18 Feb 2019 18:40:23 +0100 (CET)
Message-Id: <20190218173514.240667660@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Feb 2019 17:56:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC][PATCH 06/16] sched/fair: Export newidle_balance()
References: <20190218165620.383905466@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For pick_next_task_fair() it is the newidle balance that requires
dropping the rq->lock; provided we do put_prev_task() early, we can
also detect the condition for doing newidle early.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c  |   18 ++++++++----------
 kernel/sched/sched.h |    4 ++++
 2 files changed, 12 insertions(+), 10 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3610,8 +3610,6 @@ static inline unsigned long cfs_rq_load_
 	return cfs_rq->avg.load_avg;
 }
 
-static int idle_balance(struct rq *this_rq, struct rq_flags *rf);
-
 static inline unsigned long task_util(struct task_struct *p)
 {
 	return READ_ONCE(p->se.avg.util_avg);
@@ -7057,11 +7055,10 @@ done: __maybe_unused;
 	return p;
 
 idle:
-	update_misfit_status(NULL, rq);
-	new_tasks = idle_balance(rq, rf);
+	new_tasks = newidle_balance(rq, rf);
 
 	/*
-	 * Because idle_balance() releases (and re-acquires) rq->lock, it is
+	 * Because newidle_balance() releases (and re-acquires) rq->lock, it is
 	 * possible for any higher priority task to appear. In that case we
 	 * must re-start the pick_next_entity() loop.
 	 */
@@ -9243,10 +9240,10 @@ static int load_balance(int this_cpu, st
 	ld_moved = 0;
 
 	/*
-	 * idle_balance() disregards balance intervals, so we could repeatedly
-	 * reach this code, which would lead to balance_interval skyrocketting
-	 * in a short amount of time. Skip the balance_interval increase logic
-	 * to avoid that.
+	 * newidle_balance() disregards balance intervals, so we could
+	 * repeatedly reach this code, which would lead to balance_interval
+	 * skyrocketting in a short amount of time. Skip the balance_interval
+	 * increase logic to avoid that.
 	 */
 	if (env.idle == CPU_NEWLY_IDLE)
 		goto out;
@@ -9923,7 +9920,7 @@ static inline void nohz_newidle_balance(
  * idle_balance is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  */
-static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
+int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
@@ -9931,6 +9928,7 @@ static int idle_balance(struct rq *this_
 	int pulled_task = 0;
 	u64 curr_cost = 0;
 
+	update_misfit_status(NULL, this_rq);
 	/*
 	 * We must set idle_stamp _before_ calling idle_balance(), such that we
 	 * measure the duration of idle_balance() as idle time.
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1414,10 +1414,14 @@ static inline void unregister_sched_doma
 }
 #endif
 
+extern int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
+
 #else
 
 static inline void sched_ttwu_pending(void) { }
 
+static inline int newidle_balance(struct rq *this_rq, struct rq_flags *rf) { return 0; }
+
 #endif /* CONFIG_SMP */
 
 #include "stats.h"


