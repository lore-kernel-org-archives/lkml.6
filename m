Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096CFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD44218FF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfAGTxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:53:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbfAGTxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:53:34 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00D3E2173C;
        Mon,  7 Jan 2019 19:53:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1ggaxn-0000Hj-Tf; Mon, 07 Jan 2019 14:53:31 -0500
Message-Id: <20190107195331.792595159@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Jan 2019 14:52:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Guenter Roeck <linux@roeck-us.net>,
        Tim Sander <tim@krieglstein.org>
Subject: [PATCH RT 02/13] kthread: convert worker lock to raw spinlock
References: <20190107195252.599921907@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.87-rt50-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Julia Cartwright <julia@ni.com>

[ Upstream commit 5c8919eed1cfcad5da452047bd4ab088837afc41 ]

In order to enable the queuing of kthread work items from hardirq
context even when PREEMPT_RT_FULL is enabled, convert the worker
spin_lock to a raw_spin_lock.

This is only acceptable to do because the work performed under the lock
is well-bounded and minimal.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Reported-and-tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Reported-by: Tim Sander <tim@krieglstein.org>
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/kthread.h |  2 +-
 kernel/kthread.c        | 42 ++++++++++++++++++++---------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 4e26609c77d4..4e0449df82c3 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -84,7 +84,7 @@ enum {
 
 struct kthread_worker {
 	unsigned int		flags;
-	spinlock_t		lock;
+	raw_spinlock_t		lock;
 	struct list_head	work_list;
 	struct list_head	delayed_work_list;
 	struct task_struct	*task;
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 4e6d85b63201..430fd79cd3fe 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -579,7 +579,7 @@ void __kthread_init_worker(struct kthread_worker *worker,
 				struct lock_class_key *key)
 {
 	memset(worker, 0, sizeof(struct kthread_worker));
-	spin_lock_init(&worker->lock);
+	raw_spin_lock_init(&worker->lock);
 	lockdep_set_class_and_name(&worker->lock, key, name);
 	INIT_LIST_HEAD(&worker->work_list);
 	INIT_LIST_HEAD(&worker->delayed_work_list);
@@ -621,21 +621,21 @@ int kthread_worker_fn(void *worker_ptr)
 
 	if (kthread_should_stop()) {
 		__set_current_state(TASK_RUNNING);
-		spin_lock_irq(&worker->lock);
+		raw_spin_lock_irq(&worker->lock);
 		worker->task = NULL;
-		spin_unlock_irq(&worker->lock);
+		raw_spin_unlock_irq(&worker->lock);
 		return 0;
 	}
 
 	work = NULL;
-	spin_lock_irq(&worker->lock);
+	raw_spin_lock_irq(&worker->lock);
 	if (!list_empty(&worker->work_list)) {
 		work = list_first_entry(&worker->work_list,
 					struct kthread_work, node);
 		list_del_init(&work->node);
 	}
 	worker->current_work = work;
-	spin_unlock_irq(&worker->lock);
+	raw_spin_unlock_irq(&worker->lock);
 
 	if (work) {
 		__set_current_state(TASK_RUNNING);
@@ -792,12 +792,12 @@ bool kthread_queue_work(struct kthread_worker *worker,
 	bool ret = false;
 	unsigned long flags;
 
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	if (!queuing_blocked(worker, work)) {
 		kthread_insert_work(worker, work, &worker->work_list);
 		ret = true;
 	}
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_queue_work);
@@ -824,7 +824,7 @@ void kthread_delayed_work_timer_fn(unsigned long __data)
 	if (WARN_ON_ONCE(!worker))
 		return;
 
-	spin_lock(&worker->lock);
+	raw_spin_lock(&worker->lock);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
@@ -833,7 +833,7 @@ void kthread_delayed_work_timer_fn(unsigned long __data)
 	list_del_init(&work->node);
 	kthread_insert_work(worker, work, &worker->work_list);
 
-	spin_unlock(&worker->lock);
+	raw_spin_unlock(&worker->lock);
 }
 EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
 
@@ -890,14 +890,14 @@ bool kthread_queue_delayed_work(struct kthread_worker *worker,
 	unsigned long flags;
 	bool ret = false;
 
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	if (!queuing_blocked(worker, work)) {
 		__kthread_queue_delayed_work(worker, dwork, delay);
 		ret = true;
 	}
 
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_queue_delayed_work);
@@ -933,7 +933,7 @@ void kthread_flush_work(struct kthread_work *work)
 	if (!worker)
 		return;
 
-	spin_lock_irq(&worker->lock);
+	raw_spin_lock_irq(&worker->lock);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
@@ -945,7 +945,7 @@ void kthread_flush_work(struct kthread_work *work)
 	else
 		noop = true;
 
-	spin_unlock_irq(&worker->lock);
+	raw_spin_unlock_irq(&worker->lock);
 
 	if (!noop)
 		wait_for_completion(&fwork.done);
@@ -978,9 +978,9 @@ static bool __kthread_cancel_work(struct kthread_work *work, bool is_dwork,
 		 * any queuing is blocked by setting the canceling counter.
 		 */
 		work->canceling++;
-		spin_unlock_irqrestore(&worker->lock, *flags);
+		raw_spin_unlock_irqrestore(&worker->lock, *flags);
 		del_timer_sync(&dwork->timer);
-		spin_lock_irqsave(&worker->lock, *flags);
+		raw_spin_lock_irqsave(&worker->lock, *flags);
 		work->canceling--;
 	}
 
@@ -1027,7 +1027,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 	unsigned long flags;
 	int ret = false;
 
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	/* Do not bother with canceling when never queued. */
 	if (!work->worker)
@@ -1044,7 +1044,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 fast_queue:
 	__kthread_queue_delayed_work(worker, dwork, delay);
 out:
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
@@ -1058,7 +1058,7 @@ static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
 	if (!worker)
 		goto out;
 
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
@@ -1072,13 +1072,13 @@ static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
 	 * In the meantime, block any queuing by setting the canceling counter.
 	 */
 	work->canceling++;
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	kthread_flush_work(work);
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	work->canceling--;
 
 out_fast:
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 out:
 	return ret;
 }
-- 
2.19.2


