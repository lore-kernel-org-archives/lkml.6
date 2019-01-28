Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7768CC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452272175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfA1Xkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:40:42 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:60012 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfA1Xkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:40:42 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id D075571733617B1DE5C0;
        Tue, 29 Jan 2019 07:40:39 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0SNeYAb017620;
        Tue, 29 Jan 2019 07:40:34 +0800 (GMT-8)
        (envelope-from yang.wei9@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019012907404422-24497235 ;
          Tue, 29 Jan 2019 07:40:44 +0800 
From:   Yang Wei <yang.wei9@zte.com.cn>
To:     f.fainelli@gmail.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, Yang Wei <yang.wei9@zte.com.cn>
Subject: [PATCH net] net: ti: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles
Date:   Tue, 29 Jan 2019 07:40:10 +0800
Message-Id: <1548718810-41315-1-git-send-email-yang.wei9@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-29 07:40:44,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-29 07:40:30,
        Serialize complete at 2019-01-29 07:40:30
X-MAIL: mse01.zte.com.cn x0SNeYAb017620
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_consume_skb_irq() should be called in cpmac_end_xmit() when
xmit done. It makes drop profiles more friendly.

Signed-off-by: Yang Wei <yang.wei9@zte.com.cn>
---
 drivers/net/ethernet/ti/cpmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpmac.c b/drivers/net/ethernet/ti/cpmac.c
index 810dfc7..e2d47b2 100644
--- a/drivers/net/ethernet/ti/cpmac.c
+++ b/drivers/net/ethernet/ti/cpmac.c
@@ -608,7 +608,7 @@ static void cpmac_end_xmit(struct net_device *dev, int queue)
 			netdev_dbg(dev, "sent 0x%p, len=%d\n",
 				   desc->skb, desc->skb->len);
 
-		dev_kfree_skb_irq(desc->skb);
+		dev_consume_skb_irq(desc->skb);
 		desc->skb = NULL;
 		if (__netif_subqueue_stopped(dev, queue))
 			netif_wake_subqueue(dev, queue);
-- 
2.7.4

