Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758099AbeDXNUE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:20:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56145 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758069AbeDXNT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:19:56 -0400
X-Google-Smtp-Source: AIpwx4+C2wDSP+36+Vx4G4clzrsXal17zCG1SeJtB7eg4FBqeEzDzWVB/ER1BqEvvaDk+pmj8HAPJA==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        dev@openvswitch.org
Subject: [PATCH] openvswitch: make vport_ops:send()'s return type consistent
Date: Tue, 24 Apr 2018 15:19:53 +0200
Message-Id: <20180424131953.6474-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method struct vport_ops:send() is defined as returning an
'netdev_tx_t', which is defined as a typedef for a bitwise type
and otherwise used for the start_xmit() methods.
However, most openvswitch drivers use for this method dev_queue_xmit()
which returns an 'int' and the return value of vport_ops:send() is
in fact never used.

Make things typewise consistent and use 'int' for vport_ops:send()
as well for internal_dev_recv() (which is the only proper send method)
as using 'netdev_tx_t' doesn't offer any advantages and in fact seems,
if not wrong at least, inadequate.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 net/openvswitch/vport-internal_dev.c | 6 +++---
 net/openvswitch/vport.h              | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 3ea55618e..2fd68c2fb 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -231,7 +231,7 @@ static void internal_dev_destroy(struct vport *vport)
 	rtnl_unlock();
 }
 
-static netdev_tx_t internal_dev_recv(struct sk_buff *skb)
+static int internal_dev_recv(struct sk_buff *skb)
 {
 	struct net_device *netdev = skb->dev;
 	struct pcpu_sw_netstats *stats;
@@ -239,7 +239,7 @@ static netdev_tx_t internal_dev_recv(struct sk_buff *skb)
 	if (unlikely(!(netdev->flags & IFF_UP))) {
 		kfree_skb(skb);
 		netdev->stats.rx_dropped++;
-		return NETDEV_TX_OK;
+		return 0;
 	}
 
 	skb_dst_drop(skb);
@@ -257,7 +257,7 @@ static netdev_tx_t internal_dev_recv(struct sk_buff *skb)
 	u64_stats_update_end(&stats->syncp);
 
 	netif_rx(skb);
-	return NETDEV_TX_OK;
+	return 0;
 }
 
 static struct vport_ops ovs_internal_vport_ops = {
diff --git a/net/openvswitch/vport.h b/net/openvswitch/vport.h
index cda66c26a..8dcb48fe8 100644
--- a/net/openvswitch/vport.h
+++ b/net/openvswitch/vport.h
@@ -141,7 +141,7 @@ struct vport_ops {
 	int (*set_options)(struct vport *, struct nlattr *);
 	int (*get_options)(const struct vport *, struct sk_buff *);
 
-	netdev_tx_t (*send) (struct sk_buff *skb);
+	int (*send) (struct sk_buff *skb);
 	struct module *owner;
 	struct list_head list;
 };
-- 
2.17.0
