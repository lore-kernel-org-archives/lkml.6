Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeBJPoi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 10:44:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbeBJPog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 10:44:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39B121742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Feb 2018 15:44:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Georgiana Chelu <georgiana.chelu93@gmail.com>
Cc: linux-iio@vger.kernel.org, daniel.baluta@gmail.com,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akinobu.mita@gmail.com, jan.kiszka@siemens.com
Subject: Re: [RFC PATCH] iio: adc: ti-ads1015: Refactor code to support SPI
Message-ID: <20180210154432.5cd4168c@archlinux>
In-Reply-To: <20180209173811.19577-1-georgiana.chelu93@gmail.com>
References: <20180209173811.19577-1-georgiana.chelu93@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Feb 2018 19:38:11 +0200
Georgiana Chelu <georgiana.chelu93@gmail.com> wrote:

> We want to add support for ads1118 which uses SPI interface.
> In order to do that we first refactor existing code into a core
> part (bus independent) and an I2C part for current supported
> devices.
> 
> Next patch will introduce support for ADS1118 which uses
> SPI bus for communication.
> 
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Signed-off-by: Georgiana Chelu <georgiana.chelu93@gmail.com>
> ---
> We are sending this as a RFC for now to get your opinion on the
> split. Still working on testing the SPI part.

The split is fine in general.  A few comments inline.
Note I'm not going to take this except as part of the series
adding the SPI support.  Otherwise it sometimes turns out there
are little additional tweaks needed (often the regmap
spi is not quite the same as the regmap i2c though here it
looks like it might be) and those end up messy.

A few minor comments inline.
> 
>  drivers/iio/adc/Kconfig          |  12 ++-
>  drivers/iio/adc/Makefile         |   1 +
>  drivers/iio/adc/ti-ads1015.c     | 194 +++++++++++----------------------------
>  drivers/iio/adc/ti-ads1015.h     |  63 +++++++++++++
>  drivers/iio/adc/ti-ads1015_i2c.c |  80 ++++++++++++++++
>  5 files changed, 204 insertions(+), 146 deletions(-)
>  create mode 100644 drivers/iio/adc/ti-ads1015.h
>  create mode 100644 drivers/iio/adc/ti-ads1015_i2c.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 10f3ede91d3a..846793a0e827 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -774,17 +774,21 @@ config TI_ADC161S626
>  	  called ti-adc161s626.
>  
>  config TI_ADS1015
> -	tristate "Texas Instruments ADS1015 ADC"
> -	depends on I2C && !SENSORS_ADS1015
> -	select REGMAP_I2C
> +	tristate
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> +
> +config TI_ADS1015_I2C
> +	tristate "Texas Instruments ADS1015 I2C ADC"
> +	depends on I2C && !SENSORS_ADS1015
> +	select REGMAP_I2C
> +	select TI_ADS1015
>  	help
>  	  If you say yes here you get support for Texas Instruments ADS1015
>  	  ADC chip.
>  
>  	  This driver can also be built as a module. If so, the module will be
> -	  called ti-ads1015.
> +	  called ti-ads1015_i2c.
>  
>  config TI_ADS7950
>  	tristate "Texas Instruments ADS7950 ADC driver"
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 9572c1090f35..c5c30b7cda64 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_TI_ADC108S102) += ti-adc108s102.o
>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>  obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
> +obj-$(CONFIG_TI_ADS1015_I2C) += ti-ads1015_i2c.o
>  obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 6a114dcb4a3a..62898a0da4dd 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -6,19 +6,12 @@
>   * This file is subject to the terms and conditions of version 2 of
>   * the GNU General Public License.  See the file COPYING in the main
>   * directory of this archive for more details.
> - *
> - * IIO driver for ADS1015 ADC 7-bit I2C slave address:
> - *	* 0x48 - ADDR connected to Ground
> - *	* 0x49 - ADDR connected to Vdd
> - *	* 0x4A - ADDR connected to SDA
> - *	* 0x4B - ADDR connected to SCL
>   */
>  
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/init.h>
>  #include <linux/irq.h>
> -#include <linux/i2c.h>
>  #include <linux/regmap.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/mutex.h>
> @@ -34,55 +27,7 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  
> -#define ADS1015_DRV_NAME "ads1015"
> -
> -#define ADS1015_CONV_REG	0x00
> -#define ADS1015_CFG_REG		0x01
> -#define ADS1015_LO_THRESH_REG	0x02
> -#define ADS1015_HI_THRESH_REG	0x03
> -
> -#define ADS1015_CFG_COMP_QUE_SHIFT	0
> -#define ADS1015_CFG_COMP_LAT_SHIFT	2
> -#define ADS1015_CFG_COMP_POL_SHIFT	3
> -#define ADS1015_CFG_COMP_MODE_SHIFT	4
> -#define ADS1015_CFG_DR_SHIFT	5
> -#define ADS1015_CFG_MOD_SHIFT	8
> -#define ADS1015_CFG_PGA_SHIFT	9
> -#define ADS1015_CFG_MUX_SHIFT	12
> -
> -#define ADS1015_CFG_COMP_QUE_MASK	GENMASK(1, 0)
> -#define ADS1015_CFG_COMP_LAT_MASK	BIT(2)
> -#define ADS1015_CFG_COMP_POL_MASK	BIT(3)
> -#define ADS1015_CFG_COMP_MODE_MASK	BIT(4)
> -#define ADS1015_CFG_DR_MASK	GENMASK(7, 5)
> -#define ADS1015_CFG_MOD_MASK	BIT(8)
> -#define ADS1015_CFG_PGA_MASK	GENMASK(11, 9)
> -#define ADS1015_CFG_MUX_MASK	GENMASK(14, 12)
> -
> -/* Comparator queue and disable field */
> -#define ADS1015_CFG_COMP_DISABLE	3
> -
> -/* Comparator polarity field */
> -#define ADS1015_CFG_COMP_POL_LOW	0
> -#define ADS1015_CFG_COMP_POL_HIGH	1
> -
> -/* Comparator mode field */
> -#define ADS1015_CFG_COMP_MODE_TRAD	0
> -#define ADS1015_CFG_COMP_MODE_WINDOW	1
> -
> -/* device operating modes */
> -#define ADS1015_CONTINUOUS	0
> -#define ADS1015_SINGLESHOT	1
> -
> -#define ADS1015_SLEEP_DELAY_MS		2000
> -#define ADS1015_DEFAULT_PGA		2
> -#define ADS1015_DEFAULT_DATA_RATE	4
> -#define ADS1015_DEFAULT_CHAN		0
> -
> -enum chip_ids {
> -	ADS1015,
> -	ADS1115,
> -};
> +#include "ti-ads1015.h"

Most of these defines are probably not going to be used in the i2c / spi
specific parts.  Better to leave them here than to put them in the header.

>  
>  enum ads1015_channels {
>  	ADS1015_AIN0_AIN1 = 0,
> @@ -229,6 +174,8 @@ struct ads1015_thresh_data {
>  };
>  
>  struct ads1015_data {
> +	enum chip_ids chip_id;
> +	struct device *dev;
>  	struct regmap *regmap;
>  	/*
>  	 * Protects ADC ops, e.g: concurrent sysfs/buffered
> @@ -281,12 +228,13 @@ static bool ads1015_is_writeable_reg(struct device *dev, unsigned int reg)
>  	}
>  }
>  
> -static const struct regmap_config ads1015_regmap_config = {
> +const struct regmap_config ads1015_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 16,
>  	.max_register = ADS1015_HI_THRESH_REG,
>  	.writeable_reg = ads1015_is_writeable_reg,
>  };
> +EXPORT_SYMBOL(ads1015_regmap_config);
>  
>  static const struct iio_chan_spec ads1015_channels[] = {
>  	ADS1015_V_DIFF_CHAN(0, 1, ADS1015_AIN0_AIN1),
> @@ -841,31 +789,29 @@ static const struct iio_info ads1115_info = {
>  };
>  
>  #ifdef CONFIG_OF
> -static int ads1015_get_channels_config_of(struct i2c_client *client)
> +static int ads1015_get_channels_config_of(struct ads1015_data *data)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct ads1015_data *data = iio_priv(indio_dev);
>  	struct device_node *node;
>  
> -	if (!client->dev.of_node ||
> -	    !of_get_next_child(client->dev.of_node, NULL))
> +	if (!data->dev->of_node ||
> +	    !of_get_next_child(data->dev->of_node, NULL))
>  		return -EINVAL;
>  
> -	for_each_child_of_node(client->dev.of_node, node) {
> +	for_each_child_of_node(data->dev->of_node, node) {
>  		u32 pval;
>  		unsigned int channel;
>  		unsigned int pga = ADS1015_DEFAULT_PGA;
>  		unsigned int data_rate = ADS1015_DEFAULT_DATA_RATE;
>  
>  		if (of_property_read_u32(node, "reg", &pval)) {
> -			dev_err(&client->dev, "invalid reg on %pOF\n",
> +			dev_err(data->dev, "invalid reg on %pOF\n",
>  				node);
>  			continue;
>  		}
>  
>  		channel = pval;
>  		if (channel >= ADS1015_CHANNELS) {
> -			dev_err(&client->dev,
> +			dev_err(data->dev,
>  				"invalid channel index %d on %pOF\n",
>  				channel, node);
>  			continue;
> @@ -874,7 +820,7 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
>  		if (!of_property_read_u32(node, "ti,gain", &pval)) {
>  			pga = pval;
>  			if (pga > 6) {
> -				dev_err(&client->dev, "invalid gain on %pOF\n",
> +				dev_err(data->dev, "invalid gain on %pOF\n",
>  					node);
>  				of_node_put(node);
>  				return -EINVAL;
> @@ -884,7 +830,7 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
>  		if (!of_property_read_u32(node, "ti,datarate", &pval)) {
>  			data_rate = pval;
>  			if (data_rate > 7) {
> -				dev_err(&client->dev,
> +				dev_err(data->dev,
>  					"invalid data_rate on %pOF\n",
>  					node);
>  				of_node_put(node);
> @@ -900,13 +846,12 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
>  }
>  #endif
>  
> -static void ads1015_get_channels_config(struct i2c_client *client)
> +static void ads1015_get_channels_config(struct ads1015_data *data)
>  {
>  	unsigned int k;
> +	struct ads1015_platform_data *pdata;
>  
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct ads1015_data *data = iio_priv(indio_dev);
> -	struct ads1015_platform_data *pdata = dev_get_platdata(&client->dev);
> +	pdata = dev_get_platdata(data->dev);
>  
>  	/* prefer platform data */
>  	if (pdata) {
> @@ -916,7 +861,7 @@ static void ads1015_get_channels_config(struct i2c_client *client)
>  	}
>  
>  #ifdef CONFIG_OF
> -	if (!ads1015_get_channels_config_of(client))
> +	if (!ads1015_get_channels_config_of(data))
>  		return;
>  #endif
>  	/* fallback on default configuration */
> @@ -933,33 +878,32 @@ static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
>  				  mode << ADS1015_CFG_MOD_SHIFT);
>  }
>  
> -static int ads1015_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +int ads1015_core_probe(struct device *dev, struct regmap *regmap,
> +		       const char *name, int irq, unsigned int chip_id)
>  {
>  	struct iio_dev *indio_dev;
>  	struct ads1015_data *data;
> -	int ret;
> +	int ret, i;
>  	enum chip_ids chip;
> -	int i;
>  
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> -	i2c_set_clientdata(client, indio_dev);
> +	dev_set_drvdata(dev, data);
>  
>  	mutex_init(&data->lock);
>  
> -	indio_dev->dev.parent = &client->dev;
> -	indio_dev->dev.of_node = client->dev.of_node;
> -	indio_dev->name = ADS1015_DRV_NAME;
> +	indio_dev->dev.parent = dev;
> +	indio_dev->dev.of_node = dev->of_node;
> +	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	if (client->dev.of_node)
> -		chip = (enum chip_ids)of_device_get_match_data(&client->dev);
> +	if (dev->of_node)
> +		chip = (enum chip_ids)of_device_get_match_data(dev);
>  	else
> -		chip = id->driver_data;
> +		chip = chip_id;
>  	switch (chip) {
>  	case ADS1015:
>  		indio_dev->channels = ads1015_channels;
> @@ -988,25 +932,21 @@ static int ads1015_probe(struct i2c_client *client,
>  	}
>  
>  	/* we need to keep this ABI the same as used by hwmon ADS1015 driver */
> -	ads1015_get_channels_config(client);
> +	ads1015_get_channels_config(data);
>  
> -	data->regmap = devm_regmap_init_i2c(client, &ads1015_regmap_config);
> -	if (IS_ERR(data->regmap)) {
> -		dev_err(&client->dev, "Failed to allocate register map\n");
> -		return PTR_ERR(data->regmap);
> -	}
> +	data->regmap = regmap;
>  
> -	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
>  					      ads1015_trigger_handler,
>  					      &ads1015_buffer_setup_ops);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "iio triggered buffer setup failed\n");
> +		dev_err(dev, "iio triggered buffer setup failed\n");
>  		return ret;
>  	}
>  
> -	if (client->irq) {
> +	if (irq) {
>  		unsigned long irq_trig =
> -			irqd_get_trigger_type(irq_get_irq_data(client->irq));
> +			irqd_get_trigger_type(irq_get_irq_data(irq));
>  		unsigned int cfg_comp_mask = ADS1015_CFG_COMP_QUE_MASK |
>  			ADS1015_CFG_COMP_LAT_MASK | ADS1015_CFG_COMP_POL_MASK;
>  		unsigned int cfg_comp =
> @@ -1031,10 +971,10 @@ static int ads1015_probe(struct i2c_client *client,
>  		if (ret)
>  			return ret;
>  
> -		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +		ret = devm_request_threaded_irq(dev, irq,
>  						NULL, ads1015_event_handler,
>  						irq_trig | IRQF_ONESHOT,
> -						client->name, indio_dev);
> +						name, indio_dev);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1045,41 +985,43 @@ static int ads1015_probe(struct i2c_client *client,
>  
>  	data->conv_invalid = true;
>  
> -	ret = pm_runtime_set_active(&client->dev);
> +	ret = pm_runtime_set_active(dev);
>  	if (ret)
>  		return ret;
> -	pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
> -	pm_runtime_use_autosuspend(&client->dev);
> -	pm_runtime_enable(&client->dev);
> +	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_enable(dev);
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
> -		dev_err(&client->dev, "Failed to register IIO device\n");
> +		dev_err(dev, "Failed to register IIO device\n");
>  		return ret;
>  	}
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(ads1015_core_probe);
>  
> -static int ads1015_remove(struct i2c_client *client)
> +int ads1015_core_remove(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ads1015_data *data = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
>  
> -	pm_runtime_disable(&client->dev);
> -	pm_runtime_set_suspended(&client->dev);
> -	pm_runtime_put_noidle(&client->dev);
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_put_noidle(dev);
>  
>  	/* power down single shot mode */
>  	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
>  }
> +EXPORT_SYMBOL(ads1015_core_remove);
>  
>  #ifdef CONFIG_PM
>  static int ads1015_runtime_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ads1015_data *data = iio_priv(indio_dev);
>  
>  	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
> @@ -1087,7 +1029,7 @@ static int ads1015_runtime_suspend(struct device *dev)
>  
>  static int ads1015_runtime_resume(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ads1015_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> @@ -1099,43 +1041,11 @@ static int ads1015_runtime_resume(struct device *dev)
>  }
>  #endif
>  
> -static const struct dev_pm_ops ads1015_pm_ops = {
> +const struct dev_pm_ops ads1015_pm_ops = {
>  	SET_RUNTIME_PM_OPS(ads1015_runtime_suspend,
>  			   ads1015_runtime_resume, NULL)
>  };
> -
> -static const struct i2c_device_id ads1015_id[] = {
> -	{"ads1015", ADS1015},
> -	{"ads1115", ADS1115},
> -	{}
> -};
> -MODULE_DEVICE_TABLE(i2c, ads1015_id);
> -
> -static const struct of_device_id ads1015_of_match[] = {
> -	{
> -		.compatible = "ti,ads1015",
> -		.data = (void *)ADS1015
> -	},
> -	{
> -		.compatible = "ti,ads1115",
> -		.data = (void *)ADS1115
> -	},
> -	{}
> -};
> -MODULE_DEVICE_TABLE(of, ads1015_of_match);
> -
> -static struct i2c_driver ads1015_driver = {
> -	.driver = {
> -		.name = ADS1015_DRV_NAME,
> -		.of_match_table = ads1015_of_match,
> -		.pm = &ads1015_pm_ops,
> -	},
> -	.probe		= ads1015_probe,
> -	.remove		= ads1015_remove,
> -	.id_table	= ads1015_id,
> -};
> -
> -module_i2c_driver(ads1015_driver);
> +EXPORT_SYMBOL_GPL(ads1015_pm_ops);
>  
>  MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
>  MODULE_DESCRIPTION("Texas Instruments ADS1015 ADC driver");
> diff --git a/drivers/iio/adc/ti-ads1015.h b/drivers/iio/adc/ti-ads1015.h
> new file mode 100644
> index 000000000000..746f4cdc7637
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1015.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TI_ADS1015_H_
> +#define _TI_ADS1015_H_
> +
> +#define ADS1015_DRV_NAME "ads1015"
> +
> +#define ADS1015_CONV_REG	0x00
> +#define ADS1015_CFG_REG		0x01
> +#define ADS1015_LO_THRESH_REG	0x02
> +#define ADS1015_HI_THRESH_REG	0x03
> +
> +#define ADS1015_CFG_COMP_QUE_SHIFT	0
> +#define ADS1015_CFG_COMP_LAT_SHIFT	2
> +#define ADS1015_CFG_COMP_POL_SHIFT	3
> +#define ADS1015_CFG_COMP_MODE_SHIFT	4
> +#define ADS1015_CFG_DR_SHIFT	5
> +#define ADS1015_CFG_MOD_SHIFT	8
> +#define ADS1015_CFG_PGA_SHIFT	9
> +#define ADS1015_CFG_MUX_SHIFT	12
> +
> +#define ADS1015_CFG_COMP_QUE_MASK	GENMASK(1, 0)
> +#define ADS1015_CFG_COMP_LAT_MASK	BIT(2)
> +#define ADS1015_CFG_COMP_POL_MASK	BIT(3)
> +#define ADS1015_CFG_COMP_MODE_MASK	BIT(4)
> +#define ADS1015_CFG_DR_MASK	GENMASK(7, 5)
> +#define ADS1015_CFG_MOD_MASK	BIT(8)
> +#define ADS1015_CFG_PGA_MASK	GENMASK(11, 9)
> +#define ADS1015_CFG_MUX_MASK	GENMASK(14, 12)
> +
> +/* Comparator queue and disable field */
> +#define ADS1015_CFG_COMP_DISABLE	3
> +
> +/* Comparator polarity field */
> +#define ADS1015_CFG_COMP_POL_LOW	0
> +#define ADS1015_CFG_COMP_POL_HIGH	1
> +
> +/* Comparator mode field */
> +#define ADS1015_CFG_COMP_MODE_TRAD	0
> +#define ADS1015_CFG_COMP_MODE_WINDOW	1
> +
> +/* device operating modes */
> +#define ADS1015_CONTINUOUS	0
> +#define ADS1015_SINGLESHOT	1
> +
> +#define ADS1015_SLEEP_DELAY_MS		2000
> +#define ADS1015_DEFAULT_PGA		21
> +#define ADS1015_DEFAULT_DATA_RATE	4
> +#define ADS1015_DEFAULT_CHAN		0
> +
> +enum chip_ids {
> +	ADS1015,
> +	ADS1115,
> +};
> +
> +extern const struct regmap_config ads1015_regmap_config;
> +
> +int ads1015_core_probe(struct device *dev, struct regmap *regmap,
> +		       const char *name, int irq, unsigned int chip);
> +int ads1015_core_remove(struct device *dev);
> +
> +extern const struct dev_pm_ops ads1015_pm_ops;
> +
> +#endif /* _TI_ADS1015_H_ */
> diff --git a/drivers/iio/adc/ti-ads1015_i2c.c b/drivers/iio/adc/ti-ads1015_i2c.c
> new file mode 100644
> index 000000000000..68db9983a37f
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1015_i2c.c
> @@ -0,0 +1,80 @@
> +/*
> + * ADS1015 Texas Instruments ADC, I2C bits
> + *
> + * Copyright (C) 2018 Georgiana Chelu <georgiana.chelu93@gmail.com>
> + *
> + * IIO driver for ADS1015 ADC 7-bit I2C slave address:
> + *	* 0x48 - ADDR connected to Ground
> + *	* 0x49 - ADDR connected to Vdd
> + *	* 0x4A - ADDR connected to SDA
> + *	* 0x4B - ADDR connected to SCL
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>

Slight preference for alphabetical order in new code.
(it's rarely worth cleaning up in older drivers).

> +
> +#include "ti-ads1015.h"
> +
> +static int ads1015_i2c_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap;
> +	const char *name = NULL;
> +
> +	regmap = devm_regmap_init_i2c(client, &ads1015_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "failed to allocate i2c register map\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	if (id)
> +		name = id->name;

You don't want to end up with no name at all here...

> +
> +	return ads1015_core_probe(&client->dev, regmap, name,
> +				  client->irq, id->driver_data);
> +}
> +
> +static int ads1015_i2c_remove(struct i2c_client *client)
> +{
> +	return ads1015_core_remove(&client->dev);
> +}
> +
> +static const struct i2c_device_id ads1015_i2c_id[] = {
> +	{"ads1015", ADS1015},
> +	{"ads1115", ADS1115},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, ads1015_i2c_id);
> +
> +static const struct of_device_id ads1015_of_i2c_match[] = {
> +	{
> +		.compatible = "ti,ads1015",
> +		.data = (void *)ADS1015
> +	},
> +	{
> +		.compatible = "ti,ads1115",
> +		.data = (void *)ADS1115
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ads1015_of_i2c_match);
> +
> +static struct i2c_driver ads1015_i2c_driver = {
> +	.driver = {
> +		.name = ADS1015_DRV_NAME,
> +		.of_match_table = of_match_ptr(ads1015_of_i2c_match),
> +		.pm = &ads1015_pm_ops,
> +	},
> +	.probe		= ads1015_i2c_probe,
> +	.remove		= ads1015_i2c_remove,
> +	.id_table	= ads1015_i2c_id,
> +};
> +
> +module_i2c_driver(ads1015_i2c_driver);
> +
> +MODULE_AUTHOR("Georgiana Chelu <georgiana.chelu93@gmail.com>");

Hmm. I'd be tempted to keen Daniel as an author of this as well
(you can have two entries). Fundamentally you probably want him
to be pestered if anyone has trouble with the i2c bit not working.

> +MODULE_DESCRIPTION("Texas Instruments ADS1015 ADC driver I2C");
> +MODULE_LICENSE("GPL v2");
