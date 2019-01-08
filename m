Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAE0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93D72070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfAHQbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:31:43 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45887 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbfAHQbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:31:39 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 52EEE20A1D; Tue,  8 Jan 2019 17:31:36 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id E7C2420763;
        Tue,  8 Jan 2019 17:31:25 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v5 0/7] Add Armada 3700 COMPHY support
Date:   Tue,  8 Jan 2019 17:31:17 +0100
Message-Id: <20190108163124.6409-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds a new driver to support Armada 3700 COMPHY IP.
The series has been tested on an ESPRESSObin with SATA, PCIe
and USB3 host. For this purpose, patch 1 enumerates the SATA PHY
mode. The SGMII PHY mode that is supported by the IP has been written
(uses SMC calls anyway) but could not be tested on this platform.

Three series will follow to add PHY support (or at least a PHY nodes
in the A3700/ESPRESSObin device trees) to the MVEBU AHCI driver, the
Aardvark PCI controller driver and the MVEBU xHCI driver. All this is
needed in order to achieve suspend to RAM on this platform.

Thanks,
Miquèl


Changes since v4:
=================
* Fixed error in the driver probe where PHY_INTERFACE_MODE_NA was
  assigned to lane->mode instead of lane->submode.
* Compile-in the driver by default (depends on ARCH_MVEBU).
* Add dependency on HAVE_ARM_SMCC in Kconfig.

Changes since v3:
=================
* Added Rob's Reviewed-by tag on bindings.
* Rebased on top of phy -next as of the 12th of December, 2018.
* Adapted the driver to support SGMII/1000BASEX and
  HS_SGMII/2500BASEX.

Changes since v2:
=================
* Remove redundant check on lane->port/args->arg[0] at the end of the
  ->xlate() callback. Do it on both armada-cp110 and armada-a3700
  COMPHY drivers.
* Put my SoB as author of the patch first when a patch is co-developed.

Changes since v1:
=================
* Fix wrong check in ->xlate().
* Apply the same fix to the cp110 comphy driver from which the a3700
  driver is based.
* Added credit to Gregorz Jaszczyk for his work.
* Added Suggested-by tag to the patch adding the COMPHY DT node.


Grzegorz Jaszczyk (1):
  phy: enumerate SATA PHY mode

Miquel Raynal (6):
  phy: mvebu-cp110-comphy: fix port check in ->xlate()
  phy: add A3700 COMPHY support
  dt-bindings: phy: mvebu-comphy: extend the file to describe a3700
    bindings
  MAINTAINERS: phy: add entry for Armada 3700 COMPHY driver
  ARM64: dts: marvell: armada-37xx: fix SATA node scope
  ARM64: dts: marvell: armada-37xx: declare the COMPHY node

 .../bindings/phy/phy-mvebu-comphy.txt         |  65 +++-
 MAINTAINERS                                   |   6 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  31 +-
 drivers/phy/marvell/Kconfig                   |  12 +
 drivers/phy/marvell/Makefile                  |   1 +
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c  | 318 ++++++++++++++++++
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c  |   2 -
 include/linux/phy/phy.h                       |   1 +
 8 files changed, 421 insertions(+), 15 deletions(-)
 create mode 100644 drivers/phy/marvell/phy-mvebu-a3700-comphy.c

-- 
2.19.1

