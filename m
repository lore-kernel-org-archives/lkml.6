Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1198DC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B5D207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbfA3P66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:58:58 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:43948 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731290AbfA3P6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:58:55 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 5BFD63A66BF;
        Wed, 30 Jan 2019 16:50:31 +0100 (CET)
X-Originating-IP: 90.88.147.226
Received: from localhost.localdomain (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id E4236FF80E;
        Wed, 30 Jan 2019 15:50:28 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/3] phy: Add support for the SMSC USB333x ULPI USB PHY
Date:   Wed, 30 Jan 2019 16:50:22 +0100
Message-Id: <20190130155023.4495-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130155023.4495-1-paul.kocialkowski@bootlin.com>
References: <20190130155023.4495-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a standard ULPI USB PHY that works according to the ULPI 1.1
specification, which supports USB 2.0 OTG.

This drivers mostly allows settong a few generic bits that are specific
to the use case, in addition to handling the reference clock and reset
GPIO. In particular, it allows configuring the PHY to use an internal
VBUS reference when nothing is connected to the VBUS pin.

Two vendor-specific fields are also supported, which allow setting up
high-speed compensation by lowering the squelch detector threshold and
tweaking the PHY's data output voltage.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/phy/Kconfig            |   1 +
 drivers/phy/Makefile           |   1 +
 drivers/phy/smsc/Kconfig       |  11 ++
 drivers/phy/smsc/Makefile      |   2 +
 drivers/phy/smsc/phy-usb333x.c | 301 +++++++++++++++++++++++++++++++++
 5 files changed, 316 insertions(+)
 create mode 100644 drivers/phy/smsc/Kconfig
 create mode 100644 drivers/phy/smsc/Makefile
 create mode 100644 drivers/phy/smsc/phy-usb333x.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 250abe290ca1..f1bed15f7e5c 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -64,6 +64,7 @@ source "drivers/phy/ralink/Kconfig"
 source "drivers/phy/renesas/Kconfig"
 source "drivers/phy/rockchip/Kconfig"
 source "drivers/phy/samsung/Kconfig"
+source "drivers/phy/smsc/Kconfig"
 source "drivers/phy/socionext/Kconfig"
 source "drivers/phy/st/Kconfig"
 source "drivers/phy/tegra/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 0d9fddc498a6..499987ba26d1 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -25,6 +25,7 @@ obj-y					+= broadcom/	\
 					   qualcomm/	\
 					   ralink/	\
 					   samsung/	\
+					   smsc/	\
 					   socionext/	\
 					   st/		\
 					   ti/
diff --git a/drivers/phy/smsc/Kconfig b/drivers/phy/smsc/Kconfig
new file mode 100644
index 000000000000..2d9904986250
--- /dev/null
+++ b/drivers/phy/smsc/Kconfig
@@ -0,0 +1,11 @@
+#
+# PHY drivers for SMSC platforms
+#
+config PHY_USB333X
+	tristate "SMSC USB333x ULPI USB PHY Driver"
+	depends on USB_ULPI_BUS
+	select GENERIC_PHY
+	help
+	  Support for SMSC USB333x ULPI USB PHY.
+
+
diff --git a/drivers/phy/smsc/Makefile b/drivers/phy/smsc/Makefile
new file mode 100644
index 000000000000..1cafd3b5845f
--- /dev/null
+++ b/drivers/phy/smsc/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_USB333X)		+= phy-usb333x.o
diff --git a/drivers/phy/smsc/phy-usb333x.c b/drivers/phy/smsc/phy-usb333x.c
new file mode 100644
index 000000000000..ed0b0cd4ba65
--- /dev/null
+++ b/drivers/phy/smsc/phy-usb333x.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SMSC USB333x ULPI USB PHY Driver
+ *
+ * Copyright (C) 2018 Bootlin
+ *
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/ulpi/driver.h>
+#include <linux/ulpi/regs.h>
+#include <linux/phy/ulpi_phy.h>
+
+#define USB333X_HS_COMP	0x31
+
+#define USB333X_HS_COMP_VARISENSE_SHIFT	0
+#define USB333X_HS_COMP_VARISENSE_MASK	GENMASK(1, 0)
+#define USB333X_HS_COMP_PHYBOOST_SHIFT	4
+#define USB333X_HS_COMP_PHYBOOST_MASK	GENMASK(6, 4)
+
+struct usb333x {
+	struct ulpi *ulpi;
+	struct phy *phy;
+	struct clk *refclk;
+	struct gpio_desc *reset;
+
+	bool extvbus_passthru;
+	bool auto_resume;
+	bool chrg_vbus;
+	bool dischrg_vbus;
+	bool id_pull_up;
+
+	u32 varisense;
+	u32 phyboost;
+};
+
+static int usb333x_setup_control(struct usb333x *usb333x)
+{
+	u8 val_ifc, val_otg;
+	int ret;
+
+	ret = ulpi_read(usb333x->ulpi, ULPI_IFC_CTRL);
+	if (ret < 0)
+		return ret;
+
+	val_ifc = (u8)ret;
+
+	ret = ulpi_read(usb333x->ulpi, ULPI_OTG_CTRL);
+	if (ret < 0)
+		return ret;
+
+	val_otg = (u8)ret;
+
+	if (usb333x->extvbus_passthru) {
+		/* Clear EXTVBUS complement to get EXTVBUS high. */
+		val_ifc &= ~ULPI_IFC_CTRL_EXTERNAL_VBUS;
+
+		/* Drive VbusValid from EXTVBUS (high). */
+		val_ifc |= ULPI_IFC_CTRL_PASSTHRU;
+		val_otg |= ULPI_OTG_CTRL_EXTVBUSIND;
+	}
+
+	if (usb333x->chrg_vbus)
+		val_otg |= ULPI_OTG_CTRL_CHRGVBUS;
+
+	if (usb333x->dischrg_vbus)
+		val_otg |= ULPI_OTG_CTRL_DISCHRGVBUS;
+
+	if (usb333x->id_pull_up)
+		val_otg |= ULPI_OTG_CTRL_ID_PULLUP;
+
+	ret = ulpi_write(usb333x->ulpi, ULPI_IFC_CTRL, val_ifc);
+	if (ret)
+		return ret;
+
+	ret = ulpi_write(usb333x->ulpi, ULPI_OTG_CTRL, val_otg);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int usb333x_setup_hs_compensation(struct usb333x *usb333x)
+{
+	u8 val;
+	int ret;
+
+	ret = ulpi_read(usb333x->ulpi, USB333X_HS_COMP);
+	if (ret < 0)
+		return ret;
+
+	val = (u8)ret;
+
+	val |= (usb333x->varisense << USB333X_HS_COMP_VARISENSE_SHIFT) &
+	       USB333X_HS_COMP_VARISENSE_MASK;
+
+	val |= (usb333x->phyboost << USB333X_HS_COMP_PHYBOOST_SHIFT) &
+	       USB333X_HS_COMP_PHYBOOST_MASK;
+
+	ret = ulpi_write(usb333x->ulpi, USB333X_HS_COMP, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int usb333x_power_on(struct phy *phy)
+{
+	struct usb333x *usb333x = phy_get_drvdata(phy);
+	int ret;
+
+	if (usb333x->refclk) {
+		clk_prepare_enable(usb333x->refclk);
+		usleep_range(1000, 2000);
+	}
+
+	if (usb333x->reset) {
+		gpiod_set_value_cansleep(usb333x->reset, 0);
+		usleep_range(1000, 2000);
+	}
+
+	ret = usb333x_setup_control(usb333x);
+	if (ret)
+		return ret;
+
+	ret = usb333x_setup_hs_compensation(usb333x);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int usb333x_power_off(struct phy *phy)
+{
+	struct usb333x *usb333x = phy_get_drvdata(phy);
+
+	if (usb333x->reset)
+		gpiod_set_value_cansleep(usb333x->reset, 1);
+
+	if (usb333x->refclk)
+		clk_disable_unprepare(usb333x->refclk);
+
+	return 0;
+}
+
+static int usb333x_set_mode(struct phy *phy, enum phy_mode mode)
+{
+	struct usb333x *usb333x = phy_get_drvdata(phy);
+	u8 val;
+	int ret;
+
+	/* Note that this PHY does not drive VBUS on its own. */
+
+	switch (mode) {
+	case PHY_MODE_USB_HOST:
+		if (usb333x->auto_resume) {
+			ret = ulpi_read(usb333x->ulpi, ULPI_OTG_CTRL);
+			if (ret < 0)
+				return ret;
+
+			val = (u8)ret;
+			val |= ULPI_IFC_CTRL_AUTORESUME;
+
+			ret = ulpi_write(usb333x->ulpi, ULPI_OTG_CTRL, val);
+			if (ret)
+				return ret;
+		}
+
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct phy_ops phy_ops = {
+	.power_on = usb333x_power_on,
+	.power_off = usb333x_power_off,
+	.set_mode = usb333x_set_mode,
+	.owner = THIS_MODULE,
+};
+
+static int usb333x_probe(struct ulpi *ulpi)
+{
+	struct usb333x *usb333x;
+	struct phy_provider *provider;
+	bool needs_reset, needs_clocks;
+	int ret;
+
+	usb333x = devm_kzalloc(&ulpi->dev, sizeof(*usb333x), GFP_KERNEL);
+	if (!usb333x)
+		return -ENOMEM;
+
+	needs_reset = of_property_read_bool(ulpi->dev.of_node, "reset-gpios");
+
+	if (needs_reset) {
+		/* Hold the PHY in reset at this point. */
+		usb333x->reset = devm_gpiod_get_optional(&ulpi->dev, "reset",
+							 GPIOD_OUT_HIGH);
+		if (IS_ERR(usb333x->reset))
+			return PTR_ERR(usb333x->reset);
+	}
+
+	needs_clocks = of_property_read_bool(ulpi->dev.of_node, "clocks");
+
+	if (needs_clocks) {
+		usb333x->refclk = devm_clk_get(&ulpi->dev, "refclk");
+		if (IS_ERR(usb333x->refclk))
+			return PTR_ERR(usb333x->refclk);
+	}
+
+	usb333x->extvbus_passthru = of_property_read_bool(ulpi->dev.of_node,
+							  "extvbus-passthru");
+	usb333x->auto_resume = of_property_read_bool(ulpi->dev.of_node,
+						     "auto-resume");
+	usb333x->chrg_vbus = of_property_read_bool(ulpi->dev.of_node,
+						   "chrg-vbus");
+	usb333x->dischrg_vbus = of_property_read_bool(ulpi->dev.of_node,
+						      "dischrg-vbus");
+	usb333x->id_pull_up = of_property_read_bool(ulpi->dev.of_node,
+						    "id-pull-up");
+
+	ret = of_property_read_u32(ulpi->dev.of_node, "smsc,varisense",
+				   &usb333x->varisense);
+	if (ret)
+		usb333x->varisense = 0; /* Nominal */
+
+	ret = of_property_read_u32(ulpi->dev.of_node, "smsc,phyboost",
+				   &usb333x->phyboost);
+	if (ret)
+		usb333x->phyboost = 0; /* Nominal */
+
+	usb333x->phy = ulpi_phy_create(ulpi, &phy_ops);
+	if (IS_ERR(usb333x->phy))
+		return PTR_ERR(usb333x->phy);
+
+	usb333x->ulpi = ulpi;
+
+	phy_set_drvdata(usb333x->phy, usb333x);
+	ulpi_set_drvdata(ulpi, usb333x);
+
+	provider = devm_of_phy_provider_register(&ulpi->dev,
+						 of_phy_simple_xlate);
+	if (IS_ERR(provider)) {
+		ret = PTR_ERR(provider);
+		goto err_ulpi_phy;
+	}
+
+	return 0;
+
+err_ulpi_phy:
+	ulpi_phy_destroy(ulpi, usb333x->phy);
+
+	return ret;
+}
+
+static void usb333x_remove(struct ulpi *ulpi)
+{
+	struct usb333x *usb333x = ulpi_get_drvdata(ulpi);
+
+	ulpi_phy_destroy(ulpi, usb333x->phy);
+}
+
+#define SMSC_VENDOR_ID 0x0424
+
+static const struct ulpi_device_id usb333x_ulpi_id[] = {
+	{ SMSC_VENDOR_ID, 0x000c, },  /* USB3331 */
+	{ },
+};
+MODULE_DEVICE_TABLE(ulpi, usb333x_ulpi_id);
+
+static const struct of_device_id usb333x_of_match[] = {
+	{ .compatible = "smsc,usb333x", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, usb333x_of_match);
+
+static struct ulpi_driver usb333x_driver = {
+	.id_table = usb333x_ulpi_id,
+	.probe = usb333x_probe,
+	.remove = usb333x_remove,
+	.driver = {
+		.name = "usb333x",
+		.of_match_table = usb333x_of_match,
+	},
+};
+
+module_ulpi_driver(usb333x_driver);
+
+MODULE_AUTHOR("Paul Kocialkowski <paul.kocialkowski@bootlin.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("USB333x ULPI PHY driver");
-- 
2.20.1

