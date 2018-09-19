Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62841ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A98C2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A98C2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbeISQ73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:59:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727948AbeISQ73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:59:29 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B5FE9D200829F;
        Wed, 19 Sep 2018 19:21:58 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 19:21:50 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <shannon.nelson@oracle.com>,
        <alexander.h.duyck@intel.com>, <yanjun.zhu@oracle.com>,
        <jeffrey.t.kirsher@intel.com>, <tklauser@distanz.ch>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: sun: fix return type of ndo_start_xmit function
Date:   Wed, 19 Sep 2018 19:21:32 +0800
Message-ID: <20180919112132.26616-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/sun/ldmvsw.c         |  2 +-
 drivers/net/ethernet/sun/sunbmac.c        |  3 ++-
 drivers/net/ethernet/sun/sunqe.c          |  2 +-
 drivers/net/ethernet/sun/sunvnet.c        |  2 +-
 drivers/net/ethernet/sun/sunvnet_common.c | 14 ++++++++------
 drivers/net/ethernet/sun/sunvnet_common.h |  7 ++++---
 6 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/sun/ldmvsw.c b/drivers/net/ethernet/sun/ldmvsw.c
index d42f47f..644e42c 100644
--- a/drivers/net/ethernet/sun/ldmvsw.c
+++ b/drivers/net/ethernet/sun/ldmvsw.c
@@ -113,7 +113,7 @@ static u16 vsw_select_queue(struct net_device *dev, struct sk_buff *skb,
 }
 
 /* Wrappers to common functions */
-static int vsw_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t vsw_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	return sunvnet_start_xmit_common(skb, dev, vsw_tx_port_find);
 }
diff --git a/drivers/net/ethernet/sun/sunbmac.c b/drivers/net/ethernet/sun/sunbmac.c
index f047b27..720b7ac 100644
--- a/drivers/net/ethernet/sun/sunbmac.c
+++ b/drivers/net/ethernet/sun/sunbmac.c
@@ -950,7 +950,8 @@ static void bigmac_tx_timeout(struct net_device *dev)
 }
 
 /* Put a packet on the wire. */
-static int bigmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+bigmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct bigmac *bp = netdev_priv(dev);
 	int len, entry;
diff --git a/drivers/net/ethernet/sun/sunqe.c b/drivers/net/ethernet/sun/sunqe.c
index 7fe0d5e..1468fa0 100644
--- a/drivers/net/ethernet/sun/sunqe.c
+++ b/drivers/net/ethernet/sun/sunqe.c
@@ -570,7 +570,7 @@ static void qe_tx_timeout(struct net_device *dev)
 }
 
 /* Get a packet queued to go onto the wire. */
-static int qe_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t qe_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct sunqe *qep = netdev_priv(dev);
 	struct sunqe_buffers *qbufs = qep->buffers;
diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/sunvnet.c
index 12539b3..5901728 100644
--- a/drivers/net/ethernet/sun/sunvnet.c
+++ b/drivers/net/ethernet/sun/sunvnet.c
@@ -247,7 +247,7 @@ static u16 vnet_select_queue(struct net_device *dev, struct sk_buff *skb,
 }
 
 /* Wrappers to common functions */
-static int vnet_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t vnet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	return sunvnet_start_xmit_common(skb, dev, vnet_tx_port_find);
 }
diff --git a/drivers/net/ethernet/sun/sunvnet_common.c b/drivers/net/ethernet/sun/sunvnet_common.c
index d8f4c3f..baa3088 100644
--- a/drivers/net/ethernet/sun/sunvnet_common.c
+++ b/drivers/net/ethernet/sun/sunvnet_common.c
@@ -1216,9 +1216,10 @@ static inline struct sk_buff *vnet_skb_shape(struct sk_buff *skb, int ncookies)
 	return skb;
 }
 
-static int vnet_handle_offloads(struct vnet_port *port, struct sk_buff *skb,
-				struct vnet_port *(*vnet_tx_port)
-				(struct sk_buff *, struct net_device *))
+static netdev_tx_t
+vnet_handle_offloads(struct vnet_port *port, struct sk_buff *skb,
+		     struct vnet_port *(*vnet_tx_port)
+		     (struct sk_buff *, struct net_device *))
 {
 	struct net_device *dev = VNET_PORT_TO_NET_DEVICE(port);
 	struct vio_dring_state *dr = &port->vio.drings[VIO_DRIVER_TX_RING];
@@ -1321,9 +1322,10 @@ static int vnet_handle_offloads(struct vnet_port *port, struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-int sunvnet_start_xmit_common(struct sk_buff *skb, struct net_device *dev,
-			      struct vnet_port *(*vnet_tx_port)
-			      (struct sk_buff *, struct net_device *))
+netdev_tx_t
+sunvnet_start_xmit_common(struct sk_buff *skb, struct net_device *dev,
+			  struct vnet_port *(*vnet_tx_port)
+			  (struct sk_buff *, struct net_device *))
 {
 	struct vnet_port *port = NULL;
 	struct vio_dring_state *dr;
diff --git a/drivers/net/ethernet/sun/sunvnet_common.h b/drivers/net/ethernet/sun/sunvnet_common.h
index 1ea0b01..2b808d2 100644
--- a/drivers/net/ethernet/sun/sunvnet_common.h
+++ b/drivers/net/ethernet/sun/sunvnet_common.h
@@ -136,9 +136,10 @@ struct vnet {
 void sunvnet_set_rx_mode_common(struct net_device *dev, struct vnet *vp);
 int sunvnet_set_mac_addr_common(struct net_device *dev, void *p);
 void sunvnet_tx_timeout_common(struct net_device *dev);
-int sunvnet_start_xmit_common(struct sk_buff *skb, struct net_device *dev,
-			   struct vnet_port *(*vnet_tx_port)
-			   (struct sk_buff *, struct net_device *));
+netdev_tx_t
+sunvnet_start_xmit_common(struct sk_buff *skb, struct net_device *dev,
+			  struct vnet_port *(*vnet_tx_port)
+			  (struct sk_buff *, struct net_device *));
 #ifdef CONFIG_NET_POLL_CONTROLLER
 void sunvnet_poll_controller_common(struct net_device *dev, struct vnet *vp);
 #endif
-- 
1.8.3.1


