Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28179C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE6120870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xk5CKGzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE6120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJJVnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:43:35 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49502 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbeJJVne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:43:34 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9AEL09p040867;
        Wed, 10 Oct 2018 09:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539181260;
        bh=JpHiiulQXLikTjuuwKMyQ0/D/WrMQeh9P/XW33AqfsI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Xk5CKGzEBx+xJ3S0XvncbPAH6NIPrJ4aOvnSwOHNq7VxxF1MdvJGV6hZT0929N/Xn
         /3mnYgnxpyjSoW+zvGOnbcR5f53NLS9Ydi4/LG7FlniXeISHWyqMPm2eH5AgWZsA2n
         4S9whw9mx9e/zx+wZt9flmmsUePE/eeqq3zhwq68=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9AEL02A016673;
        Wed, 10 Oct 2018 09:21:00 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 10
 Oct 2018 09:20:59 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 10 Oct 2018 09:20:59 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9AEKxkO025672;
        Wed, 10 Oct 2018 09:20:59 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.138.183])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w9AEKxx06346;
        Wed, 10 Oct 2018 09:20:59 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC PATCH 3/3] can: tcan4x5x: Add tcan4x5x driver to the kernel
Date:   Wed, 10 Oct 2018 09:20:55 -0500
Message-ID: <20181010142055.25271-4-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20181010142055.25271-1-dmurphy@ti.com>
References: <20181010142055.25271-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the TCAN4x5x SPI CAN driver.  This device
uses the Bosch MCAN IP core along with a SPI
interface map.  Leverage the MCAN common core
code to manage the MCAN IP.

This device has a special method to indicate a
write/read operation on the data payload.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/can/m_can/Kconfig    |   6 +
 drivers/net/can/m_can/Makefile   |   1 +
 drivers/net/can/m_can/tcan4x5x.c | 321 +++++++++++++++++++++++++++++++
 3 files changed, 328 insertions(+)
 create mode 100644 drivers/net/can/m_can/tcan4x5x.c

diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
index b1a9358b7660..943e10e15f17 100644
--- a/drivers/net/can/m_can/Kconfig
+++ b/drivers/net/can/m_can/Kconfig
@@ -15,3 +15,9 @@ config CAN_M_CAN_PLATFORM
 	tristate "Bosch M_CAN devices"
 	---help---
 	  Say Y here if you want to support for Bosch M_CAN controller.
+
+config CAN_M_CAN_TCAN4X5X
+	depends on CAN_M_CAN_CORE
+	tristate "TCAN4X5X M_CAN device"
+	---help---
+	  Say Y here if you want to support for TI M_CAN controller.
diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
index e013d6f4c941..6a9584908d10 100644
--- a/drivers/net/can/m_can/Makefile
+++ b/drivers/net/can/m_can/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_CAN_M_CAN_CORE) += m_can_core.o
 obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can.o
+obj-$(CONFIG_CAN_M_CAN_TCAN4X5X) += tcan4x5x.o
diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
new file mode 100644
index 000000000000..e43d591c696d
--- /dev/null
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPI to CAN driver for the Texas Instruments TCAN4x5x
+// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
+
+#include "m_can_core.h"
+
+#define DEVICE_NAME "tcan4x5x"
+#define TCAN4X5X_EXT_CLK_DEF	40000000
+
+#define TCAN4X5X_DEV_ID0	0x00
+#define TCAN4X5X_DEV_ID1	0x04
+#define TCAN4X5X_REV		0x08
+#define TCAN4X5X_STATUS		0x0C
+#define TCAN4X5X_ERROR_STATUS	0x10
+#define TCAN4X5X_CONTROL	0x14
+
+#define TCAN4X5X_CONFIG		0x800
+#define TCAN4X5X_TS_PRESCALE	0x804
+#define TCAN4X5X_TEST_REG	0x808
+#define TCAN4X5X_INT_FLAGS	0x820
+#define TCAN4X5X_MCAN_INT_REG	0x824
+#define TCAN4X5X_INT_EN		0x830
+
+#define TCAN4X5X_MRAM_START	0x8000
+
+#define TCAN4X5X_MAX_REGISTER	0x8fff
+
+#define TCAN4X5X_WRITE_CMD	(0x61 << 24)
+#define TCAN4X5X_READ_CMD	(0x41 << 24)
+
+struct tcan4x5x_priv {
+	struct regmap *regmap;
+	struct spi_device *spi;
+	struct mutex tcan4x5x_lock; /* SPI device lock */
+
+	struct gpio_desc *reset_gpio;
+	struct gpio_desc *interrupt_gpio;
+	struct gpio_desc *wake_gpio;
+	struct regulator *power;
+};
+
+static int regmap_spi_gather_write(void *context, const void *reg,
+				   size_t reg_len, const void *val,
+				   size_t val_len)
+{
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+	u32 addr;
+	struct spi_message m;
+	struct spi_transfer t[2] = {{ .tx_buf = &addr, .len = 4, .cs_change = 0,},
+				   { .tx_buf = val, .len = val_len, },};
+
+	addr = TCAN4X5X_WRITE_CMD | (*((u16 *)reg) << 8) | val_len >> 2;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t[0], &m);
+	spi_message_add_tail(&t[1], &m);
+
+	return spi_sync(spi, &m);
+}
+
+static int tcan4x5x_regmap_write(void *context, const void *data, size_t count)
+{
+	u16 *reg = (u16 *)(data);
+	const u32 *val = data + 2;
+
+	return regmap_spi_gather_write(context, reg, 2, val, count - 2);
+}
+
+static int regmap_spi_async_write(void *context,
+				  const void *reg, size_t reg_len,
+				  const void *val, size_t val_len,
+				  struct regmap_async *a)
+{
+	return -ENOTSUPP;
+}
+
+static struct regmap_async *regmap_spi_async_alloc(void)
+{
+	return NULL;
+}
+
+static int tcan4x5x_regmap_read(void *context,
+				const void *reg, size_t reg_size,
+				void *val, size_t val_size)
+{
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+
+	u32 addr = TCAN4X5X_READ_CMD | (*((u16 *)reg) << 8) | val_size >> 2;
+
+	return spi_write_then_read(spi, &addr, 4, val, val_size);
+}
+
+static struct regmap_bus tcan4x5x_bus = {
+	.write = tcan4x5x_regmap_write,
+	.gather_write = regmap_spi_gather_write,
+	.async_write = regmap_spi_async_write,
+	.async_alloc = regmap_spi_async_alloc,
+	.read = tcan4x5x_regmap_read,
+	.read_flag_mask = 0x00,
+	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
+	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
+};
+
+u32 tcan4x5x_read_reg(const struct m_can_classdev *m_can_class, int reg)
+{
+	struct tcan4x5x_priv *priv = (struct tcan4x5x_priv *)m_can_class->device_data;
+	u32 val;
+
+	regmap_read(priv->regmap, reg, &val);
+
+	return val;
+}
+
+u32 tcan4x5x_read_fifo(const struct m_can_classdev *m_can_class, int reg)
+{
+	struct tcan4x5x_priv *priv = (struct tcan4x5x_priv *)m_can_class->device_data;
+	u32 val;
+
+	regmap_read(priv->regmap, reg, &val);
+
+	return val;
+}
+
+int tcan4x5x_write_reg(const struct m_can_classdev *m_can_class, int reg, int val)
+{
+	struct tcan4x5x_priv *priv = (struct tcan4x5x_priv *)m_can_class->device_data;
+
+	return regmap_write(priv->regmap, reg, val);
+}
+
+int tcan4x5x_write_fifo(const struct m_can_classdev *m_can_class, int reg, int val)
+{
+	struct tcan4x5x_priv *priv = (struct tcan4x5x_priv *)m_can_class->device_data;
+
+	return regmap_write(priv->regmap, reg, val);
+}
+
+static int tcan4x5x_power_enable(struct regulator *reg, int enable)
+{
+	if (IS_ERR_OR_NULL(reg))
+		return 0;
+
+	if (enable)
+		return regulator_enable(reg);
+	else
+		return regulator_disable(reg);
+}
+
+static int tcan4x5x_init(struct m_can_classdev *class_dev)
+{
+	/* Zero out the MCAN buffers */
+	m_can_init_ram(class_dev);
+
+	return 0;
+}
+
+static int tcan4x5x_parse_config(struct m_can_classdev *class_dev)
+{
+	struct tcan4x5x_priv *tcan4x5x = (struct tcan4x5x_priv *)class_dev->device_data;
+
+	tcan4x5x->reset_gpio = devm_gpiod_get_optional(class_dev->dev,
+						       "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(tcan4x5x->reset_gpio))
+		tcan4x5x->reset_gpio = NULL;
+
+	tcan4x5x->wake_gpio = devm_gpiod_get_optional(class_dev->dev,
+						      "wake-up", GPIOD_OUT_LOW);
+	if (IS_ERR(tcan4x5x->wake_gpio))
+		tcan4x5x->wake_gpio = NULL;
+
+	tcan4x5x->interrupt_gpio = devm_gpiod_get(class_dev->dev,
+						  "data-ready", GPIOD_IN);
+	if (IS_ERR(tcan4x5x->interrupt_gpio)) {
+		dev_err(class_dev->dev, "data-ready gpio not defined\n");
+		return -EINVAL;
+	}
+
+	class_dev->net->irq = gpiod_to_irq(tcan4x5x->interrupt_gpio);
+
+	tcan4x5x->power = devm_regulator_get_optional(class_dev->dev,
+						      "vsup");
+	if (PTR_ERR(tcan4x5x->power) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	return 0;
+}
+
+static const struct regmap_config tcan4x5x_regmap = {
+	.reg_bits = 16,
+	.val_bits = 32,
+	.cache_type = REGCACHE_NONE,
+	.max_register = TCAN4X5X_MAX_REGISTER,
+};
+
+static int tcan4x5x_can_probe(struct spi_device *spi)
+{
+	struct tcan4x5x_priv *priv;
+	struct m_can_classdev *mcan_class;
+	int freq, ret;
+
+	mcan_class = m_can_core_allocate_dev(&spi->dev);
+	priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mcan_class->device_data = priv;
+
+	m_can_core_get_clocks(mcan_class);
+	if (IS_ERR(mcan_class->cclk)) {
+		dev_err(&spi->dev, "no CAN clock source defined\n");
+		freq = TCAN4X5X_EXT_CLK_DEF;
+	} else {
+		freq = clk_get_rate(mcan_class->cclk);
+	}
+
+	/* Sanity check */
+	if (freq < 20000000 || freq > TCAN4X5X_EXT_CLK_DEF)
+		return -ERANGE;
+
+	mcan_class->reg_offset = 0x1000;
+	mcan_class->pm_clock_support = 0;
+	mcan_class->mram_start = TCAN4X5X_MRAM_START;
+	mcan_class->m_can_read = &tcan4x5x_read_reg;
+	mcan_class->m_can_write = &tcan4x5x_write_reg;
+	mcan_class->m_can_fifo_write = &tcan4x5x_write_fifo;
+	mcan_class->m_can_fifo_read = &tcan4x5x_read_fifo;
+
+	mcan_class->can.clock.freq = freq;
+
+	mcan_class->dev = &spi->dev;
+	spi_set_drvdata(spi, priv);
+
+	ret = tcan4x5x_parse_config(mcan_class);
+	if (ret)
+		goto out_clk;
+
+	/* Configure the SPI bus */
+	spi->bits_per_word = 32;
+	ret = spi_setup(spi);
+	if (ret)
+		goto out_clk;
+
+	priv->regmap = devm_regmap_init(&spi->dev, &tcan4x5x_bus,
+					&spi->dev, &tcan4x5x_regmap);
+
+	tcan4x5x_init(mcan_class);
+
+	m_can_core_register(mcan_class);
+
+	mutex_init(&priv->tcan4x5x_lock);
+
+	netdev_info(mcan_class->net, "TCAN4X5X successfully initialized.\n");
+	return 0;
+
+out_clk:
+	if (!IS_ERR(mcan_class->cclk)) {
+		clk_disable_unprepare(mcan_class->cclk);
+		clk_disable_unprepare(mcan_class->hclk);
+	}
+
+	free_candev(mcan_class->net);
+	dev_err(&spi->dev, "Probe failed, err=%d\n", -ret);
+	return ret;
+}
+
+static int tcan4x5x_can_remove(struct spi_device *spi)
+{
+#if 0
+	struct tcan4x5x_priv *priv = spi_get_drvdata(spi);
+	struct net_device *net = mcan_class->net;
+
+	unregister_candev(net);
+
+	tcan4x5x_power_enable(priv->power, 0);
+
+	if (!IS_ERR(mcan_class->cclk))
+		clk_disable_unprepare(mcan_class->cclk);
+
+	free_candev(net);
+#endif
+	return 0;
+}
+
+static const struct of_device_id tcan4x5x_of_match[] = {
+	{ .compatible = "ti,tcan4x5x", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tcan4x5x_of_match);
+
+static const struct spi_device_id tcan4x5x_id_table[] = {
+	{
+		.name		= "tcan4x5x",
+		.driver_data	= 0,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, tcan4x5x_id_table);
+
+static struct spi_driver tcan4x5x_can_driver = {
+	.driver = {
+		.name = DEVICE_NAME,
+		.of_match_table = tcan4x5x_of_match,
+		.pm = NULL,
+	},
+	.id_table = tcan4x5x_id_table,
+	.probe = tcan4x5x_can_probe,
+	.remove = tcan4x5x_can_remove,
+};
+module_spi_driver(tcan4x5x_can_driver);
+
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_DESCRIPTION("Texas Instruments TCAN4x5x CAN driver");
+MODULE_LICENSE("GPL v2");
-- 
2.19.0

