Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF75ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110BE20840
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110BE20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeGOX7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:59:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44389 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeGOX7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:59:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNYfw2922244
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:34:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNYfwM922241;
        Sun, 15 Jul 2018 16:34:41 -0700
Date:   Sun, 15 Jul 2018 16:34:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-af0fffd9300b97d8875aa745bc78e2f6fdb3c1f0@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, bigeasy@linutronix.de,
        torvalds@linux-foundation.org, mingo@kernel.org
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          bigeasy@linutronix.de, peterz@infradead.org
In-Reply-To: <20180706130615.g2ex2kmfu5kcvlq6@linutronix.de>
References: <20180706130615.g2ex2kmfu5kcvlq6@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Remove get_cpu() from sched_fork()
Git-Commit-ID: af0fffd9300b97d8875aa745bc78e2f6fdb3c1f0
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

Commit-ID:  af0fffd9300b97d8875aa745bc78e2f6fdb3c1f0
Gitweb:     https://git.kernel.org/tip/af0fffd9300b97d8875aa745bc78e2f6fdb3c1f0
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 6 Jul 2018 15:06:15 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:16:29 +0200

sched/core: Remove get_cpu() from sched_fork()

get_cpu() disables preemption for the entire sched_fork() function.
This get_cpu() was introduced in commit:

  dd41f596cda0 ("sched: cfs core code")

... which also invoked sched_balance_self() and this function
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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180706130615.g2ex2kmfu5kcvlq6@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ba6bb805693a..c3cf7d992159 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2294,7 +2294,6 @@ static inline void init_schedstats(void) {}
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
 	unsigned long flags;
-	int cpu = get_cpu();
 
 	__sched_fork(clone_flags, p);
 	/*
@@ -2330,14 +2329,12 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
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
 
@@ -2353,7 +2350,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	 * We're setting the CPU for the first time, we don't migrate,
 	 * so use __set_task_cpu().
 	 */
-	__set_task_cpu(p, cpu);
+	__set_task_cpu(p, smp_processor_id());
 	if (p->sched_class->task_fork)
 		p->sched_class->task_fork(p);
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
@@ -2370,8 +2367,6 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
 #endif
-
-	put_cpu();
 	return 0;
 }
 
