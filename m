Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932741AbeBUQaf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:30:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37526 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932686AbeBUQad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:30:33 -0500
Date: Wed, 21 Feb 2018 17:30:30 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Subject: [PATCH RT] net: use task_struct instead of CPU number as the queue
 owner on -RT
Message-ID: <20180221163030.467igkfyu3bxa7ew@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit ("net: move xmit_recursion to per-task variable on -RT") the
recursion level was changed to be per-task since we can get preempted in
BH on -RT. The lock owner should consequently be recorded as the task
that holds the lock and not the CPU. Otherwise we trigger the "Dead loop
on virtual device" warning on SMP systems.

Cc: stable-rt@vger.kernel.org
Reported-by: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h | 54 +++++++++++++++++++++++++++++++++++++++++------
 net/core/dev.c            |  6 +++++-
 2 files changed, 53 insertions(+), 7 deletions(-)

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
-- 
2.16.1
