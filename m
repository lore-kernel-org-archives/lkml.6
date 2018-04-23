Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753121AbeDWGqP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbeDWGqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:46:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9075F217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AIpwx48/TlT9hILVdP1MNiD/ZC3bixm7NbEYP6qxesdK3F6xSNLSqBgrqgrHaxLpr+8zKxmVURfIs6PS9RbvAu8lcvQ=
MIME-Version: 1.0
In-Reply-To: <20180422230742.3729-5-linus.walleij@linaro.org>
References: <20180422230742.3729-1-linus.walleij@linaro.org> <20180422230742.3729-5-linus.walleij@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 23 Apr 2018 08:46:11 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcasYujyBAN7zbsmE0rZXquP2dL_9fr1ZM+nCun3G-UrA@mail.gmail.com>
Message-ID: <CAJKOXPcasYujyBAN7zbsmE0rZXquP2dL_9fr1ZM+nCun3G-UrA@mail.gmail.com>
Subject: Re: [PATCH 05/18 v2] regulator: max77686: Pass descriptor instead of
 GPIO number
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 1:07 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> Instead of passing a global GPIO number, pass a descriptor looked
> up from the device tree configuration node.
>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Rebase the patch on the other changes.
> ---
>  drivers/regulator/max77686-regulator.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
> index c301f3733475..5ebd06f47e6a 100644
> --- a/drivers/regulator/max77686-regulator.c
> +++ b/drivers/regulator/max77686-regulator.c
> @@ -25,8 +25,7 @@
>  #include <linux/kernel.h>
>  #include <linux/bug.h>
>  #include <linux/err.h>
> -#include <linux/gpio.h>
> -#include <linux/of_gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/driver.h>
> @@ -90,6 +89,7 @@ enum max77686_ramp_rate {
>  };
>
>  struct max77686_data {
> +       struct device *dev;
>         DECLARE_BITMAP(gpio_enabled, MAX77686_REGULATORS);
>
>         /* Array indexed by regulator id */
> @@ -269,16 +269,20 @@ static int max77686_of_parse_cb(struct device_node *np,
>         case MAX77686_BUCK8:
>         case MAX77686_BUCK9:
>         case MAX77686_LDO20 ... MAX77686_LDO22:
> -               config->ena_gpio = of_get_named_gpio(np,
> -                                       "maxim,ena-gpios", 0);
> -               config->ena_gpio_flags = GPIOF_OUT_INIT_HIGH;
> -               config->ena_gpio_initialized = true;
> +               config->ena_gpiod = devm_gpiod_get_from_of_node(max77686->dev,
> +                                                               np,
> +                                                               "maxim,ena",
> +                                                               0,
> +                                                               GPIOD_OUT_HIGH,
> +                                                               "max77686-LDO");
> +               if (IS_ERR(config->ena_gpiod))
> +                       return PTR_ERR(config->ena_gpiod);

Both my previous comments remain not addressed:
1. Name: This is also for bucks so how about naming it "max77686-regulator"?
2. Error path here is not equivalent to old code and results in using
default driver's init data. Instead I would prefer to just ignore the
gpio.

Best regards,
Krzysztof

>                 break;
>         default:
>                 return 0;
>         }
>
> -       if (gpio_is_valid(config->ena_gpio)) {
> +       if (config->ena_gpiod) {
>                 set_bit(desc->id, max77686->gpio_enabled);
>
>                 return regmap_update_bits(config->regmap, desc->enable_reg,
> @@ -521,6 +525,7 @@ static int max77686_pmic_probe(struct platform_device *pdev)
>         if (!max77686)
>                 return -ENOMEM;
>
> +       max77686->dev = &pdev->dev;
>         config.dev = iodev->dev;
>         config.regmap = iodev->regmap;
>         config.driver_data = max77686;
> --
> 2.14.3
>
