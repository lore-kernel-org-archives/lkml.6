Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B15C43613
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF26206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbfAINmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:42:43 -0500
Received: from mxout013.mail.hostpoint.ch ([217.26.49.173]:11760 "EHLO
        mxout013.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730995AbfAINmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:42:39 -0500
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1ghE7n-0002he-5B; Wed, 09 Jan 2019 14:42:27 +0100
Received: from 252.222.41.212.static.wline.lns.sme.cust.swisscom.ch ([212.41.222.252] helo=philippe-pc.toradex.int)
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1ghE7m-0006KA-U2; Wed, 09 Jan 2019 14:42:27 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch
Cc:     robh@kernel.org, alexandre.torgue@st.com, shawnguo@kernel.org,
        dmitry.torokhov@gmail.com, thierry.reding@gmail.com,
        mcoquelin.stm32@gmail.com, digetx@gmail.com, lee.jones@linaro.org,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stefan Popa <stefan.popa@analog.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Freeman Liu <freeman.liu@spreadtrum.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Hartmut Knaack <knaack.h@gmx.de>,
        linux-arm-kernel@lists.infradead.org,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Kent Gustavsson <kent@minoris.se>
Subject: [PATCH v6 5/8] iio: adc: add STMPE ADC driver using IIO framework
Date:   Wed,  9 Jan 2019 14:42:04 +0100
Message-Id: <20190109134208.5660-6-dev@pschenker.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109134208.5660-1-dev@pschenker.ch>
References: <20190109134208.5660-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

This adds an ADC driver for the STMPE device using the industrial
input/output interface. The driver supports raw reading of values.
The driver depends on the MFD STMPE driver. If the touchscreen
block is enabled too, only four of the 8 ADC channels are available.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---

Changes in v6: None
Changes in v5:
 - Removed devm_add_action_or_reset
 - Changed iio_device_register to devm_iio_device_register
 - Added Jonathan Cameron's Reviewed-by
 - Added correct author of commit, as this changed by accident

Changes in v4:
 - Moved MFD changes to a precursor patch
 - Moved stmpe-ts changes to a precursor patch
 - Created stmpe_read_temp and stmpe_read_voltage functions to make
   read_raw more readable
 - Added local lock instead of using indio_dev's mlock
 - Use be16_to_cpu() macro instead of bitshifting
 - Added stmpe_enable again to stmpe_adc_init_hw
 - Use devm_add_action_or_reset to get rid of the remove function
   (I tested if that actually works)

Changes in v3:
 - Removed COMPILE_TEST from dependings in Kconfig
 - Removed stmpe_adc_get_platform_info() function and integrated the
   few code lines in the other function

Changes in v2:
 - Code formatting
 - Removed unused includes
 - Defined the macro STMPE_START_ONE_TEMP_CONV with other macros.
 - Added new macro that defines the channel of the temperature sensor.
   Took new name for STMPE_MAX_ADC->STMPE_ADC_LAST_NR and used it
   throughout the code for better readability.
 - Added mutex_unlock where missing.

 drivers/iio/adc/Kconfig     |   7 +
 drivers/iio/adc/Makefile    |   1 +
 drivers/iio/adc/stmpe-adc.c | 363 ++++++++++++++++++++++++++++++++++++
 3 files changed, 371 insertions(+)
 create mode 100644 drivers/iio/adc/stmpe-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7a3ca4ec0cb7..5b72e2963153 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -755,6 +755,13 @@ config STM32_DFSDM_ADC
 	  This driver can also be built as a module.  If so, the module
 	  will be called stm32-dfsdm-adc.
 
+config STMPE_ADC
+	tristate "STMicroelectronics STMPE ADC driver"
+	depends on OF && MFD_STMPE
+	help
+	  Say yes here to build support for ST Microelectronics STMPE
+	  built-in ADC block (stmpe811).
+
 config STX104
 	tristate "Apex Embedded Systems STX104 driver"
 	depends on PC104 && X86
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 07df37f621bd..6d4e3149ac15 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
 obj-$(CONFIG_STM32_ADC) += stm32-adc.o
 obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
 obj-$(CONFIG_STM32_DFSDM_ADC) += stm32-dfsdm-adc.o
+obj-$(CONFIG_STMPE_ADC) += stmpe-adc.o
 obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
 obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
 obj-$(CONFIG_TI_ADC084S021) += ti-adc084s021.o
diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
new file mode 100644
index 000000000000..37f4b74a5d32
--- /dev/null
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  STMicroelectronics STMPE811 IIO ADC Driver
+ *
+ *  4 channel, 10/12-bit ADC
+ *
+ *  Copyright (C) 2013-2018 Toradex AG <stefan.agner@toradex.com>
+ */
+
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/stmpe.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+
+#define STMPE_REG_INT_STA		0x0B
+#define STMPE_REG_ADC_INT_EN		0x0E
+#define STMPE_REG_ADC_INT_STA		0x0F
+
+#define STMPE_REG_ADC_CTRL1		0x20
+#define STMPE_REG_ADC_CTRL2		0x21
+#define STMPE_REG_ADC_CAPT		0x22
+#define STMPE_REG_ADC_DATA_CH(channel)	(0x30 + 2 * (channel))
+
+#define STMPE_REG_TEMP_CTRL		0x60
+#define STMPE_TEMP_CTRL_ENABLE		BIT(0)
+#define STMPE_TEMP_CTRL_ACQ		BIT(1)
+#define STMPE_TEMP_CTRL_THRES_EN	BIT(3)
+#define STMPE_START_ONE_TEMP_CONV	(STMPE_TEMP_CTRL_ENABLE | \
+					STMPE_TEMP_CTRL_ACQ | \
+					STMPE_TEMP_CTRL_THRES_EN)
+#define STMPE_REG_TEMP_DATA		0x61
+#define STMPE_REG_TEMP_TH		0x63
+#define STMPE_ADC_LAST_NR		7
+#define STMPE_TEMP_CHANNEL		(STMPE_ADC_LAST_NR + 1)
+
+#define STMPE_ADC_CH(channel)		((1 << (channel)) & 0xff)
+
+#define STMPE_ADC_TIMEOUT		msecs_to_jiffies(1000)
+
+struct stmpe_adc {
+	struct stmpe *stmpe;
+	struct clk *clk;
+	struct device *dev;
+	struct mutex lock;
+
+	/* We are allocating plus one for the temperature channel */
+	struct iio_chan_spec stmpe_adc_iio_channels[STMPE_ADC_LAST_NR + 2];
+
+	struct completion completion;
+
+	u8 channel;
+	u32 value;
+};
+
+static int stmpe_read_voltage(struct stmpe_adc *info,
+		struct iio_chan_spec const *chan, int *val)
+{
+	long ret;
+
+	mutex_lock(&info->lock);
+
+	info->channel = (u8)chan->channel;
+
+	if (info->channel > STMPE_ADC_LAST_NR) {
+		mutex_unlock(&info->lock);
+		return -EINVAL;
+	}
+
+	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_EN,
+			STMPE_ADC_CH(info->channel));
+
+	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_CAPT,
+			STMPE_ADC_CH(info->channel));
+
+	*val = info->value;
+
+	ret = wait_for_completion_interruptible_timeout
+		(&info->completion, STMPE_ADC_TIMEOUT);
+
+	if (ret <= 0) {
+		mutex_unlock(&info->lock);
+		if (ret == 0)
+			return -ETIMEDOUT;
+		else
+			return ret;
+	}
+
+	*val = info->value;
+
+	mutex_unlock(&info->lock);
+
+	return 0;
+}
+
+static int stmpe_read_temp(struct stmpe_adc *info,
+		struct iio_chan_spec const *chan, int *val)
+{
+	long ret;
+
+	mutex_lock(&info->lock);
+
+	info->channel = (u8)chan->channel;
+
+	if (info->channel != STMPE_TEMP_CHANNEL) {
+		mutex_unlock(&info->lock);
+		return -EINVAL;
+	}
+
+	stmpe_reg_write(info->stmpe, STMPE_REG_TEMP_CTRL,
+			STMPE_START_ONE_TEMP_CONV);
+
+	ret = wait_for_completion_interruptible_timeout
+		(&info->completion, STMPE_ADC_TIMEOUT);
+
+	if (ret <= 0) {
+		mutex_unlock(&info->lock);
+		if (ret == 0)
+			return -ETIMEDOUT;
+		else
+			return ret;
+	}
+
+	/*
+	 * absolute temp = +V3.3 * value /7.51 [K]
+	 * scale to [milli °C]
+	 */
+	*val = ((449960l * info->value) / 1024l) - 273150;
+
+	mutex_unlock(&info->lock);
+
+	return 0;
+}
+
+static int stmpe_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan,
+			  int *val,
+			  int *val2,
+			  long mask)
+{
+	struct stmpe_adc *info = iio_priv(indio_dev);
+	long ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
+
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			ret = stmpe_read_voltage(info, chan, val);
+			break;
+
+		case IIO_TEMP:
+			ret = stmpe_read_temp(info, chan, val);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = 3300;
+		*val2 = info->stmpe->mod_12b ? 12 : 10;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static irqreturn_t stmpe_adc_isr(int irq, void *dev_id)
+{
+	struct stmpe_adc *info = (struct stmpe_adc *)dev_id;
+	u16 data;
+
+	if (info->channel > STMPE_TEMP_CHANNEL)
+		return IRQ_NONE;
+
+	if (info->channel <= STMPE_ADC_LAST_NR) {
+		int int_sta;
+
+		int_sta = stmpe_reg_read(info->stmpe, STMPE_REG_ADC_INT_STA);
+
+		/* Is the interrupt relevant */
+		if (!(int_sta & STMPE_ADC_CH(info->channel)))
+			return IRQ_NONE;
+
+		/* Read value */
+		stmpe_block_read(info->stmpe,
+			STMPE_REG_ADC_DATA_CH(info->channel), 2, (u8 *) &data);
+
+		stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_STA, int_sta);
+	} else if (info->channel == STMPE_TEMP_CHANNEL) {
+		/* Read value */
+		stmpe_block_read(info->stmpe, STMPE_REG_TEMP_DATA, 2,
+				(u8 *) &data);
+	}
+
+	info->value = (u32) be16_to_cpu(data);
+	complete(&info->completion);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_info stmpe_adc_iio_info = {
+	.read_raw = &stmpe_read_raw,
+};
+
+static void stmpe_adc_voltage_chan(struct iio_chan_spec *ics, int chan)
+{
+	ics->type = IIO_VOLTAGE;
+	ics->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	ics->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
+	ics->indexed = 1;
+	ics->channel = chan;
+}
+
+static void stmpe_adc_temp_chan(struct iio_chan_spec *ics, int chan)
+{
+	ics->type = IIO_TEMP;
+	ics->info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED);
+	ics->indexed = 1;
+	ics->channel = chan;
+}
+
+static int stmpe_adc_init_hw(struct stmpe_adc *adc)
+{
+	int ret;
+	struct stmpe *stmpe = adc->stmpe;
+
+	ret = stmpe_enable(stmpe, STMPE_BLOCK_ADC);
+	if (ret) {
+		dev_err(stmpe->dev, "Could not enable clock for ADC\n");
+		return ret;
+	}
+
+	ret = stmpe811_adc_common_init(stmpe);
+	if (ret) {
+		stmpe_disable(stmpe, STMPE_BLOCK_ADC);
+		return ret;
+	}
+
+	/* use temp irq for each conversion completion */
+	stmpe_reg_write(stmpe, STMPE_REG_TEMP_TH, 0);
+	stmpe_reg_write(stmpe, STMPE_REG_TEMP_TH + 1, 0);
+
+	return 0;
+}
+
+static int stmpe_adc_probe(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev;
+	struct stmpe_adc *info;
+	struct device_node *np;
+	u32 norequest_mask = 0;
+	int irq_temp, irq_adc;
+	int num_chan = 0;
+	int i = 0;
+	int ret;
+
+	irq_adc = platform_get_irq_byname(pdev, "STMPE_ADC");
+	if (irq_adc < 0)
+		return irq_adc;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct stmpe_adc));
+	if (!indio_dev) {
+		dev_err(&pdev->dev, "failed allocating iio device\n");
+		return -ENOMEM;
+	}
+
+	info = iio_priv(indio_dev);
+	mutex_init(&info->lock);
+
+	init_completion(&info->completion);
+	ret = devm_request_threaded_irq(&pdev->dev, irq_adc, NULL,
+					stmpe_adc_isr, IRQF_ONESHOT,
+					"stmpe-adc", info);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n",
+				irq_adc);
+		return ret;
+	}
+
+	irq_temp = platform_get_irq_byname(pdev, "STMPE_TEMP_SENS");
+	if (irq_temp >= 0) {
+		ret = devm_request_threaded_irq(&pdev->dev, irq_temp, NULL,
+						stmpe_adc_isr, IRQF_ONESHOT,
+						"stmpe-adc", info);
+		if (ret < 0)
+			dev_warn(&pdev->dev, "failed requesting irq for"
+				 " temp sensor, irq = %d\n", irq_temp);
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	indio_dev->name		= dev_name(&pdev->dev);
+	indio_dev->dev.parent	= &pdev->dev;
+	indio_dev->info		= &stmpe_adc_iio_info;
+	indio_dev->modes	= INDIO_DIRECT_MODE;
+
+	info->stmpe = dev_get_drvdata(pdev->dev.parent);
+
+	np = pdev->dev.of_node;
+
+	if (!np)
+		dev_err(&pdev->dev, "no device tree node found\n");
+
+	of_property_read_u32(np, "st,norequest-mask", &norequest_mask);
+
+	for_each_clear_bit(i, (unsigned long *) &norequest_mask,
+			   (STMPE_ADC_LAST_NR + 1)) {
+		stmpe_adc_voltage_chan(&info->stmpe_adc_iio_channels[num_chan], i);
+		num_chan++;
+	}
+	stmpe_adc_temp_chan(&info->stmpe_adc_iio_channels[num_chan], i);
+	num_chan++;
+	indio_dev->channels = info->stmpe_adc_iio_channels;
+	indio_dev->num_channels = num_chan;
+
+	ret = stmpe_adc_init_hw(info);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static int __maybe_unused stmpe_adc_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct stmpe_adc *info = iio_priv(indio_dev);
+
+	stmpe_adc_init_hw(info);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(stmpe_adc_pm_ops, NULL, stmpe_adc_resume);
+
+static struct platform_driver stmpe_adc_driver = {
+	.probe		= stmpe_adc_probe,
+	.driver		= {
+		.name	= "stmpe-adc",
+		.pm	= &stmpe_adc_pm_ops,
+	},
+};
+
+module_platform_driver(stmpe_adc_driver);
+
+MODULE_AUTHOR("Stefan Agner <stefan.agner@toradex.com>");
+MODULE_DESCRIPTION("STMPEXXX ADC driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:stmpe-adc");
-- 
2.20.1

