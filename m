Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932384AbeDWTK2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 15:10:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58545 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932175AbeDWTK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 15:10:26 -0400
Date: Mon, 23 Apr 2018 21:10:23 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v4.14.29-rt25
Message-ID: <20180423191023.qtinidsq4vj3lmha@linutronix.de>
References: <20180325101204.ibuvdpnusv3vutyc@linutronix.de>
 <b04275af-000d-7b29-3031-508c9a01cd91@ti.com>
 <20180420171116.w2hxytgzvp4jgpyl@linutronix.de>
 <764d0abc-7e88-a696-17a0-0bf807148d5b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <764d0abc-7e88-a696-17a0-0bf807148d5b@ti.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-23 11:57:39 [-0500], Grygorii Strashko wrote:
> Sry, but I can't apply it. What's you base?

please try this patch and latest v4.14-RT

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e305a8f8cd7d..0322503084a5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -600,6 +600,9 @@ struct task_struct {
 	int				migrate_disable_atomic;
 # endif
 #endif
+#ifdef CONFIG_PREEMPT_RT_FULL
+	int				sleeping_lock;
+#endif
 
 #ifdef CONFIG_PREEMPT_RCU
 	int				rcu_read_lock_nesting;
@@ -1757,6 +1760,23 @@ static __always_inline bool need_resched(void)
 	return unlikely(tif_need_resched());
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static inline void sleeping_lock_inc(void)
+{
+	current->sleeping_lock++;
+}
+
+static inline void sleeping_lock_dec(void)
+{
+	current->sleeping_lock--;
+}
+
+#else
+
+static inline void sleeping_lock_inc(void) { }
+static inline void sleeping_lock_dec(void) { }
+#endif
+
 /*
  * Wrappers for p->thread_info->cpu access. No-op on UP.
  */
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 0cb716ba3be0..bac3fb580af6 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1141,6 +1141,7 @@ void __sched rt_spin_lock_slowunlock(struct rt_mutex *lock)
 
 void __lockfunc rt_spin_lock(spinlock_t *lock)
 {
+	sleeping_lock_inc();
 	migrate_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
@@ -1155,6 +1156,7 @@ void __lockfunc __rt_spin_lock(struct rt_mutex *lock)
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __lockfunc rt_spin_lock_nested(spinlock_t *lock, int subclass)
 {
+	sleeping_lock_inc();
 	migrate_disable();
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
@@ -1168,6 +1170,7 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
 	spin_release(&lock->dep_map, 1, _RET_IP_);
 	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
 	migrate_enable();
+	sleeping_lock_dec();
 }
 EXPORT_SYMBOL(rt_spin_unlock);
 
@@ -1193,12 +1196,15 @@ int __lockfunc rt_spin_trylock(spinlock_t *lock)
 {
 	int ret;
 
+	sleeping_lock_inc();
 	migrate_disable();
 	ret = __rt_mutex_trylock(&lock->lock);
-	if (ret)
+	if (ret) {
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
-	else
+	} else {
 		migrate_enable();
+		sleeping_lock_dec();
+	}
 	return ret;
 }
 EXPORT_SYMBOL(rt_spin_trylock);
@@ -1210,6 +1216,7 @@ int __lockfunc rt_spin_trylock_bh(spinlock_t *lock)
 	local_bh_disable();
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
+		sleeping_lock_inc();
 		migrate_disable();
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 	} else
@@ -1225,6 +1232,7 @@ int __lockfunc rt_spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags)
 	*flags = 0;
 	ret = __rt_mutex_trylock(&lock->lock);
 	if (ret) {
+		sleeping_lock_inc();
 		migrate_disable();
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 	}
diff --git a/kernel/locking/rwlock-rt.c b/kernel/locking/rwlock-rt.c
index aebb7ce25bc6..f2e155b2c4a8 100644
--- a/kernel/locking/rwlock-rt.c
+++ b/kernel/locking/rwlock-rt.c
@@ -305,12 +305,15 @@ int __lockfunc rt_read_trylock(rwlock_t *rwlock)
 {
 	int ret;
 
+	sleeping_lock_inc();
 	migrate_disable();
 	ret = do_read_rt_trylock(rwlock);
-	if (ret)
+	if (ret) {
 		rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
-	else
+	} else {
 		migrate_enable();
+		sleeping_lock_dec();
+	}
 	return ret;
 }
 EXPORT_SYMBOL(rt_read_trylock);
@@ -319,18 +322,22 @@ int __lockfunc rt_write_trylock(rwlock_t *rwlock)
 {
 	int ret;
 
+	sleeping_lock_inc();
 	migrate_disable();
 	ret = do_write_rt_trylock(rwlock);
-	if (ret)
+	if (ret) {
 		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
-	else
+	} else {
 		migrate_enable();
+		sleeping_lock_dec();
+	}
 	return ret;
 }
 EXPORT_SYMBOL(rt_write_trylock);
 
 void __lockfunc rt_read_lock(rwlock_t *rwlock)
 {
+	sleeping_lock_inc();
 	migrate_disable();
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	do_read_rt_lock(rwlock);
@@ -339,6 +346,7 @@ EXPORT_SYMBOL(rt_read_lock);
 
 void __lockfunc rt_write_lock(rwlock_t *rwlock)
 {
+	sleeping_lock_inc();
 	migrate_disable();
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 	do_write_rt_lock(rwlock);
@@ -350,6 +358,7 @@ void __lockfunc rt_read_unlock(rwlock_t *rwlock)
 	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
 	do_read_rt_unlock(rwlock);
 	migrate_enable();
+	sleeping_lock_dec();
 }
 EXPORT_SYMBOL(rt_read_unlock);
 
@@ -358,6 +367,7 @@ void __lockfunc rt_write_unlock(rwlock_t *rwlock)
 	rwlock_release(&rwlock->dep_map, 1, _RET_IP_);
 	do_write_rt_unlock(rwlock);
 	migrate_enable();
+	sleeping_lock_dec();
 }
 EXPORT_SYMBOL(rt_write_unlock);
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3315ebad932f..c6098f60e641 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -301,13 +301,13 @@ static void rcu_preempt_note_context_switch(bool preempt)
 	struct task_struct *t = current;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
-	int mg_counter = 0;
+	int sleeping_l = 0;
 
 	RCU_LOCKDEP_WARN(!irqs_disabled(), "rcu_preempt_note_context_switch() invoked with interrupts enabled!!!\n");
-#if defined(CONFIG_PREEMPT_RT_BASE)
-	mg_counter = t->migrate_disable;
+#if defined(CONFIG_PREEMPT_RT_FULL)
+	sleeping_l = t->sleeping_lock;
 #endif
-	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0 && !mg_counter);
+	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0 && !sleeping_l);
 	if (t->rcu_read_lock_nesting > 0 &&
 	    !t->rcu_read_unlock_special.b.blocked) {
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index ce2c2d04cbaa..b59e009087a9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1870,7 +1870,9 @@ void cpu_chill(void)
 	chill_time = ktime_set(0, NSEC_PER_MSEC);
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	current->flags |= PF_NOFREEZE;
+	sleeping_lock_inc();
 	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
+	sleeping_lock_dec();
 	if (!freeze_flag)
 		current->flags &= ~PF_NOFREEZE;
 }

Sebastian
