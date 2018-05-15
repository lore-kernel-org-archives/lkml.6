Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752361AbeEOV5B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:57:01 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:40780 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeEOV47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:56:59 -0400
X-Google-Smtp-Source: AB8JxZrGITfSUGFWJLbCJ57FhJ6SXK6d1GSN54/Pxv+tFVYQ+K4sy/fh/JbcM0ENAQo0gEzwTpshINaHIV2jW5tQ90g=
MIME-Version: 1.0
In-Reply-To: <20180515154352.20263-2-dmurphy@ti.com>
References: <20180515154352.20263-1-dmurphy@ti.com> <20180515154352.20263-2-dmurphy@ti.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 May 2018 00:56:58 +0300
Message-ID: <CAHp75VegjkiiD1qTGpi9rr6cg=72t9kSwDrG=sUpUWFVO58M4A@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] leds: lm3601x: Introduce the lm3601x LED driver
To: Dan Murphy <dmurphy@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 6:43 PM, Dan Murphy <dmurphy@ti.com> wrote:
> Introduce the family of LED devices that can
> drive a torch, strobe or IR LED.
>
> The LED driver can be configured with a strobe
> timer to execute a strobe flash.  The IR LED
> brightness is controlled via the torch brightness
> register.
>
> The data sheet for each the LM36010 and LM36011
> LED drivers can be found here:
> http://www.ti.com/product/LM36010
> http://www.ti.com/product/LM36011

> +       depends on LEDS_CLASS && I2C && OF

What is OF specific in this driver?


> +#define LM3601X_STRB_LVL_TRIG  ~BIT(3)

> +#define LM36010_BOOST_LIMIT_19 ~BIT(5)

> +#define LM36010_BOOST_FREQ_2MHZ        ~BIT(6)

> +#define LM36010_BOOST_MODE_NORM        ~BIT(7)

These looks rather strange. Shouldn't be just 0:s?

> +struct lm3601x_led {
> +       struct mutex lock;
> +       struct regmap *regmap;
> +       struct i2c_client *client;

> +       struct device_node *led_node;

Why do you need this?

> +};

> +static const struct lm3601x_max_timeouts strobe_timeouts[] = {
> +       { 40000, 0x00 },
> +       { 80000, 0x01 },
> +       { 120000, 0x02 },
> +       { 160000, 0x03 },
> +       { 200000, 0x04 },
> +       { 240000, 0x05 },
> +       { 280000, 0x06 },
> +       { 320000, 0x07 },
> +       { 360000, 0x08 },
> +       { 400000, 0x09 },
> +       { 600000, 0x0a },
> +       { 800000, 0x0b },
> +       { 1000000, 0x0c },
> +       { 1200000, 0x0d },
> +       { 1400000, 0x0e },
> +       { 1600000, 0x0f },

Huh?!

strobe_timeout = (x + 1) * 40 * MSECS_IN_SEC;

> +};

> +       struct lm3601x_led *led = fled_cdev_to_led(fled_cdev);
> +       int ret;
> +       int current_timeout;
> +       int reg_count;
> +       int i;
> +       int timeout_reg_val = 0;

Better to put lines here in reversed xmas tree order (longest first).

> +       reg_count = ARRAY_SIZE(strobe_timeouts);
> +       for (i = 0; i < reg_count; i++) {
> +               if (led->strobe_timeout > strobe_timeouts[i].timeout)
> +                       continue;

binary search?

Check lib/bsearch.c (IIRC).

But! See above the formula.

> +               brightness_val = (brightness/2);

Spaces.

> +static int lm3601x_register_leds(struct lm3601x_led *led)
> +{


> +       int err = -ENODEV;

Useless assignment.

> +       err = led_classdev_flash_register(&led->client->dev,
> +                       fled_cdev);
> +
> +       return err;

This is return led_...();

> +}

> +               ret = of_property_read_string(led->led_node, "label", &name);

device_property_...();

> +               if (!ret)

if (ret) sounds more natural. And better just to split

> +                       snprintf(led->led_name, sizeof(led->led_name),
> +                               "%s:%s", led->led_node->name, name);
> +               else
> +                       snprintf(led->led_name, sizeof(led->led_name),
> +                               "%s:torch", led->led_node->name);

const char *tmp;

ret = device_property_read_...(&tmp);
if (ret)
 tmp = ...
sprintf(...);

> +       led = devm_kzalloc(&client->dev,
> +                           sizeof(struct lm3601x_led), GFP_KERNEL);

sizeof(*led) and one line in the result

> +static const struct i2c_device_id lm3601x_id[] = {
> +       { "LM36010", CHIP_LM36010 },
> +       { "LM36011", CHIP_LM36011 },
> +       { },

Terminators better w/o comma.

> +};
> +MODULE_DEVICE_TABLE(i2c, lm3601x_id);
> +
> +static const struct of_device_id of_lm3601x_leds_match[] = {
> +       { .compatible = "ti,lm36010", },
> +       { .compatible = "ti,lm36011", },
> +       {},

Ditto.

> +};
> +MODULE_DEVICE_TABLE(of, of_lm3601x_leds_match);




-- 
With Best Regards,
Andy Shevchenko
