Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E40C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590DF208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590DF208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935982AbeFRJmD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:42:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55610 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935470AbeFRIWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:22:40 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 03899C93;
        Mon, 18 Jun 2018 08:22:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gaurav Kohli <gkohli@codeaurora.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 161/279] kthread, sched/wait: Fix kthread_parkme() completion issue
Date:   Mon, 18 Jun 2018 10:12:26 +0200
Message-Id: <20180618080615.492002239@linuxfoundation.org>
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

[ Upstream commit 85f1abe0019fcb3ea10df7029056cf42702283a8 ]

Even with the wait-loop fixed, there is a further issue with
kthread_parkme(). Upon hotplug, when we do takedown_cpu(),
smpboot_park_threads() can return before all those threads are in fact
blocked, due to the placement of the complete() in __kthread_parkme().

When that happens, sched_cpu_dying() -> migrate_tasks() can end up
migrating such a still runnable task onto another CPU.

Normally the task will have hit schedule() and gone to sleep by the
time we do kthread_unpark(), which will then do __kthread_bind() to
re-bind the task to the correct CPU.

However, when we loose the initial TASK_PARKED store to the concurrent
wakeup issue described previously, do the complete(), get migrated, it
is possible to either:

 - observe kthread_unpark()'s clearing of SHOULD_PARK and terminate
   the park and set TASK_RUNNING, or

 - __kthread_bind()'s wait_task_inactive() to observe the competing
   TASK_RUNNING store.

Either way the WARN() in __kthread_bind() will trigger and fail to
correctly set the CPU affinity.

Fix this by only issuing the complete() when the kthread has scheduled
out. This does away with all the icky 'still running' nonsense.

The alternative is to promote TASK_PARKED to a special state, this
guarantees wait_task_inactive() cannot observe a 'stale' TASK_RUNNING
and we'll end up doing the right thing, but this preserves the whole
icky business of potentially migating the still runnable thing.

Reported-by: Gaurav Kohli <gkohli@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/kthread.h |    1 +
 kernel/kthread.c        |   43 +++++++++++++++++++------------------------
 kernel/sched/core.c     |   32 +++++++++++++++++++++-----------
 3 files changed, 41 insertions(+), 35 deletions(-)

--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -62,6 +62,7 @@ void *kthread_probe_data(struct task_str
 int kthread_park(struct task_struct *k);
 void kthread_unpark(struct task_struct *k);
 void kthread_parkme(void);
+void kthread_park_complete(struct task_struct *k);
 
 int kthreadd(void *unused);
 extern struct task_struct *kthreadd_task;
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -55,7 +55,6 @@ enum KTHREAD_BITS {
 	KTHREAD_IS_PER_CPU = 0,
 	KTHREAD_SHOULD_STOP,
 	KTHREAD_SHOULD_PARK,
-	KTHREAD_IS_PARKED,
 };
 
 static inline void set_kthread_struct(void *kthread)
@@ -181,11 +180,8 @@ static void __kthread_parkme(struct kthr
 		set_current_state(TASK_PARKED);
 		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
 			break;
-		if (!test_and_set_bit(KTHREAD_IS_PARKED, &self->flags))
-			complete(&self->parked);
 		schedule();
 	}
-	clear_bit(KTHREAD_IS_PARKED, &self->flags);
 	__set_current_state(TASK_RUNNING);
 }
 
@@ -195,6 +191,11 @@ void kthread_parkme(void)
 }
 EXPORT_SYMBOL_GPL(kthread_parkme);
 
+void kthread_park_complete(struct task_struct *k)
+{
+	complete(&to_kthread(k)->parked);
+}
+
 static int kthread(void *_create)
 {
 	/* Copy data: it's on kthread's stack */
@@ -451,22 +452,15 @@ void kthread_unpark(struct task_struct *
 {
 	struct kthread *kthread = to_kthread(k);
 
-	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	/*
-	 * We clear the IS_PARKED bit here as we don't wait
-	 * until the task has left the park code. So if we'd
-	 * park before that happens we'd see the IS_PARKED bit
-	 * which might be about to be cleared.
+	 * Newly created kthread was parked when the CPU was offline.
+	 * The binding was lost and we need to set it again.
 	 */
-	if (test_and_clear_bit(KTHREAD_IS_PARKED, &kthread->flags)) {
-		/*
-		 * Newly created kthread was parked when the CPU was offline.
-		 * The binding was lost and we need to set it again.
-		 */
-		if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
-			__kthread_bind(k, kthread->cpu, TASK_PARKED);
-		wake_up_state(k, TASK_PARKED);
-	}
+	if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
+		__kthread_bind(k, kthread->cpu, TASK_PARKED);
+
+	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
+	wake_up_state(k, TASK_PARKED);
 }
 EXPORT_SYMBOL_GPL(kthread_unpark);
 
@@ -489,12 +483,13 @@ int kthread_park(struct task_struct *k)
 	if (WARN_ON(k->flags & PF_EXITING))
 		return -ENOSYS;
 
-	if (!test_bit(KTHREAD_IS_PARKED, &kthread->flags)) {
-		set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
-		if (k != current) {
-			wake_up_process(k);
-			wait_for_completion(&kthread->parked);
-		}
+	if (WARN_ON_ONCE(test_bit(KTHREAD_SHOULD_PARK, &kthread->flags)))
+		return -EBUSY;
+
+	set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
+	if (k != current) {
+		wake_up_process(k);
+		wait_for_completion(&kthread->parked);
 	}
 
 	return 0;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -30,6 +30,8 @@
 #include <linux/syscalls.h>
 #include <linux/sched/isolation.h>
 
+#include <linux/kthread.h>
+
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
 #ifdef CONFIG_PARAVIRT
@@ -2733,20 +2735,28 @@ static struct rq *finish_task_switch(str
 		membarrier_mm_sync_core_before_usermode(mm);
 		mmdrop(mm);
 	}
-	if (unlikely(prev_state == TASK_DEAD)) {
-		if (prev->sched_class->task_dead)
-			prev->sched_class->task_dead(prev);
+	if (unlikely(prev_state & (TASK_DEAD|TASK_PARKED))) {
+		switch (prev_state) {
+		case TASK_DEAD:
+			if (prev->sched_class->task_dead)
+				prev->sched_class->task_dead(prev);
+
+			/*
+			 * Remove function-return probe instances associated with this
+			 * task and put them back on the free list.
+			 */
+			kprobe_flush_task(prev);
 
-		/*
-		 * Remove function-return probe instances associated with this
-		 * task and put them back on the free list.
-		 */
-		kprobe_flush_task(prev);
+			/* Task is done with its stack. */
+			put_task_stack(prev);
 
-		/* Task is done with its stack. */
-		put_task_stack(prev);
+			put_task_struct(prev);
+			break;
 
-		put_task_struct(prev);
+		case TASK_PARKED:
+			kthread_park_complete(prev);
+			break;
+		}
 	}
 
 	tick_nohz_task_switch();


