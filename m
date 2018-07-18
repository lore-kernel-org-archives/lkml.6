Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437D1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067092075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067092075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbeGRQtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:49:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60428 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731674AbeGRQtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:49:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6DBF720935; Wed, 18 Jul 2018 18:11:10 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4304D20741;
        Wed, 18 Jul 2018 18:11:10 +0200 (CEST)
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
Subject: [PATCH net-next v3 5/8] net: mvneta: discriminate error cause for missed packet
Date:   Wed, 18 Jul 2018 18:10:54 +0200
Message-Id: <20180718161057.28704-6-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718161057.28704-1-gregory.clement@bootlin.com>
References: <20180718161057.28704-1-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to improve the diagnostic in case of error, make the distinction
between refill error and skb allocation error. Also make the information
available through the ethtool state.

Based on the work of Yelena Krivosheev <yelena@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 28 +++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index e519439bac97..da2d56826295 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -328,6 +328,8 @@
 
 enum {
 	ETHTOOL_STAT_EEE_WAKEUP,
+	ETHTOOL_STAT_SKB_ALLOC_ERR,
+	ETHTOOL_STAT_REFILL_ERR,
 	ETHTOOL_MAX_STATS,
 };
 
@@ -375,6 +377,8 @@ static const struct mvneta_statistic mvneta_statistics[] = {
 	{ 0x3054, T_REG_32, "fc_sent", },
 	{ 0x300c, T_REG_32, "internal_mac_transmit_err", },
 	{ ETHTOOL_STAT_EEE_WAKEUP, T_SW, "eee_wakeup_errors", },
+	{ ETHTOOL_STAT_SKB_ALLOC_ERR, T_SW, "skb_alloc_errors", },
+	{ ETHTOOL_STAT_REFILL_ERR, T_SW, "refill_errors", },
 };
 
 struct mvneta_pcpu_stats {
@@ -589,9 +593,6 @@ struct mvneta_rx_queue {
 	/* num of rx descriptors in the rx descriptor ring */
 	int size;
 
-	/* counter of times when mvneta_refill() failed */
-	int missed;
-
 	u32 pkts_coal;
 	u32 time_coal;
 
@@ -609,6 +610,10 @@ struct mvneta_rx_queue {
 
 	/* Index of the next RX DMA descriptor to process */
 	int next_desc_to_proc;
+
+	/* error counters */
+	u32 skb_alloc_err;
+	u32 refill_err;
 };
 
 static enum cpuhp_state online_hpstate;
@@ -1946,8 +1951,13 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
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
@@ -1972,7 +1982,7 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
 		err = mvneta_rx_refill(pp, rx_desc, rxq);
 		if (err) {
 			netdev_err(dev, "Linux processing - Can't refill\n");
-			rxq->missed++;
+			rxq->refill_err++;
 			goto err_drop_frame;
 		}
 
@@ -2102,7 +2112,7 @@ static int mvneta_rx_hwbm(struct napi_struct *napi,
 		err = hwbm_pool_refill(&bm_pool->hwbm_pool, GFP_ATOMIC);
 		if (err) {
 			netdev_err(dev, "Linux processing - Can't refill\n");
-			rxq->missed++;
+			rxq->refill_err++;
 			goto err_drop_frame_ret_pool;
 		}
 
@@ -3963,6 +3973,12 @@ static void mvneta_ethtool_update_stats(struct mvneta_port *pp)
 			case ETHTOOL_STAT_EEE_WAKEUP:
 				val = phylink_get_eee_err(pp->phylink);
 				break;
+			case ETHTOOL_STAT_SKB_ALLOC_ERR:
+				val = pp->rxqs[0].skb_alloc_err;
+				break;
+			case ETHTOOL_STAT_REFILL_ERR:
+				val = pp->rxqs[0].refill_err;
+				break;
 			}
 			break;
 		}
-- 
2.18.0

