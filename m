Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeC2LL5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:11:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53054 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752699AbeC2LLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:11:45 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Aniruddha Banerjee <aniruddhab@nvidia.com>,
        Archana Sathyakumar <asathyak@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        JeffyChen <jeffy.chen@rock-chips.com>,
        Lina Iyer <ilina@codeaurora.org>, Rob Herring <robh@kernel.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] irqchip updates for v4.17
Date: Thu, 29 Mar 2018 12:11:09 +0100
Message-Id: <20180329111109.2854-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

This is the bulk of the irqchip changes for 4.17. On the menu, two new
irqchip drivers, two GIC updates for kexec/kdump and suspend/resume,
and the usual bunch of cleanups and fixes.

Please pull,

	M.

The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-4.17

for you to fetch changes up to aa08192a254d362a4d5317647a81de6996961aef:

  irqchip/gic: Take lock when updating irq type (2018-03-29 11:47:50 +0100)

----------------------------------------------------------------
irqchip updates for 4.17

- New Qualcomm PDC irqchip
- New Microsemi Ocelot irqchip
- Suspend/resume support for some oddball GICv3 irqchip
- Better GIC/GICv3 support for kexec
- Various cleanups and fixes

----------------------------------------------------------------
Alexandre Belloni (2):
      dt-bindings: interrupt-controller: Add binding for the Microsemi Ocelot interrupt controller
      irqchip: Add a driver for the Microsemi Ocelot controller

Aniruddha Banerjee (1):
      irqchip/gic: Take lock when updating irq type

Archana Sathyakumar (2):
      irqchip/pdc: Add PDC interrupt controller for QCOM SoCs
      dt-bindings/interrupt-controller: pdc: Describe PDC device binding

Davidlohr Bueso (1):
      irqchip/gic: Update supports_deactivate static key to modern api

Derek Basehore (2):
      irqchip/gic-v3-its: Add ability to save/restore ITS state
      irqchip/gic-v3-its: Add ability to resend MAPC on resume

Geert Uytterhoeven (2):
      irqchip/renesas-intc-irqpin: Use wakeup_path i.s.o. explicit clock handling
      irqchip/renesas-irqc: Use wakeup_path i.s.o. explicit clock handling

Marc Zyngier (8):
      irqchip/gic-v2: Reset APRn registers at boot time
      irqchip/gic-v3: Reset APgRn registers at boot time
      irqchip/gic-v3: Allow LPIs to be disabled from the command line
      irqchip/gic: Loudly complain about the use of IRQ_TYPE_NONE
      irqchip/gic-v3: Loudly complain about the use of IRQ_TYPE_NONE
      irqchip/gic-v3: Do not check trigger configuration of partitionned LPIs
      irqchip/gic-v3: Don't try to reset AP0Rn
      irqchip/gic-v3: Probe for SCR_EL3 being clear before resetting AP0Rn

Shanker Donthineni (1):
      irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is observed before enabling

 Documentation/admin-guide/kernel-parameters.txt    |   8 +
 .../interrupt-controller/mscc,ocelot-icpu-intr.txt |  22 ++
 .../bindings/interrupt-controller/qcom,pdc.txt     |  78 ++++++
 arch/arm/include/asm/arch_gicv3.h                  |  47 +++-
 arch/arm64/include/asm/arch_gicv3.h                |   5 -
 drivers/irqchip/Kconfig                            |  14 +
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-gic-common.c                   |   9 +-
 drivers/irqchip/irq-gic-v3-its.c                   | 267 ++++++++++++++----
 drivers/irqchip/irq-gic-v3.c                       |  99 ++++++-
 drivers/irqchip/irq-gic.c                          |  44 +--
 drivers/irqchip/irq-mscc-ocelot.c                  | 118 ++++++++
 drivers/irqchip/irq-renesas-intc-irqpin.c          |  40 ++-
 drivers/irqchip/irq-renesas-irqc.c                 |  30 +-
 drivers/irqchip/qcom-pdc.c                         | 311 +++++++++++++++++++++
 include/linux/irqchip/arm-gic-v3.h                 |   4 +-
 16 files changed, 956 insertions(+), 142 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
 create mode 100644 drivers/irqchip/irq-mscc-ocelot.c
 create mode 100644 drivers/irqchip/qcom-pdc.c
