Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754783AbeEWQf7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:35:59 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:41865 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754623AbeEWQfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:35:53 -0400
X-Google-Smtp-Source: ADUXVKIzmwzBz0SwlQaV5oHnUFr69hIUtUQvpKAm+bxFIZaOiX4e1HdLSizEXRif9AZiWm/rjGRCm6+rqCk5W+KZ/pg=
MIME-Version: 1.0
In-Reply-To: <20180509230630.258755-1-gwendal@chromium.org>
References: <20180509230630.258755-1-gwendal@chromium.org>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Wed, 23 May 2018 18:35:51 +0200
Message-ID: <CAFqH_50VYJC7aep6P+KtN4qmFeV66GEXvxmFy8KrNp1BRv33xg@mail.gmail.com>
Subject: Re: [PATCH] cros_ec: Use devm_kzalloc for private data
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

2018-05-10 1:06 GMT+02:00 Gwendal Grignou <gwendal@chromium.org>:
> Use dev_kzmalloc, remove .release entry point.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/mfd/cros_ec_dev.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index eafd06f62a3a..45d42511a3e5 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -262,13 +262,6 @@ static const struct file_operations fops = {
>  #endif
>  };
>
> -static void __remove(struct device *dev)
> -{
> -       struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
> -                                             class_dev);
> -       kfree(ec);
> -}
> -
>  static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>  {
>         /*
> @@ -388,7 +381,7 @@ static int ec_device_probe(struct platform_device *pdev)
>         int retval = -ENOMEM;
>         struct device *dev = &pdev->dev;
>         struct cros_ec_platform *ec_platform = dev_get_platdata(dev);
> -       struct cros_ec_dev *ec = kzalloc(sizeof(*ec), GFP_KERNEL);
> +       struct cros_ec_dev *ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
>
>         if (!ec)
>                 return retval;
> @@ -410,7 +403,6 @@ static int ec_device_probe(struct platform_device *pdev)
>         ec->class_dev.devt = MKDEV(ec_major, pdev->id);
>         ec->class_dev.class = &cros_class;
>         ec->class_dev.parent = dev;
> -       ec->class_dev.release = __remove;
>
>         retval = dev_set_name(&ec->class_dev, "%s", ec_platform->ec_name);
>         if (retval) {
> --
> 2.17.0.441.gb46fe60e1d-goog
>

The patch looks good to me, however, the patch doesn't apply cleanly
if you have [1] already applied, and if not, then is this patch ([2])
which doesn't apply cleanly. To not have interdependencies I'd suggest
apply first this patch and remove the following from [1]

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index eafd06f62a3a..cad12da7f884 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -264,8 +264,8 @@ static const struct file_operations fops = {

 static void __remove(struct device *dev)
 {
-       struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
-                                             class_dev);
+       struct cros_ec_dev *ec = to_cros_ec_dev(dev);
+
        kfree(ec);
 }

With this change, [1] can go through the Benson tree and [2] through
Lee tree independently. With the above change feel free to add my

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

If you want I can do this rework for you.

Best regards,
 Enric

[1] https://patchwork.kernel.org/patch/10390959/
[2] https://patchwork.kernel.org/patch/10390965/
