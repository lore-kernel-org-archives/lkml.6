Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758154AbeD0MkU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:40:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33627 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757373AbeD0MkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:40:19 -0400
Date: Fri, 27 Apr 2018 05:40:14 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-de5b55c1d4e30740009864eb35ce4ed856aac01d@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, hpa@zytor.com
Reply-To: bigeasy@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20180423191635.6014-1-bigeasy@linutronix.de>
References: <20180423191635.6014-1-bigeasy@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] stop_machine: Use raw spinlocks
Git-Commit-ID: de5b55c1d4e30740009864eb35ce4ed856aac01d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  de5b55c1d4e30740009864eb35ce4ed856aac01d
Gitweb:     https://git.kernel.org/tip/de5b55c1d4e30740009864eb35ce4ed856aac01d
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 23 Apr 2018 21:16:35 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 27 Apr 2018 14:34:51 +0200

stop_machine: Use raw spinlocks

Use raw-locks in stop_machine() to allow locking in irq-off and
preempt-disabled regions on -RT. This also documents the possible locking
context in general.

[bigeasy: update patch description.]
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/20180423191635.6014-1-bigeasy@linutronix.de

---
 kernel/stop_machine.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index b7591261652d..c25ba18274fb 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -36,7 +36,7 @@ struct cpu_stop_done {
 struct cpu_stopper {
 	struct task_struct	*thread;
 
-	spinlock_t		lock;
+	raw_spinlock_t		lock;
 	bool			enabled;	/* is this stopper enabled? */
 	struct list_head	works;		/* list of pending works */
 
@@ -78,13 +78,13 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 	unsigned long flags;
 	bool enabled;
 
-	spin_lock_irqsave(&stopper->lock, flags);
+	raw_spin_lock_irqsave(&stopper->lock, flags);
 	enabled = stopper->enabled;
 	if (enabled)
 		__cpu_stop_queue_work(stopper, work);
 	else if (work->done)
 		cpu_stop_signal_done(work->done);
-	spin_unlock_irqrestore(&stopper->lock, flags);
+	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 
 	return enabled;
 }
@@ -231,8 +231,8 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 	struct cpu_stopper *stopper2 = per_cpu_ptr(&cpu_stopper, cpu2);
 	int err;
 retry:
-	spin_lock_irq(&stopper1->lock);
-	spin_lock_nested(&stopper2->lock, SINGLE_DEPTH_NESTING);
+	raw_spin_lock_irq(&stopper1->lock);
+	raw_spin_lock_nested(&stopper2->lock, SINGLE_DEPTH_NESTING);
 
 	err = -ENOENT;
 	if (!stopper1->enabled || !stopper2->enabled)
@@ -255,8 +255,8 @@ retry:
 	__cpu_stop_queue_work(stopper1, work1);
 	__cpu_stop_queue_work(stopper2, work2);
 unlock:
-	spin_unlock(&stopper2->lock);
-	spin_unlock_irq(&stopper1->lock);
+	raw_spin_unlock(&stopper2->lock);
+	raw_spin_unlock_irq(&stopper1->lock);
 
 	if (unlikely(err == -EDEADLK)) {
 		while (stop_cpus_in_progress)
@@ -448,9 +448,9 @@ static int cpu_stop_should_run(unsigned int cpu)
 	unsigned long flags;
 	int run;
 
-	spin_lock_irqsave(&stopper->lock, flags);
+	raw_spin_lock_irqsave(&stopper->lock, flags);
 	run = !list_empty(&stopper->works);
-	spin_unlock_irqrestore(&stopper->lock, flags);
+	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 	return run;
 }
 
@@ -461,13 +461,13 @@ static void cpu_stopper_thread(unsigned int cpu)
 
 repeat:
 	work = NULL;
-	spin_lock_irq(&stopper->lock);
+	raw_spin_lock_irq(&stopper->lock);
 	if (!list_empty(&stopper->works)) {
 		work = list_first_entry(&stopper->works,
 					struct cpu_stop_work, list);
 		list_del_init(&work->list);
 	}
-	spin_unlock_irq(&stopper->lock);
+	raw_spin_unlock_irq(&stopper->lock);
 
 	if (work) {
 		cpu_stop_fn_t fn = work->fn;
@@ -541,7 +541,7 @@ static int __init cpu_stop_init(void)
 	for_each_possible_cpu(cpu) {
 		struct cpu_stopper *stopper = &per_cpu(cpu_stopper, cpu);
 
-		spin_lock_init(&stopper->lock);
+		raw_spin_lock_init(&stopper->lock);
 		INIT_LIST_HEAD(&stopper->works);
 	}
 
