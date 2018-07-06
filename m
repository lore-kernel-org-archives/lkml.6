Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB2BC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A9A23FCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A9A23FCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933618AbeGFNWN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:22:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57319 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933168AbeGFNUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:20:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C283420775; Fri,  6 Jul 2018 15:20:00 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 91C61207D4;
        Fri,  6 Jul 2018 15:19:50 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Dmitri Epshtein <dima@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next 3/6] net: mvneta: discriminate error cause for missed packet
Date:   Fri,  6 Jul 2018 15:19:46 +0200
Message-Id: <20180706131949.2684-4-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706131949.2684-1-gregory.clement@bootlin.com>
References: <20180706131949.2684-1-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yelena Krivosheev <yelena@marvell.com>

In order to improve the diagnostic in case of error, make the distinction
between refill error and skb allocation error.

Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
[gregory: extract from a larger patch]
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 531227e2e48e..2c575c6732ce 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -589,9 +589,6 @@ struct mvneta_rx_queue {
 	/* num of rx descriptors in the rx descriptor ring */
 	int size;
 
-	/* counter of times when mvneta_refill() failed */
-	int missed;
-
 	u32 pkts_coal;
 	u32 time_coal;
 
@@ -609,6 +606,10 @@ struct mvneta_rx_queue {
 
 	/* Index of the next RX DMA descriptor to process */
 	int next_desc_to_proc;
+
+	/* error counters */
+	u32 skb_alloc_err;
+	u32 refill_err;
 };
 
 static enum cpuhp_state online_hpstate;
@@ -1946,8 +1947,13 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 		if (rx_bytes <= rx_copybreak) {
 		/* better copy a small frame and not unmap the DMA region */
 			skb = netdev_alloc_skb_ip_align(dev, rx_bytes);
-			if (unlikely(!skb))
+			if (unlikely(!skb)) {
+				netdev_err(dev,
+					   "Can't allocate skb on queue %d\n",
+					   rxq->id);
+				rxq->skb_alloc_err++;
 				goto err_drop_frame;
+			}
 
 			dma_sync_single_range_for_cpu(dev->dev.parent,
 						      phys_addr,
@@ -1972,7 +1978,7 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 		err = mvneta_rx_refill(pp, rx_desc, rxq);
 		if (err) {
 			netdev_err(dev, "Linux processing - Can't refill\n");
-			rxq->missed++;
+			rxq->refill_err++;
 			goto err_drop_frame;
 		}
 
@@ -2102,7 +2108,7 @@ static int mvneta_rx_hwbm(struct mvneta_port *pp, int rx_todo,
 		err = hwbm_pool_refill(&bm_pool->hwbm_pool, GFP_ATOMIC);
 		if (err) {
 			netdev_err(dev, "Linux processing - Can't refill\n");
-			rxq->missed++;
+			rxq->refill_err++;
 			goto err_drop_frame_ret_pool;
 		}
 
-- 
2.17.1

