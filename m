Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7559BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AC720870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547319277;
	bh=F8FWB1v3VWQtQvSr/IwZF0A9GDeqlXBiB0sjzja1HlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pT576lPZ7mOnxyrF6M4qPBn/b3sBfa7Pry/Etmj2wsIc/9dFdsYqQTHC6wr87/K7t
	 /4sEpFRf9fxNqRUEFK9M/vwwDYipKe2yrBdzWWNLfF2FnAxQX6cjf/Oq4tuOxFB0sn
	 KVmBzA5lbuCZy4iLF9Maeua9xJdAH6KVlyNmRSf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfALSyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:54:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfALSyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:54:35 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AC42206B7;
        Sat, 12 Jan 2019 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547319273;
        bh=F8FWB1v3VWQtQvSr/IwZF0A9GDeqlXBiB0sjzja1HlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HtW/H9hhiKmdTy59LRcrsbHYS76IbF4u6N1/yHAo1NPlTcPpoWGYijV8y/QgkxsWb
         F6sF4V+nHKDsHLuEy19B2j1sVEVLCwcF12dYUDgQJDIwzSrKmmCD9QcM+5RcoCFD7j
         yT7oHmPyJ9jlBB7IlKjq3cOtwLumWhKhOaD3saeg=
Date:   Sat, 12 Jan 2019 18:54:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, yuenn@google.com,
        venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au, linux-iio@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add NPCM ADC driver
Message-ID: <20190112185427.13529293@archlinux>
In-Reply-To: <20190109164343.164205-3-tmaimon77@gmail.com>
References: <20190109164343.164205-1-tmaimon77@gmail.com>
        <20190109164343.164205-3-tmaimon77@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jan 2019 18:43:43 +0200
Tomer Maimon <tmaimon77@gmail.com> wrote:

> Add Nuvoton NPCM BMC Analog-to-Digital Converter(ADC) driver.
> 
> The NPCM ADC is a 10-bit converter for eight channel inputs.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Hi Tomer,

Only remaining element I think needs tidying up is the relative
ordering of probe vs remove and the interaction with devm managed
cleanup.

I really like to see the two elements being as near as possible
to opposite in order. It's a lot harder to review if they aren't.
Chances are there isn't a race condition in here, but if they are
in the 'right' order it becomes much more obvious that there isn't!

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig    |  10 ++
>  drivers/iio/adc/Makefile   |   1 +
>  drivers/iio/adc/npcm_adc.c | 338 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 349 insertions(+)
>  create mode 100644 drivers/iio/adc/npcm_adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7a3ca4ec0cb7..2d1e70a7d5c4 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -576,6 +576,16 @@ config NAU7802
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called nau7802.
>  
> +config NPCM_ADC
> +	tristate "Nuvoton NPCM ADC driver"
> +	depends on ARCH_NPCM || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Say yes here to build support for Nuvoton NPCM ADC.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called npcm_adc.
> +
>  config PALMAS_GPADC
>  	tristate "TI Palmas General Purpose ADC"
>  	depends on MFD_PALMAS
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 07df37f621bd..3337eb1f4c30 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
>  obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
>  obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
>  obj-$(CONFIG_NAU7802) += nau7802.o
> +obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
>  obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
>  obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
>  obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
> diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
> new file mode 100644
> index 000000000000..c364f2dbd702
> --- /dev/null
> +++ b/drivers/iio/adc/npcm_adc.c
> @@ -0,0 +1,338 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2019 Nuvoton Technology corporation.
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/io.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spinlock.h>
> +#include <linux/uaccess.h>
> +
> +struct npcm_adc {
> +	bool int_status;
> +	u32 adc_sample_hz;
> +	struct device *dev;
> +	void __iomem *regs;
> +	struct clk *adc_clk;
> +	wait_queue_head_t wq;
> +	struct regulator *vref;
> +	struct regmap *rst_regmap;
> +};
> +
> +/* NPCM7xx reset module */
> +#define NPCM7XX_IPSRST1_OFFSET		0x020
> +#define NPCM7XX_IPSRST1_ADC_RST		BIT(27)
> +
> +/* ADC registers */
> +#define NPCM_ADCCON	 0x00
> +#define NPCM_ADCDATA	 0x04
> +
> +/* ADCCON Register Bits */
> +#define NPCM_ADCCON_ADC_INT_EN		BIT(21)
> +#define NPCM_ADCCON_REFSEL		BIT(19)
> +#define NPCM_ADCCON_ADC_INT_ST		BIT(18)
> +#define NPCM_ADCCON_ADC_EN		BIT(17)
> +#define NPCM_ADCCON_ADC_RST		BIT(16)
> +#define NPCM_ADCCON_ADC_CONV		BIT(13)
> +
> +#define NPCM_ADCCON_CH_MASK		GENMASK(27, 24)
> +#define NPCM_ADCCON_CH(x)		((x) << 24)
> +#define NPCM_ADCCON_DIV_SHIFT		1
> +#define NPCM_ADCCON_DIV_MASK		GENMASK(8, 1)
> +#define NPCM_ADC_DATA_MASK(x)		((x) & GENMASK(9, 0))
> +
> +#define NPCM_ADC_ENABLE		(NPCM_ADCCON_ADC_EN | NPCM_ADCCON_ADC_INT_EN)
> +
> +/* ADC General Definition */
> +#define NPCM_RESOLUTION_BITS		10
> +#define NPCM_ADC_DEFAULT_SAMPLE_RATE	12500000
> +#define NPCM_INT_VREF_MV		2000
> +
> +#define NPCM_ADC_CHAN(ch) {					\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = ch,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +}
> +
> +static const struct iio_chan_spec npcm_adc_iio_channels[] = {
> +	NPCM_ADC_CHAN(0),
> +	NPCM_ADC_CHAN(1),
> +	NPCM_ADC_CHAN(2),
> +	NPCM_ADC_CHAN(3),
> +	NPCM_ADC_CHAN(4),
> +	NPCM_ADC_CHAN(5),
> +	NPCM_ADC_CHAN(6),
> +	NPCM_ADC_CHAN(7),
> +};
> +
> +static irqreturn_t npcm_adc_isr(int irq, void *data)
> +{
> +	u32 regtemp;
> +	struct iio_dev *indio_dev = data;
> +	struct npcm_adc *info = iio_priv(indio_dev);
> +
> +	regtemp = ioread32(info->regs + NPCM_ADCCON);
> +	if (regtemp & NPCM_ADCCON_ADC_INT_ST) {
> +		iowrite32(regtemp, info->regs + NPCM_ADCCON);
> +		wake_up_interruptible(&info->wq);
> +		info->int_status = true;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int npcm_adc_read(struct npcm_adc *info, int *val, u8 channel)
> +{
> +	int ret;
> +	u32 regtemp;
> +
> +	/* Select ADC channel */
> +	regtemp = ioread32(info->regs + NPCM_ADCCON);
> +	regtemp &= ~NPCM_ADCCON_CH_MASK;
> +	info->int_status = false;
> +	iowrite32(regtemp | NPCM_ADCCON_CH(channel) |
> +		  NPCM_ADCCON_ADC_CONV, info->regs + NPCM_ADCCON);
> +
> +	ret = wait_event_interruptible_timeout(info->wq, info->int_status,
> +					       msecs_to_jiffies(10));
> +	if (ret == 0) {
> +		regtemp = ioread32(info->regs + NPCM_ADCCON);
> +		if ((regtemp & NPCM_ADCCON_ADC_CONV) && info->rst_regmap) {
> +			/* if conversion failed - reset ADC module */
> +			regmap_write(info->rst_regmap, NPCM7XX_IPSRST1_OFFSET,
> +				     NPCM7XX_IPSRST1_ADC_RST);
> +			msleep(100);
> +			regmap_write(info->rst_regmap, NPCM7XX_IPSRST1_OFFSET,
> +				     0x0);
> +			msleep(100);
> +
> +			/* Enable ADC and start conversion module */
> +			iowrite32(NPCM_ADC_ENABLE | NPCM_ADCCON_ADC_CONV,
> +				  info->regs + NPCM_ADCCON);
> +			dev_err(info->dev, "RESET ADC Complete\n");
> +		}
> +		return -ETIMEDOUT;
> +	}
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = NPCM_ADC_DATA_MASK(ioread32(info->regs + NPCM_ADCDATA));
> +
> +	return 0;
> +}
> +
> +static int npcm_adc_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	int ret;
> +	int vref_uv;
> +	struct npcm_adc *info = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&indio_dev->mlock);
> +		ret = npcm_adc_read(info, val, chan->channel);
> +		mutex_unlock(&indio_dev->mlock);
> +		if (ret) {
> +			dev_err(info->dev, "NPCM ADC read failed\n");
> +			return ret;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (info->vref) {
> +			vref_uv = regulator_get_voltage(info->vref);
> +			*val = vref_uv / 1000;
> +		} else {
> +			*val = NPCM_INT_VREF_MV;
> +		}
> +		*val2 = NPCM_RESOLUTION_BITS;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = info->adc_sample_hz;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_info npcm_adc_iio_info = {
> +	.read_raw = &npcm_adc_read_raw,
> +};
> +
> +static const struct of_device_id npcm_adc_match[] = {
> +	{ .compatible = "nuvoton,npcm750-adc", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, npcm_adc_match);
> +
> +static int npcm_adc_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	int irq;
> +	u32 div;
> +	u32 reg_con;
> +	struct resource *res;
> +	struct npcm_adc *info;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	info = iio_priv(indio_dev);
> +
> +	info->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	info->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(info->regs))
> +		return PTR_ERR(info->regs);
> +
> +	info->adc_clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(info->adc_clk)) {
> +		dev_warn(&pdev->dev, "ADC clock failed: can't read clk, assuming ADC clock rate 12.5MHz\n");
> +		info->adc_sample_hz = NPCM_ADC_DEFAULT_SAMPLE_RATE;

I think this is a device tree bug.  We should have a fixed clock defined
here if nothing else. If there isn't one, then don't load the driver.
We should not be guessing the frequency.


> +	} else {
> +		/* calculate ADC clock sample rate */
> +		reg_con = ioread32(info->regs + NPCM_ADCCON);
> +		div = reg_con & NPCM_ADCCON_DIV_MASK;
> +		div = div >> NPCM_ADCCON_DIV_SHIFT;
> +		info->adc_sample_hz = clk_get_rate(info->adc_clk) /
> +			((div + 1) * 2);
> +	}
> +
> +	if (of_device_is_compatible(np, "nuvoton,npcm750-adc")) {
> +		info->rst_regmap = syscon_regmap_lookup_by_compatible
> +			("nuvoton,npcm750-rst");
> +		if (IS_ERR(info->rst_regmap)) {
> +			dev_err(&pdev->dev, "Failed to find nuvoton,npcm750-rst\n");
> +			ret = PTR_ERR(info->rst_regmap);
> +			goto err_disable_clk;
> +		}
> +	}
> +
> +	reg_con = ioread32(info->regs + NPCM_ADCCON);
> +	info->vref = devm_regulator_get_optional(&pdev->dev, "vref");
> +	if (!IS_ERR(info->vref)) {
> +		ret = regulator_enable(info->vref);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Can't enable ADC reference voltage\n");
> +			goto err_disable_clk;
> +		}
> +
> +		iowrite32(reg_con & ~NPCM_ADCCON_REFSEL,
> +			  info->regs + NPCM_ADCCON);
> +	} else {
> +		/*
> +		 * Any error which is not ENODEV indicates the regulator
> +		 * has been specified and so is a failure case.
> +		 */
> +		if (PTR_ERR(info->vref) != -ENODEV) {
> +			ret = PTR_ERR(info->vref);
> +			goto err_disable_clk;
> +		}
> +
> +		/* Use internal reference */
> +		iowrite32(reg_con | NPCM_ADCCON_REFSEL,
> +			  info->regs + NPCM_ADCCON);
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0) {
> +		dev_err(dev, "failed getting interrupt resource\n");
> +		ret = -EINVAL;
> +		goto err_disable_vref_reg;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq, npcm_adc_isr, 0,
> +			       "NPCM_ADC", indio_dev);
> +	if (ret < 0) {
I'm not keen on mixing the regulator being enabled in a non devm
managed path and the irq being requested using devm after it.

The reason is that the probe and remove paths then take non obvious
ordering.  One nice fix for this is to do the regulator disable
using a devm_add_action_or_reset call to make it part of the
managed unwind.

The same is true for the clk_prepare_enable call.
Alternative is don't use managed requests for the irq etc.


> +		dev_err(dev, "failed requesting interrupt\n");
> +		goto err_disable_vref_reg;
> +	}
> +
> +	init_waitqueue_head(&info->wq);
> +
> +	reg_con = ioread32(info->regs + NPCM_ADCCON);
> +	reg_con |= NPCM_ADC_ENABLE;
> +
> +	/* Enable the ADC Module */
> +	iowrite32(reg_con, info->regs + NPCM_ADCCON);
> +
> +	/* Start ADC conversion */
> +	iowrite32(reg_con | NPCM_ADCCON_ADC_CONV, info->regs + NPCM_ADCCON);
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->info = &npcm_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = npcm_adc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(npcm_adc_iio_channels);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Couldn't register the device.\n");
> +		goto err_disable_vref_reg;
> +	}
> +
> +	pr_info("NPCM ADC driver probed\n");
> +
> +	return 0;
> +
> +err_disable_vref_reg:
> +	if (!IS_ERR(info->vref))
> +		regulator_disable(info->vref);
> +err_disable_clk:
> +	clk_disable_unprepare(info->adc_clk);
> +
> +	return ret;
> +}
> +
> +static int npcm_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct npcm_adc *info = iio_priv(indio_dev);
> +	u32 regtemp;
> +
> +	regtemp = ioread32(info->regs + NPCM_ADCCON);
> +
> +	/* Disable the ADC Module */
> +	iowrite32(regtemp & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON);
> +
> +	iio_device_unregister(indio_dev);
> +	clk_disable_unprepare(info->adc_clk);
> +	if (!IS_ERR(info->vref))
> +		regulator_disable(info->vref);
This should look like the error paths above.  The fact it doesn't
means that the ordering at least needs more thought in review than it
should.  

> +
> +	return 0;
> +}
> +
> +static struct platform_driver npcm_adc_driver = {
> +	.probe		= npcm_adc_probe,
> +	.remove		= npcm_adc_remove,
> +	.driver		= {
> +		.name	= "npcm_adc",
> +		.of_match_table = npcm_adc_match,
> +	},
> +};
> +
> +module_platform_driver(npcm_adc_driver);
> +
> +MODULE_DESCRIPTION("Nuvoton NPCM ADC Driver");
> +MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
> +MODULE_LICENSE("GPL v2");

