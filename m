Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE9DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09005222CF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405808AbfBNGjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:39:19 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:34278 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbfBNGjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:39:19 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 782346DA692048CECA2B;
        Thu, 14 Feb 2019 14:39:16 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1E6dCnS048823;
        Thu, 14 Feb 2019 14:39:12 +0800 (GMT-8)
        (envelope-from huang.zijiang@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019021414394212-26035282 ;
          Thu, 14 Feb 2019 14:39:42 +0800 
From:   Huang Zijiang <huang.zijiang@zte.com.cn>
To:     isdn@linux-pingi.de
Cc:     davem@davemloft.net, natechancellor@gmail.com,
        yuehaibing@huawei.com, baijiaju1990@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn, Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: [PATCH] isdn:hisax: Replace dev_kfree_skb_any by dev_consume_skb_any
Date:   Thu, 14 Feb 2019 14:39:59 +0800
Message-Id: <1550126399-28063-1-git-send-email-huang.zijiang@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-14 14:39:42,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-14 14:39:00,
        Serialize complete at 2019-02-14 14:39:00
X-MAIL: mse01.zte.com.cn x1E6dCnS048823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The skb should be freed by dev_consume_skb_any() in hfcpci_fill_fifo()
when bcs->tx_skb is still used. The bcs->tx_skb is be replaced by
skb_dequeue(&bcs->squeue), so the original bcs->tx_skb should
be consumed(not drop).

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
---
 drivers/isdn/hisax/hfc_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
index ea0e4c6..7f9e8cc 100644
--- a/drivers/isdn/hisax/hfc_pci.c
+++ b/drivers/isdn/hisax/hfc_pci.c
@@ -657,7 +657,7 @@ hfcpci_fill_fifo(struct BCState *bcs)
 				schedule_event(bcs, B_ACKPENDING);
 			}
 
-			dev_kfree_skb_any(bcs->tx_skb);
+			dev_consume_skb_any(bcs->tx_skb);
 			bcs->tx_skb = skb_dequeue(&bcs->squeue);	/* fetch next data */
 		}
 		test_and_clear_bit(BC_FLG_BUSY, &bcs->Flag);
-- 
1.8.3.1

