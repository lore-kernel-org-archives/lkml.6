Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754550AbeDWI0R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:26:17 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34103 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754482AbeDWI0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:26:11 -0400
X-Google-Smtp-Source: AB8JxZqSs94MKIjZ5hGh1gQbLqjwplZwzbxE7RStYA/Qfstu2Ky+MmjcfT4o5GxnGpwo+tX5IpC2lrkTrOHwWGM0tuY=
MIME-Version: 1.0
In-Reply-To: <20180422213126.32756-1-lukma@denx.de>
References: <20180422213126.32756-1-lukma@denx.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Apr 2018 10:26:09 +0200
Message-ID: <CAPDyKFqaV0ehiHCNdt0i4sWE9cskBa9AQHdRZmzCphPzCdm9ow@mail.gmail.com>
Subject: Re: [PATCH] mmc: disable card sleep via device-tree
To: Lukasz Majewski <lukma@denx.de>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chanho Min <chanho.min@lge.com>, devicetree@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 April 2018 at 23:31, Lukasz Majewski <lukma@denx.de> wrote:
> From: Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
>
> On a TQMa53 module the mmc_sleep leaves the eMMC card in a state
> that the imx53 rom boot code is unable to probe, resulting in
> reboot hanging. Add a device tree property to disable sleeping
> on suspend.
>
> For TQMa53 modules the exact commit to cause hang after reboot
> (v3.10 -> v3.11):
> commit 486fdbbc1483 ("mmc: core: Add shutdown callback for (e)MMC bus_ops")
>
> [The exact discussion can be found here:
> https://patchwork.kernel.org/patch/8881401/
> "i.MX53 restart via watchdog does not work"
>
> Signed-off-by: Stanislav Meduna <stanislav.meduna@nxtcontrol.com>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-card.txt | 4 ++++
>  drivers/mmc/core/mmc.c                             | 7 +++++--
>  include/linux/mmc/card.h                           | 2 +-
>  3 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt b/Documentation/devicetree/bindings/mmc/mmc-card.txt
> index 8d2d71758907..c3ee151edd7c 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-card.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc-card.txt
> @@ -12,6 +12,9 @@ Required properties:
>  Optional properties:
>  -broken-hpi : Use this to indicate that the mmc-card has a broken hpi
>                implementation, and that hpi should not be used
> +-no-sleep-on-suspend : Do not put the card to sleep when suspending.
> +              There are boards with bootloaders that are unable
> +              to probe such card when rebooting.
>
>  Example:
>
> @@ -26,5 +29,6 @@ Example:
>                 reg = <0>;
>                 compatible = "mmc-card";
>                 broken-hpi;
> +               no-sleep-on-suspend;
>         };
>  };
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 208a762b87ef..a3b74b5c8893 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -381,8 +381,11 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>         }
>
>         np = mmc_of_find_child_device(card->host, 0);
> -       if (np && of_device_is_compatible(np, "mmc-card"))
> +       if (np && of_device_is_compatible(np, "mmc-card")) {
>                 broken_hpi = of_property_read_bool(np, "broken-hpi");
> +               card->no_sleep_on_suspend =
> +                       of_property_read_bool(np, "no-sleep-on-suspend");
> +       }
>         of_node_put(np);
>
>         /*
> @@ -1990,7 +1993,7 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>         if (mmc_can_poweroff_notify(host->card) &&
>                 ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
>                 err = mmc_poweroff_notify(host->card, notify_type);
> -       else if (mmc_can_sleep(host->card))
> +       else if (mmc_can_sleep(host->card) && !host->card->no_sleep_on_suspend)

No, this is wrong.

This means that the mmc_power_off() a few lines below would start to
violate the eMMC spec. That via powering off the card, without first
sending the sleep or power-off-notify command.
You are probably just lucky, as your particular eMMC card still copes
with this in-correct sequence (I know there are these kind of cards).

Well, what is also interesting in this regards, is what is happening
during mmc_power_off(). Does your host driver cut power to VMMC and/or
VQMMC?

>                 err = mmc_sleep(host);
>         else if (!mmc_host_is_spi(host))
>                 err = mmc_deselect_cards(host);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 279b39008a33..c64d88e6de3b 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -304,8 +304,8 @@ struct mmc_card {
>         struct dentry           *debugfs_root;
>         struct mmc_part part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
>         unsigned int    nr_parts;
> -
>         unsigned int            bouncesz;       /* Bounce buffer size */
> +       bool    no_sleep_on_suspend;
>  };
>
>  static inline bool mmc_large_sector(struct mmc_card *card)
> --
> 2.11.0
>

My impression is that it seems like there are still some uncertainties
around what actually happens when the failure occurs during re-boot. I
am guessing this boils done to how VMMC and VQMMC are being managed.

BTW, in the the pwrseq_emmc, we register a restart handler to pull the
reset GPIO for the eMMC. Perhaps that can help to fix this problem as
well!?

Kind regards
Uffe
