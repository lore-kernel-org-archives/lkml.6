Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426236AbeCBKOh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:14:37 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34119 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424378AbeCBKOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:14:06 -0500
X-Google-Smtp-Source: AG47ELua2ZQ+tGjm9P5NxgVGJ5lJ71XqnU4z3qasMbflRj4e++7sqknnooDatAOCwrqNr+iAxfOzqsDWkmKrZ3r+6c4=
MIME-Version: 1.0
In-Reply-To: <1519321475-973-1-git-send-email-matheus@castello.eng.br>
References: <1519321475-973-1-git-send-email-matheus@castello.eng.br>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Mar 2018 11:14:05 +0100
Message-ID: <CACRpkdZc0ataQGWQ-81v1+_wCRpv=VVk195rafJcEQUFM5xfOg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bc2835: Add brcm,level property
To: Matheus Castello <matheus@castello.eng.br>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matheus,

sorry for top-posting, but new DT properties have to be ACKed
by the device tree maintainers, so quoting it all.

I understand why you use the legacy bcm-specific bindings for this,
but in theory nothing really stops you from just using
"output-high" and "output-low" from the generic properties,
even if you are not using the generic code to handle them but
instead parse them just like in this driver.

The only reason I could think of not to use them would be consistency,
like it would look not so elegant.

But if we look at the pin control bindings from a birds eye view
the big problem with consistency is the proliferation of custom
vendor bindings like this.

So there is a bit of conflict of interest here.

Yours,
Linus Walleij


On Thu, Feb 22, 2018 at 6:44 PM, Matheus Castello
<matheus@castello.eng.br> wrote:
> Property to set initial value of pin output buffer.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  .../bindings/pinctrl/brcm,bcm2835-gpio.txt         |  5 +-
>  drivers/pinctrl/bcm/pinctrl-bcm2835.c              | 90 +++++++++++++++++-----
>  2 files changed, 75 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
> index 2569866..6834f1d 100644
> --- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
> @@ -54,8 +54,11 @@ Optional subnode-properties:
>    0: none
>    1: down
>    2: up
> +- brcm,level: Integer, representing the value of output buffer to apply to the pin(s):
> +  0: low
> +  1: high
>
> -Each of brcm,function and brcm,pull may contain either a single value which
> +Each of brcm,function, brcm,pull and brcm,level may contain either a single value which
>  will be applied to all pins in brcm,pins, or 1 value for each entry in
>  brcm,pins.
>
> diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> index 785c366..0ace548 100644
> --- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> +++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> @@ -73,6 +73,8 @@
>  enum bcm2835_pinconf_param {
>         /* argument: bcm2835_pinconf_pull */
>         BCM2835_PINCONF_PARAM_PULL,
> +       /* argument: bcm2835_pinconf_level */
> +       BCM2835_PINCONF_PARAM_LEVEL,
>  };
>
>  #define BCM2835_PINCONF_PACK(_param_, _arg_) ((_param_) << 16 | (_arg_))
> @@ -725,16 +727,42 @@ static int bcm2835_pctl_dt_node_to_map_pull(struct bcm2835_pinctrl *pc,
>         return 0;
>  }
>
> +static int bcm2835_pctl_dt_node_to_map_level(struct bcm2835_pinctrl *pc,
> +               struct device_node *np, u32 pin, u32 level,
> +               struct pinctrl_map **maps)
> +{
> +       struct pinctrl_map *map = *maps;
> +       unsigned long *configs;
> +
> +       if (level > 2) {
> +               dev_err(pc->dev, "%pOF: invalid brcm,level %d\n", np, level);
> +               return -EINVAL;
> +       }
> +
> +       configs = kzalloc(sizeof(*configs), GFP_KERNEL);
> +       if (!configs)
> +               return -ENOMEM;
> +       configs[0] = BCM2835_PINCONF_PACK(BCM2835_PINCONF_PARAM_LEVEL, level);
> +
> +       map->type = PIN_MAP_TYPE_CONFIGS_PIN;
> +       map->data.configs.group_or_pin = bcm2835_gpio_pins[pin].name;
> +       map->data.configs.configs = configs;
> +       map->data.configs.num_configs = 1;
> +       (*maps)++;
> +
> +       return 0;
> +}
> +
>  static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
>                 struct device_node *np,
>                 struct pinctrl_map **map, unsigned *num_maps)
>  {
>         struct bcm2835_pinctrl *pc = pinctrl_dev_get_drvdata(pctldev);
> -       struct property *pins, *funcs, *pulls;
> -       int num_pins, num_funcs, num_pulls, maps_per_pin;
> +       struct property *pins, *funcs, *pulls, *levels;
> +       int num_pins, num_funcs, num_pulls, num_levels, maps_per_pin;
>         struct pinctrl_map *maps, *cur_map;
>         int i, err;
> -       u32 pin, func, pull;
> +       u32 pin, func, pull, level;
>
>         pins = of_find_property(np, "brcm,pins", NULL);
>         if (!pins) {
> @@ -744,6 +772,7 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
>
>         funcs = of_find_property(np, "brcm,function", NULL);
>         pulls = of_find_property(np, "brcm,pull", NULL);
> +       levels = of_find_property(np, "brcm,level", NULL);
>
>         if (!funcs && !pulls) {
>                 dev_err(pc->dev,
> @@ -755,6 +784,7 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
>         num_pins = pins->length / 4;
>         num_funcs = funcs ? (funcs->length / 4) : 0;
>         num_pulls = pulls ? (pulls->length / 4) : 0;
> +       num_levels = levels ? (levels->length / 4) : 0;
>
>         if (num_funcs > 1 && num_funcs != num_pins) {
>                 dev_err(pc->dev,
> @@ -770,11 +800,20 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
>                 return -EINVAL;
>         }
>
> +       if (num_levels > 1 && num_levels != num_pins) {
> +               dev_err(pc->dev,
> +                       "%pOF: brcm,level must have 1 or %d entries\n",
> +                       np, num_pins);
> +               return -EINVAL;
> +       }
> +
>         maps_per_pin = 0;
>         if (num_funcs)
>                 maps_per_pin++;
>         if (num_pulls)
>                 maps_per_pin++;
> +       if (num_levels)
> +               maps_per_pin++;
>         cur_map = maps = kzalloc(num_pins * maps_per_pin * sizeof(*maps),
>                                 GFP_KERNEL);
>         if (!maps)
> @@ -811,6 +850,17 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
>                         if (err)
>                                 goto out;
>                 }
> +               if (num_levels) {
> +                       err = of_property_read_u32_index(np, "brcm,level",
> +                                       (num_levels > 1) ? i : 0, &level);
> +                       if (err)
> +                               goto out;
> +
> +                       err = bcm2835_pctl_dt_node_to_map_level(pc, np, pin,
> +                                                       level, &cur_map);
> +                       if (err)
> +                               goto out;
> +               }
>         }
>
>         *map = maps;
> @@ -931,23 +981,25 @@ static int bcm2835_pinconf_set(struct pinctrl_dev *pctldev,
>                 param = BCM2835_PINCONF_UNPACK_PARAM(configs[i]);
>                 arg = BCM2835_PINCONF_UNPACK_ARG(configs[i]);
>
> -               if (param != BCM2835_PINCONF_PARAM_PULL)
> +               if (param == BCM2835_PINCONF_PARAM_PULL) {
> +                       off = GPIO_REG_OFFSET(pin);
> +                       bit = GPIO_REG_SHIFT(pin);
> +
> +                       bcm2835_gpio_wr(pc, GPPUD, arg & 3);
> +                       /*
> +                       * Docs say to wait 150 cycles, but not of what. We assume a
> +                       * 1 MHz clock here, which is pretty slow...
> +                       */
> +                       udelay(150);
> +                       bcm2835_gpio_wr(pc, GPPUDCLK0 + (off * 4), BIT(bit));
> +                       udelay(150);
> +                       bcm2835_gpio_wr(pc, GPPUDCLK0 + (off * 4), 0);
> +               } else if (param == BCM2835_PINCONF_PARAM_LEVEL) {
> +                       /* write in register */
> +                       bcm2835_gpio_set_bit(pc, arg ? GPSET0 : GPCLR0, pin);
> +               } else {
>                         return -EINVAL;
> -
> -               off = GPIO_REG_OFFSET(pin);
> -               bit = GPIO_REG_SHIFT(pin);
> -
> -               bcm2835_gpio_wr(pc, GPPUD, arg & 3);
> -               /*
> -                * BCM2835 datasheet say to wait 150 cycles, but not of what.
> -                * But the VideoCore firmware delay for this operation
> -                * based nearly on the same amount of VPU cycles and this clock
> -                * runs at 250 MHz.
> -                */
> -               udelay(1);
> -               bcm2835_gpio_wr(pc, GPPUDCLK0 + (off * 4), BIT(bit));
> -               udelay(1);
> -               bcm2835_gpio_wr(pc, GPPUDCLK0 + (off * 4), 0);
> +               }
>         } /* for each config */
>
>         return 0;
> --
> 2.7.4
>
