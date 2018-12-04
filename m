Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0BDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACCC20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACCC20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeLDTRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:17:45 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46653 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeLDTRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:17:45 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8AB0620A5A; Tue,  4 Dec 2018 20:17:42 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8E59E20717;
        Tue,  4 Dec 2018 20:17:31 +0100 (CET)
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
Subject: [PATCH v3 0/8] Add Armada 3700 COMPHY support
Date:   Tue,  4 Dec 2018 20:17:22 +0100
Message-Id: <20181204191730.11516-1-miquel.raynal@bootlin.com>
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

Miquel Raynal (7):
  phy: mvebu-cp110-comphy: fix spelling in structure name
  phy: mvebu-cp110-comphy: fix port check in ->xlate()
  phy: add A3700 COMPHY support
  dt-bindings: phy: mvebu-comphy: extend the file to describe a3700
    bindings
  MAINTAINERS: phy: add entry for Armada 3700 COMPHY driver
  ARM64: dts: marvell: armada-37xx: fix SATA node scope
  ARM64: dts: marvell: armada-37xx: declare the COMPHY node

 .../bindings/phy/phy-mvebu-comphy.txt         |  65 ++++-
 MAINTAINERS                                   |   6 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  31 +-
 drivers/phy/marvell/Kconfig                   |  10 +
 drivers/phy/marvell/Makefile                  |   1 +
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c  | 274 ++++++++++++++++++
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c  |   6 +-
 include/linux/phy/phy.h                       |   1 +
 8 files changed, 377 insertions(+), 17 deletions(-)
 create mode 100644 drivers/phy/marvell/phy-mvebu-a3700-comphy.c

-- 
2.19.1

