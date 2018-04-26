Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757016AbeDZUCG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:02:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35227 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755818AbeDZT7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:59:38 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH net-next v2 0/7] Microsemi Ocelot Ethernet switch support
Date: Thu, 26 Apr 2018 21:59:24 +0200
Message-Id: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
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
  net: mscc: Add MDIO driver
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
 drivers/net/ethernet/mscc/Kconfig             |   29 +
 drivers/net/ethernet/mscc/Makefile            |    5 +
 drivers/net/ethernet/mscc/ocelot.c            | 1316 +++++++++++++++++
 drivers/net/ethernet/mscc/ocelot.h            |  554 +++++++
 drivers/net/ethernet/mscc/ocelot_ana.h        |  625 ++++++++
 drivers/net/ethernet/mscc/ocelot_board.c      |  313 ++++
 drivers/net/ethernet/mscc/ocelot_dev.h        |  275 ++++
 drivers/net/ethernet/mscc/ocelot_dev_gmii.h   |  154 ++
 drivers/net/ethernet/mscc/ocelot_hsio.h       |  785 ++++++++++
 drivers/net/ethernet/mscc/ocelot_io.c         |  116 ++
 drivers/net/ethernet/mscc/ocelot_qs.h         |   78 +
 drivers/net/ethernet/mscc/ocelot_qsys.h       |  270 ++++
 drivers/net/ethernet/mscc/ocelot_regs.c       |  399 +++++
 drivers/net/ethernet/mscc/ocelot_rew.h        |   81 +
 drivers/net/ethernet/mscc/ocelot_sys.h        |  140 ++
 drivers/net/phy/Kconfig                       |    7 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/mdio-mscc-miim.c              |  197 +++
 25 files changed, 5569 insertions(+)
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
