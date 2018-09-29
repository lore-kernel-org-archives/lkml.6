Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA879C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C232087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 12:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3/UTPHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C232087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeI2TNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 15:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbeI2TNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 15:13:08 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4314206B2;
        Sat, 29 Sep 2018 12:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538225087;
        bh=PISjVKT+jWtVTLof2duQ3EP2/Su707I3/21yE/65SmY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T3/UTPHKiQ8VB3vFP448BAjviruE9GlSzkvwxT6HKc3TKL9+IXqXJYv2KFg91autM
         ZfWF/sKTfsiQG9fz/Qfg5FYqRQ1E2++NHN/65ckHVBXpo2EEg6S1y2ht/VJKyZkfOZ
         yKDwhYyH23NopyprrnDOHAJqTs1V48MF3VkofRK8=
Date:   Sat, 29 Sep 2018 13:44:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: Add support for PNI RM3100 9-axis
 magnetometer
Message-ID: <20180929134441.2e400956@archlinux>
In-Reply-To: <20180924143714.GA16236@Eros>
References: <20180920131340.6699-1-songqiang1304521@gmail.com>
        <20180922111409.597126fd@archlinux>
        <20180924143714.GA16236@Eros>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018 22:37:14 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> On Sat, Sep 22, 2018 at 11:14:09AM +0100, Jonathan Cameron wrote:
> > On Thu, 20 Sep 2018 21:13:40 +0800
> > Song Qiang <songqiang1304521@gmail.com> wrote:
> >   
> > > PNI RM3100 magnetometer is a high resolution, large signal immunity
> > > magnetometer, composed of 3 single sensors and a processing chip.
> > > PNI is currently not in the vendors list, so this is also adding it.
> > > 
> > > Following functions are available:
> > >  - Single-shot measurement from
> > >    /sys/bus/iio/devices/iio:deviceX/in_magn_{axis}_raw
> > >  - Triggerd buffer measurement.
> > >  - Both i2c and spi interface are supported.
> > >  - Both interrupt and polling measurement is supported, depands on if
> > >    the 'interrupts' in DT is declared.
> > > 
> > > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>  
> > Hi Song,  
> 
> ...
> 
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	/* 3sec more wait time. */
> > > +	ret = regmap_read(data->regmap, RM_REG_TMRC, &tmp);
> > > +	data->conversion_time = rm3100_samp_rates[tmp-RM_TMRC_OFFSET][2] + 3000;
> > > +
> > > +	/* Starting all channels' conversion. */
> > > +	ret = regmap_write(regmap, RM_REG_CMM,
> > > +		RM_CMM_PMX | RM_CMM_PMY | RM_CMM_PMZ | RM_CMM_START);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return devm_iio_device_register(dev, indio_dev);  
> > Nope.  Can't do this without having a race condition.   You need
> > to ensure the userspace and in kernel interfaces are removed 'before'.
> > you do that RM_REG_CMM write in remove.
> > 
> > One option is to use devm_add_action to add a custom unwind function
> > to the automatic handling. The other is to not use devm for everything 
> > after the write above and do the device_unregister manually.
> >   
> 
> Hi Jonathan,
> 
> I considered the both options you mentioned, and I was going to use the
> manual way. But then something came to my mind, what if there is another
> devm_* operation needs care, what if more. I checked devm_add_action in
> source code, and it says that this function only adds unwinding handlers.
> I guess this method was designed for this situation, and if we have
> already used devm_ in our code, it's better to use devm_add_action for
> cleanup, is that right?

It can provide a very clean solution.  Be careful though. You do need
to make sure to handle a failure of this function itself.

Jonathan

> 
> yours,
> Song Qiang
> 
> > > +}
> > > +EXPORT_SYMBOL(rm3100_common_probe);
> > > +
> > > +int rm3100_common_remove(struct device *dev)
> > > +{
> > > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > > +	struct rm3100_data *data = iio_priv(indio_dev);
> > > +	struct regmap *regmap = data->regmap;
> > > +
> > > +	regmap_write(regmap, RM_REG_CMM, 0x00);
> > > +
> > > +	return 0;  
> > No real point in returning int if you are always going to put 0 in
> > in it.  Should probably check the regmap_write though and output
> > a log message if it fails (as no other way of telling).
> >   
> > > +}
> > > +EXPORT_SYMBOL(rm3100_common_remove);
> > > +
> > > +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> > > +MODULE_DESCRIPTION("PNI RM3100 9-axis magnetometer i2c driver");
> > > +MODULE_LICENSE("GPL v2");
> > > diff --git a/drivers/iio/magnetometer/rm3100-i2c.c b/drivers/iio/magnetometer/rm3100-i2c.c
> > > new file mode 100644
> > > index 000000000000..b50dc5b1b30b
> > > --- /dev/null
> > > +++ b/drivers/iio/magnetometer/rm3100-i2c.c
> > > @@ -0,0 +1,66 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Support for PNI RM3100 9-axis geomagnetic sensor a i2c bus.
> > > + *
> > > + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> > > + *
> > > + * User Manual available at
> > > + * <https://www.pnicorp.com/download/rm3100-user-manual/>
> > > + *
> > > + * i2c slave address 0x20 + SA1 << 1 + SA0.
> > > + */
> > > +
> > > +#include <linux/i2c.h>
> > > +
> > > +#include "rm3100.h"
> > > +
> > > +static const struct regmap_config rm3100_regmap_config = {
> > > +		.reg_bits = 8,  
> > This indenting seems an extra tab on conventional choice...  
> > > +		.val_bits = 8,
> > > +
> > > +		.rd_table = &rm3100_readable_table,
> > > +		.wr_table = &rm3100_writable_table,
> > > +		.volatile_table = &rm3100_volatile_table,
> > > +
> > > +		.cache_type = REGCACHE_RBTREE,
> > > +};
> > > +
> > > +static int rm3100_probe(struct i2c_client *client)
> > > +{
> > > +	struct regmap *regmap;
> > > +
> > > +	if (!i2c_check_functionality(client->adapter,
> > > +		I2C_FUNC_SMBUS_READ_I2C_BLOCK | I2C_FUNC_SMBUS_BYTE_DATA))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	regmap =  devm_regmap_init_i2c(client, &rm3100_regmap_config);
> > > +	if (IS_ERR(regmap))
> > > +		return PTR_ERR(regmap);
> > > +
> > > +	return rm3100_common_probe(&client->dev, regmap, client->irq);
> > > +}
> > > +
> > > +static int rm3100_remove(struct i2c_client *client)
> > > +{
> > > +	return rm3100_common_remove(&client->dev);
> > > +}
> > > +
> > > +static const struct of_device_id rm3100_dt_match[] = {
> > > +	{ .compatible = "pni,rm3100-i2c", },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, rm3100_dt_match);
> > > +
> > > +static struct i2c_driver rm3100_driver = {
> > > +	.driver = {
> > > +		.name = "rm3100-i2c",
> > > +		.of_match_table = rm3100_dt_match,
> > > +	},
> > > +	.probe_new = rm3100_probe,
> > > +	.remove = rm3100_remove,
> > > +};
> > > +module_i2c_driver(rm3100_driver);
> > > +
> > > +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> > > +MODULE_DESCRIPTION("PNI RM3100 9-axis magnetometer i2c driver");
> > > +MODULE_LICENSE("GPL v2");
> > > diff --git a/drivers/iio/magnetometer/rm3100-spi.c b/drivers/iio/magnetometer/rm3100-spi.c
> > > new file mode 100644
> > > index 000000000000..2c7dd9e3a1a2
> > > --- /dev/null
> > > +++ b/drivers/iio/magnetometer/rm3100-spi.c
> > > @@ -0,0 +1,72 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Support for PNI RM3100 9-axis geomagnetic sensor a spi bus.
> > > + *
> > > + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> > > + *
> > > + * User Manual available at
> > > + * <https://www.pnicorp.com/download/rm3100-user-manual/>  
> > 
> > Probably only worth mentioning the manual in the main file.
> >   
> > > + */
> > > +
> > > +#include <linux/spi/spi.h>
> > > +
> > > +#include "rm3100.h"
> > > +
> > > +static const struct regmap_config rm3100_regmap_config = {
> > > +		.reg_bits = 8,
> > > +		.val_bits = 8,
> > > +
> > > +		.rd_table = &rm3100_readable_table,
> > > +		.wr_table = &rm3100_writable_table,
> > > +		.volatile_table = &rm3100_volatile_table,
> > > +
> > > +		.read_flag_mask = 0x80,
> > > +
> > > +		.cache_type = REGCACHE_RBTREE,
> > > +};
> > > +
> > > +static int rm3100_probe(struct spi_device *spi)
> > > +{
> > > +	struct regmap *regmap;
> > > +	int ret;
> > > +
> > > +	/* Actually this device supports both mode 0 and mode 3. */
> > > +	spi->mode = SPI_MODE_0;
> > > +	/* data rates cannot exceeds 1Mbits. */
> > > +	spi->max_speed_hz = 1000000;
> > > +	spi->bits_per_word = 8;
> > > +	ret = spi_setup(spi);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	regmap =  devm_regmap_init_spi(spi, &rm3100_regmap_config);
> > > +	if (IS_ERR(regmap))
> > > +		return PTR_ERR(regmap);
> > > +
> > > +	return rm3100_common_probe(&spi->dev, regmap, spi->irq);
> > > +}
> > > +
> > > +static int rm3100_remove(struct spi_device *spi)
> > > +{
> > > +	return rm3100_common_remove(&spi->dev);
> > > +}
> > > +
> > > +static const struct of_device_id rm3100_dt_match[] = {
> > > +	{ .compatible = "pni,rm3100-spi", },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, rm3100_dt_match);
> > > +
> > > +static struct spi_driver rm3100_driver = {
> > > +		.driver = {
> > > +				.name = "rm3100-spi",
> > > +				.of_match_table = rm3100_dt_match,  
> > 
> > Indenting looks oddly deep...
> >   
> > > +		},
> > > +		.probe = rm3100_probe,
> > > +		.remove = rm3100_remove,
> > > +};
> > > +module_spi_driver(rm3100_driver);
> > > +
> > > +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> > > +MODULE_DESCRIPTION("PNI RM3100 9-axis magnetometer spi driver");
> > > +MODULE_LICENSE("GPL v2");
> > > diff --git a/drivers/iio/magnetometer/rm3100.h b/drivers/iio/magnetometer/rm3100.h
> > > new file mode 100644
> > > index 000000000000..5e30bc0f5149
> > > --- /dev/null
> > > +++ b/drivers/iio/magnetometer/rm3100.h
> > > @@ -0,0 +1,90 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > +/*
> > > + * Header file for PNI RM3100 driver
> > > + *
> > > + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> > > + */
> > > +
> > > +#ifndef RM3100_CORE_H
> > > +#define RM3100_CORE_H
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>  
> > 
> > What in here needs module.h?  Push that down into the
> > individual c files.  It's repetition but it si generally
> > good practice to include headers at as low a level as possible.
> >   
> > > +
> > > +#define RM_REG_REV_ID		0x36  
> > I would prefer RM3100 as the prefix.  
> > > +
> > > +/* Cycle Count Registers MSBs and LSBs. */  
> > Could probably give these slightly more human readable names?
> > RM3100_REG_CC_X_MSB
> > 
> > Actually I doubt you use both of them in the driver anyway...
> > (just searched, nope you don't so drop the ones you don't
> >  use and then the MSB, LSB definition probably not necessary).
> >   
> > > +#define RM_REG_CCXM		0x04
> > > +#define RM_REG_CCXL		0x05
> > > +#define RM_REG_CCYM		0x06
> > > +#define RM_REG_CCYL		0x07
> > > +#define RM_REG_CCZM		0x08
> > > +#define RM_REG_CCZL		0x09
> > > +
> > > +/* Single Measurement Mode register. */
> > > +#define RM_REG_POLL		0x00
> > > +#define RM_POLL_PMX		BIT(4)
> > > +#define RM_POLL_PMY		BIT(5)
> > > +#define RM_POLL_PMZ		BIT(6)
> > > +
> > > +/* Continues Measurement Mode register. */
> > > +#define RM_REG_CMM		0x01
> > > +#define RM_CMM_START		BIT(0)
> > > +#define RM_CMM_DRDM		BIT(2)
> > > +#define RM_CMM_PMX		BIT(4)
> > > +#define RM_CMM_PMY		BIT(5)
> > > +#define RM_CMM_PMZ		BIT(6)
> > > +
> > > +/* TiMe Rate Configuration register. */
> > > +#define RM_REG_TMRC		0x0B
> > > +#define RM_TMRC_OFFSET		0x92
> > > +
> > > +/* Result Status register. */
> > > +#define RM_REG_STATUS		0x34
> > > +#define RM_STATUS_DRDY		BIT(7)
> > > +
> > > +/* Measurement result registers. */
> > > +#define RM_REG_MX2		0x24  
> > 
> > You only use some of these. Not sure having defines for the
> > others is really helpful.
> >   
> > > +#define RM_REG_MX1		0x25
> > > +#define RM_REG_MX0		0x26
> > > +#define RM_REG_MY2		0x27
> > > +#define RM_REG_MY1		0x28
> > > +#define RM_REG_MY0		0x29
> > > +#define RM_REG_MZ2		0x2a
> > > +#define RM_REG_MZ1		0x2b
> > > +#define RM_REG_MZ0		0x2c
> > > +
> > > +#define RM_REG_HSHAKE		0x35
> > > +
> > > +#define RM_W_REG_START		RM_REG_POLL
> > > +#define RM_W_REG_END		RM_REG_REV_ID
> > > +#define RM_R_REG_START		RM_REG_POLL
> > > +#define RM_R_REG_END		RM_REG_HSHAKE
> > > +#define RM_V_REG_START		RM_REG_MX2
> > > +#define RM_V_REG_END		RM_REG_HSHAKE
> > > +
> > > +/* Built-In Self Test reigister. */
> > > +#define RM_REG_BIST		0x33
> > > +
> > > +struct rm3100_data {
> > > +	struct device *dev;
> > > +	struct regmap *regmap;
> > > +	struct completion measuring_done;
> > > +	bool use_interrupt;
> > > +
> > > +	int conversion_time;
> > > +
> > > +	/* To protect consistency of every measurement and sampling  
> > 
> > /*
> >  * To protect
> >  */
> > (common format to most of the kernel other than those 'crazy' :)
> > people in net and a few other corners.
> >   
> > > +	 * frequency change operations.
> > > +	 */
> > > +	struct mutex lock;
> > > +};
> > > +
> > > +extern const struct regmap_access_table rm3100_readable_table;
> > > +extern const struct regmap_access_table rm3100_writable_table;
> > > +extern const struct regmap_access_table rm3100_volatile_table;
> > > +
> > > +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq);
> > > +int rm3100_common_remove(struct device *dev);
> > > +
> > > +#endif /* RM3100_CORE_H */  
> >   

