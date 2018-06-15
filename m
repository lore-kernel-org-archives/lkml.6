Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A7E52C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F91E208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ze4y12W/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F91E208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755887AbeFOHDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 03:03:55 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35252 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755750AbeFOHDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 03:03:49 -0400
Received: by mail-pf0-f194.google.com with SMTP id c22-v6so4447913pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6OdSsixCYxVBglfAAVmW+/BMk05IH2UymgWtBaUjzZE=;
        b=Ze4y12W/yCLcySsKtLbk+NEleoGyGZh7Qnxv8WC1rqDKiEHNH5eHu4pOV5mSzDNL51
         ALJOwzNxBeugclRzE5IycdDBwzZRjyzpVMooctldoPFAz1SHhZXo5C2HryaK2i2rPAS9
         TfPMDHjmqUJAtFZTsjwQq1PN+ysduV4EnJ3Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6OdSsixCYxVBglfAAVmW+/BMk05IH2UymgWtBaUjzZE=;
        b=qS/x2J59xe3ffjS97ZDlYHDmaAjZoyqsHeadDpQN/An6gnaCUs/VTfZ/oI2U8bjApu
         baU+/qWIIswHxDjuarZGPdVl3hynDjspSvcTrCEWnDpMcPVGm0ewdC5XAf7EKBOVKDBx
         1H44DwXLzLkNRDBvQCVXqvYWyfB8iHfYPjzjvQp92I4jUfZGB2R3ldcPOTxgB06alJcS
         uaomgnbckY1ldhCKhPjDcJwNj/LiGjnIlTgDjjI61v5x0KsULF8+msElTPvY0mxzAOD3
         W3rZz1TzukmxBH7sCDh+Thz83RLCQ63KNr2eL63CkM9oBs0Fir5Dvr2eYN6D/y6VCr70
         Y8XQ==
X-Gm-Message-State: APt69E1w7+7YfUeO2jvr7jNnNelLPxXipbjZ4197iW8OLaMI97sQNWQn
        4CDczH/Sm7sFASN9mIrqh4xX+A==
X-Google-Smtp-Source: ADUXVKJj673gTgGJSlM5rO1d4gt109ES4sIx+72GW6ClsIli3695x4X4+nE2iC/1kpgPKwKoIKbr8A==
X-Received: by 2002:a62:a38d:: with SMTP id q13-v6mr556200pfl.49.1529046229028;
        Fri, 15 Jun 2018 00:03:49 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h78-v6sm15139330pfh.141.2018.06.15.00.03.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jun 2018 00:03:48 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     baolin.wang@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, freeman.liu@spreadtrum.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: adc: Add Spreadtrum SC27XX PMICs ADC support
Date:   Fri, 15 Jun 2018 15:03:36 +0800
Message-Id: <5728839377cefd20cdb95913b43dbdab530c1e81.1529040864.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <9b6743bb6782041b7fec9ed0e166faf2b6456de4.1529040864.git.baolin.wang@linaro.org>
References: <9b6743bb6782041b7fec9ed0e166faf2b6456de4.1529040864.git.baolin.wang@linaro.org>
In-Reply-To: <9b6743bb6782041b7fec9ed0e166faf2b6456de4.1529040864.git.baolin.wang@linaro.org>
References: <9b6743bb6782041b7fec9ed0e166faf2b6456de4.1529040864.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Freeman Liu <freeman.liu@spreadtrum.com>

The Spreadtrum SC27XX PMICs ADC controller contains 32 channels,
which is used to sample voltages with 12 bits conversion.

Signed-off-by: Freeman Liu <freeman.liu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v1:
 - Add const for static structures definition.
 - Change SC27XX_ADC_TO_VOLTAGE macro to be one function.
 - Move channel scale accessing into mutex protection.
 - Fix some typos.
---
 drivers/iio/adc/Kconfig      |   10 +
 drivers/iio/adc/Makefile     |    1 +
 drivers/iio/adc/sc27xx_adc.c |  547 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 558 insertions(+)
 create mode 100644 drivers/iio/adc/sc27xx_adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 9da7907..985b73e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -621,6 +621,16 @@ config ROCKCHIP_SARADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called rockchip_saradc.
 
+config SC27XX_ADC
+	tristate "Spreadtrum SC27xx series PMICs ADC"
+	depends on MFD_SC27XX_PMIC || COMPILE_TEST
+	help
+	  Say yes here to build support for the integrated ADC inside the
+	  Spreadtrum SC27xx series PMICs.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called sc27xx_adc.
+
 config SPEAR_ADC
 	tristate "ST SPEAr ADC"
 	depends on PLAT_SPEAR || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 28a9423..03db7b5 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
 obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
 obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
+obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
 obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
 obj-$(CONFIG_STX104) += stx104.o
 obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
new file mode 100644
index 0000000..52e5b74
--- /dev/null
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -0,0 +1,547 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Spreadtrum Communications Inc.
+
+#include <linux/hwspinlock.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/* PMIC global registers definition */
+#define SC27XX_MODULE_EN		0xc08
+#define SC27XX_MODULE_ADC_EN		BIT(5)
+#define SC27XX_ARM_CLK_EN		0xc10
+#define SC27XX_CLK_ADC_EN		BIT(5)
+#define SC27XX_CLK_ADC_CLK_EN		BIT(6)
+
+/* ADC controller registers definition */
+#define SC27XX_ADC_CTL			0x0
+#define SC27XX_ADC_CH_CFG		0x4
+#define SC27XX_ADC_DATA			0x4c
+#define SC27XX_ADC_INT_EN		0x50
+#define SC27XX_ADC_INT_CLR		0x54
+#define SC27XX_ADC_INT_STS		0x58
+#define SC27XX_ADC_INT_RAW		0x5c
+
+/* Bits and mask definition for SC27XX_ADC_CTL register */
+#define SC27XX_ADC_EN			BIT(0)
+#define SC27XX_ADC_CHN_RUN		BIT(1)
+#define SC27XX_ADC_12BIT_MODE		BIT(2)
+#define SC27XX_ADC_RUN_NUM_MASK		GENMASK(7, 4)
+#define SC27XX_ADC_RUN_NUM_SHIFT	4
+
+/* Bits and mask definition for SC27XX_ADC_CH_CFG register */
+#define SC27XX_ADC_CHN_ID_MASK		GENMASK(4, 0)
+#define SC27XX_ADC_SCALE_MASK		GENMASK(10, 8)
+#define SC27XX_ADC_SCALE_SHIFT		8
+
+/* Bits definitions for SC27XX_ADC_INT_EN registers */
+#define SC27XX_ADC_IRQ_EN		BIT(0)
+
+/* Bits definitions for SC27XX_ADC_INT_CLR registers */
+#define SC27XX_ADC_IRQ_CLR		BIT(0)
+
+/* Mask definition for SC27XX_ADC_DATA register */
+#define SC27XX_ADC_DATA_MASK		GENMASK(11, 0)
+
+/* Timeout (ms) for the trylock of hardware spinlocks */
+#define SC27XX_ADC_HWLOCK_TIMEOUT	5000
+
+/* Maximum ADC channel number */
+#define SC27XX_ADC_CHANNEL_MAX		32
+
+/* ADC voltage ratio definition */
+#define SC27XX_VOLT_RATIO(n, d)		\
+	(((n) << SC27XX_RATIO_NUMERATOR_OFFSET) | (d))
+#define SC27XX_RATIO_NUMERATOR_OFFSET	16
+#define SC27XX_RATIO_DENOMINATOR_MASK	GENMASK(15, 0)
+
+struct sc27xx_adc_data {
+	struct device *dev;
+	struct regmap *regmap;
+	/*
+	 * One hardware spinlock to synchronize between the multiple
+	 * subsystems which will access the unique ADC controller.
+	 */
+	struct hwspinlock *hwlock;
+	struct completion completion;
+	int channel_scale[SC27XX_ADC_CHANNEL_MAX];
+	int (*get_volt_ratio)(int channel, int scale);
+	u32 base;
+	int value;
+	int irq;
+};
+
+struct sc27xx_adc_linear_graph {
+	int volt0;
+	int adc0;
+	int volt1;
+	int adc1;
+};
+
+/*
+ * According to the datasheet, we can convert one ADC value to one voltage value
+ * through 2 points in the linear graph. If the voltage is less than 1.2v, we
+ * should use the small-scale graph, and if more than 1.2v, we should use the
+ * big-scale graph.
+ */
+static const struct sc27xx_adc_linear_graph big_scale_graph = {
+	4200, 3310,
+	3600, 2832,
+};
+
+static const struct sc27xx_adc_linear_graph small_scale_graph = {
+	1000, 3413,
+	100, 341,
+};
+
+static int sc27xx_adc_2731_ratio(int channel, int scale)
+{
+	switch (channel) {
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+		return scale ? SC27XX_VOLT_RATIO(400, 1025) :
+			SC27XX_VOLT_RATIO(1, 1);
+	case 5:
+		return SC27XX_VOLT_RATIO(7, 29);
+	case 6:
+		return SC27XX_VOLT_RATIO(375, 9000);
+	case 7:
+	case 8:
+		return scale ? SC27XX_VOLT_RATIO(100, 125) :
+			SC27XX_VOLT_RATIO(1, 1);
+	case 19:
+		return SC27XX_VOLT_RATIO(1, 3);
+	default:
+		return SC27XX_VOLT_RATIO(1, 1);
+	}
+	return SC27XX_VOLT_RATIO(1, 1);
+}
+
+static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
+			   int scale, int *val)
+{
+	int ret;
+	u32 tmp;
+
+	reinit_completion(&data->completion);
+
+	ret = hwspin_lock_timeout_raw(data->hwlock, SC27XX_ADC_HWLOCK_TIMEOUT);
+	if (ret) {
+		dev_err(data->dev, "timeout to get the hwspinlock\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
+				 SC27XX_ADC_EN, SC27XX_ADC_EN);
+	if (ret)
+		goto unlock_adc;
+
+	/* Configure the channel id and scale */
+	tmp = (scale << SC27XX_ADC_SCALE_SHIFT) & SC27XX_ADC_SCALE_MASK;
+	tmp |= channel & SC27XX_ADC_CHN_ID_MASK;
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CH_CFG,
+				 SC27XX_ADC_CHN_ID_MASK | SC27XX_ADC_SCALE_MASK,
+				 tmp);
+	if (ret)
+		goto disable_adc;
+
+	/* Select 12bit conversion mode, and only sample 1 time */
+	tmp = SC27XX_ADC_12BIT_MODE;
+	tmp |= (0 << SC27XX_ADC_RUN_NUM_SHIFT) & SC27XX_ADC_RUN_NUM_MASK;
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
+				 SC27XX_ADC_RUN_NUM_MASK | SC27XX_ADC_12BIT_MODE,
+				 tmp);
+	if (ret)
+		goto disable_adc;
+
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
+				 SC27XX_ADC_CHN_RUN, SC27XX_ADC_CHN_RUN);
+	if (ret)
+		goto disable_adc;
+
+	wait_for_completion(&data->completion);
+
+disable_adc:
+	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
+			   SC27XX_ADC_EN, 0);
+unlock_adc:
+	hwspin_unlock_raw(data->hwlock);
+
+	if (!ret)
+		*val = data->value;
+
+	return ret;
+}
+
+static irqreturn_t sc27xx_adc_isr(int irq, void *dev_id)
+{
+	struct sc27xx_adc_data *data = dev_id;
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_CLR,
+				 SC27XX_ADC_IRQ_CLR, SC27XX_ADC_IRQ_CLR);
+	if (ret)
+		return IRQ_RETVAL(ret);
+
+	ret = regmap_read(data->regmap, data->base + SC27XX_ADC_DATA,
+			  &data->value);
+	if (ret)
+		return IRQ_RETVAL(ret);
+
+	data->value &= SC27XX_ADC_DATA_MASK;
+	complete(&data->completion);
+
+	return IRQ_HANDLED;
+}
+
+static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
+				  int channel, int scale,
+				  u32 *div_numerator, u32 *div_denominator)
+{
+	u32 ratio = data->get_volt_ratio(channel, scale);
+
+	*div_numerator = ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
+	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
+}
+
+static int sc27xx_adc_to_volt(const struct sc27xx_adc_linear_graph *graph,
+			      int raw_adc)
+{
+	int tmp;
+
+	tmp = (graph->volt0 - graph->volt1) * (raw_adc - graph->adc1);
+	tmp /= (graph->adc0 - graph->adc1);
+	tmp += graph->volt1;
+
+	return tmp < 0 ? 0 : tmp;
+}
+
+static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data, int channel,
+				   int scale, int raw_adc)
+{
+	u32 numerator, denominator;
+	u32 volt;
+
+	/*
+	 * Convert ADC values to voltage values according to the linear graph,
+	 * and channel 5 and channel 1 has been calibrated, so we can just
+	 * return the voltage values calculated by the linear graph. But other
+	 * channels need be calculated to the real voltage values with the
+	 * voltage ratio.
+	 */
+	switch (channel) {
+	case 5:
+		return sc27xx_adc_to_volt(&big_scale_graph, raw_adc);
+
+	case 1:
+		return sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
+
+	default:
+		volt = sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
+		break;
+	}
+
+	sc27xx_adc_volt_ratio(data, channel, scale, &numerator, &denominator);
+
+	return (volt * denominator + numerator / 2) / numerator;
+}
+
+static int sc27xx_adc_read_processed(struct sc27xx_adc_data *data,
+				     int channel, int scale, int *val)
+{
+	int ret, raw_adc;
+
+	ret = sc27xx_adc_read(data, channel, scale, &raw_adc);
+	if (ret)
+		return ret;
+
+	*val = sc27xx_adc_convert_volt(data, channel, scale, raw_adc);
+	return 0;
+}
+
+static int sc27xx_adc_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask)
+{
+	struct sc27xx_adc_data *data = iio_priv(indio_dev);
+	int scale, ret, tmp;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_AVERAGE_RAW:
+		mutex_lock(&indio_dev->mlock);
+		scale = data->channel_scale[chan->channel];
+		ret = sc27xx_adc_read(data, chan->channel, scale, &tmp);
+		mutex_unlock(&indio_dev->mlock);
+
+		if (ret)
+			return ret;
+
+		*val = tmp;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_PROCESSED:
+		mutex_lock(&indio_dev->mlock);
+		scale = data->channel_scale[chan->channel];
+		ret = sc27xx_adc_read_processed(data, chan->channel, scale,
+						&tmp);
+		mutex_unlock(&indio_dev->mlock);
+
+		if (ret)
+			return ret;
+
+		*val = tmp;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		mutex_lock(&indio_dev->mlock);
+		*val = data->channel_scale[chan->channel];
+		mutex_unlock(&indio_dev->mlock);
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sc27xx_adc_write_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int val, int val2, long mask)
+{
+	struct sc27xx_adc_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		mutex_lock(&indio_dev->mlock);
+		data->channel_scale[chan->channel] = val;
+		mutex_unlock(&indio_dev->mlock);
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info sc27xx_info = {
+	.read_raw = &sc27xx_adc_read_raw,
+	.write_raw = &sc27xx_adc_write_raw,
+};
+
+#define SC27XX_ADC_CHANNEL(index) {				\
+	.type = IIO_VOLTAGE,					\
+	.channel = index,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_AVERAGE_RAW) |	\
+			      BIT(IIO_CHAN_INFO_PROCESSED) |	\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.datasheet_name = "CH##index",				\
+	.indexed = 1,						\
+}
+
+static const struct iio_chan_spec sc27xx_channels[] = {
+	SC27XX_ADC_CHANNEL(0),
+	SC27XX_ADC_CHANNEL(1),
+	SC27XX_ADC_CHANNEL(2),
+	SC27XX_ADC_CHANNEL(3),
+	SC27XX_ADC_CHANNEL(4),
+	SC27XX_ADC_CHANNEL(5),
+	SC27XX_ADC_CHANNEL(6),
+	SC27XX_ADC_CHANNEL(7),
+	SC27XX_ADC_CHANNEL(8),
+	SC27XX_ADC_CHANNEL(9),
+	SC27XX_ADC_CHANNEL(10),
+	SC27XX_ADC_CHANNEL(11),
+	SC27XX_ADC_CHANNEL(12),
+	SC27XX_ADC_CHANNEL(13),
+	SC27XX_ADC_CHANNEL(14),
+	SC27XX_ADC_CHANNEL(15),
+	SC27XX_ADC_CHANNEL(16),
+	SC27XX_ADC_CHANNEL(17),
+	SC27XX_ADC_CHANNEL(18),
+	SC27XX_ADC_CHANNEL(19),
+	SC27XX_ADC_CHANNEL(20),
+	SC27XX_ADC_CHANNEL(21),
+	SC27XX_ADC_CHANNEL(22),
+	SC27XX_ADC_CHANNEL(23),
+	SC27XX_ADC_CHANNEL(24),
+	SC27XX_ADC_CHANNEL(25),
+	SC27XX_ADC_CHANNEL(26),
+	SC27XX_ADC_CHANNEL(27),
+	SC27XX_ADC_CHANNEL(28),
+	SC27XX_ADC_CHANNEL(29),
+	SC27XX_ADC_CHANNEL(30),
+	SC27XX_ADC_CHANNEL(31),
+};
+
+static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
+{
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
+				 SC27XX_MODULE_ADC_EN, SC27XX_MODULE_ADC_EN);
+	if (ret)
+		return ret;
+
+	/* Enable ADC work clock and controller clock */
+	ret = regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
+				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN,
+				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_EN,
+				 SC27XX_ADC_IRQ_EN, SC27XX_ADC_IRQ_EN);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_CLR,
+				  SC27XX_ADC_IRQ_CLR, SC27XX_ADC_IRQ_CLR);
+}
+
+static void sc27xx_adc_disable(struct sc27xx_adc_data *data)
+{
+	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_EN,
+			   SC27XX_ADC_IRQ_EN, 0);
+
+	/* Disable ADC work clock and controller clock */
+	regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
+			   SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0);
+
+	regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
+			   SC27XX_MODULE_ADC_EN, 0);
+}
+
+static int sc27xx_adc_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct sc27xx_adc_data *sc27xx_data;
+	struct iio_dev *indio_dev;
+	const void *data;
+	int ret;
+
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data) {
+		dev_err(&pdev->dev, "failed to get match data\n");
+		return -EINVAL;
+	}
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*sc27xx_data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	sc27xx_data = iio_priv(indio_dev);
+
+	sc27xx_data->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!sc27xx_data->regmap) {
+		dev_err(&pdev->dev, "failed to get ADC regmap\n");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32(np, "reg", &sc27xx_data->base);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get ADC base address\n");
+		return ret;
+	}
+
+	sc27xx_data->irq = platform_get_irq(pdev, 0);
+	if (sc27xx_data->irq < 0) {
+		dev_err(&pdev->dev, "failed to get ADC irq number\n");
+		return sc27xx_data->irq;
+	}
+
+	ret = of_hwspin_lock_get_id(np, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get hwspinlock id\n");
+		return ret;
+	}
+
+	sc27xx_data->hwlock = hwspin_lock_request_specific(ret);
+	if (!sc27xx_data->hwlock) {
+		dev_err(&pdev->dev, "failed to request hwspinlock\n");
+		return -ENXIO;
+	}
+
+	init_completion(&sc27xx_data->completion);
+
+	/*
+	 * Different PMIC ADC controllers can have different channel voltage
+	 * ratios, so we should save the implementation of getting voltage
+	 * ratio for corresponding PMIC ADC in the device data structure.
+	 */
+	sc27xx_data->get_volt_ratio = data;
+	sc27xx_data->dev = &pdev->dev;
+
+	ret = sc27xx_adc_enable(sc27xx_data);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable ADC module\n");
+		goto free_hwlock;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, sc27xx_data->irq, NULL,
+					sc27xx_adc_isr, IRQF_ONESHOT,
+					pdev->name, sc27xx_data);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request ADC irq\n");
+		goto disable_adc;
+	}
+
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &sc27xx_info;
+	indio_dev->channels = sc27xx_channels;
+	indio_dev->num_channels = ARRAY_SIZE(sc27xx_channels);
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "could not register iio (ADC)");
+		goto disable_adc;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+	return 0;
+
+disable_adc:
+	sc27xx_adc_disable(sc27xx_data);
+free_hwlock:
+	hwspin_lock_free(sc27xx_data->hwlock);
+	return ret;
+}
+
+static int sc27xx_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct sc27xx_adc_data *sc27xx_data = iio_priv(indio_dev);
+
+	sc27xx_adc_disable(sc27xx_data);
+	hwspin_lock_free(sc27xx_data->hwlock);
+	return 0;
+}
+
+static const struct of_device_id sc27xx_adc_of_match[] = {
+	{
+		.compatible = "sprd,sc2731-adc",
+		.data = (void *)&sc27xx_adc_2731_ratio,
+	},
+	{ }
+};
+
+static struct platform_driver sc27xx_adc_driver = {
+	.probe = sc27xx_adc_probe,
+	.remove = sc27xx_adc_remove,
+	.driver = {
+		.name = "sc27xx-adc",
+		.of_match_table = sc27xx_adc_of_match,
+	},
+};
+
+module_platform_driver(sc27xx_adc_driver);
+
+MODULE_AUTHOR("Freeman Liu <freeman.liu@spreadtrum.com>");
+MODULE_DESCRIPTION("Spreadtrum SC27XX ADC Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

