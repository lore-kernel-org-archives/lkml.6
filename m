Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B60C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC062083D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC062083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeHaRsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:48:18 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:58967 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeHaRsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:48:18 -0400
X-IronPort-AV: E=Sophos;i="5.53,311,1531810800"; 
   d="scan'208";a="16999764"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Aug 2018 06:40:45 -0700
Received: from m19893.microchip.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Fri, 31 Aug 2018 06:40:44 -0700
From:   Radu Pirea <radu.pirea@microchip.com>
To:     <richard.genoud@gmail.com>, <pirea.radu@gmail.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>
Subject: [RESEND PATCH v11 5/6] spi: at91-usart: add driver for at91-usart as spi
Date:   Fri, 31 Aug 2018 16:41:40 +0300
Message-ID: <20180831134141.9335-6-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831134141.9335-1-radu.pirea@microchip.com>
References: <20180831134141.9335-1-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the driver for at91-usart in spi mode. The USART IP can be configured
to work in many modes and one of them is SPI.

The driver was tested on sama5d3-xplained and sama5d4-xplained boards with
enc28j60 ethernet controller as slave.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviwed-by: Mark Brown <broonie@kernel.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/spi/Kconfig          |   8 +
 drivers/spi/Makefile         |   1 +
 drivers/spi/spi-at91-usart.c | 432 +++++++++++++++++++++++++++++++++++
 3 files changed, 441 insertions(+)
 create mode 100644 drivers/spi/spi-at91-usart.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 7580eb76ab18..181b5f2e831d 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -83,6 +83,14 @@ config SPI_ATMEL
 	  This selects a driver for the Atmel SPI Controller, present on
 	  many AT91 ARM chips.
 
+config SPI_AT91_USART
+	tristate "Atmel USART Controller SPI driver"
+	depends on (ARCH_AT91 || COMPILE_TEST)
+	depends on MFD_AT91_USART
+	help
+	  This selects a driver for the AT91 USART Controller as SPI Master,
+	  present on AT91 and SAMA5 SoC series.
+
 config SPI_AU1550
 	tristate "Au1550/Au1200/Au1300 SPI Controller"
 	depends on MIPS_ALCHEMY
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 1920b6cc2b7e..7385bbd37dcf 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
 obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
 obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
+obj-$(CONFIG_SPI_AT91_USART)		+= spi-at91-usart.o
 obj-$(CONFIG_SPI_ATH79)			+= spi-ath79.o
 obj-$(CONFIG_SPI_AU1550)		+= spi-au1550.o
 obj-$(CONFIG_SPI_AXI_SPI_ENGINE)	+= spi-axi-spi-engine.o
diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
new file mode 100644
index 000000000000..4712bd470c89
--- /dev/null
+++ b/drivers/spi/spi-at91-usart.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Driver for AT91 USART Controllers as SPI
+//
+// Copyright (C) 2018 Microchip Technology Inc.
+//
+// Author: Radu Pirea <radu.pirea@microchip.com>
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+
+#include <linux/spi/spi.h>
+
+#define US_CR			0x00
+#define US_MR			0x04
+#define US_IER			0x08
+#define US_IDR			0x0C
+#define US_CSR			0x14
+#define US_RHR			0x18
+#define US_THR			0x1C
+#define US_BRGR			0x20
+#define US_VERSION		0xFC
+
+#define US_CR_RSTRX		BIT(2)
+#define US_CR_RSTTX		BIT(3)
+#define US_CR_RXEN		BIT(4)
+#define US_CR_RXDIS		BIT(5)
+#define US_CR_TXEN		BIT(6)
+#define US_CR_TXDIS		BIT(7)
+
+#define US_MR_SPI_MASTER	0x0E
+#define US_MR_CHRL		GENMASK(7, 6)
+#define US_MR_CPHA		BIT(8)
+#define US_MR_CPOL		BIT(16)
+#define US_MR_CLKO		BIT(18)
+#define US_MR_WRDBT		BIT(20)
+#define US_MR_LOOP		BIT(15)
+
+#define US_IR_RXRDY		BIT(0)
+#define US_IR_TXRDY		BIT(1)
+#define US_IR_OVRE		BIT(5)
+
+#define US_BRGR_SIZE		BIT(16)
+
+#define US_MIN_CLK_DIV		0x06
+#define US_MAX_CLK_DIV		BIT(16)
+
+#define US_RESET		(US_CR_RSTRX | US_CR_RSTTX)
+#define US_DISABLE		(US_CR_RXDIS | US_CR_TXDIS)
+#define US_ENABLE		(US_CR_RXEN | US_CR_TXEN)
+#define US_OVRE_RXRDY_IRQS	(US_IR_OVRE | US_IR_RXRDY)
+
+#define US_INIT \
+	(US_MR_SPI_MASTER | US_MR_CHRL | US_MR_CLKO | US_MR_WRDBT)
+
+/* Register access macros */
+#define at91_usart_spi_readl(port, reg) \
+	readl_relaxed((port)->regs + US_##reg)
+#define at91_usart_spi_writel(port, reg, value) \
+	writel_relaxed((value), (port)->regs + US_##reg)
+
+#define at91_usart_spi_readb(port, reg) \
+	readb_relaxed((port)->regs + US_##reg)
+#define at91_usart_spi_writeb(port, reg, value) \
+	writeb_relaxed((value), (port)->regs + US_##reg)
+
+struct at91_usart_spi {
+	struct spi_transfer	*current_transfer;
+	void __iomem		*regs;
+	struct device		*dev;
+	struct clk		*clk;
+
+	/*used in interrupt to protect data reading*/
+	spinlock_t		lock;
+
+	int			irq;
+	unsigned int		current_tx_remaining_bytes;
+	unsigned int		current_rx_remaining_bytes;
+
+	u32			spi_clk;
+	u32			status;
+
+	bool			xfer_failed;
+};
+
+static inline u32 at91_usart_spi_tx_ready(struct at91_usart_spi *aus)
+{
+	return aus->status & US_IR_TXRDY;
+}
+
+static inline u32 at91_usart_spi_rx_ready(struct at91_usart_spi *aus)
+{
+	return aus->status & US_IR_RXRDY;
+}
+
+static inline u32 at91_usart_spi_check_overrun(struct at91_usart_spi *aus)
+{
+	return aus->status & US_IR_OVRE;
+}
+
+static inline u32 at91_usart_spi_read_status(struct at91_usart_spi *aus)
+{
+	aus->status = at91_usart_spi_readl(aus, CSR);
+	return aus->status;
+}
+
+static inline void at91_usart_spi_tx(struct at91_usart_spi *aus)
+{
+	unsigned int len = aus->current_transfer->len;
+	unsigned int remaining = aus->current_tx_remaining_bytes;
+	const u8  *tx_buf = aus->current_transfer->tx_buf;
+
+	if (!remaining)
+		return;
+
+	if (at91_usart_spi_tx_ready(aus)) {
+		at91_usart_spi_writeb(aus, THR, tx_buf[len - remaining]);
+		aus->current_tx_remaining_bytes--;
+	}
+}
+
+static inline void at91_usart_spi_rx(struct at91_usart_spi *aus)
+{
+	int len = aus->current_transfer->len;
+	int remaining = aus->current_rx_remaining_bytes;
+	u8  *rx_buf = aus->current_transfer->rx_buf;
+
+	if (!remaining)
+		return;
+
+	rx_buf[len - remaining] = at91_usart_spi_readb(aus, RHR);
+	aus->current_rx_remaining_bytes--;
+}
+
+static inline void
+at91_usart_spi_set_xfer_speed(struct at91_usart_spi *aus,
+			      struct spi_transfer *xfer)
+{
+	at91_usart_spi_writel(aus, BRGR,
+			      DIV_ROUND_UP(aus->spi_clk, xfer->speed_hz));
+}
+
+static irqreturn_t at91_usart_spi_interrupt(int irq, void *dev_id)
+{
+	struct spi_controller *controller = dev_id;
+	struct at91_usart_spi *aus = spi_master_get_devdata(controller);
+
+	spin_lock(&aus->lock);
+	at91_usart_spi_read_status(aus);
+
+	if (at91_usart_spi_check_overrun(aus)) {
+		aus->xfer_failed = true;
+		at91_usart_spi_writel(aus, IDR, US_IR_OVRE | US_IR_RXRDY);
+		spin_unlock(&aus->lock);
+		return IRQ_HANDLED;
+	}
+
+	if (at91_usart_spi_rx_ready(aus)) {
+		at91_usart_spi_rx(aus);
+		spin_unlock(&aus->lock);
+		return IRQ_HANDLED;
+	}
+
+	spin_unlock(&aus->lock);
+
+	return IRQ_NONE;
+}
+
+static int at91_usart_spi_setup(struct spi_device *spi)
+{
+	struct at91_usart_spi *aus = spi_master_get_devdata(spi->controller);
+	u32 *ausd = spi->controller_state;
+	unsigned int mr = at91_usart_spi_readl(aus, MR);
+	u8 bits = spi->bits_per_word;
+
+	if (bits != 8) {
+		dev_dbg(&spi->dev, "Only 8 bits per word are supported\n");
+		return -EINVAL;
+	}
+
+	if (spi->mode & SPI_CPOL)
+		mr |= US_MR_CPOL;
+	else
+		mr &= ~US_MR_CPOL;
+
+	if (spi->mode & SPI_CPHA)
+		mr |= US_MR_CPHA;
+	else
+		mr &= ~US_MR_CPHA;
+
+	if (spi->mode & SPI_LOOP)
+		mr |= US_MR_LOOP;
+	else
+		mr &= ~US_MR_LOOP;
+
+	if (!ausd) {
+		ausd = kzalloc(sizeof(*ausd), GFP_KERNEL);
+		if (!ausd)
+			return -ENOMEM;
+
+		spi->controller_state = ausd;
+	}
+
+	*ausd = mr;
+
+	dev_dbg(&spi->dev,
+		"setup: bpw %u mode 0x%x -> mr %d %08x\n",
+		bits, spi->mode, spi->chip_select, mr);
+
+	return 0;
+}
+
+int at91_usart_spi_transfer_one(struct spi_controller *ctlr,
+				struct spi_device *spi,
+				struct spi_transfer *xfer)
+{
+	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
+
+	at91_usart_spi_set_xfer_speed(aus, xfer);
+	aus->xfer_failed = false;
+	aus->current_transfer = xfer;
+	aus->current_tx_remaining_bytes = xfer->len;
+	aus->current_rx_remaining_bytes = xfer->len;
+
+	while ((aus->current_tx_remaining_bytes ||
+		aus->current_rx_remaining_bytes) && !aus->xfer_failed) {
+		at91_usart_spi_read_status(aus);
+		at91_usart_spi_tx(aus);
+		cpu_relax();
+	}
+
+	if (aus->xfer_failed) {
+		dev_err(aus->dev, "Overrun!\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int at91_usart_spi_prepare_message(struct spi_controller *ctlr,
+				   struct spi_message *message)
+{
+	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
+	struct spi_device *spi = message->spi;
+	u32 *ausd = spi->controller_state;
+
+	at91_usart_spi_writel(aus, CR, US_ENABLE);
+	at91_usart_spi_writel(aus, IER, US_OVRE_RXRDY_IRQS);
+	at91_usart_spi_writel(aus, MR, *ausd);
+
+	return 0;
+}
+
+int at91_usart_spi_unprepare_message(struct spi_controller *ctlr,
+				     struct spi_message *message)
+{
+	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
+
+	at91_usart_spi_writel(aus, CR, US_RESET | US_DISABLE);
+	at91_usart_spi_writel(aus, IDR, US_OVRE_RXRDY_IRQS);
+
+	return 0;
+}
+
+static void at91_usart_spi_cleanup(struct spi_device *spi)
+{
+	struct at91_usart_spi_device *ausd = spi->controller_state;
+
+	spi->controller_state = NULL;
+	kfree(ausd);
+}
+
+static void at91_usart_spi_init(struct at91_usart_spi *aus)
+{
+	at91_usart_spi_writel(aus, MR, US_INIT);
+	at91_usart_spi_writel(aus, CR, US_RESET | US_DISABLE);
+}
+
+static int at91_usart_gpio_setup(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.parent->of_node;
+	int i;
+	int ret;
+	int nb;
+
+	if (!np)
+		return -EINVAL;
+
+	nb = of_gpio_named_count(np, "cs-gpios");
+	for (i = 0; i < nb; i++) {
+		int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
+
+		if (cs_gpio < 0)
+			return cs_gpio;
+
+		if (gpio_is_valid(cs_gpio)) {
+			ret = devm_gpio_request_one(&pdev->dev, cs_gpio,
+						    GPIOF_DIR_OUT,
+						    dev_name(&pdev->dev));
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int at91_usart_spi_probe(struct platform_device *pdev)
+{
+	struct resource *regs;
+	struct spi_controller *controller;
+	struct at91_usart_spi *aus;
+	struct clk *clk;
+	int irq;
+	int ret;
+
+	regs = platform_get_resource(to_platform_device(pdev->dev.parent),
+				     IORESOURCE_MEM, 0);
+	if (!regs)
+		return -EINVAL;
+
+	irq = platform_get_irq(to_platform_device(pdev->dev.parent), 0);
+	if (irq < 0)
+		return irq;
+
+	clk = devm_clk_get(pdev->dev.parent, "usart");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = -ENOMEM;
+	controller = spi_alloc_master(&pdev->dev, sizeof(*aus));
+	if (!controller)
+		goto at91_usart_spi_probe_fail;
+
+	ret = at91_usart_gpio_setup(pdev);
+	if (ret)
+		goto at91_usart_spi_probe_fail;
+
+	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
+	controller->dev.of_node = pdev->dev.parent->of_node;
+	controller->bits_per_word_mask = SPI_BPW_MASK(8);
+	controller->setup = at91_usart_spi_setup;
+	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	controller->transfer_one = at91_usart_spi_transfer_one;
+	controller->prepare_message = at91_usart_spi_prepare_message;
+	controller->unprepare_message = at91_usart_spi_unprepare_message;
+	controller->cleanup = at91_usart_spi_cleanup;
+	controller->max_speed_hz = DIV_ROUND_UP(clk_get_rate(clk),
+						US_MIN_CLK_DIV);
+	controller->min_speed_hz = DIV_ROUND_UP(clk_get_rate(clk),
+						US_MAX_CLK_DIV);
+	platform_set_drvdata(pdev, controller);
+
+	aus = spi_master_get_devdata(controller);
+
+	aus->dev = &pdev->dev;
+	aus->regs = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(aus->regs)) {
+		ret = PTR_ERR(aus->regs);
+		goto at91_usart_spi_probe_fail;
+	}
+
+	aus->irq = irq;
+	aus->clk = clk;
+
+	ret = devm_request_irq(&pdev->dev, irq, at91_usart_spi_interrupt, 0,
+			       dev_name(&pdev->dev), controller);
+	if (ret)
+		goto at91_usart_spi_probe_fail;
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto at91_usart_spi_probe_fail;
+
+	aus->spi_clk = clk_get_rate(clk);
+	at91_usart_spi_init(aus);
+
+	spin_lock_init(&aus->lock);
+	ret = devm_spi_register_master(&pdev->dev, controller);
+	if (ret)
+		goto at91_usart_fail_register_master;
+
+	dev_info(&pdev->dev,
+		 "AT91 USART SPI Controller version 0x%x at %pa (irq %d)\n",
+		 at91_usart_spi_readl(aus, VERSION),
+		 &regs->start, irq);
+
+	return 0;
+
+at91_usart_fail_register_master:
+	clk_disable_unprepare(clk);
+at91_usart_spi_probe_fail:
+	spi_master_put(controller);
+	return ret;
+}
+
+static int at91_usart_spi_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct at91_usart_spi *aus = spi_master_get_devdata(ctlr);
+
+	clk_disable_unprepare(aus->clk);
+
+	return 0;
+}
+
+static const struct of_device_id at91_usart_spi_dt_ids[] = {
+	{ .compatible = "microchip,at91sam9g45-usart-spi"},
+	{ /* sentinel */}
+};
+
+MODULE_DEVICE_TABLE(of, at91_usart_spi_dt_ids);
+
+static struct platform_driver at91_usart_spi_driver = {
+	.driver = {
+		.name = "at91_usart_spi",
+	},
+	.probe = at91_usart_spi_probe,
+	.remove = at91_usart_spi_remove,
+};
+
+module_platform_driver(at91_usart_spi_driver);
+
+MODULE_DESCRIPTION("Microchip AT91 USART SPI Controller driver");
+MODULE_AUTHOR("Radu Pirea <radu.pirea@microchip.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:at91_usart_spi");
-- 
2.18.0

