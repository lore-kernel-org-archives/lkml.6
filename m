Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28558C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031B52082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031B52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeKCEca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:32:30 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57302 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeKCEc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:32:29 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA2JNse0011817;
        Fri, 2 Nov 2018 14:23:54 -0500
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA2JNsLp045151
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 14:23:54 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 2 Nov
 2018 14:23:53 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 2 Nov 2018 14:23:53 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA2JNfvX000522;
        Fri, 2 Nov 2018 14:23:51 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 3/6] phy: phy-of-simple: Add support for simple generic phy driver
Date:   Sat, 3 Nov 2018 00:56:13 +0530
Message-ID: <20181102192616.28291-4-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181102192616.28291-1-faiz_abbas@ti.com>
References: <20181102192616.28291-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A good number of phy implementations don't have a dedicated register
map and only do simple clock or regulator configurations. Add support
for a generic driver which just does such simple configurations.

The driver optionally gets all the generic phy attributes and also the
pwr regulator node. It also includes a generic implementation of
phy_power_on() and phy_power_off().

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/phy/Kconfig         |  7 +++
 drivers/phy/Makefile        |  1 +
 drivers/phy/phy-of-simple.c | 90 +++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 drivers/phy/phy-of-simple.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 60f949e2a684..e66039560da9 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -40,6 +40,13 @@ config PHY_XGENE
 	help
 	  This option enables support for APM X-Gene SoC multi-purpose PHY.
 
+config PHY_OF_SIMPLE
+	tristate "PHY Simple Driver"
+	select GENERIC_PHY
+	help
+	  This driver supports simple generic phy implementations which don't
+	  need a dedicated register map.
+
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 0301e25d07c1..ffef0fdf2c68 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
+obj-$(CONFIG_PHY_OF_SIMPLE)		+= phy-of-simple.o
 obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
 obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
 obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
diff --git a/drivers/phy/phy-of-simple.c b/drivers/phy/phy-of-simple.c
new file mode 100644
index 000000000000..0194aae90d3c
--- /dev/null
+++ b/drivers/phy/phy-of-simple.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * phy-of-simple.c - phy driver for simple implementations
+ *
+ * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
+ *
+ */
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+static int phy_simple_power_on(struct phy *phy)
+{
+	if (phy->pwr)
+		return regulator_enable(phy->pwr);
+
+	return 0;
+}
+
+static int phy_simple_power_off(struct phy *phy)
+{
+	if (phy->pwr)
+		return regulator_disable(phy->pwr);
+
+	return 0;
+}
+
+static const struct phy_ops phy_simple_ops = {
+	.power_on	= phy_simple_power_on,
+	.power_off	= phy_simple_power_off,
+	.owner		= THIS_MODULE,
+};
+
+int phy_simple_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct regulator *pwr = NULL;
+	struct phy *phy;
+	u32 bus_width = 0;
+	u32 max_bitrate = 0;
+	int ret;
+
+	phy = devm_phy_create(dev, dev->of_node,
+				      &phy_simple_ops);
+
+	if (IS_ERR(phy)) {
+		dev_err(dev, "Failed to create phy\n");
+		return PTR_ERR(phy);
+	}
+
+	device_property_read_u32(dev, "bus-width", &bus_width);
+	phy->attrs.bus_width = bus_width;
+	device_property_read_u32(dev, "max-bitrate", &max_bitrate);
+	phy->attrs.max_bitrate = max_bitrate;
+
+	pwr = devm_regulator_get_optional(dev, "pwr");
+	if (IS_ERR(pwr)) {
+		ret = PTR_ERR(pwr);
+		dev_err(dev, "Couldn't get regulator. ret=%d\n", ret);
+		return ret;
+	}
+	phy->pwr = pwr;
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id phy_simple_dt_ids[] = {
+	{ .compatible = "simple-phy"},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, phy_simple_phy_dt_ids);
+
+static struct platform_driver phy_simple_driver = {
+	.probe		= phy_simple_probe,
+	.driver		= {
+		.name	= "phy-of-simple",
+		.of_match_table = phy_simple_dt_ids,
+	},
+};
+
+module_platform_driver(phy_simple_driver);
+
+MODULE_AUTHOR("Faiz Abbas <faiz_abbas@ti.com>");
+MODULE_DESCRIPTION("Simple PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

