Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB862C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9182098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9182098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbeISQNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:13:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727605AbeISQNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:13:20 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7BB28BBFCBAE1;
        Wed, 19 Sep 2018 18:36:00 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 18:35:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <anirudh@xilinx.com>, <John.Linn@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: xilinx: fix return type of ndo_start_xmit function
Date:   Wed, 19 Sep 2018 18:32:40 +0800
Message-ID: <20180919103240.27708-2-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20180919103240.27708-1-yuehaibing@huawei.com>
References: <20180919103240.27708-1-yuehaibing@huawei.com>
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
 drivers/net/ethernet/xilinx/ll_temac_main.c       | 3 ++-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 3 ++-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c     | 9 +++++----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 60abc92..2241f98 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -674,7 +674,8 @@ static inline int temac_check_tx_bd_space(struct temac_local *lp, int num_frag)
 	return 0;
 }
 
-static int temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct temac_local *lp = netdev_priv(ndev);
 	struct cdmac_bd *cur_p;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index f24f48f..12a1460 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -653,7 +653,8 @@ static inline int axienet_check_tx_bd_space(struct axienet_local *lp,
  * start the transmission. Additionally if checksum offloading is supported,
  * it populates AXI Stream Control fields with appropriate values.
  */
-static int axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	u32 ii;
 	u32 num_frag;
diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 46d3092..639e3e9 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1019,9 +1019,10 @@ static int xemaclite_close(struct net_device *dev)
  * deferred and the Tx queue is stopped so that the deferred socket buffer can
  * be transmitted when the Emaclite device is free to transmit data.
  *
- * Return:	0, always.
+ * Return:	NETDEV_TX_OK, always.
  */
-static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
+static netdev_tx_t
+xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 {
 	struct net_local *lp = netdev_priv(dev);
 	struct sk_buff *new_skb;
@@ -1043,7 +1044,7 @@ static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 		/* Take the time stamp now, since we can't do this in an ISR. */
 		skb_tx_timestamp(new_skb);
 		spin_unlock_irqrestore(&lp->reset_lock, flags);
-		return 0;
+		return NETDEV_TX_OK;
 	}
 	spin_unlock_irqrestore(&lp->reset_lock, flags);
 
@@ -1052,7 +1053,7 @@ static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 	dev->stats.tx_bytes += len;
 	dev_consume_skb_any(new_skb);
 
-	return 0;
+	return NETDEV_TX_OK;
 }
 
 /**
-- 
1.8.3.1


