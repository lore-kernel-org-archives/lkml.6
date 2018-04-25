Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755205AbeDYQtU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:49:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:30153 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754552AbeDYQtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:49:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="53597121"
Message-ID: <1524674952.21176.610.camel@linux.intel.com>
Subject: Re: [RFC PATCH RESEND 3/3] pinctrl: upboard: Add UP2 pinctrl and
 gpio driver
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Arteaga <javier@emutex.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: "Dan O'Donovan" <dan@emutex.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 25 Apr 2018 19:49:12 +0300
In-Reply-To: <20180421085009.28773-4-javier@emutex.com>
References: <20180421085009.28773-1-javier@emutex.com>
         <20180421085009.28773-4-javier@emutex.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-04-21 at 09:50 +0100, Javier Arteaga wrote:
> The UP2 board features a Raspberry Pi compatible pin header (HAT) and
> a
> board-specific expansion connector (EXHAT). Both expose assorted
> functions from either the SoC (such as GPIO, I2C, SPI, UART...) or
> other
> on-board devices (ADC, FPGA IP blocks...).
> 
> These lines are routed through an on-board FPGA. The platform
> controller
> in its stock firmware provides register fields to change:
> 
> - Line enable (FPGA pins enabled / high impedance)
> - Line direction (SoC driven / FPGA driven)
> 
> To enable using SoC GPIOs on the pin header, this arrangement requires
> both configuring the platform controller, and updating the SoC pad
> registers in sync.
> 
> Add a frontend pinctrl/GPIO driver that registers a new set of GPIO
> lines for the header pins. When these are requested, the driver
> propagates this request to the backend SoC pinctrl/GPIO driver by
> grabbing a GPIO descriptor for the matching SoC GPIO line. The needed
> mapping for this is retrieved via ACPI properties.
> 
> 

> For reference, here's the relevant ASL from the UP2 platform
> controller.

It should be in Documentation file or in commit message.


>  static const struct mfd_cell upboard_up2_mfd_cells[] = {
> +	{ .name = "upboard-pinctrl" },

I guess it should be 3 lines.

>  	UPBOARD_LED_CELL(upboard_up2_led_data, 0),
>  	UPBOARD_LED_CELL(upboard_up2_led_data, 1),
>  	UPBOARD_LED_CELL(upboard_up2_led_data, 2),

...and honestly I would not use this macro and put 4 cells explicitly
here.

> +static int upboard_gpio_request_enable(struct pinctrl_dev *pctldev,
> +				       struct pinctrl_gpio_range
> *range,
> +				       unsigned int pin)
> +{
> +	const struct pin_desc * const pd = pin_desc_get(pctldev,
> pin);
> +	const struct upboard_pin *p;
> +	int ret;
> +

> +	if (!pd)
> +		return -EINVAL;

When it's possible?

> +	p = pd->drv_data;

> +	return 0;
> +};

> +	if (!pd)
> +		return -EINVAL;

Ditto.

> +	struct upboard_pinctrl *pctrl =
> +		container_of(gc, struct upboard_pinctrl, chip);

Do define and use to_upboard_pinctrl().

> +	if (offset + 1 > pctrl->nsoc_gpios || !pctrl-
> >soc_gpios[offset])
> +		return ERR_PTR(-ENODEV);

When this is a case?

> +static int upboard_gpio_get_direction(struct gpio_chip *gc, unsigned
> int offset)
> +{
> +	struct gpio_desc *desc = upboard_offset_to_soc_gpio(gc,
> offset);
> +

Split above to definition and assignment pieces. Put assignment
immediately before condition.

> +	if (IS_ERR(desc))
> +		return PTR_ERR(desc);


> +
> +	return gpiod_get_direction(desc);
> +}

> +static struct regmap_field * __init upboard_field_alloc(struct device
> *dev,
> +							struct regmap
> *regmap,
> +							unsigned int
> base,
> +							unsigned int
> number)

You should really understand what __init means and when it's appropriate
to use it.

> +static int __init upboard_pinctrl_probe(struct platform_device *pdev)
> +{
> +	struct acpi_device * const adev = ACPI_COMPANION(&pdev->dev);

Huh, const in that place? Why?

> +	if (!pdev->dev.parent)
> +		return -EINVAL;
> +
> +	upboard = dev_get_drvdata(pdev->dev.parent);
> +	if (!upboard)
> +		return -EINVAL;

Same comment as per LED driver.

> +	if (strcmp(acpi_device_hid(adev), "AANT0F01"))
> +		return -ENODEV;

Huh?

> +		((struct pinctrl_pin_desc *)pd)->drv_data = pin;

What is that?! I mean ugly casting.

> +	}

> +}

> +MODULE_LICENSE("GPL");

License mismatch.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
