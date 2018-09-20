Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC7CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AA3206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AA3206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732238AbeITPw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:52:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50087 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731145AbeITPw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:52:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1071D20795; Thu, 20 Sep 2018 12:10:11 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id D16A3208F5;
        Thu, 20 Sep 2018 12:10:00 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: [PATCH net] net: mscc: fix the frame extraction into the skb
Date:   Thu, 20 Sep 2018 12:08:54 +0200
Message-Id: <20180920100854.19044-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When extracting frames from the Ocelot switch, the frame check sequence
(FCS) is present at the end of the data extracted. The FCS was put into
the sk buffer which introduced some issues (as length related ones), as
the FCS shouldn't be part of an Rx sk buffer.

This patch fixes the Ocelot switch extraction behaviour by discarding
the FCS.

Fixes: a556c76adc05 ("net: mscc: Add initial Ocelot switch support")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---

Hi all,

Once this patch will be accepted and net merged into net-next, I'll
probably send another patch to fill skb->csum with the FCS based on
NETIF_F_RXFCS.

Thanks!
Antoine

 drivers/net/ethernet/mscc/ocelot_board.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index 26bb3b18f3be..3cdf63e35b53 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -91,7 +91,7 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
 		struct sk_buff *skb;
 		struct net_device *dev;
 		u32 *buf;
-		int sz, len;
+		int sz, len, buf_len;
 		u32 ifh[4];
 		u32 val;
 		struct frame_info info;
@@ -116,14 +116,20 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
 			err = -ENOMEM;
 			break;
 		}
-		buf = (u32 *)skb_put(skb, info.len);
+		buf_len = info.len - ETH_FCS_LEN;
+		buf = (u32 *)skb_put(skb, buf_len);
 
 		len = 0;
 		do {
 			sz = ocelot_rx_frame_word(ocelot, grp, false, &val);
 			*buf++ = val;
 			len += sz;
-		} while ((sz == 4) && (len < info.len));
+		} while (len < buf_len);
+
+		/* Read the FCS and discard it */
+		sz = ocelot_rx_frame_word(ocelot, grp, false, &val);
+		/* Update the statistics if part of the FCS was read before */
+		len -= ETH_FCS_LEN - sz;
 
 		if (sz < 0) {
 			err = sz;
-- 
2.17.1

