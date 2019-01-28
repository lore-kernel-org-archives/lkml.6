Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13518C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99F12175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfA1Xjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:39:43 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:56514 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfA1Xjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:39:43 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id D13C3FB7C7F07D7014EB;
        Tue, 29 Jan 2019 07:39:39 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0SNdbso017107;
        Tue, 29 Jan 2019 07:39:37 +0800 (GMT-8)
        (envelope-from yang.wei9@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019012907394742-24497225 ;
          Tue, 29 Jan 2019 07:39:47 +0800 
From:   Yang Wei <yang.wei9@zte.com.cn>
To:     davem@davemloft.net
Cc:     krzk@kernel.org, herbert@gondor.apana.org.au,
        yuehaibing@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, Yang Wei <yang.wei9@zte.com.cn>
Subject: [PATCH net] net: apple: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
Date:   Tue, 29 Jan 2019 07:39:13 +0800
Message-Id: <1548718753-41047-1-git-send-email-yang.wei9@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-29 07:39:47,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-29 07:39:33,
        Serialize complete at 2019-01-29 07:39:33
X-MAIL: mse01.zte.com.cn x0SNdbso017107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_consume_skb_irq() should be called in bmac_txdma_intr() when 
xmit done. It makes drop profiles more friendly.

Signed-off-by: Yang Wei <yang.wei9@zte.com.cn>
---
 drivers/net/ethernet/apple/bmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/apple/bmac.c b/drivers/net/ethernet/apple/bmac.c
index 6a8e256..4d3855c 100644
--- a/drivers/net/ethernet/apple/bmac.c
+++ b/drivers/net/ethernet/apple/bmac.c
@@ -777,7 +777,7 @@ static irqreturn_t bmac_txdma_intr(int irq, void *dev_id)
 
 		if (bp->tx_bufs[bp->tx_empty]) {
 			++dev->stats.tx_packets;
-			dev_kfree_skb_irq(bp->tx_bufs[bp->tx_empty]);
+			dev_consume_skb_irq(bp->tx_bufs[bp->tx_empty]);
 		}
 		bp->tx_bufs[bp->tx_empty] = NULL;
 		bp->tx_fullup = 0;
-- 
2.7.4

