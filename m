Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753474AbeCPKfn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:35:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34995 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753449AbeCPKfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:35:40 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 00/10] net: mvpp2: phylink conversion
Date: Fri, 16 Mar 2018 11:33:41 +0100
Message-Id: <20180316103351.16616-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, Russell,

This series convert the Marvell PPv2 driver to phylink (models the MAC
to PHY link). The series is a respin of a patch[1] and a series[2] sent
a while ago. All these patches have been heavily reworked, this is why
this series isn't a new version of the previous work. I still tried to
take in account the comments I got back then (when applicable).

One important point is the PPv2 driver supports two probe modes: device
tree and ACPI. This series only brings phylink support for the device
tree mode, as the ACPI one will need further work. Still, the driver
should be working as before when using ACPI. This split should be
temporary, and was discussed with Marcin (in Cc.) who added ACPI support
to the driver.

Before implementing phylink callbacks in the PPv2 driver, some patches
are required (patches 1 and 2). The first one is a cosmetic patch, the
other one modifies the phylink core. Then PPv2 is converted to phylink.

The rest of the series uses phylink to add support for 1000BaseX and
2500BaseX modes in the PPv2 driver. To do this, two patches are needed
in the common PHY framework (patches 4 and 5). These patches were
previously acked by Kishon but as this was a while ago I didn't kept the
tags. The last 3 patches modify the device tree to use the new PPv2
functionalities.

@Dave: patches 8 to 10 should go through the mvebu tree (Gregory in Cc.)
to avoid any conflict with the other mvebu dt patches taken during this
cycle.

The series has been tested for the device tree mode on the 7040-db,
8040-db and 8040-mcbin boards, to ensure all the interface where working
as expected. Marcin (in Cc.) tested the series for the ACPI mode.

The series is based on today's net-next, and is available at:
https://github.com/MISL-EBU-System-SW/mainline-public/ at/net-next/ppv2-phylink

Thanks!
Antoine

[1] http://www.spinics.net/lists/netdev/msg456023.html
[2] https://lkml.org/lkml/2018/1/12/59

Antoine Tenart (10):
  net: mvpp2: align the ethtool ops definition
  net: phy: phylink: allow 10GKR interface to use in-band negotiation
  net: mvpp2: phylink support
  phy: add 2.5G SGMII mode to the phy_mode enum
  phy: cp110-comphy: 2.5G SGMII mode
  net: mvpp2: 1000baseX support
  net: mvpp2: 2500baseX support
  arm64: dts: marvell: 7040-db: set the 10G interface management to
    in-band
  arm64: dts: marvell: 8040-db: set the 10G interfaces management to
    in-band
  arm64: dts: marvell: mcbin: enable the fourth network interface

 arch/arm64/boot/dts/marvell/armada-7040-db.dts    |   1 +
 arch/arm64/boot/dts/marvell/armada-8040-db.dts    |   2 +
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts |  11 +
 drivers/net/ethernet/marvell/Kconfig              |   1 +
 drivers/net/ethernet/marvell/mvpp2.c              | 917 +++++++++++++---------
 drivers/net/phy/phylink.c                         |   3 +-
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c      |  17 +-
 include/linux/phy/phy.h                           |   1 +
 8 files changed, 599 insertions(+), 354 deletions(-)

-- 
2.14.3
