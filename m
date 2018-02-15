Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031776AbeBOMxL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:53:11 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43337 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030360AbeBOMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:53:08 -0500
X-Google-Smtp-Source: AH8x226q1+/rV8HvQlbFpeko1SjMndTNojmktPfRRKuMDzmlTgznNHs+aLs6NU+EZsGsf6/pov1p6uITSEtZQdH1Ps8=
MIME-Version: 1.0
In-Reply-To: <20180215072450.7160-1-hdegoede@redhat.com>
References: <20180215072450.7160-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 15 Feb 2018 14:53:07 +0200
Message-ID: <CAHp75Veugd4U2kpSzuDdg65GaoanrZ7hL-5NaU-APNqAUnmFcQ@mail.gmail.com>
Subject: Re: [PATCH] extcon: intel-cht-wc: Also set direction and drv flags
 for V5 boost GPIO
To: Hans de Goede <hdegoede@redhat.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 9:24 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Sometimes (firmware bug?) the V5 boost GPIO is not configured as output
> by the BIOS, leading to the 5V boost convertor being permanently on,
>
> Explicitly set the direction and drv flags rather then inheriting them
> from the firmware to fix this.
>

FWIW,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/extcon/extcon-intel-cht-wc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> index 7c4bc8c44c3f..b7e9ea377d70 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -66,6 +66,8 @@
>
>  #define CHT_WC_VBUS_GPIO_CTLO          0x6e2d
>  #define CHT_WC_VBUS_GPIO_CTLO_OUTPUT   BIT(0)
> +#define CHT_WC_VBUS_GPIO_CTLO_DRV_OD   BIT(4)
> +#define CHT_WC_VBUS_GPIO_CTLO_DIR_OUT  BIT(5)
>
>  enum cht_wc_usb_id {
>         USB_ID_OTG,
> @@ -183,14 +185,15 @@ static void cht_wc_extcon_set_5v_boost(struct cht_wc_extcon_data *ext,
>  {
>         int ret, val;
>
> -       val = enable ? CHT_WC_VBUS_GPIO_CTLO_OUTPUT : 0;
> -
>         /*
>          * The 5V boost converter is enabled through a gpio on the PMIC, since
>          * there currently is no gpio driver we access the gpio reg directly.
>          */
> -       ret = regmap_update_bits(ext->regmap, CHT_WC_VBUS_GPIO_CTLO,
> -                                CHT_WC_VBUS_GPIO_CTLO_OUTPUT, val);
> +       val = CHT_WC_VBUS_GPIO_CTLO_DRV_OD | CHT_WC_VBUS_GPIO_CTLO_DIR_OUT;
> +       if (enable)
> +               val |= CHT_WC_VBUS_GPIO_CTLO_OUTPUT;
> +
> +       ret = regmap_write(ext->regmap, CHT_WC_VBUS_GPIO_CTLO, val);
>         if (ret)
>                 dev_err(ext->dev, "Error writing Vbus GPIO CTLO: %d\n", ret);
>  }
> --
> 2.14.3
>



-- 
With Best Regards,
Andy Shevchenko
