Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeBUXri (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:47:38 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33968 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeBUXrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:47:36 -0500
X-Google-Smtp-Source: AH8x227L0tekSAJrT903wSBwSK4zddefJkUMPKAa2sinGHYzZcvTqCBgqHfrW5k4luYjdt4V2FUW9tEIQKa0aoCQENY=
MIME-Version: 1.0
In-Reply-To: <20180219224053.21458-1-enric.balletbo@collabora.com>
References: <20180219224053.21458-1-enric.balletbo@collabora.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Wed, 21 Feb 2018 15:47:15 -0800
X-Google-Sender-Auth: bx9Qpj0CjGnmCKTG9Fp7QoYX63k
Message-ID: <CAMHSBOW434OB816APCq22SmNeFF9rKrF+fWan-Z7QZVTkxu6Hg@mail.gmail.com>
Subject: Re: [PATCH 3/6] mfd: cros_ec_dev: Register cros-ec-rtc driver as a subdevice.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 2:40 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Check whether this EC instance has RTC host command support and instatiate
> the RTC driver as a subdevice in such case.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/mfd/cros_ec_dev.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index e4fafdd96e5e..e0c604ab380f 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -389,6 +389,10 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>         kfree(msg);
>  }
>
> +static const struct mfd_cell cros_ec_rtc_cell = {
> +       .name = "cros-ec-rtc",

> +};
> +
>  static int ec_device_probe(struct platform_device *pdev)
>  {
>         int retval = -ENOMEM;
> @@ -437,6 +441,16 @@ static int ec_device_probe(struct platform_device *pdev)
>         if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>                 cros_ec_sensors_register(ec);
>
> +       /* check whether this EC instance has RTC host command support */
> +       if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
> +               retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
> +                                        &cros_ec_rtc_cell, 1, NULL, 0, NULL);
> +               if (retval)
> +                       dev_err(ec->dev,
> +                               "failed to add cros-ec-rtc device: %d\n",
> +                               retval);
> +       }
> +
>         /* Take control of the lightbar from the EC. */
>         lb_manual_suspend_ctrl(ec, 1);
>
> --
> 2.16.1
>
