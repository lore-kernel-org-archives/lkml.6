Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC785C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F042086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762580;
	bh=FVE9vSt+r3z5KANDpl8xfCDRe4bqMPtudzkj6tOF6Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rYp0/ZncMj3U0uX70wpTwNLQ9gtm4x4WsmD7D+QM8hP2Xcd8m+GQln4WwgACJ0h2A
	 P5NUCPdUJnVF5oCXUt6pPwUf4SYBGc/zlLktoKpuwN7jeGDI/kX/RYqDOROVPNrvdh
	 dTKY5U0UfK4PjfhPxrjy+HVYks0428YG56HA9qGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfA2Ltj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:49:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730991AbfA2Ltd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:49:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 479322083B;
        Tue, 29 Jan 2019 11:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762572;
        bh=FVE9vSt+r3z5KANDpl8xfCDRe4bqMPtudzkj6tOF6Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SOKXZvkHxfv9QztOPchTiFTJA0Yrtv2XSDEsZhxvFyJ9voeRezFlDcdogjCrNZiqT
         6fbMblLkZIBlHnmnEaGwfDQRzcU0sf2mvYB+E27TTlvumM0tR/y5mqKIbI9fgGEb5e
         FPoOazmy5dBe0LYzIRhhM7Fn2tNDvz3CmJSLuQKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <jpinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH 4.14 53/68] net: stmmac: Use correct values in TQS/RQS fields
Date:   Tue, 29 Jan 2019 12:36:15 +0100
Message-Id: <20190129113136.552952800@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jose Abreu <Jose.Abreu@synopsys.com>

commit 52a76235d0c4dd259cd0df503afed4757c04ba1d upstream.

Currently we are using all the available fifo size in RQS and
TQS fields. This will not work correctly in multi-queues IP's
because total fifo size must be splitted to the enabled queues.

Correct this by computing the available fifo size per queue and
setting the right value in TQS and RQS fields.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/common.h      |    3 ++-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   15 +++++++++------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   22 ++++++++++++++++++++--
 3 files changed, 31 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -444,7 +444,8 @@ struct stmmac_dma_ops {
 			 int rxfifosz);
 	void (*dma_rx_mode)(void __iomem *ioaddr, int mode, u32 channel,
 			    int fifosz);
-	void (*dma_tx_mode)(void __iomem *ioaddr, int mode, u32 channel);
+	void (*dma_tx_mode)(void __iomem *ioaddr, int mode, u32 channel,
+			    int fifosz);
 	/* To track extra statistic (if supported) */
 	void (*dma_diagnostic_fr) (void *data, struct stmmac_extra_stats *x,
 				   void __iomem *ioaddr);
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -271,9 +271,10 @@ static void dwmac4_dma_rx_chan_op_mode(v
 }
 
 static void dwmac4_dma_tx_chan_op_mode(void __iomem *ioaddr, int mode,
-				       u32 channel)
+				       u32 channel, int fifosz)
 {
 	u32 mtl_tx_op = readl(ioaddr + MTL_CHAN_TX_OP_MODE(channel));
+	unsigned int tqs = fifosz / 256 - 1;
 
 	if (mode == SF_DMA_MODE) {
 		pr_debug("GMAC: enable TX store and forward mode\n");
@@ -306,12 +307,14 @@ static void dwmac4_dma_tx_chan_op_mode(v
 	 * For an IP with DWC_EQOS_NUM_TXQ > 1, the fields TXQEN and TQS are R/W
 	 * with reset values: TXQEN off, TQS 256 bytes.
 	 *
-	 * Write the bits in both cases, since it will have no effect when RO.
-	 * For DWC_EQOS_NUM_TXQ > 1, the top bits in MTL_OP_MODE_TQS_MASK might
-	 * be RO, however, writing the whole TQS field will result in a value
-	 * equal to DWC_EQOS_TXFIFO_SIZE, just like for DWC_EQOS_NUM_TXQ == 1.
+	 * TXQEN must be written for multi-channel operation and TQS must
+	 * reflect the available fifo size per queue (total fifo size / number
+	 * of enabled queues).
 	 */
-	mtl_tx_op |= MTL_OP_MODE_TXQEN | MTL_OP_MODE_TQS_MASK;
+	mtl_tx_op |= MTL_OP_MODE_TXQEN;
+	mtl_tx_op &= ~MTL_OP_MODE_TQS_MASK;
+	mtl_tx_op |= tqs << MTL_OP_MODE_TQS_SHIFT;
+
 	writel(mtl_tx_op, ioaddr +  MTL_CHAN_TX_OP_MODE(channel));
 }
 
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1765,12 +1765,19 @@ static void stmmac_dma_operation_mode(st
 	u32 rx_channels_count = priv->plat->rx_queues_to_use;
 	u32 tx_channels_count = priv->plat->tx_queues_to_use;
 	int rxfifosz = priv->plat->rx_fifo_size;
+	int txfifosz = priv->plat->tx_fifo_size;
 	u32 txmode = 0;
 	u32 rxmode = 0;
 	u32 chan = 0;
 
 	if (rxfifosz == 0)
 		rxfifosz = priv->dma_cap.rx_fifo_size;
+	if (txfifosz == 0)
+		txfifosz = priv->dma_cap.tx_fifo_size;
+
+	/* Adjust for real per queue fifo size */
+	rxfifosz /= rx_channels_count;
+	txfifosz /= tx_channels_count;
 
 	if (priv->plat->force_thresh_dma_mode) {
 		txmode = tc;
@@ -1798,7 +1805,8 @@ static void stmmac_dma_operation_mode(st
 						   rxfifosz);
 
 		for (chan = 0; chan < tx_channels_count; chan++)
-			priv->hw->dma->dma_tx_mode(priv->ioaddr, txmode, chan);
+			priv->hw->dma->dma_tx_mode(priv->ioaddr, txmode, chan,
+						   txfifosz);
 	} else {
 		priv->hw->dma->dma_mode(priv->ioaddr, txmode, rxmode,
 					rxfifosz);
@@ -1967,15 +1975,25 @@ static void stmmac_tx_err(struct stmmac_
 static void stmmac_set_dma_operation_mode(struct stmmac_priv *priv, u32 txmode,
 					  u32 rxmode, u32 chan)
 {
+	u32 rx_channels_count = priv->plat->rx_queues_to_use;
+	u32 tx_channels_count = priv->plat->tx_queues_to_use;
 	int rxfifosz = priv->plat->rx_fifo_size;
+	int txfifosz = priv->plat->tx_fifo_size;
 
 	if (rxfifosz == 0)
 		rxfifosz = priv->dma_cap.rx_fifo_size;
+	if (txfifosz == 0)
+		txfifosz = priv->dma_cap.tx_fifo_size;
+
+	/* Adjust for real per queue fifo size */
+	rxfifosz /= rx_channels_count;
+	txfifosz /= tx_channels_count;
 
 	if (priv->synopsys_id >= DWMAC_CORE_4_00) {
 		priv->hw->dma->dma_rx_mode(priv->ioaddr, rxmode, chan,
 					   rxfifosz);
-		priv->hw->dma->dma_tx_mode(priv->ioaddr, txmode, chan);
+		priv->hw->dma->dma_tx_mode(priv->ioaddr, txmode, chan,
+					   txfifosz);
 	} else {
 		priv->hw->dma->dma_mode(priv->ioaddr, txmode, rxmode,
 					rxfifosz);


