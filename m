Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A84C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89495208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89495208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965582AbeFRIWi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:22:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965515AbeFRIWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:22:35 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 42D52C7A;
        Mon, 18 Jun 2018 08:22:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 159/279] stop_machine, sched: Fix migrate_swap() vs. active_balance() deadlock
Date:   Mon, 18 Jun 2018 10:12:24 +0200
Message-Id: <20180618080615.404029993@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 0b26351b910fb8fe6a056f8a1bbccabe50c0e19f ]

Matt reported the following deadlock:

CPU0					CPU1

schedule(.prev=migrate/0)		<fault>
  pick_next_task()			  ...
    idle_balance()			    migrate_swap()
      active_balance()			      stop_two_cpus()
						spin_lock(stopper0->lock)
						spin_lock(stopper1->lock)
						ttwu(migrate/0)
						  smp_cond_load_acquire() -- waits for schedule()
        stop_one_cpu(1)
	  spin_lock(stopper1->lock) -- waits for stopper lock

Fix this deadlock by taking the wakeups out from under stopper->lock.
This allows the active_balance() to queue the stop work and finish the
context switch, which in turn allows the wakeup from migrate_swap() to
observe the context and complete the wakeup.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180420095005.GH4064@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/stop_machine.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -21,6 +21,7 @@
 #include <linux/smpboot.h>
 #include <linux/atomic.h>
 #include <linux/nmi.h>
+#include <linux/sched/wake_q.h>
 
 /*
  * Structure to determine completion condition and record errors.  May
@@ -65,27 +66,31 @@ static void cpu_stop_signal_done(struct
 }
 
 static void __cpu_stop_queue_work(struct cpu_stopper *stopper,
-					struct cpu_stop_work *work)
+					struct cpu_stop_work *work,
+					struct wake_q_head *wakeq)
 {
 	list_add_tail(&work->list, &stopper->works);
-	wake_up_process(stopper->thread);
+	wake_q_add(wakeq, stopper->thread);
 }
 
 /* queue @work to @stopper.  if offline, @work is completed immediately */
 static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 {
 	struct cpu_stopper *stopper = &per_cpu(cpu_stopper, cpu);
+	DEFINE_WAKE_Q(wakeq);
 	unsigned long flags;
 	bool enabled;
 
 	spin_lock_irqsave(&stopper->lock, flags);
 	enabled = stopper->enabled;
 	if (enabled)
-		__cpu_stop_queue_work(stopper, work);
+		__cpu_stop_queue_work(stopper, work, &wakeq);
 	else if (work->done)
 		cpu_stop_signal_done(work->done);
 	spin_unlock_irqrestore(&stopper->lock, flags);
 
+	wake_up_q(&wakeq);
+
 	return enabled;
 }
 
@@ -229,6 +234,7 @@ static int cpu_stop_queue_two_works(int
 {
 	struct cpu_stopper *stopper1 = per_cpu_ptr(&cpu_stopper, cpu1);
 	struct cpu_stopper *stopper2 = per_cpu_ptr(&cpu_stopper, cpu2);
+	DEFINE_WAKE_Q(wakeq);
 	int err;
 retry:
 	spin_lock_irq(&stopper1->lock);
@@ -252,8 +258,8 @@ retry:
 			goto unlock;
 
 	err = 0;
-	__cpu_stop_queue_work(stopper1, work1);
-	__cpu_stop_queue_work(stopper2, work2);
+	__cpu_stop_queue_work(stopper1, work1, &wakeq);
+	__cpu_stop_queue_work(stopper2, work2, &wakeq);
 unlock:
 	spin_unlock(&stopper2->lock);
 	spin_unlock_irq(&stopper1->lock);
@@ -263,6 +269,9 @@ unlock:
 			cpu_relax();
 		goto retry;
 	}
+
+	wake_up_q(&wakeq);
+
 	return err;
 }
 /**


