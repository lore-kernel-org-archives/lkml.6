Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932489AbeCJQPT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 11:15:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932329AbeCJQPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 11:15:17 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1AD2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 16:15:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: potentiometer: mcp4018: driver for Microchip
 digital potentiometers
Message-ID: <20180310161511.66d2ef97@archlinux>
In-Reply-To: <20180308195830.16348-3-peda@axentia.se>
References: <20180308195830.16348-1-peda@axentia.se>
        <20180308195830.16348-3-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Mar 2018 20:58:30 +0100
Peter Rosin <peda@axentia.se> wrote:

> Add support for Microchip digital potentiometers and rheostats
> 	MCP4017, MCP4018, MCP4019
> 
> They all have one wiper with 128 steps and come in 5, 10, 50 and 100 kOhm
> variations.
> 
> Datasheet: http://www.microchip.com/downloads/en/DeviceDoc/22147a.pdf
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Nice little driver.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  MAINTAINERS                         |   3 +-
>  drivers/iio/potentiometer/Kconfig   |  11 ++
>  drivers/iio/potentiometer/Makefile  |   1 +
>  drivers/iio/potentiometer/mcp4018.c | 194 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 208 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/potentiometer/mcp4018.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4623caf8d72d..81527c75adee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8589,11 +8589,12 @@ W:	https://linuxtv.org
>  S:	Maintained
>  F:	drivers/media/radio/radio-maxiradio*
>  
> -MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVER
> +MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
>  M:	Peter Rosin <peda@axentia.se>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
> +F:	drivers/iio/potentiometer/mcp4018.c
>  F:	drivers/iio/potentiometer/mcp4531.c
>  
>  MEASUREMENT COMPUTING CIO-DAC IIO DRIVER
> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> index 8bf282510be6..84bdbcd53114 100644
> --- a/drivers/iio/potentiometer/Kconfig
> +++ b/drivers/iio/potentiometer/Kconfig
> @@ -37,6 +37,17 @@ config MAX5487
>            To compile this driver as a module, choose M here: the
>            module will be called max5487.
>  
> +config MCP4018
> +	tristate "Microchip MCP4017/18/19 Digital Potentiometer driver"
> +	depends on I2Cs
> +	help
> +	  Say yes here to build support for the Microchip
> +	  MCP4017, MCP4018, MCP4019
> +	  digital potentiometer chips.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mcp4018.
> +
>  config MCP4131
>  	tristate "Microchip MCP413X/414X/415X/416X/423X/424X/425X/426X Digital Potentiometer driver"
>  	depends on SPI
> diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
> index 1afd1e70f8cc..0cff8a2916d5 100644
> --- a/drivers/iio/potentiometer/Makefile
> +++ b/drivers/iio/potentiometer/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_DS1803) += ds1803.o
>  obj-$(CONFIG_MAX5481) += max5481.o
>  obj-$(CONFIG_MAX5487) += max5487.o
> +obj-$(CONFIG_MCP4018) += mcp4018.o
>  obj-$(CONFIG_MCP4131) += mcp4131.o
>  obj-$(CONFIG_MCP4531) += mcp4531.o
>  obj-$(CONFIG_TPL0102) += tpl0102.o
> diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
> new file mode 100644
> index 000000000000..601b25d1f387
> --- /dev/null
> +++ b/drivers/iio/potentiometer/mcp4018.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Industrial I/O driver for Microchip digital potentiometers
> + * Copyright (c) 2018  Axentia Technologies AB
> + * Author: Peter Rosin <peda@axentia.se>
> + *
> + * Datasheet: http://www.microchip.com/downloads/en/DeviceDoc/22147a.pdf
> + *
> + * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)
> + * mcp4017	1	128		5, 10, 50, 100
> + * mcp4018	1	128		5, 10, 50, 100
> + * mcp4019	1	128		5, 10, 50, 100
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +#define MCP4018_WIPER_MAX 127
> +
> +struct mcp4018_cfg {
> +	int kohms;
> +};
> +
> +enum mcp4018_type {
> +	MCP4018_502,
> +	MCP4018_103,
> +	MCP4018_503,
> +	MCP4018_104,
> +};
> +
> +static const struct mcp4018_cfg mcp4018_cfg[] = {
> +	[MCP4018_502] = { .kohms =   5, },
> +	[MCP4018_103] = { .kohms =  10, },
> +	[MCP4018_503] = { .kohms =  50, },
> +	[MCP4018_104] = { .kohms = 100, },
> +};
> +
> +struct mcp4018_data {
> +	struct i2c_client *client;
> +	const struct mcp4018_cfg *cfg;
> +};
> +
> +static const struct iio_chan_spec mcp4018_channel = {
> +	.type = IIO_RESISTANCE,
> +	.indexed = 1,
> +	.output = 1,
> +	.channel = 0,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +};
> +
> +static int mcp4018_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct mcp4018_data *data = iio_priv(indio_dev);
> +	s32 ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = i2c_smbus_read_byte(data->client);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1000 * data->cfg->kohms;
> +		*val2 = MCP4018_WIPER_MAX;
> +		return IIO_VAL_FRACTIONAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int mcp4018_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct mcp4018_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val > MCP4018_WIPER_MAX || val < 0)
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return i2c_smbus_write_byte(data->client, val);
> +}
> +
> +static const struct iio_info mcp4018_info = {
> +	.read_raw = mcp4018_read_raw,
> +	.write_raw = mcp4018_write_raw,
> +};
> +
> +#ifdef CONFIG_OF
> +
> +#define MCP4018_COMPATIBLE(of_compatible, cfg) {	\
> +	.compatible = of_compatible,			\
> +	.data = &mcp4018_cfg[cfg],			\
> +}
> +
> +static const struct of_device_id mcp4018_of_match[] = {
> +	MCP4018_COMPATIBLE("microchip,mcp4017-502", MCP4018_502),
> +	MCP4018_COMPATIBLE("microchip,mcp4017-103", MCP4018_103),
> +	MCP4018_COMPATIBLE("microchip,mcp4017-503", MCP4018_503),
> +	MCP4018_COMPATIBLE("microchip,mcp4017-104", MCP4018_104),
> +	MCP4018_COMPATIBLE("microchip,mcp4018-502", MCP4018_502),
> +	MCP4018_COMPATIBLE("microchip,mcp4018-103", MCP4018_103),
> +	MCP4018_COMPATIBLE("microchip,mcp4018-503", MCP4018_503),
> +	MCP4018_COMPATIBLE("microchip,mcp4018-104", MCP4018_104),
> +	MCP4018_COMPATIBLE("microchip,mcp4019-502", MCP4018_502),
> +	MCP4018_COMPATIBLE("microchip,mcp4019-103", MCP4018_103),
> +	MCP4018_COMPATIBLE("microchip,mcp4019-503", MCP4018_503),
> +	MCP4018_COMPATIBLE("microchip,mcp4019-104", MCP4018_104),
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mcp4018_of_match);
> +
> +#endif
> +
> +static int mcp4018_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct mcp4018_data *data;
> +	struct iio_dev *indio_dev;
> +	const struct of_device_id *match;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_BYTE)) {
> +		dev_err(dev, "SMBUS Byte transfers not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	match = of_match_device(of_match_ptr(mcp4018_of_match), dev);
> +	if (match)
> +		data->cfg = of_device_get_match_data(dev);
> +	else
> +		data->cfg = &mcp4018_cfg[id->driver_data];
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &mcp4018_info;
> +	indio_dev->channels = &mcp4018_channel;
> +	indio_dev->num_channels = 1;
> +	indio_dev->name = client->name;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id mcp4018_id[] = {
> +	{ "mcp4017-502", MCP4018_502 },
> +	{ "mcp4017-103", MCP4018_103 },
> +	{ "mcp4017-503", MCP4018_503 },
> +	{ "mcp4017-104", MCP4018_104 },
> +	{ "mcp4018-502", MCP4018_502 },
> +	{ "mcp4018-103", MCP4018_103 },
> +	{ "mcp4018-503", MCP4018_503 },
> +	{ "mcp4018-104", MCP4018_104 },
> +	{ "mcp4019-502", MCP4018_502 },
> +	{ "mcp4019-103", MCP4018_103 },
> +	{ "mcp4019-503", MCP4018_503 },
> +	{ "mcp4019-104", MCP4018_104 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, mcp4018_id);
> +
> +static struct i2c_driver mcp4018_driver = {
> +	.driver = {
> +		.name	= "mcp4018",
> +		.of_match_table = of_match_ptr(mcp4018_of_match),
> +	},
> +	.probe		= mcp4018_probe,
> +	.id_table	= mcp4018_id,
> +};
> +
> +module_i2c_driver(mcp4018_driver);
> +
> +MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
> +MODULE_DESCRIPTION("MCP4018 digital potentiometer");
> +MODULE_LICENSE("GPL");
