Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755763AbeDWPcz convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:32:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42925 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755460AbeDWPcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:32:52 -0400
Date: Mon, 23 Apr 2018 17:32:50 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Level-triggered MSI support
Message-ID: <20180423173250.6060b7ac@xps13>
In-Reply-To: <20180423103440.26592-1-marc.zyngier@arm.com>
References: <20180423103440.26592-1-marc.zyngier@arm.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, 23 Apr 2018 11:34:33 +0100, Marc Zyngier <marc.zyngier@arm.com>
wrote:

> This series is a first shot at teaching the kernel about the oxymoron
> expressed in $SUBJECT. Over the past couple of years, we've seen some
> SoCs coming up with ways of signalling level interrupts using a new
> flavor of MSIs, where the MSI controller uses two distinct messages:
> one that raises a virtual line, and one that lowers it. The target MSI
> controller is in charge of maintaining the state of the line.
> 
> This allows for a much simplified HW signal routing (no need to have
> hundreds of discrete lines to signal level interrupts if you already
> have a memory bus), but results in a departure from the current idea
> the kernel has of MSIs.
> 
> This series takes a minimal approach to the problem, which is to allow
> MSI controllers to use not only one, but up to two messages at a
> time. This is controlled by a flag exposed at MSI irq domain creation,
> and is only supported with platform MSI.
> 
> The rest of the series repaints the Marvell ICU/GICP drivers which
> already make use of this feature with a side-channel, and adds support
> for the same feature in GICv3. A side effect of the last GICv3 patch
> is that you can also use SPIs to signal PCI MSIs. This is a last
> resort measure for SoCs where the ITS is unusable for unspeakable
> reasons.
> 
> Marc Zyngier (7):
>   genirq/msi: Allow level-triggered MSIs to be exposed by MSI providers
>   genirq/msi: Limit level-triggered MSI to platform devices
>   irqchip/mvebu-gicp: Use level-triggered MSIs between ICU and GICP
>   dma-iommu: Fix compilation when !CONFIG_IOMMU_DMA
>   irqchip/gic-v3: Add support for Message Based Interrupts as an MSI
>     controller
>   irqchip/gic-v3: Add PCI/MSI support to the GICv3 MBI sub-driver
>   dt-bindings/gic-v3: Add documentation for MBI support
> 
>  .../bindings/interrupt-controller/arm,gic-v3.txt   |  17 +
>  drivers/base/platform-msi.c                        |   3 +
>  drivers/irqchip/Makefile                           |   2 +-
>  drivers/irqchip/irq-gic-v3-mbi.c                   | 343 +++++++++++++++++++++
>  drivers/irqchip/irq-gic-v3.c                       |   6 +
>  drivers/irqchip/irq-mvebu-gicp.c                   |  37 +--
>  drivers/irqchip/irq-mvebu-gicp.h                   |  12 -
>  drivers/irqchip/irq-mvebu-icu.c                    |  33 +-
>  drivers/pci/msi.c                                  |   3 +
>  include/linux/dma-iommu.h                          |   1 +
>  include/linux/irqchip/arm-gic-v3.h                 |   1 +
>  include/linux/msi.h                                |   2 +
>  kernel/irq/msi.c                                   |  32 +-
>  13 files changed, 427 insertions(+), 65 deletions(-)
>  create mode 100644 drivers/irqchip/irq-gic-v3-mbi.c
>  delete mode 100644 drivers/irqchip/irq-mvebu-gicp.h
> 

Thanks for the series, I gave it a try on Armada-8040-DB:

# cat /proc/interrupts | grep ICU
 28:          0          0          0          0  ICU.f21e0000 107 Level     ahci[f2540000.sata]
 29:          0          0          0          0  ICU.f41e0000 107 Level     ahci[f4540000.sata]
 35:          2          0          0          0  ICU.f21e0000 129 Level   
 36:          3          0          0          0  ICU.f21e0000  41 Level     eth1
 37:          0          0          0          0  ICU.f21e0000  45 Level     eth1
 38:          0          0          4          0  ICU.f21e0000  49 Level     eth1
 39:          0          0          0          2  ICU.f21e0000  53 Level     eth1
 40:        128          0          0          0  ICU.f21e0000  57 Level     eth1
 47:          2          0          0          0  ICU.f41e0000 129 Level   
 54:         82          0          0          0  ICU.f21e0000 106 Level     xhci-hcd:usb3
 55:         82          0          0          0  ICU.f21e0000 105 Level     xhci-hcd:usb5
 56:          4          0          0          0  ICU.f41e0000 106 Level     xhci-hcd:usb7
 57:          0          0          0          0  ICU.f41e0000 105 Level     xhci-hcd:usb1
 58:          0          0          0          0  ICU.f41e0000  77 Level     f4284000.rtc
 59:        224          0          0          0  ICU.f21e0000 120 Level     mv64xxx_i2c
 60:          0          0          0          0  ICU.f41e0000 120 Level     mv64xxx_i2c
 61:         52          0          0          0  ICU.f21e0000  27 Level     mmc1
 63:          0          0          0          0  ICU.f21e0000  22 Level     armada8k-pcie, PCIe PME, aerdrv
 64:          0          0          0          0  ICU.f21e0000  23 Level     armada8k-pcie, PCIe PME, aerdrv
 65:          0          0          0          0  ICU.f41e0000  22 Level     armada8k-pcie, PCIe PME, aerdrv
 66:          0          0          0          0  ICU.f41e0000  24 Level     armada8k-pcie, PCIe PME, aerdrv
 67:          0          0          0          0  ICU.f41e0000  23 Level     armada8k-pcie, PCIe PME, aerdrv

All these interrupts are NSRs and go through the GICP. I was able to
use the network (CP0), an I2C bus (CP0) and the USB host ports (on each
CP).

Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
