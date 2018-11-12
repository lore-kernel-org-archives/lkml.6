Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A48BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1426F2241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1426F2241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbeKMChU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:37:20 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:55134 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727976AbeKMChU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:37:20 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id wACGCjmW030402;
        Mon, 12 Nov 2018 18:12:45 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 1DE28630C8; Mon, 12 Nov 2018 18:42:44 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 2/2] spi: npcm: add NPCM PSPI controller driver
Date:   Mon, 12 Nov 2018 18:42:32 +0200
Message-Id: <20181112164232.435629-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181112164232.435629-1-tmaimon77@gmail.com>
References: <20181112164232.435629-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Nuvoton NPCM BMC Peripheral SPI controller driver.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/spi/Kconfig         |   7 +
 drivers/spi/Makefile        |   1 +
 drivers/spi/spi-npcm-pspi.c | 480 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 488 insertions(+)
 create mode 100644 drivers/spi/spi-npcm-pspi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 7d3a5c94727e..21eb08405127 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -397,6 +397,13 @@ config SPI_MT65XX
 	  say Y or M here.If you are not sure, say N.
 	  SPI drivers for Mediatek MT65XX and MT81XX series ARM SoCs.
 
+config SPI_NPCM_PSPI
+	tristate "Nuvoton NPCM PSPI Controller"
+	depends on ARCH_NPCM || COMPILE_TEST
+	help
+	  This driver provides support for Nuvoton NPCM BMC
+	  Peripheral SPI controller in master mode.
+
 config SPI_NUC900
 	tristate "Nuvoton NUC900 series SPI"
 	depends on ARCH_W90X900
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 3575205c5c27..d40a3611809c 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
 obj-$(CONFIG_SPI_MPC52xx)		+= spi-mpc52xx.o
 obj-$(CONFIG_SPI_MT65XX)                += spi-mt65xx.o
 obj-$(CONFIG_SPI_MXS)			+= spi-mxs.o
+obj-$(CONFIG_SPI_NPCM_PSPI)		+= spi-npcm-pspi.o
 obj-$(CONFIG_SPI_NUC900)		+= spi-nuc900.o
 obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
 spi-octeon-objs				:= spi-cavium.o spi-cavium-octeon.o
diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
new file mode 100644
index 000000000000..51777515c83f
--- /dev/null
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Nuvoton Technology corporation.
+
+#include <linux/kernel.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+
+#include <asm/unaligned.h>
+
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+struct npcm_pspi {
+	struct completion xfer_done;
+	struct regmap *rst_regmap;
+	struct spi_master *master;
+	unsigned int tx_bytes;
+	unsigned int rx_bytes;
+	void __iomem *base;
+	bool is_save_param;
+	u8 bits_per_word;
+	const u8 *tx_buf;
+	struct clk *clk;
+	u32 speed_hz;
+	u8 *rx_buf;
+	u16 mode;
+	u32 id;
+};
+
+#define DRIVER_NAME "npcm-pspi"
+
+#define NPCM_PSPI_DATA		0x00
+#define NPCM_PSPI_CTL1		0x02
+#define NPCM_PSPI_STAT		0x04
+
+/* definitions for control and status register */
+#define NPCM_PSPI_CTL1_SPIEN	BIT(0)
+#define NPCM_PSPI_CTL1_MOD	BIT(2)
+#define NPCM_PSPI_CTL1_EIR	BIT(5)
+#define NPCM_PSPI_CTL1_EIW	BIT(6)
+#define NPCM_PSPI_CTL1_SCM	BIT(7)
+#define NPCM_PSPI_CTL1_SCIDL	BIT(8)
+#define NPCM_PSPI_CTL1_SCDV6_0	GENMASK(15, 9)
+
+#define NPCM_PSPI_STAT_BSY	BIT(0)
+#define NPCM_PSPI_STAT_RBF	BIT(1)
+
+/* general definitions */
+#define NPCM_PSPI_TIMEOUT_MS		2000
+#define NPCM_PSPI_MAX_CLK_DIVIDER	256
+#define NPCM_PSPI_MIN_CLK_DIVIDER	4
+#define NPCM_PSPI_DEFAULT_CLK		25000000
+
+/* reset register */
+#define NPCM7XX_IPSRST2_OFFSET	0x24
+
+#define NPCM7XX_PSPI1_RESET	BIT(22)
+#define NPCM7XX_PSPI2_RESET	BIT(23)
+
+static inline unsigned int bytes_per_word(unsigned int bits)
+{
+	return bits <= 8 ? 1 : 2;
+}
+
+static inline void npcm_pspi_irq_enable(struct npcm_pspi *priv, u16 mask)
+{
+	u16 val;
+
+	val = ioread16(priv->base + NPCM_PSPI_CTL1);
+	val |= mask;
+	iowrite16(val, priv->base + NPCM_PSPI_CTL1);
+}
+
+static inline void npcm_pspi_irq_disable(struct npcm_pspi *priv, u16 mask)
+{
+	u16 val;
+
+	val = ioread16(priv->base + NPCM_PSPI_CTL1);
+	val &= ~mask;
+	iowrite16(val, priv->base + NPCM_PSPI_CTL1);
+}
+
+static inline void npcm_pspi_enable(struct npcm_pspi *priv)
+{
+	u16 val;
+
+	val = ioread16(priv->base + NPCM_PSPI_CTL1);
+	val |= NPCM_PSPI_CTL1_SPIEN;
+	iowrite16(val, priv->base + NPCM_PSPI_CTL1);
+}
+
+static inline void npcm_pspi_disable(struct npcm_pspi *priv)
+{
+	u16 val;
+
+	val = ioread16(priv->base + NPCM_PSPI_CTL1);
+	val &= ~NPCM_PSPI_CTL1_SPIEN;
+	iowrite16(val, priv->base + NPCM_PSPI_CTL1);
+}
+
+static void npcm_pspi_set_mode(struct spi_device *spi)
+{
+	struct npcm_pspi *priv = spi_master_get_devdata(spi->master);
+	u16 regtemp;
+	u16 mode_val;
+
+	switch (spi->mode & (SPI_CPOL | SPI_CPHA)) {
+	case SPI_MODE_0:
+		mode_val = 0;
+		break;
+	case SPI_MODE_1:
+		mode_val = NPCM_PSPI_CTL1_SCIDL;
+		break;
+	case SPI_MODE_2:
+		mode_val = NPCM_PSPI_CTL1_SCM;
+		break;
+	case SPI_MODE_3:
+		mode_val = NPCM_PSPI_CTL1_SCIDL | NPCM_PSPI_CTL1_SCM;
+		break;
+	}
+
+	regtemp = ioread16(priv->base + NPCM_PSPI_CTL1);
+	regtemp &= ~(NPCM_PSPI_CTL1_SCM | NPCM_PSPI_CTL1_SCIDL);
+	iowrite16(regtemp | mode_val, priv->base + NPCM_PSPI_CTL1);
+}
+
+static void npcm_pspi_set_transfer_size(struct npcm_pspi *priv, int size)
+{
+	u16 regtemp;
+
+	regtemp = ioread16(NPCM_PSPI_CTL1 + priv->base);
+
+	switch (size) {
+	case 8:
+		regtemp &= ~NPCM_PSPI_CTL1_MOD;
+		break;
+	case 16:
+		regtemp |= NPCM_PSPI_CTL1_MOD;
+		break;
+	}
+
+	iowrite16(regtemp, NPCM_PSPI_CTL1 + priv->base);
+}
+
+static void npcm_pspi_set_baudrate(struct npcm_pspi *priv, unsigned int speed)
+{
+	u32 ckdiv;
+	u16 regtemp;
+
+	/* the supported rates are numbers from 4 to 256. */
+	ckdiv = DIV_ROUND_CLOSEST(clk_get_rate(priv->clk), (2 * speed)) - 1;
+
+	regtemp = ioread16(NPCM_PSPI_CTL1 + priv->base);
+	regtemp &= ~NPCM_PSPI_CTL1_SCDV6_0;
+	iowrite16(regtemp | (ckdiv << 9), NPCM_PSPI_CTL1 + priv->base);
+}
+
+static void npcm_pspi_setup_transfer(struct spi_device *spi,
+				     struct spi_transfer *t)
+{
+	struct npcm_pspi *priv = spi_master_get_devdata(spi->master);
+
+	priv->tx_buf = t->tx_buf;
+	priv->rx_buf = t->rx_buf;
+	priv->tx_bytes = t->len;
+	priv->rx_bytes = t->len;
+
+	if (!priv->is_save_param || priv->mode != spi->mode) {
+		npcm_pspi_set_mode(spi);
+		priv->mode = spi->mode;
+	}
+
+	if (!priv->is_save_param || priv->bits_per_word != t->bits_per_word) {
+		npcm_pspi_set_transfer_size(priv, t->bits_per_word);
+		priv->bits_per_word = t->bits_per_word;
+	}
+
+	if (!priv->is_save_param || priv->speed_hz != t->speed_hz) {
+		npcm_pspi_set_baudrate(priv, t->speed_hz);
+		priv->speed_hz = t->speed_hz;
+	}
+
+	if (!priv->is_save_param)
+		priv->is_save_param = true;
+}
+
+static void npcm_pspi_send(struct npcm_pspi *priv)
+{
+	int wsize;
+
+	wsize = min(bytes_per_word(priv->bits_per_word), priv->tx_bytes);
+	priv->tx_bytes -= wsize;
+
+	if (priv->tx_buf) {
+		if (wsize == 1)
+			iowrite8(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
+		if (wsize == 2)
+			iowrite16(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
+
+		priv->tx_buf += wsize;
+	}
+}
+
+static void npcm_pspi_recv(struct npcm_pspi *priv)
+{
+	int rsize;
+	u16 val;
+
+	rsize = min(bytes_per_word(priv->bits_per_word), priv->rx_bytes);
+	priv->rx_bytes -= rsize;
+
+	if (priv->rx_buf) {
+		if (rsize == 1)
+			val = ioread8(priv->base + NPCM_PSPI_DATA);
+		if (rsize == 2)
+			val = ioread16(priv->base + NPCM_PSPI_DATA);
+
+		*priv->rx_buf = val;
+		priv->rx_buf += rsize;
+	}
+}
+
+static int npcm_pspi_transfer_one(struct spi_master *master,
+				  struct spi_device *spi,
+				  struct spi_transfer *t)
+{
+	struct npcm_pspi *priv = spi_master_get_devdata(master);
+	int status;
+
+	npcm_pspi_setup_transfer(spi, t);
+	reinit_completion(&priv->xfer_done);
+	npcm_pspi_enable(priv);
+	status = wait_for_completion_timeout(&priv->xfer_done,
+					     msecs_to_jiffies
+					     (NPCM_PSPI_TIMEOUT_MS));
+	if (status == 0) {
+		npcm_pspi_disable(priv);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int npcm_pspi_prepare_transfer_hardware(struct spi_master *master)
+{
+	struct npcm_pspi *priv = spi_master_get_devdata(master);
+
+	npcm_pspi_irq_enable(priv, NPCM_PSPI_CTL1_EIR | NPCM_PSPI_CTL1_EIW);
+
+	return 0;
+}
+
+static int npcm_pspi_unprepare_transfer_hardware(struct spi_master *master)
+{
+	struct npcm_pspi *priv = spi_master_get_devdata(master);
+
+	npcm_pspi_irq_disable(priv, NPCM_PSPI_CTL1_EIR | NPCM_PSPI_CTL1_EIW);
+
+	return 0;
+}
+
+static void npcm_pspi_reset_hw(struct npcm_pspi *priv)
+{
+	regmap_write(priv->rst_regmap, NPCM7XX_IPSRST2_OFFSET,
+		     NPCM7XX_PSPI1_RESET << priv->id);
+	regmap_write(priv->rst_regmap, NPCM7XX_IPSRST2_OFFSET, 0x0);
+}
+
+static irqreturn_t npcm_pspi_handler(int irq, void *dev_id)
+{
+	struct npcm_pspi *priv = dev_id;
+	u16 val;
+	u8 stat;
+
+	stat = ioread8(priv->base + NPCM_PSPI_STAT);
+
+	if (!priv->tx_buf && !priv->rx_buf)
+		return IRQ_NONE;
+
+	if (priv->tx_buf) {
+		if (stat & NPCM_PSPI_STAT_RBF) {
+			val = ioread8(NPCM_PSPI_DATA + priv->base);
+			if (priv->tx_bytes == 0) {
+				npcm_pspi_disable(priv);
+				complete(&priv->xfer_done);
+				return IRQ_HANDLED;
+			}
+		}
+
+		if ((stat & NPCM_PSPI_STAT_BSY) == 0)
+			if (priv->tx_bytes)
+				npcm_pspi_send(priv);
+	}
+
+	if (priv->rx_buf) {
+		if (stat & NPCM_PSPI_STAT_RBF) {
+			if (!priv->rx_bytes)
+				return IRQ_NONE;
+
+			npcm_pspi_recv(priv);
+
+			if (!priv->rx_bytes) {
+				npcm_pspi_disable(priv);
+				complete(&priv->xfer_done);
+				return IRQ_HANDLED;
+			}
+		}
+
+		if (((stat & NPCM_PSPI_STAT_BSY) == 0) && !priv->tx_buf)
+			iowrite8(0x0, NPCM_PSPI_DATA + priv->base);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int npcm_pspi_probe(struct platform_device *pdev)
+{
+	struct npcm_pspi *priv;
+	struct spi_master *master;
+	struct resource *res;
+	unsigned long clk_hz;
+	struct device_node *np = pdev->dev.of_node;
+	int num_cs, i;
+	u32 csgpio;
+	int irq;
+	int ret;
+
+	num_cs = of_gpio_named_count(np, "cs-gpios");
+	if (num_cs < 0)
+		return num_cs;
+
+	pdev->id = of_alias_get_id(np, "spi");
+	if (pdev->id < 0)
+		pdev->id = 0;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*priv));
+	if (!master)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, master);
+
+	priv = spi_master_get_devdata(master);
+	priv->master = master;
+	priv->is_save_param = false;
+	priv->id = pdev->id;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->base)) {
+		ret = PTR_ERR(priv->base);
+		goto out_master_put;
+	}
+
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		dev_err(&pdev->dev, "failed to get clock\n");
+		ret = PTR_ERR(priv->clk);
+		goto out_master_put;
+	}
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		goto out_master_put;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ\n");
+		ret = irq;
+		goto out_disable_clk;
+	}
+
+	priv->rst_regmap =
+		syscon_regmap_lookup_by_compatible("nuvoton,npcm750-rst");
+	if (IS_ERR(priv->rst_regmap)) {
+		dev_err(&pdev->dev, "failed to find nuvoton,npcm750-rst\n");
+		return IS_ERR(priv->rst_regmap);
+	}
+
+	/* reset SPI-HW block */
+	npcm_pspi_reset_hw(priv);
+
+	ret = devm_request_irq(&pdev->dev, irq, npcm_pspi_handler, 0,
+			       "npcm-pspi", priv);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request IRQ\n");
+		goto out_disable_clk;
+	}
+
+	init_completion(&priv->xfer_done);
+
+	clk_hz = clk_get_rate(priv->clk);
+
+	master->max_speed_hz = DIV_ROUND_UP(clk_hz, NPCM_PSPI_MIN_CLK_DIVIDER);
+	master->min_speed_hz = DIV_ROUND_UP(clk_hz, NPCM_PSPI_MAX_CLK_DIVIDER);
+	master->mode_bits = SPI_CPHA | SPI_CPOL;
+	master->dev.of_node = pdev->dev.of_node;
+	master->bus_num = pdev->id;
+	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	master->transfer_one = npcm_pspi_transfer_one;
+	master->prepare_transfer_hardware =
+		npcm_pspi_prepare_transfer_hardware;
+	master->unprepare_transfer_hardware =
+		npcm_pspi_unprepare_transfer_hardware;
+	master->num_chipselect = num_cs;
+
+	for (i = 0; i < num_cs; i++) {
+		csgpio = of_get_named_gpio(np, "cs-gpios", i);
+		if (csgpio < 0) {
+			dev_err(&pdev->dev, "failed to get csgpio#%u\n", i);
+			goto out_disable_clk;
+		}
+		dev_dbg(&pdev->dev, "csgpio#%u = %u\n", i, csgpio);
+		ret = devm_gpio_request_one(&pdev->dev, csgpio,
+					    GPIOF_OUT_INIT_HIGH, DRIVER_NAME);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"failed to configure csgpio#%u %u\n"
+				, i, csgpio);
+			goto out_disable_clk;
+		}
+	}
+
+	/* set to default clock rate */
+	npcm_pspi_set_baudrate(priv, NPCM_PSPI_DEFAULT_CLK);
+
+	ret = devm_spi_register_master(&pdev->dev, master);
+	if (ret)
+		goto out_disable_clk;
+
+	pr_info("NPCM Peripheral SPI %d probed\n", pdev->id);
+
+	return 0;
+
+out_disable_clk:
+	clk_disable_unprepare(priv->clk);
+
+out_master_put:
+	spi_master_put(master);
+	return ret;
+}
+
+static int npcm_pspi_remove(struct platform_device *pdev)
+{
+	struct npcm_pspi *priv = platform_get_drvdata(pdev);
+
+	npcm_pspi_reset_hw(priv);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static const struct of_device_id npcm_pspi_match[] = {
+	{ .compatible = "nuvoton,npcm750-pspi", .data = NULL },
+	{}
+};
+MODULE_DEVICE_TABLE(of, npcm_pspi_match);
+
+static struct platform_driver npcm_pspi_driver = {
+	.driver		= {
+		.name		= DRIVER_NAME,
+		.of_match_table	= npcm_pspi_match,
+		.owner		= THIS_MODULE,
+	},
+	.probe		= npcm_pspi_probe,
+	.remove		= npcm_pspi_remove,
+};
+module_platform_driver(npcm_pspi_driver);
+
+MODULE_DESCRIPTION("NPCM peripheral SPI Controller driver");
+MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
+MODULE_LICENSE("GPL v2");
+
-- 
2.14.1

