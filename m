Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C99AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAFF214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0M6OBbs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAFF214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeJKGh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbeJKGh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:27 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFACD21470;
        Wed, 10 Oct 2018 23:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213185;
        bh=E0MqSHwUKx6VCpelC/GgR97vmEn76b26T/HSlEvdtAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0M6OBbs9ezuimsJYm7I02aO75jzRDlzYA+q/JRs1E7/ZmQ8Ik45ce83ZJ1vOhV/G2
         wF+U9pAXomkMgHpZg5cBhGFsbil3ylq+RWiWJVM5S3ig7GMzV5abkaCM8Hri0jJB39
         rJL9Puy8QUKEUSlS7u68JC+236hAFS6NLJcW3ZSQ=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 11/30] net: Prepare netif_tx_lock_bh/netif_tx_unlock_bh() for handling softirq mask
Date:   Thu, 11 Oct 2018 01:11:58 +0200
Message-Id: <1539213137-13953-12-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pair of function is implemented on top of spin_lock_bh() that is
going to handle a softirq mask in order to apply finegrained vector
disablement. The lock function is going to return the previous vectors
enabled mask prior to the last call to local_bh_disable(), following a
similar model to that of local_irq_save/restore. Subsequent calls to
local_bh_disable() and friends can then stack up:

	bh = local_bh_disable(vec_mask);
		bh1 = local_bh_disable(vec_mask1);
			bh2 = spin_lock_bh(vec_mask2);
				netif_tx_lock_bh(vec_mask3) {
					bh3 = spin_lock_bh(vec_mask3)
					return bh3;
				}
				...
				netif_tx_unlock_bh(bh3, ...) {
					spin_unlock_bh(bh3, ...);
				}
			spin_unlock_bh(bh2, ...);
		local_bh_enable(bh1);
	local_bh_enable(bh);

To prepare for that, make netif_tx_lock_bh() able to return a saved vector
enabled mask and pass it back to netif_tx_unlock_bh(). We'll plug it
to spin_[un]lock_bh() in a subsequent patch.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            | 42 ++++++++++++----------
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            |  5 +--
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |  9 ++---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     | 19 +++++-----
 drivers/net/ethernet/aurora/nb8800.c               |  5 +--
 drivers/net/ethernet/chelsio/cxgb4/sge.c           |  5 +--
 drivers/net/ethernet/freescale/fec_main.c          | 34 ++++++++++--------
 drivers/net/ethernet/ibm/emac/core.c               | 15 ++++----
 drivers/net/ethernet/marvell/mv643xx_eth.c         |  5 +--
 drivers/net/ethernet/marvell/skge.c                |  5 +--
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |  5 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  5 +--
 drivers/net/ethernet/nvidia/forcedeth.c            | 40 ++++++++++++---------
 drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c |  7 ++--
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c     |  7 ++--
 drivers/net/ethernet/qualcomm/qca_spi.c            | 10 +++---
 drivers/net/ethernet/sfc/falcon/selftest.c         | 10 +++---
 drivers/net/ethernet/sfc/selftest.c                | 10 +++---
 drivers/net/hamradio/6pack.c                       | 10 +++---
 drivers/net/hamradio/mkiss.c                       | 10 +++---
 drivers/net/usb/cdc_ncm.c                          | 15 ++++----
 include/linux/netdevice.h                          | 18 +++++++---
 net/atm/clip.c                                     |  5 +--
 net/sched/sch_generic.c                            |  5 +--
 24 files changed, 181 insertions(+), 120 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index 3d5424f..de6cb14 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -983,6 +983,7 @@ void ipoib_cm_dev_stop(struct net_device *dev)
 static int ipoib_cm_rep_handler(struct ib_cm_id *cm_id,
 				const struct ib_cm_event *event)
 {
+	unsigned int bh;
 	struct ipoib_cm_tx *p = cm_id->context;
 	struct ipoib_dev_priv *priv = ipoib_priv(p->dev);
 	struct ipoib_cm_data *data = event->private_data;
@@ -1027,14 +1028,14 @@ static int ipoib_cm_rep_handler(struct ib_cm_id *cm_id,
 
 	skb_queue_head_init(&skqueue);
 
-	netif_tx_lock_bh(p->dev);
+	bh = netif_tx_lock_bh(p->dev);
 	spin_lock_irq(&priv->lock);
 	set_bit(IPOIB_FLAG_OPER_UP, &p->flags);
 	if (p->neigh)
 		while ((skb = __skb_dequeue(&p->neigh->queue)))
 			__skb_queue_tail(&skqueue, skb);
 	spin_unlock_irq(&priv->lock);
-	netif_tx_unlock_bh(p->dev);
+	netif_tx_unlock_bh(p->dev, bh);
 
 	while ((skb = __skb_dequeue(&skqueue))) {
 		skb->dev = p->dev;
@@ -1201,6 +1202,7 @@ static int ipoib_cm_tx_init(struct ipoib_cm_tx *p, u32 qpn,
 
 static void ipoib_cm_tx_destroy(struct ipoib_cm_tx *p)
 {
+	unsigned int bh;
 	struct ipoib_dev_priv *priv = ipoib_priv(p->dev);
 	struct ipoib_tx_buf *tx_req;
 	unsigned long begin;
@@ -1231,14 +1233,14 @@ static void ipoib_cm_tx_destroy(struct ipoib_cm_tx *p)
 		tx_req = &p->tx_ring[p->tx_tail & (ipoib_sendq_size - 1)];
 		ipoib_dma_unmap_tx(priv, tx_req);
 		dev_kfree_skb_any(tx_req->skb);
-		netif_tx_lock_bh(p->dev);
+		bh = netif_tx_lock_bh(p->dev);
 		++p->tx_tail;
 		++priv->tx_tail;
 		if (unlikely(priv->tx_head - priv->tx_tail == ipoib_sendq_size >> 1) &&
 		    netif_queue_stopped(p->dev) &&
 		    test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags))
 			netif_wake_queue(p->dev);
-		netif_tx_unlock_bh(p->dev);
+		netif_tx_unlock_bh(p->dev, bh);
 	}
 
 	if (p->qp)
@@ -1251,6 +1253,7 @@ static void ipoib_cm_tx_destroy(struct ipoib_cm_tx *p)
 static int ipoib_cm_tx_handler(struct ib_cm_id *cm_id,
 			       const struct ib_cm_event *event)
 {
+	unsigned int bh;
 	struct ipoib_cm_tx *tx = cm_id->context;
 	struct ipoib_dev_priv *priv = ipoib_priv(tx->dev);
 	struct net_device *dev = priv->dev;
@@ -1274,7 +1277,7 @@ static int ipoib_cm_tx_handler(struct ib_cm_id *cm_id,
 	case IB_CM_REJ_RECEIVED:
 	case IB_CM_TIMEWAIT_EXIT:
 		ipoib_dbg(priv, "CM error %d.\n", event->event);
-		netif_tx_lock_bh(dev);
+		bh = netif_tx_lock_bh(dev);
 		spin_lock_irqsave(&priv->lock, flags);
 		neigh = tx->neigh;
 
@@ -1291,7 +1294,7 @@ static int ipoib_cm_tx_handler(struct ib_cm_id *cm_id,
 		}
 
 		spin_unlock_irqrestore(&priv->lock, flags);
-		netif_tx_unlock_bh(dev);
+		netif_tx_unlock_bh(dev, bh);
 		break;
 	default:
 		break;
@@ -1339,6 +1342,7 @@ void ipoib_cm_destroy_tx(struct ipoib_cm_tx *tx)
 
 static void ipoib_cm_tx_start(struct work_struct *work)
 {
+	unsigned int bh;
 	struct ipoib_dev_priv *priv = container_of(work, struct ipoib_dev_priv,
 						   cm.start_task);
 	struct net_device *dev = priv->dev;
@@ -1351,7 +1355,7 @@ static void ipoib_cm_tx_start(struct work_struct *work)
 	struct sa_path_rec pathrec;
 	u32 qpn;
 
-	netif_tx_lock_bh(dev);
+	bh = netif_tx_lock_bh(dev);
 	spin_lock_irqsave(&priv->lock, flags);
 
 	while (!list_empty(&priv->cm.start_list)) {
@@ -1374,11 +1378,11 @@ static void ipoib_cm_tx_start(struct work_struct *work)
 		memcpy(&pathrec, &p->path->pathrec, sizeof(pathrec));
 
 		spin_unlock_irqrestore(&priv->lock, flags);
-		netif_tx_unlock_bh(dev);
+		netif_tx_unlock_bh(dev, bh);
 
 		ret = ipoib_cm_tx_init(p, qpn, &pathrec);
 
-		netif_tx_lock_bh(dev);
+		bh = netif_tx_lock_bh(dev);
 		spin_lock_irqsave(&priv->lock, flags);
 
 		if (ret) {
@@ -1394,36 +1398,38 @@ static void ipoib_cm_tx_start(struct work_struct *work)
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
-	netif_tx_unlock_bh(dev);
+	netif_tx_unlock_bh(dev, bh);
 }
 
 static void ipoib_cm_tx_reap(struct work_struct *work)
 {
+	unsigned int bh;
 	struct ipoib_dev_priv *priv = container_of(work, struct ipoib_dev_priv,
 						   cm.reap_task);
 	struct net_device *dev = priv->dev;
 	struct ipoib_cm_tx *p;
 	unsigned long flags;
 
-	netif_tx_lock_bh(dev);
+	bh = netif_tx_lock_bh(dev);
 	spin_lock_irqsave(&priv->lock, flags);
 
 	while (!list_empty(&priv->cm.reap_list)) {
 		p = list_entry(priv->cm.reap_list.next, typeof(*p), list);
 		list_del_init(&p->list);
 		spin_unlock_irqrestore(&priv->lock, flags);
-		netif_tx_unlock_bh(dev);
+		netif_tx_unlock_bh(dev, bh);
 		ipoib_cm_tx_destroy(p);
-		netif_tx_lock_bh(dev);
+		bh = netif_tx_lock_bh(dev);
 		spin_lock_irqsave(&priv->lock, flags);
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
-	netif_tx_unlock_bh(dev);
+	netif_tx_unlock_bh(dev, bh);
 }
 
 static void ipoib_cm_skb_reap(struct work_struct *work)
 {
+	unsigned int bh;
 	struct ipoib_dev_priv *priv = container_of(work, struct ipoib_dev_priv,
 						   cm.skb_task);
 	struct net_device *dev = priv->dev;
@@ -1431,12 +1437,12 @@ static void ipoib_cm_skb_reap(struct work_struct *work)
 	unsigned long flags;
 	unsigned int mtu = priv->mcast_mtu;
 
-	netif_tx_lock_bh(dev);
+	bh = netif_tx_lock_bh(dev);
 	spin_lock_irqsave(&priv->lock, flags);
 
 	while ((skb = skb_dequeue(&priv->cm.skb_queue))) {
 		spin_unlock_irqrestore(&priv->lock, flags);
-		netif_tx_unlock_bh(dev);
+		netif_tx_unlock_bh(dev, bh);
 
 		if (skb->protocol == htons(ETH_P_IP))
 			icmp_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED, htonl(mtu));
@@ -1446,12 +1452,12 @@ static void ipoib_cm_skb_reap(struct work_struct *work)
 #endif
 		dev_kfree_skb_any(skb);
 
-		netif_tx_lock_bh(dev);
+		bh = netif_tx_lock_bh(dev);
 		spin_lock_irqsave(&priv->lock, flags);
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
-	netif_tx_unlock_bh(dev);
+	netif_tx_unlock_bh(dev, bh);
 }
 
 void ipoib_cm_skb_too_long(struct net_device *dev, struct sk_buff *skb,
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 9006a13..87f2a5c 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -667,12 +667,13 @@ int ipoib_send(struct net_device *dev, struct sk_buff *skb,
 
 static void __ipoib_reap_ah(struct net_device *dev)
 {
+	unsigned int bh;
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 	struct ipoib_ah *ah, *tah;
 	LIST_HEAD(remove_list);
 	unsigned long flags;
 
-	netif_tx_lock_bh(dev);
+	bh = netif_tx_lock_bh(dev);
 	spin_lock_irqsave(&priv->lock, flags);
 
 	list_for_each_entry_safe(ah, tah, &priv->dead_ahs, list)
@@ -683,7 +684,7 @@ static void __ipoib_reap_ah(struct net_device *dev)
 		}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
-	netif_tx_unlock_bh(dev);
+	netif_tx_unlock_bh(dev, bh);
 }
 
 void ipoib_reap_ah(struct work_struct *work)
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index e3d28f9..eaefa43 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -709,12 +709,13 @@ static void push_pseudo_header(struct sk_buff *skb, const char *daddr)
 
 void ipoib_flush_paths(struct net_device *dev)
 {
+	unsigned int bh;
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 	struct ipoib_path *path, *tp;
 	LIST_HEAD(remove_list);
 	unsigned long flags;
 
-	netif_tx_lock_bh(dev);
+	bh = netif_tx_lock_bh(dev);
 	spin_lock_irqsave(&priv->lock, flags);
 
 	list_splice_init(&priv->path_list, &remove_list);
@@ -726,15 +727,15 @@ void ipoib_flush_paths(struct net_device *dev)
 		if (path->query)
 			ib_sa_cancel_query(path->query_id, path->query);
 		spin_unlock_irqrestore(&priv->lock, flags);
-		netif_tx_unlock_bh(dev);
+		netif_tx_unlock_bh(dev, bh);
 		wait_for_completion(&path->done);
 		path_free(dev, path);
-		netif_tx_lock_bh(dev);
+		bh = netif_tx_lock_bh(dev);
 		spin_lock_irqsave(&priv->lock, flags);
 	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
-	netif_tx_unlock_bh(dev);
+	netif_tx_unlock_bh(dev, bh);
 }
 
 static void path_rec_completion(int status,
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index b9e9562..26a4b01 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -111,6 +111,7 @@ static void __ipoib_mcast_schedule_join_thread(struct ipoib_dev_priv *priv,
 
 static void ipoib_mcast_free(struct ipoib_mcast *mcast)
 {
+	unsigned int bh;
 	struct net_device *dev = mcast->dev;
 	int tx_dropped = 0;
 
@@ -128,9 +129,9 @@ static void ipoib_mcast_free(struct ipoib_mcast *mcast)
 		dev_kfree_skb_any(skb_dequeue(&mcast->pkt_queue));
 	}
 
-	netif_tx_lock_bh(dev);
+	bh = netif_tx_lock_bh(dev);
 	dev->stats.tx_dropped += tx_dropped;
-	netif_tx_unlock_bh(dev);
+	netif_tx_unlock_bh(dev, bh);
 
 	kfree(mcast);
 }
@@ -211,6 +212,7 @@ static int __ipoib_mcast_add(struct net_device *dev, struct ipoib_mcast *mcast)
 static int ipoib_mcast_join_finish(struct ipoib_mcast *mcast,
 				   struct ib_sa_mcmember_rec *mcmember)
 {
+	unsigned int bh;
 	struct net_device *dev = mcast->dev;
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 	struct rdma_netdev *rn = netdev_priv(dev);
@@ -304,11 +306,11 @@ static int ipoib_mcast_join_finish(struct ipoib_mcast *mcast,
 			mcast->mcmember.sl);
 
 	/* actually send any queued packets */
-	netif_tx_lock_bh(dev);
+	bh = netif_tx_lock_bh(dev);
 	while (!skb_queue_empty(&mcast->pkt_queue)) {
 		struct sk_buff *skb = skb_dequeue(&mcast->pkt_queue);
 
-		netif_tx_unlock_bh(dev);
+		netif_tx_unlock_bh(dev, bh);
 
 		skb->dev = dev;
 
@@ -316,9 +318,9 @@ static int ipoib_mcast_join_finish(struct ipoib_mcast *mcast,
 		if (ret)
 			ipoib_warn(priv, "%s:dev_queue_xmit failed to re-queue packet, ret:%d\n",
 				   __func__, ret);
-		netif_tx_lock_bh(dev);
+		bh = netif_tx_lock_bh(dev);
 	}
-	netif_tx_unlock_bh(dev);
+	netif_tx_unlock_bh(dev, bh);
 
 	return 0;
 }
@@ -367,6 +369,7 @@ void ipoib_mcast_carrier_on_task(struct work_struct *work)
 static int ipoib_mcast_join_complete(int status,
 				     struct ib_sa_multicast *multicast)
 {
+	unsigned int bh;
 	struct ipoib_mcast *mcast = multicast->context;
 	struct net_device *dev = mcast->dev;
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
@@ -435,12 +438,12 @@ static int ipoib_mcast_join_complete(int status,
 			 * is why the join thread ignores this group.
 			 */
 			mcast->backoff = 1;
-			netif_tx_lock_bh(dev);
+			bh = netif_tx_lock_bh(dev);
 			while (!skb_queue_empty(&mcast->pkt_queue)) {
 				++dev->stats.tx_dropped;
 				dev_kfree_skb_any(skb_dequeue(&mcast->pkt_queue));
 			}
-			netif_tx_unlock_bh(dev);
+			netif_tx_unlock_bh(dev, bh);
 		} else {
 			spin_lock_irq(&priv->lock);
 			/* Requeue this join task with a backoff delay */
diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
index c8d1f8f..77e116a 100644
--- a/drivers/net/ethernet/aurora/nb8800.c
+++ b/drivers/net/ethernet/aurora/nb8800.c
@@ -629,6 +629,7 @@ static void nb8800_mac_config(struct net_device *dev)
 
 static void nb8800_pause_config(struct net_device *dev)
 {
+	unsigned int bh;
 	struct nb8800_priv *priv = netdev_priv(dev);
 	struct phy_device *phydev = dev->phydev;
 	u32 rxcr;
@@ -649,11 +650,11 @@ static void nb8800_pause_config(struct net_device *dev)
 
 	if (netif_running(dev)) {
 		napi_disable(&priv->napi);
-		netif_tx_lock_bh(dev);
+		bh = netif_tx_lock_bh(dev);
 		nb8800_dma_stop(dev);
 		nb8800_modl(priv, NB8800_RXC_CR, RCR_FL, priv->pause_tx);
 		nb8800_start_rx(dev);
-		netif_tx_unlock_bh(dev);
+		netif_tx_unlock_bh(dev, bh);
 		napi_enable(&priv->napi);
 	} else {
 		nb8800_modl(priv, NB8800_RXC_CR, RCR_FL, priv->pause_tx);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 6807bc3..a9799ce 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -3829,6 +3829,7 @@ void t4_free_ofld_rxqs(struct adapter *adap, int n, struct sge_ofld_rxq *q)
  */
 void t4_free_sge_resources(struct adapter *adap)
 {
+	unsigned int bh;
 	int i;
 	struct sge_eth_rxq *eq;
 	struct sge_eth_txq *etq;
@@ -3855,9 +3856,9 @@ void t4_free_sge_resources(struct adapter *adap)
 		if (etq->q.desc) {
 			t4_eth_eq_free(adap, adap->mbox, adap->pf, 0,
 				       etq->q.cntxt_id);
-			__netif_tx_lock_bh(etq->txq);
+			bh = __netif_tx_lock_bh(etq->txq);
 			free_tx_desc(adap, &etq->q, etq->q.in_use, true);
-			__netif_tx_unlock_bh(etq->txq);
+			__netif_tx_unlock_bh(etq->txq, bh);
 			kfree(etq->q.sdesc);
 			free_txq(adap, &etq->q);
 		}
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 2708297..17cda1d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1149,6 +1149,7 @@ fec_timeout(struct net_device *ndev)
 
 static void fec_enet_timeout_work(struct work_struct *work)
 {
+	unsigned int bh;
 	struct fec_enet_private *fep =
 		container_of(work, struct fec_enet_private, tx_timeout_work);
 	struct net_device *ndev = fep->netdev;
@@ -1156,10 +1157,10 @@ static void fec_enet_timeout_work(struct work_struct *work)
 	rtnl_lock();
 	if (netif_device_present(ndev) || netif_running(ndev)) {
 		napi_disable(&fep->napi);
-		netif_tx_lock_bh(ndev);
+		bh = netif_tx_lock_bh(ndev);
 		fec_restart(ndev);
 		netif_wake_queue(ndev);
-		netif_tx_unlock_bh(ndev);
+		netif_tx_unlock_bh(ndev, bh);
 		napi_enable(&fep->napi);
 	}
 	rtnl_unlock();
@@ -1708,6 +1709,7 @@ static void fec_get_mac(struct net_device *ndev)
  */
 static void fec_enet_adjust_link(struct net_device *ndev)
 {
+	unsigned int bh;
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct phy_device *phy_dev = ndev->phydev;
 	int status_change = 0;
@@ -1744,18 +1746,18 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 		/* if any of the above changed restart the FEC */
 		if (status_change) {
 			napi_disable(&fep->napi);
-			netif_tx_lock_bh(ndev);
+			bh = netif_tx_lock_bh(ndev);
 			fec_restart(ndev);
 			netif_wake_queue(ndev);
-			netif_tx_unlock_bh(ndev);
+			netif_tx_unlock_bh(ndev, bh);
 			napi_enable(&fep->napi);
 		}
 	} else {
 		if (fep->link) {
 			napi_disable(&fep->napi);
-			netif_tx_lock_bh(ndev);
+			bh = netif_tx_lock_bh(ndev);
 			fec_stop(ndev);
-			netif_tx_unlock_bh(ndev);
+			netif_tx_unlock_bh(ndev, bh);
 			napi_enable(&fep->napi);
 			fep->link = phy_dev->link;
 			status_change = 1;
@@ -2213,6 +2215,7 @@ static void fec_enet_get_pauseparam(struct net_device *ndev,
 static int fec_enet_set_pauseparam(struct net_device *ndev,
 				   struct ethtool_pauseparam *pause)
 {
+	unsigned int bh;
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
 	if (!ndev->phydev)
@@ -2245,10 +2248,10 @@ static int fec_enet_set_pauseparam(struct net_device *ndev,
 	}
 	if (netif_running(ndev)) {
 		napi_disable(&fep->napi);
-		netif_tx_lock_bh(ndev);
+		bh = netif_tx_lock_bh(ndev);
 		fec_restart(ndev);
 		netif_wake_queue(ndev);
-		netif_tx_unlock_bh(ndev);
+		netif_tx_unlock_bh(ndev, bh);
 		napi_enable(&fep->napi);
 	}
 
@@ -3072,17 +3075,18 @@ static inline void fec_enet_set_netdev_features(struct net_device *netdev,
 static int fec_set_features(struct net_device *netdev,
 	netdev_features_t features)
 {
+	unsigned int bh;
 	struct fec_enet_private *fep = netdev_priv(netdev);
 	netdev_features_t changed = features ^ netdev->features;
 
 	if (netif_running(netdev) && changed & NETIF_F_RXCSUM) {
 		napi_disable(&fep->napi);
-		netif_tx_lock_bh(netdev);
+		bh = netif_tx_lock_bh(netdev);
 		fec_stop(netdev);
 		fec_enet_set_netdev_features(netdev, features);
 		fec_restart(netdev);
 		netif_tx_wake_all_queues(netdev);
-		netif_tx_unlock_bh(netdev);
+		netif_tx_unlock_bh(netdev, bh);
 		napi_enable(&fep->napi);
 	} else {
 		fec_enet_set_netdev_features(netdev, features);
@@ -3609,6 +3613,7 @@ fec_drv_remove(struct platform_device *pdev)
 
 static int __maybe_unused fec_suspend(struct device *dev)
 {
+	unsigned int bh;
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
@@ -3618,9 +3623,9 @@ static int __maybe_unused fec_suspend(struct device *dev)
 			fep->wol_flag |= FEC_WOL_FLAG_SLEEP_ON;
 		phy_stop(ndev->phydev);
 		napi_disable(&fep->napi);
-		netif_tx_lock_bh(ndev);
+		bh = netif_tx_lock_bh(ndev);
 		netif_device_detach(ndev);
-		netif_tx_unlock_bh(ndev);
+		netif_tx_unlock_bh(ndev, bh);
 		fec_stop(ndev);
 		fec_enet_clk_enable(ndev, false);
 		if (!(fep->wol_flag & FEC_WOL_FLAG_ENABLE))
@@ -3642,6 +3647,7 @@ static int __maybe_unused fec_suspend(struct device *dev)
 
 static int __maybe_unused fec_resume(struct device *dev)
 {
+	unsigned int bh;
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct fec_platform_data *pdata = fep->pdev->dev.platform_data;
@@ -3672,9 +3678,9 @@ static int __maybe_unused fec_resume(struct device *dev)
 			pinctrl_pm_select_default_state(&fep->pdev->dev);
 		}
 		fec_restart(ndev);
-		netif_tx_lock_bh(ndev);
+		bh = netif_tx_lock_bh(ndev);
 		netif_device_attach(ndev);
-		netif_tx_unlock_bh(ndev);
+		netif_tx_unlock_bh(ndev, bh);
 		napi_enable(&fep->napi);
 		phy_start(ndev->phydev);
 	}
diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 3726646..3f65b2c 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -296,11 +296,12 @@ static void emac_rx_disable(struct emac_instance *dev)
 
 static inline void emac_netif_stop(struct emac_instance *dev)
 {
-	netif_tx_lock_bh(dev->ndev);
+	unsigned int bh;
+	bh = netif_tx_lock_bh(dev->ndev);
 	netif_addr_lock(dev->ndev);
 	dev->no_mcast = 1;
 	netif_addr_unlock(dev->ndev);
-	netif_tx_unlock_bh(dev->ndev);
+	netif_tx_unlock_bh(dev->ndev, bh);
 	netif_trans_update(dev->ndev);	/* prevent tx timeout */
 	mal_poll_disable(dev->mal, &dev->commac);
 	netif_tx_disable(dev->ndev);
@@ -308,13 +309,14 @@ static inline void emac_netif_stop(struct emac_instance *dev)
 
 static inline void emac_netif_start(struct emac_instance *dev)
 {
-	netif_tx_lock_bh(dev->ndev);
+	unsigned int bh;
+	bh = netif_tx_lock_bh(dev->ndev);
 	netif_addr_lock(dev->ndev);
 	dev->no_mcast = 0;
 	if (dev->mcast_pending && netif_running(dev->ndev))
 		__emac_set_multicast_list(dev);
 	netif_addr_unlock(dev->ndev);
-	netif_tx_unlock_bh(dev->ndev);
+	netif_tx_unlock_bh(dev->ndev, bh);
 
 	netif_wake_queue(dev->ndev);
 
@@ -1607,6 +1609,7 @@ static void emac_parse_tx_error(struct emac_instance *dev, u16 ctrl)
 
 static void emac_poll_tx(void *param)
 {
+	unsigned int bh;
 	struct emac_instance *dev = param;
 	u32 bad_mask;
 
@@ -1617,7 +1620,7 @@ static void emac_poll_tx(void *param)
 	else
 		bad_mask = EMAC_IS_BAD_TX;
 
-	netif_tx_lock_bh(dev->ndev);
+	bh = netif_tx_lock_bh(dev->ndev);
 	if (dev->tx_cnt) {
 		u16 ctrl;
 		int slot = dev->ack_slot, n = 0;
@@ -1648,7 +1651,7 @@ static void emac_poll_tx(void *param)
 			DBG2(dev, "tx %d pkts" NL, n);
 		}
 	}
-	netif_tx_unlock_bh(dev->ndev);
+	netif_tx_unlock_bh(dev->ndev, bh);
 }
 
 static inline void emac_recycle_rx_skb(struct emac_instance *dev, int slot,
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 62f204f..56c74c2 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -1071,11 +1071,12 @@ static void txq_kick(struct tx_queue *txq)
 
 static int txq_reclaim(struct tx_queue *txq, int budget, int force)
 {
+	unsigned int bh;
 	struct mv643xx_eth_private *mp = txq_to_mp(txq);
 	struct netdev_queue *nq = netdev_get_tx_queue(mp->dev, txq->index);
 	int reclaimed;
 
-	__netif_tx_lock_bh(nq);
+	bh = __netif_tx_lock_bh(nq);
 
 	reclaimed = 0;
 	while (reclaimed < budget && txq->tx_desc_count > 0) {
@@ -1131,7 +1132,7 @@ static int txq_reclaim(struct tx_queue *txq, int budget, int force)
 
 	}
 
-	__netif_tx_unlock_bh(nq);
+	__netif_tx_unlock_bh(nq, bh);
 
 	if (reclaimed < budget)
 		mp->work_tx &= ~(1 << txq->index);
diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index 9c08c36..506087a 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -2653,6 +2653,7 @@ static void skge_rx_stop(struct skge_hw *hw, int port)
 
 static int skge_down(struct net_device *dev)
 {
+	unsigned int bh;
 	struct skge_port *skge = netdev_priv(dev);
 	struct skge_hw *hw = skge->hw;
 	int port = skge->port;
@@ -2718,9 +2719,9 @@ static int skge_down(struct net_device *dev)
 
 	skge_led(skge, LED_MODE_OFF);
 
-	netif_tx_lock_bh(dev);
+	bh = netif_tx_lock_bh(dev);
 	skge_tx_clean(dev);
-	netif_tx_unlock_bh(dev);
+	netif_tx_unlock_bh(dev, bh);
 
 	skge_rx_clean(skge);
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 6785661..666708a 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -1878,6 +1878,7 @@ int mlx4_en_start_port(struct net_device *dev)
 
 void mlx4_en_stop_port(struct net_device *dev, int detach)
 {
+	unsigned int bh;
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	struct mlx4_en_dev *mdev = priv->mdev;
 	struct mlx4_en_mc_list *mclist, *tmp;
@@ -1894,11 +1895,11 @@ void mlx4_en_stop_port(struct net_device *dev, int detach)
 	mlx4_CLOSE_PORT(mdev->dev, priv->port);
 
 	/* Synchronize with tx routine */
-	netif_tx_lock_bh(dev);
+	bh = netif_tx_lock_bh(dev);
 	if (detach)
 		netif_device_detach(dev);
 	netif_tx_stop_all_queues(dev);
-	netif_tx_unlock_bh(dev);
+	netif_tx_unlock_bh(dev, bh);
 
 	netif_tx_disable(dev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5a7939e..6d66d1c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1349,9 +1349,10 @@ static void mlx5e_activate_txqsq(struct mlx5e_txqsq *sq)
 
 static inline void netif_tx_disable_queue(struct netdev_queue *txq)
 {
-	__netif_tx_lock_bh(txq);
+	unsigned int bh;
+	bh = __netif_tx_lock_bh(txq);
 	netif_tx_stop_queue(txq);
-	__netif_tx_unlock_bh(txq);
+	__netif_tx_unlock_bh(txq, bh);
 }
 
 static void mlx5e_deactivate_txqsq(struct mlx5e_txqsq *sq)
diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index 1d9b0d4..7b5ac16 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -3028,6 +3028,7 @@ static void set_bufsize(struct net_device *dev)
  */
 static int nv_change_mtu(struct net_device *dev, int new_mtu)
 {
+	unsigned int bh;
 	struct fe_priv *np = netdev_priv(dev);
 	int old_mtu;
 
@@ -3049,7 +3050,7 @@ static int nv_change_mtu(struct net_device *dev, int new_mtu)
 		 */
 		nv_disable_irq(dev);
 		nv_napi_disable(dev);
-		netif_tx_lock_bh(dev);
+		bh = netif_tx_lock_bh(dev);
 		netif_addr_lock(dev);
 		spin_lock(&np->lock);
 		/* stop engines */
@@ -3076,7 +3077,7 @@ static int nv_change_mtu(struct net_device *dev, int new_mtu)
 		nv_start_rxtx(dev);
 		spin_unlock(&np->lock);
 		netif_addr_unlock(dev);
-		netif_tx_unlock_bh(dev);
+		netif_tx_unlock_bh(dev, bh);
 		nv_napi_enable(dev);
 		nv_enable_irq(dev);
 	}
@@ -3102,6 +3103,7 @@ static void nv_copy_mac_to_hw(struct net_device *dev)
  */
 static int nv_set_mac_address(struct net_device *dev, void *addr)
 {
+	unsigned int bh;
 	struct fe_priv *np = netdev_priv(dev);
 	struct sockaddr *macaddr = (struct sockaddr *)addr;
 
@@ -3112,7 +3114,7 @@ static int nv_set_mac_address(struct net_device *dev, void *addr)
 	memcpy(dev->dev_addr, macaddr->sa_data, ETH_ALEN);
 
 	if (netif_running(dev)) {
-		netif_tx_lock_bh(dev);
+		bh = netif_tx_lock_bh(dev);
 		netif_addr_lock(dev);
 		spin_lock_irq(&np->lock);
 
@@ -3126,7 +3128,7 @@ static int nv_set_mac_address(struct net_device *dev, void *addr)
 		nv_start_rx(dev);
 		spin_unlock_irq(&np->lock);
 		netif_addr_unlock(dev);
-		netif_tx_unlock_bh(dev);
+		netif_tx_unlock_bh(dev, bh);
 	} else {
 		nv_copy_mac_to_hw(dev);
 	}
@@ -4088,6 +4090,7 @@ static void nv_free_irq(struct net_device *dev)
 
 static void nv_do_nic_poll(struct timer_list *t)
 {
+	unsigned int bh;
 	struct fe_priv *np = from_timer(np, t, nic_poll);
 	struct net_device *dev = np->dev;
 	u8 __iomem *base = get_hwbase(dev);
@@ -4129,7 +4132,7 @@ static void nv_do_nic_poll(struct timer_list *t)
 		np->recover_error = 0;
 		netdev_info(dev, "MAC in recoverable error state\n");
 		if (netif_running(dev)) {
-			netif_tx_lock_bh(dev);
+			bh = netif_tx_lock_bh(dev);
 			netif_addr_lock(dev);
 			spin_lock(&np->lock);
 			/* stop engines */
@@ -4163,7 +4166,7 @@ static void nv_do_nic_poll(struct timer_list *t)
 			nv_start_rxtx(dev);
 			spin_unlock(&np->lock);
 			netif_addr_unlock(dev);
-			netif_tx_unlock_bh(dev);
+			netif_tx_unlock_bh(dev, bh);
 		}
 	}
 
@@ -4346,6 +4349,7 @@ static int nv_get_link_ksettings(struct net_device *dev,
 static int nv_set_link_ksettings(struct net_device *dev,
 				 const struct ethtool_link_ksettings *cmd)
 {
+	unsigned int bh;
 	struct fe_priv *np = netdev_priv(dev);
 	u32 speed = cmd->base.speed;
 	u32 advertising;
@@ -4389,7 +4393,7 @@ static int nv_set_link_ksettings(struct net_device *dev,
 		unsigned long flags;
 
 		nv_disable_irq(dev);
-		netif_tx_lock_bh(dev);
+		bh = netif_tx_lock_bh(dev);
 		netif_addr_lock(dev);
 		/* with plain spinlock lockdep complains */
 		spin_lock_irqsave(&np->lock, flags);
@@ -4405,7 +4409,7 @@ static int nv_set_link_ksettings(struct net_device *dev,
 		nv_stop_rxtx(dev);
 		spin_unlock_irqrestore(&np->lock, flags);
 		netif_addr_unlock(dev);
-		netif_tx_unlock_bh(dev);
+		netif_tx_unlock_bh(dev, bh);
 	}
 
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
@@ -4540,6 +4544,7 @@ static void nv_get_regs(struct net_device *dev, struct ethtool_regs *regs, void
 
 static int nv_nway_reset(struct net_device *dev)
 {
+	unsigned int bh;
 	struct fe_priv *np = netdev_priv(dev);
 	int ret;
 
@@ -4549,14 +4554,14 @@ static int nv_nway_reset(struct net_device *dev)
 		netif_carrier_off(dev);
 		if (netif_running(dev)) {
 			nv_disable_irq(dev);
-			netif_tx_lock_bh(dev);
+			bh = netif_tx_lock_bh(dev);
 			netif_addr_lock(dev);
 			spin_lock(&np->lock);
 			/* stop engines */
 			nv_stop_rxtx(dev);
 			spin_unlock(&np->lock);
 			netif_addr_unlock(dev);
-			netif_tx_unlock_bh(dev);
+			netif_tx_unlock_bh(dev, bh);
 			netdev_info(dev, "link down\n");
 		}
 
@@ -4598,6 +4603,7 @@ static void nv_get_ringparam(struct net_device *dev, struct ethtool_ringparam* r
 
 static int nv_set_ringparam(struct net_device *dev, struct ethtool_ringparam* ring)
 {
+	unsigned int bh;
 	struct fe_priv *np = netdev_priv(dev);
 	u8 __iomem *base = get_hwbase(dev);
 	u8 *rxtx_ring, *rx_skbuff, *tx_skbuff;
@@ -4660,7 +4666,7 @@ static int nv_set_ringparam(struct net_device *dev, struct ethtool_ringparam* ri
 	if (netif_running(dev)) {
 		nv_disable_irq(dev);
 		nv_napi_disable(dev);
-		netif_tx_lock_bh(dev);
+		bh = netif_tx_lock_bh(dev);
 		netif_addr_lock(dev);
 		spin_lock(&np->lock);
 		/* stop engines */
@@ -4711,7 +4717,7 @@ static int nv_set_ringparam(struct net_device *dev, struct ethtool_ringparam* ri
 		nv_start_rxtx(dev);
 		spin_unlock(&np->lock);
 		netif_addr_unlock(dev);
-		netif_tx_unlock_bh(dev);
+		netif_tx_unlock_bh(dev, bh);
 		nv_napi_enable(dev);
 		nv_enable_irq(dev);
 	}
@@ -4731,6 +4737,7 @@ static void nv_get_pauseparam(struct net_device *dev, struct ethtool_pauseparam*
 
 static int nv_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam* pause)
 {
+	unsigned int bh;
 	struct fe_priv *np = netdev_priv(dev);
 	int adv, bmcr;
 
@@ -4747,14 +4754,14 @@ static int nv_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam*
 	netif_carrier_off(dev);
 	if (netif_running(dev)) {
 		nv_disable_irq(dev);
-		netif_tx_lock_bh(dev);
+		bh = netif_tx_lock_bh(dev);
 		netif_addr_lock(dev);
 		spin_lock(&np->lock);
 		/* stop engines */
 		nv_stop_rxtx(dev);
 		spin_unlock(&np->lock);
 		netif_addr_unlock(dev);
-		netif_tx_unlock_bh(dev);
+		netif_tx_unlock_bh(dev, bh);
 	}
 
 	np->pause_flags &= ~(NV_PAUSEFRAME_RX_REQ|NV_PAUSEFRAME_TX_REQ);
@@ -5190,6 +5197,7 @@ static int nv_loopback_test(struct net_device *dev)
 
 static void nv_self_test(struct net_device *dev, struct ethtool_test *test, u64 *buffer)
 {
+	unsigned int bh;
 	struct fe_priv *np = netdev_priv(dev);
 	u8 __iomem *base = get_hwbase(dev);
 	int result, count;
@@ -5206,7 +5214,7 @@ static void nv_self_test(struct net_device *dev, struct ethtool_test *test, u64
 		if (netif_running(dev)) {
 			netif_stop_queue(dev);
 			nv_napi_disable(dev);
-			netif_tx_lock_bh(dev);
+			bh = netif_tx_lock_bh(dev);
 			netif_addr_lock(dev);
 			spin_lock_irq(&np->lock);
 			nv_disable_hw_interrupts(dev, np->irqmask);
@@ -5221,7 +5229,7 @@ static void nv_self_test(struct net_device *dev, struct ethtool_test *test, u64
 			nv_drain_rxtx(dev);
 			spin_unlock_irq(&np->lock);
 			netif_addr_unlock(dev);
-			netif_tx_unlock_bh(dev);
+			netif_tx_unlock_bh(dev, bh);
 		}
 
 		if (!nv_register_test(dev)) {
diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
index 52ad806..b39e0e81 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
@@ -566,6 +566,7 @@ static int
 netxen_send_cmd_descs(struct netxen_adapter *adapter,
 		struct cmd_desc_type0 *cmd_desc_arr, int nr_desc)
 {
+	unsigned int bh;
 	u32 i, producer;
 	struct netxen_cmd_buffer *pbuf;
 	struct nx_host_tx_ring *tx_ring;
@@ -576,7 +577,7 @@ netxen_send_cmd_descs(struct netxen_adapter *adapter,
 		return -EIO;
 
 	tx_ring = adapter->tx_ring;
-	__netif_tx_lock_bh(tx_ring->txq);
+	bh = __netif_tx_lock_bh(tx_ring->txq);
 
 	producer = tx_ring->producer;
 
@@ -587,7 +588,7 @@ netxen_send_cmd_descs(struct netxen_adapter *adapter,
 			if (netxen_tx_avail(tx_ring) > TX_STOP_THRESH)
 				netif_tx_wake_queue(tx_ring->txq);
 		} else {
-			__netif_tx_unlock_bh(tx_ring->txq);
+			__netif_tx_unlock_bh(tx_ring->txq, bh);
 			return -EBUSY;
 		}
 	}
@@ -609,7 +610,7 @@ netxen_send_cmd_descs(struct netxen_adapter *adapter,
 
 	netxen_nic_update_cmd_producer(adapter, tx_ring);
 
-	__netif_tx_unlock_bh(tx_ring->txq);
+	__netif_tx_unlock_bh(tx_ring->txq, bh);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
index 822aa39..3991ad0 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
@@ -382,6 +382,7 @@ static int
 qlcnic_send_cmd_descs(struct qlcnic_adapter *adapter,
 		struct cmd_desc_type0 *cmd_desc_arr, int nr_desc)
 {
+	unsigned int bh;
 	u32 i, producer;
 	struct qlcnic_cmd_buffer *pbuf;
 	struct cmd_desc_type0 *cmd_desc;
@@ -393,7 +394,7 @@ qlcnic_send_cmd_descs(struct qlcnic_adapter *adapter,
 		return -EIO;
 
 	tx_ring = &adapter->tx_ring[0];
-	__netif_tx_lock_bh(tx_ring->txq);
+	bh = __netif_tx_lock_bh(tx_ring->txq);
 
 	producer = tx_ring->producer;
 
@@ -405,7 +406,7 @@ qlcnic_send_cmd_descs(struct qlcnic_adapter *adapter,
 				netif_tx_wake_queue(tx_ring->txq);
 		} else {
 			adapter->stats.xmit_off++;
-			__netif_tx_unlock_bh(tx_ring->txq);
+			__netif_tx_unlock_bh(tx_ring->txq, bh);
 			return -EBUSY;
 		}
 	}
@@ -429,7 +430,7 @@ qlcnic_send_cmd_descs(struct qlcnic_adapter *adapter,
 
 	qlcnic_update_cmd_producer(tx_ring);
 
-	__netif_tx_unlock_bh(tx_ring->txq);
+	__netif_tx_unlock_bh(tx_ring->txq, bh);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 66b775d..31dbd19 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -272,6 +272,7 @@ qcaspi_tx_frame(struct qcaspi *qca, struct sk_buff *skb)
 static int
 qcaspi_transmit(struct qcaspi *qca)
 {
+	unsigned int bh;
 	struct net_device_stats *n_stats = &qca->net_dev->stats;
 	u16 available = 0;
 	u32 pkt_len;
@@ -306,7 +307,7 @@ qcaspi_transmit(struct qcaspi *qca)
 		/* XXX After inconsistent lock states netif_tx_lock()
 		 * has been replaced by netif_tx_lock_bh() and so on.
 		 */
-		netif_tx_lock_bh(qca->net_dev);
+		bh = netif_tx_lock_bh(qca->net_dev);
 		dev_kfree_skb(qca->txr.skb[qca->txr.head]);
 		qca->txr.skb[qca->txr.head] = NULL;
 		qca->txr.size -= pkt_len;
@@ -316,7 +317,7 @@ qcaspi_transmit(struct qcaspi *qca)
 		qca->txr.head = new_head;
 		if (netif_queue_stopped(qca->net_dev))
 			netif_wake_queue(qca->net_dev);
-		netif_tx_unlock_bh(qca->net_dev);
+		netif_tx_unlock_bh(qca->net_dev, bh);
 	}
 
 	return 0;
@@ -450,12 +451,13 @@ qcaspi_tx_ring_has_space(struct tx_ring *txr)
 static void
 qcaspi_flush_tx_ring(struct qcaspi *qca)
 {
+	unsigned int bh;
 	int i;
 
 	/* XXX After inconsistent lock states netif_tx_lock()
 	 * has been replaced by netif_tx_lock_bh() and so on.
 	 */
-	netif_tx_lock_bh(qca->net_dev);
+	bh = netif_tx_lock_bh(qca->net_dev);
 	for (i = 0; i < TX_RING_MAX_LEN; i++) {
 		if (qca->txr.skb[i]) {
 			dev_kfree_skb(qca->txr.skb[i]);
@@ -466,7 +468,7 @@ qcaspi_flush_tx_ring(struct qcaspi *qca)
 	qca->txr.tail = 0;
 	qca->txr.head = 0;
 	qca->txr.size = 0;
-	netif_tx_unlock_bh(qca->net_dev);
+	netif_tx_unlock_bh(qca->net_dev, bh);
 }
 
 static void
diff --git a/drivers/net/ethernet/sfc/falcon/selftest.c b/drivers/net/ethernet/sfc/falcon/selftest.c
index 55c0fbb..ab223e6 100644
--- a/drivers/net/ethernet/sfc/falcon/selftest.c
+++ b/drivers/net/ethernet/sfc/falcon/selftest.c
@@ -412,6 +412,7 @@ static void ef4_iterate_state(struct ef4_nic *efx)
 
 static int ef4_begin_loopback(struct ef4_tx_queue *tx_queue)
 {
+	unsigned int bh;
 	struct ef4_nic *efx = tx_queue->efx;
 	struct ef4_loopback_state *state = efx->loopback_selftest;
 	struct ef4_loopback_payload *payload;
@@ -439,9 +440,9 @@ static int ef4_begin_loopback(struct ef4_tx_queue *tx_queue)
 		 * interrupt handler. */
 		smp_wmb();
 
-		netif_tx_lock_bh(efx->net_dev);
+		bh = netif_tx_lock_bh(efx->net_dev);
 		rc = ef4_enqueue_skb(tx_queue, skb);
-		netif_tx_unlock_bh(efx->net_dev);
+		netif_tx_unlock_bh(efx->net_dev, bh);
 
 		if (rc != NETDEV_TX_OK) {
 			netif_err(efx, drv, efx->net_dev,
@@ -469,13 +470,14 @@ static int ef4_poll_loopback(struct ef4_nic *efx)
 static int ef4_end_loopback(struct ef4_tx_queue *tx_queue,
 			    struct ef4_loopback_self_tests *lb_tests)
 {
+	unsigned int bh;
 	struct ef4_nic *efx = tx_queue->efx;
 	struct ef4_loopback_state *state = efx->loopback_selftest;
 	struct sk_buff *skb;
 	int tx_done = 0, rx_good, rx_bad;
 	int i, rc = 0;
 
-	netif_tx_lock_bh(efx->net_dev);
+	bh = netif_tx_lock_bh(efx->net_dev);
 
 	/* Count the number of tx completions, and decrement the refcnt. Any
 	 * skbs not already completed will be free'd when the queue is flushed */
@@ -486,7 +488,7 @@ static int ef4_end_loopback(struct ef4_tx_queue *tx_queue,
 		dev_kfree_skb(skb);
 	}
 
-	netif_tx_unlock_bh(efx->net_dev);
+	netif_tx_unlock_bh(efx->net_dev, bh);
 
 	/* Check TX completion and received packet counts */
 	rx_good = atomic_read(&state->rx_good);
diff --git a/drivers/net/ethernet/sfc/selftest.c b/drivers/net/ethernet/sfc/selftest.c
index f693694..59e4d35 100644
--- a/drivers/net/ethernet/sfc/selftest.c
+++ b/drivers/net/ethernet/sfc/selftest.c
@@ -412,6 +412,7 @@ static void efx_iterate_state(struct efx_nic *efx)
 
 static int efx_begin_loopback(struct efx_tx_queue *tx_queue)
 {
+	unsigned int bh;
 	struct efx_nic *efx = tx_queue->efx;
 	struct efx_loopback_state *state = efx->loopback_selftest;
 	struct efx_loopback_payload *payload;
@@ -439,9 +440,9 @@ static int efx_begin_loopback(struct efx_tx_queue *tx_queue)
 		 * interrupt handler. */
 		smp_wmb();
 
-		netif_tx_lock_bh(efx->net_dev);
+		bh = netif_tx_lock_bh(efx->net_dev);
 		rc = efx_enqueue_skb(tx_queue, skb);
-		netif_tx_unlock_bh(efx->net_dev);
+		netif_tx_unlock_bh(efx->net_dev, bh);
 
 		if (rc != NETDEV_TX_OK) {
 			netif_err(efx, drv, efx->net_dev,
@@ -469,13 +470,14 @@ static int efx_poll_loopback(struct efx_nic *efx)
 static int efx_end_loopback(struct efx_tx_queue *tx_queue,
 			    struct efx_loopback_self_tests *lb_tests)
 {
+	unsigned int bh;
 	struct efx_nic *efx = tx_queue->efx;
 	struct efx_loopback_state *state = efx->loopback_selftest;
 	struct sk_buff *skb;
 	int tx_done = 0, rx_good, rx_bad;
 	int i, rc = 0;
 
-	netif_tx_lock_bh(efx->net_dev);
+	bh = netif_tx_lock_bh(efx->net_dev);
 
 	/* Count the number of tx completions, and decrement the refcnt. Any
 	 * skbs not already completed will be free'd when the queue is flushed */
@@ -486,7 +488,7 @@ static int efx_end_loopback(struct efx_tx_queue *tx_queue,
 		dev_kfree_skb(skb);
 	}
 
-	netif_tx_unlock_bh(efx->net_dev);
+	netif_tx_unlock_bh(efx->net_dev, bh);
 
 	/* Check TX completion and received packet counts */
 	rx_good = atomic_read(&state->rx_good);
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index d79a69d..efc5c22 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -289,13 +289,14 @@ static int sp_close(struct net_device *dev)
 
 static int sp_set_mac_address(struct net_device *dev, void *addr)
 {
+	unsigned int bh;
 	struct sockaddr_ax25 *sa = addr;
 
-	netif_tx_lock_bh(dev);
+	bh = netif_tx_lock_bh(dev);
 	netif_addr_lock(dev);
 	memcpy(dev->dev_addr, &sa->sax25_call, AX25_ADDR_LEN);
 	netif_addr_unlock(dev);
-	netif_tx_unlock_bh(dev);
+	netif_tx_unlock_bh(dev, bh);
 
 	return 0;
 }
@@ -693,6 +694,7 @@ static void sixpack_close(struct tty_struct *tty)
 static int sixpack_ioctl(struct tty_struct *tty, struct file *file,
 	unsigned int cmd, unsigned long arg)
 {
+	unsigned int bh;
 	struct sixpack *sp = sp_get(tty);
 	struct net_device *dev;
 	unsigned int tmp, err;
@@ -735,9 +737,9 @@ static int sixpack_ioctl(struct tty_struct *tty, struct file *file,
 				break;
 			}
 
-			netif_tx_lock_bh(dev);
+			bh = netif_tx_lock_bh(dev);
 			memcpy(dev->dev_addr, &addr, AX25_ADDR_LEN);
-			netif_tx_unlock_bh(dev);
+			netif_tx_unlock_bh(dev, bh);
 
 			err = 0;
 			break;
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 13e4c1e..3397dda 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -350,13 +350,14 @@ static void kiss_unesc(struct mkiss *ax, unsigned char s)
 
 static int ax_set_mac_address(struct net_device *dev, void *addr)
 {
+	unsigned int bh;
 	struct sockaddr_ax25 *sa = addr;
 
-	netif_tx_lock_bh(dev);
+	bh = netif_tx_lock_bh(dev);
 	netif_addr_lock(dev);
 	memcpy(dev->dev_addr, &sa->sax25_call, AX25_ADDR_LEN);
 	netif_addr_unlock(dev);
-	netif_tx_unlock_bh(dev);
+	netif_tx_unlock_bh(dev, bh);
 
 	return 0;
 }
@@ -816,6 +817,7 @@ static void mkiss_close(struct tty_struct *tty)
 static int mkiss_ioctl(struct tty_struct *tty, struct file *file,
 	unsigned int cmd, unsigned long arg)
 {
+	unsigned int bh;
 	struct mkiss *ax = mkiss_get(tty);
 	struct net_device *dev;
 	unsigned int tmp, err;
@@ -859,9 +861,9 @@ static int mkiss_ioctl(struct tty_struct *tty, struct file *file,
 			break;
 		}
 
-		netif_tx_lock_bh(dev);
+		bh = netif_tx_lock_bh(dev);
 		memcpy(dev->dev_addr, addr, AX25_ADDR_LEN);
-		netif_tx_unlock_bh(dev);
+		netif_tx_unlock_bh(dev, bh);
 
 		err = 0;
 		break;
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 1eaec64..b4b8a61 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -296,6 +296,7 @@ static ssize_t ndp_to_end_show(struct device *d, struct device_attribute *attr,
 
 static ssize_t ndp_to_end_store(struct device *d,  struct device_attribute *attr, const char *buf, size_t len)
 {
+	unsigned int bh;
 	struct usbnet *dev = netdev_priv(to_net_dev(d));
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
 	bool enable;
@@ -314,7 +315,7 @@ static ssize_t ndp_to_end_store(struct device *d,  struct device_attribute *attr
 	}
 
 	/* flush pending data before changing flag */
-	netif_tx_lock_bh(dev->net);
+	bh = netif_tx_lock_bh(dev->net);
 	usbnet_start_xmit(NULL, dev->net);
 	spin_lock_bh(&ctx->mtx);
 	if (enable)
@@ -322,7 +323,7 @@ static ssize_t ndp_to_end_store(struct device *d,  struct device_attribute *attr
 	else
 		ctx->drvflags &= ~CDC_NCM_FLAG_NDP_TO_END;
 	spin_unlock_bh(&ctx->mtx);
-	netif_tx_unlock_bh(dev->net);
+	netif_tx_unlock_bh(dev->net, bh);
 
 	return len;
 }
@@ -375,6 +376,7 @@ static const struct attribute_group cdc_ncm_sysfs_attr_group = {
 /* handle rx_max and tx_max changes */
 static void cdc_ncm_update_rxtx_max(struct usbnet *dev, u32 new_rx, u32 new_tx)
 {
+	unsigned int bh;
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
 	u8 iface_no = ctx->control->cur_altsetting->desc.bInterfaceNumber;
 	u32 val;
@@ -421,7 +423,7 @@ static void cdc_ncm_update_rxtx_max(struct usbnet *dev, u32 new_rx, u32 new_tx)
 
 	/* we might need to flush any pending tx buffers if running */
 	if (netif_running(dev->net) && val > ctx->tx_max) {
-		netif_tx_lock_bh(dev->net);
+		bh = netif_tx_lock_bh(dev->net);
 		usbnet_start_xmit(NULL, dev->net);
 		/* make sure tx_curr_skb is reallocated if it was empty */
 		if (ctx->tx_curr_skb) {
@@ -429,7 +431,7 @@ static void cdc_ncm_update_rxtx_max(struct usbnet *dev, u32 new_rx, u32 new_tx)
 			ctx->tx_curr_skb = NULL;
 		}
 		ctx->tx_max = val;
-		netif_tx_unlock_bh(dev->net);
+		netif_tx_unlock_bh(dev->net, bh);
 	} else {
 		ctx->tx_max = val;
 	}
@@ -1359,6 +1361,7 @@ static enum hrtimer_restart cdc_ncm_tx_timer_cb(struct hrtimer *timer)
 
 static void cdc_ncm_txpath_bh(unsigned long param)
 {
+	unsigned int bh;
 	struct usbnet *dev = (struct usbnet *)param;
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
 
@@ -1370,9 +1373,9 @@ static void cdc_ncm_txpath_bh(unsigned long param)
 	} else if (dev->net != NULL) {
 		ctx->tx_reason_timeout++;	/* count reason for transmitting */
 		spin_unlock_bh(&ctx->mtx);
-		netif_tx_lock_bh(dev->net);
+		bh = netif_tx_lock_bh(dev->net);
 		usbnet_start_xmit(NULL, dev->net);
-		netif_tx_unlock_bh(dev->net);
+		netif_tx_unlock_bh(dev->net, bh);
 	} else {
 		spin_unlock_bh(&ctx->mtx);
 	}
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ca5ab98..b3617fe 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3794,10 +3794,14 @@ static inline void __netif_tx_release(struct netdev_queue *txq)
 	__release(&txq->_xmit_lock);
 }
 
-static inline void __netif_tx_lock_bh(struct netdev_queue *txq)
+static inline unsigned int __netif_tx_lock_bh(struct netdev_queue *txq)
 {
+	unsigned int bh = 0;
+
 	spin_lock_bh(&txq->_xmit_lock);
 	txq->xmit_lock_owner = smp_processor_id();
+
+	return bh;
 }
 
 static inline bool __netif_tx_trylock(struct netdev_queue *txq)
@@ -3814,7 +3818,8 @@ static inline void __netif_tx_unlock(struct netdev_queue *txq)
 	spin_unlock(&txq->_xmit_lock);
 }
 
-static inline void __netif_tx_unlock_bh(struct netdev_queue *txq)
+static inline void __netif_tx_unlock_bh(struct netdev_queue *txq,
+					unsigned int bh)
 {
 	txq->xmit_lock_owner = -1;
 	spin_unlock_bh(&txq->_xmit_lock);
@@ -3863,10 +3868,14 @@ static inline void netif_tx_lock(struct net_device *dev)
 	}
 }
 
-static inline void netif_tx_lock_bh(struct net_device *dev)
+static inline unsigned int netif_tx_lock_bh(struct net_device *dev)
 {
+	unsigned int bh = 0;
+
 	local_bh_disable();
 	netif_tx_lock(dev);
+
+	return bh;
 }
 
 static inline void netif_tx_unlock(struct net_device *dev)
@@ -3886,7 +3895,8 @@ static inline void netif_tx_unlock(struct net_device *dev)
 	spin_unlock(&dev->tx_global_lock);
 }
 
-static inline void netif_tx_unlock_bh(struct net_device *dev)
+static inline void netif_tx_unlock_bh(struct net_device *dev,
+				      unsigned int bh)
 {
 	netif_tx_unlock(dev);
 	local_bh_enable();
diff --git a/net/atm/clip.c b/net/atm/clip.c
index d795b9c..5fddf85 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -84,6 +84,7 @@ static void link_vcc(struct clip_vcc *clip_vcc, struct atmarp_entry *entry)
 
 static void unlink_clip_vcc(struct clip_vcc *clip_vcc)
 {
+	unsigned int bh;
 	struct atmarp_entry *entry = clip_vcc->entry;
 	struct clip_vcc **walk;
 
@@ -91,7 +92,7 @@ static void unlink_clip_vcc(struct clip_vcc *clip_vcc)
 		pr_crit("!clip_vcc->entry (clip_vcc %p)\n", clip_vcc);
 		return;
 	}
-	netif_tx_lock_bh(entry->neigh->dev);	/* block clip_start_xmit() */
+	bh = netif_tx_lock_bh(entry->neigh->dev);	/* block clip_start_xmit() */
 	entry->neigh->used = jiffies;
 	for (walk = &entry->vccs; *walk; walk = &(*walk)->next)
 		if (*walk == clip_vcc) {
@@ -113,7 +114,7 @@ static void unlink_clip_vcc(struct clip_vcc *clip_vcc)
 		}
 	pr_crit("ATMARP: failed (entry %p, vcc 0x%p)\n", entry, clip_vcc);
 out:
-	netif_tx_unlock_bh(entry->neigh->dev);
+	netif_tx_unlock_bh(entry->neigh->dev, bh);
 }
 
 /* The neighbour entry n->lock is held. */
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 69078c8..2266f1f 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -490,10 +490,11 @@ static void dev_watchdog_up(struct net_device *dev)
 
 static void dev_watchdog_down(struct net_device *dev)
 {
-	netif_tx_lock_bh(dev);
+	unsigned int bh;
+	bh = netif_tx_lock_bh(dev);
 	if (del_timer(&dev->watchdog_timer))
 		dev_put(dev);
-	netif_tx_unlock_bh(dev);
+	netif_tx_unlock_bh(dev, bh);
 }
 
 /**
-- 
2.7.4

