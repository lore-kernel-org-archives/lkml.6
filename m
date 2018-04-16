Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754671AbeDPJul (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:50:41 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:37904 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754450AbeDPJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:50:37 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Subject: Re: [PATCH v9 3/9] mfd: madera: Add common support for Cirrus Logic
 Madera codecs
To: Lee Jones <lee.jones@linaro.org>
CC: <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <robh+dt@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180313131904.13700-1-rf@opensource.cirrus.com>
 <20180313131904.13700-4-rf@opensource.cirrus.com>
 <20180328090039.ooyi3tf64uqpntx6@dell>
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <8abd9e13-dde6-9eba-83cc-cfd1dfee6149@opensource.cirrus.com>
Date: Mon, 16 Apr 2018 10:50:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328090039.ooyi3tf64uqpntx6@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804160092
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/18 10:00, Lee Jones wrote:
> On Tue, 13 Mar 2018, Richard Fitzgerald wrote:
> 
>> This adds the generic core support for Cirrus Logic "Madera" class codecs.
>> These are complex audio codec SoCs with a variety of digital and analogue
>> I/O, onboard audio processing and DSPs, and other features.
>>
>> These codecs are all based off a common set of hardware IP so can be
>> supported by a core of common code (with a few minor device-to-device
>> variations).
>>
>> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>> Signed-off-by: Nikesh Oswal <Nikesh.Oswal@cirrus.com>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>> There have been various smallish changes since Lee acked this patch so I have
>> decided to err on the side of caution and remove the Ack in case Lee might have
>> some comments about the current state of the code.
>>
>> Cumulative changes since Lee acked it:
>> - changed to use gpiod for all reset code - affects madera_[enable|disable]_hard_reset,
>>    madera_get_reset_gpio, madera_dev_init
>> - use of_device_get_match_data in the spi and i2c probes
>> - use __maybe_unused on the pm runtime functions instead of a #ifdef
>> - don't put comma after {} list terminators
>> - commented why we don't use the devm version of mfd_add_devices
>> - don't use regulator_get_exclusive, it fails in the legitimate case of having the same
>>    regulator supply multiple chip supplies
>> - the core driver can now be built as a module
>> - minor Kconfig change to make the SPI/I2C submodules depend on the core module
>>      as this gives a more user-friendly menuconfig
>> - changed the irqchip and codec pdata to be a pointer to remove the build dependency
>>      so we can submit this patch without the irqchip and codec driver patches
>> - SPDX license headers
>> ---
>>   MAINTAINERS                      |   3 +
>>   drivers/mfd/Kconfig              |  29 ++
>>   drivers/mfd/Makefile             |   5 +
>>   drivers/mfd/madera-core.c        | 600 +++++++++++++++++++++++++++++++++++++++
>>   drivers/mfd/madera-i2c.c         | 139 +++++++++
>>   drivers/mfd/madera-spi.c         | 138 +++++++++
>>   drivers/mfd/madera.h             |  44 +++
>>   include/linux/mfd/madera/core.h  | 187 ++++++++++++
>>   include/linux/mfd/madera/pdata.h |  63 ++++
>>   9 files changed, 1208 insertions(+)
>>   create mode 100644 drivers/mfd/madera-core.c
>>   create mode 100644 drivers/mfd/madera-i2c.c
>>   create mode 100644 drivers/mfd/madera-spi.c
>>   create mode 100644 drivers/mfd/madera.h
>>   create mode 100644 include/linux/mfd/madera/core.h
>>   create mode 100644 include/linux/mfd/madera/pdata.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 40d78683a53f..f7ea1a47496c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3498,7 +3498,10 @@ L:	patches@opensource.cirrus.com
>>   T:	git https://github.com/CirrusLogic/linux-drivers.git
>>   W:	https://github.com/CirrusLogic/linux-drivers/wiki
>>   S:	Supported
>> +F:	Documentation/devicetree/bindings/mfd/madera.txt
>>   F:	include/linux/mfd/madera/*
>> +F:	drivers/mfd/madera*
>> +F:	drivers/mfd/cs47l*
>>   
>>   CLEANCACHE API
>>   M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index b860eb5aa194..f5ca392f8bc2 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -232,6 +232,35 @@ config MFD_CROS_EC_CHARDEV
>>             If you have a supported Chromebook, choose Y or M here.
>>             The module will be called cros_ec_dev.
>>   
>> +config MFD_MADERA
>> +	tristate "Cirrus Logic Madera codecs"
>> +	select MFD_CORE
>> +	select REGMAP
>> +	select REGMAP_IRQ
>> +	select MADERA_IRQ
>> +	select PINCTRL
>> +	select PINCTRL_MADERA
>> +	help
>> +	  Support for the Cirrus Logic Madera platform audio codecs
>> +
>> +config MFD_MADERA_I2C
>> +	tristate "Cirrus Logic Madera codecs with I2C"
>> +	depends on MFD_MADERA
>> +	depends on I2C
>> +	select REGMAP_I2C
>> +	help
>> +	  Support for the Cirrus Logic Madera platform audio SoC
>> +	  core functionality controlled via I2C.
>> +
>> +config MFD_MADERA_SPI
>> +	tristate "Cirrus Logic Madera codecs with SPI"
>> +	depends on MFD_MADERA
>> +	depends on SPI_MASTER
>> +	select REGMAP_SPI
>> +	help
>> +	  Support for the Cirrus Logic Madera platform audio SoC
>> +	  core functionality controlled via SPI.
>> +
>>   config MFD_ASIC3
>>   	bool "Compaq ASIC3"
>>   	depends on GPIOLIB && ARM
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index e9fd20dba18d..db9ee6d24d91 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -72,6 +72,11 @@ wm8994-objs			:= wm8994-core.o wm8994-irq.o wm8994-regmap.o
>>   obj-$(CONFIG_MFD_WM8994)	+= wm8994.o
>>   obj-$(CONFIG_MFD_WM97xx)	+= wm97xx-core.o
>>   
>> +madera-objs			:= madera-core.o
>> +obj-$(CONFIG_MFD_MADERA)	+= madera.o
>> +obj-$(CONFIG_MFD_MADERA_I2C)	+= madera-i2c.o
>> +obj-$(CONFIG_MFD_MADERA_SPI)	+= madera-spi.o
>> +
>>   obj-$(CONFIG_TPS6105X)		+= tps6105x.o
>>   obj-$(CONFIG_TPS65010)		+= tps65010.o
>>   obj-$(CONFIG_TPS6507X)		+= tps6507x.o
>> diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
>> new file mode 100644
>> index 000000000000..fde4aae41608
>> --- /dev/null
>> +++ b/drivers/mfd/madera-core.c
>> @@ -0,0 +1,600 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Core MFD support for Cirrus Logic Madera codecs
>> + *
>> + * Copyright (C) 2015-2018 Cirrus Logic
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by the
>> + * Free Software Foundation; version 2.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/gpio.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/module.h>
>> +#include <linux/notifier.h>
>> +#include <linux/of.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/regulator/machine.h>
>> +#include <linux/regulator/of_regulator.h>
>> +
>> +#include <linux/mfd/madera/core.h>
>> +#include <linux/mfd/madera/registers.h>
>> +
>> +#include "madera.h"
>> +
>> +#define CS47L35_SILICON_ID	0x6360
>> +#define CS47L85_SILICON_ID	0x6338
>> +#define CS47L90_SILICON_ID	0x6364
>> +
>> +#define MADERA_32KZ_MCLK2	1
>> +
>> +static const char * const madera_core_supplies[] = {
>> +	"AVDD",
>> +	"DBVDD1",
>> +};
>> +
>> +static const struct mfd_cell madera_ldo1_devs[] = {
>> +	{ .name = "madera-ldo1" },
>> +};
>> +
>> +static const char * const cs47l35_supplies[] = {
>> +	"MICVDD",
>> +	"DBVDD2",
>> +	"CPVDD1",
>> +	"CPVDD2",
>> +	"SPKVDD",
>> +};
>> +
>> +static const struct mfd_cell cs47l35_devs[] = {
>> +	{ .name = "madera-pinctrl", },
>> +	{ .name = "madera-irq", },
>> +	{ .name = "madera-micsupp", },
>> +	{ .name = "madera-gpio", },
>> +	{ .name = "madera-extcon", },
>> +	{
>> +		.name = "cs47l35-codec",
>> +		.parent_supplies = cs47l35_supplies,
>> +		.num_parent_supplies = ARRAY_SIZE(cs47l35_supplies),
>> +	},
>> +};
>> +
>> +static const char * const cs47l85_supplies[] = {
>> +	"MICVDD",
>> +	"DBVDD2",
>> +	"DBVDD3",
>> +	"DBVDD4",
>> +	"CPVDD1",
>> +	"CPVDD2",
>> +	"SPKVDDL",
>> +	"SPKVDDR",
>> +};
>> +
>> +static const struct mfd_cell cs47l85_devs[] = {
>> +	{ .name = "madera-pinctrl", },
>> +	{ .name = "madera-irq", },
>> +	{ .name = "madera-micsupp" },
>> +	{ .name = "madera-gpio", },
>> +	{ .name = "madera-extcon", },
>> +	{
>> +		.name = "cs47l85-codec",
>> +		.parent_supplies = cs47l85_supplies,
>> +		.num_parent_supplies = ARRAY_SIZE(cs47l85_supplies),
>> +	},
>> +};
>> +
>> +static const char * const cs47l90_supplies[] = {
>> +	"MICVDD",
>> +	"DBVDD2",
>> +	"DBVDD3",
>> +	"DBVDD4",
>> +	"CPVDD1",
>> +	"CPVDD2",
>> +};
>> +
>> +static const struct mfd_cell cs47l90_devs[] = {
>> +	{ .name = "madera-pinctrl", },
>> +	{ .name = "madera-irq", },
>> +	{ .name = "madera-micsupp", },
>> +	{ .name = "madera-gpio", },
>> +	{ .name = "madera-extcon", },
>> +	{
>> +		.name = "cs47l90-codec",
>> +		.parent_supplies = cs47l90_supplies,
>> +		.num_parent_supplies = ARRAY_SIZE(cs47l90_supplies),
>> +	},
>> +};
>> +
>> +/* Used by madera-i2c and madera-spi drivers */
>> +const char *madera_name_from_type(enum madera_type type)
>> +{
>> +	switch (type) {
>> +	case CS47L35:
>> +		return "CS47L35";
>> +	case CS47L85:
>> +		return "CS47L85";
>> +	case CS47L90:
>> +		return "CS47L90";
>> +	case CS47L91:
>> +		return "CS47L91";
>> +	case WM1840:
>> +		return "WM1840";
>> +	default:
>> +		return "Unknown";
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(madera_name_from_type);
>> +
>> +#define MADERA_BOOT_POLL_MAX_INTERVAL_US  5000
>> +#define MADERA_BOOT_POLL_TIMEOUT_US	 25000
>> +
>> +static int madera_wait_for_boot(struct madera *madera)
>> +{
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	/*
>> +	 * We can't use an interrupt as we need to runtime resume to do so,
>> +	 * so we poll the status bit. This won't race with the interrupt
>> +	 * handler because it will be blocked on runtime resume.
>> +	 */
>> +	ret = regmap_read_poll_timeout(madera->regmap,
>> +				       MADERA_IRQ1_RAW_STATUS_1,
>> +				       val,
>> +				       (val & MADERA_BOOT_DONE_STS1),
>> +				       MADERA_BOOT_POLL_MAX_INTERVAL_US,
>> +				       MADERA_BOOT_POLL_TIMEOUT_US);
>> +
>> +	if (ret)
>> +		dev_err(madera->dev, "Polling BOOT_DONE_STS failed: %d\n", ret);
>> +
>> +	/*
>> +	 * BOOT_DONE defaults to unmasked on boot so we must ack it.
>> +	 * Do this unconditionally to avoid interrupt storms
> 
> Nit: Missing full stop
> 
>> +	 */
>> +	regmap_write(madera->regmap, MADERA_IRQ1_STATUS_1,
>> +		     MADERA_BOOT_DONE_EINT1);
>> +
>> +	pm_runtime_mark_last_busy(madera->dev);
>> +
>> +	return ret;
>> +}
>> +
>> +static int madera_soft_reset(struct madera *madera)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_write(madera->regmap, MADERA_SOFTWARE_RESET, 0);
>> +	if (ret != 0) {
>> +		dev_err(madera->dev, "Failed to soft reset device: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Allow time for internal clocks to startup after reset */
>> +	usleep_range(1000, 2000);
>> +
>> +	return 0;
>> +}
>> +
>> +static void madera_enable_hard_reset(struct madera *madera)
>> +{
>> +	if (!madera->pdata.reset)
>> +		return;
>> +
>> +	/*
>> +	 * there are many existing out-of-tree users of these codecs that we
> 
> Nit: There
> 
>> +	 * can't break so preserve the expected behaviour of setting the line
>> +	 * low to assert reset
>> +	 */
>> +	gpiod_set_raw_value_cansleep(madera->pdata.reset, 0);
>> +}
>> +
>> +static void madera_disable_hard_reset(struct madera *madera)
>> +{
>> +	if (!madera->pdata.reset)
>> +		return;
>> +
>> +	gpiod_set_raw_value_cansleep(madera->pdata.reset, 1);
>> +	usleep_range(1000, 2000);
>> +}
>> +
>> +static int __maybe_unused madera_runtime_resume(struct device *dev)
>> +{
>> +	struct madera *madera = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	dev_dbg(dev, "Leaving sleep mode\n");
>> +
>> +	ret = regulator_enable(madera->dcvdd);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable DCVDD: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	regcache_cache_only(madera->regmap, false);
>> +	regcache_cache_only(madera->regmap_32bit, false);
>> +
>> +	ret = madera_wait_for_boot(madera);
>> +	if (ret)
>> +		goto err;
>> +
>> +	ret = regcache_sync(madera->regmap);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to restore 16-bit register cache\n");
>> +		goto err;
>> +	}
>> +
>> +	ret = regcache_sync(madera->regmap_32bit);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to restore 32-bit register cache\n");
>> +		goto err;
>> +	}
>> +
>> +	return 0;
>> +
>> +err:
>> +	regcache_cache_only(madera->regmap_32bit, true);
>> +	regcache_cache_only(madera->regmap, true);
>> +	regulator_disable(madera->dcvdd);
>> +
>> +	return ret;
>> +}
>> +
>> +static int __maybe_unused madera_runtime_suspend(struct device *dev)
>> +{
>> +	struct madera *madera = dev_get_drvdata(dev);
>> +
>> +	dev_dbg(madera->dev, "Entering sleep mode\n");
>> +
>> +	regcache_cache_only(madera->regmap, true);
>> +	regcache_mark_dirty(madera->regmap);
>> +	regcache_cache_only(madera->regmap_32bit, true);
>> +	regcache_mark_dirty(madera->regmap_32bit);
>> +
>> +	regulator_disable(madera->dcvdd);
>> +
>> +	return 0;
>> +}
>> +
>> +const struct dev_pm_ops madera_pm_ops = {
>> +	SET_RUNTIME_PM_OPS(madera_runtime_suspend,
>> +			   madera_runtime_resume,
>> +			   NULL)
>> +};
>> +EXPORT_SYMBOL_GPL(madera_pm_ops);
>> +
>> +const struct of_device_id madera_of_match[] = {
>> +	{ .compatible = "cirrus,cs47l35", .data = (void *)CS47L35 },
>> +	{ .compatible = "cirrus,cs47l85", .data = (void *)CS47L85 },
>> +	{ .compatible = "cirrus,cs47l90", .data = (void *)CS47L90 },
>> +	{ .compatible = "cirrus,cs47l91", .data = (void *)CS47L91 },
>> +	{ .compatible = "cirrus,wm1840", .data = (void *)WM1840 },
>> +	{}
>> +};
>> +EXPORT_SYMBOL_GPL(madera_of_match);
>> +
>> +static int madera_get_reset_gpio(struct madera *madera)
>> +{
>> +	struct gpio_desc *reset;
>> +	int ret;
>> +
>> +	reset = devm_gpiod_get_optional(madera->dev, "reset", GPIOD_OUT_LOW);
>> +
> 
> Nit: Remove this line.
> 
>> +	if (IS_ERR(reset)) {
>> +		ret = PTR_ERR(reset);
>> +		if (ret == -EPROBE_DEFER)
> 
> Reverse the logic and only print the error if !-EPROBE_DEFER, then you
> only need one return.
> 
>> +			return ret;
>> +
>> +		dev_err(madera->dev, "Failed to request /RESET: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	madera->pdata.reset = reset;
>> +
>> +	return 0;
>> +}
>> +
>> +static void madera_set_micbias_info(struct madera *madera)
>> +{
>> +	/*
>> +	 * childbias is an array because future codecs can have different
> 
> You mean num_childbias?
> 
>> +	 * childbiases for each micbias
>> +	 */
>> +	switch (madera->type) {
>> +	case CS47L35:
>> +		madera->num_micbias = 2;
>> +		madera->num_childbias[0] = 2;
>> +		madera->num_childbias[1] = 2;
>> +		return;
>> +	case CS47L85:
>> +	case WM1840:
>> +		madera->num_micbias = 4;
> 
> Where are the num_childbias[x] initialised for this device?
> 

The data struct in kzalloc in probe so we don't need to waste
lines initializing zeros.

>> +		return;
>> +	case CS47L90:
>> +	case CS47L91:
>> +		madera->num_micbias = 2;
>> +		madera->num_childbias[0] = 4;
>> +		madera->num_childbias[1] = 4;
>> +		return;
>> +	default:
>> +		return;
>> +	}
>> +}
>> +
>> +int madera_dev_init(struct madera *madera)
>> +{
>> +	struct device *dev = madera->dev;
>> +	unsigned int hwid;
>> +	int (*patch_fn)(struct madera *) = NULL;
>> +	const struct mfd_cell *mfd_devs;
>> +	int n_devs = 0;
>> +	int i, ret;
>> +
>> +	dev_set_drvdata(madera->dev, madera);
>> +	BLOCKING_INIT_NOTIFIER_HEAD(&madera->notifier);
>> +	madera_set_micbias_info(madera);
>> +
>> +	if (dev_get_platdata(madera->dev)) {
>> +		memcpy(&madera->pdata, dev_get_platdata(madera->dev),
>> +		       sizeof(madera->pdata));
>> +	}
> 
> Hmm... not sure about this.
> 
> Normally we extract what we need from pdata and place it into your ddata.
> 

We need all our pdata and we want to share modifiable settings with
the children.
Or do you mean that there's already code in the driver core that
takes a copy of the pdata?

>> +	if (!madera->pdata.reset) {
>> +		ret = madera_get_reset_gpio(madera);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	if (!madera->pdata.reset)
>> +		dev_warn(madera->dev,
>> +			 "Running without reset GPIO is not recommended\n");
> 
> Is this even possible?  If so, handle it in  madera_get_reset_gpio().
>
>> +	regcache_cache_only(madera->regmap, true);
>> +	regcache_cache_only(madera->regmap_32bit, true);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(madera_core_supplies); i++)
>> +		madera->core_supplies[i].supply = madera_core_supplies[i];
>> +
>> +	madera->num_core_supplies = ARRAY_SIZE(madera_core_supplies);
>> +
>> +	/*
>> +	 * On some codecs DCVDD could be supplied by the internal LDO1.
>> +	 * For those we must add the LDO1 driver before requesting DCVDD
>> +	 * No devm_ because we need to control shutdown order of children.
>> +	 */
>> +	switch (madera->type) {
>> +	case CS47L35:
>> +	case CS47L90:
>> +	case CS47L91:
>> +		break;
>> +	case CS47L85:
>> +	case WM1840:
>> +		ret = mfd_add_devices(madera->dev, PLATFORM_DEVID_NONE,
>> +				      madera_ldo1_devs,
>> +				      ARRAY_SIZE(madera_ldo1_devs),
>> +				      NULL, 0, NULL);
> 
> LEE: Is there any guarantee?
> 

Of what?

> #########################################################
> #########################################################
> #########################################################
> #########################################################
> #########################################################
> #########################################################
> 

??

>> +		if (ret) {
>> +			dev_err(dev, "Failed to add LDO1 child: %d\n", ret);
>> +			return ret;
>> +		}
>> +		break;
>> +	default:
>> +		/* No point continuing if the type is unknown */
>> +		dev_err(madera->dev, "Unknown device type %d\n", madera->type);
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = devm_regulator_bulk_get(dev, madera->num_core_supplies,
>> +				      madera->core_supplies);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to request core supplies: %d\n", ret);
>> +		goto err_devs;
>> +	}
>> +
>> +	/*
>> +	 * Don't use devres here because the only device we have to get
>> +	 * against is the MFD device and DCVDD will likely be supplied by
>> +	 * one of its children. Meaning that the regulator will be
>> +	 * destroyed by the time devres calls regulator put.
>> +	 */
> 
> I'm confused.  So the regulator you're *_get()ing doesn't exist yet?
>

No, it's what it says in the comment. If the regulator is a child of
this mfd it will be removed before the parent mfd is removed so when
the devm tries to put() it has already gone - BANG.

>> +	madera->dcvdd = regulator_get(madera->dev, "DCVDD");
>> +	if (IS_ERR(madera->dcvdd)) {
>> +		ret = PTR_ERR(madera->dcvdd);
>> +		dev_err(dev, "Failed to request DCVDD: %d\n", ret);
>> +		goto err_devs;
>> +	}
>> +
>> +	ret = regulator_bulk_enable(madera->num_core_supplies,
>> +				    madera->core_supplies);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable core supplies: %d\n", ret);
>> +		goto err_dcvdd;
>> +	}
>> +
>> +	ret = regulator_enable(madera->dcvdd);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable DCVDD: %d\n", ret);
>> +		goto err_enable;
>> +	}
>> +
>> +	madera_disable_hard_reset(madera);
>> +
>> +	regcache_cache_only(madera->regmap, false);
>> +	regcache_cache_only(madera->regmap_32bit, false);
>> +
>> +	/*
>> +	 * Verify that this is a chip we know about before we
>> +	 * starting doing any writes to its registers
> 
> Nit: start
> 
> Shouldn't you do this *before* you start to set everything up above?
> 

No. You can't read registers until you have applied power and taken
the chip out of hard reset.

>> +	 */
>> +	ret = regmap_read(madera->regmap, MADERA_SOFTWARE_RESET, &hwid);
> 
> MADERA_SOFTWARE_RESET ?
> 

That's what the register is called. It's in the datasheet.

>> +	if (ret) {
>> +		dev_err(dev, "Failed to read ID register: %d\n", ret);
>> +		goto err_reset;
>> +	}
>> +
>> +	switch (hwid) {
>> +	case CS47L35_SILICON_ID:
>> +		if (IS_ENABLED(CONFIG_MFD_CS47L35)) {
>> +			switch (madera->type) {
>> +			case CS47L35:
>> +				patch_fn = cs47l35_patch;
> 
> I've always hated these.
> 
> Why doesn't the device come with a sensible default configuration
> that you can sensibly adjust accordingly in a *sane* way?
> 

Google "post-silicon tuning" or see
https://en.wikipedia.org/wiki/Integrated_circuit_design#Analog_design
and
https://tinyurl.com/y8qxa599

Analog is affected by process variation. If you don't care about the
performance you can leave it at some defaults but our customers expect
high-quality audio so we want to tune for the best performance.
The tuning isn't some controls you can give to the user to "play with
until it sounds right". It takes skilled engineers with knowledge of the
insides of the chip to come up with tunings and a coherent set of
values.

>> +				mfd_devs = cs47l35_devs;
>> +				n_devs = ARRAY_SIZE(cs47l35_devs);
>> +				break;
>> +			default:
>> +				break;
>> +			}
>> +		}
>> +		break;
>> +	case CS47L85_SILICON_ID:
>> +		if (IS_ENABLED(CONFIG_MFD_CS47L85)) {
>> +			switch (madera->type) {
>> +			case CS47L85:
>> +			case WM1840:
>> +				patch_fn = cs47l85_patch;
>> +				mfd_devs = cs47l85_devs;
>> +				n_devs = ARRAY_SIZE(cs47l85_devs);
>> +				break;
>> +			default:
>> +				break;
>> +			}
>> +		}
>> +		break;
>> +	case CS47L90_SILICON_ID:
>> +		if (IS_ENABLED(CONFIG_MFD_CS47L90)) {
>> +			switch (madera->type) {
>> +			case CS47L90:
>> +			case CS47L91:
>> +				patch_fn = cs47l90_patch;
>> +				mfd_devs = cs47l90_devs;
>> +				n_devs = ARRAY_SIZE(cs47l90_devs);
>> +				break;
>> +			default:
>> +				break;
>> +			}
>> +		}
>> +		break;
>> +	default:
>> +		dev_err(madera->dev, "Unknown device ID: %x\n", hwid);
>> +		ret = -EINVAL;
>> +		goto err_reset;
>> +	}
>> +
>> +	if (!n_devs) {
>> +		dev_err(madera->dev, "Device ID 0x%x not a %s\n", hwid,
>> +			madera->type_name);
>> +		ret = -ENODEV;
>> +		goto err_reset;
>> +	}
>> +
>> +	/*
>> +	 * It looks like a device we support. If we don't have a hard reset
>> +	 * we can now attempt a soft reset
>> +	 */
>> +	if (!madera->pdata.reset) {
> 
> Call the reset regardless and do any affiliated checks *inside*.
> 

No. We don't want to be doing spurious unnecessary resets.
We _only_ call soft reset if we didn't have a GPIO to be able to
do a full hard reset. We can't combine hard and soft into one
function, the sequencing is different. Hard reset is asserted before
powering the chip up. Soft reset is a command so can only be issued
after the chip is powered up. You can see from the code that we call
hard reset control in different places to the soft reset.

>> +		ret = madera_soft_reset(madera);
>> +		if (ret)
>> +			goto err_reset;
>> +	}
>> +
>> +	ret = madera_wait_for_boot(madera);
>> +	if (ret) {
>> +		dev_err(madera->dev, "Device failed initial boot: %d\n", ret);
>> +		goto err_reset;
>> +	}
>> +
>> +	ret = regmap_read(madera->regmap, MADERA_HARDWARE_REVISION,
>> +			  &madera->rev);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to read revision register: %d\n", ret);
>> +		goto err_reset;
>> +	}
>> +	madera->rev &= MADERA_HW_REVISION_MASK;
>> +
>> +	dev_info(dev, "%s silicon revision %d\n", madera->type_name,
>> +		 madera->rev);
>> +
>> +	/* Apply hardware patch */
>> +	if (patch_fn) {
>> +		ret = patch_fn(madera);
>> +		if (ret) {
>> +			dev_err(madera->dev, "Failed to apply patch %d\n", ret);
>> +			goto err_reset;
>> +		}
>> +	}
>> +
>> +	/* Init 32k clock sourced from MCLK2 */
>> +	ret = regmap_update_bits(madera->regmap,
>> +			MADERA_CLOCK_32K_1,
>> +			MADERA_CLK_32K_ENA_MASK | MADERA_CLK_32K_SRC_MASK,
>> +			MADERA_CLK_32K_ENA | MADERA_32KZ_MCLK2);
>> +	if (ret) {
>> +		dev_err(madera->dev, "Failed to init 32k clock: %d\n", ret);
>> +		goto err_reset;
>> +	}
>> +
>> +	pm_runtime_set_active(madera->dev);
>> +	pm_runtime_enable(madera->dev);
>> +	pm_runtime_set_autosuspend_delay(madera->dev, 100);
>> +	pm_runtime_use_autosuspend(madera->dev);
>> +
>> +	/* No devm_ because we need to control shutdown order of children */
>> +	ret = mfd_add_devices(madera->dev, PLATFORM_DEVID_NONE,
>> +			      mfd_devs, n_devs,
>> +			      NULL, 0, NULL);
>> +	if (ret) {
>> +		dev_err(madera->dev, "Failed to add subdevices: %d\n", ret);
>> +		goto err_pm_runtime;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_pm_runtime:
>> +	pm_runtime_disable(madera->dev);
>> +err_reset:
>> +	madera_enable_hard_reset(madera);
>> +	regulator_disable(madera->dcvdd);
>> +err_enable:
>> +	regulator_bulk_disable(madera->num_core_supplies,
>> +			       madera->core_supplies);
>> +err_dcvdd:
>> +	regulator_put(madera->dcvdd);
>> +err_devs:
>> +	mfd_remove_devices(dev);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(madera_dev_init);
>> +
>> +int madera_dev_exit(struct madera *madera)
>> +{
>> +	/* Prevent any IRQs being serviced while we clean up */
>> +	disable_irq(madera->irq);
>> +
>> +	/*
>> +	 * DCVDD could be supplied by a child node, we must disable it before
>> +	 * removing the children, and prevent PM runtime from turning it back on
>> +	 */
>> +	pm_runtime_disable(madera->dev);
>> +
>> +	regulator_disable(madera->dcvdd);
>> +	regulator_put(madera->dcvdd);
>> +
>> +	mfd_remove_devices(madera->dev);
>> +	madera_enable_hard_reset(madera);
>> +
>> +	regulator_bulk_disable(madera->num_core_supplies,
>> +			       madera->core_supplies);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(madera_dev_exit);
>> +
>> +MODULE_DESCRIPTION("Madera core MFD driver");
>> +MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/mfd/madera-i2c.c b/drivers/mfd/madera-i2c.c
>> new file mode 100644
>> index 000000000000..ac2ad4a97766
>> --- /dev/null
>> +++ b/drivers/mfd/madera-i2c.c
>> @@ -0,0 +1,139 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * I2C bus interface to Cirrus Logic Madera codecs
>> + *
>> + * Copyright (C) 2015-2018 Cirrus Logic
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by the
>> + * Free Software Foundation; version 2.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <linux/mfd/madera/core.h>
>> +
>> +#include "madera.h"
>> +
>> +static int madera_i2c_probe(struct i2c_client *i2c,
>> +			    const struct i2c_device_id *id)
>> +{
>> +	struct madera *madera;
>> +	const struct regmap_config *regmap_16bit_config = NULL;
>> +	const struct regmap_config *regmap_32bit_config = NULL;
>> +	const void *of_data;
>> +	unsigned long type;
>> +	const char *name;
>> +	int ret;
>> +
>> +	of_data = of_device_get_match_data(&i2c->dev);
>> +	if (of_data)
>> +		type = (unsigned long)of_data;
>> +	else
>> +		type = id->driver_data;
>> +
>> +	switch (type) {
>> +	case CS47L35:
>> +		if (IS_ENABLED(CONFIG_MFD_CS47L35)) {
>> +			regmap_16bit_config = &cs47l35_16bit_i2c_regmap;
>> +			regmap_32bit_config = &cs47l35_32bit_i2c_regmap;
>> +		}
>> +		break;
>> +	case CS47L85:
>> +	case WM1840:
>> +		if (IS_ENABLED(CONFIG_MFD_CS47L85)) {
>> +			regmap_16bit_config = &cs47l85_16bit_i2c_regmap;
>> +			regmap_32bit_config = &cs47l85_32bit_i2c_regmap;
>> +		}
>> +		break;
>> +	case CS47L90:
>> +	case CS47L91:
>> +		if (IS_ENABLED(CONFIG_MFD_CS47L90)) {
>> +			regmap_16bit_config = &cs47l90_16bit_i2c_regmap;
>> +			regmap_32bit_config = &cs47l90_32bit_i2c_regmap;
>> +		}
>> +		break;
>> +	default:
>> +		dev_err(&i2c->dev,
>> +			"Unknown Madera I2C device type %ld\n", type);
>> +		return -EINVAL;
>> +	}
>> +
>> +	name = madera_name_from_type(type);
>> +
>> +	if (!regmap_16bit_config) {
>> +		dev_err(&i2c->dev,
>> +			"Kernel does not include support for %s\n", name);
> 
> So you have provided support for devices in madera_name_from_type(),
> but not elsewhere?
> 

I'm sorry. I don't understand. Surely if the kernel has been compiled
without support for a chip it's useful to be able to log a meaningful
string to help with a menuconfig if there's an attempt to use that
chip?

>> +		return -EINVAL;
>> +	}
>> +
>> +	madera = devm_kzalloc(&i2c->dev, sizeof(*madera), GFP_KERNEL);
>> +	if (!madera)
>> +		return -ENOMEM;
>> +
>> +
>> +	madera->regmap = devm_regmap_init_i2c(i2c, regmap_16bit_config);
>> +	if (IS_ERR(madera->regmap)) {
>> +		ret = PTR_ERR(madera->regmap);
>> +		dev_err(&i2c->dev,
>> +			"Failed to allocate 16-bit register map: %d\n",	ret);
>> +		return ret;
>> +	}
>> +
>> +	madera->regmap_32bit = devm_regmap_init_i2c(i2c, regmap_32bit_config);
>> +	if (IS_ERR(madera->regmap_32bit)) {
>> +		ret = PTR_ERR(madera->regmap_32bit);
>> +		dev_err(&i2c->dev,
>> +			"Failed to allocate 32-bit register map: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	madera->type = type;
>> +	madera->type_name = name;
>> +	madera->dev = &i2c->dev;
>> +	madera->irq = i2c->irq;
>> +
>> +	return madera_dev_init(madera);
>> +}
>> +
>> +static int madera_i2c_remove(struct i2c_client *i2c)
>> +{
>> +	struct madera *madera = dev_get_drvdata(&i2c->dev);
>> +
>> +	madera_dev_exit(madera);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct i2c_device_id madera_i2c_id[] = {
>> +	{ "cs47l35", CS47L35 },
>> +	{ "cs47l85", CS47L85 },
>> +	{ "cs47l90", CS47L90 },
>> +	{ "cs47l91", CS47L91 },
>> +	{ "wm1840", WM1840 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, madera_i2c_id);
>> +
>> +static struct i2c_driver madera_i2c_driver = {
>> +	.driver = {
>> +		.name	= "madera",
>> +		.pm	= &madera_pm_ops,
>> +		.of_match_table	= of_match_ptr(madera_of_match),
>> +	},
>> +	.probe		= madera_i2c_probe,
>> +	.remove		= madera_i2c_remove,
>> +	.id_table	= madera_i2c_id,
>> +};
>> +
>> +module_i2c_driver(madera_i2c_driver);
>> +
>> +MODULE_DESCRIPTION("Madera I2C bus interface");
>> +MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/mfd/madera-spi.c b/drivers/mfd/madera-spi.c
>> new file mode 100644
>> index 000000000000..ff5c545dc575
>> --- /dev/null
>> +++ b/drivers/mfd/madera-spi.c
>> @@ -0,0 +1,138 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * SPI bus interface to Cirrus Logic Madera codecs
>> + *
>> + * Copyright (C) 2015-2018 Cirrus Logic
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by the
>> + * Free Software Foundation; version 2.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#include <linux/mfd/madera/core.h>
>> +
>> +#include "madera.h"
>> +
>> +static int madera_spi_probe(struct spi_device *spi)
>> +{
>> +	const struct spi_device_id *id = spi_get_device_id(spi);
>> +	struct madera *madera;
>> +	const struct regmap_config *regmap_16bit_config = NULL;
>> +	const struct regmap_config *regmap_32bit_config = NULL;
>> +	const void *of_data;
>> +	unsigned long type;
>> +	const char *name;
>> +	int ret;
>> +
>> +	of_data = of_device_get_match_data(&spi->dev);
>> +	if (of_data)
>> +		type = (unsigned long)of_data;
>> +	else
>> +		type = id->driver_data;
>> +
>> +	switch (type) {
>> +	case CS47L35:
>> +		if (IS_ENABLED(CONFIG_MFD_CS47L35)) {
>> +			regmap_16bit_config = &cs47l35_16bit_spi_regmap;
>> +			regmap_32bit_config = &cs47l35_32bit_spi_regmap;
>> +		}
>> +		break;
>> +	case CS47L85:
>> +	case WM1840:
>> +		if (IS_ENABLED(CONFIG_MFD_CS47L85)) {
>> +			regmap_16bit_config = &cs47l85_16bit_spi_regmap;
>> +			regmap_32bit_config = &cs47l85_32bit_spi_regmap;
>> +		}
>> +		break;
>> +	case CS47L90:
>> +	case CS47L91:
>> +		if (IS_ENABLED(CONFIG_MFD_CS47L90)) {
>> +			regmap_16bit_config = &cs47l90_16bit_spi_regmap;
>> +			regmap_32bit_config = &cs47l90_32bit_spi_regmap;
>> +		}
>> +		break;
>> +	default:
>> +		dev_err(&spi->dev,
>> +			"Unknown Madera SPI device type %ld\n", type);
>> +		return -EINVAL;
>> +	}
>> +
>> +	name = madera_name_from_type(type);
>> +
>> +	if (!regmap_16bit_config) {
>> +		dev_err(&spi->dev,
>> +			"Kernel does not include support for %s\n", name);
> 
> As above?
> 

As above.

>> +		return -EINVAL;
>> +	}
>> +
>> +	madera = devm_kzalloc(&spi->dev, sizeof(*madera), GFP_KERNEL);
>> +	if (!madera)
>> +		return -ENOMEM;
>> +
>> +	madera->regmap = devm_regmap_init_spi(spi, regmap_16bit_config);
>> +	if (IS_ERR(madera->regmap)) {
>> +		ret = PTR_ERR(madera->regmap);
>> +		dev_err(&spi->dev,
>> +			"Failed to allocate 16-bit register map: %d\n",	ret);
>> +		return ret;
>> +	}
>> +
>> +	madera->regmap_32bit = devm_regmap_init_spi(spi, regmap_32bit_config);
>> +	if (IS_ERR(madera->regmap_32bit)) {
>> +		ret = PTR_ERR(madera->regmap_32bit);
>> +		dev_err(&spi->dev,
>> +			"Failed to allocate 32-bit register map: %d\n",	ret);
>> +		return ret;
>> +	}
>> +
>> +	madera->type = type;
>> +	madera->type_name = name;
>> +	madera->dev = &spi->dev;
>> +	madera->irq = spi->irq;
>> +
>> +	return madera_dev_init(madera);
>> +}
>> +
>> +static int madera_spi_remove(struct spi_device *spi)
>> +{
>> +	struct madera *madera = spi_get_drvdata(spi);
>> +
>> +	madera_dev_exit(madera);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct spi_device_id madera_spi_ids[] = {
>> +	{ "cs47l35", CS47L35 },
>> +	{ "cs47l85", CS47L85 },
>> +	{ "cs47l90", CS47L90 },
>> +	{ "cs47l91", CS47L91 },
>> +	{ "wm1840", WM1840 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(spi, madera_spi_ids);
>> +
>> +static struct spi_driver madera_spi_driver = {
>> +	.driver = {
>> +		.name	= "madera",
>> +		.pm	= &madera_pm_ops,
>> +		.of_match_table	= of_match_ptr(madera_of_match),
>> +	},
>> +	.probe		= madera_spi_probe,
>> +	.remove		= madera_spi_remove,
>> +	.id_table	= madera_spi_ids,
>> +};
>> +
>> +module_spi_driver(madera_spi_driver);
>> +
>> +MODULE_DESCRIPTION("Madera SPI bus interface");
>> +MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/mfd/madera.h b/drivers/mfd/madera.h
>> new file mode 100644
>> index 000000000000..891b84efb9a7
>> --- /dev/null
>> +++ b/drivers/mfd/madera.h
>> @@ -0,0 +1,44 @@
>> +/*
>> + * MFD internals for Cirrus Logic Madera codecs
>> + *
>> + * Copyright 2015-2018 Cirrus Logic
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef MADERA_MFD_H
>> +#define MADERA_MFD_H
>> +
>> +#include <linux/of.h>
>> +#include <linux/pm.h>
>> +
>> +struct madera;
>> +
>> +extern const struct dev_pm_ops madera_pm_ops;
>> +extern const struct of_device_id madera_of_match[];
>> +
>> +int madera_dev_init(struct madera *madera);
>> +int madera_dev_exit(struct madera *madera);
>> +
>> +const char *madera_name_from_type(enum madera_type type);
>> +
>> +extern const struct regmap_config cs47l35_16bit_spi_regmap;
>> +extern const struct regmap_config cs47l35_32bit_spi_regmap;
>> +extern const struct regmap_config cs47l35_16bit_i2c_regmap;
>> +extern const struct regmap_config cs47l35_32bit_i2c_regmap;
>> +int cs47l35_patch(struct madera *madera);
>> +
>> +extern const struct regmap_config cs47l85_16bit_spi_regmap;
>> +extern const struct regmap_config cs47l85_32bit_spi_regmap;
>> +extern const struct regmap_config cs47l85_16bit_i2c_regmap;
>> +extern const struct regmap_config cs47l85_32bit_i2c_regmap;
>> +int cs47l85_patch(struct madera *madera);
>> +
>> +extern const struct regmap_config cs47l90_16bit_spi_regmap;
>> +extern const struct regmap_config cs47l90_32bit_spi_regmap;
>> +extern const struct regmap_config cs47l90_16bit_i2c_regmap;
>> +extern const struct regmap_config cs47l90_32bit_i2c_regmap;
>> +int cs47l90_patch(struct madera *madera);
>> +#endif
>> diff --git a/include/linux/mfd/madera/core.h b/include/linux/mfd/madera/core.h
>> new file mode 100644
>> index 000000000000..c332681848ef
>> --- /dev/null
>> +++ b/include/linux/mfd/madera/core.h
>> @@ -0,0 +1,187 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * MFD internals for Cirrus Logic Madera codecs
>> + *
>> + * Copyright (C) 2015-2018 Cirrus Logic
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by the
>> + * Free Software Foundation; version 2.
>> + */
>> +
>> +#ifndef MADERA_CORE_H
>> +#define MADERA_CORE_H
>> +
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/mfd/madera/pdata.h>
>> +#include <linux/notifier.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +enum madera_type {
>> +	/* 0 is reserved for indicating failure to identify */
>> +	CS47L35 = 1,
>> +	CS47L85 = 2,
>> +	CS47L90 = 3,
>> +	CS47L91 = 4,
>> +	WM1840 = 7,
>> +};
>> +
>> +#define MADERA_MAX_CORE_SUPPLIES	2
>> +#define MADERA_MAX_GPIOS		40
>> +
>> +#define CS47L35_NUM_GPIOS		16
>> +#define CS47L85_NUM_GPIOS		40
>> +#define CS47L90_NUM_GPIOS		38
>> +
>> +#define MADERA_MAX_MICBIAS		4
>> +
>> +/* Notifier events */
>> +#define MADERA_NOTIFY_VOICE_TRIGGER	0x1
>> +#define MADERA_NOTIFY_HPDET		0x2
>> +#define MADERA_NOTIFY_MICDET		0x4
>> +
>> +/* GPIO Function Definitions */
>> +#define MADERA_GP_FN_ALTERNATE		0x00
>> +#define MADERA_GP_FN_GPIO		0x01
>> +#define MADERA_GP_FN_DSP_GPIO		0x02
>> +#define MADERA_GP_FN_IRQ1		0x03
>> +#define MADERA_GP_FN_IRQ2		0x04
>> +#define MADERA_GP_FN_FLL1_CLOCK		0x10
>> +#define MADERA_GP_FN_FLL2_CLOCK		0x11
>> +#define MADERA_GP_FN_FLL3_CLOCK		0x12
>> +#define MADERA_GP_FN_FLLAO_CLOCK	0x13
>> +#define MADERA_GP_FN_FLL1_LOCK		0x18
>> +#define MADERA_GP_FN_FLL2_LOCK		0x19
>> +#define MADERA_GP_FN_FLL3_LOCK		0x1A
>> +#define MADERA_GP_FN_FLLAO_LOCK		0x1B
>> +#define MADERA_GP_FN_OPCLK_OUT		0x40
>> +#define MADERA_GP_FN_OPCLK_ASYNC_OUT	0x41
>> +#define MADERA_GP_FN_PWM1		0x48
>> +#define MADERA_GP_FN_PWM2		0x49
>> +#define MADERA_GP_FN_SPDIF_OUT		0x4C
>> +#define MADERA_GP_FN_HEADPHONE_DET	0x50
>> +#define MADERA_GP_FN_MIC_DET		0x58
>> +#define MADERA_GP_FN_DRC1_SIGNAL_DETECT	0x80
>> +#define MADERA_GP_FN_DRC2_SIGNAL_DETECT	0x81
>> +#define MADERA_GP_FN_ASRC1_IN1_LOCK	0x88
>> +#define MADERA_GP_FN_ASRC1_IN2_LOCK	0x89
>> +#define MADERA_GP_FN_ASRC2_IN1_LOCK	0x8A
>> +#define MADERA_GP_FN_ASRC2_IN2_LOCK	0x8B
>> +#define MADERA_GP_FN_DSP_IRQ1		0xA0
>> +#define MADERA_GP_FN_DSP_IRQ2		0xA1
>> +#define MADERA_GP_FN_DSP_IRQ3		0xA2
>> +#define MADERA_GP_FN_DSP_IRQ4		0xA3
>> +#define MADERA_GP_FN_DSP_IRQ5		0xA4
>> +#define MADERA_GP_FN_DSP_IRQ6		0xA5
>> +#define MADERA_GP_FN_DSP_IRQ7		0xA6
>> +#define MADERA_GP_FN_DSP_IRQ8		0xA7
>> +#define MADERA_GP_FN_DSP_IRQ9		0xA8
>> +#define MADERA_GP_FN_DSP_IRQ10		0xA9
>> +#define MADERA_GP_FN_DSP_IRQ11		0xAA
>> +#define MADERA_GP_FN_DSP_IRQ12		0xAB
>> +#define MADERA_GP_FN_DSP_IRQ13		0xAC
>> +#define MADERA_GP_FN_DSP_IRQ14		0xAD
>> +#define MADERA_GP_FN_DSP_IRQ15		0xAE
>> +#define MADERA_GP_FN_DSP_IRQ16		0xAF
>> +#define MADERA_GP_FN_HPOUT1L_SC		0xB0
>> +#define MADERA_GP_FN_HPOUT1R_SC		0xB1
>> +#define MADERA_GP_FN_HPOUT2L_SC		0xB2
>> +#define MADERA_GP_FN_HPOUT2R_SC		0xB3
>> +#define MADERA_GP_FN_HPOUT3L_SC		0xB4
>> +#define MADERA_GP_FN_HPOUT4R_SC		0xB5
>> +#define MADERA_GP_FN_SPKOUTL_SC		0xB6
>> +#define MADERA_GP_FN_SPKOUTR_SC		0xB7
>> +#define MADERA_GP_FN_HPOUT1L_ENA	0xC0
>> +#define MADERA_GP_FN_HPOUT1R_ENA	0xC1
>> +#define MADERA_GP_FN_HPOUT2L_ENA	0xC2
>> +#define MADERA_GP_FN_HPOUT2R_ENA	0xC3
>> +#define MADERA_GP_FN_HPOUT3L_ENA	0xC4
>> +#define MADERA_GP_FN_HPOUT4R_ENA	0xC5
>> +#define MADERA_GP_FN_SPKOUTL_ENA	0xC6
>> +#define MADERA_GP_FN_SPKOUTR_ENA	0xC7
>> +#define MADERA_GP_FN_HPOUT1L_DIS	0xD0
>> +#define MADERA_GP_FN_HPOUT1R_DIS	0xD1
>> +#define MADERA_GP_FN_HPOUT2L_DIS	0xD2
>> +#define MADERA_GP_FN_HPOUT2R_DIS	0xD3
>> +#define MADERA_GP_FN_HPOUT3L_DIS	0xD4
>> +#define MADERA_GP_FN_HPOUT4R_DIS	0xD5
>> +#define MADERA_GP_FN_SPKOUTL_DIS	0xD6
>> +#define MADERA_GP_FN_SPKOUTR_DIS	0xD7
>> +#define MADERA_GP_FN_SPK_SHUTDOWN	0xE0
>> +#define MADERA_GP_FN_SPK_OVH_SHUTDOWN	0xE1
>> +#define MADERA_GP_FN_SPK_OVH_WARN	0xE2
>> +#define MADERA_GP_FN_TIMER1_STATUS	0x140
>> +#define MADERA_GP_FN_TIMER2_STATUS	0x141
>> +#define MADERA_GP_FN_TIMER3_STATUS	0x142
>> +#define MADERA_GP_FN_TIMER4_STATUS	0x143
>> +#define MADERA_GP_FN_TIMER5_STATUS	0x144
>> +#define MADERA_GP_FN_TIMER6_STATUS	0x145
>> +#define MADERA_GP_FN_TIMER7_STATUS	0x146
>> +#define MADERA_GP_FN_TIMER8_STATUS	0x147
>> +#define MADERA_GP_FN_EVENTLOG1_FIFO_STS	0x150
>> +#define MADERA_GP_FN_EVENTLOG2_FIFO_STS	0x151
>> +#define MADERA_GP_FN_EVENTLOG3_FIFO_STS	0x152
>> +#define MADERA_GP_FN_EVENTLOG4_FIFO_STS	0x153
>> +#define MADERA_GP_FN_EVENTLOG5_FIFO_STS	0x154
>> +#define MADERA_GP_FN_EVENTLOG6_FIFO_STS	0x155
>> +#define MADERA_GP_FN_EVENTLOG7_FIFO_STS	0x156
>> +#define MADERA_GP_FN_EVENTLOG8_FIFO_STS	0x157
>> +
>> +struct snd_soc_dapm_context;
>> +
>> +/*
>> + * struct madera - internal data shared by the set of Madera drivers
>> + *
>> + * This should not be used by anything except child drivers of the Madera MFD
>> + *
>> + * @regmap:		pointer to the regmap instance for 16-bit registers
>> + * @regmap_32bit:	pointer to the regmap instance for 32-bit registers
>> + * @dev:		pointer to the MFD device
>> + * @type:		type of codec
>> + * @rev:		silicon revision
>> + * @type_name:		display name of this codec
>> + * @num_core_supplies:	number of core supply regulators
>> + * @core_supplies:	list of core supplies that are always required
>> + * @dcvdd:		pointer to DCVDD regulator
>> + * @internal_dcvdd:	true if DCVDD is supplied from the internal LDO1
>> + * @pdata:		our pdata
>> + * @irq_dev:		the irqchip child driver device
>> + * @irq:		host irq number from SPI or I2C configuration
>> + * @out_clamp:		indicates output clamp state for each analogue output
>> + * @out_shorted:	indicates short circuit state for each analogue output
>> + * @hp_ena:		bitflags of enable state for the headphone outputs
>> + * @num_micbias:	number of MICBIAS outputs
>> + * @num_childbias:	number of child biases for each MICBIAS
>> + * @dapm:		pointer to codec driver DAPM context
>> + * @notifier:		notifier for signalling events to ASoC machine driver
>> + */
>> +struct madera {
>> +	struct regmap *regmap;
>> +	struct regmap *regmap_32bit;
>> +
>> +	struct device *dev;
>> +
>> +	enum madera_type type;
>> +	unsigned int rev;
>> +	const char *type_name;
>> +
>> +	int num_core_supplies;
>> +	struct regulator_bulk_data core_supplies[MADERA_MAX_CORE_SUPPLIES];
>> +	struct regulator *dcvdd;
>> +	bool internal_dcvdd;
>> +
>> +	struct madera_pdata pdata;
>> +
>> +	struct device *irq_dev;
>> +	int irq;
>> +
>> +	unsigned int num_micbias;
>> +	unsigned int num_childbias[MADERA_MAX_MICBIAS];
>> +
>> +	struct snd_soc_dapm_context *dapm;
>> +
>> +	struct blocking_notifier_head notifier;
>> +};
>> +#endif
>> diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
>> new file mode 100644
>> index 000000000000..cd4ce12c2ced
>> --- /dev/null
>> +++ b/include/linux/mfd/madera/pdata.h
>> @@ -0,0 +1,63 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Platform data for Cirrus Logic Madera codecs
>> + *
>> + * Copyright (C) 2015-2018 Cirrus Logic
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by the
>> + * Free Software Foundation; version 2.
>> + */
>> +
>> +#ifndef MADERA_PDATA_H
>> +#define MADERA_PDATA_H
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/regulator/arizona-ldo1.h>
>> +#include <linux/regulator/arizona-micsupp.h>
>> +#include <linux/regulator/machine.h>
>> +
>> +#define MADERA_MAX_MICBIAS		4
>> +#define MADERA_MAX_CHILD_MICBIAS	4
>> +
>> +#define MADERA_MAX_GPSW			2
>> +
>> +struct gpio_desc;
>> +struct pinctrl_map;
>> +struct madera_irqchip_pdata;
>> +struct madera_codec_pdata;
>> +
>> +/**
>> + * struct madera_pdata - Configuration data for Madera devices
>> + *
>> + * @reset:	    GPIO controlling /RESET (NULL = none)
>> + * @ldo1:	    Substruct of pdata for the LDO1 regulator
>> + * @micvdd:	    Substruct of pdata for the MICVDD regulator
>> + * @irqchip:	    Pointer to optional pdata for the irqchip driver
>> + * @gpio_base:	    Base GPIO number
>> + * @gpio_configs:   Array of GPIO configurations (See Documentation/pinctrl.txt)
>> + * @n_gpio_configs: Number of entries in gpio_configs
>> + * @codec:	    Pointer to optional pdata for the ASoC codec driver
>> + *		    See include/sound/madera-pdata.h
>> + * @gpsw:	    General purpose switch mode setting (See the SW1_MODE field
>> + *		    in the datasheet for the available values for your codec)
>> + */
>> +struct madera_pdata {
>> +	struct gpio_desc *reset;
>> +
>> +	struct arizona_ldo1_pdata ldo1;
>> +	struct arizona_micsupp_pdata micvdd;
>> +
>> +	struct madera_irqchip_pdata *irqchip;
>> +
>> +	int gpio_base;
>> +
>> +	const struct pinctrl_map *gpio_configs;
>> +	int n_gpio_configs;
>> +
>> +	struct madera_codec_pdata *codec;
>> +
>> +	u32 gpsw[MADERA_MAX_GPSW];
>> +};
> 
> This doesn't look like platform data.  Where does it come from?
> 

In what way doesn't it look like platform data?
A bunch of information about external hardware that we wouldn't
be able to guess sounds like pdata to me.

>> +#endif
> 
