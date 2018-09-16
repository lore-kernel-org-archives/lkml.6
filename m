Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF79ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58238208DD
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7jA91z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58238208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeIPQY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 12:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbeIPQY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 12:24:28 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D75B4208AE;
        Sun, 16 Sep 2018 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537095714;
        bh=SuZAs1iu1JerlXZy5LFapeCq9WTVEe2PAU+/5NfiC7c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j7jA91z/pQK+wTSzrBQ1ON1ZGOkcbO0gf/VwK9EnBTr87NJJ6nZryWzh9cxlQ5br1
         BswRdVjIh4vJeDYmDa8ne/HdtrcZ4pKsz8HWF6H/KuATFlyRyRUB8airdKN+BA1uzF
         Kqy/k1u9KzcwHs6uapvz8uGIZhQgEGEPaQXJT0Mo=
Date:   Sun, 16 Sep 2018 12:01:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        tglx@linutronix.de, ak@it-klinger.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        himanshujha199640@gmail.com,
        Song Qiang <songqiang.1304521@gmail.com>
Subject: Re: [PATCH v5] iio: proximity: Add driver support for ST's VL53L0X
 ToF ranging sensor.
Message-ID: <20180916120149.0c68893f@archlinux>
In-Reply-To: <20180915095752.8116-1-songqiang.1304521@gmail.com>
References: <20180915095752.8116-1-songqiang.1304521@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Sep 2018 17:57:52 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> This driver was originally written by ST in 2016 as a misc input device
> driver, and hasn't been maintained for a long time. I grabbed some code
> from it's API and reformed it into an iio proximity device driver.
> This version of driver uses i2c bus to talk to the sensor and
> polling for measuring completes, so no irq line is needed.
> This version of driver supports only one-shot mode, and it can be
> tested with reading from
> /sys/bus/iio/devices/iio:deviceX/in_distance_raw
> 
> Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
Hi Song,

My first comment was going to be don't use wild cards in a part name
in a driver, but a quick sanity check confirmed that ST were actually
crazy enough to end a part number with an X.  Ah well ;)

Otherwise a few minor things, mostly around naming.  There is some
confusion around endian stuff as well

Looks pretty good for a first go at upstreaming a driver!

Are you planning on adding more features?  Seems like a capable little device
and would be good to have fuller support in the long term if you have time
to look at it!

Jonathan

> ---
> Changes in v5:
> 	- Correct some spell problems.
> 	- Change tries-- to --tries to fix the count error.
> 	- Add MODULE_DEVICE_TABLE().
> 	- Add some comments.
> 
> Changes in v4:
> 	- Add datasheet link, default i2c address and TODO list.
> 	- Make capitalization of defines consistent.
> 	- Replace i2c_transfer() with i2c_smbus_read_i2c_block_data().
> 	- Remove IIO_CHAN_SOFT_TIMESTAMP() since no buffer/trigger
> 	  support.
> 	- Add information to MAINTAINERS.
> 
> Changes in v3:
> 	- Recover ST's copyright.
> 	- Clean up indio_dev member in vl53l0x_data struct since it's
> 	  useless now.
> 	- Replace __le16_to_cpu() with le16_to_cpu().
> 	- Remove the iio_device_{claim|release}_direct_mode() since it's
> 	  only needed when we use buffered mode.
> 	- Clean up some coding style problems.
> 
> Changes in v2:
> 	- Clean up the register table.
> 	- Sort header files declarations.
> 	- Replace some bit definations with GENMASK() and BIT().
> 	- Clean up some code and comments that's useless for now.
> 	- Change the order of some the definations of some variables to reversed
> 	  xmas tree order.
> 	- Using do...while() rather while and check.
> 	- Replace pr_err() with dev_err().
> 	- Remove device id declaration since we recommend to use DT.
> 	- Remove .owner = THIS_MODULE.
> 	- Replace probe() with probe_new() hook.
> 	- Remove IIO_BUFFER and IIO_TRIGGERED_BUFFER dependences.
> 	- Change the driver module name to vl53l0x-i2c.
> 	- Align all the parameters if they are in the same function with open
> 	  parentheses.
> 	- Replace iio_device_register() with devm_iio_device_register
> 	  for better resource management.
> 	- Remove the vl53l0x_remove() since it's not needed.
> 	- Remove dev_set_drvdata() since it's already setted above.
> 
>  .../bindings/iio/proximity/vl53l0x.txt        |  12 ++
>  MAINTAINERS                                   |   7 +
>  drivers/iio/proximity/Kconfig                 |  11 ++
>  drivers/iio/proximity/Makefile                |   2 +
>  drivers/iio/proximity/vl53l0x-i2c.c           | 180 ++++++++++++++++++
>  5 files changed, 212 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
>  create mode 100644 drivers/iio/proximity/vl53l0x-i2c.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> new file mode 100644
> index 000000000000..ab9a9539fec4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> @@ -0,0 +1,12 @@
> +ST VL53L0X ToF ranging sensor
> +
> +Required properties:
> +	- compatible: must be "st,vl53l0x-i2c"
> +	- reg: i2c address where to find the device
> +
> +Example:
> +
> +vl53l0x@29 {
> +	compatible = "st,vl53l0x-i2c";
> +	reg = <0x29>;
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 967ce8cdd1cc..a35d80e63506 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13510,6 +13510,13 @@ L:	linux-i2c@vger.kernel.org
>  S:	Maintained
>  F:	drivers/i2c/busses/i2c-stm32*
>  
> +ST VL53L0X ToF RANGER(I2C) IIO DRIVER
> +M:	Song Qiang <songqiang.1304521@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/proximity/vl53l0x-i2c.c
> +F:	Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> +
>  STABLE BRANCH
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  L:	stable@vger.kernel.org
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index f726f9427602..5f421cbd37f3 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -79,4 +79,15 @@ config SRF08
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called srf08.
>  
> +config VL53L0X_I2C
> +	tristate "STMicroelectronics VL53L0X ToF ranger sensor (I2C)"
> +	depends on I2C
> +	help
> +	  Say Y here to build a driver for STMicroelectronics VL53L0X
> +	  ToF ranger sensors with i2c interface.
> +	  This driver can be used to measure the distance of objects.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called vl53l0x-i2c.
> +
>  endmenu
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index 4f4ed45e87ef..dedfb5bf3475 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -10,3 +10,5 @@ obj-$(CONFIG_RFD77402)		+= rfd77402.o
>  obj-$(CONFIG_SRF04)		+= srf04.o
>  obj-$(CONFIG_SRF08)		+= srf08.o
>  obj-$(CONFIG_SX9500)		+= sx9500.o
> +obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
> +
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> new file mode 100644
> index 000000000000..4837cc2fff19
> --- /dev/null
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Support for ST VL53L0X FlightSense ToF Ranging Sensor on a i2c bus.
> + *
> + * Copyright (C) 2016 STMicroelectronics Imaging Division.
> + * Copyright (C) 2018 Song Qiang <songqiang.1304521@gmail.com>
> + *
> + * Datasheet available at
> + * <https://www.st.com/resource/en/datasheet/vl53l0x.pdf>
> + *
> + * Default 7-bit i2c slave address 0x29.
> + *
> + * TODO: FIFO buffer, continuous mode, interrupts, range selection,
> + * sensor ID check.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define VL53L0X_DRV_NAME				"vl53l0x-i2c"

A quick google suggests this only has an i2c interface.  Hence I'd argue
there is no point in having -i2c in the driver name.  Lots of other
i2c only parts don't on the basis it doesn't add anything.  In fact
the only time we tend to do this is if we have a driver that splits
into a shared core and two or more bus specific drivers.

> +
> +#define VL_REG_SYSRANGE_START				0x00
> +
> +#define VL_REG_SYSRANGE_MODE_MASK			GENMASK(3, 0)
> +#define VL_REG_SYSRANGE_MODE_SINGLESHOT			0x00
> +#define VL_REG_SYSRANGE_MODE_START_STOP			BIT(0)
> +#define VL_REG_SYSRANGE_MODE_BACKTOBACK			BIT(1)
> +#define VL_REG_SYSRANGE_MODE_TIMED			BIT(2)
> +#define VL_REG_SYSRANGE_MODE_HISTOGRAM			BIT(3)
> +
> +#define VL_REG_SYS_SEQUENCE_CFG				BIT(0)
> +#define VL_REG_SYS_INTERMEASUREMENT_PERIOD		BIT(2)
> +#define VL_REG_SYS_RANGE_CFG				0x09
> +#define VL_REG_SYS_INT_GPIO_DISABLED			0x00
> +#define VL_REG_SYS_INT_GPIO_LEVEL_LOW			BIT(0)
> +#define VL_REG_SYS_INT_GPIO_LEVEL_HIGH			BIT(1)
> +#define VL_REG_SYS_INT_GPIO_OUT_OF_WINDOW		0x03
> +#define VL_REG_SYS_INT_GPIO_NEW_SAMPLE_READY		BIT(2)
> +#define VL_REG_SYS_INT_CFG_GPIO				0x0A
> +#define VL_REG_SYS_INT_CLEAR				0x0B
> +#define VL_REG_GPIO_HV_MUX_ACTIVE_HIGH			0x84
> +
> +#define VL_REG_RESULT_INT_STATUS			0x13
> +#define VL_REG_RESULT_RANGE_STATUS			0x14
> +#define VL_REG_RESULT_RANGE_STATUS_COMPLETE		BIT(0)
> +
> +/* Check contents of these registers to verify the device. */
> +#define VL_REG_IDENTIFICATION_MODEL_ID			0xC0
> +#define VL_REG_IDENTIFICATION_REVISION_ID		0xC2
> +
> +struct vl53l0x_data {
> +	struct i2c_client *client;
> +};
> +
> +static int vl53l0x_read_proximity(struct vl53l0x_data *data,
> +				  const struct iio_chan_spec *chan,
> +				  int *val)
> +{
> +	struct i2c_client *client = data->client;
> +	unsigned int tries = 20;
> +	u8 buffer[12];
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client,
> +		VL_REG_SYSRANGE_START, 1);

Looks like the above would fit on one line.  Please do a quick check
through the driver for other cases of this.

> +	if (ret < 0)
> +		return ret;
> +
> +	do {
> +		ret = i2c_smbus_read_byte_data(client,
> +			VL_REG_RESULT_RANGE_STATUS);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret & VL_REG_RESULT_RANGE_STATUS_COMPLETE)
> +			break;
> +
> +		usleep_range(1000, 5000);
> +	} while (--tries);
> +	if (!tries)
> +		return -ETIMEDOUT;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, VL_REG_RESULT_RANGE_STATUS,
> +		12, buffer);
> +	if (ret < 0)
> +		return ret;
> +	else if (ret != 12)
> +		return -EREMOTEIO;
> +
> +	/* Values should be between 30~1200. */
> +	*val = le16_to_cpu((buffer[10] << 8) + buffer[11]);
This worries me as a conversion.  The shift and addition is
unwinding the endianness already. You then do it again with le16_to_cpu

As it's aligned you could have done
*val = le16_to_cpu(*(le16 *)(&buffer[10]));  That's obviously
a bit ugly though, mainly because we are handling the buffer as
a u8.  Is there a reason to not directly handle it as an le16 array?

I'm having trouble finding the relevant section of the manual to actually
figure out what is in the first 10 bytes!



> +
> +	return 0;
> +}
> +
> +static const struct iio_chan_spec vl53l0x_channels[] = {
> +	{
> +		.type = IIO_DISTANCE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),

This is a time of flight sensor?  As such I would kind of assume it is possible
to get to a real world distance?  Adding scale and offset to do this can
of course be a follow up patch,  but it would be good to have!

> +	},
> +};
> +
> +static int vl53l0x_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct vl53l0x_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type != IIO_DISTANCE) {
> +		dev_err(&data->client->dev, "iio type error");

This can't actually happen as there are no other channel types
registered.   The if check is really a form of documentation rather
than real protection.   As such I'd drop the dev_err print
out as unnecessary noise.  A simple return -EINVAL is more than
enough here.

> +		return -EINVAL;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = vl53l0x_read_proximity(data, chan, val);
> +		if (ret < 0)
> +			dev_err(&data->client->dev,
> +				"raw value read error with %d", ret);

If return is less than 0 you should be passing that on to userspace
(so add a return ret in this if block.)

> +
> +		return IIO_VAL_INT;
> +	default:
> +		dev_err(&data->client->dev, "IIO_CHAN_* not recognized.");
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info vl53l0x_info = {
> +	.read_raw = vl53l0x_read_raw,
> +};
> +
> +static int vl53l0x_probe(struct i2c_client *client)
> +{
> +	struct vl53l0x_data *data;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	if (!i2c_check_functionality(client->adapter,
> +		I2C_FUNC_SMBUS_READ_I2C_BLOCK | I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = VL53L0X_DRV_NAME;
> +	indio_dev->info = &vl53l0x_info;
> +	indio_dev->channels = vl53l0x_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(vl53l0x_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct of_device_id st_vl53l0x_dt_match[] = {
> +	{ .compatible = "st,vl53l0x-i2c", },

Compatible shouldn't need the -i2c as it will only check for
i2c devices if they are on an i2c bus anyway.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, st_vl53l0x_dt_match);
> +
> +static struct i2c_driver vl53l0x_driver = {
> +	.driver = {
> +		.name = VL53L0X_DRV_NAME,
> +		.of_match_table = st_vl53l0x_dt_match,
> +	},
> +	.probe_new = vl53l0x_probe,
> +};
> +module_i2c_driver(vl53l0x_driver);
> +
> +MODULE_AUTHOR("Song Qiang <songqiang.1304521@gmail.com>");
> +MODULE_DESCRIPTION("ST vl53l0x ToF ranging sensor driver");
> +MODULE_LICENSE("GPL v2");

