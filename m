Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DE1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAD9222D0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436740AbfBNGks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:40:48 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:55744 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbfBNGkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:40:47 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 3DE99F9B18BD5CD5A489;
        Thu, 14 Feb 2019 14:40:45 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1E6eWtG050422;
        Thu, 14 Feb 2019 14:40:32 +0800 (GMT-8)
        (envelope-from huang.zijiang@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019021414410260-26035759 ;
          Thu, 14 Feb 2019 14:41:02 +0800 
From:   Huang Zijiang <huang.zijiang@zte.com.cn>
To:     nicolas.ferre@microchip.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: [PATCH 1/2] net:ethernet:cadence: Replace dev_kfree_skb_any by dev_consume_skb_any
Date:   Thu, 14 Feb 2019 14:41:18 +0800
Message-Id: <1550126478-28316-1-git-send-email-huang.zijiang@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-14 14:41:02,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-14 14:40:21,
        Serialize complete at 2019-02-14 14:40:21
X-MAIL: mse01.zte.com.cn x1E6eWtG050422
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The skb should be freed by dev_consume_skb_any() in macb_pad_and_fcs()
when *skb is still used. The *skb is be replaced by nskb, so the
original *skb should be consumed(not drop).

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1d86b4d..5a63ac5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1698,7 +1698,7 @@ static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *ndev)
 		if (!nskb)
 			return -ENOMEM;
 
-		dev_kfree_skb_any(*skb);
+		dev_consume_skb_any(*skb);
 		*skb = nskb;
 	}
 
-- 
1.8.3.1

