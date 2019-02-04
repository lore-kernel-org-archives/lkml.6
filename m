Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6172C169C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE7021871
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfBDAS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 19:18:56 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:51324 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfBDASz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 19:18:55 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id B028F3A019A;
        Mon,  4 Feb 2019 01:15:17 +0100 (CET)
Received: from pc.localdomain (unknown [91.192.165.7])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C30D9200003;
        Mon,  4 Feb 2019 00:15:14 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 3/3] IIO: add Ingenic JZ47xx ADC driver.
Date:   Mon,  4 Feb 2019 01:15:14 +0100
Message-Id: <20190204001514.29891-3-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204001514.29891-1-contact@artur-rojek.eu>
References: <20190204001514.29891-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an IIO driver for the ADC hardware present on Ingenic JZ47xx SoCs.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---

 Changes:

 v2: - prefix all platform defines with JZ_ADC_*,
     - replace spinlock with a mutex,
     - change devm_add_action to devm_add_action_or_reset,
     - add a function wrapper for clk_unprepare,
     - change iio_dev->name from "adc" to "jz-adc",
     - simplify error handling code for devm_iio_device_register

 drivers/iio/adc/Kconfig       |   9 +
 drivers/iio/adc/Makefile      |   1 +
 drivers/iio/adc/ingenic-adc.c | 363 ++++++++++++++++++++++++++++++++++
 3 files changed, 373 insertions(+)
 create mode 100644 drivers/iio/adc/ingenic-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7a3ca4ec0cb7..f9f349a22b04 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -367,6 +367,15 @@ config INA2XX_ADC
 	  Say yes here to build support for TI INA2xx family of Power Monitors.
 	  This driver is mutually exclusive with the HWMON version.
 
+config INGENIC_ADC
+	tristate "Ingenic JZ47xx SoCs ADC driver"
+	depends on MIPS || COMPILE_TEST
+	help
+	  Say yes here to build support for the Ingenic JZ47xx SoCs ADC unit.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ingenic_adc.
+
 config IMX7D_ADC
 	tristate "Freescale IMX7D ADC driver"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 07df37f621bd..0a7acab33b91 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_HI8435) += hi8435.o
 obj-$(CONFIG_HX711) += hx711.o
 obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
 obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
+obj-$(CONFIG_INGENIC_ADC) += ingenic-adc.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
new file mode 100644
index 000000000000..1f436df1fd45
--- /dev/null
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADC driver for the Ingenic JZ47xx SoCs
+ * Copyright (c) 2019 Artur Rojek <contact@artur-rojek.eu>
+ *
+ * based on drivers/mfd/jz4740-adc.c
+ */
+
+#include <dt-bindings/iio/adc/ingenic,adc.h>
+#include <linux/clk.h>
+#include <linux/iio/iio.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+
+#define JZ_ADC_REG_ENABLE		0x00
+#define JZ_ADC_REG_CFG			0x04
+#define JZ_ADC_REG_CTRL			0x08
+#define JZ_ADC_REG_STATUS		0x0c
+#define JZ_ADC_REG_ADTCH		0x18
+#define JZ_ADC_REG_ADBDAT		0x1c
+#define JZ_ADC_REG_ADSDAT		0x20
+
+#define JZ_ADC_REG_CFG_BAT_MD		BIT(4)
+
+#define JZ_ADC_AUX_VREF				3300
+#define JZ_ADC_AUX_VREF_BITS			12
+#define JZ_ADC_BATTERY_LOW_VREF			2500
+#define JZ_ADC_BATTERY_LOW_VREF_BITS		12
+#define JZ4725B_ADC_BATTERY_HIGH_VREF		7500
+#define JZ4725B_ADC_BATTERY_HIGH_VREF_BITS	10
+#define JZ4740_ADC_BATTERY_HIGH_VREF		(7500 * 0.986)
+#define JZ4740_ADC_BATTERY_HIGH_VREF_BITS	12
+
+struct ingenic_adc_soc_data {
+	unsigned int battery_high_vref;
+	unsigned int battery_high_vref_bits;
+	const int *battery_raw_avail;
+	size_t battery_raw_avail_size;
+	const int *battery_scale_avail;
+	size_t battery_scale_avail_size;
+};
+
+struct ingenic_adc {
+	void __iomem *base;
+	struct clk *clk;
+	struct mutex lock;
+	const struct ingenic_adc_soc_data *soc_data;
+	bool low_vref_mode;
+};
+
+static void ingenic_adc_set_config(struct ingenic_adc *adc,
+				   uint32_t mask,
+				   uint32_t val)
+{
+	uint32_t cfg;
+
+	clk_enable(adc->clk);
+	mutex_lock(&adc->lock);
+
+	cfg = readl(adc->base + JZ_ADC_REG_CFG) & ~mask;
+	cfg |= val;
+	writel(cfg, adc->base + JZ_ADC_REG_CFG);
+
+	mutex_unlock(&adc->lock);
+	clk_disable(adc->clk);
+}
+
+static void ingenic_adc_enable(struct ingenic_adc *adc,
+			       int engine,
+			       bool enabled)
+{
+	u8 val;
+
+	mutex_lock(&adc->lock);
+	val = readb(adc->base + JZ_ADC_REG_ENABLE);
+
+	if (enabled)
+		val |= BIT(engine);
+	else
+		val &= ~BIT(engine);
+
+	writeb(val, adc->base + JZ_ADC_REG_ENABLE);
+	mutex_unlock(&adc->lock);
+}
+
+static int ingenic_adc_capture(struct ingenic_adc *adc,
+			       int engine)
+{
+	u8 val;
+	int ret;
+
+	ingenic_adc_enable(adc, engine, true);
+	ret = readb_poll_timeout(adc->base + JZ_ADC_REG_ENABLE, val,
+				 !(val & BIT(engine)), 250, 1000);
+	if (ret)
+		ingenic_adc_enable(adc, engine, false);
+
+	return ret;
+}
+
+static int ingenic_adc_write_raw(struct iio_dev *iio_dev,
+				 struct iio_chan_spec const *chan,
+				 int val,
+				 int val2,
+				 long m)
+{
+	struct ingenic_adc *adc = iio_priv(iio_dev);
+
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->channel) {
+		case INGENIC_ADC_BATTERY:
+			if (val > JZ_ADC_BATTERY_LOW_VREF) {
+				ingenic_adc_set_config(adc,
+						       JZ_ADC_REG_CFG_BAT_MD,
+						       0);
+				adc->low_vref_mode = false;
+			} else {
+				ingenic_adc_set_config(adc,
+						       JZ_ADC_REG_CFG_BAT_MD,
+						       JZ_ADC_REG_CFG_BAT_MD);
+				adc->low_vref_mode = true;
+			}
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static const int jz4725b_adc_battery_raw_avail[] = {
+	0, 1, (1 << JZ_ADC_BATTERY_LOW_VREF_BITS) - 1,
+};
+
+static const int jz4725b_adc_battery_scale_avail[] = {
+	JZ4725B_ADC_BATTERY_HIGH_VREF, JZ4725B_ADC_BATTERY_HIGH_VREF_BITS,
+	JZ_ADC_BATTERY_LOW_VREF, JZ_ADC_BATTERY_LOW_VREF_BITS,
+};
+
+static const int jz4740_adc_battery_raw_avail[] = {
+	0, 1, (1 << JZ_ADC_BATTERY_LOW_VREF_BITS) - 1,
+};
+
+static const int jz4740_adc_battery_scale_avail[] = {
+	JZ4740_ADC_BATTERY_HIGH_VREF, JZ4740_ADC_BATTERY_HIGH_VREF_BITS,
+	JZ_ADC_BATTERY_LOW_VREF, JZ_ADC_BATTERY_LOW_VREF_BITS,
+};
+
+static const struct ingenic_adc_soc_data jz4725b_adc_soc_data = {
+	.battery_high_vref = JZ4725B_ADC_BATTERY_HIGH_VREF,
+	.battery_high_vref_bits = JZ4725B_ADC_BATTERY_HIGH_VREF_BITS,
+	.battery_raw_avail = jz4725b_adc_battery_raw_avail,
+	.battery_raw_avail_size = ARRAY_SIZE(jz4725b_adc_battery_raw_avail),
+	.battery_scale_avail = jz4725b_adc_battery_scale_avail,
+	.battery_scale_avail_size = ARRAY_SIZE(jz4725b_adc_battery_scale_avail),
+};
+
+static const struct ingenic_adc_soc_data jz4740_adc_soc_data = {
+	.battery_high_vref = JZ4740_ADC_BATTERY_HIGH_VREF,
+	.battery_high_vref_bits = JZ4740_ADC_BATTERY_HIGH_VREF_BITS,
+	.battery_raw_avail = jz4740_adc_battery_raw_avail,
+	.battery_raw_avail_size = ARRAY_SIZE(jz4740_adc_battery_raw_avail),
+	.battery_scale_avail = jz4740_adc_battery_scale_avail,
+	.battery_scale_avail_size = ARRAY_SIZE(jz4740_adc_battery_scale_avail),
+};
+
+static int ingenic_adc_read_avail(struct iio_dev *iio_dev,
+				  struct iio_chan_spec const *chan,
+				  const int **vals,
+				  int *type,
+				  int *length,
+				  long m)
+{
+	struct ingenic_adc *adc = iio_priv(iio_dev);
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		*type = IIO_VAL_INT;
+		*length = adc->soc_data->battery_raw_avail_size;
+		*vals = adc->soc_data->battery_raw_avail;
+		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_FRACTIONAL_LOG2;
+		*length = adc->soc_data->battery_scale_avail_size;
+		*vals = adc->soc_data->battery_scale_avail;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	};
+}
+
+static int ingenic_adc_read_raw(struct iio_dev *iio_dev,
+				struct iio_chan_spec const *chan,
+				int *val,
+				int *val2,
+				long m)
+{
+	struct ingenic_adc *adc = iio_priv(iio_dev);
+	int ret;
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		clk_enable(adc->clk);
+		ret = ingenic_adc_capture(adc, chan->channel);
+		if (ret) {
+			clk_disable(adc->clk);
+			return ret;
+		}
+
+		switch (chan->channel) {
+		case INGENIC_ADC_AUX:
+			*val = readw(adc->base + JZ_ADC_REG_ADSDAT);
+			break;
+		case INGENIC_ADC_BATTERY:
+			*val = readw(adc->base + JZ_ADC_REG_ADBDAT);
+			break;
+		}
+
+		clk_disable(adc->clk);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->channel) {
+		case INGENIC_ADC_AUX:
+			*val = JZ_ADC_AUX_VREF;
+			*val2 = JZ_ADC_AUX_VREF_BITS;
+			break;
+		case INGENIC_ADC_BATTERY:
+			if (adc->low_vref_mode) {
+				*val = JZ_ADC_BATTERY_LOW_VREF;
+				*val2 = JZ_ADC_BATTERY_LOW_VREF_BITS;
+			} else {
+				*val = adc->soc_data->battery_high_vref;
+				*val2 = adc->soc_data->battery_high_vref_bits;
+			}
+			break;
+		}
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static void ingenic_adc_clk_cleanup(void *data)
+{
+	clk_unprepare(data);
+}
+
+static const struct iio_info ingenic_adc_info = {
+	.write_raw = ingenic_adc_write_raw,
+	.read_raw = ingenic_adc_read_raw,
+	.read_avail = ingenic_adc_read_avail,
+};
+
+static const struct iio_chan_spec ingenic_channels[] = {
+	{
+		.extend_name = "aux",
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = INGENIC_ADC_AUX,
+	},
+	{
+		.extend_name = "battery",
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW) |
+						BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = INGENIC_ADC_BATTERY,
+	},
+};
+
+static int ingenic_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *iio_dev;
+	struct ingenic_adc *adc;
+	struct resource *mem_base;
+	const struct ingenic_adc_soc_data *soc_data;
+	int ret;
+
+	soc_data = device_get_match_data(dev);
+	if (!soc_data)
+		return -EINVAL;
+
+	iio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	adc = iio_priv(iio_dev);
+	mutex_init(&adc->lock);
+	adc->soc_data = soc_data;
+
+	mem_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	adc->base = devm_ioremap_resource(dev, mem_base);
+	if (IS_ERR(adc->base)) {
+		dev_err(dev, "Unable to ioremap mmio resource\n");
+		return PTR_ERR(adc->base);
+	}
+
+	adc->clk = devm_clk_get(dev, "adc");
+	if (IS_ERR(adc->clk)) {
+		dev_err(dev, "Unable to get clock\n");
+		return PTR_ERR(adc->clk);
+	}
+
+	ret = clk_prepare_enable(adc->clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable clock\n");
+		return ret;
+	}
+
+	/* Put hardware in a known passive state. */
+	writeb(0x00, adc->base + JZ_ADC_REG_ENABLE);
+	writeb(0xff, adc->base + JZ_ADC_REG_CTRL);
+	clk_disable(adc->clk);
+
+	ret = devm_add_action_or_reset(dev, ingenic_adc_clk_cleanup, adc->clk);
+	if (ret) {
+		dev_err(dev, "Unable to add action\n");
+		return ret;
+	}
+
+	iio_dev->dev.parent = dev;
+	iio_dev->name = "jz-adc";
+	iio_dev->modes = INDIO_DIRECT_MODE;
+	iio_dev->channels = ingenic_channels;
+	iio_dev->num_channels = ARRAY_SIZE(ingenic_channels);
+	iio_dev->info = &ingenic_adc_info;
+
+	ret = devm_iio_device_register(dev, iio_dev);
+	if (ret)
+		dev_err(dev, "Unable to register IIO device\n");
+
+	return ret;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id ingenic_adc_of_match[] = {
+	{ .compatible = "ingenic,jz4725b-adc", .data = &jz4725b_adc_soc_data, },
+	{ .compatible = "ingenic,jz4740-adc", .data = &jz4740_adc_soc_data, },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ingenic_adc_of_match);
+#endif
+
+static struct platform_driver ingenic_adc_driver = {
+	.driver = {
+		.name = "ingenic-adc",
+		.of_match_table = of_match_ptr(ingenic_adc_of_match),
+	},
+	.probe = ingenic_adc_probe,
+};
+module_platform_driver(ingenic_adc_driver);
-- 
2.20.1

