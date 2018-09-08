Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9181EC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360142086D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxUSsDEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360142086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeIHTPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbeIHTPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:15:00 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAC0F2086B;
        Sat,  8 Sep 2018 14:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536416939;
        bh=uo61JTdP2YR+pE7Cscieg6G9z0jaQ+86OTfX8H4tE9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MxUSsDEe/cnlJ9a7weQxtctH391i67jNvgiYIrZbc6nQlW0Fs0voLAfxEJNHTJrNK
         nuZU4JySAdPhs/vbH0uh0FQnnM9CXcP3ci9XGmTn/zjXZ9NkBDmWvi0mbl6GaaJ8Zq
         gVlOR4JjwDuaPnFzEXMNA6j2mFn9iKR3GxjldjmQ=
Date:   Sat, 8 Sep 2018 15:28:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <knaack.h@gmx.de>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <davem@davemloft.net>, <mchehab+samsung@kernel.org>,
        <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: adxl372: Refactor the driver
Message-ID: <20180908152855.53bbf177@archlinux>
In-Reply-To: <1536070291-5335-1-git-send-email-stefan.popa@analog.com>
References: <1536070291-5335-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018 17:11:31 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> This patch restructures the existing adxl372 driver by adding a module for
> SPI and a header file, while the baseline module deals with the chip-logic.
> 
> This is a necessary step, as this driver should support in the future
> a similar device which differs only in the type of interface used (I2C
> instead of SPI).
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
One comment inline on an area where we haven't been that consistent...

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  MAINTAINERS                     |  1 +
>  drivers/iio/accel/Kconfig       | 11 +++++--
>  drivers/iio/accel/Makefile      |  1 +
>  drivers/iio/accel/adxl372.c     | 73 ++++++++++++++---------------------------
>  drivers/iio/accel/adxl372.h     | 15 +++++++++
>  drivers/iio/accel/adxl372_spi.c | 52 +++++++++++++++++++++++++++++
>  6 files changed, 102 insertions(+), 51 deletions(-)
>  create mode 100644 drivers/iio/accel/adxl372.h
>  create mode 100644 drivers/iio/accel/adxl372_spi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2bfc9b0..2938632 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -548,6 +548,7 @@ M:	Stefan Popa <stefan.popa@analog.com>
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/accel/adxl372.c
> +F:	drivers/iio/accel/adxl372_spi.c
>  F:	Documentation/devicetree/bindings/iio/accel/adxl372.txt
>  
>  AF9013 MEDIA DRIVER
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index eae23d6..bed5da8 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -61,15 +61,20 @@ config ADXL345_SPI
>  	  for the core module.
>  
>  config ADXL372
> -	tristate "Analog Devices ADXL372 3-Axis Accelerometer Driver"
> -	depends on SPI
> +	tristate
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER

Hmm. I'm in too minds about this (and it's come up quite a few times before).

The issue is trading off configuration complexity against flexibility to
configure a minimum build.

So either:
1. Two config options for the user to select.
2. One option that will build the i2c / spi dependent on their being support
   for these busses built.

This second is what for example the bmc150 does in this same file. The
It leads to a cleaner menuconfig.
The first is done by mma7455.

At somepoint we should probably decide to clean this up but for now there
is a mix so I'm not going to block this patch on making that decision.

> +
> +config ADXL372_SPI
> +	tristate "Analog Devices ADXL372 3-Axis Accelerometer SPI Driver"
> +	depends on SPI
> +	select ADXL372
> +	select REGMAP_SPI
>  	help
>  	  Say yes here to add support for the Analog Devices ADXL372 triaxial
>  	  acceleration sensor.
>  	  To compile this driver as a module, choose M here: the
> -	  module will be called adxl372.
> +	  module will be called adxl372_spi.
>  
>  config BMA180
>  	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 5758ffc..c9c5db9 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_ADXL345) += adxl345_core.o
>  obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
>  obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
>  obj-$(CONFIG_ADXL372) += adxl372.o
> +obj-$(CONFIG_ADXL372_SPI) += adxl372_spi.o
>  obj-$(CONFIG_BMA180) += bma180.o
>  obj-$(CONFIG_BMA220) += bma220_spi.o
>  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index fdaaa58..f1df89d 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * ADXL372 3-Axis Digital Accelerometer SPI driver
> + * ADXL372 3-Axis Digital Accelerometer core driver
>   *
>   * Copyright 2018 Analog Devices Inc.
>   */
> @@ -20,6 +20,8 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  
> +#include "adxl372.h"
> +
>  /* ADXL372 registers definition */
>  #define ADXL372_DEVID			0x00
>  #define ADXL372_DEVID_MST		0x01
> @@ -246,7 +248,8 @@ static const struct iio_chan_spec adxl372_channels[] = {
>  };
>  
>  struct adxl372_state {
> -	struct spi_device		*spi;
> +	int				irq;
> +	struct device			*dev;
>  	struct regmap			*regmap;
>  	struct iio_trigger		*dready_trig;
>  	enum adxl372_fifo_mode		fifo_mode;
> @@ -565,7 +568,7 @@ static int adxl372_setup(struct adxl372_state *st)
>  		return ret;
>  
>  	if (regval != ADXL372_DEVID_VAL) {
> -		dev_err(&st->spi->dev, "Invalid chip id %x\n", regval);
> +		dev_err(st->dev, "Invalid chip id %x\n", regval);
>  		return -ENODEV;
>  	}
>  
> @@ -891,56 +894,45 @@ static const struct iio_info adxl372_info = {
>  	.hwfifo_set_watermark = adxl372_set_watermark,
>  };
>  
> -static bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg)
> +bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg)
>  {
>  	return (reg == ADXL372_FIFO_DATA);
>  }
> +EXPORT_SYMBOL_GPL(adxl372_readable_noinc_reg);
>  
> -static const struct regmap_config adxl372_spi_regmap_config = {
> -	.reg_bits = 7,
> -	.pad_bits = 1,
> -	.val_bits = 8,
> -	.read_flag_mask = BIT(0),
> -	.readable_noinc_reg = adxl372_readable_noinc_reg,
> -};
> -
> -static int adxl372_probe(struct spi_device *spi)
> +int adxl372_probe(struct device *dev, struct regmap *regmap,
> +		  int irq, const char *name)
>  {
>  	struct iio_dev *indio_dev;
>  	struct adxl372_state *st;
> -	struct regmap *regmap;
>  	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	spi_set_drvdata(spi, indio_dev);
> -
> -	st->spi = spi;
> -
> -	regmap = devm_regmap_init_spi(spi, &adxl372_spi_regmap_config);
> -	if (IS_ERR(regmap))
> -		return PTR_ERR(regmap);
> +	dev_set_drvdata(dev, indio_dev);
>  
> +	st->dev = dev;
>  	st->regmap = regmap;
> +	st->irq = irq;
>  
>  	indio_dev->channels = adxl372_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
>  	indio_dev->available_scan_masks = adxl372_channel_masks;
> -	indio_dev->dev.parent = &spi->dev;
> -	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->dev.parent = dev;
> +	indio_dev->name = name;
>  	indio_dev->info = &adxl372_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>  
>  	ret = adxl372_setup(st);
>  	if (ret < 0) {
> -		dev_err(&st->spi->dev, "ADXL372 setup failed\n");
> +		dev_err(dev, "ADXL372 setup failed\n");
>  		return ret;
>  	}
>  
> -	ret = devm_iio_triggered_buffer_setup(&st->spi->dev,
> +	ret = devm_iio_triggered_buffer_setup(dev,
>  					      indio_dev, NULL,
>  					      adxl372_trigger_handler,
>  					      &adxl372_buffer_ops);
> @@ -949,8 +941,8 @@ static int adxl372_probe(struct spi_device *spi)
>  
>  	iio_buffer_set_attrs(indio_dev->buffer, adxl372_fifo_attributes);
>  
> -	if (st->spi->irq) {
> -		st->dready_trig = devm_iio_trigger_alloc(&st->spi->dev,
> +	if (st->irq) {
> +		st->dready_trig = devm_iio_trigger_alloc(dev,
>  							 "%s-dev%d",
>  							 indio_dev->name,
>  							 indio_dev->id);
> @@ -958,15 +950,15 @@ static int adxl372_probe(struct spi_device *spi)
>  			return -ENOMEM;
>  
>  		st->dready_trig->ops = &adxl372_trigger_ops;
> -		st->dready_trig->dev.parent = &st->spi->dev;
> +		st->dready_trig->dev.parent = dev;
>  		iio_trigger_set_drvdata(st->dready_trig, indio_dev);
> -		ret = devm_iio_trigger_register(&st->spi->dev, st->dready_trig);
> +		ret = devm_iio_trigger_register(dev, st->dready_trig);
>  		if (ret < 0)
>  			return ret;
>  
>  		indio_dev->trig = iio_trigger_get(st->dready_trig);
>  
> -		ret = devm_request_threaded_irq(&st->spi->dev, st->spi->irq,
> +		ret = devm_request_threaded_irq(dev, st->irq,
>  					iio_trigger_generic_data_rdy_poll,
>  					NULL,
>  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> @@ -975,24 +967,9 @@ static int adxl372_probe(struct spi_device *spi)
>  			return ret;
>  	}
>  
> -	return devm_iio_device_register(&st->spi->dev, indio_dev);
> +	return devm_iio_device_register(dev, indio_dev);
>  }
> -
> -static const struct spi_device_id adxl372_id[] = {
> -	{ "adxl372", 0 },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(spi, adxl372_id);
> -
> -static struct spi_driver adxl372_driver = {
> -	.driver = {
> -		.name = KBUILD_MODNAME,
> -	},
> -	.probe = adxl372_probe,
> -	.id_table = adxl372_id,
> -};
> -
> -module_spi_driver(adxl372_driver);
> +EXPORT_SYMBOL_GPL(adxl372_probe);
>  
>  MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer driver");
> diff --git a/drivers/iio/accel/adxl372.h b/drivers/iio/accel/adxl372.h
> new file mode 100644
> index 0000000..5da89b1
> --- /dev/null
> +++ b/drivers/iio/accel/adxl372.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * ADXL372 3-Axis Digital Accelerometer
> + *
> + * Copyright 2018 Analog Devices Inc.
> + */
> +
> +#ifndef _ADXL372_H_
> +#define _ADXL372_H_
> +
> +int adxl372_probe(struct device *dev, struct regmap *regmap,
> +		  int irq, const char *name);
> +bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg);
> +
> +#endif /* _ADXL372_H_ */
> diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
> new file mode 100644
> index 0000000..e14e655
> --- /dev/null
> +++ b/drivers/iio/accel/adxl372_spi.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ADXL372 3-Axis Digital Accelerometer SPI driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "adxl372.h"
> +
> +static const struct regmap_config adxl372_spi_regmap_config = {
> +	.reg_bits = 7,
> +	.pad_bits = 1,
> +	.val_bits = 8,
> +	.read_flag_mask = BIT(0),
> +	.readable_noinc_reg = adxl372_readable_noinc_reg,
> +};
> +
> +static int adxl372_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_spi(spi, &adxl372_spi_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return adxl372_probe(&spi->dev, regmap, spi->irq, id->name);
> +}
> +
> +static const struct spi_device_id adxl372_spi_id[] = {
> +	{ "adxl372", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, adxl372_spi_id);
> +
> +static struct spi_driver adxl372_spi_driver = {
> +	.driver = {
> +		.name = "adxl372_spi",
> +	},
> +	.probe = adxl372_spi_probe,
> +	.id_table = adxl372_spi_id,
> +};
> +
> +module_spi_driver(adxl372_spi_driver);
> +
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer SPI driver");
> +MODULE_LICENSE("GPL");

