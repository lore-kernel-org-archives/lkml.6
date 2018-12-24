Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7DDC676F1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE27321873
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cryASmQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbeLXWBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:01:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39267 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeLXWBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:01:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so12538281wra.6;
        Mon, 24 Dec 2018 14:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HK6/u5N0Qx3JrdyMAJuIBQVQ5HicGr8fdzjz92KPW2w=;
        b=cryASmQCVSXwXJo+MCrD2GLftqXZLQeLLKit8bRWBbRHuUN6wBsMfkclKL5hS2oPMl
         5usuwPNaGhwfpkxKUPs908doAItKvFMGzgMZupFaC9v6/FuHuTppsPAogok4nkRwQC7R
         O2OtC0J7x8iRrKOFWskGOain1bak/XC/gnOETuU/7i/2V9n1z96wzEZ/A3oqQ0A3G/0F
         sp+2RAmwd24YvvcBjk0InSCozzz0+yJKiuQWJKSPey3bhHawIgahhEYLKmuXw3U6sGoS
         9cQCxHQHYmkg3vBzBu+vEQ0qhI70AL2bUjHckbwuVmTWJJm2GICXOz4w72a4VaGyhlH3
         DRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HK6/u5N0Qx3JrdyMAJuIBQVQ5HicGr8fdzjz92KPW2w=;
        b=aLHo8nTnVrlXlFqrifdLgcZWRuMNfjnde3qM1ktDVuLu2unwtDWgngX43o0av9lWNJ
         DErwMdxIo49QjeGWtziH0opxEzQR1S+FQl+cXayGOHzwB72H1K2dbJpMqSEb3IWMX87J
         YoWk0BXf9DTUzrLr0Hp4sRLe4IjFmXz5vhKqAmfMPdt2H2rvGiA347VD6uivNqO3f3A5
         bd0OLU5+6McAo3IvH7ws9yEYt6Cfc+7Lgr5BTx0BbxgAEBL/aPNLOwEH4CSZXUqL4XF4
         RnPQPX0bvrQTC+9O/TLbbLNrSRYjnO3sMu7tX+ciBsASQ6oafy/aVvD+ImL26ZYnvddL
         fyww==
X-Gm-Message-State: AJcUukcapS1Nl58DDXuvLpNc7BWiiwdBg+nEPJIIIFd4Rt76T4txb+Rq
        t/B9C8t5wao9uAfIXgraUmI=
X-Google-Smtp-Source: ALg8bN6yBOxVvwdOhC2AcHXWyLJ/YQnu0ZUyToj97zQhKrf4ef1s52Bzy/by7dl5hSq1fHnba2Am+g==
X-Received: by 2002:adf:d243:: with SMTP id o3mr13489694wri.66.1545688872533;
        Mon, 24 Dec 2018 14:01:12 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl. [83.23.22.20])
        by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.01.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 14:01:11 -0800 (PST)
From:   cezary.gapinski@gmail.com
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: [PATCH v2 12/14] spi: stm32: add support for STM32F4
Date:   Mon, 24 Dec 2018 23:00:38 +0100
Message-Id: <1545688840-23992-13-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Add routines, registers & bitfield definition. Also baud rate divisor
definitions for STM32F4 SPI. This version supports full-duplex,
simplex TX and half-duplex TX communication with 8 or 16-bit per word.
DMA capability is optionally supported for transfer longer than 16 bytes.
For transfer less than 16 bytes frames can be send in discontinuous mode.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 489 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 482 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 8b10074..4186ed2 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -20,6 +20,59 @@
 
 #define DRIVER_NAME "spi_stm32"
 
+/* STM32F4 SPI registers */
+#define STM32F4_SPI_CR1			0x00
+#define STM32F4_SPI_CR2			0x04
+#define STM32F4_SPI_SR			0x08
+#define STM32F4_SPI_DR			0x0C
+#define STM32F4_SPI_I2SCFGR		0x1C
+
+/* STM32F4_SPI_CR1 bit fields */
+#define STM32F4_SPI_CR1_CPHA		BIT(0)
+#define STM32F4_SPI_CR1_CPOL		BIT(1)
+#define STM32F4_SPI_CR1_MSTR		BIT(2)
+#define STM32F4_SPI_CR1_BR_SHIFT	3
+#define STM32F4_SPI_CR1_BR		GENMASK(5, 3)
+#define STM32F4_SPI_CR1_SPE		BIT(6)
+#define STM32F4_SPI_CR1_LSBFRST		BIT(7)
+#define STM32F4_SPI_CR1_SSI		BIT(8)
+#define STM32F4_SPI_CR1_SSM		BIT(9)
+#define STM32F4_SPI_CR1_RXONLY		BIT(10)
+#define STM32F4_SPI_CR1_DFF		BIT(11)
+#define STM32F4_SPI_CR1_CRCNEXT		BIT(12)
+#define STM32F4_SPI_CR1_CRCEN		BIT(13)
+#define STM32F4_SPI_CR1_BIDIOE		BIT(14)
+#define STM32F4_SPI_CR1_BIDIMODE	BIT(15)
+#define STM32F4_SPI_CR1_BR_MIN		0
+#define STM32F4_SPI_CR1_BR_MAX		(GENMASK(5, 3) >> 3)
+
+/* STM32F4_SPI_CR2 bit fields */
+#define STM32F4_SPI_CR2_RXDMAEN		BIT(0)
+#define STM32F4_SPI_CR2_TXDMAEN		BIT(1)
+#define STM32F4_SPI_CR2_SSOE		BIT(2)
+#define STM32F4_SPI_CR2_FRF		BIT(4)
+#define STM32F4_SPI_CR2_ERRIE		BIT(5)
+#define STM32F4_SPI_CR2_RXNEIE		BIT(6)
+#define STM32F4_SPI_CR2_TXEIE		BIT(7)
+
+/* STM32F4_SPI_SR bit fields */
+#define STM32F4_SPI_SR_RXNE		BIT(0)
+#define STM32F4_SPI_SR_TXE		BIT(1)
+#define STM32F4_SPI_SR_CHSIDE		BIT(2)
+#define STM32F4_SPI_SR_UDR		BIT(3)
+#define STM32F4_SPI_SR_CRCERR		BIT(4)
+#define STM32F4_SPI_SR_MODF		BIT(5)
+#define STM32F4_SPI_SR_OVR		BIT(6)
+#define STM32F4_SPI_SR_BSY		BIT(7)
+#define STM32F4_SPI_SR_FRE		BIT(8)
+
+/* STM32F4_SPI_I2SCFGR bit fields */
+#define STM32F4_SPI_I2SCFGR_I2SMOD	BIT(11)
+
+/* STM32F4 SPI Baud Rate min/max divisor */
+#define STM32F4_SPI_BR_DIV_MIN		(2 << STM32F4_SPI_CR1_BR_MIN)
+#define STM32F4_SPI_BR_DIV_MAX		(2 << STM32F4_SPI_CR1_BR_MAX)
+
 /* STM32H7 SPI registers */
 #define STM32H7_SPI_CR1			0x00
 #define STM32H7_SPI_CR2			0x04
@@ -116,6 +169,12 @@
 
 #define SPI_1HZ_NS		1000000000
 
+/*
+ * use PIO for small transfers, avoiding DMA setup/teardown overhead for drivers
+ * without fifo buffers.
+ */
+#define SPI_DMA_MIN_BYTES	16
+
 /**
  * stm32_spi_reg - stm32 SPI register & bitfield desc
  * @reg:		register offset
@@ -257,6 +316,21 @@ struct stm32_spi {
 	dma_addr_t phys_addr;
 };
 
+static const struct stm32_spi_regspec stm32f4_spi_regspec = {
+	.en = { STM32F4_SPI_CR1, STM32F4_SPI_CR1_SPE },
+
+	.dma_rx_en = { STM32F4_SPI_CR2, STM32F4_SPI_CR2_RXDMAEN },
+	.dma_tx_en = { STM32F4_SPI_CR2, STM32F4_SPI_CR2_TXDMAEN },
+
+	.cpol = { STM32F4_SPI_CR1, STM32F4_SPI_CR1_CPOL },
+	.cpha = { STM32F4_SPI_CR1, STM32F4_SPI_CR1_CPHA },
+	.lsb_first = { STM32F4_SPI_CR1, STM32F4_SPI_CR1_LSBFRST },
+	.br = { STM32F4_SPI_CR1, STM32F4_SPI_CR1_BR, STM32F4_SPI_CR1_BR_SHIFT },
+
+	.rx = { STM32F4_SPI_DR },
+	.tx = { STM32F4_SPI_DR },
+};
+
 static const struct stm32_spi_regspec stm32h7_spi_regspec = {
 	/* SPI data transfer is enabled but spi_ker_ck is idle.
 	 * CFG1 and CFG2 registers are write protected when SPE is enabled.
@@ -316,6 +390,16 @@ static int stm32h7_spi_get_fifo_size(struct stm32_spi *spi)
 }
 
 /**
+ * stm32f4_spi_get_bpw_mask - Return bits per word mask
+ * @spi: pointer to the spi controller data structure
+ */
+static int stm32f4_spi_get_bpw_mask(struct stm32_spi *spi)
+{
+	dev_dbg(spi->dev, "8-bit or 16-bit data frame supported\n");
+	return SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+}
+
+/**
  * stm32h7_spi_get_bpw_mask - Return bits per word mask
  * @spi: pointer to the spi controller data structure
  */
@@ -409,6 +493,35 @@ static u32 stm32h7_spi_prepare_fthlv(struct stm32_spi *spi)
 }
 
 /**
+ * stm32f4_spi_write_tx - Write bytes to Transmit Data Register
+ * @spi: pointer to the spi controller data structure
+ *
+ * Read from tx_buf depends on remaining bytes to avoid to read beyond
+ * tx_buf end.
+ */
+static void stm32f4_spi_write_tx(struct stm32_spi *spi)
+{
+	if ((spi->tx_len > 0) && (readl_relaxed(spi->base + STM32F4_SPI_SR) &
+				  STM32F4_SPI_SR_TXE)) {
+		u32 offs = spi->cur_xferlen - spi->tx_len;
+
+		if (spi->cur_bpw == 16) {
+			const u16 *tx_buf16 = (const u16 *)(spi->tx_buf + offs);
+
+			writew_relaxed(*tx_buf16, spi->base + STM32F4_SPI_DR);
+			spi->tx_len -= sizeof(u16);
+		} else {
+			const u8 *tx_buf8 = (const u8 *)(spi->tx_buf + offs);
+
+			writeb_relaxed(*tx_buf8, spi->base + STM32F4_SPI_DR);
+			spi->tx_len -= sizeof(u8);
+		}
+	}
+
+	dev_dbg(spi->dev, "%s: %d bytes left\n", __func__, spi->tx_len);
+}
+
+/**
  * stm32h7_spi_write_txfifo - Write bytes in Transmit Data Register
  * @spi: pointer to the spi controller data structure
  *
@@ -444,6 +557,35 @@ static void stm32h7_spi_write_txfifo(struct stm32_spi *spi)
 }
 
 /**
+ * stm32f4_spi_read_rx - Read bytes from Receive Data Register
+ * @spi: pointer to the spi controller data structure
+ *
+ * Write in rx_buf depends on remaining bytes to avoid to write beyond
+ * rx_buf end.
+ */
+static void stm32f4_spi_read_rx(struct stm32_spi *spi)
+{
+	if ((spi->rx_len > 0) && (readl_relaxed(spi->base + STM32F4_SPI_SR) &
+				  STM32F4_SPI_SR_RXNE)) {
+		u32 offs = spi->cur_xferlen - spi->rx_len;
+
+		if (spi->cur_bpw == 16) {
+			u16 *rx_buf16 = (u16 *)(spi->rx_buf + offs);
+
+			*rx_buf16 = readw_relaxed(spi->base + STM32F4_SPI_DR);
+			spi->rx_len -= sizeof(u16);
+		} else {
+			u8 *rx_buf8 = (u8 *)(spi->rx_buf + offs);
+
+			*rx_buf8 = readb_relaxed(spi->base + STM32F4_SPI_DR);
+			spi->rx_len -= sizeof(u8);
+		}
+	}
+
+	dev_dbg(spi->dev, "%s: %d bytes left\n", __func__, spi->rx_len);
+}
+
+/**
  * stm32h7_spi_read_rxfifo - Read bytes in Receive Data Register
  * @spi: pointer to the spi controller data structure
  *
@@ -502,6 +644,54 @@ static void stm32_spi_enable(struct stm32_spi *spi)
 }
 
 /**
+ * stm32f4_spi_disable - Disable SPI controller
+ * @spi: pointer to the spi controller data structure
+ */
+static void stm32f4_spi_disable(struct stm32_spi *spi)
+{
+	unsigned long flags;
+	u32 sr;
+
+	dev_dbg(spi->dev, "disable controller\n");
+
+	spin_lock_irqsave(&spi->lock, flags);
+
+	if (!(readl_relaxed(spi->base + STM32F4_SPI_CR1) &
+	      STM32F4_SPI_CR1_SPE)) {
+		spin_unlock_irqrestore(&spi->lock, flags);
+		return;
+	}
+
+	/* Disable interrupts */
+	stm32_spi_clr_bits(spi, STM32F4_SPI_CR2, STM32F4_SPI_CR2_TXEIE |
+						 STM32F4_SPI_CR2_RXNEIE |
+						 STM32F4_SPI_CR2_ERRIE);
+
+	/* Wait until BSY = 0 */
+	if (readl_relaxed_poll_timeout_atomic(spi->base + STM32F4_SPI_SR,
+					      sr, !(sr & STM32F4_SPI_SR_BSY),
+					      10, 100000) < 0) {
+		dev_warn(spi->dev, "disabling condition timeout\n");
+	}
+
+	if (spi->cur_usedma && spi->dma_tx)
+		dmaengine_terminate_all(spi->dma_tx);
+	if (spi->cur_usedma && spi->dma_rx)
+		dmaengine_terminate_all(spi->dma_rx);
+
+	stm32_spi_clr_bits(spi, STM32F4_SPI_CR1, STM32F4_SPI_CR1_SPE);
+
+	stm32_spi_clr_bits(spi, STM32F4_SPI_CR2, STM32F4_SPI_CR2_TXDMAEN |
+						 STM32F4_SPI_CR2_RXDMAEN);
+
+	/* Sequence to clear OVR flag */
+	readl_relaxed(spi->base + STM32F4_SPI_DR);
+	readl_relaxed(spi->base + STM32F4_SPI_SR);
+
+	spin_unlock_irqrestore(&spi->lock, flags);
+}
+
+/**
  * stm32h7_spi_disable - Disable SPI controller
  * @spi: pointer to the spi controller data structure
  *
@@ -568,18 +758,128 @@ static void stm32h7_spi_disable(struct stm32_spi *spi)
 /**
  * stm32_spi_can_dma - Determine if the transfer is eligible for DMA use
  *
- * If the current transfer size is greater than fifo size, use DMA.
+ * If driver has fifo and the current transfer size is greater than fifo size,
+ * use DMA. Otherwise use DMA for transfer longer than defined DMA min bytes.
  */
 static bool stm32_spi_can_dma(struct spi_master *master,
 			      struct spi_device *spi_dev,
 			      struct spi_transfer *transfer)
 {
+	unsigned int dma_size;
 	struct stm32_spi *spi = spi_master_get_devdata(master);
 
+	if (spi->cfg->has_fifo)
+		dma_size = spi->fifo_size;
+	else
+		dma_size = SPI_DMA_MIN_BYTES;
+
 	dev_dbg(spi->dev, "%s: %s\n", __func__,
-		(transfer->len > spi->fifo_size) ? "true" : "false");
+		(transfer->len > dma_size) ? "true" : "false");
+
+	return (transfer->len > dma_size);
+}
+
+/**
+ * stm32f4_spi_irq_event - Interrupt handler for SPI controller events
+ * @irq: interrupt line
+ * @dev_id: SPI controller master interface
+ */
+static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
+{
+	struct spi_master *master = dev_id;
+	struct stm32_spi *spi = spi_master_get_devdata(master);
+	u32 sr, mask = 0;
+	unsigned long flags;
+	bool end = false;
+
+	spin_lock_irqsave(&spi->lock, flags);
+
+	sr = readl_relaxed(spi->base + STM32F4_SPI_SR);
+	/*
+	 * BSY flag is not handled in interrupt but it is normal behavior when
+	 * this flag is set.
+	 */
+	sr &= ~STM32F4_SPI_SR_BSY;
+
+	if (!spi->cur_usedma && (spi->cur_comm == SPI_SIMPLEX_TX ||
+				 spi->cur_comm == SPI_3WIRE_TX)) {
+		/* OVR flag shouldn't be handled for TX only mode */
+		sr &= ~STM32F4_SPI_SR_OVR | STM32F4_SPI_SR_RXNE;
+		mask |= STM32F4_SPI_SR_TXE;
+	}
+
+	if (!spi->cur_usedma && spi->cur_comm == SPI_FULL_DUPLEX) {
+		/* TXE flag is set and is handled when RXNE flag occurs */
+		sr &= ~STM32F4_SPI_SR_TXE;
+		mask |= STM32F4_SPI_SR_RXNE | STM32F4_SPI_SR_OVR;
+	}
+
+	if (!(sr & mask)) {
+		dev_dbg(spi->dev, "spurious IT (sr=0x%08x)\n", sr);
+		spin_unlock_irqrestore(&spi->lock, flags);
+		return IRQ_NONE;
+	}
+
+	if (sr & STM32F4_SPI_SR_OVR) {
+		dev_warn(spi->dev, "Overrun: received value discarded\n");
+
+		/* Sequence to clear OVR flag */
+		readl_relaxed(spi->base + STM32F4_SPI_DR);
+		readl_relaxed(spi->base + STM32F4_SPI_SR);
+
+		/*
+		 * If overrun is detected, it means that something went wrong,
+		 * so stop the current transfer. Transfer can wait for next
+		 * RXNE but DR is already read and end never happens.
+		 */
+		end = true;
+		goto end_irq;
+	}
+
+	if (sr & STM32F4_SPI_SR_TXE) {
+		if (spi->tx_buf)
+			stm32f4_spi_write_tx(spi);
+		if (spi->tx_len == 0)
+			end = true;
+	}
+
+	if (sr & STM32F4_SPI_SR_RXNE) {
+		stm32f4_spi_read_rx(spi);
+		if (spi->rx_len == 0)
+			end = true;
+		else /* Load data for discontinuous mode */
+			stm32f4_spi_write_tx(spi);
+	}
+
+end_irq:
+	if (end) {
+		/* Immediately disable interrupts to do not generate new one */
+		stm32_spi_clr_bits(spi, STM32F4_SPI_CR2,
+					STM32F4_SPI_CR2_TXEIE |
+					STM32F4_SPI_CR2_RXNEIE |
+					STM32F4_SPI_CR2_ERRIE);
+		spin_unlock_irqrestore(&spi->lock, flags);
+		return IRQ_WAKE_THREAD;
+	}
+
+	spin_unlock_irqrestore(&spi->lock, flags);
+	return IRQ_HANDLED;
+}
+
+/**
+ * stm32f4_spi_irq_thread - Thread of interrupt handler for SPI controller
+ * @irq: interrupt line
+ * @dev_id: SPI controller master interface
+ */
+static irqreturn_t stm32f4_spi_irq_thread(int irq, void *dev_id)
+{
+	struct spi_master *master = dev_id;
+	struct stm32_spi *spi = spi_master_get_devdata(master);
+
+	spi_finalize_current_transfer(master);
+	stm32f4_spi_disable(spi);
 
-	return (transfer->len > spi->fifo_size);
+	return IRQ_HANDLED;
 }
 
 /**
@@ -749,6 +1049,34 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
 }
 
 /**
+ * stm32f4_spi_dma_tx_cb - dma callback
+ *
+ * DMA callback is called when the transfer is complete for DMA TX channel.
+ */
+static void stm32f4_spi_dma_tx_cb(void *data)
+{
+	struct stm32_spi *spi = data;
+
+	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX) {
+		spi_finalize_current_transfer(spi->master);
+		stm32f4_spi_disable(spi);
+	}
+}
+
+/**
+ * stm32f4_spi_dma_rx_cb - dma callback
+ *
+ * DMA callback is called when the transfer is complete for DMA RX channel.
+ */
+static void stm32f4_spi_dma_rx_cb(void *data)
+{
+	struct stm32_spi *spi = data;
+
+	spi_finalize_current_transfer(spi->master);
+	stm32f4_spi_disable(spi);
+}
+
+/**
  * stm32h7_spi_dma_cb - dma callback
  *
  * DMA callback is called when the transfer is complete or when an error
@@ -790,11 +1118,15 @@ static void stm32_spi_dma_config(struct stm32_spi *spi,
 	else
 		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-	/* Valid for DMA Half or Full Fifo threshold */
-	if (spi->cur_fthlv == 2)
+	if (spi->cfg->has_fifo) {
+		/* Valid for DMA Half or Full Fifo threshold */
+		if (spi->cur_fthlv == 2)
+			maxburst = 1;
+		else
+			maxburst = spi->cur_fthlv;
+	} else {
 		maxburst = 1;
-	else
-		maxburst = spi->cur_fthlv;
+	}
 
 	memset(dma_conf, 0, sizeof(struct dma_slave_config));
 	dma_conf->direction = dir;
@@ -816,6 +1148,46 @@ static void stm32_spi_dma_config(struct stm32_spi *spi,
 }
 
 /**
+ * stm32f4_spi_transfer_one_irq - transfer a single spi_transfer using
+ *				  interrupts
+ *
+ * It must returns 0 if the transfer is finished or 1 if the transfer is still
+ * in progress.
+ */
+static int stm32f4_spi_transfer_one_irq(struct stm32_spi *spi)
+{
+	unsigned long flags;
+	u32 cr2 = 0;
+
+	/* Enable the interrupts relative to the current communication mode */
+	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX) {
+		cr2 |= STM32F4_SPI_CR2_TXEIE;
+	} else if (spi->cur_comm == SPI_FULL_DUPLEX) {
+		/* In transmit-only mode, the OVR flag is set in the SR register
+		 * since the received data are never read. Therefore set OVR
+		 * interrupt only when rx buffer is available.
+		 */
+		cr2 |= STM32F4_SPI_CR2_RXNEIE | STM32F4_SPI_CR2_ERRIE;
+	} else {
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&spi->lock, flags);
+
+	stm32_spi_set_bits(spi, STM32F4_SPI_CR2, cr2);
+
+	stm32_spi_enable(spi);
+
+	/* starting data transfer when buffer is loaded */
+	if (spi->tx_buf)
+		stm32f4_spi_write_tx(spi);
+
+	spin_unlock_irqrestore(&spi->lock, flags);
+
+	return 1;
+}
+
+/**
  * stm32h7_spi_transfer_one_irq - transfer a single spi_transfer using
  *				  interrupts
  *
@@ -857,6 +1229,26 @@ static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
 }
 
 /**
+ * stm32f4_spi_transfer_one_dma_start - Set SPI driver registers to start
+ *					transfer using DMA
+ */
+static void stm32f4_spi_transfer_one_dma_start(struct stm32_spi *spi)
+{
+	/* In DMA mode end of transfer is handled by DMA TX or RX callback. */
+	if (spi->cur_comm == SPI_SIMPLEX_RX || spi->cur_comm == SPI_3WIRE_RX ||
+	    spi->cur_comm == SPI_FULL_DUPLEX) {
+		/*
+		 * In transmit-only mode, the OVR flag is set in the SR register
+		 * since the received data are never read. Therefore set OVR
+		 * interrupt only when rx buffer is available.
+		 */
+		stm32_spi_set_bits(spi, STM32F4_SPI_CR2, STM32F4_SPI_CR2_ERRIE);
+	}
+
+	stm32_spi_enable(spi);
+}
+
+/**
  * stm32h7_spi_transfer_one_dma_start - Set SPI driver registers to start
  *					transfer using DMA
  */
@@ -977,6 +1369,18 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 }
 
 /**
+ * stm32f4_spi_set_bpw - Configure bits per word
+ * @spi: pointer to the spi controller data structure
+ */
+static void stm32f4_spi_set_bpw(struct stm32_spi *spi)
+{
+	if (spi->cur_bpw == 16)
+		stm32_spi_set_bits(spi, STM32F4_SPI_CR1, STM32F4_SPI_CR1_DFF);
+	else
+		stm32_spi_clr_bits(spi, STM32F4_SPI_CR1, STM32F4_SPI_CR1_DFF);
+}
+
+/**
  * stm32h7_spi_set_bpw - configure bits per word
  * @spi: pointer to the spi controller data structure
  */
@@ -1054,6 +1458,28 @@ static unsigned int stm32_spi_communication_type(struct spi_device *spi_dev,
 }
 
 /**
+ * stm32f4_spi_set_mode - configure communication mode
+ * @spi: pointer to the spi controller data structure
+ * @comm_type: type of communication to configure
+ */
+static int stm32f4_spi_set_mode(struct stm32_spi *spi, unsigned int comm_type)
+{
+	if (comm_type == SPI_3WIRE_TX || comm_type == SPI_SIMPLEX_TX) {
+		stm32_spi_set_bits(spi, STM32F4_SPI_CR1,
+					STM32F4_SPI_CR1_BIDIMODE |
+					STM32F4_SPI_CR1_BIDIOE);
+	} else if (comm_type == SPI_FULL_DUPLEX) {
+		stm32_spi_clr_bits(spi, STM32F4_SPI_CR1,
+					STM32F4_SPI_CR1_BIDIMODE |
+					STM32F4_SPI_CR1_BIDIOE);
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
  * stm32h7_spi_set_mode - configure communication mode
  * @spi: pointer to the spi controller data structure
  * @comm_type: type of communication to configure
@@ -1268,6 +1694,36 @@ static int stm32_spi_unprepare_msg(struct spi_master *master,
 }
 
 /**
+ * stm32f4_spi_config - Configure SPI controller as SPI master
+ */
+static int stm32f4_spi_config(struct stm32_spi *spi)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&spi->lock, flags);
+
+	/* Ensure I2SMOD bit is kept cleared */
+	stm32_spi_clr_bits(spi, STM32F4_SPI_I2SCFGR,
+			   STM32F4_SPI_I2SCFGR_I2SMOD);
+
+	/*
+	 * - SS input value high
+	 * - transmitter half duplex direction
+	 * - Set the master mode (default Motorola mode)
+	 * - Consider 1 master/n slaves configuration and
+	 *   SS input value is determined by the SSI bit
+	 */
+	stm32_spi_set_bits(spi, STM32F4_SPI_CR1, STM32F4_SPI_CR1_SSI |
+						 STM32F4_SPI_CR1_BIDIOE |
+						 STM32F4_SPI_CR1_MSTR |
+						 STM32F4_SPI_CR1_SSM);
+
+	spin_unlock_irqrestore(&spi->lock, flags);
+
+	return 0;
+}
+
+/**
  * stm32h7_spi_config - Configure SPI controller as SPI master
  */
 static int stm32h7_spi_config(struct stm32_spi *spi)
@@ -1304,6 +1760,24 @@ static int stm32h7_spi_config(struct stm32_spi *spi)
 	return 0;
 }
 
+static const struct stm32_spi_cfg stm32f4_spi_cfg = {
+	.regs = &stm32f4_spi_regspec,
+	.get_bpw_mask = stm32f4_spi_get_bpw_mask,
+	.disable = stm32f4_spi_disable,
+	.config = stm32f4_spi_config,
+	.set_bpw = stm32f4_spi_set_bpw,
+	.set_mode = stm32f4_spi_set_mode,
+	.transfer_one_dma_start = stm32f4_spi_transfer_one_dma_start,
+	.dma_tx_cb = stm32f4_spi_dma_tx_cb,
+	.dma_rx_cb = stm32f4_spi_dma_rx_cb,
+	.transfer_one_irq = stm32f4_spi_transfer_one_irq,
+	.irq_handler_event = stm32f4_spi_irq_event,
+	.irq_handler_thread = stm32f4_spi_irq_thread,
+	.baud_rate_div_min = STM32F4_SPI_BR_DIV_MIN,
+	.baud_rate_div_max = STM32F4_SPI_BR_DIV_MAX,
+	.has_fifo = false,
+};
+
 static const struct stm32_spi_cfg stm32h7_spi_cfg = {
 	.regs = &stm32h7_spi_regspec,
 	.get_fifo_size = stm32h7_spi_get_fifo_size,
@@ -1326,6 +1800,7 @@ static const struct stm32_spi_cfg stm32h7_spi_cfg = {
 
 static const struct of_device_id stm32_spi_of_match[] = {
 	{ .compatible = "st,stm32h7-spi", .data = (void *)&stm32h7_spi_cfg },
+	{ .compatible = "st,stm32f4-spi", .data = (void *)&stm32f4_spi_cfg },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_spi_of_match);
-- 
2.7.4

