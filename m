Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52D5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C5F20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C5F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeIZQr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:47:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727222AbeIZQr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:47:28 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 24922604EEA45;
        Wed, 26 Sep 2018 18:35:07 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Wed, 26 Sep 2018
 18:35:01 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <garsilva@embeddedor.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: plip: fix return type of ndo_start_xmit function
Date:   Wed, 26 Sep 2018 18:34:43 +0800
Message-ID: <20180926103443.25316-1-yuehaibing@huawei.com>
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
 drivers/net/plip/plip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
index feb92ec..0b354e6 100644
--- a/drivers/net/plip/plip.c
+++ b/drivers/net/plip/plip.c
@@ -146,7 +146,7 @@
 static void plip_interrupt(void *dev_id);
 
 /* Functions for DEV methods */
-static int plip_tx_packet(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t plip_tx_packet(struct sk_buff *skb, struct net_device *dev);
 static int plip_hard_header(struct sk_buff *skb, struct net_device *dev,
                             unsigned short type, const void *daddr,
 			    const void *saddr, unsigned len);
@@ -962,7 +962,7 @@ static __be16 plip_type_trans(struct sk_buff *skb, struct net_device *dev)
 	spin_unlock_irqrestore(&nl->lock, flags);
 }
 
-static int
+static netdev_tx_t
 plip_tx_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct net_local *nl = netdev_priv(dev);
-- 
1.8.3.1


