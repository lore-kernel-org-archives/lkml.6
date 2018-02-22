Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbeBVTOZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:14:25 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:39756 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVTOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:14:23 -0500
Date: Thu, 22 Feb 2018 20:14:21 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.14.20-rt17
Message-ID: <20180222191420.ifs7yt33zhhplmuk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.14.20-rt17 patch set. 

Changes since v4.14.20-rt16:

  - A RCU warning was disabled if we schedule() while we acquire a
    sleeping lock. The warning was still seen on UP only kernels and is
    now disabled. Reported by Grygorii Strashko.

  - The recording of the recursion limit in networking was changed from
    per-CPU to per-task on RT. This was done because BH-context can be
    preempted on RT and therefore multiple tasks may attempt to send a
    packet and so wrongly increase the counter.
    The queue lock owner was still recording the CPU which was holding
    the lock instead the task. This will lead to a recursion warning if
    the same transmit queue is already used (locked) by another task.
    Reported by Kurt Kanzenbach.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.14.20-rt16 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.20-rt16-rt17.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.14.20-rt17

The RT patch against v4.14.20 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.20-rt17.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patches-4.14.20-rt17.tar.xz

Sebastian

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index dea370d31dc3..cd0f34dfc5f4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -583,7 +583,11 @@ struct netdev_queue {
  * write-mostly part
  */
 	spinlock_t		_xmit_lock ____cacheline_aligned_in_smp;
+#ifdef CONFIG_PREEMPT_RT_FULL
+	struct task_struct	*xmit_lock_owner;
+#else
 	int			xmit_lock_owner;
+#endif
 	/*
 	 * Time (in jiffies) of last Tx
 	 */
@@ -3547,10 +3551,48 @@ static inline u32 netif_msg_init(int debug_value, int default_msg_enable_bits)
 	return (1 << debug_value) - 1;
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+static inline void netdev_queue_set_owner(struct netdev_queue *txq, int cpu)
+{
+	txq->xmit_lock_owner = current;
+}
+
+static inline void netdev_queue_clear_owner(struct netdev_queue *txq)
+{
+	txq->xmit_lock_owner = NULL;
+}
+
+static inline bool netdev_queue_has_owner(struct netdev_queue *txq)
+{
+	if (txq->xmit_lock_owner != NULL)
+		return true;
+	return false;
+}
+
+#else
+
+static inline void netdev_queue_set_owner(struct netdev_queue *txq, int cpu)
+{
+	txq->xmit_lock_owner = cpu;
+}
+
+static inline void netdev_queue_clear_owner(struct netdev_queue *txq)
+{
+	txq->xmit_lock_owner = -1;
+}
+
+static inline bool netdev_queue_has_owner(struct netdev_queue *txq)
+{
+	if (txq->xmit_lock_owner != -1)
+		return true;
+	return false;
+}
+#endif
+
 static inline void __netif_tx_lock(struct netdev_queue *txq, int cpu)
 {
 	spin_lock(&txq->_xmit_lock);
-	txq->xmit_lock_owner = cpu;
+	netdev_queue_set_owner(txq, cpu);
 }
 
 static inline bool __netif_tx_acquire(struct netdev_queue *txq)
@@ -3567,32 +3609,32 @@ static inline void __netif_tx_release(struct netdev_queue *txq)
 static inline void __netif_tx_lock_bh(struct netdev_queue *txq)
 {
 	spin_lock_bh(&txq->_xmit_lock);
-	txq->xmit_lock_owner = smp_processor_id();
+	netdev_queue_set_owner(txq, smp_processor_id());
 }
 
 static inline bool __netif_tx_trylock(struct netdev_queue *txq)
 {
 	bool ok = spin_trylock(&txq->_xmit_lock);
 	if (likely(ok))
-		txq->xmit_lock_owner = smp_processor_id();
+		netdev_queue_set_owner(txq, smp_processor_id());
 	return ok;
 }
 
 static inline void __netif_tx_unlock(struct netdev_queue *txq)
 {
-	txq->xmit_lock_owner = -1;
+	netdev_queue_clear_owner(txq);
 	spin_unlock(&txq->_xmit_lock);
 }
 
 static inline void __netif_tx_unlock_bh(struct netdev_queue *txq)
 {
-	txq->xmit_lock_owner = -1;
+	netdev_queue_clear_owner(txq);
 	spin_unlock_bh(&txq->_xmit_lock);
 }
 
 static inline void txq_trans_update(struct netdev_queue *txq)
 {
-	if (txq->xmit_lock_owner != -1)
+	if (netdev_queue_has_owner(txq))
 		txq->trans_start = jiffies;
 }
 
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index b0e6248c8a3c..0591df500e9d 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -231,6 +231,15 @@ extern void migrate_enable(void);
 
 int __migrate_disabled(struct task_struct *p);
 
+#elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
+
+extern void migrate_disable(void);
+extern void migrate_enable(void);
+static inline int __migrate_disabled(struct task_struct *p)
+{
+	return 0;
+}
+
 #else
 #define migrate_disable()		barrier()
 #define migrate_enable()		barrier()
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c42f64997ccd..a8909bcb26ec 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -593,6 +593,12 @@ struct task_struct {
 # ifdef CONFIG_SCHED_DEBUG
 	int				migrate_disable_atomic;
 # endif
+
+#elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
+	int				migrate_disable;
+# ifdef CONFIG_SCHED_DEBUG
+	int				migrate_disable_atomic;
+# endif
 #endif
 
 #ifdef CONFIG_PREEMPT_RCU
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 36e44ecd576e..3315ebad932f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -304,7 +304,7 @@ static void rcu_preempt_note_context_switch(bool preempt)
 	int mg_counter = 0;
 
 	RCU_LOCKDEP_WARN(!irqs_disabled(), "rcu_preempt_note_context_switch() invoked with interrupts enabled!!!\n");
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_SMP)
+#if defined(CONFIG_PREEMPT_RT_BASE)
 	mg_counter = t->migrate_disable;
 #endif
 	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0 && !mg_counter);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1ab422da7706..ea8bfeddcea0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7047,4 +7047,49 @@ void migrate_enable(void)
 	preempt_enable();
 }
 EXPORT_SYMBOL(migrate_enable);
+
+#elif !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT_RT_BASE)
+void migrate_disable(void)
+{
+	struct task_struct *p = current;
+
+	if (in_atomic() || irqs_disabled()) {
+#ifdef CONFIG_SCHED_DEBUG
+		p->migrate_disable_atomic++;
+#endif
+		return;
+	}
+#ifdef CONFIG_SCHED_DEBUG
+	if (unlikely(p->migrate_disable_atomic)) {
+		tracing_off();
+		WARN_ON_ONCE(1);
+	}
+#endif
+
+	p->migrate_disable++;
+}
+EXPORT_SYMBOL(migrate_disable);
+
+void migrate_enable(void)
+{
+	struct task_struct *p = current;
+
+	if (in_atomic() || irqs_disabled()) {
+#ifdef CONFIG_SCHED_DEBUG
+		p->migrate_disable_atomic--;
+#endif
+		return;
+	}
+
+#ifdef CONFIG_SCHED_DEBUG
+	if (unlikely(p->migrate_disable_atomic)) {
+		tracing_off();
+		WARN_ON_ONCE(1);
+	}
+#endif
+
+	WARN_ON_ONCE(p->migrate_disable <= 0);
+	p->migrate_disable--;
+}
+EXPORT_SYMBOL(migrate_enable);
 #endif
diff --git a/localversion-rt b/localversion-rt
index 1199ebade17b..1e584b47c987 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt16
+-rt17
diff --git a/net/core/dev.c b/net/core/dev.c
index cd0fdfefdd99..489906baead1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3486,7 +3486,11 @@ static int __dev_queue_xmit(struct sk_buff *skb, void *accel_priv)
 	if (dev->flags & IFF_UP) {
 		int cpu = smp_processor_id(); /* ok because BHs are off */
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+		if (txq->xmit_lock_owner != current) {
+#else
 		if (txq->xmit_lock_owner != cpu) {
+#endif
 			if (unlikely(xmit_rec_read() > XMIT_RECURSION_LIMIT))
 				goto recursion_alert;
 
@@ -7493,7 +7497,7 @@ static void netdev_init_one_queue(struct net_device *dev,
 	/* Initialize queue lock */
 	spin_lock_init(&queue->_xmit_lock);
 	netdev_set_xmit_lockdep_class(&queue->_xmit_lock, dev->type);
-	queue->xmit_lock_owner = -1;
+	netdev_queue_clear_owner(queue);
 	netdev_queue_numa_node_write(queue, NUMA_NO_NODE);
 	queue->dev = dev;
 #ifdef CONFIG_BQL
