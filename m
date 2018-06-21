Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACACC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DC120652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dNR8Tknp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DC120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933209AbeFUASy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:18:54 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45864 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754443AbeFUASw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:18:52 -0400
Received: by mail-qk0-f195.google.com with SMTP id c198-v6so820109qkg.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 17:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C4Ku8wMKMvSuOhoKpx7tyM7BugeYydPAIsHj9Cvp/z4=;
        b=dNR8TknpvW5W3/a4aOtRDUGO4jevTZavU1sQwQ38pENMlN86Le302cWeIWXvNRWoxM
         ZyD0GO4NLsDo1HKh+WbGoVb4Eok3/iW3mBW/lHSrBDjuxa6IFE2VJ/YlBIwt24KfQhfS
         0SsDsuVHrdGL3Hy34/Z6cVgdxspnCJm4b/SBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C4Ku8wMKMvSuOhoKpx7tyM7BugeYydPAIsHj9Cvp/z4=;
        b=KzNtaaBwVpGquUkShCElD9Uh2ZlNGwAPjCqftJXwrOJ4RiC0PW6ezfEgqTC3i/3/+r
         W3NGz+HofzbSO4Mt4xZVw+tUD6MMbtczej978Li0xNHB8D6xnPWUIsolW0YVh0j0FyyE
         CDEDc8Q9XT2d0UdIaSY0aOAvn1N7bXzTXSvzp1pv/vcKbCnf1/PZ/BYF/xoVeWOTGnVp
         fE1jzJlTKwCFuzk7QiU/LG8+LVPYALSlEPSeawsNcnwJV/v/t0t2Id/YoJJWRP7bnlSy
         uvbn6e7gsspm2HxXp61+lrp5Gyqi8evVLL2hMhtsyb4/RkKpxvkKIrPjP1vHg2sMZuGr
         j5uQ==
X-Gm-Message-State: APt69E1+lBSRDhDY/QvE7+PqSviEwIthcZ/A7rVTm/FTds88UnTnKlkh
        bO3rXMyzXdwu3bFKBscnJ0E1cg==
X-Google-Smtp-Source: ADUXVKJvJJ1PE8B3w5JGpTgCvaevBB882WK7MGZQhoeD0xxQh+HgzzAAcBWytO0D+c+7NHg8xzmQ+w==
X-Received: by 2002:a37:16c3:: with SMTP id 64-v6mr403093qkw.381.1529540331240;
        Wed, 20 Jun 2018 17:18:51 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t13-v6sm2778156qkt.53.2018.06.20.17.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 17:18:50 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 2/2] phy: bcm-sr-pcie: Add Stingray PCIe PHY driver
Date:   Wed, 20 Jun 2018 17:18:36 -0700
Message-Id: <1529540316-21706-3-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1529540316-21706-1-git-send-email-ray.jui@broadcom.com>
References: <1529540316-21706-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Stingray PCIe PHY driver for both PAXB and PAXC root complex

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/phy/broadcom/Kconfig           |  10 ++
 drivers/phy/broadcom/Makefile          |   2 +
 drivers/phy/broadcom/phy-bcm-sr-pcie.c | 306 +++++++++++++++++++++++++++++++++
 3 files changed, 318 insertions(+)
 create mode 100644 drivers/phy/broadcom/phy-bcm-sr-pcie.c

diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
index 97d27b0d5..8786a96 100644
--- a/drivers/phy/broadcom/Kconfig
+++ b/drivers/phy/broadcom/Kconfig
@@ -80,3 +80,13 @@ config PHY_BRCM_USB
 	  This driver is required by the USB XHCI, EHCI and OHCI
 	  drivers.
 	  If unsure, say N.
+
+config PHY_BCM_SR_PCIE
+	tristate "Broadcom Stingray PCIe PHY driver"
+	depends on OF && (ARCH_BCM_IPROC || COMPILE_TEST)
+	select GENERIC_PHY
+	select MFD_SYSCON
+	default ARCH_BCM_IPROC
+	help
+	  Enable this to support the Broadcom Stingray PCIe PHY
+	  If unsure, say N.
diff --git a/drivers/phy/broadcom/Makefile b/drivers/phy/broadcom/Makefile
index 13e000c..0f60184 100644
--- a/drivers/phy/broadcom/Makefile
+++ b/drivers/phy/broadcom/Makefile
@@ -9,3 +9,5 @@ obj-$(CONFIG_PHY_BRCM_SATA)		+= phy-brcm-sata.o
 obj-$(CONFIG_PHY_BRCM_USB)		+= phy-brcm-usb-dvr.o
 
 phy-brcm-usb-dvr-objs := phy-brcm-usb.o phy-brcm-usb-init.o
+
+obj-$(CONFIG_PHY_BCM_SR_PCIE)		+= phy-bcm-sr-pcie.o
diff --git a/drivers/phy/broadcom/phy-bcm-sr-pcie.c b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
new file mode 100644
index 0000000..c4ee49d
--- /dev/null
+++ b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016-2018 Broadcom
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+/* we have up to 8 PAXB based RC. The 9th one is always PAXC */
+#define SR_NR_PCIE_PHYS               9
+#define SR_PAXC_PHY_IDX               (SR_NR_PCIE_PHYS - 1)
+
+#define CDRU_STRAP_DATA_LSW_OFFSET    0x5c
+#define PCIE_PIPEMUX_SHIFT            19
+#define PCIE_PIPEMUX_MASK             0xf
+
+#define MHB_MEM_PW_PAXC_OFFSET        0x1c0
+#define MHB_PWR_ARR_POWERON           0x8
+#define MHB_PWR_ARR_POWEROK           0x4
+#define MHB_PWR_POWERON               0x2
+#define MHB_PWR_POWEROK               0x1
+#define MHB_PWR_STATUS_MASK           (MHB_PWR_ARR_POWERON | \
+				       MHB_PWR_ARR_POWEROK | \
+				       MHB_PWR_POWERON | \
+				       MHB_PWR_POWEROK)
+
+struct sr_pcie_phy_core;
+
+/**
+ * struct sr_pcie_phy - Stingray PCIe PHY
+ *
+ * @core: pointer to the Stingray PCIe PHY core control
+ * @index: PHY index
+ * @phy: pointer to the kernel PHY device
+ */
+struct sr_pcie_phy {
+	struct sr_pcie_phy_core *core;
+	unsigned int index;
+	struct phy *phy;
+};
+
+/**
+ * struct sr_pcie_phy_core - Stingray PCIe PHY core control
+ *
+ * @dev: pointer to device
+ * @cdru: regmap to the CDRU device
+ * @mhb: regmap to the MHB device
+ * @pipemux: pipemuex strap
+ * @phys: array of PCIe PHYs
+ */
+struct sr_pcie_phy_core {
+	struct device *dev;
+	struct regmap *cdru;
+	struct regmap *mhb;
+	u32 pipemux;
+	struct sr_pcie_phy phys[SR_NR_PCIE_PHYS];
+};
+
+/*
+ * PCIe PIPEMUX lookup table
+ *
+ * Each array index represents a PIPEMUX strap setting
+ * The array element represents a bitmap where a set bit means the PCIe
+ * core and associated serdes has been enabled as RC and is available for use
+ */
+static const u8 pipemux_table[] = {
+	/* PIPEMUX = 0, EP 1x16 */
+	0x00,
+	/* PIPEMUX = 1, EP 2x8 */
+	0x00,
+	/* PIPEMUX = 2, EP 4x4 */
+	0x00,
+	/* PIPEMUX = 3, RC 2x8, cores 0, 7 */
+	0x81,
+	/* PIPEMUX = 4, RC 4x4, cores 0, 1, 6, 7 */
+	0xc3,
+	/* PIPEMUX = 5, RC 8x2, all 8 cores */
+	0xff,
+	/* PIPEMUX = 6, RC 3x4 + 2x2, cores 0, 2, 3, 6, 7 */
+	0xcd,
+	/* PIPEMUX = 7, RC 1x4 + 6x2, cores 0, 2, 3, 4, 5, 6, 7 */
+	0xfd,
+	/* PIPEMUX = 8, EP 1x8 + RC 4x2, cores 4, 5, 6, 7 */
+	0xf0,
+	/* PIPEMUX = 9, EP 1x8 + RC 2x4, cores 6, 7 */
+	0xc0,
+	/* PIPEMUX = 10, EP 2x4 + RC 2x4, cores 1, 6 */
+	0x42,
+	/* PIPEMUX = 11, EP 2x4 + RC 4x2, cores 2, 3, 4, 5 */
+	0x3c,
+	/* PIPEMUX = 12, EP 1x4 + RC 6x2, cores 2, 3, 4, 5, 6, 7 */
+	0xfc,
+	/* PIPEMUX = 13, RC 2x4 + RC 1x4 + 2x2, cores 2, 3, 6 */
+	0x4c,
+};
+
+/*
+ * Return true if the strap setting is valid
+ */
+static bool pipemux_strap_is_valid(u32 pipemux)
+{
+	return !!(pipemux < ARRAY_SIZE(pipemux_table));
+}
+
+/*
+ * Read the PCIe PIPEMUX from strap
+ */
+static u32 pipemux_strap_read(struct sr_pcie_phy_core *core)
+{
+	u32 pipemux;
+
+	regmap_read(core->cdru, CDRU_STRAP_DATA_LSW_OFFSET, &pipemux);
+	pipemux >>= PCIE_PIPEMUX_SHIFT;
+	pipemux &= PCIE_PIPEMUX_MASK;
+
+	return pipemux;
+}
+
+/*
+ * Given a PIPEMUX strap and PCIe core index, this function returns true if the
+ * PCIe core needs to be enabled
+ */
+static bool pcie_core_is_for_rc(struct sr_pcie_phy *phy)
+{
+	struct sr_pcie_phy_core *core = phy->core;
+	unsigned int core_idx = phy->index;
+
+	return !!((pipemux_table[core->pipemux] >> core_idx) & 0x1);
+}
+
+static int sr_pcie_phy_init(struct phy *p)
+{
+	struct sr_pcie_phy *phy = phy_get_drvdata(p);
+
+	/*
+	 * Check whether this PHY is for root complex or not. If yes, return
+	 * zero so the host driver can proceed to enumeration. If not, return
+	 * an error and that will force the host driver to bail out
+	 */
+	if (pcie_core_is_for_rc(phy))
+		return 0;
+	else
+		return -ENODEV;
+}
+
+static int sr_paxc_phy_init(struct phy *p)
+{
+	struct sr_pcie_phy *phy = phy_get_drvdata(p);
+	struct sr_pcie_phy_core *core = phy->core;
+	unsigned int core_idx = phy->index;
+	u32 val;
+
+	if (core_idx != SR_PAXC_PHY_IDX)
+		return -EINVAL;
+
+	regmap_read(core->mhb, MHB_MEM_PW_PAXC_OFFSET, &val);
+	if ((val & MHB_PWR_STATUS_MASK) != MHB_PWR_STATUS_MASK) {
+		dev_err(core->dev, "PAXC is not powered up\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int sr_pcie_phy_exit(struct phy *p)
+{
+	/* dummy function to allow host driver to proceed */
+	return 0;
+}
+
+static int sr_pcie_phy_power_on(struct phy *p)
+{
+	/* dummy function to allow host driver to proceed */
+	return 0;
+}
+
+static int sr_pcie_phy_power_off(struct phy *p)
+{
+	/* dummy function to allow host to proceed */
+	return 0;
+}
+
+static const struct phy_ops sr_pcie_phy_ops = {
+	.init = sr_pcie_phy_init,
+	.exit = sr_pcie_phy_exit,
+	.power_on = sr_pcie_phy_power_on,
+	.power_off = sr_pcie_phy_power_off,
+};
+
+static const struct phy_ops sr_paxc_phy_ops = {
+	.init = sr_paxc_phy_init,
+	.exit = sr_pcie_phy_exit,
+	.power_on = sr_pcie_phy_power_on,
+	.power_off = sr_pcie_phy_power_off,
+};
+
+static struct phy *sr_pcie_phy_xlate(struct device *dev,
+				     struct of_phandle_args *args)
+{
+	struct sr_pcie_phy_core *core;
+	int phy_idx;
+
+	core = dev_get_drvdata(dev);
+	if (!core)
+		return ERR_PTR(-EINVAL);
+
+	phy_idx = args->args[0];
+
+	if (WARN_ON(phy_idx >= SR_NR_PCIE_PHYS))
+		return ERR_PTR(-ENODEV);
+
+	return core->phys[phy_idx].phy;
+}
+
+static int sr_pcie_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct sr_pcie_phy_core *core;
+	struct phy_provider *provider;
+	unsigned int phy_idx = 0;
+
+	core = devm_kzalloc(dev, sizeof(*core), GFP_KERNEL);
+	if (!core)
+		return -ENOMEM;
+
+	core->dev = dev;
+
+	core->cdru = syscon_regmap_lookup_by_phandle(node, "brcm,sr-cdru");
+	if (IS_ERR(core->cdru)) {
+		dev_err(core->dev, "unable to find CDRU device\n");
+		return PTR_ERR(core->cdru);
+	}
+
+	core->mhb = syscon_regmap_lookup_by_phandle(node, "brcm,sr-mhb");
+	if (IS_ERR(core->mhb)) {
+		dev_err(core->dev, "unable to find MHB device\n");
+		return PTR_ERR(core->mhb);
+	}
+
+	/* read the PCIe PIPEMUX strap setting */
+	core->pipemux = pipemux_strap_read(core);
+	if (!pipemux_strap_is_valid(core->pipemux)) {
+		dev_err(core->dev, "invalid PCIe PIPEMUX strap %u\n",
+			core->pipemux);
+		return -EIO;
+	}
+
+	for (phy_idx = 0; phy_idx < SR_NR_PCIE_PHYS; phy_idx++) {
+		struct sr_pcie_phy *p = &core->phys[phy_idx];
+		const struct phy_ops *ops;
+
+		if (phy_idx == SR_PAXC_PHY_IDX)
+			ops = &sr_paxc_phy_ops;
+		else
+			ops = &sr_pcie_phy_ops;
+
+		p->phy = devm_phy_create(dev, NULL, ops);
+		if (IS_ERR(p->phy)) {
+			dev_err(dev, "failed to create PCIe PHY\n");
+			return PTR_ERR(p->phy);
+		}
+
+		p->core = core;
+		p->index = phy_idx;
+		phy_set_drvdata(p->phy, p);
+	}
+
+	dev_set_drvdata(dev, core);
+
+	provider = devm_of_phy_provider_register(dev, sr_pcie_phy_xlate);
+	if (IS_ERR(provider)) {
+		dev_err(dev, "failed to register PHY provider\n");
+		return PTR_ERR(provider);
+	}
+
+	dev_info(dev, "Stingray PCIe PHY driver initialized\n");
+
+	return 0;
+}
+
+static const struct of_device_id sr_pcie_phy_match_table[] = {
+	{ .compatible = "brcm,sr-pcie-phy" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sr_pcie_phy_match_table);
+
+static struct platform_driver sr_pcie_phy_driver = {
+	.driver = {
+		.name		= "sr-pcie-phy",
+		.of_match_table	= sr_pcie_phy_match_table,
+	},
+	.probe	= sr_pcie_phy_probe,
+};
+module_platform_driver(sr_pcie_phy_driver);
+
+MODULE_AUTHOR("Ray Jui <ray.jui@broadcom.com>");
+MODULE_DESCRIPTION("Broadcom Stingray PCIe PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4

