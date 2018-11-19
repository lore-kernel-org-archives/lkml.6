Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C3FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01D220831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="B3zybsJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01D220831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbeKTBMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:12:44 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:59236 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbeKTBMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:12:43 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id B540B5C0929;
        Mon, 19 Nov 2018 15:48:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1542638928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obDBPOQz+tpOoqsZOrxupjXxY1UsSOFcUG8gTYBagUY=;
        b=B3zybsJNylUCE2TJD+MtQYDXqKMps/HzqvLf4eQq34nqLjI5ax/whVL/eAusLVErCCUFGs
        PIgLl2AL+T8garKBcjJjzv4z0QdEWDXCyT6FoZv6HmN6Kw1Qi57HywEQn1aVQsOUgbR/85
        EWnMyZikbslkB9YUbG835yAnhFoWclI=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Mon, 19 Nov 2018 15:48:47 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     jic23@kernel.org, marcel.ziswiler@toradex.com,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Freeman Liu <freeman.liu@spreadtrum.com>,
        linux-input@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/4] iio: adc: add STMPE ADC driver using IIO framework
In-Reply-To: <20181119102528.2830-2-dev@pschenker.ch>
References: <20181119102528.2830-1-dev@pschenker.ch>
 <20181119102528.2830-2-dev@pschenker.ch>
Message-ID: <f55e8b6c618b1e292cf2a17862bc8a2a@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.2018 11:25, Philippe Schenker wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> This adds an ADC driver for the STMPE device using the industrial
> input/output interface. The driver supports raw reading of values.
> The driver depends on the MFD STMPE driver. If the touchscreen
> block is enabled too, only four of the 8 ADC channels are available.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v2:
>  - Code formatting
>  - Move code to setup ADC to MFD device, as it is used by both drivers
>    adc and touchscreen
>  - Removed unused includes
>  - Defined the macro STMPE_START_ONE_TEMP_CONV with other macros.
>  - Added new macro that defines the channel of the temperature sensor.
>    Took new name for STMPE_MAX_ADC->STMPE_ADC_LAST_NR and used it throughout
>    the code for better readability.
>  - Added mutex_unlock where missing.
> 
>  drivers/iio/adc/Kconfig              |   7 +
>  drivers/iio/adc/Makefile             |   1 +
>  drivers/iio/adc/stmpe-adc.c          | 340 +++++++++++++++++++++++++++
>  drivers/input/touchscreen/stmpe-ts.c |  43 +---
>  drivers/mfd/Kconfig                  |   3 +-
>  drivers/mfd/stmpe.c                  |  84 +++++++
>  include/linux/mfd/stmpe.h            |   6 +
>  7 files changed, 445 insertions(+), 39 deletions(-)
>  create mode 100644 drivers/iio/adc/stmpe-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a52fea8749a9..5d4c061d8296 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -734,6 +734,13 @@ config STM32_DFSDM_ADC
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called stm32-dfsdm-adc.
>  
> +config STMPE_ADC
> +	tristate "STMicroelectronics STMPE ADC driver"
> +	depends on (OF || COMPILE_TEST || MFD_STMPE)

I know I previously said you should add COMPILE_TEST.

However, I changed my mind. Why? Even when using COMPILE_TEST, we should
still make sure that Kconfig dependencies are such that all required
symbols for compilation are enabled! After all, COMPILE_TEST is used to
check whether the driver compiles...

Typically COMPILE_TEST is used when we restrict a config symbol to a
certain architecture/SoC (e.g. since only that SoC has the particular
IP). However, in those cases the driver still compiles, even for a
different architecture.

However, in this case compile fails if MFD_STMPE or OF is not enabled.

Hence we have no compile time optional dependency. So just use:

	depends on OF && MFD_STMPE


> +	help
> +	  Say yes here to build support for ST Microelectronics STMPE
> +	  built-in ADC block (stmpe811).
> +
>  config STX104
>  	tristate "Apex Embedded Systems STX104 driver"
>  	depends on PC104 && X86
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index a6e6a0b659e2..cba889c30bf9 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
>  obj-$(CONFIG_STM32_ADC) += stm32-adc.o
>  obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
>  obj-$(CONFIG_STM32_DFSDM_ADC) += stm32-dfsdm-adc.o
> +obj-$(CONFIG_STMPE_ADC) += stmpe-adc.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
>  obj-$(CONFIG_TI_ADC084S021) += ti-adc084s021.o
> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> new file mode 100644
> index 000000000000..151f1c8f827e
> --- /dev/null
> +++ b/drivers/iio/adc/stmpe-adc.c
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  STMicroelectronics STMPE811 IIO ADC Driver
> + *
> + *  4 channel, 10/12-bit ADC
> + *
> + *  Copyright (C) 2013-2018 Toradex AG <stefan.agner@toradex.com>
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/stmpe.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
> +#define STMPE_REG_INT_STA		0x0B
> +#define STMPE_REG_ADC_INT_EN		0x0E
> +#define STMPE_REG_ADC_INT_STA		0x0F
> +
> +#define STMPE_REG_ADC_CTRL1		0x20
> +#define STMPE_REG_ADC_CTRL2		0x21
> +#define STMPE_REG_ADC_CAPT		0x22
> +#define STMPE_REG_ADC_DATA_CH(channel)	(0x30 + 2 * (channel))
> +
> +#define STMPE_REG_TEMP_CTRL		0x60
> +#define STMPE_TEMP_CTRL_ENABLE		BIT(0)
> +#define STMPE_TEMP_CTRL_ACQ		BIT(1)
> +#define STMPE_TEMP_CTRL_THRES_EN	BIT(3)
> +#define STMPE_START_ONE_TEMP_CONV	(STMPE_TEMP_CTRL_ENABLE | \
> +					STMPE_TEMP_CTRL_ACQ | \
> +					STMPE_TEMP_CTRL_THRES_EN)
> +#define STMPE_REG_TEMP_DATA		0x61
> +#define STMPE_REG_TEMP_TH		0x63
> +#define STMPE_ADC_LAST_NR		7
> +#define STMPE_TEMP_CHANNEL		(STMPE_ADC_LAST_NR + 1)
> +
> +#define STMPE_ADC_CH(channel)		((1 << (channel)) & 0xff)
> +
> +#define STMPE_ADC_TIMEOUT		msecs_to_jiffies(1000)
> +
> +struct stmpe_adc {
> +	struct stmpe *stmpe;
> +	struct clk *clk;
> +	struct device *dev;
> +
> +	/* We are allocating plus one for the temperature channel */
> +	struct iio_chan_spec stmpe_adc_iio_channels[STMPE_ADC_LAST_NR + 2];
> +
> +	struct completion completion;
> +
> +	u8 channel;
> +	u32 value;
> +	u32 norequest_mask;
> +};
> +
> +static int stmpe_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int *val,
> +			  int *val2,
> +			  long mask)
> +{
> +	struct stmpe_adc *info = iio_priv(indio_dev);
> +	long ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +	case IIO_CHAN_INFO_PROCESSED:
> +
> +		mutex_lock(&indio_dev->mlock);
> +
> +		info->channel = (u8)chan->channel;
> +
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (info->channel > STMPE_ADC_LAST_NR) {
> +				mutex_unlock(&indio_dev->mlock);
> +				return -EINVAL;
> +			}
> +
> +			stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_EN,
> +					STMPE_ADC_CH(info->channel));
> +
> +			stmpe_reg_write(info->stmpe, STMPE_REG_ADC_CAPT,
> +					STMPE_ADC_CH(info->channel));
> +
> +			*val = info->value;
> +			break;
> +
> +		case IIO_TEMP:
> +			if (info->channel != STMPE_TEMP_CHANNEL) {
> +				mutex_unlock(&indio_dev->mlock);
> +				return -EINVAL;
> +			}
> +
> +			stmpe_reg_write(info->stmpe, STMPE_REG_TEMP_CTRL,
> +					STMPE_START_ONE_TEMP_CONV);
> +			break;
> +		default:
> +			mutex_unlock(&indio_dev->mlock);
> +			return -EINVAL;
> +		}
> +
> +		ret = wait_for_completion_interruptible_timeout
> +			(&info->completion, STMPE_ADC_TIMEOUT);
> +
> +		if (ret <= 0) {
> +			mutex_unlock(&indio_dev->mlock);
> +			if (ret == 0)
> +				return -ETIMEDOUT;
> +			else
> +				return ret;
> +		}
> +
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = info->value;
> +			break;
> +
> +		case IIO_TEMP:
> +			/*
> +			 * absolute temp = +V3.3 * value /7.51 [K]
> +			 * scale to [milli °C]
> +			 */
> +			*val = ((449960l * info->value) / 1024l) - 273150;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		mutex_unlock(&indio_dev->mlock);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 3300;
> +		*val2 = info->stmpe->mod_12b ? 12 : 10;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static irqreturn_t stmpe_adc_isr(int irq, void *dev_id)
> +{
> +	struct stmpe_adc *info = (struct stmpe_adc *)dev_id;
> +	u8 data[2];
> +
> +	if (info->channel > STMPE_TEMP_CHANNEL)
> +		return IRQ_NONE;
> +
> +	if (info->channel <= STMPE_ADC_LAST_NR) {
> +		int int_sta;
> +
> +		int_sta = stmpe_reg_read(info->stmpe, STMPE_REG_ADC_INT_STA);
> +
> +		/* Is the interrupt relevant */
> +		if (!(int_sta & STMPE_ADC_CH(info->channel)))
> +			return IRQ_NONE;
> +
> +		/* Read value */
> +		stmpe_block_read(info->stmpe,
> +			STMPE_REG_ADC_DATA_CH(info->channel), 2, data);
> +
> +		stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_STA, int_sta);
> +	} else if (info->channel == STMPE_TEMP_CHANNEL) {
> +		/* Read value */
> +		stmpe_block_read(info->stmpe, STMPE_REG_TEMP_DATA, 2, data);
> +	}
> +
> +	info->value = ((u32)data[0] << 8) + data[1];
> +	complete(&info->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info stmpe_adc_iio_info = {
> +	.read_raw = &stmpe_read_raw,
> +};
> +
> +static void stmpe_adc_voltage_chan(struct iio_chan_spec *ics, int chan)
> +{
> +	ics->type = IIO_VOLTAGE;
> +	ics->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +	ics->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> +	ics->indexed = 1;
> +	ics->channel = chan;
> +}
> +
> +static void stmpe_adc_temp_chan(struct iio_chan_spec *ics, int chan)
> +{
> +	ics->type = IIO_TEMP;
> +	ics->info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED);
> +	ics->indexed = 1;
> +	ics->channel = chan;
> +}
> +
> +static int stmpe_adc_init_hw(struct stmpe_adc *adc)
> +{
> +	struct stmpe *stmpe = adc->stmpe;
> +
> +	/* use temp irq for each conversion completion */
> +	stmpe_reg_write(stmpe, STMPE_REG_TEMP_TH, 0);
> +	stmpe_reg_write(stmpe, STMPE_REG_TEMP_TH + 1, 0);
> +
> +	return 0;
> +}
> +
> +static void stmpe_adc_get_platform_info(struct platform_device *pdev,
> +					struct stmpe_adc *adc)
> +{
> +	struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
> +	struct device_node *np = pdev->dev.of_node;
> +	u32 val;
> +
> +	adc->stmpe = stmpe;
> +
> +	if (!np) {
> +		dev_err(&pdev->dev, "no device tree node found\n");
> +		return;
> +	}
> +
> +	if (!of_property_read_u32(np, "st,norequest-mask", &val))
> +		adc->norequest_mask = val;
> +}
> +
> +static int stmpe_adc_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = NULL;
> +	struct stmpe_adc *info = NULL;
> +	int irq_temp, irq_adc;
> +	int num_chan = 0;
> +	int i = 0;
> +	int ret;
> +
> +	irq_adc = platform_get_irq_byname(pdev, "STMPE_ADC");
> +	if (irq_adc < 0)
> +		return irq_adc;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct stmpe_adc));
> +	if (!indio_dev) {
> +		dev_err(&pdev->dev, "failed allocating iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	info = iio_priv(indio_dev);
> +
> +	init_completion(&info->completion);
> +	ret = devm_request_threaded_irq(&pdev->dev, irq_adc, NULL,
> +					stmpe_adc_isr, IRQF_ONESHOT,
> +					"stmpe-adc", info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n",
> +				irq_adc);
> +		return ret;
> +	}
> +
> +	irq_temp = platform_get_irq_byname(pdev, "STMPE_TEMP_SENS");
> +	if (irq_temp >= 0) {
> +		ret = devm_request_threaded_irq(&pdev->dev, irq_temp, NULL,
> +						stmpe_adc_isr, IRQF_ONESHOT,
> +						"stmpe-adc", info);
> +		if (ret < 0)
> +			dev_warn(&pdev->dev, "failed requesting irq for"
> +				 " temp sensor, irq = %d\n", irq_temp);
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	indio_dev->name		= dev_name(&pdev->dev);
> +	indio_dev->dev.parent	= &pdev->dev;
> +	indio_dev->info		= &stmpe_adc_iio_info;
> +	indio_dev->modes	= INDIO_DIRECT_MODE;
> +
> +	stmpe_adc_get_platform_info(pdev, info);

Since there are no plans to support platform data I think we can get rid
of this function and just move the code here.

Then you can also get rid of norequest_mask in struct stmpe_adc and make
it a local variable here.

> +
> +	for_each_clear_bit(i, (unsigned long *) &info->norequest_mask,
> +			   (STMPE_ADC_LAST_NR + 1)) {
> +		stmpe_adc_voltage_chan(&info->stmpe_adc_iio_channels[num_chan], i);
> +		num_chan++;
> +	}
> +	stmpe_adc_temp_chan(&info->stmpe_adc_iio_channels[num_chan], i);
> +	num_chan++;
> +	indio_dev->channels = info->stmpe_adc_iio_channels;
> +	indio_dev->num_channels = num_chan;
> +
> +	ret = stmpe_adc_init_hw(info);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

You can simplify the last 4 lines to just "return ret";

> +}
> +
> +static int stmpe_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct stmpe_adc *info = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	stmpe_disable(info->stmpe, STMPE_BLOCK_ADC);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused stmpe_adc_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct stmpe_adc *info = iio_priv(indio_dev);
> +
> +	stmpe_adc_init_hw(info);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(stmpe_adc_pm_ops, NULL, stmpe_adc_resume);
> +
> +static struct platform_driver stmpe_adc_driver = {
> +	.probe		= stmpe_adc_probe,
> +	.remove		= stmpe_adc_remove,
> +	.driver		= {
> +		.name	= "stmpe-adc",
> +		.pm	= &stmpe_adc_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(stmpe_adc_driver);
> +
> +MODULE_AUTHOR("Stefan Agner <stefan.agner@toradex.com>");
> +MODULE_DESCRIPTION("STMPEXXX ADC driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:stmpe-adc");
> diff --git a/drivers/input/touchscreen/stmpe-ts.c
> b/drivers/input/touchscreen/stmpe-ts.c
> index c5d9006588a2..31d157032f4a 100644
> --- a/drivers/input/touchscreen/stmpe-ts.c
> +++ b/drivers/input/touchscreen/stmpe-ts.c
> @@ -30,8 +30,6 @@
>   * with touchscreen controller
>   */
>  #define STMPE_REG_INT_STA		0x0B
> -#define STMPE_REG_ADC_CTRL1		0x20
> -#define STMPE_REG_ADC_CTRL2		0x21
>  #define STMPE_REG_TSC_CTRL		0x40
>  #define STMPE_REG_TSC_CFG		0x41
>  #define STMPE_REG_FIFO_TH		0x4A
> @@ -88,10 +86,6 @@ struct stmpe_touch {
>  	struct input_dev *idev;
>  	struct delayed_work work;
>  	struct device *dev;
> -	u8 sample_time;
> -	u8 mod_12b;
> -	u8 ref_sel;
> -	u8 adc_freq;
>  	u8 ave_ctrl;
>  	u8 touch_det_delay;
>  	u8 settling;
> @@ -176,7 +170,7 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
>  	input_report_key(ts->idev, BTN_TOUCH, 1);
>  	input_sync(ts->idev);
>  
> -       /* flush the FIFO after we have read out our values. */
> +	/* flush the FIFO after we have read out our values. */
>  	__stmpe_reset_fifo(ts->stmpe);
>  
>  	/* reenable the tsc */
> @@ -192,7 +186,7 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
>  static int stmpe_init_hw(struct stmpe_touch *ts)
>  {
>  	int ret;
> -	u8 adc_ctrl1, adc_ctrl1_mask, tsc_cfg, tsc_cfg_mask;
> +	u8 tsc_cfg, tsc_cfg_mask;
>  	struct stmpe *stmpe = ts->stmpe;
>  	struct device *dev = ts->dev;
>  
> @@ -202,25 +196,6 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
>  		return ret;
>  	}
>  
> -	adc_ctrl1 = STMPE_SAMPLE_TIME(ts->sample_time) |
> -		    STMPE_MOD_12B(ts->mod_12b) | STMPE_REF_SEL(ts->ref_sel);
> -	adc_ctrl1_mask = STMPE_SAMPLE_TIME(0xff) | STMPE_MOD_12B(0xff) |
> -			 STMPE_REF_SEL(0xff);
> -
> -	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL1,
> -			adc_ctrl1_mask, adc_ctrl1);
> -	if (ret) {
> -		dev_err(dev, "Could not setup ADC\n");
> -		return ret;
> -	}
> -
> -	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL2,
> -			STMPE_ADC_FREQ(0xff), STMPE_ADC_FREQ(ts->adc_freq));
> -	if (ret) {
> -		dev_err(dev, "Could not setup ADC\n");
> -		return ret;
> -	}
> -
>  	tsc_cfg = STMPE_AVE_CTRL(ts->ave_ctrl) |
>  		  STMPE_DET_DELAY(ts->touch_det_delay) |
>  		  STMPE_SETTLING(ts->settling);
> @@ -234,14 +209,14 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
>  	}
>  
>  	ret = stmpe_set_bits(stmpe, STMPE_REG_TSC_FRACTION_Z,
> -			STMPE_FRACTION_Z(0xff), STMPE_FRACTION_Z(ts->fraction_z));
> +		STMPE_FRACTION_Z(0xff), STMPE_FRACTION_Z(ts->fraction_z));

This...

>  	if (ret) {
>  		dev_err(dev, "Could not config touch\n");
>  		return ret;
>  	}
>  
>  	ret = stmpe_set_bits(stmpe, STMPE_REG_TSC_I_DRIVE,
> -			STMPE_I_DRIVE(0xff), STMPE_I_DRIVE(ts->i_drive));
> +		STMPE_I_DRIVE(0xff), STMPE_I_DRIVE(ts->i_drive));

...and this...

>  	if (ret) {
>  		dev_err(dev, "Could not config touch\n");
>  		return ret;
> @@ -255,7 +230,7 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
>  	}
>  
>  	ret = stmpe_set_bits(stmpe, STMPE_REG_TSC_CTRL,
> -			STMPE_OP_MODE(0xff), STMPE_OP_MODE(OP_MOD_XYZ));
> +		STMPE_OP_MODE(0xff), STMPE_OP_MODE(OP_MOD_XYZ));

... and this change are rather unrelated indent fixes, please drop them.

>  	if (ret) {
>  		dev_err(dev, "Could not set mode\n");
>  		return ret;
> @@ -294,14 +269,6 @@ static void stmpe_ts_get_platform_info(struct
> platform_device *pdev,
>  	u32 val;
>  
>  	if (np) {
> -		if (!of_property_read_u32(np, "st,sample-time", &val))
> -			ts->sample_time = val;
> -		if (!of_property_read_u32(np, "st,mod-12b", &val))
> -			ts->mod_12b = val;
> -		if (!of_property_read_u32(np, "st,ref-sel", &val))
> -			ts->ref_sel = val;
> -		if (!of_property_read_u32(np, "st,adc-freq", &val))
> -			ts->adc_freq = val;

Hm, so this removes backward compatibility. I don't think this is
acceptable.

You still need to read the values from the stmpe_ts subnode and use them
the new binding is not there.

--
Stefan

>  		if (!of_property_read_u32(np, "st,ave-ctrl", &val))
>  			ts->ave_ctrl = val;
>  		if (!of_property_read_u32(np, "st,touch-det-delay", &val))
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8c5dfdce4326..bba159e8eaa4 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1204,7 +1204,7 @@ config MFD_STMPE
>  
>  	  Currently supported devices are:
>  
> -		STMPE811: GPIO, Touchscreen
> +		STMPE811: GPIO, Touchscreen, ADC
>  		STMPE1601: GPIO, Keypad
>  		STMPE1801: GPIO, Keypad
>  		STMPE2401: GPIO, Keypad
> @@ -1217,6 +1217,7 @@ config MFD_STMPE
>  		GPIO: stmpe-gpio
>  		Keypad: stmpe-keypad
>  		Touchscreen: stmpe-ts
> +		ADC: stmpe-adc
>  
>  menu "STMicroelectronics STMPE Interface Drivers"
>  depends on MFD_STMPE
> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> index 566caca4efd8..eab3d33e4093 100644
> --- a/drivers/mfd/stmpe.c
> +++ b/drivers/mfd/stmpe.c
> @@ -23,6 +23,9 @@
>  #include <linux/regulator/consumer.h>
>  #include "stmpe.h"
>  
> +#define STMPE_REG_ADC_CTRL1	0x20
> +#define STMPE_REG_ADC_CTRL2	0x21
> +
>  /**
>   * struct stmpe_platform_data - STMPE platform data
>   * @id: device id to distinguish between multiple STMPEs on the same board
> @@ -463,6 +466,28 @@ static const struct mfd_cell stmpe_ts_cell = {
>  	.num_resources	= ARRAY_SIZE(stmpe_ts_resources),
>  };
>  
> +/*
> + * ADC (STMPE811)
> + */
> +
> +static struct resource stmpe_adc_resources[] = {
> +	{
> +		.name	= "STMPE_TEMP_SENS",
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +	{
> +		.name	= "STMPE_ADC",
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static const struct mfd_cell stmpe_adc_cell = {
> +	.name		= "stmpe-adc",
> +	.of_compatible	= "st,stmpe-adc",
> +	.resources	= stmpe_adc_resources,
> +	.num_resources	= ARRAY_SIZE(stmpe_adc_resources),
> +};
> +
>  /*
>   * STMPE811 or STMPE610
>   */
> @@ -497,6 +522,11 @@ static struct stmpe_variant_block stmpe811_blocks[] = {
>  		.irq	= STMPE811_IRQ_TOUCH_DET,
>  		.block	= STMPE_BLOCK_TOUCHSCREEN,
>  	},
> +	{
> +		.cell	= &stmpe_adc_cell,
> +		.irq	= STMPE811_IRQ_TEMP_SENS,
> +		.block	= STMPE_BLOCK_ADC,
> +	},
>  };
>  
>  static int stmpe811_enable(struct stmpe *stmpe, unsigned int blocks,
> @@ -517,6 +547,44 @@ static int stmpe811_enable(struct stmpe *stmpe,
> unsigned int blocks,
>  				enable ? 0 : mask);
>  }
>  
> +static int stmpe811_init_adc(struct stmpe *stmpe)
> +{
> +	int ret;
> +	u8 adc_ctrl1, adc_ctrl1_mask;
> +
> +	ret = stmpe_enable(stmpe, STMPE_BLOCK_ADC);
> +	if (ret) {
> +		dev_err(stmpe->dev, "Could not enable clock for ADC\n");
> +		goto err_adc;
> +	}
> +
> +	adc_ctrl1 = STMPE_SAMPLE_TIME(stmpe->sample_time) |
> +		    STMPE_MOD_12B(stmpe->mod_12b) |
> +		    STMPE_REF_SEL(stmpe->ref_sel);
> +	adc_ctrl1_mask = STMPE_SAMPLE_TIME(0xff) | STMPE_MOD_12B(0xff) |
> +			 STMPE_REF_SEL(0xff);
> +
> +	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL1,
> +			adc_ctrl1_mask, adc_ctrl1);
> +	if (ret) {
> +		dev_err(stmpe->dev, "Could not setup ADC\n");
> +		goto err_adc;
> +	}
> +
> +	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL2,
> +			STMPE_ADC_FREQ(0xff), STMPE_ADC_FREQ(stmpe->adc_freq));
> +	if (ret) {
> +		dev_err(stmpe->dev, "Could not setup ADC\n");
> +		goto err_adc;
> +	}
> +
> +	return 0;
> +err_adc:
> +	stmpe_disable(stmpe, STMPE_BLOCK_ADC);
> +
> +	return ret;
> +}
> +
>  static int stmpe811_get_altfunc(struct stmpe *stmpe, enum stmpe_block block)
>  {
>  	/* 0 for touchscreen, 1 for GPIO */
> @@ -1235,6 +1303,12 @@ static int stmpe_chip_init(struct stmpe *stmpe)
>  			return ret;
>  	}
>  
> +	if (id == STMPE610 || id == STMPE811) {
> +		ret = stmpe811_init_adc(stmpe);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return stmpe_reg_write(stmpe, stmpe->regs[STMPE_IDX_ICR_LSB], icr);
>  }
>  
> @@ -1325,6 +1399,7 @@ int stmpe_probe(struct stmpe_client_info *ci,
> enum stmpe_partnum partnum)
>  	struct device_node *np = ci->dev->of_node;
>  	struct stmpe *stmpe;
>  	int ret;
> +	u32 val;
>  
>  	pdata = devm_kzalloc(ci->dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
> @@ -1342,6 +1417,15 @@ int stmpe_probe(struct stmpe_client_info *ci,
> enum stmpe_partnum partnum)
>  	mutex_init(&stmpe->irq_lock);
>  	mutex_init(&stmpe->lock);
>  
> +	if (!of_property_read_u32(np, "st,sample-time", &val))
> +		stmpe->sample_time = val;
> +	if (!of_property_read_u32(np, "st,mod-12b", &val))
> +		stmpe->mod_12b = val;
> +	if (!of_property_read_u32(np, "st,ref-sel", &val))
> +		stmpe->ref_sel = val;
> +	if (!of_property_read_u32(np, "st,adc-freq", &val))
> +		stmpe->adc_freq = val;
> +
>  	stmpe->dev = ci->dev;
>  	stmpe->client = ci->client;
>  	stmpe->pdata = pdata;
> diff --git a/include/linux/mfd/stmpe.h b/include/linux/mfd/stmpe.h
> index c0353f6431f9..4e3f6ff60408 100644
> --- a/include/linux/mfd/stmpe.h
> +++ b/include/linux/mfd/stmpe.h
> @@ -134,6 +134,12 @@ struct stmpe {
>  	u8 ier[2];
>  	u8 oldier[2];
>  	struct stmpe_platform_data *pdata;
> +
> +	/* For devices that use an ADC */
> +	u8 sample_time;
> +	u8 mod_12b;
> +	u8 ref_sel;
> +	u8 adc_freq;
>  };
>  
>  extern int stmpe_reg_write(struct stmpe *stmpe, u8 reg, u8 data);
