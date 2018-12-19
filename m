Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76201C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC40217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="XJhFC8LO";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="mwEHkid2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbeLSQnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:43:18 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:50967 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727383AbeLSQnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:43:17 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id 3B44821321;
        Wed, 19 Dec 2018 19:43:13 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 51ZqkxIrED-hCOqeP3m;
        Wed, 19 Dec 2018 19:43:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1545237793; bh=MSv7B/d4wVDMLojnIBPVkba5gMXIMkpMLjVLzInF2u8=;
        h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References;
        b=XJhFC8LOuQo3BeMET6Af2mruRy+UmSfySLt5nTbQsmKYbNJ+zGeCf/AkJApeuQWBZ
         yefT11BwBU2M5o1IE+gzq30taFeEyDTbCUkMfCMjP7T1Wh33k9nLpg8h6Be/arjDts
         rrb0JQcGL5U8Z+WzLekG5JV5WWq30HDnRjNo4IHs=
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:0:3711::1:3e])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id qozLndJxTz-hC5CMBKm;
        Wed, 19 Dec 2018 19:43:12 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1545237792; bh=MSv7B/d4wVDMLojnIBPVkba5gMXIMkpMLjVLzInF2u8=;
        h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References;
        b=mwEHkid29XC6QnMBpuiVe3TIZrduKKoTAj7bQypItmWvo36GNypEA0cONJPcsCWLz
         6psAcWrx5UCXuxdKE0nXBAe3L3Yclns1COGaKUFoFBoZjFC6CezaIJ9jwxc2yA8zwO
         kz46oSxV00iEKlaf73jEYB+8WBT2r6TfW8i/0n+M=
Authentication-Results: smtpcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH v2] macvlan: use per-cpu queues for broadcast and multicast
 packets
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc:     Vadim Fedorenko <junk@yandex-team.ru>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Date:   Wed, 19 Dec 2018 19:43:10 +0300
Message-ID: <154523779011.671635.11120127931100080368.stgit@buzz>
In-Reply-To: <154116580015.953950.9450253307804393677.stgit@buzz>
References: <154116580015.953950.9450253307804393677.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently macvlan has single per-port queue for broadcast and multicast.
This disrupts order of packets when flows from different cpus are mixed.

This patch replaces this queue with single set of per-cpu queues.
Pointer to macvlan port is passed in skb control block.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reported-by: Vadim Fedorenko <vfedorenko@yandex-team.ru>
Tested-by: Vadim Fedorenko <vfedorenko@yandex-team.ru>
---
 drivers/net/macvlan.c |   65 +++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 0da3d36b283b..d6e74bd01571 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -46,8 +46,6 @@ struct macvlan_port {
 	struct net_device	*dev;
 	struct hlist_head	vlan_hash[MACVLAN_HASH_SIZE];
 	struct list_head	vlans;
-	struct sk_buff_head	bc_queue;
-	struct work_struct	bc_work;
 	u32			flags;
 	int			count;
 	struct hlist_head	vlan_source_hash[MACVLAN_HASH_SIZE];
@@ -55,6 +53,11 @@ struct macvlan_port {
 	unsigned char           perm_addr[ETH_ALEN];
 };
 
+struct macvlan_bc_work {
+	struct sk_buff_head	bc_queue;
+	struct work_struct	bc_work;
+};
+
 struct macvlan_source_entry {
 	struct hlist_node	hlist;
 	struct macvlan_dev	*vlan;
@@ -63,6 +66,7 @@ struct macvlan_source_entry {
 };
 
 struct macvlan_skb_cb {
+	const struct macvlan_port *port;
 	const struct macvlan_dev *src;
 };
 
@@ -295,20 +299,23 @@ static void macvlan_broadcast(struct sk_buff *skb,
 	}
 }
 
+static DEFINE_PER_CPU(struct macvlan_bc_work, macvlan_bc_work);
+
 static void macvlan_process_broadcast(struct work_struct *w)
 {
-	struct macvlan_port *port = container_of(w, struct macvlan_port,
+	struct macvlan_bc_work *work = container_of(w, struct macvlan_bc_work,
 						 bc_work);
 	struct sk_buff *skb;
 	struct sk_buff_head list;
 
 	__skb_queue_head_init(&list);
 
-	spin_lock_bh(&port->bc_queue.lock);
-	skb_queue_splice_tail_init(&port->bc_queue, &list);
-	spin_unlock_bh(&port->bc_queue.lock);
+	spin_lock_bh(&work->bc_queue.lock);
+	skb_queue_splice_tail_init(&work->bc_queue, &list);
+	spin_unlock_bh(&work->bc_queue.lock);
 
 	while ((skb = __skb_dequeue(&list))) {
+		const struct macvlan_port *port = MACVLAN_SKB_CB(skb)->port;
 		const struct macvlan_dev *src = MACVLAN_SKB_CB(skb)->src;
 
 		rcu_read_lock();
@@ -345,6 +352,7 @@ static void macvlan_broadcast_enqueue(struct macvlan_port *port,
 				      const struct macvlan_dev *src,
 				      struct sk_buff *skb)
 {
+	struct macvlan_bc_work *work;
 	struct sk_buff *nskb;
 	int err = -ENOMEM;
 
@@ -352,24 +360,30 @@ static void macvlan_broadcast_enqueue(struct macvlan_port *port,
 	if (!nskb)
 		goto err;
 
+	MACVLAN_SKB_CB(nskb)->port = port;
 	MACVLAN_SKB_CB(nskb)->src = src;
 
-	spin_lock(&port->bc_queue.lock);
-	if (skb_queue_len(&port->bc_queue) < MACVLAN_BC_QUEUE_LEN) {
+	work = get_cpu_ptr(&macvlan_bc_work);
+
+	spin_lock(&work->bc_queue.lock);
+	if (skb_queue_len(&work->bc_queue) < MACVLAN_BC_QUEUE_LEN) {
 		if (src)
 			dev_hold(src->dev);
-		__skb_queue_tail(&port->bc_queue, nskb);
+		__skb_queue_tail(&work->bc_queue, nskb);
 		err = 0;
 	}
-	spin_unlock(&port->bc_queue.lock);
+	spin_unlock(&work->bc_queue.lock);
 
 	if (err)
 		goto free_nskb;
 
-	schedule_work(&port->bc_work);
+	schedule_work_on(smp_processor_id(), &work->bc_work);
+	put_cpu_ptr(work);
+
 	return;
 
 free_nskb:
+	put_cpu_ptr(work);
 	kfree_skb(nskb);
 err:
 	atomic_long_inc(&skb->dev->rx_dropped);
@@ -1171,9 +1185,6 @@ static int macvlan_port_create(struct net_device *dev)
 	for (i = 0; i < MACVLAN_HASH_SIZE; i++)
 		INIT_HLIST_HEAD(&port->vlan_source_hash[i]);
 
-	skb_queue_head_init(&port->bc_queue);
-	INIT_WORK(&port->bc_work, macvlan_process_broadcast);
-
 	err = netdev_rx_handler_register(dev, macvlan_handle_frame, port);
 	if (err)
 		kfree(port);
@@ -1185,24 +1196,16 @@ static int macvlan_port_create(struct net_device *dev)
 static void macvlan_port_destroy(struct net_device *dev)
 {
 	struct macvlan_port *port = macvlan_port_get_rtnl(dev);
-	struct sk_buff *skb;
+	int cpu;
 
 	dev->priv_flags &= ~IFF_MACVLAN_PORT;
 	netdev_rx_handler_unregister(dev);
 
 	/* After this point, no packet can schedule bc_work anymore,
-	 * but we need to cancel it and purge left skbs if any.
+	 * but we need to flush work.
 	 */
-	cancel_work_sync(&port->bc_work);
-
-	while ((skb = __skb_dequeue(&port->bc_queue))) {
-		const struct macvlan_dev *src = MACVLAN_SKB_CB(skb)->src;
-
-		if (src)
-			dev_put(src->dev);
-
-		kfree_skb(skb);
-	}
+	for_each_possible_cpu(cpu)
+		flush_work(per_cpu_ptr(&macvlan_bc_work.bc_work, cpu));
 
 	/* If the lower device address has been changed by passthru
 	 * macvlan, put it back.
@@ -1705,7 +1708,15 @@ static struct notifier_block macvlan_notifier_block __read_mostly = {
 
 static int __init macvlan_init_module(void)
 {
-	int err;
+	int err, cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct macvlan_bc_work *work;
+
+		work = per_cpu_ptr(&macvlan_bc_work, cpu);
+		skb_queue_head_init(&work->bc_queue);
+		INIT_WORK(&work->bc_work, macvlan_process_broadcast);
+	}
 
 	register_netdevice_notifier(&macvlan_notifier_block);
 

