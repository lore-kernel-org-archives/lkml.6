Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935699AbeBLNz3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:55:29 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:50760 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934672AbeBLNzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:55:25 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 0/3] renesas: irqchip: Use wakeup_path i.s.o. explicit clock handling
Date: Mon, 12 Feb 2018 14:55:10 +0100
Message-Id: <1518443713-1835-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

If an interrupt controller in a Renesas ARM SoC is part of a Clock
Domain, and it is part of the wakeup path, it must be kept active during
system suspend.

Currently this is handled in all interrupt controller drivers by
explicitly increasing the use count of the module clock when the device
is part of the wakeup path.  However, this explicit clock handling is
merely a workaround for a failure to properly communicate wakeup
information to the device core.

Hence this series fixes the affected drivers by setting the devices'
power.wakeup_path fields instead, to indicate they are part of the
wakeup path.  Depending on the PM Domain's active_wakeup configuration,
the genpd core code will keep the device enabled (and the clock running)
during system suspend when needed.

Target trees:
  - Patches 1 and 2 are meant for the irqchip tree,
  - Patch 3 is meant for the GPIO tree.

Changes compared to v2 (sent by Ulf Hanson):
  - Revert to v1, as WAKEUP_PATH didn't make it,
  - Use an atomic_t instead of a boolean flag, as the boolean tracked
    only the status of the last configured GPIO, while multiple interrupt
    sources on the same irqchip may be involved with wake-up,
  - Use new helper device_set_wakeup_path(),
  - Drop checks for CONFIG_PM_SLEEP, as device_set_wakeup_path() is
    always available, unlike dev_pm_info.wakeup_path,
  - Mark suspend functions __maybe_unused.

Changes compared to v1:
  - Convert to use the WAKEUP_PATH driver PM flag (Ulf Hanson).

This has been tested on r8a73a4/ape6evm, r8a7740/armadillo,
r8a7791/koelsch, r8a7795/salvator-x and -xs, r8a7796/salvator-x, and
sh73a0/kzm9g.

Thanks for applying!

Geert Uytterhoeven (3):
  irqchip/renesas-intc-irqpin: Use wakeup_path i.s.o. explicit clock
    handling
  irqchip/renesas-irqc: Use wakeup_path i.s.o. explicit clock handling
  gpio: rcar: Use wakeup_path i.s.o. explicit clock handling

 drivers/gpio/gpio-rcar.c                  | 38 +++++++++++++----------------
 drivers/irqchip/irq-renesas-intc-irqpin.c | 40 +++++++++++++------------------
 drivers/irqchip/irq-renesas-irqc.c        | 30 ++++++++++++-----------
 3 files changed, 48 insertions(+), 60 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
