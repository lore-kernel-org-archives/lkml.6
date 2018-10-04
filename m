Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555F7C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D632082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D632082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJDUKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:10:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38654 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbeJDUKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:10:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 422302090A; Thu,  4 Oct 2018 15:17:28 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id D5703207B4;
        Thu,  4 Oct 2018 15:17:17 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, andrew@lunn.ch,
        f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v2 0/5] net: phy: mscc: add support for VSC8584 and VSC8574 Microsemi quad-port PHYs
Date:   Thu,  4 Oct 2018 15:17:05 +0200
Message-Id: <20181004131710.14978-1-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both PHYs are 4-port PHY that are 10/100/1000BASE-T, 100BASE-FX, 1000BASE-X
and triple-speed copper SFP capable, can communicate with the MAC via
SGMII, QSGMII or 1000BASE-X, supports downshifting and can set the blinking
pattern of each of its 4 LEDs, supports SyncE as well as HP Auto-MDIX
detection.

VSC8574 supports WOL and VSC8584 supports hardware offloading of MACsec.

This patch series add support for 10/100/1000BASE-T, SGMII/QSGMII link with
the MAC, downshifting, HP Auto-MDIX detection and blinking pattern for
their 4 LEDs.

They have also an internal Intel 8051 microcontroller whose firmware needs
to be patched when the PHY is reset. If the 8051's firmware has the
expected CRC, its patching can be skipped. The microcontroller can be
accessed from any port of the PHY, though the CRC function can only be done
through the PHY that is the base PHY of the package (internal address 0)
due to a limitation of the firmware.

The GPIO register bank is a set of registers that are common to all PHYs in
the package. So any modification in any register of this bank affects all
PHYs of the package.

If the PHYs haven't been reset before booting the Linux kernel and were
configured to use interrupts for e.g. link status updates, it is required
to clear the interrupts mask register of all PHYs before being able to use
interrupts with any PHY. The first PHY of the package that will be init
will take care of clearing all PHYs interrupts mask registers. Thus, we
need to keep track of the init sequence in the package, if it's already
been done or if it's to be done.

Most of the init sequence of a PHY of the package is common to all PHYs in
the package, thus we use the SMI broadcast feature which enables us to
propagate a write in one register of one PHY to all PHYs in the same
package.

We also introduce a new development board called PCB120 which exists in
variants for VSC8584 and VSC8574 (and that's the only difference to the
best of my knowledge).

I suggest patches 1 to 3 go through net tree and patches 4 and 5 go
through MIPS tree. Patches going through net tree and those going through
MIPS tree do not depend on one another.

This patch series depends on two patch series though:
"mscc: ocelot: add support for SerDes muxing configuration"
(https://lore.kernel.org/lkml/20181004122208.32272-1-quentin.schulz@bootlin.com/)
"net: phy: mscc: various improvements to Microsemi PHY driver"
(https://lore.kernel.org/lkml/20181004124728.9821-1-quentin.schulz@bootlin.com/)

Thanks,
Quentin

v2:
  - add reviewed-by,
  - create phy_base_write/read functions to replace ugly
  __mdiobus_write/read,
  - add a base_addr variable in the priv structure of the phy driver to
  store the MDIO address of the base PHY in the package,
  - use this base_addr everywhere in the driver in lieu of passing the pair
  (mii_bus, int phy_addr) to each function,
  - add a mutex_is_locked() check in writes and read within the
  config_init function,
  - specify that broadcasting feature is impacting PHYs in the same package
  only and not accross the whole MDIO bus,
  - remove patch that introduced a config_pre_init function pointer to be
  set in the probe function depending on the probed PHY and used in the
  config_init function, instead, check the matched PHY in config_init to
  call the appropriate config_pre_init function,
  - migrate the multiple constants writes to an iteration over an array of
  constants,
  - move pinctrl DT node for PHY interrupt to the board DTS,
  - rename the pinctrl DT from the obscure gpio4 to phy_int_pins,

Quentin Schulz (5):
  dt-bindings: net: vsc8531: add two additional LED modes for VSC8584
  net: phy: mscc: add support for VSC8584 PHY
  net: phy: mscc: add support for VSC8574 PHY
  MIPS: mscc: add DT for Ocelot PCB120
  MIPS: mscc: add PCB120 to the ocelot fitImage

 arch/mips/boot/dts/mscc/Makefile              |    2 +-
 arch/mips/boot/dts/mscc/ocelot_pcb120.dts     |  107 ++
 arch/mips/generic/Kconfig                     |    6 +-
 arch/mips/generic/Platform                    |    2 +-
 ...ocelot_pcb123.its.S => board-ocelot.its.S} |   17 +
 drivers/net/phy/mscc.c                        | 1065 +++++++++++++++++
 include/dt-bindings/net/mscc-phy-vsc8531.h    |    2 +
 7 files changed, 1196 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb120.dts
 rename arch/mips/generic/{board-ocelot_pcb123.its.S => board-ocelot.its.S} (55%)

-- 
2.17.1

