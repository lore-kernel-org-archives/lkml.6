Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E77C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181FD2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181FD2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeKZLIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:08:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51962 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeKZLIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 06:08:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ0FXgh097194;
        Sun, 25 Nov 2018 18:15:33 -0600
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ0FXha126518
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 25 Nov 2018 18:15:33 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 25
 Nov 2018 18:15:32 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 25 Nov 2018 18:15:33 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ0FWna030819;
        Sun, 25 Nov 2018 18:15:32 -0600
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wAQ0FWU04334;
        Sun, 25 Nov 2018 18:15:32 -0600 (CST)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Lunn <andrew@lunn.ch>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH linux-next 00/10] net: ethernet: ti: cpsw: replace cpsw-phy-sel with phy driver
Date:   Sun, 25 Nov 2018 18:15:21 -0600
Message-ID: <20181126001531.12974-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI am335x/am437x/dra7(am5)/dm814x CPSW3G Ethernet Subsystem supports 
two 10/100/1000 Ethernet ports with selectable G/MII, RMII, and RGMII interfaces.
The interface mode is selected by configuring the MII mode selection register(s)
(GMII_SEL) in the System Control Module chapter (SCM).
                                               +--------------+
        +-------------------------------+      |SCM           |
        |                     CPSW      |      |  +---------+ |
        |        +--------------------------------+gmii_sel | |
        |        |                      |      |  +---------+ |
        |   +----v---+     +--------+   |      +--------------+
        |   |Port 1..<--+-->GMII/MII<------->
        |   |        |  |  |        |   |
        |   +--------+  |  +--------+   |
        |               |               |
        |               |  +--------+   |
        |               |  | RMII   <------->
        |               +-->        |   |
        |               |  +--------+   |
        |               |               |
        |               |  +--------+   |
        |               |  | RGMII  <------->
        |               +-->        |   |
        |                  +--------+   |
        +-------------------------------+

GMII_SEL register(s) and bit fields placement in SCM are different between SoCs
while fields meaning is the same. GMII_SEL(s) allows to select -
Port GMII/MII/RMII/RGMII Mode; RGMII Internal Delay Mode (SoC dependant) and
RMII Reference Clock Output mode (SoC dependant).

Historically CPSW external Port's interface mode selection configuartion was
introduced using custom driver and API cpsw-phy-sel.c.
This leads to unnecessary driver, DT binding and custom API support effort.
Moreover, even definition of cpsw-phy-sel node in DTs is logically incorrect [1]

mac: ethernet@4a100000 {
	compatible = "ti,am4372-cpsw","ti,cpsw";
	...

	phy_sel: cpsw-phy-sel@44e10650 {
		compatible = "ti,am43xx-cpsw-phy-sel";
		reg= <0x44e10650 0x4>;
		reg-names = "gmii-sel";
	};
};

This series replaces custom CPSW Port interface selection implementation
(cpsw-phy-sel.c) with well defined Linux PHY framework interface instead.
It introduces CPSW Port's PHY Interface Mode selection Driver (phy-gmii-sel)
which implements standard Linux PHY interface. The phy-gmii-sel PHY device
should defined as child device of SCM node (scm_conf) and can be attached to
each CPSW port node using standard PHY bindings (cell 1 - port number,
cell 2 - RMII refclk mode).

scm_conf: scm_conf@0 {
	compatible = "syscon", "simple-bus";

	gmii_sel_phy: cpsw-sel-netif {
		compatible = "ti,am43xx-gmii-sel-phy";
		syscon-scm = <&scm_conf>;
		#phy-cells = <2>;
	};
};

mac: ethernet@4a100000 {
	compatible = "ti,am4372-cpsw","ti,cpsw";

	cpsw_emac0: slave@4a100200 {
		phy-mode = "rgmii";
		phys = <&gmii_sel_phy 1 0>;
	};
};

The CPSW driver requests phy-gmii-sel PHY for each external port and uses
recently introduced PHY API phy_set_mode_ext() [1] for port interface mode
selection when netdev is opened.

	slave->data->gmii_sel_phy = devm_of_phy_get(&pdev->dev, port_node, NULL);
	slave->data->phy_if = of_get_phy_mode(port_node);

cpsw_ndo_open()
	phy_set_mode_ext(slave->data->gmii_sel_phy, PHY_MODE_ETHERNET, slave->data->phy_if);

Note. CPSW Port interface has to be reconfigured every time netdev is opened for
proper System Suspend support where CPSW can lose context.

[1] https://patchwork.kernel.org/cover/10689739/

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>

Grygorii Strashko (10):
  dt-bindings: phy: add cpsw port interface mode selection phy bindings
  phy: ti: introduce phy-gmii-sel driver
  dt-bindings: net: ti: cpsw: switch to use phy-gmii-sel phy
  net: ethernet: ti: cpsw: add support for port interface mode selection
    phy
  ARM: dts: dra7: switch to use phy-gmii-sel
  ARM: dts: dm814x: switch to use phy-gmii-sel
  ARM: dts: am4372: switch to use phy-gmii-sel
  ARM: dts: am335x: switch to use phy-gmii-sel
  dt-bindings: net: ti: deprecate cpsw-phy-sel bindings
  net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver

 .../devicetree/bindings/net/cpsw-phy-sel.txt       |   2 +-
 Documentation/devicetree/bindings/net/cpsw.txt     |   8 +-
 .../devicetree/bindings/phy/ti-phy-gmii-sel.txt    |  68 ++++
 arch/arm/boot/dts/am335x-baltos-ir2110.dts         |   4 -
 arch/arm/boot/dts/am335x-baltos-ir3220.dts         |   4 -
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         |   4 -
 arch/arm/boot/dts/am335x-chiliboard.dts            |   4 -
 arch/arm/boot/dts/am335x-icev2.dts                 |   4 -
 arch/arm/boot/dts/am335x-igep0033.dtsi             |   4 -
 arch/arm/boot/dts/am335x-lxm.dts                   |   4 -
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi  |   5 -
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts     |   5 -
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |   4 -
 arch/arm/boot/dts/am33xx-l4.dtsi                   |  15 +-
 arch/arm/boot/dts/am437x-l4.dtsi                   |  17 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   5 +-
 arch/arm/boot/dts/dm814x.dtsi                      |  15 +-
 arch/arm/boot/dts/dra7-l4.dtsi                     |  15 +-
 drivers/net/ethernet/ti/Kconfig                    |   6 +-
 drivers/net/ethernet/ti/cpsw.c                     |  19 +-
 drivers/net/ethernet/ti/cpsw.h                     |   6 +
 drivers/phy/ti/Kconfig                             |  10 +
 drivers/phy/ti/Makefile                            |   1 +
 drivers/phy/ti/phy-gmii-sel.c                      | 349 +++++++++++++++++++++
 24 files changed, 498 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt
 create mode 100644 drivers/phy/ti/phy-gmii-sel.c

-- 
2.10.5

