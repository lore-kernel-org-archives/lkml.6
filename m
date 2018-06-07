Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AeE/OQwoGVsKewAAmS7hNA
	; Thu, 07 Jun 2018 12:42:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1AF73608BA; Thu,  7 Jun 2018 12:42:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2IIzIwf5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 547DF607DC;
	Thu,  7 Jun 2018 12:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 547DF607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932533AbeFGMl6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:41:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49918 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932459AbeFGMlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=swXVvSn64Di+C2bFMkrPZ14lE/ZRlv9WavYcIDDE+l8=; b=2IIzIwf5WaPcMT1uVlfdtgmP7Y
        3b1m8SRgNhi/tpfFVQwii5EJ1Nz4d4rsrHpPn83NP4hpuso4hxSOjA1xUEG4g5okpQd1Yp2Pj/g/I
        HteHdlzuAnx+H/WhDu7JHbk4Q4M7Q1FzKMBUi1bN5xgS5Jo4iR/rFuLZARS9rHfPb83uz6fvd27kt
        iQSW7GSJ9BhDAlK6b0Ey42UBQyXjiNcBRjyhxo/PqScYETI2gd0aEaFuuUwvFfNkcJ3dzyGdirRQh
        NJgndn28RDOvw7rZpYVSHEkVaNjWUL4aD6a1VA7CA9oksWmDJBDguLKrHnTd7ZdAYGRvK/c3JwykS
        z+8eKuJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQuEI-000646-4q; Thu, 07 Jun 2018 12:41:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 98E9B201EA7A1; Thu,  7 Jun 2018 14:41:18 +0200 (CEST)
Message-Id: <20180607124006.104273400@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 07 Jun 2018 14:33:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, oleg@redhat.com, gkohli@codeaurora.org
Cc: tglx@linutronix.de, mpe@ellerman.id.au, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 1/4] kthread, sched: Fix kthread_parkme() (again...)
References: <20180607123310.866085998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-kthread-0.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gaurav reports that commit:

   85f1abe0019f ("kthread, sched/wait: Fix kthread_parkme() completion issue")

isn't working for him. Because of the following race:

> controller Thread                               CPUHP Thread
> takedown_cpu
> kthread_park
> kthread_parkme
> Set KTHREAD_SHOULD_PARK
>                                                 smpboot_thread_fn
>                                                 set Task interruptible
> 
> 
> wake_up_process
>  if (!(p->state & state))
>                 goto out;
>   
>                                                 Kthread_parkme
>                                                 SET TASK_PARKED
>                                                 schedule
>                                                 raw_spin_lock(&rq->lock)
> ttwu_remote
> waiting for __task_rq_lock
>                                                 context_switch
>        
>                                                 finish_lock_switch
> 
> 
>        
>                                                 Case TASK_PARKED
>                                                 kthread_park_complete
> 
>      
> SET Running

Furthermore, Oleg noticed that the whole scheduler TASK_PARKED
handling is buggered because the TASK_DEAD thing is done with
preemption disabled, the current code can still complete early on
preemption :/

So basically revert that earlier fix and go with a variant of the
alternative mentioned in the commit. Promote TASK_PARKED to special
state to avoid the store-store issue on task->state leading to the
WARN in kthread_unpark() -> __kthread_bind().

But in addition, add wait_task_inactive() to kthread_park() to ensure
the task really is PARKED when we return from kthread_park(). This
avoids the whole kthread still gets migrated nonsense -- although it
would be really good to get this done differently.

Cc: Oleg Nesterov <oleg@redhat.com>
Reported-by: Gaurav Kohli <gkohli@codeaurora.org>
Fixes: 85f1abe0019f ("kthread, sched/wait: Fix kthread_parkme() completion issue")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/kthread.h |    1 -
 include/linux/sched.h   |    2 +-
 kernel/kthread.c        |   30 ++++++++++++++++++++++++------
 kernel/sched/core.c     |   31 +++++++++++--------------------
 4 files changed, 36 insertions(+), 28 deletions(-)

--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -62,7 +62,6 @@ void *kthread_probe_data(struct task_str
 int kthread_park(struct task_struct *k);
 void kthread_unpark(struct task_struct *k);
 void kthread_parkme(void);
-void kthread_park_complete(struct task_struct *k);
 
 int kthreadd(void *unused);
 extern struct task_struct *kthreadd_task;
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -117,7 +117,7 @@ struct task_group;
  * the comment with set_special_state().
  */
 #define is_special_task_state(state)				\
-	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_DEAD))
+	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_PARKED | TASK_DEAD))
 
 #define __set_current_state(state_value)			\
 	do {							\
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -177,9 +177,20 @@ void *kthread_probe_data(struct task_str
 static void __kthread_parkme(struct kthread *self)
 {
 	for (;;) {
-		set_current_state(TASK_PARKED);
+		/*
+		 * TASK_PARKED is a special state; we must serialize against
+		 * possible pending wakeups to avoid store-store collisions on
+		 * task->state.
+		 *
+		 * Such a collision might possibly result in the task state
+		 * changin from TASK_PARKED and us failing the
+		 * wait_task_inactive() in kthread_park().
+		 */
+		set_special_state(TASK_PARKED);
 		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
 			break;
+
+		complete_all(&self->parked);
 		schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -191,11 +202,6 @@ void kthread_parkme(void)
 }
 EXPORT_SYMBOL_GPL(kthread_parkme);
 
-void kthread_park_complete(struct task_struct *k)
-{
-	complete_all(&to_kthread(k)->parked);
-}
-
 static int kthread(void *_create)
 {
 	/* Copy data: it's on kthread's stack */
@@ -461,6 +467,9 @@ void kthread_unpark(struct task_struct *
 
 	reinit_completion(&kthread->parked);
 	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
+	/*
+	 * __kthread_parkme() will either see !SHOULD_PARK or get the wakeup.
+	 */
 	wake_up_state(k, TASK_PARKED);
 }
 EXPORT_SYMBOL_GPL(kthread_unpark);
@@ -487,7 +496,16 @@ int kthread_park(struct task_struct *k)
 	set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	if (k != current) {
 		wake_up_process(k);
+		/*
+		 * Wait for __kthread_parkme() to complete(), this means we
+		 * _will_ have TASK_PARKED and are about to call schedule().
+		 */
 		wait_for_completion(&kthread->parked);
+		/*
+		 * Now wait for that schedule() to complete and the task to
+		 * get scheduled out.
+		 */
+		WARN_ON_ONCE(!wait_task_inactive(k, TASK_PARKED));
 	}
 
 	return 0;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7,7 +7,6 @@
  */
 #include "sched.h"
 
-#include <linux/kthread.h>
 #include <linux/nospec.h>
 
 #include <asm/switch_to.h>
@@ -2701,28 +2700,20 @@ static struct rq *finish_task_switch(str
 		membarrier_mm_sync_core_before_usermode(mm);
 		mmdrop(mm);
 	}
-	if (unlikely(prev_state & (TASK_DEAD|TASK_PARKED))) {
-		switch (prev_state) {
-		case TASK_DEAD:
-			if (prev->sched_class->task_dead)
-				prev->sched_class->task_dead(prev);
-
-			/*
-			 * Remove function-return probe instances associated with this
-			 * task and put them back on the free list.
-			 */
-			kprobe_flush_task(prev);
+	if (unlikely(prev_state == TASK_DEAD)) {
+		if (prev->sched_class->task_dead)
+			prev->sched_class->task_dead(prev);
 
-			/* Task is done with its stack. */
-			put_task_stack(prev);
+		/*
+		 * Remove function-return probe instances associated with this
+		 * task and put them back on the free list.
+		 */
+		kprobe_flush_task(prev);
 
-			put_task_struct(prev);
-			break;
+		/* Task is done with its stack. */
+		put_task_stack(prev);
 
-		case TASK_PARKED:
-			kthread_park_complete(prev);
-			break;
-		}
+		put_task_struct(prev);
 	}
 
 	tick_nohz_task_switch();
