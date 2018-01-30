Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeA3Jam (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:30:42 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44372 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeA3Jai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:30:38 -0500
X-Google-Smtp-Source: AH8x225UajiOD4769PVdA6rQfo/xNuteTOn2ZjJRTZTipDYjIHZYhTuh9gmCDhG+FRe9/Fe4P7qMlbobtmcFjjRu/GQ=
MIME-Version: 1.0
In-Reply-To: <20171201120651.29633-1-enric.balletbo@collabora.com>
References: <20171201120651.29633-1-enric.balletbo@collabora.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Tue, 30 Jan 2018 10:30:36 +0100
Message-ID: <CAFqH_531DL3DYp4kn_Gjxprp7NNoAnP4MMD4-PRN=yJ+mXJNnA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] pwm-backlight: enable/disable the PWM before/after
 LCD enable toggle.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-fbdev@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2017-12-01 13:06 GMT+01:00 Enric Balletbo i Serra
<enric.balletbo@collabora.com>:
> Before this patch the enable signal was set before the PWM signal and
> vice-versa on power off. This sequence is wrong, at least, it is on
> the different panels datasheets that I checked, so I inverted the sequence
> to follow the specs.
>
> For reference the following panels have the mentioned sequence:
>   - N133HSE-EA1 (Innolux)
>   - N116BGE (Innolux)
>   - N156BGE-L21 (Innolux)
>   - B101EAN0 (Auo)
>   - B101AW03 (Auo)
>   - LTN101NT05 (Samsung)
>   - CLAA101WA01A (Chunghwa)
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> ---
> Changes since v4:
>  - Rebase on top of mainline.
>  - Add the acks from Daniel Thompson and Jingoo Han.
> Changes since v3:
>  - List the part numbers for the panel checked (Daniel Thompson)
> Changes since v2:
>  - Add this as a separate patch (Thierry Reding)
> Changes since v1:
>  - None
>
>  drivers/video/backlight/pwm_bl.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 1c2289d..698ec68 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -54,10 +54,11 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>         if (err < 0)
>                 dev_err(pb->dev, "failed to enable power supply\n");
>
> +       pwm_enable(pb->pwm);
> +
>         if (pb->enable_gpio)
>                 gpiod_set_value_cansleep(pb->enable_gpio, 1);
>
> -       pwm_enable(pb->pwm);
>         pb->enabled = true;
>  }
>
> @@ -66,12 +67,12 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>         if (!pb->enabled)
>                 return;
>
> -       pwm_config(pb->pwm, 0, pb->period);
> -       pwm_disable(pb->pwm);
> -
>         if (pb->enable_gpio)
>                 gpiod_set_value_cansleep(pb->enable_gpio, 0);
>
> +       pwm_config(pb->pwm, 0, pb->period);
> +       pwm_disable(pb->pwm);
> +
>         regulator_disable(pb->power_supply);
>         pb->enabled = false;
>  }
> --
> 2.9.3
>

A gentle ping, It's been nearly two months since I sent this patchset,
there is anything else that prevents these patches to land or
incorporate in linux-next?

Thanks,
 Enric
