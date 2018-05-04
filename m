Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeEDOEr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:04:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60378 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbeEDOAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:00:13 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 00/13] net: mvpp2: phylink conversion
Date: Fri,  4 May 2018 15:56:30 +0200
Message-Id: <20180504135643.23466-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, Russell,

This series convert the Marvell PPv2 driver to phylink (models the MAC
to PHY link).

One important point is the PPv2 driver supports two probe modes: device
tree and ACPI. This series only brings phylink support for the device
tree mode, as the ACPI one will need further work. Still, the driver
should be working as before when using ACPI. This split should be
temporary, and was discussed with Marcin (in Cc.) who added ACPI support
to the driver.

Also as the SFP cages on both DB boards can be considered as non-wired,
the SFP code was reworked to really support when some pins of the SFP
cage aren't described in the device tree. Also a warning was added when
no Tx disable pin is available. (Patches 1-3).

Then the phylink callbacks are implemented (patch 5).

The rest of the series uses phylink to add support for 1000BaseX and
2500BaseX modes in the PPv2 driver. To do this, two patches are needed
in the common PHY framework (patches 6 and 7). The last 3 patches modify
the device tree to use the new PPv2 functionalities.

The series has been tested for the device tree mode on the 7040-db,
8040-db and 8040-mcbin boards, to ensure all the interface where working
as expected.

@Dave: patches 10 to 13 should go through the mvebu tree (Gregory in
Cc.) to avoid any conflict with the other mvebu dt patches taken during
this cycle.

The series is based on today's net-next, and is available at:
https://github.com/MISL-EBU-System-SW/mainline-public/ at/net-next/ppv2-phylink

Thanks!
Antoine

Since v1:
  - Chose a different approach to the SFP changes, as the previous ones
    weren't valid and reworked both BD boards device trees.
  - Misc fixes.
  - Added Kishon's acked-by on one patch.
  - Rebaed on latest net-next branch.

Antoine Tenart (12):
  net: phy: sfp: make the i2c-bus property really optional
  net: phy: sfp: handle non-wired SFP connectors
  net: phy: sfp: warn the user when no tx_disable pin is available
  net: mvpp2: align the ethtool ops definition
  net: mvpp2: phylink support
  phy: add 2.5G SGMII mode to the phy_mode enum
  phy: cp110-comphy: 2.5G SGMII mode
  net: mvpp2: 1000baseX support
  net: mvpp2: 2500baseX support
  arm64: dts: marvell: mcbin: enable the fourth network interface
  arm64: dts: marvell: 7040-db: describe the 10G SFP cage
  arm64: dts: marvell: 8040-db: describe the 10G SFP cages

Russell King (1):
  arm64: dts: marvell: mcbin: add 10G SFP support

 .../arm64/boot/dts/marvell/armada-7040-db.dts |   6 +
 .../arm64/boot/dts/marvell/armada-8040-db.dts |  12 +
 .../boot/dts/marvell/armada-8040-mcbin.dts    |  70 ++
 drivers/net/ethernet/marvell/Kconfig          |   1 +
 drivers/net/ethernet/marvell/mvpp2.c          | 918 +++++++++++-------
 drivers/net/phy/sfp.c                         |  37 +
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c  |  17 +-
 include/linux/phy/phy.h                       |   1 +
 8 files changed, 709 insertions(+), 353 deletions(-)

-- 
2.17.0
