Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755727AbeDYP5n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:57:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:55535 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932093AbeDYP5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:57:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="49869217"
Message-ID: <1524671850.21176.585.camel@linux.intel.com>
Subject: Re: [RFC PATCH RESEND 1/3] mfd: upboard: Add UP2 platform
 controller driver
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Arteaga <javier@emutex.com>, Lee Jones <lee.jones@linaro.org>
Cc: "Dan O'Donovan" <dan@emutex.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 25 Apr 2018 18:57:30 +0300
In-Reply-To: <20180421085009.28773-2-javier@emutex.com>
References: <20180421085009.28773-1-javier@emutex.com>
         <20180421085009.28773-2-javier@emutex.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-04-21 at 09:50 +0100, Javier Arteaga wrote:
> UP Squared (UP2) is a x86 SBC from AAEON based on Intel Apollo Lake. 

> +config MFD_UPBOARD
> +	tristate "UP Squared"
> +	depends on ACPI
> +	depends on GPIOLIB
> +	select MFD_CORE
> +	select REGMAP
> +	help
> +	  If you say yes here you get support for the platform
> controller
> +	  of the UP Squared single-board computer.
> +
> +	  This driver provides common support for accessing the
> device,
> +	  additional drivers must be enabled in order to use the
> +	  functionality of the device.
> +
> +	  This driver can also be built as a module. If so, the
> module
> +	  will be called upboard.

"upboard"

> 
> +static int upboard_read(void *context, unsigned int reg, unsigned int
> *val)
> +{
> +	const struct upboard * const upboard = context;
> +	int i;
> +
> +	gpiod_set_value(upboard->clear_gpio, 0);
> +	gpiod_set_value(upboard->clear_gpio, 1);
> +
> +	reg |= UPBOARD_READ_FLAG;
> +
> +	for (i = UPBOARD_ADDRESS_SIZE; i >= 0; i--) {
> +		gpiod_set_value(upboard->strobe_gpio, 0);
> +		gpiod_set_value(upboard->datain_gpio, (reg >> i) &
> 0x1);
> +		gpiod_set_value(upboard->strobe_gpio, 1);
> +	}
> +

> +	gpiod_set_value(upboard->strobe_gpio, 0);
> +	*val = 0;
> +
> +	for (i = UPBOARD_REGISTER_SIZE - 1; i >= 0; i--) {
> +		gpiod_set_value(upboard->strobe_gpio, 1);
> +		gpiod_set_value(upboard->strobe_gpio, 0);
> +		*val |= gpiod_get_value(upboard->dataout_gpio) << i;
> +	}
> +
> +	gpiod_set_value(upboard->strobe_gpio, 1);

Can't you rewrite this like

for (addr) {
 strobe(0)
 data(x)
 strobe(1)
}

for (register) {
 strobe(0)
 val = data(x)
 strobe(1)
}

val &= BIT(register_size);
strobe(0)

?

> +
> +	return 0;
> +};
> +
> +static int upboard_write(void *context, unsigned int reg, unsigned
> int val)
> +{
> +	const struct upboard * const upboard = context;
> +	int i;
> +
> +	gpiod_set_value(upboard->clear_gpio, 0);
> +	gpiod_set_value(upboard->clear_gpio, 1);
> +
> +	for (i = UPBOARD_ADDRESS_SIZE; i >= 0; i--) {
> +		gpiod_set_value(upboard->strobe_gpio, 0);
> +		gpiod_set_value(upboard->datain_gpio, (reg >> i) &
> 0x1);
> +		gpiod_set_value(upboard->strobe_gpio, 1);
> +	}
> +
> +	gpiod_set_value(upboard->strobe_gpio, 0);
> +
> +	for (i = UPBOARD_REGISTER_SIZE - 1; i >= 0; i--) {
> +		gpiod_set_value(upboard->datain_gpio, (val >> i) &
> 0x1);
> +		gpiod_set_value(upboard->strobe_gpio, 1);
> +		gpiod_set_value(upboard->strobe_gpio, 0);
> +	}
> +
> +	gpiod_set_value(upboard->strobe_gpio, 1);

Similar here:

for (addr) {
 strobe(0)
 data(x)
 strobe(1)
}

for (register) {
 strobe(0)
 data(x)
 strobe(1)
}

strobe(0)
strobe(1)

?

> +
> +	return 0;
> +};

Moreover these two functions have duplications, i.e.

static ... upboard_clear()
{
 clear(0)
 clear(1)
}

static ... upboard_set_address()
{
 for (addr) {
  ...
 }
}


Additional question is about spi-bitbang and i2c-gpio. Can one of them
be utilized here? Why not?

> +struct upboard_data {
> +	const struct regmap_config *regmapconf;
> +	const struct mfd_cell *cells;
> +	size_t ncells;
> +};

> +static int upboard_init_gpio(struct upboard *upboard)
> +{
> +	struct gpio_desc *enable_gpio;
> +
> +	enable_gpio = devm_gpiod_get(upboard->dev, "enable",
> GPIOD_OUT_LOW);
> +	if (IS_ERR(enable_gpio))
> +		return PTR_ERR(enable_gpio);

> +	gpiod_set_value(enable_gpio, 1);

When do you disable it? Why not?

> +	return 0;
> +}

> +
> +static int upboard_check_supported(struct upboard *upboard)
> +{

> +	const unsigned int AAEON_MANUFACTURER_ID = 0x01;
> +	const unsigned int SUPPORTED_FW_MAJOR = 0x0;

Why to hide here instead of putting at the top of file as defined
constants?

> +	unsigned int platform_id, manufacturer_id;
> +	unsigned int firmware_id, build, major, minor, patch;
> +	int ret;

> +	build = (firmware_id >> 12) & 0xf;
> +	major = (firmware_id >> 8) & 0xf;
> +	minor = (firmware_id >> 4) & 0xf;

> +	patch = firmware_id & 0xf;

For style purposes you can use
(firmware >> 0) & 0xf here

> +static int upboard_probe(struct platform_device *pdev)
> +{
> +	struct upboard *upboard;
> +	const struct acpi_device_id *id;
> +	const struct upboard_data *upboard_data;
> +	int ret;

> +	id = acpi_match_device(upboard_acpi_match, &pdev->dev);
> +	if (!id)
> +		return -ENODEV;
> +
> +	upboard_data = (const struct upboard_data *) id->driver_data;

Use new API for that.

> +MODULE_LICENSE("GPL");

License mismatch.

> +#define UPBOARD_ADDRESS_SIZE  7
> +#define UPBOARD_REGISTER_SIZE 16

> +#define UPBOARD_READ_FLAG     BIT(UPBOARD_ADDRESS_SIZE)

It's not clear why this one is defined in this way.
Comment is needed.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
