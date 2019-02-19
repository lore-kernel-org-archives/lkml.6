Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDBDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0B72075C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gmHTgnml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfBSJjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:39:03 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:52094 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBSJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:39:02 -0500
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id F3A2710C18A9;
        Tue, 19 Feb 2019 01:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550569142; bh=EdVybxrScWXUTWqAzU55vUBZjTNMqf6zIGirgxC1v3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=gmHTgnmlf06XvUuUrzF3/RAIF/iL4ilaSNRwXj8yprAbvRfxvK5Seo3n5sM+0DR8g
         y8CiSk1yNd4VL96YVogysSs8PX8mJyej4wRZAbdV8DeBdc+hkXaxg/EYT7GHALMvGg
         7xoKZ64s9j+hmLvSRwqPNGS9DdHorOpJGBFcWvdlZBtO0zPT3dNT3tB8afRk9i1Ay0
         0lbWDtZxQJhUuLmBHBA/zvWBWErONrBocYIYOog/TOM2EdkDvVYtBEF4/CZuXmDW0u
         CUxQi/YwIT3cCy1lIKjxewVrT1W6/bdIR+TH3JNsGLAFGBdkejhqrr8+2s+hoqDSF2
         bF4mJ1mJuZgAQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id E0AE65A59;
        Tue, 19 Feb 2019 01:38:59 -0800 (PST)
From:   Jose Abreu <jose.abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <jose.abreu@synopsys.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next v3 1/3] net: stmmac: Fix NAPI poll in TX path when in multi-queue
Date:   Tue, 19 Feb 2019 10:38:47 +0100
Message-Id: <c78a065df8f1f6b86f227773c75c55ff170e2260.1550569066.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1550569066.git.joabreu@synopsys.com>
References: <cover.1550569066.git.joabreu@synopsys.com>
In-Reply-To: <cover.1550569066.git.joabreu@synopsys.com>
References: <cover.1550569066.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8fce33317023 introduced the concept of NAPI per-channel and
independent cleaning of TX path.

This is currently breaking performance in some cases. The scenario
happens when all packets are being received in Queue 0 but the TX is
performed in Queue != 0.

Fix this by using different NAPI instances per each TX and RX queue, as
suggested by Florian.

Changes from v2:
	- Only force restart transmission if there are pending packets
Changes from v1:
	- Pass entire ring size to TX clean path (Florian)

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   5 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 115 +++++++++++++---------
 2 files changed, 68 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 63e1064b27a2..e697ecd9b0a6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -78,11 +78,10 @@ struct stmmac_rx_queue {
 };
 
 struct stmmac_channel {
-	struct napi_struct napi ____cacheline_aligned_in_smp;
+	struct napi_struct rx_napi ____cacheline_aligned_in_smp;
+	struct napi_struct tx_napi ____cacheline_aligned_in_smp;
 	struct stmmac_priv *priv_data;
 	u32 index;
-	int has_rx;
-	int has_tx;
 };
 
 struct stmmac_tc_entry {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 685d20472358..9d515b86e278 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -155,7 +155,10 @@ static void stmmac_disable_all_queues(struct stmmac_priv *priv)
 	for (queue = 0; queue < maxq; queue++) {
 		struct stmmac_channel *ch = &priv->channel[queue];
 
-		napi_disable(&ch->napi);
+		if (queue < rx_queues_cnt)
+			napi_disable(&ch->rx_napi);
+		if (queue < tx_queues_cnt)
+			napi_disable(&ch->tx_napi);
 	}
 }
 
@@ -173,7 +176,10 @@ static void stmmac_enable_all_queues(struct stmmac_priv *priv)
 	for (queue = 0; queue < maxq; queue++) {
 		struct stmmac_channel *ch = &priv->channel[queue];
 
-		napi_enable(&ch->napi);
+		if (queue < rx_queues_cnt)
+			napi_enable(&ch->rx_napi);
+		if (queue < tx_queues_cnt)
+			napi_enable(&ch->tx_napi);
 	}
 }
 
@@ -1939,6 +1945,10 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 		mod_timer(&priv->eee_ctrl_timer, STMMAC_LPI_T(eee_timer));
 	}
 
+	/* We still have pending packets, let's call for a new scheduling */
+	if (tx_q->dirty_tx != tx_q->cur_tx)
+		mod_timer(&tx_q->txtimer, STMMAC_COAL_TIMER(10));
+
 	__netif_tx_unlock_bh(netdev_get_tx_queue(priv->dev, queue));
 
 	return count;
@@ -2029,23 +2039,15 @@ static int stmmac_napi_check(struct stmmac_priv *priv, u32 chan)
 	int status = stmmac_dma_interrupt_status(priv, priv->ioaddr,
 						 &priv->xstats, chan);
 	struct stmmac_channel *ch = &priv->channel[chan];
-	bool needs_work = false;
-
-	if ((status & handle_rx) && ch->has_rx) {
-		needs_work = true;
-	} else {
-		status &= ~handle_rx;
-	}
 
-	if ((status & handle_tx) && ch->has_tx) {
-		needs_work = true;
-	} else {
-		status &= ~handle_tx;
+	if ((status & handle_rx) && (chan < priv->plat->rx_queues_to_use)) {
+		stmmac_disable_dma_irq(priv, priv->ioaddr, chan);
+		napi_schedule_irqoff(&ch->rx_napi);
 	}
 
-	if (needs_work && napi_schedule_prep(&ch->napi)) {
+	if ((status & handle_tx) && (chan < priv->plat->tx_queues_to_use)) {
 		stmmac_disable_dma_irq(priv, priv->ioaddr, chan);
-		__napi_schedule(&ch->napi);
+		napi_schedule_irqoff(&ch->tx_napi);
 	}
 
 	return status;
@@ -2241,8 +2243,14 @@ static void stmmac_tx_timer(struct timer_list *t)
 
 	ch = &priv->channel[tx_q->queue_index];
 
-	if (likely(napi_schedule_prep(&ch->napi)))
-		__napi_schedule(&ch->napi);
+	/*
+	 * If NAPI is already running we can miss some events. Let's rearm
+	 * the timer and try again.
+	 */
+	if (likely(napi_schedule_prep(&ch->tx_napi)))
+		__napi_schedule(&ch->tx_napi);
+	else
+		mod_timer(&tx_q->txtimer, STMMAC_COAL_TIMER(10));
 }
 
 /**
@@ -3498,7 +3506,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			else
 				skb->ip_summed = CHECKSUM_UNNECESSARY;
 
-			napi_gro_receive(&ch->napi, skb);
+			napi_gro_receive(&ch->rx_napi, skb);
 
 			priv->dev->stats.rx_packets++;
 			priv->dev->stats.rx_bytes += frame_len;
@@ -3513,40 +3521,45 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	return count;
 }
 
-/**
- *  stmmac_poll - stmmac poll method (NAPI)
- *  @napi : pointer to the napi structure.
- *  @budget : maximum number of packets that the current CPU can receive from
- *	      all interfaces.
- *  Description :
- *  To look at the incoming frames and clear the tx resources.
- */
-static int stmmac_napi_poll(struct napi_struct *napi, int budget)
+static int stmmac_napi_poll_rx(struct napi_struct *napi, int budget)
 {
 	struct stmmac_channel *ch =
-		container_of(napi, struct stmmac_channel, napi);
+		container_of(napi, struct stmmac_channel, rx_napi);
 	struct stmmac_priv *priv = ch->priv_data;
-	int work_done, rx_done = 0, tx_done = 0;
 	u32 chan = ch->index;
+	int work_done;
 
 	priv->xstats.napi_poll++;
 
-	if (ch->has_tx)
-		tx_done = stmmac_tx_clean(priv, budget, chan);
-	if (ch->has_rx)
-		rx_done = stmmac_rx(priv, budget, chan);
+	work_done = stmmac_rx(priv, budget, chan);
+	if (work_done < budget && napi_complete_done(napi, work_done))
+		stmmac_enable_dma_irq(priv, priv->ioaddr, chan);
+	return work_done;
+}
 
-	work_done = max(rx_done, tx_done);
-	work_done = min(work_done, budget);
+static int stmmac_napi_poll_tx(struct napi_struct *napi, int budget)
+{
+	struct stmmac_channel *ch =
+		container_of(napi, struct stmmac_channel, tx_napi);
+	struct stmmac_priv *priv = ch->priv_data;
+	struct stmmac_tx_queue *tx_q;
+	u32 chan = ch->index;
+	int work_done;
 
-	if (work_done < budget && napi_complete_done(napi, work_done)) {
-		int stat;
+	priv->xstats.napi_poll++;
+
+	work_done = stmmac_tx_clean(priv, DMA_TX_SIZE, chan);
+	work_done = min(work_done, budget);
 
+	if (work_done < budget && napi_complete_done(napi, work_done))
 		stmmac_enable_dma_irq(priv, priv->ioaddr, chan);
-		stat = stmmac_dma_interrupt_status(priv, priv->ioaddr,
-						   &priv->xstats, chan);
-		if (stat && napi_reschedule(napi))
-			stmmac_disable_dma_irq(priv, priv->ioaddr, chan);
+
+	/* Force transmission restart */
+	tx_q = &priv->tx_queue[chan];
+	if (tx_q->cur_tx != tx_q->dirty_tx) {
+		stmmac_enable_dma_transmission(priv, priv->ioaddr);
+		stmmac_set_tx_tail_ptr(priv, priv->ioaddr, tx_q->tx_tail_addr,
+				       chan);
 	}
 
 	return work_done;
@@ -4323,13 +4336,14 @@ int stmmac_dvr_probe(struct device *device,
 		ch->priv_data = priv;
 		ch->index = queue;
 
-		if (queue < priv->plat->rx_queues_to_use)
-			ch->has_rx = true;
-		if (queue < priv->plat->tx_queues_to_use)
-			ch->has_tx = true;
-
-		netif_napi_add(ndev, &ch->napi, stmmac_napi_poll,
-			       NAPI_POLL_WEIGHT);
+		if (queue < priv->plat->rx_queues_to_use) {
+			netif_napi_add(ndev, &ch->rx_napi, stmmac_napi_poll_rx,
+				       NAPI_POLL_WEIGHT);
+		}
+		if (queue < priv->plat->tx_queues_to_use) {
+			netif_napi_add(ndev, &ch->tx_napi, stmmac_napi_poll_tx,
+				       NAPI_POLL_WEIGHT);
+		}
 	}
 
 	mutex_init(&priv->lock);
@@ -4385,7 +4399,10 @@ int stmmac_dvr_probe(struct device *device,
 	for (queue = 0; queue < maxq; queue++) {
 		struct stmmac_channel *ch = &priv->channel[queue];
 
-		netif_napi_del(&ch->napi);
+		if (queue < priv->plat->rx_queues_to_use)
+			netif_napi_del(&ch->rx_napi);
+		if (queue < priv->plat->tx_queues_to_use)
+			netif_napi_del(&ch->tx_napi);
 	}
 error_hw_init:
 	destroy_workqueue(priv->wq);
-- 
2.7.4

