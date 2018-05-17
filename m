Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeEQIag (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:30:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41815 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752387AbeEQIa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:30:29 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v3 00/10] net: mvpp2: phylink conversion
Date: Thu, 17 May 2018 10:29:29 +0200
Message-Id: <20180517082939.14598-1-antoine.tenart@bootlin.com>
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

Also as the SFP cages on both DB boards can be considered as non-wired.
We thus chose not to describe those SFP cages and we use fixed-link.

The rest of the series uses phylink to add support for 1000BaseX and
2500BaseX modes in the PPv2 driver. To do this, two patches are needed
in the common PHY framework (patches 3 and 4). The last 4 patches modify
the device tree to use the new PPv2 functionalities.

The series has been tested for the device tree mode on the 7040-db,
8040-db and 8040-mcbin boards, to ensure all the interface where working
as expected.

@Dave: patches 7 to 10 should go through the mvebu tree (Gregory in
Cc.) to avoid any conflict with the other mvebu dt patches taken during
this cycle.

The series is based on today's net-next.

Thanks!
Antoine

Since v2:
  - Removed the SFP description from the DB boards, as their SFP cages
    are wired properly. We now use fixed-link.
  - Because of this rework, split the series in two, so that the SFP
    part is reviewed separately.
  - Small fixes in the phylink patch.
  - Rebased on the latest net-next branch.

Since v1:
  - Chose a different approach to the SFP changes, as the previous ones
    weren't valid and reworked both BD boards device trees.
  - Misc fixes.
  - Added Kishon's acked-by on one patch.
  - Rebaed on latest net-next branch.

Antoine Tenart (9):
  net: mvpp2: align the ethtool ops definition
  net: mvpp2: phylink support
  phy: add 2.5G SGMII mode to the phy_mode enum
  phy: cp110-comphy: 2.5G SGMII mode
  net: mvpp2: 1000baseX support
  net: mvpp2: 2500baseX support
  arm64: dts: marvell: mcbin: enable the fourth network interface
  arm64: dts: marvell: 8040-db: describe the 10G interfaces as
    fixed-link
  arm64: dts: marvell: 7040-db: describe the 10G interface as fixed-link

Russell King (1):
  arm64: dts: marvell: mcbin: add 10G SFP support

 .../arm64/boot/dts/marvell/armada-7040-db.dts |   5 +
 .../arm64/boot/dts/marvell/armada-8040-db.dts |  10 +
 .../boot/dts/marvell/armada-8040-mcbin.dts    |  70 ++
 drivers/net/ethernet/marvell/Kconfig          |   1 +
 drivers/net/ethernet/marvell/mvpp2.c          | 931 +++++++++++-------
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c  |  17 +-
 include/linux/phy/phy.h                       |   1 +
 7 files changed, 680 insertions(+), 355 deletions(-)

-- 
2.17.0
