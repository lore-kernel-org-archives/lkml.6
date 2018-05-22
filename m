Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeEVJk7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:40:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49649 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751039AbeEVJkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:40:55 -0400
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Haim Boot <hayim@marvell.com>,
        Hanna Hawa <hannah@marvell.com>, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 00/16] Add System Error Interrupt support to Armada SoCs
Date: Tue, 22 May 2018 11:40:26 +0200
Message-Id: <20180522094042.24770-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ICU is an IRQ chip found in Armada CP110. It currently has 207 wired
inputs. Its purpose is to aggregate all CP interrupts and report them to
the AP through MSIs. The ICU writes into GIC registers (AP side) by way
of the interconnect. These interrupts can be of several groups:
- SecuRe (SR);
- Non-SecuRe (NSR);
- System Error Interrupts (SEI);
- RAM Error Interrupts (REI);
- ...
Each ICU wired interrupt can be of any of these groups. The group is
encoded in the MSI payload.

Until now, only the non-secure interrupts (NSR) were handled by the ICU
driver. Interrupts of another group could work by chance because the
ICU driver does not erase all ATF configuration; it only erases the
configuration for NSR interrupts.

This series aims at adding support for the System Error Interrupts
(SEI). For this purpose, the ICU driver is a bit reworked to separate
the ICU 'generic' configuration from the NSR-related handling. Then,
the SEI driver (part of the GIC) is introduced and finally, support for
SEI interrupts are also added to the ICU driver.

The SEI driver is a bit different than its cousin the GICP because it
must handle MSIs from the CPs, as well as wired interrupts from the AP
itself. MSIs and wired interrupts will automatically update two
registers (GICP_SECR0/GICP_SECR1) that will trigger a single top-level
interrupt (SPI #32).

As this is my first contribution in the IRQ subsystem I might have
missed some specificities or misunderstood the API, please do not
hesitate to correct me if I'm wrong.

Also, for the sake of understandability (and because I love ASCII art),
this is a try to explain the ICU/SEI architecture:


+----------------------------------------------------------------------+
|                                                                      |
|                                                                      |
|     SPIa SPIb        SPIz                    SPI 32                  |
|       ^    ^           ^                       ^                     |
|       |    |   . . .   |                       |                     |
|       |    |           |                       |                     |
|       |    |   . . .   |                       |                     |
|   +------------------------+   +---------------------------------+   |
|   |   |    |           |   |   |               |                 |   |
|   |   |    |           |   |   |   SEI         |                 |   |
|   |   |    |   . . .   |   |   |       ________|_______          |   |
|   |   |    |           |   |   |      /___SEI_SECR_____\         |   |
|   |   |____|___________|   |   |     /       |         \\        |   |
|   |    \_GICP_SETSPI _/    |   |    /        |          \\       |   |
|   |                ||      |   |   /   ...   |           \\      |   |
|   |  GICP          ||      |   |  |          |            \\     |   |
|   +----------------||------+   +--|----------|------------||-----+   |
|                    ||             |          |            ||         |
|                    ||             |    ...   |            ||         |
|                    ||             |          |            ||         |
|                    ||             |          |            ||         |
|                     \\_______   int 0  ... int 20        //          |
|                      \_NSR__ \                          //           |
|                              \\    ____________________//            |
|                               \\  /________SEI_________/             |
|   AP 806                       \\//                                  |
|                                 ||                                   |
+---------------------------------||-----------------------------------+
                                  ||
                                  || Interconnect
                                  ||\
                                  ||\\______
                                  || \______ <---> Others CP 110
                                  ||
+---------------------------------||-----------------------------------+
|                                 ||                                   |
|   CP 110                        ||                                   |
|                                 ||                                   |
|       +-------------------------||------------------------+          |
|       |                         || MSI                    |          |
|       |   ICU                   ||                        |          |
|       |         /--------------/  \------\                |          |
|       |        /      /-------/           \               |          |
|       |       /      /       /             \              |          |
|       |      /      /       /     . . .     \             |          |
|       |     /      /       /                 \            |          |
|       |   NSR     NSR     SEI               NSR           |          |
|       |    |       |       |                 |            |          |
|       +----^-------^-------^-----------------^------------+          |
|            |       |       |                 |                       |
|            |       |       |      . . .      |                       |
|            |       |       |                 |                       |
|         int 0   int 1   int 2             int 206                    |
|                                                                      |
|                                                                      |
+----------------------------------------------------------------------+


Thank you,
Miquèl


Changes since v1:
=================
General
-------
* Spelling/function names/comments.
* Added Reviewed-by tags.
* Rebased on top of Marc Zyngier level-MSI series (tip:irq/core).

SEI
---
* Change the license for GPL-2.0 only in irq-mvebu-sei.c C file.
* Used alphabetic ordering when adding SEI driver in Makefile.
* Re-ordered register definitions by increasing offset.
* s/NB/COUNT/ in register definitions.
* avoid enabling all interrupt by default.
* fixed mask/unmask functions using the wrong hwirq number.
* removed hackish doorbell mechanism.
* Removed the ->xlate hook assigned for CP MSIs.
* Used devm_*() helpers.
* s/top_level_spi/parent_irq/ in probe.
* Added forgotten of_node_put(child).
* Reset the SEI registers before registering the IRQ domains.
* Introduced new DT property "marvell,sei-ranges" instead of using
  "reg" to declare the range of MSI interrupts vs. wired interrupts in
  the SEI subnodes.
* Finally did not change the ->alloc() about the fwspec->param[1]
  line (to be checked by Marc).

ICU
---
* Updated the ICU documentation so the legacy bindings are still
  documented somewhere.
* Added stable tags on the commit fixing the CP110 ICU node size.
* Removed the "syscon" compatible from the ICU node, instead the
  syscon is created at probe time.
* s/user data/private data/ in the title of commit
  "irqchip/irq-mvebu-icu: fix wrong user data retrieval"


Miquel Raynal (16):
  dt-bindings/interrupt-controller: fix Marvell ICU length in the
    example
  arm64: dts: marvell: fix CP110 ICU node size
  irqchip/irq-mvebu-icu: fix wrong private data retrieval
  irqchip/irq-mvebu-icu: clarify the reset operation of configured
    interrupts
  irqchip/irq-mvebu-icu: switch to regmap
  irqchip/irq-mvebu-icu: make irq_domain local
  irqchip/irq-mvebu-icu: disociate ICU and NSR
  irqchip/irq-mvebu-icu: support ICU subnodes
  irqchip/irq-mvebu-sei: add new driver for Marvell SEI
  arm64: marvell: enable SEI driver
  irqchip/irq-mvebu-icu: add support for System Error Interrupts (SEI)
  dt-bindings/interrupt-controller: update Marvell ICU bindings
  dt-bindings/interrupt-controller: add documentation for Marvell SEI
    controller
  arm64: dts: marvell: add AP806 SEI subnode
  arm64: dts: marvell: use new bindings for CP110 interrupts
  arm64: dts: marvell: add CP110 ICU SEI subnode

 .../bindings/interrupt-controller/marvell,icu.txt  |  83 +++-
 .../bindings/interrupt-controller/marvell,sei.txt  |  50 +++
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  19 +
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      | 123 +++---
 drivers/irqchip/Kconfig                            |   3 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-mvebu-icu.c                    | 301 ++++++++++++---
 drivers/irqchip/irq-mvebu-sei.c                    | 422 +++++++++++++++++++++
 9 files changed, 872 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
 create mode 100644 drivers/irqchip/irq-mvebu-sei.c

-- 
2.14.1
