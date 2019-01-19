Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C69C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4813B2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 09:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNJ+P1gZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfASJDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 04:03:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35093 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfASJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 04:03:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so7801491pfi.2;
        Sat, 19 Jan 2019 01:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9M1wCNl8YpRcoA4cb+0eFiTwivkJFx0Z7VkQXX2cA/c=;
        b=SNJ+P1gZ2AVFp/IHQfyHr56/McDQO6Hwd7ytY1CbALh92NjJCDdhuPEX8xi3/hQjUc
         aoNLSoaAUGMD3n2VNLkKh70nen5+eLD+CQ0WHdetp98bQTtrmh26OXSeaofyj4m1eFN6
         g9LzlM9L2oT/n/csW08aCll25g1BswBBk6g5eY+4BB6yoYuQRl2FyHRvFgcQeD+ZhlZ+
         btBt9QMckWmtY+7JYij39vwuDvCdrzt0OdGR0xktnT/bJ2S648p730+IOyMURAjLIITW
         41/hCH6H7hxNQzCXwjCn7n1jLs/W4r9YXo3T1kFJnu6eTfGXJoAoIveNZTcwj8O7SwcK
         P8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9M1wCNl8YpRcoA4cb+0eFiTwivkJFx0Z7VkQXX2cA/c=;
        b=pk1JeoXpyRskLdTxxvbUhUINeAh774h+FL4IQAdgRl094vjgUgQM3rpwihXRG/2ogg
         gNSkqffhIOo9uegw5Cg916G72tUhqEBIu3J2VCXLA8lvWBobmeYH4nCNFF5sWeIJmv0Q
         /LRinQPsiM9dN8ASTgzAlZcrEkGv5/35fusEC0u3Ahg5I3JJ/zWFLfOasZ2xOKprXWFH
         Slzaa6Jq/96xCJ3Il79B/x/wb66IPgGhZ1hiG8W/12kKSYbuVevQw/3g3lIQQhjMwZLT
         z6m6X+bbCGbx3arzy4Cfnm6YsjlZ4d55XqvNXFGkEXX5xa2Q2Adwd8OU7bqkexZV47q5
         3Juw==
X-Gm-Message-State: AJcUukd9QWFKZUIkl1cqo2glYztoaKiZ0Sh/xGCUg5MyIm3bxr8CcTkv
        7RlvNRj5tWdpCSkqvikMkl0=
X-Google-Smtp-Source: ALg8bN4x68s/ZB3NjLiJyjGJGfLKHqWKk0rtMJ0d3C05Fj32WbBW1ur1v93TcLT+HFqxQ0BgeGn+AA==
X-Received: by 2002:a62:1c7:: with SMTP id 190mr22649074pfb.46.1547888601616;
        Sat, 19 Jan 2019 01:03:21 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w185sm9640452pfb.135.2019.01.19.01.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Jan 2019 01:03:20 -0800 (PST)
Date:   Sat, 19 Jan 2019 01:03:18 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 12/13] input: max77650: add onkey support
Message-ID: <20190119090318.GB187380@dtor-ws>
References: <20190118134244.22253-1-brgl@bgdev.pl>
 <20190118134244.22253-13-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118134244.22253-13-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On Fri, Jan 18, 2019 at 02:42:43PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add support for the push- and slide-button events for max77650.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/input/misc/Kconfig          |   9 ++
>  drivers/input/misc/Makefile         |   1 +
>  drivers/input/misc/max77650-onkey.c | 135 ++++++++++++++++++++++++++++
>  3 files changed, 145 insertions(+)
>  create mode 100644 drivers/input/misc/max77650-onkey.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index ca59a2be9bc5..bb9c45c1269e 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -180,6 +180,15 @@ config INPUT_M68K_BEEP
>  	tristate "M68k Beeper support"
>  	depends on M68K
>  
> +config INPUT_MAX77650_ONKEY
> +	tristate "Maxim MAX77650 ONKEY support"
> +	depends on MFD_MAX77650
> +	help
> +	  Support the ONKEY of the MAX77650 PMIC as an input device.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called max77650-onkey.
> +
>  config INPUT_MAX77693_HAPTIC
>  	tristate "MAXIM MAX77693/MAX77843 haptic controller support"
>  	depends on (MFD_MAX77693 || MFD_MAX77843) && PWM
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 9d0f9d1ff68f..5bd53590ce60 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
>  obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
>  obj-$(CONFIG_INPUT_KXTJ9)		+= kxtj9.o
>  obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
> +obj-$(CONFIG_INPUT_MAX77650_ONKEY)	+= max77650-onkey.o
>  obj-$(CONFIG_INPUT_MAX77693_HAPTIC)	+= max77693-haptic.o
>  obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
>  obj-$(CONFIG_INPUT_MAX8997_HAPTIC)	+= max8997_haptic.o
> diff --git a/drivers/input/misc/max77650-onkey.c b/drivers/input/misc/max77650-onkey.c
> new file mode 100644
> index 000000000000..cc7e83f589cd
> --- /dev/null
> +++ b/drivers/input/misc/max77650-onkey.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 BayLibre SAS
> + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> + *
> + * ONKEY driver for MAXIM 77650/77651 charger/power-supply.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/max77650.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define MAX77650_ONKEY_MODE_MASK	BIT(3)
> +#define MAX77650_ONKEY_MODE_PUSH	0x00
> +#define MAX77650_ONKEY_MODE_SLIDE	BIT(3)
> +
> +struct max77650_onkey {
> +	struct input_dev *input;
> +	unsigned int code;
> +};
> +
> +static irqreturn_t
> +max77650_onkey_report(struct max77650_onkey *onkey, int value)
> +{
> +	input_report_key(onkey->input, onkey->code, value);
> +	input_sync(onkey->input);
> +
> +	return IRQ_HANDLED;

It is weird that report function returns irqreturn_t. I'd simply moved
input_report_key()/input_sync() into real IRQ handlers.

> +}
> +
> +static irqreturn_t max77650_onkey_falling(int irq, void *data)
> +{
> +	struct max77650_onkey *onkey = data;
> +
> +	return max77650_onkey_report(onkey, 0);
> +}
> +
> +static irqreturn_t max77650_onkey_rising(int irq, void *data)
> +{
> +	struct max77650_onkey *onkey = data;
> +
> +	return max77650_onkey_report(onkey, 1);
> +}
> +
> +static int max77650_onkey_probe(struct platform_device *pdev)
> +{
> +	struct regmap_irq_chip_data *irq_data;
> +	struct max77650_onkey *onkey;
> +	struct device *dev, *parent;
> +	int irq_r, irq_f, rv, mode;

Please call "rv" "error".

> +	struct i2c_client *i2c;
> +	const char *mode_prop;
> +	struct regmap *map;
> +
> +	dev = &pdev->dev;
> +	parent = dev->parent;
> +	i2c = to_i2c_client(parent);
> +	irq_data = i2c_get_clientdata(i2c);
> +
> +	map = dev_get_regmap(parent, NULL);
> +	if (!map)
> +		return -ENODEV;
> +
> +	onkey = devm_kzalloc(dev, sizeof(*onkey), GFP_KERNEL);
> +	if (!onkey)
> +		return -ENOMEM;
> +
> +	rv = device_property_read_u32(dev, "linux,code", &onkey->code);
> +	if (rv)
> +		onkey->code = KEY_POWER;
> +
> +	rv = device_property_read_string(dev, "maxim,onkey-mode", &mode_prop);
> +	if (rv)
> +		mode_prop = "push";
> +
> +	if (strcmp(mode_prop, "push") == 0)
> +		mode = MAX77650_ONKEY_MODE_PUSH;
> +	else if (strcmp(mode_prop, "slide") == 0)
> +		mode = MAX77650_ONKEY_MODE_SLIDE;
> +	else
> +		return -EINVAL;
> +
> +	rv = regmap_update_bits(map, MAX77650_REG_CNFG_GLBL,
> +				MAX77650_ONKEY_MODE_MASK, mode);
> +	if (rv)
> +		return rv;
> +
> +	irq_f = regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_F);
> +	if (irq_f <= 0)
> +		return -EINVAL;
> +
> +	irq_r = regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_R);
> +	if (irq_r <= 0)
> +		return -EINVAL;

Ugh, it would be better if you handled IRQ mapping in the MFD piece and
passed it as resources of platform device. Then you'd simply call
platform_get_irq() here and did not have to reach into parent device for
"irq_dara".

> +
> +	onkey->input = devm_input_allocate_device(dev);
> +	if (!onkey->input)
> +		return -ENOMEM;
> +
> +	onkey->input->name = "max77650_onkey";
> +	onkey->input->phys = "max77650_onkey/input0";
> +	onkey->input->id.bustype = BUS_I2C;
> +	onkey->input->dev.parent = dev;

Not needed since devm_input_allocate_device sets parent for you.

> +	input_set_capability(onkey->input, EV_KEY, onkey->code);
> +
> +	rv = devm_request_threaded_irq(dev, irq_f, NULL,

Why threaded interrupt with only hard interrupt handler? If parent
interrupt is threaded use "any_context_irq" here.

> +				       max77650_onkey_falling,
> +				       IRQF_ONESHOT, "onkey-down", onkey);

Why do you need oneshot with interrupt that is essentially not threaded?

> +	if (rv)
> +		return rv;
> +
> +	rv = devm_request_threaded_irq(dev, irq_r, NULL,
> +				       max77650_onkey_rising,
> +				       IRQF_ONESHOT, "onkey-up", onkey);
> +	if (rv)
> +		return rv;
> +
> +	return input_register_device(onkey->input);
> +}
> +
> +static struct platform_driver max77650_onkey_driver = {
> +	.driver = {
> +		.name = "max77650-onkey",
> +	},
> +	.probe = max77650_onkey_probe,
> +};
> +module_platform_driver(max77650_onkey_driver);
> +
> +MODULE_DESCRIPTION("MAXIM 77650/77651 ONKEY driver");
> +MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
> +MODULE_LICENSE("GPL");

SPDX header say GPL-2.0 so please "GPL v2" here as "GPL" means v2 and
later.

Thanks.

-- 
Dmitry
