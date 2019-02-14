Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D327DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E8D222CF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437035AbfBNGlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:41:36 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:35868 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394037AbfBNGlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:41:36 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 97654A10604BA685D497;
        Thu, 14 Feb 2019 14:41:31 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1E6fQej051178;
        Thu, 14 Feb 2019 14:41:26 +0800 (GMT-8)
        (envelope-from huang.zijiang@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019021414415656-26036134 ;
          Thu, 14 Feb 2019 14:41:56 +0800 
From:   Huang Zijiang <huang.zijiang@zte.com.cn>
To:     linux-net-drivers@solarflare.com
Cc:     ecree@solarflare.com, bkenward@solarflare.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn, Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: [PATCH 2/2] net: Replace dev_kfree_skb_any by dev_consume_skb_any
Date:   Thu, 14 Feb 2019 14:42:13 +0800
Message-Id: <1550126533-28462-1-git-send-email-huang.zijiang@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-14 14:41:56,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-14 14:41:15,
        Serialize complete at 2019-02-14 14:41:15
X-MAIL: mse01.zte.com.cn x1E6fQej051178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The skb should be freed by dev_consume_skb_any() efx_tx_tso_fallback()
when skb is still used. The skb is be replaced by segments, so the
original skb should be consumed(not drop).

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
---
 drivers/net/ethernet/sfc/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/tx.c b/drivers/net/ethernet/sfc/tx.c
index c3ad564..ed551f0 100644
--- a/drivers/net/ethernet/sfc/tx.c
+++ b/drivers/net/ethernet/sfc/tx.c
@@ -471,7 +471,7 @@ static int efx_tx_tso_fallback(struct efx_tx_queue *tx_queue,
 	if (IS_ERR(segments))
 		return PTR_ERR(segments);
 
-	dev_kfree_skb_any(skb);
+	dev_consume_skb_any(skb);
 	skb = segments;
 
 	while (skb) {
-- 
1.8.3.1

