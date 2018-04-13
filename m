Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeDMQKi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:10:38 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:10397 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeDMQKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:10:35 -0400
X-IronPort-AV: E=Sophos;i="5.48,446,1517900400";
   d="scan'208";a="10537218"
From: Radu Pirea <radu.pirea@microchip.com>
To: <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC: Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH 3/3] spi: at91-usart: add driver for at91-usart as spi
Date: Fri, 13 Apr 2018 19:11:17 +0300
Message-ID: <20180413161117.20274-4-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180413161117.20274-1-radu.pirea@microchip.com>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the driver for at91-usart in spi mode. The USART IP can be configured
to work in many modes and one of them is SPI.

The driver was tested on sama5d3-xplained and sama5d4-xplained boards with
enc28j60 ethernet controller as slave.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 drivers/spi/Kconfig          |   8 +
 drivers/spi/Makefile         |   1 +
 drivers/spi/spi-at91-usart.c | 545 +++++++++++++++++++++++++++++++++++
 3 files changed, 554 insertions(+)
 create mode 100644 drivers/spi/spi-at91-usart.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6fb0347a24f2..b6b18d12abcb 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -77,6 +77,14 @@ config SPI_ATMEL
 	  This selects a driver for the Atmel SPI Controller, present on
 	  many AT91 (ARM) chips.
 
+config SPI_AT91_USART
+        tristate "Atmel USART Controller as SPI"
+        depends on HAS_DMA
+        depends on (ARCH_AT91 || COMPILE_TEST)
+        help
+	  This selects a driver for the AT91 USART Controller as SPI Master,
+	  present on AT91 and SAMA5 SoC series.
+
 config SPI_AU1550
 	tristate "Au1550/Au1200/Au1300 SPI Controller"
 	depends on MIPS_ALCHEMY
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 34c5f2832ddf..fb6cb42f4eaa 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
 obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
 obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
+obj-$(CONFIG_SPI_AT91_USART)		+= spi-at91-usart.o
 obj-$(CONFIG_SPI_ATH79)			+= spi-ath79.o
 obj-$(CONFIG_SPI_AU1550)		+= spi-au1550.o
 obj-$(CONFIG_SPI_AXI_SPI_ENGINE)	+= spi-axi-spi-engine.o
diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
new file mode 100644
index 000000000000..7d443fae1b79
--- /dev/null
+++ b/drivers/spi/spi-at91-usart.c
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for AT91 USART Controllers as SPI
+ *
+ * Copyright (C) 2018 Microchip Technology Inc.
+ * Author: Radu Pirea <radu.pirea@microchip.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#include <linux/pinctrl/consumer.h>
+
+#include <linux/spi/spi.h>
+
+#define US_CR			0x00
+#define US_MR			0x04
+#define US_IER			0x08
+#define	US_IDR			0x0C
+#define	US_CSR			0x14
+#define US_RHR			0x18
+#define	US_THR			0x1C
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
+#define US_DUMMY_TX		0xFF
+
+/* Register access macros */
+#define spi_readl(port, reg) \
+	readl_relaxed((port)->regs + US_##reg)
+#define spi_writel(port, reg, value) \
+	writel_relaxed((value), (port)->regs + US_##reg)
+
+#define spi_readb(port, reg) \
+	readb_relaxed((port)->regs + US_##reg)
+#define spi_writeb(port, reg, value) \
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
+	int			done_status;
+
+	u32			spi_clk;
+	u32			status;
+
+	bool			xfer_failed;
+	bool			keep_cs;
+	bool			cs_active;
+};
+
+struct at91_usart_spi_device {
+	struct gpio_desc	*npcs_pin;
+	u32			mr;
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
+	aus->status = spi_readl(aus, CSR);
+	return aus->status;
+}
+
+static inline void at91_usart_spi_tx(struct at91_usart_spi *aus)
+{
+	unsigned int len = aus->current_transfer->len;
+	unsigned int remaining = aus->current_tx_remaining_bytes;
+	const u8  *tx_buf = aus->current_transfer->tx_buf;
+
+	if (tx_buf && remaining) {
+		if (at91_usart_spi_tx_ready(aus))
+			spi_writel(aus, THR, tx_buf[len - remaining]);
+			aus->current_tx_remaining_bytes--;
+	} else {
+		if (at91_usart_spi_tx_ready(aus))
+			spi_writel(aus, THR, US_DUMMY_TX);
+	}
+}
+
+static inline void at91_usart_spi_rx(struct at91_usart_spi *aus)
+{
+	int len = aus->current_transfer->len;
+	int remaining = aus->current_rx_remaining_bytes;
+	u8  *rx_buf = aus->current_transfer->rx_buf;
+
+	if (aus->current_rx_remaining_bytes) {
+		rx_buf[len - remaining] = spi_readb(aus, RHR);
+		aus->current_rx_remaining_bytes--;
+	} else {
+		spi_readb(aus, RHR);
+	}
+}
+
+static inline void at91_usart_spi_cs_activate(struct spi_device *spi)
+{
+	struct at91_usart_spi_device *ausd = spi->controller_state;
+	struct at91_usart_spi *aus = spi_master_get_devdata(spi->controller);
+	u32 active = spi->mode & SPI_CS_HIGH;
+
+	gpiod_set_value(ausd->npcs_pin, active);
+	aus->cs_active = true;
+}
+
+static inline void at91_usart_spi_cs_deactivate(struct spi_device *spi)
+{
+	struct at91_usart_spi_device *ausd = spi->controller_state;
+	struct at91_usart_spi *aus = spi_master_get_devdata(spi->controller);
+	u32 active = spi->mode & SPI_CS_HIGH;
+
+	gpiod_set_value(ausd->npcs_pin, !active);
+	aus->cs_active = false;
+}
+
+static inline void at91_usart_spi_set_mode_register(struct spi_device *spi)
+{
+	struct at91_usart_spi_device *ausd = spi->controller_state;
+	struct at91_usart_spi *aus = spi_master_get_devdata(spi->controller);
+
+	spi_writel(aus, MR, ausd->mr);
+}
+
+static inline void
+at91_usart_spi_enable_irq_and_hw(struct at91_usart_spi *aus)
+{
+	spi_writel(aus, CR, US_CR_RXEN | US_CR_TXEN);
+	spi_writel(aus, IER, US_IR_OVRE | US_IR_RXRDY);
+}
+
+static inline void
+at91_usart_spi_disable_irq_and_hw(struct at91_usart_spi *aus)
+{
+	spi_writel(aus, CR, US_CR_RXDIS | US_CR_TXDIS |
+		   US_CR_RSTRX | US_CR_RSTTX);
+	spi_writel(aus, IDR, US_IR_OVRE | US_IR_RXRDY);
+}
+
+static inline void
+at91_usart_spi_set_xfer_speed(struct at91_usart_spi *aus,
+			      struct spi_transfer *xfer)
+{
+	spi_writel(aus, BRGR,
+		   DIV_ROUND_UP(aus->spi_clk, xfer->speed_hz));
+}
+
+static irqreturn_t at91_usart_spi_interrupt(int irq, void *dev_id)
+{
+	struct spi_controller *controller = dev_id;
+	struct at91_usart_spi *aus = spi_master_get_devdata(controller);
+
+	spin_lock(&aus->lock);
+
+	at91_usart_spi_read_status(aus);
+
+	if (at91_usart_spi_check_overrun(aus)) {
+		aus->xfer_failed = true;
+		aus->done_status = -EIO;
+		spi_writel(aus, IDR, US_IR_OVRE | US_IR_RXRDY);
+		spin_unlock(&aus->lock);
+		return IRQ_HANDLED;
+	}
+
+	if (at91_usart_spi_rx_ready(aus)) {
+		at91_usart_spi_rx(aus);
+		spin_unlock(&aus->lock);
+		return IRQ_HANDLED;
+	}
+	spin_unlock(&aus->lock);
+
+	return IRQ_NONE;
+}
+
+static int at91_usart_spi_setup(struct spi_device *spi)
+{
+	struct at91_usart_spi *aus = spi_master_get_devdata(spi->controller);
+	struct at91_usart_spi_device *ausd = spi->controller_state;
+	struct gpio_desc *npcs_pin;
+	unsigned int mr = spi_readl(aus, MR);
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
+		if (gpio_is_valid(spi->cs_gpio)) {
+			npcs_pin = gpio_to_desc(spi->cs_gpio);
+		} else {
+			dev_dbg(&spi->dev, "Invalid chip select\n");
+			return -EINVAL;
+		}
+
+		ausd = kzalloc(sizeof(*ausd), GFP_KERNEL);
+		if (!ausd)
+			return -ENOMEM;
+		gpiod_direction_output(npcs_pin, !(spi->mode & SPI_CS_HIGH));
+
+		ausd->npcs_pin = npcs_pin;
+		spi->controller_state = ausd;
+	}
+
+	ausd->mr = mr;
+
+	dev_dbg(&spi->dev,
+		"setup: bpw %u mode 0x%x -> mr %d %08x\n",
+		bits, spi->mode, spi->chip_select, mr);
+
+	return 0;
+}
+
+static int at91_usart_spi_one_transfer(struct spi_controller *controller,
+				       struct spi_message *msg,
+				       struct spi_transfer *xfer)
+{
+	struct at91_usart_spi *aus = spi_master_get_devdata(controller);
+	struct spi_device *spi = msg->spi;
+	const u8 *tx_buf = xfer->tx_buf;
+	u8 *rx_buf = xfer->rx_buf;
+
+	if (!(xfer->tx_buf || xfer->rx_buf) && xfer->len) {
+		dev_dbg(&spi->dev, "missing rx and tx buf\n");
+		return -EINVAL;
+	}
+
+	at91_usart_spi_set_xfer_speed(aus, xfer);
+	aus->done_status = 0;
+	aus->xfer_failed = false;
+	aus->current_transfer = xfer;
+	aus->current_tx_remaining_bytes = xfer->len;
+	aus->current_rx_remaining_bytes = xfer->len;
+	if (!tx_buf)
+		aus->current_tx_remaining_bytes = 0;
+	if (!rx_buf)
+		aus->current_rx_remaining_bytes = 0;
+
+	while ((aus->current_tx_remaining_bytes ||
+		aus->current_rx_remaining_bytes) && !aus->xfer_failed) {
+		at91_usart_spi_read_status(aus);
+		at91_usart_spi_tx(aus);
+		cpu_relax();
+	}
+	if (aus->xfer_failed) {
+		dev_err(aus->dev, "Overrun!\n");
+		return -EIO;
+	}
+
+	if (xfer->delay_usecs)
+		udelay(xfer->delay_usecs);
+
+	if (xfer->cs_change) {
+		if (list_is_last(&xfer->transfer_list, &msg->transfers)) {
+			aus->keep_cs = true;
+		} else {
+			aus->cs_active = !aus->cs_active;
+			if (aus->cs_active)
+				at91_usart_spi_cs_activate(spi);
+			else
+				at91_usart_spi_cs_deactivate(spi);
+		}
+	}
+
+	return 0;
+}
+
+static int
+at91_usart_spi_transfer_one_message(struct spi_controller *controller,
+				    struct spi_message *msg)
+{
+	struct at91_usart_spi *aus = spi_master_get_devdata(controller);
+	struct spi_transfer *xfer;
+	struct spi_device *spi = msg->spi;
+	int ret;
+
+	dev_dbg(&spi->dev, "new message %p submitted for %s\n",
+		msg, dev_name(&spi->dev));
+	at91_usart_spi_enable_irq_and_hw(aus);
+	at91_usart_spi_set_mode_register(spi);
+	at91_usart_spi_cs_activate(spi);
+
+	aus->keep_cs = false;
+
+	msg->status = 0;
+	msg->actual_length = 0;
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		ret = at91_usart_spi_one_transfer(controller, msg, xfer);
+		if (ret)
+			goto msg_done;
+	}
+
+msg_done:
+
+	if (!aus->keep_cs)
+		at91_usart_spi_cs_deactivate(spi);
+
+	at91_usart_spi_disable_irq_and_hw(aus);
+
+	msg->status = aus->done_status;
+	spi_finalize_current_message(spi->master);
+
+	return ret;
+}
+
+static void at91_usart_spi_cleanup(struct spi_device *spi)
+{
+	struct at91_usart_spi_device *ausd = spi->controller_state;
+
+	if (!ausd)
+		return;
+
+	spi->controller_state = NULL;
+	kfree(ausd);
+}
+
+static int at91_usart_spi_gpio_cs(struct platform_device *pdev)
+{
+	struct spi_controller *controller = platform_get_drvdata(pdev);
+	struct device_node *np = controller->dev.of_node;
+	struct gpio_desc *cs_gpio;
+	int nb;
+	int i;
+
+	if (!np)
+		return 0;
+
+	nb = of_gpio_named_count(np, "cs-gpios");
+	for (i = 0; i < nb; i++) {
+		cs_gpio = devm_gpiod_get_from_of_node(&pdev->dev,
+						      pdev->dev.of_node,
+						      "cs-gpios",
+						      i, GPIOD_OUT_HIGH,
+						      dev_name(&pdev->dev));
+		if (IS_ERR(cs_gpio))
+			return PTR_ERR(cs_gpio);
+	}
+
+	controller->num_chipselect = nb;
+
+	return 0;
+}
+
+static void at91_usart_spi_init(struct at91_usart_spi *aus)
+{
+	spi_writel(aus, MR, US_MR_SPI_MASTER | US_MR_CHRL | US_MR_CLKO |
+			US_MR_WRDBT);
+	spi_writel(aus, CR, US_CR_RXDIS | US_CR_TXDIS | US_CR_RSTRX |
+			US_CR_RSTTX);
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
+	pinctrl_pm_select_default_state(&pdev->dev);
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs)
+		return -ENXIO;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	clk = devm_clk_get(&pdev->dev, "usart");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = -ENOMEM;
+	controller = spi_alloc_master(&pdev->dev, sizeof(*aus));
+	if (!controller)
+		goto at91_usart_spi_probe_fail;
+
+	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
+	controller->dev.of_node = pdev->dev.of_node;
+	controller->bits_per_word_mask = SPI_BPW_MASK(8);
+	controller->bus_num = pdev->id;
+	controller->num_chipselect = 0;
+	controller->setup = at91_usart_spi_setup;
+	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	controller->transfer_one_message = at91_usart_spi_transfer_one_message;
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
+	ret = at91_usart_spi_gpio_cs(pdev);
+	if (ret)
+		goto at91_usart_spi_probe_fail;
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
+		goto fail_register_master;
+
+	dev_info(&pdev->dev,
+		 "Atmel USART SPI Controller version 0x%x at 0x%08lx (irq %d)\n",
+		 spi_readl(aus, VERSION),
+		 (unsigned long)regs->start, irq);
+
+	return 0;
+
+fail_register_master:
+	clk_disable_unprepare(clk);
+at91_usart_spi_probe_fail:
+	spi_master_put(controller);
+	return ret;
+}
+
+static int at91_usart_spi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct at91_usart_spi *aus = spi_master_get_devdata(master);
+
+	clk_disable_unprepare(aus->clk);
+
+	return 0;
+}
+
+static const struct of_device_id at91_usart_spi_dt_ids[] = {
+	{ .compatible = "microchip,sama5d2-usart-spi"},
+	{ .compatible = "microchip,at91sam9g45-usart-spi"},
+	{ /* sentinel */}
+};
+
+MODULE_DEVICE_TABLE(of, at91_usart_spi_dt_ids);
+
+static struct platform_driver at91_usart_spi_driver = {
+	.driver = {
+		.name = "at91_usart_spi",
+		.of_match_table = of_match_ptr(at91_usart_spi_dt_ids),
+	},
+	.probe = at91_usart_spi_probe,
+	.remove = at91_usart_spi_remove, };
+module_platform_driver(at91_usart_spi_driver);
+
+MODULE_DESCRIPTION("Microchip AT91 USART SPI Controller driver");
+MODULE_AUTHOR("Radu Pirea <radu.pirea@microchip.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:at91_usart_spi");
-- 
2.17.0
