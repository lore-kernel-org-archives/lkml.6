Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F53FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083BF20657
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083BF20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbeGQPFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:05:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42460 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731432AbeGQPFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:05:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A7E3F20765; Tue, 17 Jul 2018 16:32:15 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 641B520884;
        Tue, 17 Jul 2018 16:31:59 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com
Subject: [PATCH RESEND 5/5] spi: imx: Use the longuest possible burst size when in dynamic_burst
Date:   Tue, 17 Jul 2018 16:31:54 +0200
Message-Id: <20180717143154.28241-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
References: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic burst mode allows to group together multiple words and send them
in one continuous burst. When the number of bytes to be sent is not a
strict multiple of the FIFO entry size (32 bits), the controller expects
the non aligned bits to be sent first.

This commit adds support for this particular constraint, avoiding the
need to send the non-aligned bytes one by one at the end of the
transfer, speeding-up transfer speed in that case.

With this method, a transfer is divided into multiple bursts, limited in
size by the maximum amount of data that the controller can transfer in
one continuous burst (which is 512 bytes).

The non-512 byte part of the transfer is sent first. The remaining bytes
to be transferred in the current burst is stored in the 'remainder'
field.

With this method, the read_u32 field is no longer necessary, and is
removed.

This was tested on imx6 solo and imx6 quad.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/spi/spi-imx.c | 122 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 85 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index ef6d3648396a..08dd3a31a3e5 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -94,7 +94,7 @@ struct spi_imx_data {
 	void *rx_buf;
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
-	unsigned int dynamic_burst, read_u32;
+	unsigned int dynamic_burst;
 
 	/* Slave mode */
 	bool slave_mode;
@@ -139,6 +139,8 @@ static void spi_imx_buf_rx_##type(struct spi_imx_data *spi_imx)		\
 		*(type *)spi_imx->rx_buf = val;				\
 		spi_imx->rx_buf += sizeof(type);			\
 	}								\
+									\
+	spi_imx->remainder -= sizeof(type);				\
 }
 
 #define MXC_SPI_BUF_TX(type)						\
@@ -292,22 +294,36 @@ static void spi_imx_buf_rx_swap_u32(struct spi_imx_data *spi_imx)
 		*(u32 *)spi_imx->rx_buf = val;
 		spi_imx->rx_buf += sizeof(u32);
 	}
+
+	spi_imx->remainder -= sizeof(u32);
 }
 
 static void spi_imx_buf_rx_swap(struct spi_imx_data *spi_imx)
 {
-	unsigned int bytes_per_word;
+	int unaligned;
+	u32 val;
 
-	bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
-	if (spi_imx->read_u32) {
+	unaligned = spi_imx->remainder % 4;
+
+	if (!unaligned) {
 		spi_imx_buf_rx_swap_u32(spi_imx);
 		return;
 	}
 
-	if (bytes_per_word == 1)
-		spi_imx_buf_rx_u8(spi_imx);
-	else if (bytes_per_word == 2)
+	if (spi_imx_bytes_per_word(spi_imx->bits_per_word) == 2) {
 		spi_imx_buf_rx_u16(spi_imx);
+		return;
+	}
+
+	val = readl(spi_imx->base + MXC_CSPIRXDATA);
+
+	while (unaligned--) {
+		if (spi_imx->rx_buf) {
+			*(u8 *)spi_imx->rx_buf = (val >> (8 * unaligned)) & 0xff;
+			spi_imx->rx_buf++;
+		}
+		spi_imx->remainder--;
+	}
 }
 
 static void spi_imx_buf_tx_swap_u32(struct spi_imx_data *spi_imx)
@@ -336,40 +352,30 @@ static void spi_imx_buf_tx_swap_u32(struct spi_imx_data *spi_imx)
 
 static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
 {
-	u32 ctrl, val;
-	unsigned int bytes_per_word;
+	int unaligned;
+	u32 val = 0;
 
-	if (spi_imx->count == spi_imx->remainder) {
-		ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
-		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
-		if (spi_imx->count > MX51_ECSPI_CTRL_MAX_BURST) {
-			spi_imx->remainder = spi_imx->count %
-					     MX51_ECSPI_CTRL_MAX_BURST;
-			val = MX51_ECSPI_CTRL_MAX_BURST * 8 - 1;
-		} else if (spi_imx->count >= sizeof(u32)) {
-			spi_imx->remainder = spi_imx->count % sizeof(u32);
-			val = (spi_imx->count - spi_imx->remainder) * 8 - 1;
-		} else {
-			spi_imx->remainder = 0;
-			val = spi_imx->bits_per_word - 1;
-			spi_imx->read_u32 = 0;
-		}
+	unaligned = spi_imx->count % 4;
 
-		ctrl |= (val << MX51_ECSPI_CTRL_BL_OFFSET);
-		writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
+	if (!unaligned) {
+		spi_imx_buf_tx_swap_u32(spi_imx);
+		return;
 	}
 
-	if (spi_imx->count >= sizeof(u32)) {
-		spi_imx_buf_tx_swap_u32(spi_imx);
+	if (spi_imx_bytes_per_word(spi_imx->bits_per_word) == 2) {
+		spi_imx_buf_tx_u16(spi_imx);
 		return;
 	}
 
-	bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
+	while (unaligned--) {
+		if (spi_imx->tx_buf) {
+			val |= *(u8 *)spi_imx->tx_buf << (8 * unaligned);
+			spi_imx->tx_buf++;
+		}
+		spi_imx->count--;
+	}
 
-	if (bytes_per_word == 1)
-		spi_imx_buf_tx_u8(spi_imx);
-	else if (bytes_per_word == 2)
-		spi_imx_buf_tx_u16(spi_imx);
+	writel(val, spi_imx->base + MXC_CSPITXDATA);
 }
 
 static void mx53_ecspi_rx_slave(struct spi_imx_data *spi_imx)
@@ -388,6 +394,8 @@ static void mx53_ecspi_rx_slave(struct spi_imx_data *spi_imx)
 		spi_imx->rx_buf += n_bytes;
 		spi_imx->slave_burst -= n_bytes;
 	}
+
+	spi_imx->remainder -= sizeof(u32);
 }
 
 static void mx53_ecspi_tx_slave(struct spi_imx_data *spi_imx)
@@ -997,12 +1005,52 @@ static void spi_imx_chipselect(struct spi_device *spi, int is_active)
 	gpio_set_value(spi->cs_gpio, dev_is_lowactive ^ active);
 }
 
+static void spi_imx_set_burst_len(struct spi_imx_data *spi_imx, int n_bits)
+{
+	u32 ctrl;
+
+	ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
+	ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
+	ctrl |= ((n_bits - 1) << MX51_ECSPI_CTRL_BL_OFFSET);
+	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
+}
+
 static void spi_imx_push(struct spi_imx_data *spi_imx)
 {
+	unsigned int burst_len, fifo_words;
+
+	if (spi_imx->dynamic_burst)
+		fifo_words = 4;
+	else
+		fifo_words = spi_imx_bytes_per_word(spi_imx->bits_per_word);
+	/*
+	 * Reload the FIFO when the remaining bytes to be transferred in the
+	 * current burst is 0. This only applies when bits_per_word is a
+	 * multiple of 8.
+	 */
+	if (!spi_imx->remainder) {
+		if (spi_imx->dynamic_burst) {
+
+			/* We need to deal unaligned data first */
+			burst_len = spi_imx->count % MX51_ECSPI_CTRL_MAX_BURST;
+
+			if (!burst_len)
+				burst_len = MX51_ECSPI_CTRL_MAX_BURST;
+
+			spi_imx_set_burst_len(spi_imx, burst_len * 8);
+
+			spi_imx->remainder = burst_len;
+		} else {
+			spi_imx->remainder = fifo_words;
+		}
+	}
+
 	while (spi_imx->txfifo < spi_imx->devtype_data->fifo_size) {
 		if (!spi_imx->count)
 			break;
-		if (spi_imx->txfifo && (spi_imx->count == spi_imx->remainder))
+		if (spi_imx->dynamic_burst &&
+		    spi_imx->txfifo >=  DIV_ROUND_UP(spi_imx->remainder,
+						     fifo_words))
 			break;
 		spi_imx->tx(spi_imx);
 		spi_imx->txfifo++;
@@ -1108,12 +1156,9 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	    spi_imx->bits_per_word == 16 ||
 	    spi_imx->bits_per_word == 32)) {
 
-		spi_imx->read_u32  = 1;
-
 		spi_imx->rx = spi_imx_buf_rx_swap;
 		spi_imx->tx = spi_imx_buf_tx_swap;
 		spi_imx->dynamic_burst = 1;
-		spi_imx->remainder = t->len;
 
 	} else {
 		if (spi_imx->bits_per_word <= 8) {
@@ -1126,6 +1171,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 			spi_imx->rx = spi_imx_buf_rx_u32;
 			spi_imx->tx = spi_imx_buf_tx_u32;
 		}
+		spi_imx->dynamic_burst = 0;
 	}
 
 	if (spi_imx_can_dma(spi_imx->bitbang.master, spi, t))
@@ -1309,6 +1355,7 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 	spi_imx->rx_buf = transfer->rx_buf;
 	spi_imx->count = transfer->len;
 	spi_imx->txfifo = 0;
+	spi_imx->remainder = 0;
 
 	reinit_completion(&spi_imx->xfer_done);
 
@@ -1346,6 +1393,7 @@ static int spi_imx_pio_transfer_slave(struct spi_device *spi,
 	spi_imx->rx_buf = transfer->rx_buf;
 	spi_imx->count = transfer->len;
 	spi_imx->txfifo = 0;
+	spi_imx->remainder = 0;
 
 	reinit_completion(&spi_imx->xfer_done);
 	spi_imx->slave_aborted = false;
-- 
2.11.0

