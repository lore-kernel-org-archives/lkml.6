Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeEBM4q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:56:46 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39571 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeEBM4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:56:45 -0400
X-Google-Smtp-Source: AB8JxZr+tUdxxjaKrZFmls2gHW+i05mNQKm/VUwdfu59GhDU8NTnSl2J12IazBXUzjGxyYX83bR61Qb/Sv5Nxa8JHKY=
MIME-Version: 1.0
In-Reply-To: <1525201801-25682-2-git-send-email-matheus@castello.eng.br>
References: <201805011855.LvT1SKBS%fengguang.wu@intel.com> <1525201801-25682-1-git-send-email-matheus@castello.eng.br>
 <1525201801-25682-2-git-send-email-matheus@castello.eng.br>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 May 2018 14:56:44 +0200
Message-ID: <CACRpkdZRVEsDkYRHeR5X8pvKsuvAUktLdzmHvjF+cbMiRuyYDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: generic: add API to solve generic
 sub-node property name
To: Matheus Castello <matheus@castello.eng.br>
Cc: kbuild-all@01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 9:10 PM, Matheus Castello
<matheus@castello.eng.br> wrote:

> Set dt_params with the definitions of the generic sub-node properties
> global in pinconf-generic.h and add a function to pinconf-generic API
> to decode a packed param returning the string name from sub-node
> property.
>
> This can be useful in debug from pinctrl-vendor driver or even for
> debug in pinconf driver.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>

(...)

> +const char *pinconf_generic_get_param_property_name(struct pinctrl_dev *pctldev,
> +       unsigned int num_configs, unsigned long *param)
> +{
> +       struct pinctrl_desc *desc = pctldev->desc;
> +       unsigned int num_params = ARRAY_SIZE(pinconf_dt_params),
> +               num_custom_params = desc->num_custom_params,
> +               i, j;
> +
> +       for (i = 0; i < num_configs; i++) {
> +               enum pin_config_param pin_param =
> +               pinconf_to_config_param(param[i]);
> +
> +               /* first search on default properties */
> +               for (j = 0; j < num_params; j++) {
> +                       if (pin_param == pinconf_dt_params[j].param)
> +                               return pinconf_dt_params[j].property;
> +               }

If this is only for OF, we should rename the function to something including
*of* as well.

I would like it if you manage to break the dependency to OF though.

> +++ b/include/linux/pinctrl/pinconf-generic.h
>
> +static const struct pinconf_generic_params pinconf_dt_params[] = {
> +       { "bias-bus-hold", PIN_CONFIG_BIAS_BUS_HOLD, 0 },
> +       { "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
> +       { "bias-high-impedance", PIN_CONFIG_BIAS_HIGH_IMPEDANCE, 0 },
(...)

Is it really advisible to put big static constant arrays into header
files like this?

This will end up with a copy in each file where it is included and it is not a
small thing that gets replicated all over the place either.

What about just add it as extern and exporting the symbol if you
need it elsewhere?

Yours,
Linus Walleij
