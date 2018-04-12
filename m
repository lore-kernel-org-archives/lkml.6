Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeDLDyt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 23:54:49 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:65094 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeDLDyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 23:54:47 -0400
From: Keerthy <j-keerthy@ti.com>
To: <linus.walleij@linaro.org>, <grygorii.strashko@ti.com>,
        <tony@atomide.com>
CC: <j-keerthy@ti.com>, <t-kristo@ti.com>, <Russ.Dill@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ssantosh@kernel.org>, <haojian.zhuang@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <d-gerlach@ti.com>
Subject: [PATCH 00/14] arm: OMAP: AM437X: Save restores patches for rtc mode with DDR In self-refresh
Date: Thu, 12 Apr 2018 09:23:45 +0530
Message-ID: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC plus DDR in self-refresh is power a saving mode where in the entire
system including the different voltage rails from PMIC are shutdown except
the ones feeding on to RTC and DDR. DDR is kept in self-refresh hence the
contents are preserved. RTC ALARM2 is connected to PMIC_EN line once
we the ALARM2 is triggered we enter the mode with DDR in self-refresh
and RTC Ticking. After a predetermined time an RTC ALARM1 triggers waking
up the system. The control goes to bootloader. The bootloader then checks
RTC scratchpad registers to confirm it was an rtc_only wakeup and follows
a different path, configure bare minimal clocks for ddr and then jumps to
the resume address in another RTC scratchpad registers and transfers the
control to Kernel. Kernel then restores the saved context.

This series is a prerequisite for the rtc mode with DDR in self
refresh mode for am437x series of SoCs. As all the voltage domains
are shut off apart from RTC and DDR is kept in self refresh
additional save/restores are needed.

The series applies cleanly against linux-next branch.

This mode works only with u-boot built with am43xx_evm_rtconly_defconfig

Dave Gerlach (5):
  memory: ti-emif-sram: Add resume function to recopy sram code
  ARM: OMAP2+: omap_hwmod: Introduce HWMOD_NEEDS_REIDLE
  gpio: omap: Restore power_mode configuration at resume time
  ARM: hwmod: RTC: Don't assume lock/unlock will be called with irq
    enabled
  ARM: OMAP2+: prm44xx: Introduce context save/restore for am43 PRCM IO

Keerthy (1):
  OMAP: CLK: CLKSRC: Add suspend resume hooks

Russ Dill (7):
  ARM: OMAP2: Add functions to save and restore clockdomain context
    en-masse.
  ARM: OMAP2: Add functions to save and restore omap hwmod context
    en-masse.
  ARM: OMAP2: Add functions to save and restore powerdomain context
  ARM: AM33XX: Add functions to save/restore am33xx control registers.
  ARM: OMAP2: Add functions to save and restore pinctrl context.
  ARM: OMAP2: Drop the concept of certain power domains not being able
    to lose context.
  gpio: omap: Drop the concept of gpio banks not being able to lose
    context.

Tero Kristo (1):
  ARM: AM43XX: Add functions to save/restore am43xx control registers

 arch/arm/mach-omap2/clockdomain.c                  |  46 +++++
 arch/arm/mach-omap2/clockdomain.h                  |   8 +
 arch/arm/mach-omap2/cm33xx.c                       |  53 ++++++
 arch/arm/mach-omap2/cminst44xx.c                   |  43 +++++
 arch/arm/mach-omap2/control.c                      | 172 ++++++++++++++++++
 arch/arm/mach-omap2/control.h                      |  65 +++++++
 arch/arm/mach-omap2/omap_device.c                  |  50 +++++
 arch/arm/mach-omap2/omap_device.h                  |   1 +
 arch/arm/mach-omap2/omap_hwmod.c                   | 202 +++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.h                   |  21 +++
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  14 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   3 +-
 arch/arm/mach-omap2/omap_hwmod_reset.c             |  12 +-
 arch/arm/mach-omap2/powerdomain.c                  |  75 +++++---
 arch/arm/mach-omap2/powerdomain.h                  |   8 +-
 arch/arm/mach-omap2/prm.h                          |   2 +
 arch/arm/mach-omap2/prm33xx.c                      |  31 ++++
 arch/arm/mach-omap2/prm44xx.c                      |  79 ++++++++
 arch/arm/mach-omap2/timer.c                        |  37 ++++
 drivers/gpio/gpio-omap.c                           |  40 ++--
 drivers/memory/ti-emif-pm.c                        |  24 +++
 drivers/pinctrl/core.c                             |   1 +
 drivers/pinctrl/core.h                             |   1 -
 drivers/pinctrl/pinctrl-single.c                   |  50 +++++
 drivers/pinctrl/pinmux.c                           |  22 +++
 include/linux/pinctrl/pinctrl.h                    |   7 +
 include/linux/pinctrl/pinmux.h                     |  16 ++
 include/linux/platform_data/gpio-omap.h            |   1 -
 28 files changed, 1019 insertions(+), 65 deletions(-)

-- 
1.9.1
