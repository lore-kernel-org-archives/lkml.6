Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80361C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409F721477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409F721477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeJDTQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:16:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35843 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbeJDTQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:16:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B86A62090A; Thu,  4 Oct 2018 14:23:01 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 74F8C20DDD;
        Thu,  4 Oct 2018 14:22:34 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v4 11/11] net: mscc: ocelot: make use of SerDes PHYs for handling their configuration
Date:   Thu,  4 Oct 2018 14:22:08 +0200
Message-Id: <20181004122208.32272-12-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004122208.32272-1-quentin.schulz@bootlin.com>
References: <20181004122208.32272-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the SerDes muxing was hardcoded to a given mode in the MAC
controller driver. Now, the SerDes muxing is configured within the
Device Tree and is enforced in the MAC controller driver so we can have
a lot of different SerDes configurations.

Make use of the SerDes PHYs in the MAC controller to set up the SerDes
according to the SerDes<->switch port mapping and the communication mode
with the Ethernet PHY.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/ethernet/mscc/Kconfig        |  2 +
 drivers/net/ethernet/mscc/ocelot.c       | 16 +++++++-
 drivers/net/ethernet/mscc/ocelot.h       |  6 ++-
 drivers/net/ethernet/mscc/ocelot_board.c | 50 +++++++++++++++++++-----
 drivers/net/ethernet/mscc/ocelot_regs.c  |  1 +
 5 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mscc/Kconfig b/drivers/net/ethernet/mscc/Kconfig
index 36c84625d54e..bcec0587cf61 100644
--- a/drivers/net/ethernet/mscc/Kconfig
+++ b/drivers/net/ethernet/mscc/Kconfig
@@ -23,6 +23,8 @@ config MSCC_OCELOT_SWITCH
 config MSCC_OCELOT_SWITCH_OCELOT
 	tristate "Ocelot switch driver on Ocelot"
 	depends on MSCC_OCELOT_SWITCH
+	depends on GENERIC_PHY
+	depends on OF_NET
 	help
 	  This driver supports the Ocelot network switch device as present on
 	  the Ocelot SoCs.
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 1a4f2bb48ead..8f11fdba8d0e 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -472,6 +472,7 @@ static int ocelot_port_open(struct net_device *dev)
 {
 	struct ocelot_port *port = netdev_priv(dev);
 	struct ocelot *ocelot = port->ocelot;
+	enum phy_mode phy_mode;
 	int err;
 
 	/* Enable receiving frames on the port, and activate auto-learning of
@@ -482,8 +483,21 @@ static int ocelot_port_open(struct net_device *dev)
 			 ANA_PORT_PORT_CFG_PORTID_VAL(port->chip_port),
 			 ANA_PORT_PORT_CFG, port->chip_port);
 
+	if (port->serdes) {
+		if (port->phy_mode == PHY_INTERFACE_MODE_SGMII)
+			phy_mode = PHY_MODE_SGMII;
+		else
+			phy_mode = PHY_MODE_QSGMII;
+
+		err = phy_set_mode(port->serdes, phy_mode);
+		if (err) {
+			netdev_err(dev, "Could not set mode of SerDes\n");
+			return err;
+		}
+	}
+
 	err = phy_connect_direct(dev, port->phy, &ocelot_port_adjust_link,
-				 PHY_INTERFACE_MODE_NA);
+				 port->phy_mode);
 	if (err) {
 		netdev_err(dev, "Could not attach to PHY\n");
 		return err;
diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
index ff0e3a5d7487..62c7c8eb00d9 100644
--- a/drivers/net/ethernet/mscc/ocelot.h
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -11,9 +11,10 @@
 #include <linux/bitops.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/phy.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <soc/mscc/ocelot_hsio.h>
 
 #include "ocelot_ana.h"
 #include "ocelot_dev.h"
@@ -454,6 +455,9 @@ struct ocelot_port {
 	u8 vlan_aware;
 
 	u64 *stats;
+
+	phy_interface_t phy_mode;
+	struct phy *serdes;
 };
 
 u32 __ocelot_read_ix(struct ocelot *ocelot, u32 reg, u32 offset);
diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index dca205e0ef75..953b32677383 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -6,6 +6,7 @@
  */
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/of_net.h>
 #include <linux/netdevice.h>
 #include <linux/of_mdio.h>
 #include <linux/of_platform.h>
@@ -253,18 +254,12 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&ocelot->multicast);
 	ocelot_init(ocelot);
 
-	ocelot_rmw(ocelot, HSIO_HW_CFG_DEV1G_4_MODE |
-		     HSIO_HW_CFG_DEV1G_6_MODE |
-		     HSIO_HW_CFG_DEV1G_9_MODE,
-		     HSIO_HW_CFG_DEV1G_4_MODE |
-		     HSIO_HW_CFG_DEV1G_6_MODE |
-		     HSIO_HW_CFG_DEV1G_9_MODE,
-		     HSIO_HW_CFG);
-
 	for_each_available_child_of_node(ports, portnp) {
 		struct device_node *phy_node;
 		struct phy_device *phy;
 		struct resource *res;
+		struct phy *serdes;
+		enum phy_mode phy_mode;
 		void __iomem *regs;
 		char res_name[8];
 		u32 port;
@@ -289,10 +284,45 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 			continue;
 
 		err = ocelot_probe_port(ocelot, port, regs, phy);
-		if (err) {
-			dev_err(&pdev->dev, "failed to probe ports\n");
+		if (err)
+			return err;
+
+		err = of_get_phy_mode(portnp);
+		if (err < 0)
+			ocelot->ports[port]->phy_mode = PHY_INTERFACE_MODE_NA;
+		else
+			ocelot->ports[port]->phy_mode = err;
+
+		switch (ocelot->ports[port]->phy_mode) {
+		case PHY_INTERFACE_MODE_NA:
+			continue;
+		case PHY_INTERFACE_MODE_SGMII:
+			phy_mode = PHY_MODE_SGMII;
+			break;
+		case PHY_INTERFACE_MODE_QSGMII:
+			phy_mode = PHY_MODE_QSGMII;
+			break;
+		default:
+			dev_err(ocelot->dev,
+				"invalid phy mode for port%d, (Q)SGMII only\n",
+				port);
+			return -EINVAL;
+		}
+
+		serdes = devm_of_phy_get(ocelot->dev, portnp, NULL);
+		if (IS_ERR(serdes)) {
+			err = PTR_ERR(serdes);
+			if (err == -EPROBE_DEFER)
+				dev_dbg(ocelot->dev, "deferring probe\n");
+			else
+				dev_err(ocelot->dev,
+					"missing SerDes phys for port%d\n",
+					port);
+
 			goto err_probe_ports;
 		}
+
+		ocelot->ports[port]->serdes = serdes;
 	}
 
 	register_netdevice_notifier(&ocelot_netdevice_nb);
diff --git a/drivers/net/ethernet/mscc/ocelot_regs.c b/drivers/net/ethernet/mscc/ocelot_regs.c
index 2518ce0fe265..9271af18b93b 100644
--- a/drivers/net/ethernet/mscc/ocelot_regs.c
+++ b/drivers/net/ethernet/mscc/ocelot_regs.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2017 Microsemi Corporation
  */
 #include "ocelot.h"
+#include <soc/mscc/ocelot_hsio.h>
 
 static const u32 ocelot_ana_regmap[] = {
 	REG(ANA_ADVLEARN,                  0x009000),
-- 
2.17.1

