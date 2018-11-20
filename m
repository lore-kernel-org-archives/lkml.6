Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00ABC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0392089F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wh1pept9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0392089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbeKTLwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:52:03 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60198 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbeKTLwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:52:02 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAK1OR7c084589;
        Mon, 19 Nov 2018 19:24:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542677067;
        bh=2VDfed9KY4h+R8FdQ2P0e/jfTBo+1N6PWOIRZasAyXU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wh1pept97PZpKSdXXCfCaRCZQpm2SQ3gW5MEg8Z8VFEixRNiEdGMn/6b2zu98ui60
         0pqe5sgaKK6xbF4PjpFsd3tt20s9KuoYpoJzQYdmp/UjKQ56kKssN+gEDKV3PU3zW5
         bMP1e0yJLOsygg8CrVC8Nk37mzZHpLcFmM1Jn7hQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAK1OR4h128541
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 19:24:27 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 19:24:27 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 19:24:27 -0600
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAK1ORQ7001274;
        Mon, 19 Nov 2018 19:24:27 -0600
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wAK1OQx26497;
        Mon, 19 Nov 2018 19:24:26 -0600 (CST)
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
Subject: [PATCH v3 3/5] phy: ocelot-serdes: convert to use eth phy mode and submode
Date:   Mon, 19 Nov 2018 19:24:22 -0600
Message-ID: <20181120012424.11802-4-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20181120012424.11802-1-grygorii.strashko@ti.com>
References: <20181120012424.11802-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ocelot-serdes PHY driver to use recently introduced
PHY_MODE_ETHERNET and phy_set_mode_ext().

Cc: Quentin Schulz <quentin.schulz@bootlin.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/mscc/ocelot.c   |  9 ++-------
 drivers/phy/mscc/phy-ocelot-serdes.c | 22 ++++++++++++++++------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 3238b9e..3edb608 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -472,7 +472,6 @@ static int ocelot_port_open(struct net_device *dev)
 {
 	struct ocelot_port *port = netdev_priv(dev);
 	struct ocelot *ocelot = port->ocelot;
-	enum phy_mode phy_mode;
 	int err;
 
 	/* Enable receiving frames on the port, and activate auto-learning of
@@ -484,12 +483,8 @@ static int ocelot_port_open(struct net_device *dev)
 			 ANA_PORT_PORT_CFG, port->chip_port);
 
 	if (port->serdes) {
-		if (port->phy_mode == PHY_INTERFACE_MODE_SGMII)
-			phy_mode = PHY_MODE_SGMII;
-		else
-			phy_mode = PHY_MODE_QSGMII;
-
-		err = phy_set_mode(port->serdes, phy_mode);
+		err = phy_set_mode_ext(port->serdes, PHY_MODE_ETHERNET,
+				       port->phy_mode);
 		if (err) {
 			netdev_err(dev, "Could not set mode of SerDes\n");
 			return err;
diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-ocelot-serdes.c
index c61a9890..77c46f6 100644
--- a/drivers/phy/mscc/phy-ocelot-serdes.c
+++ b/drivers/phy/mscc/phy-ocelot-serdes.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/phy.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -104,20 +105,24 @@ struct serdes_mux {
 	u8			idx;
 	u8			port;
 	enum phy_mode		mode;
+	int			submode;
 	u32			mask;
 	u32			mux;
 };
 
-#define SERDES_MUX(_idx, _port, _mode, _mask, _mux) {		\
+#define SERDES_MUX(_idx, _port, _mode, _submode, _mask, _mux) {		\
 	.idx = _idx,						\
 	.port = _port,						\
 	.mode = _mode,						\
+	.submode = _submode,					\
 	.mask = _mask,						\
 	.mux = _mux,						\
 }
 
-#define SERDES_MUX_SGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_SGMII, m, c)
-#define SERDES_MUX_QSGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_QSGMII, m, c)
+#define SERDES_MUX_SGMII(i, p, m, c) \
+	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_SGMII, m, c)
+#define SERDES_MUX_QSGMII(i, p, m, c) \
+	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_QSGMII, m, c)
 
 static const struct serdes_mux ocelot_serdes_muxes[] = {
 	SERDES_MUX_SGMII(SERDES1G(0), 0, 0, 0),
@@ -154,7 +159,7 @@ static const struct serdes_mux ocelot_serdes_muxes[] = {
 	SERDES_MUX_SGMII(SERDES6G(1), 8, 0, 0),
 	SERDES_MUX_SGMII(SERDES6G(2), 10, HSIO_HW_CFG_PCIE_ENA |
 			 HSIO_HW_CFG_DEV2G5_10_MODE, 0),
-	SERDES_MUX(SERDES6G(2), 10, PHY_MODE_PCIE, HSIO_HW_CFG_PCIE_ENA,
+	SERDES_MUX(SERDES6G(2), 10, PHY_MODE_PCIE, 0, HSIO_HW_CFG_PCIE_ENA,
 		   HSIO_HW_CFG_PCIE_ENA),
 };
 
@@ -164,12 +169,17 @@ static int serdes_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	unsigned int i;
 	int ret;
 
+	/* As of now only PHY_MODE_ETHERNET is supported */
+	if (mode != PHY_MODE_ETHERNET)
+		return -EOPNOTSUPP;
+
 	for (i = 0; i < ARRAY_SIZE(ocelot_serdes_muxes); i++) {
 		if (macro->idx != ocelot_serdes_muxes[i].idx ||
-		    mode != ocelot_serdes_muxes[i].mode)
+		    mode != ocelot_serdes_muxes[i].mode ||
+		    submode != ocelot_serdes_muxes[i].submode)
 			continue;
 
-		if (mode != PHY_MODE_QSGMII &&
+		if (submode != PHY_INTERFACE_MODE_QSGMII &&
 		    macro->port != ocelot_serdes_muxes[i].port)
 			continue;
 
-- 
2.10.5

