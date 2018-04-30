Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754112AbeD3NUu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 09:20:50 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41968 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753397AbeD3NUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 09:20:49 -0400
X-Google-Smtp-Source: AB8JxZokIReErXohP/f0L7iscsA/OdpMqCsZ4yN0fneUaeX7gCyNPpGSWxCODuTsx9Rpq+N/QISw8RFFGXdOrcKgP8c=
MIME-Version: 1.0
In-Reply-To: <20180430131403.14296-3-enric.balletbo@collabora.com>
References: <20180430131403.14296-1-enric.balletbo@collabora.com> <20180430131403.14296-3-enric.balletbo@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 30 Apr 2018 15:20:27 +0200
Message-ID: <CANiq72=CcaLadgp3NDa_rZ_DGeLUu3ZPhKZ5CCHJGypMfKrn-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] power: supply: add cros-ec USBPD charger driver.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 3:14 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> From: Sameer Nanda <snanda@chromium.org>
>
> This driver gets various bits of information about what is connected to
> USB PD ports from the EC and converts that into power_supply properties.
>
> Signed-off-by: Sameer Nanda <snanda@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v2:
> - [2/3] Add SPDX header, use devm_ variant and drop .owner
> - [2/3] Removed the PD log functionality (will be send on a follow up patch)
> - [2/3] Removed the extra custom sysfs attributes (will be send on a follow up patch)
>
>  drivers/power/supply/Kconfig              |  10 +
>  drivers/power/supply/Makefile             |   1 +
>  drivers/power/supply/cros_usbpd-charger.c | 511 ++++++++++++++++++++++
>  include/linux/mfd/cros_ec.h               |   2 +
>  4 files changed, 524 insertions(+)
>  create mode 100644 drivers/power/supply/cros_usbpd-charger.c
>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 428b426842f4..046eb23ba6f0 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -624,4 +624,14 @@ config CHARGER_RT9455
>         help
>           Say Y to enable support for Richtek RT9455 battery charger.
>
> +config CHARGER_CROS_USBPD
> +       tristate "ChromeOS EC based USBPD charger"
> +       depends on MFD_CROS_EC
> +       default n
> +       help
> +         Say Y here to enable ChromeOS EC based USBPD charger
> +         driver. This driver gets various bits of information about
> +         what is connected to USB PD ports from the EC and converts
> +         that into power_supply properties.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index e83aa843bcc6..907e26f824b2 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -83,3 +83,4 @@ obj-$(CONFIG_CHARGER_TPS65090)        += tps65090-charger.o
>  obj-$(CONFIG_CHARGER_TPS65217) += tps65217_charger.o
>  obj-$(CONFIG_AXP288_FUEL_GAUGE) += axp288_fuel_gauge.o
>  obj-$(CONFIG_AXP288_CHARGER)   += axp288_charger.o
> +obj-$(CONFIG_CHARGER_CROS_USBPD)       += cros_usbpd-charger.o
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
> new file mode 100644
> index 000000000000..c57d1c41828c
> --- /dev/null
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -0,0 +1,511 @@
> +// SPDX-License-Identifier: GPL-2.0

If this is GPL-2.0...

> +/*
> + * Power supply driver for ChromeOS EC based USB PD Charger.
> + *
> + * Copyright (c) 2014 - 2018 Google, Inc
> + */
> +
> +
> +module_platform_driver(cros_usbpd_charger_driver);
> +
> +MODULE_LICENSE("GPL");

...then this should be "GPL v2":
https://elixir.bootlin.com/linux/v4.17-rc3/source/include/linux/module.h#L175

Cheers,
Miguel
