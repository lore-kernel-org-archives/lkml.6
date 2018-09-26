Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDE7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AFE2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AFE2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeIZPjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:39:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39521 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727710AbeIZPjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:39:32 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B2EFFCB87F6B3;
        Wed, 26 Sep 2018 17:27:26 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Wed, 26 Sep 2018
 17:27:22 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <dmitry.tarnyagin@lockless.no>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: caif: fix return type of ndo_start_xmit function
Date:   Wed, 26 Sep 2018 17:27:05 +0800
Message-ID: <20180926092705.28880-1-yuehaibing@huawei.com>
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
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/caif/caif_hsi.c    | 10 +++++-----
 drivers/net/caif/caif_serial.c |  7 +++++--
 drivers/net/caif/caif_spi.c    |  6 +++---
 drivers/net/caif/caif_virtio.c |  2 +-
 net/caif/chnl_net.c            |  3 ++-
 5 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/caif/caif_hsi.c b/drivers/net/caif/caif_hsi.c
index 433a14b..70c449e 100644
--- a/drivers/net/caif/caif_hsi.c
+++ b/drivers/net/caif/caif_hsi.c
@@ -1006,7 +1006,7 @@ static void cfhsi_aggregation_tout(struct timer_list *t)
 	cfhsi_start_tx(cfhsi);
 }
 
-static int cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct cfhsi *cfhsi = NULL;
 	int start_xfer = 0;
@@ -1014,7 +1014,7 @@ static int cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
 	int prio;
 
 	if (!dev)
-		return -EINVAL;
+		return NETDEV_TX_BUSY;
 
 	cfhsi = netdev_priv(dev);
 
@@ -1048,7 +1048,7 @@ static int cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (WARN_ON(test_bit(CFHSI_SHUTDOWN, &cfhsi->bits))) {
 		spin_unlock_bh(&cfhsi->lock);
 		cfhsi_abort_tx(cfhsi);
-		return -EINVAL;
+		return NETDEV_TX_BUSY;
 	}
 
 	/* Send flow off if number of packets is above high water mark. */
@@ -1072,7 +1072,7 @@ static int cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
 		spin_unlock_bh(&cfhsi->lock);
 		if (aggregate_ready)
 			cfhsi_start_tx(cfhsi);
-		return 0;
+		return NETDEV_TX_OK;
 	}
 
 	/* Delete inactivity timer if started. */
@@ -1102,7 +1102,7 @@ static int cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
 			queue_work(cfhsi->wq, &cfhsi->wake_up_work);
 	}
 
-	return 0;
+	return NETDEV_TX_OK;
 }
 
 static const struct net_device_ops cfhsi_netdevops;
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index a0f954f..acb3264 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -275,7 +275,7 @@ static int handle_tx(struct ser_device *ser)
 	return tty_wr;
 }
 
-static int caif_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t caif_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ser_device *ser;
 
@@ -290,7 +290,10 @@ static int caif_xmit(struct sk_buff *skb, struct net_device *dev)
 		ser->common.flowctrl(ser->dev, OFF);
 
 	skb_queue_tail(&ser->head, skb);
-	return handle_tx(ser);
+	if (handle_tx(ser))
+		return NETDEV_TX_BUSY;
+
+	return NETDEV_TX_OK;
 }
 
 
diff --git a/drivers/net/caif/caif_spi.c b/drivers/net/caif/caif_spi.c
index d28a139..9040658 100644
--- a/drivers/net/caif/caif_spi.c
+++ b/drivers/net/caif/caif_spi.c
@@ -486,12 +486,12 @@ static void cfspi_xfer_done_cb(struct cfspi_ifc *ifc)
 	complete(&cfspi->comp);
 }
 
-static int cfspi_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t cfspi_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct cfspi *cfspi = NULL;
 	unsigned long flags;
 	if (!dev)
-		return -EINVAL;
+		return NETDEV_TX_BUSY;
 
 	cfspi = netdev_priv(dev);
 
@@ -512,7 +512,7 @@ static int cfspi_xmit(struct sk_buff *skb, struct net_device *dev)
 		cfspi->cfdev.flowctrl(cfspi->ndev, 0);
 	}
 
-	return 0;
+	return NETDEV_TX_OK;
 }
 
 int cfspi_rxfrm(struct cfspi *cfspi, u8 *buf, size_t len)
diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 2814e0d..f5507db 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -519,7 +519,7 @@ static struct buf_info *cfv_alloc_and_copy_to_shm(struct cfv_info *cfv,
 }
 
 /* Put the CAIF packet on the virtio ring and kick the receiver */
-static int cfv_netdev_tx(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t cfv_netdev_tx(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct cfv_info *cfv = netdev_priv(netdev);
 	struct buf_info *buf_info;
diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
index 13e2ae6..30be426 100644
--- a/net/caif/chnl_net.c
+++ b/net/caif/chnl_net.c
@@ -211,7 +211,8 @@ static void chnl_flowctrl_cb(struct cflayer *layr, enum caif_ctrlcmd flow,
 	}
 }
 
-static int chnl_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+chnl_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct chnl_net *priv;
 	struct cfpkt *pkt = NULL;
-- 
1.8.3.1


