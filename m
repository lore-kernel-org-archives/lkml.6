Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935981AbeBLOkJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:40:09 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:55202 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935270AbeBLOkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:40:06 -0500
X-Google-Smtp-Source: AH8x227LlQj4dSpJ69VJW5ieu2iL4AnGWyk+exkCZBZqA8A7xmfstwnvw4LuWR3KxDXo04B/o5YaFbPNuLOW9J+qcNk=
MIME-Version: 1.0
In-Reply-To: <1518443713-1835-1-git-send-email-geert+renesas@glider.be>
References: <1518443713-1835-1-git-send-email-geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 12 Feb 2018 15:40:04 +0100
Message-ID: <CAPDyKFpVyOuzEvrHVVg6R9Q4jcK5+8Ure8PDTqfcE2T3iVm8iQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] renesas: irqchip: Use wakeup_path i.s.o. explicit
 clock handling
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 February 2018 at 14:55, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>         Hi all,
>
> If an interrupt controller in a Renesas ARM SoC is part of a Clock
> Domain, and it is part of the wakeup path, it must be kept active during
> system suspend.
>
> Currently this is handled in all interrupt controller drivers by
> explicitly increasing the use count of the module clock when the device
> is part of the wakeup path.  However, this explicit clock handling is
> merely a workaround for a failure to properly communicate wakeup
> information to the device core.
>
> Hence this series fixes the affected drivers by setting the devices'
> power.wakeup_path fields instead, to indicate they are part of the
> wakeup path.  Depending on the PM Domain's active_wakeup configuration,
> the genpd core code will keep the device enabled (and the clock running)
> during system suspend when needed.
>
> Target trees:
>   - Patches 1 and 2 are meant for the irqchip tree,
>   - Patch 3 is meant for the GPIO tree.
>
> Changes compared to v2 (sent by Ulf Hanson):
>   - Revert to v1, as WAKEUP_PATH didn't make it,
>   - Use an atomic_t instead of a boolean flag, as the boolean tracked
>     only the status of the last configured GPIO, while multiple interrupt
>     sources on the same irqchip may be involved with wake-up,
>   - Use new helper device_set_wakeup_path(),
>   - Drop checks for CONFIG_PM_SLEEP, as device_set_wakeup_path() is
>     always available, unlike dev_pm_info.wakeup_path,
>   - Mark suspend functions __maybe_unused.
>
> Changes compared to v1:
>   - Convert to use the WAKEUP_PATH driver PM flag (Ulf Hanson).
>
> This has been tested on r8a73a4/ape6evm, r8a7740/armadillo,
> r8a7791/koelsch, r8a7795/salvator-x and -xs, r8a7796/salvator-x, and
> sh73a0/kzm9g.
>
> Thanks for applying!
>
> Geert Uytterhoeven (3):
>   irqchip/renesas-intc-irqpin: Use wakeup_path i.s.o. explicit clock
>     handling
>   irqchip/renesas-irqc: Use wakeup_path i.s.o. explicit clock handling
>   gpio: rcar: Use wakeup_path i.s.o. explicit clock handling
>
>  drivers/gpio/gpio-rcar.c                  | 38 +++++++++++++----------------
>  drivers/irqchip/irq-renesas-intc-irqpin.c | 40 +++++++++++++------------------
>  drivers/irqchip/irq-renesas-irqc.c        | 30 ++++++++++++-----------
>  3 files changed, 48 insertions(+), 60 deletions(-)
>

For the series:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
