Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A29C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D545F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dc797Oqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D545F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbeKTLwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:52:08 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60220 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKTLwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:52:07 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAK1OQAq084576;
        Mon, 19 Nov 2018 19:24:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542677066;
        bh=7EqDP1FfQdIgVvRV9tN17/+4muTaK9fhI9TG3owNmeo=;
        h=From:To:CC:Subject:Date;
        b=Dc797OqpA/JskSug2Cu5UkFhH1Yuqe9Le44FE7GYj2pK2Du9rF7jkizNPDBkt03fh
         TV5nfePMOry9sSPpV08/UYKnNRBJTozBFEtDnK9cnNipJFSA9BYn26uGpnG4ZgfCQS
         YQhZ1ed85EmsYaVAH05045EEbI2v7D4pX/4mw4IU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAK1OQRT128531
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 19:24:26 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 19:24:26 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 19:24:26 -0600
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAK1OQhf029710;
        Mon, 19 Nov 2018 19:24:26 -0600
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wAK1OPx26485;
        Mon, 19 Nov 2018 19:24:25 -0600 (CST)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v3 0/5] phy: core: rework phy_set_mode to accept phy mode and submode
Date:   Mon, 19 Nov 2018 19:24:19 -0600
Message-ID: <20181120012424.11802-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon, All,

Thank you for your review.
I've not added "Tested-by"/"Acked-by" tags due to code changes in v3.

As was discussed in [1] I'm posting series which introduces rework of
phy_set_mode to accept phy mode and submode. I've dropped TI specific patches as
this change is pretty big by itself.

Patch 1 is cumulative change which refactors PHY framework code to
support dual level PHYs mode configuration - PHY mode and PHY submode. It
extends .set_mode() callback to support additional parameter "int submode"
and converts all corresponding PHY drivers to support new .set_mode()
callback declaration.
The new extended PHY API
 int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode)
is introduced to support dual level PHYs mode configuration and existing
phy_set_mode() API is converted to macros, so PHY framework consumers do
not need to be changed (~21 matches).

Patches 2-4: Add new PHY's mode to be used by Ethernet PHY interface drivers or
multipurpose PHYs like serdes and convert ocelot-serdes and mvebu-cp110-comphy
PHY drivers to use recently introduced PHY_MODE_ETHERNET and phy_set_mode_ext().

Patch 5 - removes unused, ethernet specific phy modes from enum phy_mode.

Testing:
 - series tested on TI am335x/am437x/am5(dra7) paltforms.
 - other driver build tested.

changes in v3:
- mux tables for PHY ocelot-serdes driver updated to store PHY mode and submode
- mux tables for PHY mvebu-cp110-comphy driver updated to store PHY mode
  and submode
changes in v2:
- marvell PHY and net drivers updated as recommended by Russell King

v2: https://lkml.org/lkml/2018/11/10/220
v1: https://lkml.org/lkml/2018/11/8/260

[1] https://lkml.org/lkml/2018/10/25/366

Grygorii Strashko (5):
  phy: core: rework phy_set_mode to accept phy mode and submode
  phy: core: add PHY_MODE_ETHERNET
  phy: ocelot-serdes: convert to use eth phy mode and submode
  phy: mvebu-cp110-comphy: convert to use eth phy mode and submode
  phy: core: clean up unused ethernet specific phy modes

 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 19 +----
 drivers/net/ethernet/mscc/ocelot.c              |  9 +--
 drivers/phy/allwinner/phy-sun4i-usb.c           |  3 +-
 drivers/phy/amlogic/phy-meson-gxl-usb2.c        |  5 +-
 drivers/phy/amlogic/phy-meson-gxl-usb3.c        |  5 +-
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c    | 93 ++++++++++++++-----------
 drivers/phy/mediatek/phy-mtk-tphy.c             |  2 +-
 drivers/phy/mediatek/phy-mtk-xsphy.c            |  2 +-
 drivers/phy/mscc/phy-ocelot-serdes.c            | 24 +++++--
 drivers/phy/phy-core.c                          |  6 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c             |  3 +-
 drivers/phy/qualcomm/phy-qcom-qusb2.c           |  3 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c    |  3 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c    |  3 +-
 drivers/phy/qualcomm/phy-qcom-usb-hs.c          |  3 +-
 drivers/phy/ti/phy-da8xx-usb.c                  |  3 +-
 drivers/phy/ti/phy-tusb1210.c                   |  2 +-
 include/linux/phy/phy.h                         | 18 +++--
 18 files changed, 111 insertions(+), 95 deletions(-)

-- 
2.10.5

