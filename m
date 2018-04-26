Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756527AbeDZNyv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:54:51 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44209 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756424AbeDZNyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:54:49 -0400
X-Google-Smtp-Source: AIpwx4+jjHuGhx1A5rmfCyjlykPAXTIMxFgJuarXQqqumEtuQIzgIkdOzC+xHAq1QFfEkRL4bYDPA9Ayh5I6j67SDsg=
MIME-Version: 1.0
In-Reply-To: <20180426103817.12675-1-jbrunet@baylibre.com>
References: <20180426103817.12675-1-jbrunet@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Apr 2018 15:54:48 +0200
Message-ID: <CAPDyKFooqSGrgKqKxTTRBYbi6s-199GhRNhQvVD0wzWWK3UG=Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: add device reset
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 April 2018 at 12:38, Jerome Brunet <jbrunet@baylibre.com> wrote:
> Trigger the reset line of the mmc controller while probing, if available
> The reset should be optional for now, at least until all related DT node
> have the reset property
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 2 ++

Please move DT doc changes into separate patches. And make the DT
maintainers are in to field as well.

Otherwise, this looks good to me.

Kind regards
Uffe

>  drivers/mmc/host/meson-gx-mmc.c                            | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> index 5add8d7d855f..ba434375e7f2 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> @@ -20,6 +20,7 @@ Required properties:
>         "clkin1" - Other parent clock of internal mux
>    The driver has an internal mux clock which switches between clkin0 and clkin1 depending on the
>    clock rate requested by the MMC core.
> +- reset      : phandle of the internal reset line
>
>  Example:
>
> @@ -30,4 +31,5 @@ Example:
>                 clocks = <&clkc CLKID_SD_EMMC_A>, <&xtal>, <&clkc CLKID_FCLK_DIV2>;
>                 clock-names = "core", "clkin0", "clkin1";
>                 pinctrl-0 = <&emmc_pins>;
> +               resets = <&reset RESET_SD_EMMC_A>;
>         };
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 55bbd67177df..9d214622c8cf 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -35,6 +35,7 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
>  #include <linux/interrupt.h>
>  #include <linux/bitfield.h>
>  #include <linux/pinctrl/consumer.h>
> @@ -1212,6 +1213,11 @@ static int meson_mmc_probe(struct platform_device *pdev)
>                 goto free_host;
>         }
>
> +       ret = device_reset_optional(&pdev->dev);
> +       if (ret)
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev, "device reset failed: %d\n", ret);
> +
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         host->regs = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(host->regs)) {
> --
> 2.14.3
>
