Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C08C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6BA24001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6BA24001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933390AbeGFNGT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:06:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54523 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932679AbeGFNGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:06:17 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fbQRD-0001S0-Ms; Fri, 06 Jul 2018 15:06:15 +0200
Date:   Fri, 6 Jul 2018 15:06:15 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] sched/core: remove get_cpu() from sched_fork()
Message-ID: <20180706130615.g2ex2kmfu5kcvlq6@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_cpu() disables preemption for the entire sched_fork() function.
This get_cpu() was introduced in commit dd41f596cda0 ("sched: cfs core
code") which also invoked sched_balance_self() and this function
required preemption do be off.
Today, sched_balance_self() seems to be moved to ->task_fork callback
which is invoked while the ->pi_lock is held.
set_load_weight() could invoke reweight_task() which then via $callchain
might end up in smp_processor_id() but since `update_load' is false
this won't happen.
I didn't find any this_cpu*() or similar usage during the initialisation
of the task_struct.
The `cpu' value (from get_cpu()) is only used later in __set_task_cpu()
while the ->pi_lock lock is held.

Based on this it is possible to remove get_cpu() and use
smp_processor_id() for the `cpu' variable without breaking anything.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 78d8facba456..b6ec6ebe620d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2318,7 +2318,6 @@ static inline void init_schedstats(void) {}
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
 	unsigned long flags;
-	int cpu = get_cpu();
 
 	__sched_fork(clone_flags, p);
 	/*
@@ -2354,14 +2353,12 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->sched_reset_on_fork = 0;
 	}
 
-	if (dl_prio(p->prio)) {
-		put_cpu();
+	if (dl_prio(p->prio))
 		return -EAGAIN;
-	} else if (rt_prio(p->prio)) {
+	else if (rt_prio(p->prio))
 		p->sched_class = &rt_sched_class;
-	} else {
+	else
 		p->sched_class = &fair_sched_class;
-	}
 
 	init_entity_runnable_average(&p->se);
 
@@ -2377,7 +2374,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	 * We're setting the CPU for the first time, we don't migrate,
 	 * so use __set_task_cpu().
 	 */
-	__set_task_cpu(p, cpu);
+	__set_task_cpu(p, smp_processor_id());
 	if (p->sched_class->task_fork)
 		p->sched_class->task_fork(p);
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
@@ -2394,8 +2391,6 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
 #endif
-
-	put_cpu();
 	return 0;
 }
 
-- 
2.18.0

