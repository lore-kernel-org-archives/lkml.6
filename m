Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E158C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2288B20651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957037;
	bh=NgMoz/xnGO/iDl+wgZZhgCWd7+3/rFMzPE/GSiGPT4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dGVeweqV6xII7lInq7QVHfsrXBkbfsbnONyAqhGVS79glBrOQtI2X/5+ImI8xoTpq
	 zbG4TXxnxB4x0M1wVIM12JuyLrpLMPKrw1WYoplGh+9LReAhnLIQFj2lerWge4Rl1p
	 OzUA8nfWUUfW+uWvJxCskb76EI6ewx7yANydpxl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfBWVXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:23:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbfBWVH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:07:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9659820855;
        Sat, 23 Feb 2019 21:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956078;
        bh=NgMoz/xnGO/iDl+wgZZhgCWd7+3/rFMzPE/GSiGPT4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Il8nTb4CZ56AxSH8stHSO9xW+qh3I8+pt8a0J2jeBFWAlKOwcs63E7Zdcx1yTRMhG
         //5QpiI3nAe0tpBhQT6cC+c+oyBFHSzZf9MJiMbXHLw91grteOTwh4soRryAWmdY0F
         awQwSah6ua3BMRct0p/X/JIKC8j06VUluAq69iXc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 50/65] net: macb: Apply RXUBR workaround only to versions with errata
Date:   Sat, 23 Feb 2019 16:06:25 -0500
Message-Id: <20190223210640.200911-50-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@xilinx.com>

[ Upstream commit e501070e4db0b67a4c17a5557d1e9d098f3db310 ]

The interrupt handler contains a workaround for RX hang applicable
to Zynq and AT91RM9200 only. Subsequent versions do not need this
workaround. This workaround unnecessarily resets RX whenever RX used
bit read is observed, which can be often under heavy traffic. There
is no other action performed on RX UBR interrupt. Hence introduce a
CAPS mask; enable this interrupt and workaround only on affected
versions.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb.h      |  3 +++
 drivers/net/ethernet/cadence/macb_main.c | 28 ++++++++++++++----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 3d45f4c92cf6e..9bbaad9f3d632 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -643,6 +643,7 @@
 #define MACB_CAPS_JUMBO				0x00000020
 #define MACB_CAPS_GEM_HAS_PTP			0x00000040
 #define MACB_CAPS_BD_RD_PREFETCH		0x00000080
+#define MACB_CAPS_NEEDS_RSTONUBR		0x00000100
 #define MACB_CAPS_FIFO_MODE			0x10000000
 #define MACB_CAPS_GIGABIT_MODE_AVAILABLE	0x20000000
 #define MACB_CAPS_SG_DISABLED			0x40000000
@@ -1214,6 +1215,8 @@ struct macb {
 
 	int	rx_bd_rd_prefetch;
 	int	tx_bd_rd_prefetch;
+
+	u32	rx_intr_mask;
 };
 
 #ifdef CONFIG_MACB_USE_HWSTAMP
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8f4b2f9a8e079..8abea1c3844fc 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -56,8 +56,7 @@
 /* level of occupied TX descriptors under which we wake up TX process */
 #define MACB_TX_WAKEUP_THRESH(bp)	(3 * (bp)->tx_ring_size / 4)
 
-#define MACB_RX_INT_FLAGS	(MACB_BIT(RCOMP) | MACB_BIT(RXUBR)	\
-				 | MACB_BIT(ISR_ROVR))
+#define MACB_RX_INT_FLAGS	(MACB_BIT(RCOMP) | MACB_BIT(ISR_ROVR))
 #define MACB_TX_ERR_FLAGS	(MACB_BIT(ISR_TUND)			\
 					| MACB_BIT(ISR_RLE)		\
 					| MACB_BIT(TXERR))
@@ -1271,7 +1270,7 @@ static int macb_poll(struct napi_struct *napi, int budget)
 				queue_writel(queue, ISR, MACB_BIT(RCOMP));
 			napi_reschedule(napi);
 		} else {
-			queue_writel(queue, IER, MACB_RX_INT_FLAGS);
+			queue_writel(queue, IER, bp->rx_intr_mask);
 		}
 	}
 
@@ -1289,7 +1288,7 @@ static void macb_hresp_error_task(unsigned long data)
 	u32 ctrl;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		queue_writel(queue, IDR, MACB_RX_INT_FLAGS |
+		queue_writel(queue, IDR, bp->rx_intr_mask |
 					 MACB_TX_INT_FLAGS |
 					 MACB_BIT(HRESP));
 	}
@@ -1319,7 +1318,7 @@ static void macb_hresp_error_task(unsigned long data)
 
 		/* Enable interrupts */
 		queue_writel(queue, IER,
-			     MACB_RX_INT_FLAGS |
+			     bp->rx_intr_mask |
 			     MACB_TX_INT_FLAGS |
 			     MACB_BIT(HRESP));
 	}
@@ -1373,14 +1372,14 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			    (unsigned int)(queue - bp->queues),
 			    (unsigned long)status);
 
-		if (status & MACB_RX_INT_FLAGS) {
+		if (status & bp->rx_intr_mask) {
 			/* There's no point taking any more interrupts
 			 * until we have processed the buffers. The
 			 * scheduling call may fail if the poll routine
 			 * is already scheduled, so disable interrupts
 			 * now.
 			 */
-			queue_writel(queue, IDR, MACB_RX_INT_FLAGS);
+			queue_writel(queue, IDR, bp->rx_intr_mask);
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, MACB_BIT(RCOMP));
 
@@ -1413,8 +1412,9 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 		/* There is a hardware issue under heavy load where DMA can
 		 * stop, this causes endless "used buffer descriptor read"
 		 * interrupts but it can be cleared by re-enabling RX. See
-		 * the at91 manual, section 41.3.1 or the Zynq manual
-		 * section 16.7.4 for details.
+		 * the at91rm9200 manual, section 41.3.1 or the Zynq manual
+		 * section 16.7.4 for details. RXUBR is only enabled for
+		 * these two versions.
 		 */
 		if (status & MACB_BIT(RXUBR)) {
 			ctrl = macb_readl(bp, NCR);
@@ -2264,7 +2264,7 @@ static void macb_init_hw(struct macb *bp)
 
 		/* Enable interrupts */
 		queue_writel(queue, IER,
-			     MACB_RX_INT_FLAGS |
+			     bp->rx_intr_mask |
 			     MACB_TX_INT_FLAGS |
 			     MACB_BIT(HRESP));
 	}
@@ -3912,6 +3912,7 @@ static const struct macb_config sama5d4_config = {
 };
 
 static const struct macb_config emac_config = {
+	.caps = MACB_CAPS_NEEDS_RSTONUBR,
 	.clk_init = at91ether_clk_init,
 	.init = at91ether_init,
 };
@@ -3933,7 +3934,8 @@ static const struct macb_config zynqmp_config = {
 };
 
 static const struct macb_config zynq_config = {
-	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_NO_GIGABIT_HALF,
+	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_NO_GIGABIT_HALF |
+		MACB_CAPS_NEEDS_RSTONUBR,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
@@ -4088,6 +4090,10 @@ static int macb_probe(struct platform_device *pdev)
 						macb_dma_desc_get_size(bp);
 	}
 
+	bp->rx_intr_mask = MACB_RX_INT_FLAGS;
+	if (bp->caps & MACB_CAPS_NEEDS_RSTONUBR)
+		bp->rx_intr_mask |= MACB_BIT(RXUBR);
+
 	mac = of_get_mac_address(np);
 	if (mac) {
 		ether_addr_copy(bp->dev->dev_addr, mac);
-- 
2.19.1

