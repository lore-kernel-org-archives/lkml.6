Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeBTIA4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 03:00:56 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:41505 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbeBTIAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 03:00:54 -0500
X-Google-Smtp-Source: AH8x22562M7KiWQClIep7J8RLp8DhCIxN1MYIEusdjF/Sz11qOKnipmaM5D/m+hqhAtsYaaEYKUoN7iNSlCSucoSExs=
MIME-Version: 1.0
In-Reply-To: <20180219224043.21383-1-enric.balletbo@collabora.com>
References: <20180219224043.21383-1-enric.balletbo@collabora.com>
From: Vincent Palatin <vpalatin@chromium.org>
Date: Tue, 20 Feb 2018 09:00:33 +0100
X-Google-Sender-Auth: Ose3kmPFKBmyipzlFp94S1nEXgo
Message-ID: <CAP_ceTzdA6TgO4H2CCa4rJOjQvLL4tfFD8DnCZeJp67rWiSrdg@mail.gmail.com>
Subject: Re: [PATCH 2/6] mfd: cros_ec: free IRQ automatically
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, groeck@chromium.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 11:40 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> From: Vincent Palatin <vpalatin@chromium.org>
>
> Free the IRQ we might have requested when removing the cros_ec device,
> so we can unload and reload the driver properly.
>
> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/mfd/cros_ec.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index 74780f2964a1..d1a4fbee9380 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -119,9 +119,9 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>         }
>
>         if (ec_dev->irq) {
> -               err = request_threaded_irq(ec_dev->irq, NULL, ec_irq_thread,
> -                                          IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> -                                          "chromeos-ec", ec_dev);
> +               err = devm_request_threaded_irq(dev, ec_dev->irq, NULL,
> +                               ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +                               "chromeos-ec", ec_dev);
>                 if (err) {
>                         dev_err(dev, "Failed to request IRQ %d: %d",
>                                 ec_dev->irq, err);
> @@ -135,7 +135,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>                 dev_err(dev,
>                         "Failed to register Embedded Controller subdevice %d\n",
>                         err);
> -               goto fail_mfd;
> +               return err;
>         }
>
>         if (ec_dev->max_passthru) {
> @@ -153,7 +153,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>                         dev_err(dev,
>                                 "Failed to register Power Delivery subdevice %d\n",
>                                 err);
> -                       goto fail_mfd;
> +                       return err;
>                 }
>         }
>
> @@ -162,7 +162,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>                 if (err) {
>                         mfd_remove_devices(dev);
>                         dev_err(dev, "Failed to register sub-devices\n");
> -                       goto fail_mfd;
> +                       return err;
>                 }
>         }
>
> @@ -180,11 +180,6 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>         cros_ec_acpi_install_gpe_handler(dev);
>
>         return 0;
> -
> -fail_mfd:
> -       if (ec_dev->irq)
> -               free_irq(ec_dev->irq, ec_dev);
> -       return err;
>  }
>  EXPORT_SYMBOL(cros_ec_register);


You need to remove the "free_irq(ec_dev->irq, ec_dev);" in cros_ec_remove() too.
as done there:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/866858/15/drivers/mfd/cros_ec.c

it was missing originally but was added by: 'f58b14e6632a mfd:
cros_ec: Free IRQ on exit'


>
> --
> 2.16.1
>
