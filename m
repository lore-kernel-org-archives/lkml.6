Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeENUFZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:05:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:32893 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751855AbeENUFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:05:23 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH net-next v3 0/7] Microsemi Ocelot Ethernet switch support
Date: Mon, 14 May 2018 22:04:53 +0200
Message-Id: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds initial support for the Microsemi Ethernet switch
present on Ocelot SoCs.

This only has bridging (and STP) support for now and it uses the
switchdev framework.
Coming features are VLAN filtering, link aggregation, IGMP snooping.

The switch can also be connected to an external CPU using PCIe.

Also, support for integration on other SoCs will be submitted.

The ocelot dts changes are here for reference and should probably go
through the MIPS tree once the bindings are accepted.

Changes in v3:
 - Collected Reviewed-by
 * Switchdev driver:
   - Fixed two issues reported by kbuild
   - Modified ethtool statistics to support different layoiut on different chips and take care of counter overflow

Changes in v2:
 - Dropped Microsemi Ocelot PHY support
 * MIIM driver:
   - Documented interrupts bindings
   - Moved the driver to drivers/net/phy/
   - Removed unused mutex
   - Removed MDIO bus scanning
 * Switchdev driver:
   - Changed compatible to mscc,vsc7514-switch
   - Removed unused header inclusion
   - Factorized MAC table selection in ocelot_mact_select()
   - Disable the port in ocelot_port_stop()
   - Fixed the smatch endianness warnings
   - int to unsinged int where necessary
   - Removed VID handling for the FDB it has been reworked anyway and will be
     submitted with VLAN support
   - Fixed up unused cases in ocelot_port_attr_set()
   - Added a loop to register all the IO register spaces
   - the ports are now in an ethernet-ports node

I've tried switching to NAPI but this is not working well, mainly because the
only way to disable interrupts is to actually mask them in the interrupt
controller (it is not possible to tell the switch to stop generating
interrupts).

Cc: James Hogan <jhogan@kernel.org>

Alexandre Belloni (7):
  dt-bindings: net: add DT bindings for Microsemi MIIM
  net: phy: mscc-miim: Add MDIO driver
  dt-bindings: net: add DT bindings for Microsemi Ocelot Switch
  net: mscc: Add initial Ocelot switch support
  MIPS: mscc: Add switch to ocelot
  MIPS: mscc: connect phys to ports on ocelot_pcb123
  MAINTAINERS: Add entry for Microsemi Ethernet switches

 .../devicetree/bindings/net/mscc-miim.txt     |   26 +
 .../devicetree/bindings/net/mscc-ocelot.txt   |   82 +
 MAINTAINERS                                   |    6 +
 arch/mips/boot/dts/mscc/ocelot.dtsi           |   88 ++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts     |   20 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/mscc/Kconfig             |   30 +
 drivers/net/ethernet/mscc/Makefile            |    5 +
 drivers/net/ethernet/mscc/ocelot.c            | 1333 +++++++++++++++++
 drivers/net/ethernet/mscc/ocelot.h            |  572 +++++++
 drivers/net/ethernet/mscc/ocelot_ana.h        |  625 ++++++++
 drivers/net/ethernet/mscc/ocelot_board.c      |  316 ++++
 drivers/net/ethernet/mscc/ocelot_dev.h        |  275 ++++
 drivers/net/ethernet/mscc/ocelot_dev_gmii.h   |  154 ++
 drivers/net/ethernet/mscc/ocelot_hsio.h       |  785 ++++++++++
 drivers/net/ethernet/mscc/ocelot_io.c         |  116 ++
 drivers/net/ethernet/mscc/ocelot_qs.h         |   78 +
 drivers/net/ethernet/mscc/ocelot_qsys.h       |  270 ++++
 drivers/net/ethernet/mscc/ocelot_regs.c       |  497 ++++++
 drivers/net/ethernet/mscc/ocelot_rew.h        |   81 +
 drivers/net/ethernet/mscc/ocelot_sys.h        |  144 ++
 drivers/net/phy/Kconfig                       |    7 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/mdio-mscc-miim.c              |  197 +++
 25 files changed, 5710 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mscc-miim.txt
 create mode 100644 Documentation/devicetree/bindings/net/mscc-ocelot.txt
 create mode 100644 drivers/net/ethernet/mscc/Kconfig
 create mode 100644 drivers/net/ethernet/mscc/Makefile
 create mode 100644 drivers/net/ethernet/mscc/ocelot.c
 create mode 100644 drivers/net/ethernet/mscc/ocelot.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_ana.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_board.c
 create mode 100644 drivers/net/ethernet/mscc/ocelot_dev.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_dev_gmii.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_hsio.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_io.c
 create mode 100644 drivers/net/ethernet/mscc/ocelot_qs.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_qsys.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_regs.c
 create mode 100644 drivers/net/ethernet/mscc/ocelot_rew.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_sys.h
 create mode 100644 drivers/net/phy/mdio-mscc-miim.c

-- 
2.17.0
