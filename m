Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBDDECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4452087A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4452087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbeIUIwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:52:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbeIUIwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:52:46 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8BB5AA7A30F68;
        Fri, 21 Sep 2018 11:06:00 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 11:05:55 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <ralf@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-mips@linux-mips.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: sgi: fix return type of ndo_start_xmit function
Date:   Fri, 21 Sep 2018 11:05:50 +0800
Message-ID: <20180921030550.24744-1-yuehaibing@huawei.com>
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
 drivers/net/ethernet/sgi/ioc3-eth.c | 4 ++--
 drivers/net/ethernet/sgi/meth.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 18d533f..3140999 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -99,7 +99,7 @@ struct ioc3_private {
 
 static int ioc3_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static void ioc3_set_multicast_list(struct net_device *dev);
-static int ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static void ioc3_timeout(struct net_device *dev);
 static inline unsigned int ioc3_hash(const unsigned char *addr);
 static inline void ioc3_stop(struct ioc3_private *ip);
@@ -1390,7 +1390,7 @@ static void ioc3_remove_one(struct pci_dev *pdev)
 	.remove		= ioc3_remove_one,
 };
 
-static int ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	unsigned long data;
 	struct ioc3_private *ip = netdev_priv(dev);
diff --git a/drivers/net/ethernet/sgi/meth.c b/drivers/net/ethernet/sgi/meth.c
index ea55abd..703fbbe 100644
--- a/drivers/net/ethernet/sgi/meth.c
+++ b/drivers/net/ethernet/sgi/meth.c
@@ -697,7 +697,7 @@ static void meth_add_to_tx_ring(struct meth_private *priv, struct sk_buff *skb)
 /*
  * Transmit a packet (called by the kernel)
  */
-static int meth_tx(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t meth_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct meth_private *priv = netdev_priv(dev);
 	unsigned long flags;
-- 
1.8.3.1


