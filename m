Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6013AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2460D2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2460D2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeIZPWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:22:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38779 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbeIZPWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:22:09 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BEC3B1B6C6AD0;
        Wed, 26 Sep 2018 17:10:07 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Wed, 26 Sep 2018
 17:10:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <f.fainelli@gmail.com>,
        <grygorii.strashko@ti.com>, <w-kwok2@ti.com>,
        <m-karicheri2@ti.com>, <lukas@wunner.de>,
        <bgolaszewski@baylibre.com>, <ivan.khoronzhuk@linaro.org>,
        <dan.carpenter@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: ti: fix return type of ndo_start_xmit function
Date:   Wed, 26 Sep 2018 17:09:51 +0800
Message-ID: <20180926090951.25544-1-yuehaibing@huawei.com>
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
 drivers/net/ethernet/ti/cpmac.c        | 2 +-
 drivers/net/ethernet/ti/davinci_emac.c | 2 +-
 drivers/net/ethernet/ti/netcp_core.c   | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpmac.c b/drivers/net/ethernet/ti/cpmac.c
index 9b8a30b..64c45eb 100644
--- a/drivers/net/ethernet/ti/cpmac.c
+++ b/drivers/net/ethernet/ti/cpmac.c
@@ -544,7 +544,7 @@ static int cpmac_poll(struct napi_struct *napi, int budget)
 
 }
 
-static int cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t cpmac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	int queue;
 	unsigned int len;
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index f270bee..b83f32d 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -943,7 +943,7 @@ static void emac_tx_handler(void *token, int len, int status)
  *
  * Returns success(NETDEV_TX_OK) or error code (typically out of desc's)
  */
-static int emac_dev_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t emac_dev_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct device *emac_dev = &ndev->dev;
 	int ret_code;
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 1f61226..2d8cfe8 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -1270,7 +1270,8 @@ static int netcp_tx_submit_skb(struct netcp_intf *netcp,
 }
 
 /* Submit the packet */
-static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct netcp_intf *netcp = netdev_priv(ndev);
 	struct netcp_stats *tx_stats = &netcp->stats;
@@ -1290,7 +1291,7 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 			dev_warn(netcp->ndev_dev, "padding failed (%d), packet dropped\n",
 				 ret);
 			tx_stats->tx_dropped++;
-			return ret;
+			return NETDEV_TX_BUSY;
 		}
 		skb->len = NETCP_MIN_PACKET_SIZE;
 	}
@@ -1298,7 +1299,6 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	desc = netcp_tx_map_skb(skb, netcp);
 	if (unlikely(!desc)) {
 		netif_stop_subqueue(ndev, subqueue);
-		ret = -ENOBUFS;
 		goto drop;
 	}
 
@@ -1319,7 +1319,7 @@ static int netcp_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (desc)
 		netcp_free_tx_desc_chain(netcp, desc, sizeof(*desc));
 	dev_kfree_skb(skb);
-	return ret;
+	return NETDEV_TX_BUSY;
 }
 
 int netcp_txpipe_close(struct netcp_tx_pipe *tx_pipe)
-- 
1.8.3.1


