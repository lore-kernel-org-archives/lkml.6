Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65B5C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6AF20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WG7L7Xf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6AF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbeKJJcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:32:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34054 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbeKJJcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:32:15 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA9NlvL0107169;
        Fri, 9 Nov 2018 17:47:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541807277;
        bh=Pz+w7aboIHGED4+6sTqCBG0mCcjPu1zUeQHXUm2nF9w=;
        h=From:To:CC:Subject:Date;
        b=WG7L7Xf7+Q6p7y1hCMTL0Ho3ly/Z2P5iRaXi+Y5npbA2in9ziQPDVQ2ecxbxEB6PY
         tNm4VhLUqZKAB6znaIwC2RxTGuJ63tbX9iY/BaNfddOFWhEWLMPWEJ7Plcy2J5YzF4
         2FH0mdZyLPqABZp22Y45Hj2qSR9NT1XOWOd5ZsvM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA9NlvJH089765
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Nov 2018 17:47:57 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 9 Nov
 2018 17:47:57 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 9 Nov 2018 17:47:57 -0600
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA9NluNS019483;
        Fri, 9 Nov 2018 17:47:56 -0600
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wA9Nlux26432;
        Fri, 9 Nov 2018 17:47:56 -0600 (CST)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 0/5] phy: core: rework phy_set_mode to accept phy mode and submode
Date:   Fri, 9 Nov 2018 17:47:50 -0600
Message-ID: <20181109234755.21687-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon, All,

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

changes in v2:
- marvell PHY and net drivers updated as recommended by Russell King

v1: https://lkml.org/lkml/2018/11/8/260

[1] https://lkml.org/lkml/2018/10/25/366

Grygorii Strashko (5):
  phy: core: rework phy_set_mode to accept phy mode and submode
  phy: core: add PHY_MODE_ETHERNET
  phy: ocelot-serdes: convert to use eth phy mode and submode
  phy: mvebu-cp110-comphy: convert to use eth phy mode and submode
  phy: core: clean up unused ethernet specific phy modes

 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 19 +-----
 drivers/net/ethernet/mscc/ocelot.c              |  9 +--
 drivers/phy/allwinner/phy-sun4i-usb.c           |  3 +-
 drivers/phy/amlogic/phy-meson-gxl-usb2.c        |  5 +-
 drivers/phy/amlogic/phy-meson-gxl-usb3.c        |  5 +-
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c    | 86 ++++++++++++++-----------
 drivers/phy/mediatek/phy-mtk-tphy.c             |  2 +-
 drivers/phy/mediatek/phy-mtk-xsphy.c            |  2 +-
 drivers/phy/mscc/phy-ocelot-serdes.c            | 16 +++--
 drivers/phy/phy-core.c                          |  6 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c             |  3 +-
 drivers/phy/qualcomm/phy-qcom-qusb2.c           |  3 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c    |  3 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c    |  3 +-
 drivers/phy/qualcomm/phy-qcom-usb-hs.c          |  3 +-
 drivers/phy/ti/phy-da8xx-usb.c                  |  3 +-
 drivers/phy/ti/phy-tusb1210.c                   |  2 +-
 include/linux/phy/phy.h                         | 18 ++++--
 18 files changed, 100 insertions(+), 91 deletions(-)

-- 
2.10.5

