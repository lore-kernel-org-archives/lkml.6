Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeEBMvw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:51:52 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:53840 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeEBMvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:51:48 -0400
X-Google-Smtp-Source: AB8JxZpGLDc5RRxivzwJ5Aoh/vwLDyy6UFP/tW+89vg9jSZS46GdJWZQD75KHzwd898cskJOZLcvUm7RTHMRJ8pc7q8=
MIME-Version: 1.0
In-Reply-To: <1525201801-25682-3-git-send-email-matheus@castello.eng.br>
References: <201805011855.LvT1SKBS%fengguang.wu@intel.com> <1525201801-25682-1-git-send-email-matheus@castello.eng.br>
 <1525201801-25682-3-git-send-email-matheus@castello.eng.br>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 May 2018 14:51:47 +0200
Message-ID: <CACRpkda0cztaOQb0yfC-s96Lyw4dyADJz_qWmg8dVuK-exp6nA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: generic: improve apply_setting error verbosity
To: Matheus Castello <matheus@castello.eng.br>
Cc: kbuild-all@01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 9:10 PM, Matheus Castello
<matheus@castello.eng.br> wrote:

> For generic pinconf: print the dev_error with the pinctrl vendor
> driver name, error code, the sub-node property name used and the
> pin that was tried to set.
>
> Improves the undestading of the error if use a generic sub-node
> property that generic-pinconf can do parse but the vendor pinctrl
> driver does not support.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>

> +#include <linux/pinctrl/pinconf-generic.h>
>  #include "core.h"
>  #include "pinconf.h"
>
> @@ -169,9 +170,21 @@ int pinconf_apply_setting(const struct pinctrl_setting *setting)
>                                 setting->data.configs.configs,
>                                 setting->data.configs.num_configs);
>                 if (ret < 0) {
> +#ifdef CONFIG_OF

This doesn't seem right.

If this is restricted for OF only the root cause to why it is
like that needs to be found and the code refactored to fit anyone,
there is also ACPI support in the works I think, surely they should
be able to get verbose messages.

>                         dev_err(pctldev->dev,
> -                               "pin_config_set op failed for pin %d\n",
> +                               "%s error %d setting %s for pin %d\n",
> +                               pctldev->desc->name, ret,
> +                               pinconf_generic_get_param_property_name(
> +                                       pctldev, setting->data.configs.num_configs,
> +                                       setting->data.configs.configs),
>                                 setting->data.configs.group_or_pin);

This doesn't seem right. First argument is a %d, yet this
is pctldev->desc->name?

Something is fishy with the argument list.

Yours,
Linus Walleij
