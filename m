Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE35EC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918E82085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbfAaNsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:48:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3257 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726863AbfAaNsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:48:37 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 375F7F1FFC23333CBCB4;
        Thu, 31 Jan 2019 21:48:32 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 31 Jan 2019
 21:48:30 +0800
Date:   Thu, 31 Jan 2019 13:48:21 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio:dac:ti-dac7612: Add driver for Texas
 Instruments DAC7612
Message-ID: <20190131134821.00007dd0@huawei.com>
In-Reply-To: <20190128094931.4430-1-ricardo@ribalda.com>
References: <20190128094931.4430-1-ricardo@ribalda.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 10:49:30 +0100
Ricardo Ribalda Delgado <ricardo@ribalda.com> wrote:

> It is a driver for Texas Instruments Dual, 12-Bit Serial Input
> Digital-to-Analog Converter.
> 
> Datasheet of this chip:
> http://www.ti.com/lit/ds/sbas106/sbas106.pdf
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
Hi Ricardo,

Trivial bits inline I would have fixed, but seems we will be going for a v4
for the binding anyway!

Jonathan

> ---
> v3: Changes by Jonathan Cameron <jic23@kernel.org>
> 
> - Include OF compatible strings
> - Rename RESOLUTION define
> - Create defines for BIT positions
> - Support DMA
> - Rename gpio
> - Remove scantype
> - Fix scale
> - Use iio_priv at variable definition
> - (Ab)use ARRAY_SIZE for number of channels (love the idea)
> 
> 
>  MAINTAINERS                  |   6 ++
>  drivers/iio/dac/Kconfig      |  10 ++
>  drivers/iio/dac/Makefile     |   1 +
>  drivers/iio/dac/ti-dac7612.c | 173 +++++++++++++++++++++++++++++++++++
>  4 files changed, 190 insertions(+)
>  create mode 100644 drivers/iio/dac/ti-dac7612.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d039f66a5cef..30ba5435906b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14877,6 +14877,12 @@ F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>  F:	drivers/clk/keystone/sci-clk.c
>  F:	drivers/reset/reset-ti-sci.c
>  
> +Texas Instruments' DAC7612 DAC Driver
> +M:	Ricardo Ribalda <ricardo@ribalda.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	drivers/iio/dac/ti-dac7612.c
> +
>  THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
>  M:	Hans Verkuil <hverkuil@xs4all.nl>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index f28daf67db6a..fbef9107acad 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -375,6 +375,16 @@ config TI_DAC7311
>  
>  	  If compiled as a module, it will be called ti-dac7311.
>  
> +config TI_DAC7612
> +	tristate "Texas Instruments 12-bit 2-channel DAC driver"
> +	depends on SPI_MASTER && GPIOLIB
> +	help
> +	  Driver for the Texas Instruments DAC7612, DAC7612U, DAC7612UB
> +	  The driver hand drive the load pin automatically, otherwise
> +	  it needs to be toggled manually.
> +
> +	  If compiled as a module, it will be called ti-dac7612.
> +
>  config VF610_DAC
>  	tristate "Vybrid vf610 DAC driver"
>  	depends on OF
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index f0a37c93de8e..1369fa1d2f0e 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -41,4 +41,5 @@ obj-$(CONFIG_STM32_DAC) += stm32-dac.o
>  obj-$(CONFIG_TI_DAC082S085) += ti-dac082s085.o
>  obj-$(CONFIG_TI_DAC5571) += ti-dac5571.o
>  obj-$(CONFIG_TI_DAC7311) += ti-dac7311.o
> +obj-$(CONFIG_TI_DAC7612) += ti-dac7612.o
>  obj-$(CONFIG_VF610_DAC) += vf610_dac.o
> diff --git a/drivers/iio/dac/ti-dac7612.c b/drivers/iio/dac/ti-dac7612.c
> new file mode 100644
> index 000000000000..a2f58256a784
> --- /dev/null
> +++ b/drivers/iio/dac/ti-dac7612.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DAC7612 Dual, 12-Bit Serial input Digital-to-Analog Converter
> + *
> + * Copyright 2019 Qtechnology A/S
> + * 2019 Ricardo Ribalda <ricardo@ribalda.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +
> +#define DAC7612_RESOLUTION 12
> +#define DAC7612_ADDRESS 4
> +#define DAC7612_START 5
> +
> +struct dac7612 {
> +	struct spi_device *spi;
> +	struct gpio_desc *loaddacs;
> +	uint16_t cache[2];
> +
> +	// DMA
/* DMA */

But a slightly more detailed comment preferred.

> +	uint8_t data[2] ____cacheline_aligned;
> +};
> +
> +static int dac7612_cmd_single(struct dac7612 *priv, int channel, u16 val)
> +{
> +	int ret;
> +
> +	priv->data[0] = BIT(DAC7612_START) | (channel << DAC7612_ADDRESS);
> +	priv->data[0] |= val >> 8;
> +	priv->data[1] = val & 0xff;
> +
> +	priv->cache[channel] = val;
> +
> +	ret = spi_write(priv->spi, priv->data, sizeof(priv->data));
> +	if (ret)
> +		return ret;
> +
> +	gpiod_set_value(priv->loaddacs, 1);
> +	gpiod_set_value(priv->loaddacs, 0);
> +
> +	return 0;
> +}
> +
> +#define dac7612_CHANNEL(chan, name) {				\
> +	.type = IIO_VOLTAGE,					\
> +	.channel = (chan),					\
> +	.indexed = 1,						\
> +	.output = 1,						\
> +	.datasheet_name = name,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +}
> +
> +static const struct iio_chan_spec dac7612_channels[] = {
> +	dac7612_CHANNEL(0, "OUTA"),
> +	dac7612_CHANNEL(1, "OUTB"),
> +};
> +
> +static int dac7612_read_raw(struct iio_dev *iio_dev,
> +			    const struct iio_chan_spec *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct dac7612 *priv;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		priv = iio_priv(iio_dev);
> +		*val = priv->cache[chan->channel];
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int dac7612_write_raw(struct iio_dev *iio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct dac7612 *priv = iio_priv(iio_dev);
> +	int ret;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	if ((val >= BIT(DAC7612_RESOLUTION)) || val < 0 || val2)
> +		return -EINVAL;
> +
> +	if (val == priv->cache[chan->channel])
> +		return 0;
> +
> +	mutex_lock(&iio_dev->mlock);
> +	ret = dac7612_cmd_single(priv, chan->channel, val);
> +	mutex_unlock(&iio_dev->mlock);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info dac7612_info = {
> +	.read_raw = dac7612_read_raw,
> +	.write_raw = dac7612_write_raw,
> +};
> +
> +static int dac7612_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *iio_dev;
> +	struct dac7612 *priv;
> +	int i;
> +	int ret;
> +
> +	iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*priv));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(iio_dev);

Please add a comment here about why it's optional but we then use
it anyway (which is fine but none obvious!)

> +	priv->loaddacs = devm_gpiod_get_optional(&spi->dev, "loaddacs",
> +						 GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->loaddacs))
> +		return PTR_ERR(priv->loaddacs);
> +	priv->spi = spi;
> +	spi_set_drvdata(spi, iio_dev);
> +	iio_dev->dev.parent = &spi->dev;
> +	iio_dev->info = &dac7612_info;
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +	iio_dev->channels = dac7612_channels;
> +	iio_dev->num_channels = ARRAY_SIZE(priv->cache);
> +	iio_dev->name = spi_get_device_id(spi)->name;
> +
> +	for (i = 0; i < ARRAY_SIZE(priv->cache); i++) {
> +		ret = dac7612_cmd_single(priv, i, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(&spi->dev, iio_dev);
> +}
> +
> +static const struct spi_device_id dac7612_id[] = {
> +	{"ti-dac7612"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, dac7612_id);
> +
> +static const struct of_device_id dac7612_of_match[] = {
> +	{ .compatible = "ti,dac7612" },
> +	{ .compatible = "ti,dac7612u" },
> +	{ .compatible = "ti,dac7612b" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, dac7612_of_match);
> +
> +static struct spi_driver dac7612_driver = {
> +	.driver = {
> +		   .name = "ti-dac7612",
> +		   .of_match_table = dac7612_of_match,
> +		   },
> +	.probe = dac7612_probe,
> +	.id_table = dac7612_id,
> +};
> +module_spi_driver(dac7612_driver);
> +
> +MODULE_AUTHOR("Ricardo Ribalda <ricardo@ribalda.com>");
> +MODULE_DESCRIPTION("Texas Instruments DAC7612 DAC driver");
> +MODULE_LICENSE("GPL v2");


