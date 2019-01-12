Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D69C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FBA20878
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547318577;
	bh=OzfWgnvstGVKrH3eOl+G0eDtiw9EuXL/Yy+weeoXZKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KY1/UbLls616fivn+wE2CI1I2N9347iGxiufBaXAjcy/sdlW6HxkHgD3FRumi48n2
	 pCmyNBI6LpGRnhgI2709EBEGbFitZqxCgOzdn9estrGpWARLglgf5SJ+OVL6gTMy3o
	 T3fSJl+PmqvojDWd5Pba/sE/X0jUdEt3lOz+n8MM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfALSm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:42:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfALSmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:42:55 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD9A0206B6;
        Sat, 12 Jan 2019 18:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547318573;
        bh=OzfWgnvstGVKrH3eOl+G0eDtiw9EuXL/Yy+weeoXZKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ta7LHIVb8ZE2jJxNvWUZybEQ8vimvmzIeDuyAYO74hkXNtxtMd8SsVil0XNfWDXMY
         Yqbzs1Xp8NDE7I2p0P35h5Nx3TiR7JmFvll9y3lsvRGS2Z4eDSz/+gLM18+9C8DIx2
         E2ShCIrhAeFHH9rxdTTbyzg3DGExOcKYIJK8KFs0=
Date:   Sat, 12 Jan 2019 18:42:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] iio: adc: Add the TI ads124s08 ADC code
Message-ID: <20190112184249.667ad161@archlinux>
In-Reply-To: <20190111195707.2086-2-dmurphy@ti.com>
References: <20190111195707.2086-1-dmurphy@ti.com>
        <20190111195707.2086-2-dmurphy@ti.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 13:57:06 -0600
Dan Murphy <dmurphy@ti.com> wrote:

> Introduce the TI ADS124S08 and the ADS124S06 ADC
> devices from TI.  The ADS124S08 is the 12 channel ADC
> and the ADS124S06 is the 6 channel ADC device
> 
> These devices share a common datasheet:
> http://www.ti.com/lit/gpn/ads124s08
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
Hi Dan,

The only real change in here (there is another nitpick) that I think
needs to be made is that the buffer length in the private stucture is
not longer connected to the number of channels.  You effectively use it
as a bounce buffer now and I think the maximum is 5.

As that's it I'll just clean it up whilst applying.  If you could
confirm I'm not crazy and didn't mess it up that would be great!

Thanks,

Jonathan

> ---
> v3 - Fixed the IIO channel definition, reduce long line in probe and
> fixed the buffer allocation definition - https://lore.kernel.org/patchwork/patch/1023970/
> 
> v2 - Removed the fill_noop call, updated probe to use device managed calls,
> removed regulator support, fixed the buffer to allow 64 bit timestamp, changed
> all the defines from S0X to S08, added an enum for the IDs and updated copyright
> header format.  I may have missed a few summary changes here but here is the
> review reference - https://lore.kernel.org/patchwork/patch/1021048/
> 
>  drivers/iio/adc/Kconfig        |  10 +
>  drivers/iio/adc/Makefile       |   1 +
>  drivers/iio/adc/ti-ads124s08.c | 375 +++++++++++++++++++++++++++++++++
>  3 files changed, 386 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads124s08.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7a3ca4ec0cb7..8cf9e007ea76 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -908,6 +908,16 @@ config TI_ADS8688
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-ads8688.
>  
> +config TI_ADS124S08
> +	tristate "Texas Instruments ADS124S08"
> +	depends on SPI && OF
> +	help
> +	  If you say yes here you get support for Texas Instruments ADS124S08
> +	  and ADS124S06 ADC chips
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-ads124s08.
> +
>  config TI_AM335X_ADC
>  	tristate "TI's AM335X ADC driver"
>  	depends on MFD_TI_AM335X_TSCADC && HAS_DMA
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 07df37f621bd..49b203bf4e0e 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -81,6 +81,7 @@ obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
>  obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
> +obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>  obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
>  obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
> diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
> new file mode 100644
> index 000000000000..3d7f2300e0f6
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads124s08.c
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* TI ADS124S0X chip family driver
> + * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/sysfs.h>
> +
> +/* Commands */
> +#define ADS124S08_CMD_NOP	0x00
> +#define ADS124S08_CMD_WAKEUP	0x02
> +#define ADS124S08_CMD_PWRDWN	0x04
> +#define ADS124S08_CMD_RESET	0x06
> +#define ADS124S08_CMD_START	0x08
> +#define ADS124S08_CMD_STOP	0x0a
> +#define ADS124S08_CMD_SYOCAL	0x16
> +#define ADS124S08_CMD_SYGCAL	0x17
> +#define ADS124S08_CMD_SFOCAL	0x19
> +#define ADS124S08_CMD_RDATA	0x12
> +#define ADS124S08_CMD_RREG	0x20
> +#define ADS124S08_CMD_WREG	0x40
> +
> +/* Registers */
> +#define ADS124S08_ID_REG	0x00
> +#define ADS124S08_STATUS	0x01
> +#define ADS124S08_INPUT_MUX	0x02
> +#define ADS124S08_PGA		0x03
> +#define ADS124S08_DATA_RATE	0x04
> +#define ADS124S08_REF		0x05
> +#define ADS124S08_IDACMAG	0x06
> +#define ADS124S08_IDACMUX	0x07
> +#define ADS124S08_VBIAS		0x08
> +#define ADS124S08_SYS		0x09
> +#define ADS124S08_OFCAL0	0x0a
> +#define ADS124S08_OFCAL1	0x0b
> +#define ADS124S08_OFCAL2	0x0c
> +#define ADS124S08_FSCAL0	0x0d
> +#define ADS124S08_FSCAL1	0x0e
> +#define ADS124S08_FSCAL2	0x0f
> +#define ADS124S08_GPIODAT	0x10
> +#define ADS124S08_GPIOCON	0x11
> +
> +/* ADS124S0x common channels */
> +#define ADS124S08_AIN0		0x00
> +#define ADS124S08_AIN1		0x01
> +#define ADS124S08_AIN2		0x02
> +#define ADS124S08_AIN3		0x03
> +#define ADS124S08_AIN4		0x04
> +#define ADS124S08_AIN5		0x05
> +#define ADS124S08_AINCOM	0x0c
> +/* ADS124S08 only channels */
> +#define ADS124S08_AIN6		0x06
> +#define ADS124S08_AIN7		0x07
> +#define ADS124S08_AIN8		0x08
> +#define ADS124S08_AIN9		0x09
> +#define ADS124S08_AIN10		0x0a
> +#define ADS124S08_AIN11		0x0b
> +#define ADS124S08_MAX_CHANNELS	12
> +
> +#define ADS124S08_POS_MUX_SHIFT	0x04
> +#define ADS124S08_INT_REF		0x09
> +
> +#define ADS124S08_START_REG_MASK	0x1f
> +#define ADS124S08_NUM_BYTES_MASK	0x1f
> +
> +#define ADS124S08_START_CONV	0x01
> +#define ADS124S08_STOP_CONV	0x00
> +
> +enum ads124s_id {
> +	ADS124S08_ID,
> +	ADS124S06_ID,
> +};
> +
> +struct ads124s_chip_info {
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +};
> +
> +struct ads124s_private {
> +	const struct ads124s_chip_info	*chip_info;
> +	struct gpio_desc *reset_gpio;
> +	struct spi_device *spi;
> +	struct mutex lock;
> +	u8 data[ADS124S08_MAX_CHANNELS] ____cacheline_aligned;

I'm fairly sure this only needs to be 5 not MAX_CHANNELS as you use
another buffer to build up the full set of readouts.

> +};
> +
> +#define ADS124S08_CHAN(index)					\
> +{								\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = index,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.scan_index = index,					\
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = 32,					\
> +		.storagebits = 32,				\
> +	},							\
> +}
> +
> +static const struct iio_chan_spec ads124s06_channels[] = {
> +	ADS124S08_CHAN(0),
> +	ADS124S08_CHAN(1),
> +	ADS124S08_CHAN(2),
> +	ADS124S08_CHAN(3),
> +	ADS124S08_CHAN(4),
> +	ADS124S08_CHAN(5),
> +};
> +
> +static const struct iio_chan_spec ads124s08_channels[] = {
> +	ADS124S08_CHAN(0),
> +	ADS124S08_CHAN(1),
> +	ADS124S08_CHAN(2),
> +	ADS124S08_CHAN(3),
> +	ADS124S08_CHAN(4),
> +	ADS124S08_CHAN(5),
> +	ADS124S08_CHAN(6),
> +	ADS124S08_CHAN(7),
> +	ADS124S08_CHAN(8),
> +	ADS124S08_CHAN(9),
> +	ADS124S08_CHAN(10),
> +	ADS124S08_CHAN(11),
> +};
> +
> +static const struct ads124s_chip_info ads124s_chip_info_tbl[] = {
> +	[ADS124S08_ID] = {
> +		.channels = ads124s08_channels,
> +		.num_channels = ARRAY_SIZE(ads124s08_channels),
> +	},
> +	[ADS124S06_ID] = {
> +		.channels = ads124s06_channels,
> +		.num_channels = ARRAY_SIZE(ads124s06_channels),
> +	},
> +};
> +
> +static int ads124s_write_cmd(struct iio_dev *indio_dev, u8 command)
> +{
> +	struct ads124s_private *priv = iio_priv(indio_dev);
> +
> +	priv->data[0] = command;
> +
> +	return spi_write(priv->spi, &priv->data[0], 1);
> +}
> +
> +static int ads124s_write_reg(struct iio_dev *indio_dev, u8 reg, u8 data)
> +{
> +	struct ads124s_private *priv = iio_priv(indio_dev);
> +
> +	priv->data[0] = ADS124S08_CMD_WREG | reg;
> +	priv->data[1] = 0x0;
> +	priv->data[2] = data;
> +
> +	return spi_write(priv->spi, &priv->data[0], 3);
> +}
> +
> +static int ads124s_reset(struct iio_dev *indio_dev)
> +{
> +	struct ads124s_private *priv = iio_priv(indio_dev);
> +
> +	if (priv->reset_gpio) {
> +		gpiod_set_value(priv->reset_gpio, 0);
> +		udelay(200);
> +		gpiod_set_value(priv->reset_gpio, 1);
> +	} else {
> +		return ads124s_write_cmd(indio_dev, ADS124S08_CMD_RESET);
> +	}
> +
> +	return 0;
> +};
> +
> +static int ads124s_read(struct iio_dev *indio_dev, unsigned int chan)
> +{
> +	struct ads124s_private *priv = iio_priv(indio_dev);
> +	int ret;
> +	u32 tmp;
> +	struct spi_transfer t[] = {
> +		{
> +			.tx_buf = &priv->data[0],
> +			.len = 4,
> +			.cs_change = 1,
> +		}, {
> +			.tx_buf = &priv->data[1],
> +			.rx_buf = &priv->data[1],
> +			.len = 4,
> +		},
> +	};
> +
> +	priv->data[0] = ADS124S08_CMD_RDATA;
> +	memset(&priv->data[1], ADS124S08_CMD_NOP, sizeof(priv->data));
> +
> +	ret = spi_sync_transfer(priv->spi, t, ARRAY_SIZE(t));
> +	if (ret < 0)
> +		return ret;
> +
> +	tmp = priv->data[2] << 16 | priv->data[3] << 8 | priv->data[4];
> +
> +	return tmp;
> +}
> +
> +static int ads124s_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long m)
> +{
> +	struct ads124s_private *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ads124s_write_reg(indio_dev, ADS124S08_INPUT_MUX,
> +					chan->channel);
> +		if (ret) {
> +			dev_err(&priv->spi->dev, "Set ADC CH failed\n");
> +			goto out;
> +		}
> +
> +		ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
> +		if (ret) {
> +			dev_err(&priv->spi->dev, "Start converions failed\n");
> +			goto out;
> +		}
> +
> +		ret = ads124s_read(indio_dev, chan->channel);
> +		if (ret < 0) {
> +			dev_err(&priv->spi->dev, "Read ADC failed\n");
> +			goto out;
> +		} else
> +			*val = ret;
Nit pick is that this doesn't benefit from being an else as it's just the normal
flow.  Trivial though so lets just leave it!

> +
> +		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
> +		if (ret) {
> +			dev_err(&priv->spi->dev, "Stop converions failed\n");
> +			goto out;
> +		}
> +
> +		ret = IIO_VAL_INT;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +out:
> +	mutex_unlock(&priv->lock);
> +	return ret;
> +}
> +
> +static const struct iio_info ads124s_info = {
> +	.read_raw = &ads124s_read_raw,
> +};
> +
> +static irqreturn_t ads124s_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ads124s_private *priv = iio_priv(indio_dev);
> +	u32 buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u16)];
> +	int scan_index, j = 0;
> +	int ret;
> +
> +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		ret = ads124s_write_reg(indio_dev, ADS124S08_INPUT_MUX,
> +					scan_index);
> +		if (ret)
> +			dev_err(&priv->spi->dev, "Set ADC CH failed\n");
> +
> +		ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
> +		if (ret)
> +			dev_err(&priv->spi->dev, "Start ADC converions failed\n");
> +
> +		buffer[j] = ads124s_read(indio_dev, scan_index);
> +		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
> +		if (ret)
> +			dev_err(&priv->spi->dev, "Stop ADC converions failed\n");
> +
> +		j++;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +			pf->timestamp);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ads124s_probe(struct spi_device *spi)
> +{
> +	struct ads124s_private *ads124s_priv;
> +	struct iio_dev *indio_dev;
> +	const struct spi_device_id *spi_id = spi_get_device_id(spi);
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*ads124s_priv));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	ads124s_priv = iio_priv(indio_dev);
> +
> +	ads124s_priv->reset_gpio = devm_gpiod_get_optional(&spi->dev,
> +						   "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ads124s_priv->reset_gpio))
> +		dev_info(&spi->dev, "Reset GPIO not defined\n");
> +
> +	ads124s_priv->chip_info = &ads124s_chip_info_tbl[spi_id->driver_data];
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	ads124s_priv->spi = spi;
> +
> +	indio_dev->name = spi_id->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->dev.of_node = spi->dev.of_node;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ads124s_priv->chip_info->channels;
> +	indio_dev->num_channels = ads124s_priv->chip_info->num_channels;
> +	indio_dev->info = &ads124s_info;
> +
> +	mutex_init(&ads124s_priv->lock);
> +
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
> +					      ads124s_trigger_handler, NULL);
> +	if (ret) {
> +		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
> +		return ret;
> +	}
> +
> +	ads124s_reset(indio_dev);
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ads124s_id[] = {
> +	{ "ads124s06", ADS124S06_ID },
> +	{ "ads124s08", ADS124S08_ID },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ads124s_id);
> +
> +static const struct of_device_id ads124s_of_table[] = {
> +	{ .compatible = "ti,ads124s06" },
> +	{ .compatible = "ti,ads124s08" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ads124s_of_table);
> +
> +static struct spi_driver ads124s_driver = {
> +	.driver = {
> +		.name	= "ads124s08",
> +		.of_match_table = ads124s_of_table,
> +	},
> +	.probe		= ads124s_probe,
> +	.id_table	= ads124s_id,
> +};
> +module_spi_driver(ads124s_driver);
> +
> +MODULE_AUTHOR("Dan Murphy <dmuprhy@ti.com>");
> +MODULE_DESCRIPTION("TI TI_ADS12S0X ADC");
> +MODULE_LICENSE("GPL v2");

