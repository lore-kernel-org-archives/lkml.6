Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A68C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BA32184E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbfBLQ0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:26:14 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44117 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbfBLQ0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:26:12 -0500
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gtasq-0000Nw-CK; Tue, 12 Feb 2019 17:26:08 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/2] kthread: Do not use TIMER_IRQSAFE
Date:   Tue, 12 Feb 2019 17:25:54 +0100
Message-Id: <20190212162554.19779-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212162554.19779-1-bigeasy@linutronix.de>
References: <20190212162554.19779-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TIMER_IRQSAFE was introduced in commit

  22597dc3d97b1 ("kthread: initial support for delayed kthread work")

which modelled the delayed kthread code after workqueue's code. The
workqueue code requires the flag TIMER_IRQSAFE for synchronisation
purpose. This is not true for kthread's delay timer since all
operations occur under a lock.

Remove TIMER_IRQSAFE from the timer initialisation.
Use timer_setup() for initialisation purpose which is the official
function.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/kthread.h | 5 ++---
 kernel/kthread.c        | 5 +++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 6b8c064f0cbcd..3d9d834c66a25 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -164,9 +164,8 @@ extern void __kthread_init_worker(struct kthread_worker *worker,
 #define kthread_init_delayed_work(dwork, fn)				\
 	do {								\
 		kthread_init_work(&(dwork)->work, (fn));		\
-		__init_timer(&(dwork)->timer,				\
-			     kthread_delayed_work_timer_fn,		\
-			     TIMER_IRQSAFE);				\
+		timer_setup(&(dwork)->timer,				\
+			     kthread_delayed_work_timer_fn, 0);		\
 	} while (0)
 
 int kthread_worker_fn(void *worker_ptr);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5641b55783a6f..5373355412672 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -835,6 +835,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	struct kthread_delayed_work *dwork = from_timer(dwork, t, timer);
 	struct kthread_work *work = &dwork->work;
 	struct kthread_worker *worker = work->worker;
+	unsigned long flags;
 
 	/*
 	 * This might happen when a pending work is reinitialized.
@@ -843,7 +844,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	if (WARN_ON_ONCE(!worker))
 		return;
 
-	raw_spin_lock(&worker->lock);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
@@ -852,7 +853,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	list_del_init(&work->node);
 	kthread_insert_work(worker, work, &worker->work_list);
 
-	raw_spin_unlock(&worker->lock);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 }
 EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
 
-- 
2.20.1

