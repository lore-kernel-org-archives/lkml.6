Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeENJmp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751992AbeENJmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:42:44 -0400
X-Google-Smtp-Source: AB8JxZpXgeUoCZA0ndG3ytWTOMWO6uTXTgB64CaLI/4WTulPSSTTw0isPmb5zo1RTp7K9ARcyQi4Jpd1JzAW9BR0vLU=
MIME-Version: 1.0
In-Reply-To: <20180514080640.12515-11-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org> <20180514080640.12515-11-linus.walleij@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 14 May 2018 11:42:41 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfVuNXEpEAsGOTwp+ysGNw1r15rqi2kVF-VSEJ+vZfXuA@mail.gmail.com>
Message-ID: <CAJKOXPfVuNXEpEAsGOTwp+ysGNw1r15rqi2kVF-VSEJ+vZfXuA@mail.gmail.com>
Subject: Re: [PATCH 10/19 v3] regulator: s2mps11: Pass descriptor instead of
 GPIO number
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, Sangbeom Kim <sbkim73@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:06 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> Instead of passing a global GPIO number for the enable GPIO, pass
> a descriptor looked up with the standard devm_gpiod_get_optional()
> call.
>
> This regulator supports passing platform data, but enable/sleep
> regulators are looked up from the device tree exclusively, so
> we can need not touch other files.
>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sangbeom Kim <sbkim73@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Resending.
> ChangeLog v1->v2:
> - Rebase the patch on the other changes.
> ---
>  drivers/regulator/s2mps11.c | 46 ++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
> index 7726b874e539..9a1dca26362e 100644
> --- a/drivers/regulator/s2mps11.c
> +++ b/drivers/regulator/s2mps11.c
> @@ -18,7 +18,7 @@
>
>  #include <linux/bug.h>
>  #include <linux/err.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -27,7 +27,6 @@
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/of_regulator.h>
> -#include <linux/of_gpio.h>
>  #include <linux/mfd/samsung/core.h>
>  #include <linux/mfd/samsung/s2mps11.h>
>  #include <linux/mfd/samsung/s2mps13.h>
> @@ -57,7 +56,7 @@ struct s2mps11_info {
>          * Array (size: number of regulators) with GPIO-s for external
>          * sleep control.
>          */
> -       int *ext_control_gpio;
> +       struct gpio_desc **ext_control_gpiod;
>  };
>
>  static int get_ramp_delay(int ramp_delay)
> @@ -524,7 +523,7 @@ static int s2mps14_regulator_enable(struct regulator_dev *rdev)
>         case S2MPS14X:
>                 if (test_bit(rdev_get_id(rdev), s2mps11->suspend_state))
>                         val = S2MPS14_ENABLE_SUSPEND;
> -               else if (gpio_is_valid(s2mps11->ext_control_gpio[rdev_get_id(rdev)]))
> +               else if (s2mps11->ext_control_gpiod[rdev_get_id(rdev)])
>                         val = S2MPS14_ENABLE_EXT_CONTROL;
>                 else
>                         val = rdev->desc->enable_mask;
> @@ -818,7 +817,7 @@ static int s2mps14_pmic_enable_ext_control(struct s2mps11_info *s2mps11,
>  static void s2mps14_pmic_dt_parse_ext_control_gpio(struct platform_device *pdev,
>                 struct of_regulator_match *rdata, struct s2mps11_info *s2mps11)
>  {
> -       int *gpio = s2mps11->ext_control_gpio;
> +       struct gpio_desc **gpio = s2mps11->ext_control_gpiod;
>         unsigned int i;
>         unsigned int valid_regulators[3] = { S2MPS14_LDO10, S2MPS14_LDO11,
>                 S2MPS14_LDO12 };
> @@ -829,11 +828,20 @@ static void s2mps14_pmic_dt_parse_ext_control_gpio(struct platform_device *pdev,
>                 if (!rdata[reg].init_data || !rdata[reg].of_node)
>                         continue;
>
> -               gpio[reg] = of_get_named_gpio(rdata[reg].of_node,
> -                               "samsung,ext-control-gpios", 0);
> -               if (gpio_is_valid(gpio[reg]))
> -                       dev_dbg(&pdev->dev, "Using GPIO %d for ext-control over %d/%s\n",
> -                                       gpio[reg], reg, rdata[reg].name);
> +               gpio[reg] = devm_gpiod_get_from_of_node(&pdev->dev,
> +                                                       rdata[reg].of_node,
> +                                                       "samsung,ext-control-gpios",
> +                                                       0,
> +                                                       GPIOD_OUT_HIGH,
> +                                                       "s2mps11-LDO");

Now I noticed that the name is okay because GPIO control can be used
only for LDOs.

No need to change:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested on Odroid XU3 (with s2mps11 although not using any GPIOs for
regulators, so at least default paths are not broken):
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
