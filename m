Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754766AbeDWKfS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:35:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38670 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754442AbeDWKfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:35:15 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Level-triggered MSI support
Date: Mon, 23 Apr 2018 11:34:33 +0100
Message-Id: <20180423103440.26592-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a first shot at teaching the kernel about the oxymoron
expressed in $SUBJECT. Over the past couple of years, we've seen some
SoCs coming up with ways of signalling level interrupts using a new
flavor of MSIs, where the MSI controller uses two distinct messages:
one that raises a virtual line, and one that lowers it. The target MSI
controller is in charge of maintaining the state of the line.

This allows for a much simplified HW signal routing (no need to have
hundreds of discrete lines to signal level interrupts if you already
have a memory bus), but results in a departure from the current idea
the kernel has of MSIs.

This series takes a minimal approach to the problem, which is to allow
MSI controllers to use not only one, but up to two messages at a
time. This is controlled by a flag exposed at MSI irq domain creation,
and is only supported with platform MSI.

The rest of the series repaints the Marvell ICU/GICP drivers which
already make use of this feature with a side-channel, and adds support
for the same feature in GICv3. A side effect of the last GICv3 patch
is that you can also use SPIs to signal PCI MSIs. This is a last
resort measure for SoCs where the ITS is unusable for unspeakable
reasons.

Marc Zyngier (7):
  genirq/msi: Allow level-triggered MSIs to be exposed by MSI providers
  genirq/msi: Limit level-triggered MSI to platform devices
  irqchip/mvebu-gicp: Use level-triggered MSIs between ICU and GICP
  dma-iommu: Fix compilation when !CONFIG_IOMMU_DMA
  irqchip/gic-v3: Add support for Message Based Interrupts as an MSI
    controller
  irqchip/gic-v3: Add PCI/MSI support to the GICv3 MBI sub-driver
  dt-bindings/gic-v3: Add documentation for MBI support

 .../bindings/interrupt-controller/arm,gic-v3.txt   |  17 +
 drivers/base/platform-msi.c                        |   3 +
 drivers/irqchip/Makefile                           |   2 +-
 drivers/irqchip/irq-gic-v3-mbi.c                   | 343 +++++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c                       |   6 +
 drivers/irqchip/irq-mvebu-gicp.c                   |  37 +--
 drivers/irqchip/irq-mvebu-gicp.h                   |  12 -
 drivers/irqchip/irq-mvebu-icu.c                    |  33 +-
 drivers/pci/msi.c                                  |   3 +
 include/linux/dma-iommu.h                          |   1 +
 include/linux/irqchip/arm-gic-v3.h                 |   1 +
 include/linux/msi.h                                |   2 +
 kernel/irq/msi.c                                   |  32 +-
 13 files changed, 427 insertions(+), 65 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-v3-mbi.c
 delete mode 100644 drivers/irqchip/irq-mvebu-gicp.h

-- 
2.14.2
