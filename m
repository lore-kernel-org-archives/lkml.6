Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752957AbeEGUOq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:14:46 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44088 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeEGUOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:14:43 -0400
X-Google-Smtp-Source: AB8JxZpLkospTtflaMZJMdYYBpwETKBpu3I+M5LWpWh76n5waT0F9SRBP+2qHM85Qx7iF/ItZigN6A==
Subject: Re: [PATCH 2/2] leds: Add Spreadtrum SC27xx breathing light
 controller driver
To: Baolin Wang <baolin.wang@linaro.org>, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: xiaotong.lu@spreadtrum.com, broonie@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <099f4075ec489e425b5f1e7668a078c05f0d8509.1525427961.git.baolin.wang@linaro.org>
 <1bf5bc3e007d237477d740f47ed63f05aa71b348.1525427961.git.baolin.wang@linaro.org>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <6c575d06-b37e-e04f-e830-d38a53927d6f@gmail.com>
Date: Mon, 7 May 2018 22:13:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1bf5bc3e007d237477d740f47ed63f05aa71b348.1525427961.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

Thank you for the patch. Generally this is a nice and clean driver,
but I noticed some locking related issues and one detail
regarding LED naming. Please refer below.

On 05/04/2018 12:08 PM, Baolin Wang wrote:
> From: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> 
> This patch adds Spreadtrum SC27xx PMIC series breathing light controller
> driver, which can support 3 LEDs. Each LED can work at normal PWM mode
> and breathing mode.
> 
> Signed-off-by: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>   drivers/leds/Kconfig            |   11 ++
>   drivers/leds/Makefile           |    1 +
>   drivers/leds/leds-sc27xx-bltc.c |  369 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 381 insertions(+)
>   create mode 100644 drivers/leds/leds-sc27xx-bltc.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 2c896c0..319449b 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -647,6 +647,17 @@ config LEDS_IS31FL32XX
>   	  LED controllers. They are I2C devices with multiple constant-current
>   	  channels, each with independent 256-level PWM control.
>   
> +config LEDS_SC27XX_BLTC
> +	tristate "LED support for the SC27xx breathing light controller"
> +	depends on LEDS_CLASS && MFD_SC27XX_PMIC
> +	depends on OF
> +	help
> +	  Say Y here to include support for the SC27xx breathing light controller
> +	  LEDs.
> +
> +	  This driver can also be built as a module. If so the module will be
> +	  called leds-sc27xx-bltc.
> +
>   comment "LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)"
>   
>   config LEDS_BLINKM
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 91eca81..ff6917e 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_LEDS_MLXREG)		+= leds-mlxreg.o
>   obj-$(CONFIG_LEDS_NIC78BX)		+= leds-nic78bx.o
>   obj-$(CONFIG_LEDS_MT6323)		+= leds-mt6323.o
>   obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
> +obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
>   
>   # LED SPI Drivers
>   obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
> diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
> new file mode 100644
> index 0000000..0016a87
> --- /dev/null
> +++ b/drivers/leds/leds-sc27xx-bltc.c
> @@ -0,0 +1,369 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Spreadtrum Communications Inc.
> + */

Please use uniform "//" comment style here.

> +
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +/* PMIC global control register definition */
> +#define SC27XX_MODULE_EN0	0xc08
> +#define SC27XX_CLK_EN0		0xc18
> +#define SC27XX_RGB_CTRL		0xebc
> +
> +#define SC27XX_BLTC_EN		BIT(9)
> +#define SC27XX_RTC_EN		BIT(7)
> +#define SC27XX_RGB_PD		BIT(0)
> +
> +/* Breathing light controller register definition */
> +#define SC27XX_LEDS_CTRL	0x00
> +#define SC27XX_LEDS_PRESCALE	0x04
> +#define SC27XX_LEDS_DUTY	0x08
> +#define SC27XX_LEDS_CURVE0	0x0c
> +#define SC27XX_LEDS_CURVE1	0x10
> +
> +#define SC27XX_CTRL_SHIFT	4
> +#define SC27XX_LED_RUN		BIT(0)
> +#define SC27XX_LED_TYPE		BIT(1)
> +
> +#define SC27XX_DUTY_SHIFT	8
> +#define SC27XX_DUTY_MASK	GENMASK(15, 0)
> +#define SC27XX_MOD_MASK		GENMASK(7, 0)
> +
> +#define SC27XX_CURVE_SHIFT	8
> +#define SC27XX_CURVE_L_MASK	GENMASK(7, 0)
> +#define SC27XX_CURVE_H_MASK	GENMASK(15, 8)
> +
> +#define SC27XX_LEDS_OFFSET	0x10
> +#define SC27XX_LEDS_MAX		3
> +
> +/*
> + * The SC27xx breathing light controller can support 3 outputs: red LED,
> + * green LED and blue LED. Each LED can support normal PWM mode and breathing
> + * mode.
> + *
> + * In breathing mode, the LED output curve includes raise, high, fall and low 4
> + * stages, and the duration of each stage is configurable.
> + */
> +enum sc27xx_led_config {
> +	SC27XX_RAISE_TIME,
> +	SC27XX_FALL_TIME,
> +	SC27XX_HIGH_TIME,
> +	SC27XX_LOW_TIME,
> +};
> +
> +struct sc27xx_led {
> +	struct led_classdev ldev;
> +	struct sc27xx_led_priv *priv;
> +	enum led_brightness value;
> +	u8 line;
> +	bool breath_mode;
> +	bool active;
> +};
> +
> +struct sc27xx_led_priv {
> +	struct sc27xx_led leds[SC27XX_LEDS_MAX];
> +	struct regmap *regmap;
> +	u32 base;
> +};
> +
> +#define to_sc27xx_led(ldev) \
> +	container_of(ldev, struct sc27xx_led, ldev)
> +
> +static int sc27xx_led_init(struct regmap *regmap)
> +{
> +	int err;
> +
> +	err = regmap_update_bits(regmap, SC27XX_MODULE_EN0, SC27XX_BLTC_EN,
> +				 SC27XX_BLTC_EN);
> +	if (err)
> +		return err;
> +
> +	err = regmap_update_bits(regmap, SC27XX_CLK_EN0, SC27XX_RTC_EN,
> +				 SC27XX_RTC_EN);
> +	if (err)
> +		return err;
> +
> +	return regmap_update_bits(regmap, SC27XX_RGB_CTRL, SC27XX_RGB_PD, 0);
> +}
> +
> +static u32 sc27xx_led_get_offset(struct sc27xx_led *leds)
> +{
> +	return leds->priv->base + SC27XX_LEDS_OFFSET * leds->line;
> +}
> +
> +static int sc27xx_led_enable(struct sc27xx_led *leds)
> +{
> +	u32 base = sc27xx_led_get_offset(leds);
> +	u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
> +	u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
> +	struct regmap *regmap = leds->priv->regmap;
> +	int err;
> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_DUTY,
> +				 SC27XX_DUTY_MASK,
> +				 (leds->value  << SC27XX_DUTY_SHIFT) |
> +				 SC27XX_MOD_MASK);
> +	if (err)
> +		return err;
> +
> +	if (leds->breath_mode)
> +		return regmap_update_bits(regmap, ctrl_base,
> +					  SC27XX_LED_RUN << ctrl_shift,
> +					  SC27XX_LED_RUN << ctrl_shift);
> +
> +	return regmap_update_bits(regmap, ctrl_base,
> +			(SC27XX_LED_RUN | SC27XX_LED_TYPE) << ctrl_shift,
> +			(SC27XX_LED_RUN | SC27XX_LED_TYPE) << ctrl_shift);
> +}
> +
> +static int sc27xx_led_disable(struct sc27xx_led *leds)
> +{
> +	u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
> +
> +	leds->breath_mode = false;
> +
> +	return regmap_update_bits(leds->priv->regmap,
> +			leds->priv->base + SC27XX_LEDS_CTRL,
> +			(SC27XX_LED_RUN | SC27XX_LED_TYPE) << ctrl_shift, 0);
> +}
> +
> +static int sc27xx_led_set(struct led_classdev *ldev, enum led_brightness value)
> +{
> +	struct sc27xx_led *leds = to_sc27xx_led(ldev);

You need mutex protection here to ensure that the device will
not be left in an inconsistent state in case of concurrent access
from userspace.

> +	leds->value = value;
> +	if (value == LED_OFF)
> +		return sc27xx_led_disable(leds);
> +
> +	return sc27xx_led_enable(leds);
> +}
> +
> +static int sc27xx_led_config(struct sc27xx_led *leds,
> +			     enum sc27xx_led_config config, u32 val)
> +{
> +	u32 base = sc27xx_led_get_offset(leds);
> +	struct regmap *regmap = leds->priv->regmap;
> +	int err;
> +
> +	switch (config) {
> +	case SC27XX_RAISE_TIME:
> +		err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
> +					 SC27XX_CURVE_L_MASK, val);
> +		break;
> +	case SC27XX_FALL_TIME:
> +		err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
> +					 SC27XX_CURVE_H_MASK,
> +					 val << SC27XX_CURVE_SHIFT);
> +		break;
> +	case SC27XX_HIGH_TIME:
> +		err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
> +					 SC27XX_CURVE_L_MASK, val);
> +		break;
> +	case SC27XX_LOW_TIME:
> +		err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
> +					 SC27XX_CURVE_H_MASK,
> +					 val << SC27XX_CURVE_SHIFT);
> +		break;
> +	default:
> +		err = -ENOTSUPP;
> +		break;
> +	}

Ditto.

> +
> +	if (!err && !leds->breath_mode)
> +		leds->breath_mode = true;
> +
> +	return err;
> +}
> +
> +static ssize_t raise_time_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t size)
> +{
> +	struct led_classdev *ldev = dev_get_drvdata(dev);
> +	struct sc27xx_led *leds = to_sc27xx_led(ldev);
> +	u32 val;
> +	int err;
> +
> +	if (kstrtou32(buf, 10, &val))
> +		return -EINVAL;
> +
> +	err = sc27xx_led_config(leds, SC27XX_RAISE_TIME, val);
> +	if (err)
> +		return err;
> +
> +	return size;
> +}
> +
> +static ssize_t fall_time_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t size)
> +{
> +	struct led_classdev *ldev = dev_get_drvdata(dev);
> +	struct sc27xx_led *leds = to_sc27xx_led(ldev);
> +	u32 val;
> +	int err;
> +
> +	if (kstrtou32(buf, 10, &val))
> +		return -EINVAL;
> +
> +	err = sc27xx_led_config(leds, SC27XX_FALL_TIME, val);
> +	if (err)
> +		return err;
> +
> +	return size;
> +}
> +
> +static ssize_t high_time_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t size)
> +{
> +	struct led_classdev *ldev = dev_get_drvdata(dev);
> +	struct sc27xx_led *leds = to_sc27xx_led(ldev);
> +	u32 val;
> +	int err;
> +
> +	if (kstrtou32(buf, 10, &val))
> +		return -EINVAL;
> +
> +	err = sc27xx_led_config(leds, SC27XX_HIGH_TIME, val);
> +	if (err)
> +		return err;
> +
> +	return size;
> +}
> +
> +static ssize_t low_time_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t size)
> +{
> +	struct led_classdev *ldev = dev_get_drvdata(dev);
> +	struct sc27xx_led *leds = to_sc27xx_led(ldev);
> +	u32 val;
> +	int err;
> +
> +	if (kstrtou32(buf, 10, &val))
> +		return -EINVAL;
> +
> +	err = sc27xx_led_config(leds, SC27XX_LOW_TIME, val);
> +	if (err)
> +		return err;
> +
> +	return size;
> +}
> +
> +static DEVICE_ATTR_WO(raise_time);
> +static DEVICE_ATTR_WO(fall_time);
> +static DEVICE_ATTR_WO(high_time);
> +static DEVICE_ATTR_WO(low_time);
> +
> +static struct attribute *sc27xx_led_attrs[] = {
> +	&dev_attr_raise_time.attr,
> +	&dev_attr_fall_time.attr,
> +	&dev_attr_high_time.attr,
> +	&dev_attr_low_time.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(sc27xx_led);

Please add ABI documentation for this sysfs interface.

> +static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
> +{
> +	int i, err;
> +
> +	err = sc27xx_led_init(priv->regmap);
> +	if (err)
> +		return err;
> +
> +	for (i = 0; i < SC27XX_LEDS_MAX; i++) {
> +		struct sc27xx_led *led = &priv->leds[i];
> +
> +		if (!led->active)
> +			continue;
> +
> +		led->line = i;
> +		led->priv = priv;
> +		led->ldev.brightness_set_blocking = sc27xx_led_set;
> +		led->ldev.max_brightness = LED_FULL;
> +		led->ldev.groups = sc27xx_led_groups;
> +
> +		err = devm_led_classdev_register(dev, &led->ldev);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sc27xx_led_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node, *child;
> +	struct sc27xx_led_priv *priv;
> +	u32 base, count, reg;
> +	int err;
> +
> +	count = of_get_child_count(np);
> +	if (!count || count > SC27XX_LEDS_MAX)
> +		return -EINVAL;
> +
> +	err = of_property_read_u32(np, "reg", &base);
> +	if (err) {
> +		dev_err(dev, "fail to get reg of property\n");
> +		return err;
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base = base;
> +	priv->regmap = dev_get_regmap(dev->parent, NULL);
> +	if (IS_ERR(priv->regmap)) {
> +		err = PTR_ERR(priv->regmap);
> +		dev_err(dev, "failed to get regmap: %d\n", err);
> +		return err;
> +	}
> +
> +	for_each_child_of_node(np, child) {
> +		err = of_property_read_u32(child, "reg", &reg);
> +		if (err) {
> +			of_node_put(child);
> +			return err;
> +		}
> +
> +		if (reg < 0 || reg >= SC27XX_LEDS_MAX
> +		    || priv->leds[reg].active) {
> +			of_node_put(child);
> +			return -EINVAL;
> +		}
> +
> +		priv->leds[reg].active = true;
> +		priv->leds[reg].ldev.name =
> +			of_get_property(child, "label", NULL) ? : child->name;

LED class device naming pattern requires devicename section.
Please use "sc27xx::" for the case when label is not available
and concatenate "sc27xx:" with the child->name otherwise.

You can refer to drivers/leds/leds-cr0014114.c in this regard.
We're sorting out issues around LED class device naming, so this
is quite new approach.

> +	}
> +
> +	return sc27xx_led_register(dev, priv);
> +}
> +
> +static const struct of_device_id sc27xx_led_of_match[] = {
> +	{ .compatible = "sprd,sc27xx-bltc", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sc27xx_led_of_match);
> +
> +static struct platform_driver sc27xx_led_driver = {
> +	.driver = {
> +		.name = "sc27xx-bltc",
> +		.of_match_table = sc27xx_led_of_match,
> +	},
> +	.probe = sc27xx_led_probe,
> +};
> +
> +module_platform_driver(sc27xx_led_driver);
> +
> +MODULE_DESCRIPTION("Spreadtrum SC27xx breathing light controller driver");
> +MODULE_AUTHOR("Xiaotong Lu <xiaotong.lu@spreadtrum.com>");
> +MODULE_LICENSE("GPL v2");
> 

-- 
Best regards,
Jacek Anaszewski
