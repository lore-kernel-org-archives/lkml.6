Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D75ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4F0214DD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4F0214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeJIX0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:26:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43941 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeJIX0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:26:40 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g9uZ7-0007eb-4I; Tue, 09 Oct 2018 18:08:57 +0200
Date:   Tue, 9 Oct 2018 18:08:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.18.12-rt7
Message-ID: <20181009160856.eiydl7jvglcao442@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.18.12-rt7 patch set. 

Changes since v4.18.12-rt6:

  - Let the watchdog core expire the watchdog timer hardirq context.
    Otherwise a high priority thread may not allow the watchdog to run.
    The user must still adjust the priority of "watchdogd". Reported by
    Steffen Trumtrar and Tim Sander, patched by Julia Cartwright.

  - Make kasan related lock a raw_lock_t. Patch by Clark Williams.

  - Explicitly initialize a variable in the amba-pl011 driver to avoid
    false "uninitialized" warning. Patch by Kurt Kanzenbach.

  - Export the __migrate_disabled symbol so modules (like lttng-modules)
    don't complain about a missing symbol. Reported and fix suggested by
    Jonathan Rajotte-Julien.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.18.12-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.18/incr/patch-4.18.12-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.18.12-rt7

The RT patch against v4.18.12 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.18/older/patch-4.18.12-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.18/older/patches-4.18.12-rt7.tar.xz

Sebastian

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 484861278e9c3..a658214486e76 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2211,7 +2211,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_amba_port *uap = amba_ports[co->index];
 	unsigned int old_cr = 0, new_cr;
-	unsigned long flags;
+	unsigned long flags = 0;
 	int locked = 1;
 
 	clk_enable(uap->clk);
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ffbdc4642ea55..84f75b5045f66 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -147,7 +147,7 @@ static inline void watchdog_update_worker(struct watchdog_device *wdd)
 		ktime_t t = watchdog_next_keepalive(wdd);
 
 		if (t > 0)
-			hrtimer_start(&wd_data->timer, t, HRTIMER_MODE_REL);
+			hrtimer_start(&wd_data->timer, t, HRTIMER_MODE_REL_HARD);
 	} else {
 		hrtimer_cancel(&wd_data->timer);
 	}
@@ -166,7 +166,7 @@ static int __watchdog_ping(struct watchdog_device *wdd)
 	if (ktime_after(earliest_keepalive, now)) {
 		hrtimer_start(&wd_data->timer,
 			      ktime_sub(earliest_keepalive, now),
-			      HRTIMER_MODE_REL);
+			      HRTIMER_MODE_REL_HARD);
 		return 0;
 	}
 
@@ -945,7 +945,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 		return -ENODEV;
 
 	kthread_init_work(&wd_data->work, watchdog_ping_work);
-	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	wd_data->timer.function = watchdog_timer_expired;
 
 	if (wdd->id == 0) {
@@ -992,7 +992,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 		__module_get(wdd->ops->owner);
 		kref_get(&wd_data->kref);
 		if (handle_boot_enabled)
-			hrtimer_start(&wd_data->timer, 0, HRTIMER_MODE_REL);
+			hrtimer_start(&wd_data->timer, 0, HRTIMER_MODE_REL_HARD);
 		else
 			pr_info("watchdog%d running and kernel based pre-userspace handler disabled\n",
 				wdd->id);
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index c1961761311db..ad292898f7f2b 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -85,7 +85,7 @@ enum {
 
 struct kthread_worker {
 	unsigned int		flags;
-	spinlock_t		lock;
+	raw_spinlock_t		lock;
 	struct list_head	work_list;
 	struct list_head	delayed_work_list;
 	struct task_struct	*task;
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 486dedbd9af58..c1d9ee6671c67 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -597,7 +597,7 @@ void __kthread_init_worker(struct kthread_worker *worker,
 				struct lock_class_key *key)
 {
 	memset(worker, 0, sizeof(struct kthread_worker));
-	spin_lock_init(&worker->lock);
+	raw_spin_lock_init(&worker->lock);
 	lockdep_set_class_and_name(&worker->lock, key, name);
 	INIT_LIST_HEAD(&worker->work_list);
 	INIT_LIST_HEAD(&worker->delayed_work_list);
@@ -639,21 +639,21 @@ int kthread_worker_fn(void *worker_ptr)
 
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
@@ -810,12 +810,12 @@ bool kthread_queue_work(struct kthread_worker *worker,
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
@@ -841,7 +841,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	if (WARN_ON_ONCE(!worker))
 		return;
 
-	spin_lock(&worker->lock);
+	raw_spin_lock(&worker->lock);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
@@ -850,7 +850,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 	list_del_init(&work->node);
 	kthread_insert_work(worker, work, &worker->work_list);
 
-	spin_unlock(&worker->lock);
+	raw_spin_unlock(&worker->lock);
 }
 EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
 
@@ -906,14 +906,14 @@ bool kthread_queue_delayed_work(struct kthread_worker *worker,
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
@@ -949,7 +949,7 @@ void kthread_flush_work(struct kthread_work *work)
 	if (!worker)
 		return;
 
-	spin_lock_irq(&worker->lock);
+	raw_spin_lock_irq(&worker->lock);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
@@ -961,7 +961,7 @@ void kthread_flush_work(struct kthread_work *work)
 	else
 		noop = true;
 
-	spin_unlock_irq(&worker->lock);
+	raw_spin_unlock_irq(&worker->lock);
 
 	if (!noop)
 		wait_for_completion(&fwork.done);
@@ -994,9 +994,9 @@ static bool __kthread_cancel_work(struct kthread_work *work, bool is_dwork,
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
 
@@ -1043,7 +1043,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 	unsigned long flags;
 	int ret = false;
 
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 
 	/* Do not bother with canceling when never queued. */
 	if (!work->worker)
@@ -1060,7 +1060,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 fast_queue:
 	__kthread_queue_delayed_work(worker, dwork, delay);
 out:
-	spin_unlock_irqrestore(&worker->lock, flags);
+	raw_spin_unlock_irqrestore(&worker->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
@@ -1074,7 +1074,7 @@ static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
 	if (!worker)
 		goto out;
 
-	spin_lock_irqsave(&worker->lock, flags);
+	raw_spin_lock_irqsave(&worker->lock, flags);
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
@@ -1088,13 +1088,13 @@ static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
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
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7d789c1b316b3..4739472fb72ef 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1100,6 +1100,7 @@ int __migrate_disabled(struct task_struct *p)
 {
 	return p->migrate_disable;
 }
+EXPORT_SYMBOL_GPL(__migrate_disabled);
 #endif
 
 static void __do_set_cpus_allowed_tail(struct task_struct *p,
diff --git a/localversion-rt b/localversion-rt
index 8fc605d806670..045478966e9f1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 3a8ddf8baf7dc..b209dbaefde82 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -103,7 +103,7 @@ static int quarantine_head;
 static int quarantine_tail;
 /* Total size of all objects in global_quarantine across all batches. */
 static unsigned long quarantine_size;
-static DEFINE_SPINLOCK(quarantine_lock);
+static DEFINE_RAW_SPINLOCK(quarantine_lock);
 DEFINE_STATIC_SRCU(remove_cache_srcu);
 
 /* Maximum size of the global queue. */
@@ -190,7 +190,7 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
 	if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
 		qlist_move_all(q, &temp);
 
-		spin_lock(&quarantine_lock);
+		raw_spin_lock(&quarantine_lock);
 		WRITE_ONCE(quarantine_size, quarantine_size + temp.bytes);
 		qlist_move_all(&temp, &global_quarantine[quarantine_tail]);
 		if (global_quarantine[quarantine_tail].bytes >=
@@ -203,7 +203,7 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
 			if (new_tail != quarantine_head)
 				quarantine_tail = new_tail;
 		}
-		spin_unlock(&quarantine_lock);
+		raw_spin_unlock(&quarantine_lock);
 	}
 
 	local_irq_restore(flags);
@@ -230,7 +230,7 @@ void quarantine_reduce(void)
 	 * expected case).
 	 */
 	srcu_idx = srcu_read_lock(&remove_cache_srcu);
-	spin_lock_irqsave(&quarantine_lock, flags);
+	raw_spin_lock_irqsave(&quarantine_lock, flags);
 
 	/*
 	 * Update quarantine size in case of hotplug. Allocate a fraction of
@@ -254,7 +254,7 @@ void quarantine_reduce(void)
 			quarantine_head = 0;
 	}
 
-	spin_unlock_irqrestore(&quarantine_lock, flags);
+	raw_spin_unlock_irqrestore(&quarantine_lock, flags);
 
 	qlist_free_all(&to_free, NULL);
 	srcu_read_unlock(&remove_cache_srcu, srcu_idx);
@@ -310,17 +310,17 @@ void quarantine_remove_cache(struct kmem_cache *cache)
 	 */
 	on_each_cpu(per_cpu_remove_cache, cache, 1);
 
-	spin_lock_irqsave(&quarantine_lock, flags);
+	raw_spin_lock_irqsave(&quarantine_lock, flags);
 	for (i = 0; i < QUARANTINE_BATCHES; i++) {
 		if (qlist_empty(&global_quarantine[i]))
 			continue;
 		qlist_move_cache(&global_quarantine[i], &to_free, cache);
 		/* Scanning whole quarantine can take a while. */
-		spin_unlock_irqrestore(&quarantine_lock, flags);
+		raw_spin_unlock_irqrestore(&quarantine_lock, flags);
 		cond_resched();
-		spin_lock_irqsave(&quarantine_lock, flags);
+		raw_spin_lock_irqsave(&quarantine_lock, flags);
 	}
-	spin_unlock_irqrestore(&quarantine_lock, flags);
+	raw_spin_unlock_irqrestore(&quarantine_lock, flags);
 
 	qlist_free_all(&to_free, cache);
 
