Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B805CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4292083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4292083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeIZPZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:25:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34116 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbeIZPZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:25:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C342147C77B4B;
        Wed, 26 Sep 2018 17:13:36 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Wed, 26 Sep 2018
 17:13:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <joel@jms.id.au>, <sam@mendozajonas.com>, <garsilva@embeddedor.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: faraday: fix return type of ndo_start_xmit function
Date:   Wed, 26 Sep 2018 17:13:05 +0800
Message-ID: <20180926091305.24556-1-yuehaibing@huawei.com>
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
 drivers/net/ethernet/faraday/ftgmac100.c | 4 ++--
 drivers/net/ethernet/faraday/ftmac100.c  | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index d8ead7e..4d67322 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -712,8 +712,8 @@ static bool ftgmac100_prep_tx_csum(struct sk_buff *skb, u32 *csum_vlan)
 	return skb_checksum_help(skb) == 0;
 }
 
-static int ftgmac100_hard_start_xmit(struct sk_buff *skb,
-				     struct net_device *netdev)
+static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
+					     struct net_device *netdev)
 {
 	struct ftgmac100 *priv = netdev_priv(netdev);
 	struct ftgmac100_txdes *txdes, *first;
diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethernet/faraday/ftmac100.c
index a1197d3..570caeb 100644
--- a/drivers/net/ethernet/faraday/ftmac100.c
+++ b/drivers/net/ethernet/faraday/ftmac100.c
@@ -634,8 +634,8 @@ static void ftmac100_tx_complete(struct ftmac100 *priv)
 		;
 }
 
-static int ftmac100_xmit(struct ftmac100 *priv, struct sk_buff *skb,
-			 dma_addr_t map)
+static netdev_tx_t ftmac100_xmit(struct ftmac100 *priv, struct sk_buff *skb,
+				 dma_addr_t map)
 {
 	struct net_device *netdev = priv->netdev;
 	struct ftmac100_txdes *txdes;
@@ -1016,7 +1016,8 @@ static int ftmac100_stop(struct net_device *netdev)
 	return 0;
 }
 
-static int ftmac100_hard_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t
+ftmac100_hard_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct ftmac100 *priv = netdev_priv(netdev);
 	dma_addr_t map;
-- 
1.8.3.1


