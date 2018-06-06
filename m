Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdiOante"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3274605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeFFQCH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:02:07 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45245 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeFFQCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:02:05 -0400
X-Google-Smtp-Source: ADUXVKIUdvuVeHE+Zn4kpHBGZReqZBanYg2U0TXJnAkqASsOGByjKM+fGZN2/IiknkpDzVKrsqQntvotrJvRxUR4EFI=
MIME-Version: 1.0
In-Reply-To: <20180606134338.4645-1-colin.king@canonical.com>
References: <20180606134338.4645-1-colin.king@canonical.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 6 Jun 2018 19:02:03 +0300
Message-ID: <CAHp75Vd0Djw+nDN7u=-CLEfdDGA5QTsMueOb9EZLNnCDgso5fA@mail.gmail.com>
Subject: Re: [PATCH][next] pinctrl: pinctrl-single: add allocation failure
 checking of saved_vals
To: Colin King <colin.king@canonical.com>
Cc: Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 4:43 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently saved_vals is being allocated and there is no check for
> failed allocation (which is more likely than normal when using
> GFP_ATOMIC).  Fix this by checking for a failed allocation and
> propagating this error return down the the caller chain.
>
> Detected by CoverityScan, CID#1469841 ("Dereference null return value")
>
> Fixes: 88a1dbdec682 ("pinctrl: pinctrl-single: Add functions to save and restore pinctrl context")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pinctrl/pinctrl-single.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index 9c3c00515aa0..0905ee002041 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -1588,8 +1588,11 @@ static int pcs_save_context(struct pcs_device *pcs)
>
>         mux_bytes = pcs->width / BITS_PER_BYTE;
>
> -       if (!pcs->saved_vals)
> +       if (!pcs->saved_vals) {
>                 pcs->saved_vals = devm_kzalloc(pcs->dev, pcs->size, GFP_ATOMIC);

> +               if (!pcs->saved_vals)
> +                       return -ENOMEM;

Wouldn't make sense to move it out of the first condition?

Something like

if (!foo)
 foo = ...malloc(...);
if (!foo)
 return ...


> +       }
>
>         switch (pcs->width) {
>         case 64:
> @@ -1649,8 +1652,13 @@ static int pinctrl_single_suspend(struct platform_device *pdev,
>         if (!pcs)
>                 return -EINVAL;
>
> -       if (pcs->flags & PCS_CONTEXT_LOSS_OFF)
> -               pcs_save_context(pcs);
> +       if (pcs->flags & PCS_CONTEXT_LOSS_OFF) {
> +               int ret;
> +
> +               ret = pcs_save_context(pcs);
> +               if (ret < 0)
> +                       return ret;
> +       }
>
>         return pinctrl_force_sleep(pcs->pctl);
>  }



-- 
With Best Regards,
Andy Shevchenko
