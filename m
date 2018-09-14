Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F72AECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1064420853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1064420853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeINO6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:58:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36766 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbeINO6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:58:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 760492080A; Fri, 14 Sep 2018 11:44:56 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1E74020618;
        Fri, 14 Sep 2018 11:44:56 +0200 (CEST)
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
Subject: [PATCH net-next 0/7] add support for VSC8584 and VSC8574 Microsemi quad-port PHYs
Date:   Fri, 14 Sep 2018 11:44:21 +0200
Message-Id: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
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
propagate a write in one register of one PHY to all PHYs in the package.

We also introduce a new development board called PCB120 which exists in
variants for VSC8584 and VSC8574 (and that's the only difference to the
best of my knowledge).

I suggest patches 1 to 4 go through net tree and patches 5 to 7 go through
MIPS tree. Patches going through net tree and those going through MIPS tree
do not depend on one another.

This patch series depends on two patch series though:
"mscc: ocelot: add support for SerDes muxing configuration"
(https://lore.kernel.org/lkml/cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com/)
"Various improvements to Microsemi PHY driver"
(https://lore.kernel.org/lkml/cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com/)
specifically patch 2/5 which defines constants that are used in this patch
series.

Thanks,
Quentin

Quentin Schulz (7):
  dt-bindings: net: vsc8531: add two additional LED modes for VSC8584
  net: phy: mscc: add support for VSC8584 PHY
  net: phy: mscc: split config_init in two functions for VSC8584
  net: phy: mscc: add support for VSC8574 PHY
  MIPS: mscc: ocelot: add GPIO4 pinmuxing DT node
  MIPS: mscc: add DT for Ocelot PCB120
  MIPS: mscc: add PCB120 to the ocelot fitImage

 arch/mips/boot/dts/mscc/Makefile            |    2 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi         |    5 +-
 arch/mips/boot/dts/mscc/ocelot_pcb120.dts   |  100 ++-
 arch/mips/generic/Kconfig                   |    6 +-
 arch/mips/generic/Platform                  |    2 +-
 arch/mips/generic/board-ocelot.its.S        |   40 +-
 arch/mips/generic/board-ocelot_pcb123.its.S |   23 +-
 drivers/net/phy/mscc.c                      | 1019 ++++++++++++++++++++-
 include/dt-bindings/net/mscc-phy-vsc8531.h  |    2 +-
 9 files changed, 1171 insertions(+), 28 deletions(-)
 create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb120.dts
 create mode 100644 arch/mips/generic/board-ocelot.its.S
 delete mode 100644 arch/mips/generic/board-ocelot_pcb123.its.S

base-commit: d9cca8eef36bb8918c9ed28574b79b7674fd36f6
-- 
git-series 0.9.1
