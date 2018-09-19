Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED69ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B7B2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B7B2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbeISP5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:57:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727605AbeISP5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:57:13 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 97ACF2EE6768C;
        Wed, 19 Sep 2018 18:19:57 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 18:19:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <thomas.petazzoni@free-electrons.com>,
        <antoine.tenart@bootlin.com>, <maxime.chevallier@bootlin.com>,
        <ymarkman@marvell.com>, <stefanc@marvell.com>,
        <keescook@chromium.org>, <allen.lkml@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: marvell: fix return type of ndo_start_xmit function
Date:   Wed, 19 Sep 2018 18:19:26 +0800
Message-ID: <20180919101926.25036-1-yuehaibing@huawei.com>
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
 drivers/net/ethernet/marvell/mvneta.c           | 2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 drivers/net/ethernet/marvell/pxa168_eth.c       | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index fe3edb3..4019479 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2393,7 +2393,7 @@ static int mvneta_tx_frag_process(struct mvneta_port *pp, struct sk_buff *skb,
 }
 
 /* Main tx processing */
-static int mvneta_tx(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t mvneta_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct mvneta_port *pp = netdev_priv(dev);
 	u16 txq_id = skb_get_queue_mapping(skb);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 702fec8..2a897d7 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2906,7 +2906,7 @@ static int mvpp2_tx_tso(struct sk_buff *skb, struct net_device *dev,
 }
 
 /* Main tx processing */
-static int mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
 	struct mvpp2_tx_queue *txq, *aggr_txq;
diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index 3a97306..ff2fea0 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -1260,7 +1260,8 @@ static int pxa168_rx_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
-static int pxa168_eth_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+pxa168_eth_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct pxa168_eth_private *pep = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
-- 
1.8.3.1


