Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeEUWzy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:55:54 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33914 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeEUWzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:55:53 -0400
X-Google-Smtp-Source: AB8JxZoZCqKlUeZRecAWrW4wSrjr4sLZrx44/ue28lJYzOMFRGyASdmtnm5Kl8Gd/M9BJMJVYYe7O2Z6Z7/HfLmr46E=
MIME-Version: 1.0
In-Reply-To: <20180521223503.152131-1-evgreen@chromium.org>
References: <20180521223503.152131-1-evgreen@chromium.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 01:55:51 +0300
Message-ID: <CAHp75VdsMNn29TFDYXerZQfhCm6uiGHid8ZX7HOCygXNkmJDVA@mail.gmail.com>
Subject: Re: [PATCH] mmc: Allow non-sleeping GPIO cd
To: Evan Green <evgreen@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 1:35 AM, Evan Green <evgreen@chromium.org> wrote:

Some style concerns.

>  int mmc_gpio_get_cd(struct mmc_host *host)
>  {

> +       int can_sleep;
>         struct mmc_gpio *ctx = host->slot.handler_priv;

I would rather name it

int cansleep;

and put after ctx definition.

>
>         if (!ctx || !ctx->cd_gpio)
>                 return -ENOSYS;
>
> -       if (ctx->override_cd_active_level)
> -               return !gpiod_get_raw_value_cansleep(ctx->cd_gpio) ^
> -                       !!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
> +       can_sleep = gpiod_cansleep(ctx->cd_gpio);
> +       if (ctx->override_cd_active_level) {
> +               int value = can_sleep ?
> +                               gpiod_get_raw_value_cansleep(ctx->cd_gpio) :
> +                               gpiod_get_raw_value(ctx->cd_gpio);
> +               return !value ^ !!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
> +       }
>
> -       return gpiod_get_value_cansleep(ctx->cd_gpio);

> +       return can_sleep ? gpiod_get_value_cansleep(ctx->cd_gpio) :
> +                       gpiod_get_value(ctx->cd_gpio);

Perhaps same style as you use above woule be better, i.e.

retrun cansleep ?
  true_path:
  false_path;

>  }
>  EXPORT_SYMBOL(mmc_gpio_get_cd);

-- 
With Best Regards,
Andy Shevchenko
