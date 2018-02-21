Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750988AbeBUVOH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:14:07 -0500
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40009 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeBUVOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:14:04 -0500
X-Google-Smtp-Source: AH8x224OrXwkxlVjCJosVE04s8mXNoitusp4YzmrICJ7Ak0vtr+q3xEH9elKzZDB40btxDxDd0JrR3K45WgX8C57VMo=
MIME-Version: 1.0
In-Reply-To: <20180219224635.22758-1-enric.balletbo@collabora.com>
References: <20180219224635.22758-1-enric.balletbo@collabora.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Wed, 21 Feb 2018 13:13:42 -0800
X-Google-Sender-Auth: jkaQS--Udjo91PIJw-1YPz6HJSk
Message-ID: <CAMHSBOXt62qHgWr6qYPOiwXbAMPF201iSJcU7yAy_QQguf-Umg@mail.gmail.com>
Subject: Re: [PATCH 6/6] mfd: cros_ec_i2c: add ACPI module device table
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Wei-Ning Huang <wnhuang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 2:46 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> From: Wei-Ning Huang <wnhuang@google.com>
>
> Add ACPI module device table for matching cros-ec devices to load the
> cros_ec_i2c driver automatically.
>
> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> Acked-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/mfd/cros_ec_i2c.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mfd/cros_ec_i2c.c b/drivers/mfd/cros_ec_i2c.c
> index 9f70de1e4c70..9248490504a9 100644
> --- a/drivers/mfd/cros_ec_i2c.c
> +++ b/drivers/mfd/cros_ec_i2c.c
> @@ -13,6 +13,7 @@
>   * GNU General Public License for more details.
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -344,11 +345,13 @@ static int cros_ec_i2c_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(cros_ec_i2c_pm_ops, cros_ec_i2c_suspend,
>                           cros_ec_i2c_resume);
>
> +#ifdef CONFIG_OF
>  static const struct of_device_id cros_ec_i2c_of_match[] = {
>         { .compatible = "google,cros-ec-i2c", },
>         { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, cros_ec_i2c_of_match);
> +#endif
>
>  static const struct i2c_device_id cros_ec_i2c_id[] = {
>         { "cros-ec-i2c", 0 },
> @@ -356,9 +359,18 @@ static const struct i2c_device_id cros_ec_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, cros_ec_i2c_id);
>
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id cros_ec_i2c_acpi_id[] = {
> +       { "GOOG0008", 0 },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(acpi, cros_ec_i2c_acpi_id);
> +#endif
> +
>  static struct i2c_driver cros_ec_driver = {
>         .driver = {
>                 .name   = "cros-ec-i2c",
> +               .acpi_match_table = ACPI_PTR(cros_ec_i2c_acpi_id),
>                 .of_match_table = of_match_ptr(cros_ec_i2c_of_match),
>                 .pm     = &cros_ec_i2c_pm_ops,
>         },
> --
> 2.16.1
>
