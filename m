Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeCOESK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 00:18:10 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45348 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeCOESJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 00:18:09 -0400
X-Google-Smtp-Source: AG47ELtk477itQvUimcHWgmLQQxlQgfOwUh7oaoXvCsbpX/iSkKg70FGxw4nk4JAkEadIxaL3HN8pA==
Date: Wed, 14 Mar 2018 21:18:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, joel@jms.id.au, andy.shevchenko@gmail.com,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH v4 1/2] hwmon: (ucd9000) Add gpio chip interface
Message-ID: <20180315041807.GB17763@roeck-us.net>
References: <1521066734-7985-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1521066734-7985-2-git-send-email-eajames@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521066734-7985-2-git-send-email-eajames@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 05:32:13PM -0500, Eddie James wrote:
> From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> 
> Add a struct gpio_chip and define some methods so that this device's
> I/O can be accessed via /sys/class/gpio.
> 
> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>

This patch looks good to me. Any further comments ? Otherwise I'll
go ahead and apply to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/ucd9000.c | 201 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 201 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
> index b74dbec..a34ffc4 100644
> --- a/drivers/hwmon/pmbus/ucd9000.c
> +++ b/drivers/hwmon/pmbus/ucd9000.c
> @@ -27,6 +27,7 @@
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
>  #include <linux/pmbus.h>
> +#include <linux/gpio.h>
>  #include "pmbus.h"
>  
>  enum chips { ucd9000, ucd90120, ucd90124, ucd90160, ucd9090, ucd90910 };
> @@ -35,8 +36,18 @@
>  #define UCD9000_NUM_PAGES		0xd6
>  #define UCD9000_FAN_CONFIG_INDEX	0xe7
>  #define UCD9000_FAN_CONFIG		0xe8
> +#define UCD9000_GPIO_SELECT		0xfa
> +#define UCD9000_GPIO_CONFIG		0xfb
>  #define UCD9000_DEVICE_ID		0xfd
>  
> +/* GPIO CONFIG bits */
> +#define UCD9000_GPIO_CONFIG_ENABLE	BIT(0)
> +#define UCD9000_GPIO_CONFIG_OUT_ENABLE	BIT(1)
> +#define UCD9000_GPIO_CONFIG_OUT_VALUE	BIT(2)
> +#define UCD9000_GPIO_CONFIG_STATUS	BIT(3)
> +#define UCD9000_GPIO_INPUT		0
> +#define UCD9000_GPIO_OUTPUT		1
> +
>  #define UCD9000_MON_TYPE(x)	(((x) >> 5) & 0x07)
>  #define UCD9000_MON_PAGE(x)	((x) & 0x0f)
>  
> @@ -47,9 +58,15 @@
>  
>  #define UCD9000_NUM_FAN		4
>  
> +#define UCD9000_GPIO_NAME_LEN	16
> +#define UCD9090_NUM_GPIOS	23
> +#define UCD901XX_NUM_GPIOS	26
> +#define UCD90910_NUM_GPIOS	26
> +
>  struct ucd9000_data {
>  	u8 fan_data[UCD9000_NUM_FAN][I2C_SMBUS_BLOCK_MAX];
>  	struct pmbus_driver_info info;
> +	struct gpio_chip gpio;
>  };
>  #define to_ucd9000_data(_info) container_of(_info, struct ucd9000_data, info)
>  
> @@ -149,6 +166,188 @@ static int ucd9000_read_byte_data(struct i2c_client *client, int page, int reg)
>  };
>  MODULE_DEVICE_TABLE(of, ucd9000_of_match);
>  
> +static int ucd9000_gpio_read_config(struct i2c_client *client,
> +				    unsigned int offset)
> +{
> +	int ret;
> +
> +	/* No page set required */
> +	ret = i2c_smbus_write_byte_data(client, UCD9000_GPIO_SELECT, offset);
> +	if (ret < 0)
> +		return ret;
> +
> +	return i2c_smbus_read_byte_data(client, UCD9000_GPIO_CONFIG);
> +}
> +
> +static int ucd9000_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct i2c_client *client  = gpiochip_get_data(gc);
> +	int ret;
> +
> +	ret = ucd9000_gpio_read_config(client, offset);
> +	if (ret < 0)
> +		return ret;
> +
> +	return !!(ret & UCD9000_GPIO_CONFIG_STATUS);
> +}
> +
> +static void ucd9000_gpio_set(struct gpio_chip *gc, unsigned int offset,
> +			     int value)
> +{
> +	struct i2c_client *client = gpiochip_get_data(gc);
> +	int ret;
> +
> +	ret = ucd9000_gpio_read_config(client, offset);
> +	if (ret < 0) {
> +		dev_dbg(&client->dev, "failed to read GPIO %d config: %d\n",
> +			offset, ret);
> +		return;
> +	}
> +
> +	if (value) {
> +		if (ret & UCD9000_GPIO_CONFIG_STATUS)
> +			return;
> +
> +		ret |= UCD9000_GPIO_CONFIG_STATUS;
> +	} else {
> +		if (!(ret & UCD9000_GPIO_CONFIG_STATUS))
> +			return;
> +
> +		ret &= ~UCD9000_GPIO_CONFIG_STATUS;
> +	}
> +
> +	ret |= UCD9000_GPIO_CONFIG_ENABLE;
> +
> +	/* Page set not required */
> +	ret = i2c_smbus_write_byte_data(client, UCD9000_GPIO_CONFIG, ret);
> +	if (ret < 0) {
> +		dev_dbg(&client->dev, "Failed to write GPIO %d config: %d\n",
> +			offset, ret);
> +		return;
> +	}
> +
> +	ret &= ~UCD9000_GPIO_CONFIG_ENABLE;
> +
> +	ret = i2c_smbus_write_byte_data(client, UCD9000_GPIO_CONFIG, ret);
> +	if (ret < 0)
> +		dev_dbg(&client->dev, "Failed to write GPIO %d config: %d\n",
> +			offset, ret);
> +}
> +
> +static int ucd9000_gpio_get_direction(struct gpio_chip *gc,
> +				      unsigned int offset)
> +{
> +	struct i2c_client *client = gpiochip_get_data(gc);
> +	int ret;
> +
> +	ret = ucd9000_gpio_read_config(client, offset);
> +	if (ret < 0)
> +		return ret;
> +
> +	return !(ret & UCD9000_GPIO_CONFIG_OUT_ENABLE);
> +}
> +
> +static int ucd9000_gpio_set_direction(struct gpio_chip *gc,
> +				      unsigned int offset, bool direction_out,
> +				      int requested_out)
> +{
> +	struct i2c_client *client = gpiochip_get_data(gc);
> +	int ret, config, out_val;
> +
> +	ret = ucd9000_gpio_read_config(client, offset);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (direction_out) {
> +		out_val = requested_out ? UCD9000_GPIO_CONFIG_OUT_VALUE : 0;
> +
> +		if (ret & UCD9000_GPIO_CONFIG_OUT_ENABLE) {
> +			if ((ret & UCD9000_GPIO_CONFIG_OUT_VALUE) == out_val)
> +				return 0;
> +		} else {
> +			ret |= UCD9000_GPIO_CONFIG_OUT_ENABLE;
> +		}
> +
> +		if (out_val)
> +			ret |= UCD9000_GPIO_CONFIG_OUT_VALUE;
> +		else
> +			ret &= ~UCD9000_GPIO_CONFIG_OUT_VALUE;
> +
> +	} else {
> +		if (!(ret & UCD9000_GPIO_CONFIG_OUT_ENABLE))
> +			return 0;
> +
> +		ret &= ~UCD9000_GPIO_CONFIG_OUT_ENABLE;
> +	}
> +
> +	ret |= UCD9000_GPIO_CONFIG_ENABLE;
> +	config = ret;
> +
> +	/* Page set not required */
> +	ret = i2c_smbus_write_byte_data(client, UCD9000_GPIO_CONFIG, config);
> +	if (ret < 0)
> +		return ret;
> +
> +	config &= ~UCD9000_GPIO_CONFIG_ENABLE;
> +
> +	return i2c_smbus_write_byte_data(client, UCD9000_GPIO_CONFIG, config);
> +}
> +
> +static int ucd9000_gpio_direction_input(struct gpio_chip *gc,
> +					unsigned int offset)
> +{
> +	return ucd9000_gpio_set_direction(gc, offset, UCD9000_GPIO_INPUT, 0);
> +}
> +
> +static int ucd9000_gpio_direction_output(struct gpio_chip *gc,
> +					 unsigned int offset, int val)
> +{
> +	return ucd9000_gpio_set_direction(gc, offset, UCD9000_GPIO_OUTPUT,
> +					  val);
> +}
> +
> +static void ucd9000_probe_gpio(struct i2c_client *client,
> +			       const struct i2c_device_id *mid,
> +			       struct ucd9000_data *data)
> +{
> +	int rc;
> +
> +	switch (mid->driver_data) {
> +	case ucd9090:
> +		data->gpio.ngpio = UCD9090_NUM_GPIOS;
> +		break;
> +	case ucd90120:
> +	case ucd90124:
> +	case ucd90160:
> +		data->gpio.ngpio = UCD901XX_NUM_GPIOS;
> +		break;
> +	case ucd90910:
> +		data->gpio.ngpio = UCD90910_NUM_GPIOS;
> +		break;
> +	default:
> +		return; /* GPIO support is optional. */
> +	}
> +
> +	/*
> +	 * Pinmux support has not been added to the new gpio_chip.
> +	 * This support should be added when possible given the mux
> +	 * behavior of these IO devices.
> +	 */
> +	data->gpio.label = client->name;
> +	data->gpio.get_direction = ucd9000_gpio_get_direction;
> +	data->gpio.direction_input = ucd9000_gpio_direction_input;
> +	data->gpio.direction_output = ucd9000_gpio_direction_output;
> +	data->gpio.get = ucd9000_gpio_get;
> +	data->gpio.set = ucd9000_gpio_set;
> +	data->gpio.can_sleep = true;
> +	data->gpio.base = -1;
> +	data->gpio.parent = &client->dev;
> +
> +	rc = devm_gpiochip_add_data(&client->dev, &data->gpio, client);
> +	if (rc)
> +		dev_warn(&client->dev, "Could not add gpiochip: %d\n", rc);
> +}
> +
>  static int ucd9000_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -263,6 +462,8 @@ static int ucd9000_probe(struct i2c_client *client,
>  		  | PMBUS_HAVE_FAN34 | PMBUS_HAVE_STATUS_FAN34;
>  	}
>  
> +	ucd9000_probe_gpio(client, mid, data);
> +
>  	return pmbus_do_probe(client, mid, info);
>  }
>  
> -- 
> 1.8.3.1
> 
