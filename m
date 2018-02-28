Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932513AbeB1Sg6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:36:58 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40499 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbeB1Sgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:36:55 -0500
X-Google-Smtp-Source: AG47ELtqnRvhR90kfcjfDBrSLzr0NJrqoSaU4BXf/WCGPSvAvOEKb4BjPazYb/YBbGJ+DqQsp1CLb1Sb4VUNd1sz0BA=
MIME-Version: 1.0
In-Reply-To: <20180228181432.26847-5-manivannan.sadhasivam@linaro.org>
References: <20180228181432.26847-1-manivannan.sadhasivam@linaro.org> <20180228181432.26847-5-manivannan.sadhasivam@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2018 20:36:53 +0200
Message-ID: <CAHp75VchzV9SZb4g0fVP9aoKb7actsehXm8c4wsvVGASgkOc+w@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] pinctrl: actions: Add Actions S900 pinctrl driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>, amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 8:14 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add pinctrl driver for Actions Semi S900 SoC. The driver supports
> pinctrl, pinmux and pinconf functionalities through a range of registers
> common to both gpio driver and pinctrl driver.
>
> Pinmux functionality is available only for the pin groups while the
> pinconf functionality is available for both pin groups and individual
> pins.

> +static int owl_set_mux(struct pinctrl_dev *pctrldev,
> +                               unsigned int function,
> +                               unsigned int group)
> +{

> +       mfpval = readl(pctrl->base + g->mfpctl_reg);
> +       mfpval &= ~mask;
> +       mfpval |= val;
> +       writel(mfpval, pctrl->base + g->mfpctl_reg);

This is called owl_update_bits().

> +static int owl_pin_config_set(struct pinctrl_dev *pctrldev,
> +                               unsigned int pin,
> +                               unsigned long *configs,
> +                               unsigned int num_configs)
> +{

> +       int ret = 0;

Redundant assignment?

> +               mask = (1 << width) - 1;
> +               mask = mask << bit;
> +               tmp = readl(pctrl->base + reg);
> +               tmp &= ~mask;
> +               tmp |= arg << bit;
> +               writel(tmp, pctrl->base + reg);

This is called owl_update_bits().

> +}

> +static int owl_group_pinconf_val2arg(const struct owl_pingroup *g,
> +                               unsigned int param,
> +                               u32 *arg)
> +{

> +       case PIN_CONFIG_SLEW_RATE:
> +               if (*arg)
> +                       *arg = 1;
> +               else
> +                       *arg = 0;

Doesn't slew rate allow a non-binary value?

> +       return 0;
> +}
> +
> +static int owl_group_config_get(struct pinctrl_dev *pctrldev,
> +                               unsigned int group,
> +                               unsigned long *config)
> +{
> +       int ret = 0;

Redundant assignment.

> +}

> +static int owl_group_config_set(struct pinctrl_dev *pctrldev,
> +                               unsigned int group,
> +                               unsigned long *configs,
> +                               unsigned int num_configs)
> +{
> +       int ret = 0;

Redundant assignment, see below.

> +               mask = (1 << width) - 1;
> +               mask = mask << bit;
> +               tmp = readl(pctrl->base + reg);
> +               tmp &= ~mask;
> +               tmp |= arg << bit;
> +               writel(tmp, pctrl->base + reg);

This is called owl_update_bits().

> +       return ret;

return 0; ?

> +}

> +int owl_pinctrl_probe(struct platform_device *pdev,
> +                               struct owl_pinctrl_soc_data *soc_data)
> +{

> +       clk_prepare_enable(pctrl->clk);

This can fail.

> +}

> +static const struct of_device_id s900_pinctrl_of_match[] = {
> +       { .compatible = "actions,s900-pinctrl", },

> +       { },

No comma needed.

> +};

-- 
With Best Regards,
Andy Shevchenko
