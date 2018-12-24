Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982DBC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B4721873
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHjVb72S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeLXWBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:01:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51755 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeLXWBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:01:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so12007425wmj.1;
        Mon, 24 Dec 2018 14:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DWtMJCCPNn8K9WomP5bJVva/ensb35NjsYtY9byfOJE=;
        b=PHjVb72SLcmRqYEvVhZmBCeU5Qmd/eybNSjh/cTazYK0gnKoVCloPrn8NlKOCornnC
         4Ri1FmInObEgrNY+kE0XLEzGVYqRBSKoV7iqoCYBWNkkS/aX9t431fXFVgwSbnlAJB6Z
         zL0fgRbAgfng4gBS4Gv8H0V/uQJjrJdYocJiOm4GNRU8sK84sbqGGM/RKhJSAYa6wdgd
         1I+ycjip0waMK8mFpLCHitLTXqVmBzPKqdy4KH5K1xV6xOkpTtE0UgdVqRw/jUsDiCgU
         y6ZXKWyyPZfJHlq4rbXp/gUydk4HVVF6eq84MjR/r8N/uPKFToYynWSJTsFQDdVJz9gh
         ll9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DWtMJCCPNn8K9WomP5bJVva/ensb35NjsYtY9byfOJE=;
        b=DYv/FYI2o2c+XrbCkuZBibymS31IurDLrGJfBINNofbHM5WUblRxjqijrKjAymrUO9
         xY5zMPU9WoYdywTr2F2BOy2fVCWbouA1l+Pja26rq7aaWmmnpCUZ+cgWMkA2lyLClCac
         Rft1YGFxE7mYs3XUEBQQ4szkm0QKit8pMn5hFUJt7KqMdRl/a4GpEXI55d6sy87hgJZm
         eBAn4B/08XaYUNZOzaM2uGFI8tDkv1Htf/1bgls0sEcQcQWTq5gYk+WTTkl850aFxeut
         aFhdvOhc9qe36EteF0yiRrtq7cexUjRaU1vN6XZOv/sUWZwOXXSt+KdYs6tlfDsqJ8+F
         2NfA==
X-Gm-Message-State: AA+aEWaR7TWOLMr8Cr7msn17w2wkXuZ3gC1G6FcTb0SopkmLFmCfvK9o
        X4aa7+vyUQJhgbd6AJ/nQakWTtgCoEs=
X-Google-Smtp-Source: AFSGD/U9V8lSd09j/36YRAgeiKVCxrtX6Hg/padMXazCReaUB/aB7EKxKglX02+f7GXvScNLmIWFOA==
X-Received: by 2002:a1c:448a:: with SMTP id r132mr12696653wma.47.1545688870830;
        Mon, 24 Dec 2018 14:01:10 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl. [83.23.22.20])
        by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 14:01:10 -0800 (PST)
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
Subject: [PATCH v2 11/14] spi: stm32: introduce compatible data cfg
Date:   Mon, 24 Dec 2018 23:00:37 +0100
Message-Id: <1545688840-23992-12-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Prepare support for STM32F4 spi variant by introducing compatible
configuration data.
Move STM32H7 specific stuff to compatible data structure:
 - registers & bit fields
 - routines to control driver
 - baud rate divisor definitions
 - fifo availability
 - split IRQ functions to parts to be called when the IRQ occurs
   and for threaded interrupt what helps to provide less discontinuous
   mode for drivers without FIFO.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 337 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 236 insertions(+), 101 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index b19d02b..8b10074 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -117,9 +117,95 @@
 #define SPI_1HZ_NS		1000000000
 
 /**
+ * stm32_spi_reg - stm32 SPI register & bitfield desc
+ * @reg:		register offset
+ * @mask:		bitfield mask
+ * @shift:		left shift
+ */
+struct stm32_spi_reg {
+	int reg;
+	int mask;
+	int shift;
+};
+
+/**
+ * stm32_spi_regspec - stm32 registers definition, compatible dependent data
+ * en: enable register and SPI enable bit
+ * dma_rx_en: SPI DMA RX enable register end SPI DMA RX enable bit
+ * dma_tx_en: SPI DMA TX enable register end SPI DMA TX enable bit
+ * cpol: clock polarity register and polarity bit
+ * cpha: clock phase register and phase bit
+ * lsb_first: LSB transmitted first register and bit
+ * br: baud rate register and bitfields
+ * rx: SPI RX data register
+ * tx: SPI TX data register
+ */
+struct stm32_spi_regspec {
+	const struct stm32_spi_reg en;
+	const struct stm32_spi_reg dma_rx_en;
+	const struct stm32_spi_reg dma_tx_en;
+	const struct stm32_spi_reg cpol;
+	const struct stm32_spi_reg cpha;
+	const struct stm32_spi_reg lsb_first;
+	const struct stm32_spi_reg br;
+	const struct stm32_spi_reg rx;
+	const struct stm32_spi_reg tx;
+};
+
+struct stm32_spi;
+
+/**
+ * stm32_spi_cfg - stm32 compatible configuration data
+ * @regs: registers descriptions
+ * @get_fifo_size: routine to get fifo size
+ * @get_bpw_mask: routine to get bits per word mask
+ * @disable: routine to disable controller
+ * @config: routine to configure controller as SPI Master
+ * @set_bpw: routine to configure registers to for bits per word
+ * @set_mode: routine to configure registers to desired mode
+ * @set_data_idleness: optional routine to configure registers to desired idle
+ * time between frames (if driver has this functionality)
+ * set_number_of_data: optional routine to configure registers to desired
+ * number of data (if driver has this functionality)
+ * @can_dma: routine to determine if the transfer is eligible for DMA use
+ * @transfer_one_dma_start: routine to start transfer a single spi_transfer
+ * using DMA
+ * @dma_rx cb: routine to call after DMA RX channel operation is complete
+ * @dma_tx cb: routine to call after DMA TX channel operation is complete
+ * @transfer_one_irq: routine to configure interrupts for driver
+ * @irq_handler_event: Interrupt handler for SPI controller events
+ * @irq_handler_thread: thread of interrupt handler for SPI controller
+ * @baud_rate_div_min: minimum baud rate divisor
+ * @baud_rate_div_max: maximum baud rate divisor
+ * @has_fifo: boolean to know if fifo is used for driver
+ * @has_startbit: boolean to know if start bit is used to start transfer
+ */
+struct stm32_spi_cfg {
+	const struct stm32_spi_regspec *regs;
+	int (*get_fifo_size)(struct stm32_spi *spi);
+	int (*get_bpw_mask)(struct stm32_spi *spi);
+	void (*disable)(struct stm32_spi *spi);
+	int (*config)(struct stm32_spi *spi);
+	void (*set_bpw)(struct stm32_spi *spi);
+	int (*set_mode)(struct stm32_spi *spi, unsigned int comm_type);
+	void (*set_data_idleness)(struct stm32_spi *spi, u32 length);
+	int (*set_number_of_data)(struct stm32_spi *spi, u32 length);
+	void (*transfer_one_dma_start)(struct stm32_spi *spi);
+	void (*dma_rx_cb)(void *data);
+	void (*dma_tx_cb)(void *data);
+	int (*transfer_one_irq)(struct stm32_spi *spi);
+	irqreturn_t (*irq_handler_event)(int irq, void *dev_id);
+	irqreturn_t (*irq_handler_thread)(int irq, void *dev_id);
+	unsigned int baud_rate_div_min;
+	unsigned int baud_rate_div_max;
+	bool has_fifo;
+};
+
+/**
  * struct stm32_spi - private data of the SPI controller
  * @dev: driver model representation of the controller
  * @master: controller master interface
+ * @cfg: compatible configuration data
  * @base: virtual memory area
  * @clk: hw kernel clock feeding the SPI clock generator
  * @clk_rate: rate of the hw kernel clock feeding the SPI clock generator
@@ -145,6 +231,7 @@
 struct stm32_spi {
 	struct device *dev;
 	struct spi_master *master;
+	const struct stm32_spi_cfg *cfg;
 	void __iomem *base;
 	struct clk *clk;
 	u32 clk_rate;
@@ -170,6 +257,25 @@ struct stm32_spi {
 	dma_addr_t phys_addr;
 };
 
+static const struct stm32_spi_regspec stm32h7_spi_regspec = {
+	/* SPI data transfer is enabled but spi_ker_ck is idle.
+	 * CFG1 and CFG2 registers are write protected when SPE is enabled.
+	 */
+	.en = { STM32H7_SPI_CR1, STM32H7_SPI_CR1_SPE },
+
+	.dma_rx_en = { STM32H7_SPI_CFG1, STM32H7_SPI_CFG1_RXDMAEN },
+	.dma_tx_en = { STM32H7_SPI_CFG1, STM32H7_SPI_CFG1_TXDMAEN },
+
+	.cpol = { STM32H7_SPI_CFG2, STM32H7_SPI_CFG2_CPOL },
+	.cpha = { STM32H7_SPI_CFG2, STM32H7_SPI_CFG2_CPHA },
+	.lsb_first = { STM32H7_SPI_CFG2, STM32H7_SPI_CFG2_LSBFRST },
+	.br = { STM32H7_SPI_CFG1, STM32H7_SPI_CFG1_MBR,
+		STM32H7_SPI_CFG1_MBR_SHIFT },
+
+	.rx = { STM32H7_SPI_RXDR },
+	.tx = { STM32H7_SPI_TXDR },
+};
+
 static inline void stm32_spi_set_bits(struct stm32_spi *spi,
 				      u32 offset, u32 bits)
 {
@@ -185,10 +291,10 @@ static inline void stm32_spi_clr_bits(struct stm32_spi *spi,
 }
 
 /**
- * stm32_spi_get_fifo_size - Return fifo size
+ * stm32h7_spi_get_fifo_size - Return fifo size
  * @spi: pointer to the spi controller data structure
  */
-static int stm32_spi_get_fifo_size(struct stm32_spi *spi)
+static int stm32h7_spi_get_fifo_size(struct stm32_spi *spi)
 {
 	unsigned long flags;
 	u32 count = 0;
@@ -210,10 +316,10 @@ static int stm32_spi_get_fifo_size(struct stm32_spi *spi)
 }
 
 /**
- * stm32_spi_get_bpw_mask - Return bits per word mask
+ * stm32h7_spi_get_bpw_mask - Return bits per word mask
  * @spi: pointer to the spi controller data structure
  */
-static int stm32_spi_get_bpw_mask(struct stm32_spi *spi)
+static int stm32h7_spi_get_bpw_mask(struct stm32_spi *spi)
 {
 	unsigned long flags;
 	u32 cfg1, max_bpw;
@@ -276,10 +382,10 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz,
 }
 
 /**
- * stm32_spi_prepare_fthlv - Determine FIFO threshold level
+ * stm32h7_spi_prepare_fthlv - Determine FIFO threshold level
  * @spi: pointer to the spi controller data structure
  */
-static u32 stm32_spi_prepare_fthlv(struct stm32_spi *spi)
+static u32 stm32h7_spi_prepare_fthlv(struct stm32_spi *spi)
 {
 	u32 fthlv, half_fifo;
 
@@ -303,13 +409,13 @@ static u32 stm32_spi_prepare_fthlv(struct stm32_spi *spi)
 }
 
 /**
- * stm32_spi_write_txfifo - Write bytes in Transmit Data Register
+ * stm32h7_spi_write_txfifo - Write bytes in Transmit Data Register
  * @spi: pointer to the spi controller data structure
  *
  * Read from tx_buf depends on remaining bytes to avoid to read beyond
  * tx_buf end.
  */
-static void stm32_spi_write_txfifo(struct stm32_spi *spi)
+static void stm32h7_spi_write_txfifo(struct stm32_spi *spi)
 {
 	while ((spi->tx_len > 0) &&
 		       (readl_relaxed(spi->base + STM32H7_SPI_SR) &
@@ -338,13 +444,13 @@ static void stm32_spi_write_txfifo(struct stm32_spi *spi)
 }
 
 /**
- * stm32_spi_read_rxfifo - Read bytes in Receive Data Register
+ * stm32h7_spi_read_rxfifo - Read bytes in Receive Data Register
  * @spi: pointer to the spi controller data structure
  *
  * Write in rx_buf depends on remaining bytes to avoid to write beyond
  * rx_buf end.
  */
-static void stm32_spi_read_rxfifo(struct stm32_spi *spi, bool flush)
+static void stm32h7_spi_read_rxfifo(struct stm32_spi *spi, bool flush)
 {
 	u32 sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
 	u32 rxplvl = (sr & STM32H7_SPI_SR_RXPLVL) >>
@@ -386,26 +492,28 @@ static void stm32_spi_read_rxfifo(struct stm32_spi *spi, bool flush)
 /**
  * stm32_spi_enable - Enable SPI controller
  * @spi: pointer to the spi controller data structure
- *
- * SPI data transfer is enabled but spi_ker_ck is idle.
- * SPI_CFG1 and SPI_CFG2 are now write protected.
  */
 static void stm32_spi_enable(struct stm32_spi *spi)
 {
 	dev_dbg(spi->dev, "enable controller\n");
 
-	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_SPE);
+	stm32_spi_set_bits(spi, spi->cfg->regs->en.reg,
+			   spi->cfg->regs->en.mask);
 }
 
 /**
- * stm32_spi_disable - Disable SPI controller
+ * stm32h7_spi_disable - Disable SPI controller
  * @spi: pointer to the spi controller data structure
  *
  * RX-Fifo is flushed when SPI controller is disabled. To prevent any data
- * loss, use stm32_spi_read_rxfifo(flush) to read the remaining bytes in
+ * loss, use stm32h7_spi_read_rxfifo(flush) to read the remaining bytes in
  * RX-Fifo.
+ * Normally, if TSIZE has been configured, we should relax the hardware at the
+ * reception of the EOT interrupt. But in case of error, EOT will not be
+ * raised. So the subsystem unprepare_message call allows us to properly
+ * complete the transfer from an hardware point of view.
  */
-static void stm32_spi_disable(struct stm32_spi *spi)
+static void stm32h7_spi_disable(struct stm32_spi *spi)
 {
 	unsigned long flags;
 	u32 cr1, sr;
@@ -438,7 +546,7 @@ static void stm32_spi_disable(struct stm32_spi *spi)
 	}
 
 	if (!spi->cur_usedma && spi->rx_buf && (spi->rx_len > 0))
-		stm32_spi_read_rxfifo(spi, true);
+		stm32h7_spi_read_rxfifo(spi, true);
 
 	if (spi->cur_usedma && spi->dma_tx)
 		dmaengine_terminate_all(spi->dma_tx);
@@ -475,11 +583,11 @@ static bool stm32_spi_can_dma(struct spi_master *master,
 }
 
 /**
- * stm32_spi_irq_thread - Thread of interrupt handler for SPI controller
+ * stm32h7_spi_irq_thread - Thread of interrupt handler for SPI controller
  * @irq: interrupt line
  * @dev_id: SPI controller master interface
  */
-static irqreturn_t stm32_spi_irq_thread(int irq, void *dev_id)
+static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 {
 	struct spi_master *master = dev_id;
 	struct stm32_spi *spi = spi_master_get_devdata(master);
@@ -513,7 +621,7 @@ static irqreturn_t stm32_spi_irq_thread(int irq, void *dev_id)
 	if (sr & STM32H7_SPI_SR_SUSP) {
 		dev_warn(spi->dev, "Communication suspended\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
-			stm32_spi_read_rxfifo(spi, false);
+			stm32h7_spi_read_rxfifo(spi, false);
 		/*
 		 * If communication is suspended while using DMA, it means
 		 * that something went wrong, so stop the current transfer
@@ -530,7 +638,7 @@ static irqreturn_t stm32_spi_irq_thread(int irq, void *dev_id)
 	if (sr & STM32H7_SPI_SR_OVR) {
 		dev_warn(spi->dev, "Overrun: received value discarded\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
-			stm32_spi_read_rxfifo(spi, false);
+			stm32h7_spi_read_rxfifo(spi, false);
 		/*
 		 * If overrun is detected while using DMA, it means that
 		 * something went wrong, so stop the current transfer
@@ -541,17 +649,17 @@ static irqreturn_t stm32_spi_irq_thread(int irq, void *dev_id)
 
 	if (sr & STM32H7_SPI_SR_EOT) {
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
-			stm32_spi_read_rxfifo(spi, true);
+			stm32h7_spi_read_rxfifo(spi, true);
 		end = true;
 	}
 
 	if (sr & STM32H7_SPI_SR_TXP)
 		if (!spi->cur_usedma && (spi->tx_buf && (spi->tx_len > 0)))
-			stm32_spi_write_txfifo(spi);
+			stm32h7_spi_write_txfifo(spi);
 
 	if (sr & STM32H7_SPI_SR_RXP)
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
-			stm32_spi_read_rxfifo(spi, false);
+			stm32h7_spi_read_rxfifo(spi, false);
 
 	writel_relaxed(mask, spi->base + STM32H7_SPI_IFCR);
 
@@ -559,7 +667,7 @@ static irqreturn_t stm32_spi_irq_thread(int irq, void *dev_id)
 
 	if (end) {
 		spi_finalize_current_transfer(master);
-		stm32_spi_disable(spi);
+		stm32h7_spi_disable(spi);
 	}
 
 	return IRQ_HANDLED;
@@ -598,7 +706,7 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
 	struct spi_device *spi_dev = msg->spi;
 	struct device_node *np = spi_dev->dev.of_node;
 	unsigned long flags;
-	u32 cfg2_clrb = 0, cfg2_setb = 0;
+	u32 clrb = 0, setb = 0;
 
 	/* SPI slave device may need time between data frames */
 	spi->cur_midi = 0;
@@ -606,19 +714,19 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
 		dev_dbg(spi->dev, "%dns inter-data idleness\n", spi->cur_midi);
 
 	if (spi_dev->mode & SPI_CPOL)
-		cfg2_setb |= STM32H7_SPI_CFG2_CPOL;
+		setb |= spi->cfg->regs->cpol.mask;
 	else
-		cfg2_clrb |= STM32H7_SPI_CFG2_CPOL;
+		clrb |= spi->cfg->regs->cpol.mask;
 
 	if (spi_dev->mode & SPI_CPHA)
-		cfg2_setb |= STM32H7_SPI_CFG2_CPHA;
+		setb |= spi->cfg->regs->cpha.mask;
 	else
-		cfg2_clrb |= STM32H7_SPI_CFG2_CPHA;
+		clrb |= spi->cfg->regs->cpha.mask;
 
 	if (spi_dev->mode & SPI_LSB_FIRST)
-		cfg2_setb |= STM32H7_SPI_CFG2_LSBFRST;
+		setb |= spi->cfg->regs->lsb_first.mask;
 	else
-		cfg2_clrb |= STM32H7_SPI_CFG2_LSBFRST;
+		clrb |= spi->cfg->regs->lsb_first.mask;
 
 	dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
 		spi_dev->mode & SPI_CPOL,
@@ -628,11 +736,12 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
 
 	spin_lock_irqsave(&spi->lock, flags);
 
-	if (cfg2_clrb || cfg2_setb)
+	/* CPOL, CPHA and LSB FIRST bits have common register */
+	if (clrb || setb)
 		writel_relaxed(
-			(readl_relaxed(spi->base + STM32H7_SPI_CFG2) &
-				~cfg2_clrb) | cfg2_setb,
-			       spi->base + STM32H7_SPI_CFG2);
+			(readl_relaxed(spi->base + spi->cfg->regs->cpol.reg) &
+			 ~clrb) | setb,
+			spi->base + spi->cfg->regs->cpol.reg);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -640,12 +749,12 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
 }
 
 /**
- * stm32_spi_dma_cb - dma callback
+ * stm32h7_spi_dma_cb - dma callback
  *
  * DMA callback is called when the transfer is complete or when an error
  * occurs. If the transfer is complete, EOT flag is raised.
  */
-static void stm32_spi_dma_cb(void *data)
+static void stm32h7_spi_dma_cb(void *data)
 {
 	struct stm32_spi *spi = data;
 	unsigned long flags;
@@ -690,14 +799,14 @@ static void stm32_spi_dma_config(struct stm32_spi *spi,
 	memset(dma_conf, 0, sizeof(struct dma_slave_config));
 	dma_conf->direction = dir;
 	if (dma_conf->direction == DMA_DEV_TO_MEM) { /* RX */
-		dma_conf->src_addr = spi->phys_addr + STM32H7_SPI_RXDR;
+		dma_conf->src_addr = spi->phys_addr + spi->cfg->regs->rx.reg;
 		dma_conf->src_addr_width = buswidth;
 		dma_conf->src_maxburst = maxburst;
 
 		dev_dbg(spi->dev, "Rx DMA config buswidth=%d, maxburst=%d\n",
 			buswidth, maxburst);
 	} else if (dma_conf->direction == DMA_MEM_TO_DEV) { /* TX */
-		dma_conf->dst_addr = spi->phys_addr + STM32H7_SPI_TXDR;
+		dma_conf->dst_addr = spi->phys_addr + spi->cfg->regs->tx.reg;
 		dma_conf->dst_addr_width = buswidth;
 		dma_conf->dst_maxburst = maxburst;
 
@@ -707,13 +816,13 @@ static void stm32_spi_dma_config(struct stm32_spi *spi,
 }
 
 /**
- * stm32_spi_transfer_one_irq - transfer a single spi_transfer using
- *				interrupts
+ * stm32h7_spi_transfer_one_irq - transfer a single spi_transfer using
+ *				  interrupts
  *
  * It must returns 0 if the transfer is finished or 1 if the transfer is still
  * in progress.
  */
-static int stm32_spi_transfer_one_irq(struct stm32_spi *spi)
+static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
 {
 	unsigned long flags;
 	u32 ier = 0;
@@ -736,7 +845,7 @@ static int stm32_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	/* Be sure to have data in fifo before starting data transfer */
 	if (spi->tx_buf)
-		stm32_spi_write_txfifo(spi);
+		stm32h7_spi_write_txfifo(spi);
 
 	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
 
@@ -748,10 +857,10 @@ static int stm32_spi_transfer_one_irq(struct stm32_spi *spi)
 }
 
 /**
- * stm32_spi_transfer_one_dma_start - Set SPI driver registers to start transfer
- *				      using DMA
+ * stm32h7_spi_transfer_one_dma_start - Set SPI driver registers to start
+ *					transfer using DMA
  */
-static void stm32_spi_transfer_one_dma_start(struct stm32_spi *spi)
+static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
 {
 	/* Enable the interrupts relative to the end of transfer */
 	stm32_spi_set_bits(spi, STM32H7_SPI_IER, STM32H7_SPI_IER_EOTIE |
@@ -785,8 +894,8 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 		dmaengine_slave_config(spi->dma_rx, &rx_dma_conf);
 
 		/* Enable Rx DMA request */
-		stm32_spi_set_bits(spi, STM32H7_SPI_CFG1,
-				   STM32H7_SPI_CFG1_RXDMAEN);
+		stm32_spi_set_bits(spi, spi->cfg->regs->dma_rx_en.reg,
+				   spi->cfg->regs->dma_rx_en.mask);
 
 		rx_dma_desc = dmaengine_prep_slave_sg(
 					spi->dma_rx, xfer->rx_sg.sgl,
@@ -815,7 +924,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 		goto dma_desc_error;
 
 	if (rx_dma_desc) {
-		rx_dma_desc->callback = stm32_spi_dma_cb;
+		rx_dma_desc->callback = spi->cfg->dma_rx_cb;
 		rx_dma_desc->callback_param = spi;
 
 		if (dma_submit_error(dmaengine_submit(rx_dma_desc))) {
@@ -829,7 +938,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	if (tx_dma_desc) {
 		if (spi->cur_comm == SPI_SIMPLEX_TX ||
 		    spi->cur_comm == SPI_3WIRE_TX) {
-			tx_dma_desc->callback = stm32_spi_dma_cb;
+			tx_dma_desc->callback = spi->cfg->dma_tx_cb;
 			tx_dma_desc->callback_param = spi;
 		}
 
@@ -841,11 +950,11 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 		dma_async_issue_pending(spi->dma_tx);
 
 		/* Enable Tx DMA request */
-		stm32_spi_set_bits(spi, STM32H7_SPI_CFG1,
-				   STM32H7_SPI_CFG1_TXDMAEN);
+		stm32_spi_set_bits(spi, spi->cfg->regs->dma_tx_en.reg,
+				   spi->cfg->regs->dma_tx_en.mask);
 	}
 
-	stm32_spi_transfer_one_dma_start(spi);
+	spi->cfg->transfer_one_dma_start(spi);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -856,21 +965,22 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 		dmaengine_terminate_all(spi->dma_rx);
 
 dma_desc_error:
-	stm32_spi_clr_bits(spi, STM32H7_SPI_CFG1, STM32H7_SPI_CFG1_RXDMAEN);
+	stm32_spi_clr_bits(spi, spi->cfg->regs->dma_rx_en.reg,
+			   spi->cfg->regs->dma_rx_en.mask);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
 	dev_info(spi->dev, "DMA issue: fall back to irq transfer\n");
 
 	spi->cur_usedma = false;
-	return stm32_spi_transfer_one_irq(spi);
+	return spi->cfg->transfer_one_irq(spi);
 }
 
 /**
- * stm32_spi_set_bpw - configure bits per word
+ * stm32h7_spi_set_bpw - configure bits per word
  * @spi: pointer to the spi controller data structure
  */
-static void stm32_spi_set_bpw(struct stm32_spi *spi)
+static void stm32h7_spi_set_bpw(struct stm32_spi *spi)
 {
 	u32 bpw, fthlv;
 	u32 cfg1_clrb = 0, cfg1_setb = 0;
@@ -881,7 +991,7 @@ static void stm32_spi_set_bpw(struct stm32_spi *spi)
 	cfg1_setb |= (bpw << STM32H7_SPI_CFG1_DSIZE_SHIFT) &
 		     STM32H7_SPI_CFG1_DSIZE;
 
-	spi->cur_fthlv = stm32_spi_prepare_fthlv(spi);
+	spi->cur_fthlv = stm32h7_spi_prepare_fthlv(spi);
 	fthlv = spi->cur_fthlv - 1;
 
 	cfg1_clrb |= STM32H7_SPI_CFG1_FTHLV;
@@ -901,15 +1011,15 @@ static void stm32_spi_set_bpw(struct stm32_spi *spi)
  */
 static void stm32_spi_set_mbr(struct stm32_spi *spi, u32 mbrdiv)
 {
-	u32 cfg1_clrb = 0, cfg1_setb = 0;
+	u32 clrb = 0, setb = 0;
 
-	cfg1_clrb |= STM32H7_SPI_CFG1_MBR;
-	cfg1_setb |= ((u32)mbrdiv << STM32H7_SPI_CFG1_MBR_SHIFT) &
-		STM32H7_SPI_CFG1_MBR;
+	clrb |= spi->cfg->regs->br.mask;
+	setb |= ((u32)mbrdiv << spi->cfg->regs->br.shift) &
+		spi->cfg->regs->br.mask;
 
-	writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CFG1) &
-			~cfg1_clrb) | cfg1_setb,
-		       spi->base + STM32H7_SPI_CFG1);
+	writel_relaxed((readl_relaxed(spi->base + spi->cfg->regs->br.reg) &
+			~clrb) | setb,
+		       spi->base + spi->cfg->regs->br.reg);
 }
 
 /**
@@ -944,11 +1054,11 @@ static unsigned int stm32_spi_communication_type(struct spi_device *spi_dev,
 }
 
 /**
- * stm32_spi_set_mode - configure communication mode
+ * stm32h7_spi_set_mode - configure communication mode
  * @spi: pointer to the spi controller data structure
  * @comm_type: type of communication to configure
  */
-static int stm32_spi_set_mode(struct stm32_spi *spi, unsigned int comm_type)
+static int stm32h7_spi_set_mode(struct stm32_spi *spi, unsigned int comm_type)
 {
 	u32 mode;
 	u32 cfg2_clrb = 0, cfg2_setb = 0;
@@ -980,12 +1090,12 @@ static int stm32_spi_set_mode(struct stm32_spi *spi, unsigned int comm_type)
 }
 
 /**
- * stm32_spi_data_idleness - configure minimum time delay inserted between two
- *			     consecutive data frames in master mode
+ * stm32h7_spi_data_idleness - configure minimum time delay inserted between two
+ *			       consecutive data frames in master mode
  * @spi: pointer to the spi controller data structure
  * @len: transfer len
  */
-static void stm32_spi_data_idleness(struct stm32_spi *spi, u32 len)
+static void stm32h7_spi_data_idleness(struct stm32_spi *spi, u32 len)
 {
 	u32 cfg2_clrb = 0, cfg2_setb = 0;
 
@@ -1008,11 +1118,11 @@ static void stm32_spi_data_idleness(struct stm32_spi *spi, u32 len)
 }
 
 /**
- * stm32_spi_number_of_data - configure number of data at current transfer
+ * stm32h7_spi_number_of_data - configure number of data at current transfer
  * @spi: pointer to the spi controller data structure
  * @len: transfer length
  */
-static int stm32_spi_number_of_data(struct stm32_spi *spi, u32 nb_words)
+static int stm32h7_spi_number_of_data(struct stm32_spi *spi, u32 nb_words)
 {
 	u32 cr2_clrb = 0, cr2_setb = 0;
 
@@ -1047,7 +1157,7 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 
 	if (spi->cur_bpw != transfer->bits_per_word) {
 		spi->cur_bpw = transfer->bits_per_word;
-		stm32_spi_set_bpw(spi);
+		spi->cfg->set_bpw(spi);
 	}
 
 	if (spi->cur_speed != transfer->speed_hz) {
@@ -1055,8 +1165,8 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 
 		/* Update spi->cur_speed with real clock speed */
 		mbr = stm32_spi_prepare_mbr(spi, transfer->speed_hz,
-					    STM32H7_SPI_MBR_DIV_MIN,
-					    STM32H7_SPI_MBR_DIV_MAX);
+					    spi->cfg->baud_rate_div_min,
+					    spi->cfg->baud_rate_div_max);
 		if (mbr < 0) {
 			ret = mbr;
 			goto out;
@@ -1068,7 +1178,7 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 
 	comm_type = stm32_spi_communication_type(spi_dev, transfer);
 	if (spi->cur_comm != comm_type) {
-		stm32_spi_set_mode(spi, comm_type);
+		ret = spi->cfg->set_mode(spi, comm_type);
 
 		if (ret < 0)
 			goto out;
@@ -1076,7 +1186,8 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 		spi->cur_comm = comm_type;
 	}
 
-	stm32_spi_data_idleness(spi, transfer->len);
+	if (spi->cfg->set_data_idleness)
+		spi->cfg->set_data_idleness(spi, transfer->len);
 
 	if (spi->cur_bpw <= 8)
 		nb_words = transfer->len;
@@ -1085,9 +1196,11 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 	else
 		nb_words = DIV_ROUND_UP(transfer->len * 8, 32);
 
-	ret = stm32_spi_number_of_data(spi, nb_words);
-	if (ret < 0)
-		goto out;
+	if (spi->cfg->set_number_of_data) {
+		ret = spi->cfg->set_number_of_data(spi, nb_words);
+		if (ret < 0)
+			goto out;
+	}
 
 	spi->cur_xferlen = transfer->len;
 
@@ -1138,31 +1251,26 @@ static int stm32_spi_transfer_one(struct spi_master *master,
 	if (spi->cur_usedma)
 		return stm32_spi_transfer_one_dma(spi, transfer);
 	else
-		return stm32_spi_transfer_one_irq(spi);
+		return spi->cfg->transfer_one_irq(spi);
 }
 
 /**
  * stm32_spi_unprepare_msg - relax the hardware
- *
- * Normally, if TSIZE has been configured, we should relax the hardware at the
- * reception of the EOT interrupt. But in case of error, EOT will not be
- * raised. So the subsystem unprepare_message call allows us to properly
- * complete the transfer from an hardware point of view.
  */
 static int stm32_spi_unprepare_msg(struct spi_master *master,
 				   struct spi_message *msg)
 {
 	struct stm32_spi *spi = spi_master_get_devdata(master);
 
-	stm32_spi_disable(spi);
+	spi->cfg->disable(spi);
 
 	return 0;
 }
 
 /**
- * stm32_spi_config - Configure SPI controller as SPI master
+ * stm32h7_spi_config - Configure SPI controller as SPI master
  */
-static int stm32_spi_config(struct stm32_spi *spi)
+static int stm32h7_spi_config(struct stm32_spi *spi)
 {
 	unsigned long flags;
 
@@ -1196,8 +1304,28 @@ static int stm32_spi_config(struct stm32_spi *spi)
 	return 0;
 }
 
+static const struct stm32_spi_cfg stm32h7_spi_cfg = {
+	.regs = &stm32h7_spi_regspec,
+	.get_fifo_size = stm32h7_spi_get_fifo_size,
+	.get_bpw_mask = stm32h7_spi_get_bpw_mask,
+	.disable = stm32h7_spi_disable,
+	.config = stm32h7_spi_config,
+	.set_bpw = stm32h7_spi_set_bpw,
+	.set_mode = stm32h7_spi_set_mode,
+	.set_data_idleness = stm32h7_spi_data_idleness,
+	.set_number_of_data = stm32h7_spi_number_of_data,
+	.transfer_one_dma_start = stm32h7_spi_transfer_one_dma_start,
+	.dma_rx_cb = stm32h7_spi_dma_cb,
+	.dma_tx_cb = stm32h7_spi_dma_cb,
+	.transfer_one_irq = stm32h7_spi_transfer_one_irq,
+	.irq_handler_thread = stm32h7_spi_irq_thread,
+	.baud_rate_div_min = STM32H7_SPI_MBR_DIV_MIN,
+	.baud_rate_div_max = STM32H7_SPI_MBR_DIV_MAX,
+	.has_fifo = true,
+};
+
 static const struct of_device_id stm32_spi_of_match[] = {
-	{ .compatible = "st,stm32h7-spi", },
+	{ .compatible = "st,stm32h7-spi", .data = (void *)&stm32h7_spi_cfg },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_spi_of_match);
@@ -1221,12 +1349,17 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	spi->master = master;
 	spin_lock_init(&spi->lock);
 
+	spi->cfg = (const struct stm32_spi_cfg *)
+		of_match_device(pdev->dev.driver->of_match_table,
+				&pdev->dev)->data;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	spi->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(spi->base)) {
 		ret = PTR_ERR(spi->base);
 		goto err_master_put;
 	}
+
 	spi->phys_addr = (dma_addr_t)res->start;
 
 	spi->irq = platform_get_irq(pdev, 0);
@@ -1235,9 +1368,10 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		ret = -ENOENT;
 		goto err_master_put;
 	}
-	ret = devm_request_threaded_irq(&pdev->dev, spi->irq, NULL,
-					stm32_spi_irq_thread, IRQF_ONESHOT,
-					pdev->name, master);
+	ret = devm_request_threaded_irq(&pdev->dev, spi->irq,
+					spi->cfg->irq_handler_event,
+					spi->cfg->irq_handler_thread,
+					IRQF_ONESHOT, pdev->name, master);
 	if (ret) {
 		dev_err(&pdev->dev, "irq%d request failed: %d\n", spi->irq,
 			ret);
@@ -1270,9 +1404,10 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		reset_control_deassert(spi->rst);
 	}
 
-	spi->fifo_size = stm32_spi_get_fifo_size(spi);
+	if (spi->cfg->has_fifo)
+		spi->fifo_size = spi->cfg->get_fifo_size(spi);
 
-	ret = stm32_spi_config(spi);
+	ret = spi->cfg->config(spi);
 	if (ret) {
 		dev_err(&pdev->dev, "controller configuration failed: %d\n",
 			ret);
@@ -1284,9 +1419,9 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	master->bus_num = pdev->id;
 	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST |
 			    SPI_3WIRE;
-	master->bits_per_word_mask = stm32_spi_get_bpw_mask(spi);
-	master->max_speed_hz = spi->clk_rate / STM32H7_SPI_MBR_DIV_MIN;
-	master->min_speed_hz = spi->clk_rate / STM32H7_SPI_MBR_DIV_MAX;
+	master->bits_per_word_mask = spi->cfg->get_bpw_mask(spi);
+	master->max_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_min;
+	master->min_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_max;
 	master->setup = stm32_spi_setup;
 	master->prepare_message = stm32_spi_prepare_msg;
 	master->transfer_one = stm32_spi_transfer_one;
@@ -1364,7 +1499,7 @@ static int stm32_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct stm32_spi *spi = spi_master_get_devdata(master);
 
-	stm32_spi_disable(spi);
+	spi->cfg->disable(spi);
 
 	if (master->dma_tx)
 		dma_release_channel(master->dma_tx);
-- 
2.7.4

