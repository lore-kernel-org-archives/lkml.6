Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621F6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1248F2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e33jDqjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1248F2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbeH3XGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:06:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37600 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeH3XFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:05:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so9003064wrr.4;
        Thu, 30 Aug 2018 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GPqWwkBc6SB1eOqyKrvhdVyUaIv1/LBWgMacY2beA4k=;
        b=e33jDqjBqltsU4Qoc+sIfGuHVCcABdY8ZzsqBVo0ibrabbz37R2KbdfbVs6EkQJxcf
         BilT0djIxAVsV3UDxyDCH+utaGetfODCTY+qQghW43uRBjQSzyoGBXplg16gDjbQL3sB
         7KmmMcykRcJXIW5+7hSmZYQpzoG3JNBkt0iWscpuKzhnCP9Ur9e2+upntCbrvBPP/d8J
         NHdfpdtwJEuzam0M3HhcVLmdwa4nL5MMskzPDPnkSjJT6eQhtPbDSFRm5Oc2t64TR23c
         eWLfSfKrScQe/SnMuSVgRdFgp/W9972F5b3D3Wvxpp62H8DB9V8Yh5thlqXx5NHkIlIs
         60fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GPqWwkBc6SB1eOqyKrvhdVyUaIv1/LBWgMacY2beA4k=;
        b=TrS4mGJr+3TZhPkoBFCE63mFJycArsJ47kImo7fwdnWBocTbksQxen/1rFGOwkTFeg
         yL+7Ie8fl2eH/WN2KDhI1pjilEV4oeuzwwXZjd2A2fj4jWi4ODxiq8Gsu6GSfd5jDFIs
         /+WfKqSDNJrSubi3Wc5huB+yUrxgxGMGtTNNmXr7zJm+xDKhxA6bFSmI2bZoeWZN1M+k
         5jqT6oGr6gmYkso0mZMTQ4fKjtkPFOi+qPXJ/qGzPN7/yJbMQuCPkx9175UiWg6oOWAB
         W5Hb06o6F8GTZYbCQ0cNStIgrKxHywnKstxSDIjB1ZX5JWK0DN1DHXKPibQWr9bKl3MV
         iDPA==
X-Gm-Message-State: APzg51BFHKlg7qcPmNVoZjChL4AVUkLJ+JAuPDjfNJVZd8zP2sVXkoGc
        LNX+YwpgK7OQG2hXiEhr0m0=
X-Google-Smtp-Source: ANB0VdYT4x2g3AeQRnQmTGXZDf/QiZ5rwEPb0SVHiGbNM2J85VDF3a7lWls4/EV8GeX2mtPm2aZHtg==
X-Received: by 2002:a5d:6aca:: with SMTP id u10-v6mr8746074wrw.44.1535655695118;
        Thu, 30 Aug 2018 12:01:35 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w17-v6sm2937095wmc.43.2018.08.30.12.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:01:34 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, clabbe.montjoie@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 04/13] phy: Add sun4i-a10-phy-sata driver
Date:   Thu, 30 Aug 2018 21:01:11 +0200
Message-Id: <20180830190120.722-5-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch create a PHY SATA driver for allwinner SoC A10/A20/R40.
The code is taken from drivers/ata/ahci_sunxi.c but cannot be removed
from it yet, since we need to finish the transition to new binding with
the PHY usage.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/phy/allwinner/Kconfig          |   7 ++
 drivers/phy/allwinner/Makefile         |   1 +
 drivers/phy/allwinner/phy-sun4i-sata.c | 208 +++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 drivers/phy/allwinner/phy-sun4i-sata.c

diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
index cdc1e745ba47..ef6fa389389a 100644
--- a/drivers/phy/allwinner/Kconfig
+++ b/drivers/phy/allwinner/Kconfig
@@ -1,6 +1,13 @@
 #
 # Phy drivers for Allwinner platforms
 #
+config PHY_SUN4I_SATA
+	tristate "Allwinner sunxi SoC SATA PHY driver"
+	depends on ARCH_SUNXI && HAS_IOMEM && OF
+	select GENERIC_PHY
+	help
+	  Enable this to support the SATA PHY present on A10/A20/R40.
+
 config PHY_SUN4I_USB
 	tristate "Allwinner sunxi SoC USB PHY driver"
 	depends on ARCH_SUNXI && HAS_IOMEM && OF
diff --git a/drivers/phy/allwinner/Makefile b/drivers/phy/allwinner/Makefile
index 8605529c01a1..73ef882edb53 100644
--- a/drivers/phy/allwinner/Makefile
+++ b/drivers/phy/allwinner/Makefile
@@ -1,2 +1,3 @@
+obj-$(CONFIG_PHY_SUN4I_SATA)		+= phy-sun4i-sata.o
 obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
 obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
diff --git a/drivers/phy/allwinner/phy-sun4i-sata.c b/drivers/phy/allwinner/phy-sun4i-sata.c
new file mode 100644
index 000000000000..93e29f99d26c
--- /dev/null
+++ b/drivers/phy/allwinner/phy-sun4i-sata.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Allwinner sun4i SATA phy driver
+ * Copyright (C) 2018 Corentin Labbe <clabbe.montjoie@gmail.com>
+ *
+ * PHY init code taken from drivers/ahci/ahci_sunxi.c
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+#define AHCI_PHYCS0R	0x0000
+#define AHCI_PHYCS1R	0x0004
+#define AHCI_PHYCS2R	0x0008
+#define AHCI_TIMER1MS	0x0020
+#define AHCI_GPARAM1R	0x0028
+#define AHCI_GPARAM2R	0x002c
+#define AHCI_PPARAMR	0x0030
+#define AHCI_TESTR	0x0034
+#define AHCI_VERSIONR	0x0038
+#define AHCI_IDR	0x003c
+#define AHCI_RWCR	0x003c
+#define AHCI_P0DMACR	0x00b0
+#define AHCI_P0PHYCR	0x00b8
+#define AHCI_P0PHYSR	0x00bc
+
+struct sun4i_sata_phy_data {
+	struct phy *phy;
+	struct device *dev;
+	void __iomem            *base;
+};
+
+static void sunxi_clrbits(void __iomem *reg, u32 clr_val)
+{
+	u32 reg_val;
+
+	reg_val = readl(reg);
+	reg_val &= ~(clr_val);
+	writel(reg_val, reg);
+}
+
+static void sunxi_setbits(void __iomem *reg, u32 set_val)
+{
+	u32 reg_val;
+
+	reg_val = readl(reg);
+	reg_val |= set_val;
+	writel(reg_val, reg);
+}
+
+static void sunxi_clrsetbits(void __iomem *reg, u32 clr_val, u32 set_val)
+{
+	u32 reg_val;
+
+	reg_val = readl(reg);
+	reg_val &= ~(clr_val);
+	reg_val |= set_val;
+	writel(reg_val, reg);
+}
+
+static u32 sunxi_getbits(void __iomem *reg, u8 mask, u8 shift)
+{
+	return (readl(reg) >> shift) & mask;
+}
+
+static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
+{
+	u32 reg_val;
+	int timeout;
+
+	/* This magic is from the original code */
+	writel(0, reg_base + AHCI_RWCR);
+	msleep(5);
+
+	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(19));
+	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R, (0x7 << 24),
+			 (0x5 << 24) | BIT(23) | BIT(18));
+	sunxi_clrsetbits(reg_base + AHCI_PHYCS1R,
+			 (0x3 << 16) | (0x1f << 8) | (0x3 << 6),
+			 (0x2 << 16) | (0x6 << 8) | (0x2 << 6));
+	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(28) | BIT(15));
+	sunxi_clrbits(reg_base + AHCI_PHYCS1R, BIT(19));
+	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R, (0x7 << 20), (0x3 << 20));
+	sunxi_clrsetbits(reg_base + AHCI_PHYCS2R, (0x1f << 5), (0x19 << 5));
+	msleep(5);
+
+	sunxi_setbits(reg_base + AHCI_PHYCS0R, (0x1 << 19));
+
+	timeout = 250; /* Power up takes aprox 50 us */
+	do {
+		reg_val = sunxi_getbits(reg_base + AHCI_PHYCS0R, 0x7, 28);
+		if (reg_val == 0x02)
+			break;
+
+		if (--timeout == 0) {
+			dev_err(dev, "PHY power up failed.\n");
+			return -EIO;
+		}
+		udelay(1);
+	} while (1);
+
+	sunxi_setbits(reg_base + AHCI_PHYCS2R, (0x1 << 24));
+
+	timeout = 100; /* Calibration takes aprox 10 us */
+	do {
+		reg_val = sunxi_getbits(reg_base + AHCI_PHYCS2R, 0x1, 24);
+		if (reg_val == 0x00)
+			break;
+
+		if (--timeout == 0) {
+			dev_err(dev, "PHY calibration failed.\n");
+			return -EIO;
+		}
+		udelay(1);
+	} while (1);
+
+	msleep(15);
+
+	writel(0x7, reg_base + AHCI_RWCR);
+
+	return 0;
+}
+
+static int sun4i_sata_phy_power_on(struct phy *_phy)
+{
+	struct sun4i_sata_phy_data *data = phy_get_drvdata(_phy);
+
+	dev_info(data->dev, "%s\n", __func__);
+	return ahci_sunxi_phy_init(data->dev, data->base);
+}
+
+static const struct phy_ops sun4i_sata_phy_ops = {
+	.power_on	= sun4i_sata_phy_power_on,
+	.owner		= THIS_MODULE,
+};
+
+static int sun4i_sata_phy_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int sun4i_sata_phy_probe(struct platform_device *pdev)
+{
+	struct sun4i_sata_phy_data *data;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, data);
+	data->dev = dev;
+
+	data->base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!data->base)
+		return -ENOMEM;
+
+	data->phy = devm_phy_create(dev, NULL, &sun4i_sata_phy_ops);
+	if (IS_ERR(data->phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(data->phy);
+	}
+		phy_set_drvdata(data->phy, data);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	dev_info(dev, "successfully loaded\n");
+
+	return 0;
+}
+
+static const struct of_device_id sun4i_sata_phy_of_match[] = {
+	{ .compatible = "allwinner,sun4i-a10-sata-phy", },
+	{ .compatible = "allwinner,sun8i-r40-sata-phy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sun4i_sata_phy_of_match);
+
+static struct platform_driver sun4i_sata_phy_driver = {
+	.probe	= sun4i_sata_phy_probe,
+	.remove	= sun4i_sata_phy_remove,
+	.driver = {
+		.of_match_table	= sun4i_sata_phy_of_match,
+		.name  = "sun4i-a10-sata-phy",
+	}
+};
+module_platform_driver(sun4i_sata_phy_driver);
+
+MODULE_DESCRIPTION("sun4i SATA PHY driver");
+MODULE_AUTHOR("Corentin LABBE <clabbe.montjoie@gmail.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.16.4

