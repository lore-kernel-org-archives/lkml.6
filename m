Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48FAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D49217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="D71msU0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfBFPRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:17:15 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41975 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfBFPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:17:13 -0500
Received: by mail-yb1-f193.google.com with SMTP id n6so2600488ybg.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D1a9vNU3FLTNGaR8m4KDzoPIshHyTe9vaf3CcnofEBE=;
        b=D71msU0zsJcgPACBplD7hWRjZjo/83Ecqs9ae31DrVGICeMtePtw7ICn5mnbRMMENH
         3n4A4ObUWWcZhrQgXv7WWukkVIh4wa2gMhFVfMGtUV5zfamMU1vpyJU2r/faNtB9J15u
         09QBelSf7+x8eZC+iTzbCtFtvdV2VFcvvFV8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D1a9vNU3FLTNGaR8m4KDzoPIshHyTe9vaf3CcnofEBE=;
        b=nrzTawB6t0xmF/GmtEh67zS6um6o22KD46euExDznRs3HvgyWZ85HIbEfOMKQiAW64
         6uv4afIwO93/Bw/DBfNWPVluB4mfl+yGnXCssQXu7v6npxrD6EvzKXXTPb8YPUe8AVCk
         k5cp9xGbLTHePgwEe0GiKyFFBRIFDT0DM3BLWWA7jX+GLacN8ZZMNSoKEO3iffx+AflR
         mGmAjPtht5dXZd18EHYRRy4bpffdAFjfWE4SBIIbZztrPLpveQQ8H31ZtXav/2xBSbb9
         FP66qptG6vvg6CWmqMDqhIXK95xfPGviycd/BioH+gLmhs7LCQL0qTQ7G6GyNcnS6oz4
         h0gQ==
X-Gm-Message-State: AHQUAuYVNqgYnnUaioc5xtepy5Qk8hgBz6yr74ebtVokZ1plswAWMVYt
        HkvmWGtTXK7ifSOTGOGLD5hi9w==
X-Google-Smtp-Source: AHgI3IbsVIf6zJcmK1ggwvuZiKT/WNCJbEMZHFoGImppNQx+ROpJjcVQU/BomAiXnK+TrEGpEwpK8A==
X-Received: by 2002:a5b:38c:: with SMTP id k12mr2465373ybp.478.1549466232629;
        Wed, 06 Feb 2019 07:17:12 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r124sm557617ywb.39.2019.02.06.07.17.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 07:17:11 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        "Jayachandran C --cc=devicetree @ vger . kernel . org" 
        <jnair@caviumnetworks.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 2/3] phy: sr-usb: Add Stingray USB PHY driver
Date:   Wed,  6 Feb 2019 20:46:46 +0530
Message-Id: <1549466207-3190-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549466207-3190-1-git-send-email-srinath.mannam@broadcom.com>
References: <1549466207-3190-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB PHY driver supports all versions of stingray SS and HS USB PHYs.
 - Version 1 is a combo PHY contains both SS and HS PHYs.
 - Version 2 is a single HS PHY.

These PHYs support both Generic xHCI host controller driver and BDC
Broadcom device controller driver.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/phy/broadcom/Kconfig          |  11 +
 drivers/phy/broadcom/Makefile         |   1 +
 drivers/phy/broadcom/phy-bcm-sr-usb.c | 371 ++++++++++++++++++++++++++++++++++
 3 files changed, 383 insertions(+)
 create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c

diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
index aa917a6..f30f481 100644
--- a/drivers/phy/broadcom/Kconfig
+++ b/drivers/phy/broadcom/Kconfig
@@ -10,6 +10,17 @@ config PHY_CYGNUS_PCIE
 	  Enable this to support the Broadcom Cygnus PCIe PHY.
 	  If unsure, say N.
 
+config PHY_BCM_SR_USB
+	tristate "Broadcom Stingray USB PHY driver"
+	depends on OF && (ARCH_BCM_IPROC || COMPILE_TEST)
+	select GENERIC_PHY
+	default ARCH_BCM_IPROC
+	help
+	  Enable this to support the Broadcom Stingray USB PHY
+	  driver. It supports all versions of Superspeed and
+	  Highspeed PHYs.
+	  If unsure, say N.
+
 config BCM_KONA_USB2_PHY
 	tristate "Broadcom Kona USB2 PHY Driver"
 	depends on HAS_IOMEM
diff --git a/drivers/phy/broadcom/Makefile b/drivers/phy/broadcom/Makefile
index 0f60184..f453c7d 100644
--- a/drivers/phy/broadcom/Makefile
+++ b/drivers/phy/broadcom/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_PHY_BRCM_USB)		+= phy-brcm-usb-dvr.o
 phy-brcm-usb-dvr-objs := phy-brcm-usb.o phy-brcm-usb-init.o
 
 obj-$(CONFIG_PHY_BCM_SR_PCIE)		+= phy-bcm-sr-pcie.o
+obj-$(CONFIG_PHY_BCM_SR_USB)		+= phy-bcm-sr-usb.o
diff --git a/drivers/phy/broadcom/phy-bcm-sr-usb.c b/drivers/phy/broadcom/phy-bcm-sr-usb.c
new file mode 100644
index 0000000..abf801d
--- /dev/null
+++ b/drivers/phy/broadcom/phy-bcm-sr-usb.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016-2018 Broadcom
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+enum bcm_usb_phy_version {
+	BCM_USB_PHY_V1,
+	BCM_USB_PHY_V2,
+};
+
+enum bcm_usb_phy_reg {
+	PLL_NDIV_FRAC,
+	PLL_NDIV_INT,
+	PLL_CTRL,
+	PHY_CTRL,
+	PHY_PLL_CTRL,
+};
+
+/* USB PHY registers */
+
+static const u8 bcm_usb_u3phy_v1[] = {
+	[PLL_CTRL]		= 0x18,
+	[PHY_CTRL]		= 0x14,
+};
+
+static const u8 bcm_usb_u2phy_v1[] = {
+	[PLL_NDIV_FRAC]	= 0x04,
+	[PLL_NDIV_INT]	= 0x08,
+	[PLL_CTRL]	= 0x0c,
+	[PHY_CTRL]	= 0x10,
+};
+
+#define HSPLL_NDIV_INT_VAL	0x13
+#define HSPLL_NDIV_FRAC_VAL	0x1005
+
+static const u8 bcm_usb_u2phy_v2[] = {
+	[PLL_NDIV_FRAC]	= 0x0,
+	[PLL_NDIV_INT]	= 0x4,
+	[PLL_CTRL]	= 0x8,
+	[PHY_CTRL]	= 0xc,
+};
+
+enum pll_ctrl_bits {
+	PLL_RESETB,
+	SSPLL_SUSPEND_EN,
+	PLL_SEQ_START,
+	PLL_LOCK,
+	PLL_PDIV,
+};
+
+static const u8 u3pll_ctrl[] = {
+	[PLL_RESETB]		= 0,
+	[SSPLL_SUSPEND_EN]	= 1,
+	[PLL_SEQ_START]		= 2,
+	[PLL_LOCK]		= 3,
+};
+
+#define HSPLL_PDIV_MASK		0xF
+#define HSPLL_PDIV_VAL		0x1
+
+static const u8 u2pll_ctrl[] = {
+	[PLL_PDIV]	= 1,
+	[PLL_RESETB]	= 5,
+	[PLL_LOCK]	= 6,
+};
+
+enum bcm_usb_phy_ctrl_bits {
+	CORERDY,
+	AFE_LDO_PWRDWNB,
+	AFE_PLL_PWRDWNB,
+	AFE_BG_PWRDWNB,
+	PHY_ISO,
+	PHY_RESETB,
+	PHY_PCTL,
+};
+
+#define PHY_PCTL_MASK	0xffff
+/*
+ * 0x0806 of PCTL_VAL has below bits set
+ * BIT-8 : refclk divider 1
+ * BIT-3:2: device mode; mode is not effect
+ * BIT-1: soft reset active low
+ */
+#define HSPHY_PCTL_VAL	0x0806
+#define SSPHY_PCTL_VAL	0x0006
+
+static const u8 u3phy_ctrl[] = {
+	[PHY_RESETB]	= 1,
+	[PHY_PCTL]	= 2,
+};
+
+static const u8 u2phy_ctrl[] = {
+	[CORERDY]		= 0,
+	[AFE_LDO_PWRDWNB]	= 1,
+	[AFE_PLL_PWRDWNB]	= 2,
+	[AFE_BG_PWRDWNB]	= 3,
+	[PHY_ISO]		= 4,
+	[PHY_RESETB]		= 5,
+	[PHY_PCTL]		= 6,
+};
+
+struct bcm_usb_phy_cfg {
+	uint32_t type;
+	uint32_t ver;
+	void __iomem *regs;
+	struct phy *phy;
+	const u8 *offset;
+};
+
+#define PLL_LOCK_RETRY_COUNT	1000
+
+enum bcm_usb_phy_type {
+	USB_HS_PHY,
+	USB_SS_PHY,
+};
+
+static inline void bcm_usb_reg32_clrbits(void __iomem *addr, uint32_t clear)
+{
+	writel(readl(addr) & ~clear, addr);
+}
+
+static inline void bcm_usb_reg32_setbits(void __iomem *addr, uint32_t set)
+{
+	writel(readl(addr) | set, addr);
+}
+
+static int bcm_usb_pll_lock_check(void __iomem *addr, u32 bit)
+{
+	int retry;
+	u32 rd_data;
+
+	retry = PLL_LOCK_RETRY_COUNT;
+	do {
+		rd_data = readl(addr);
+		if (rd_data & bit)
+			return 0;
+		udelay(1);
+	} while (--retry > 0);
+
+	pr_err("%s: FAIL\n", __func__);
+	return -ETIMEDOUT;
+}
+
+static int bcm_usb_ss_phy_init(struct bcm_usb_phy_cfg *phy_cfg)
+{
+	int ret = 0;
+	void __iomem *regs = phy_cfg->regs;
+	const u8 *offset;
+	u32 rd_data;
+
+	offset = phy_cfg->offset;
+
+	/* Set pctl with mode and soft reset */
+	rd_data = readl(regs + offset[PHY_CTRL]);
+	rd_data &= ~(PHY_PCTL_MASK << u3phy_ctrl[PHY_PCTL]);
+	rd_data |= (SSPHY_PCTL_VAL << u3phy_ctrl[PHY_PCTL]);
+	writel(rd_data, regs + offset[PHY_CTRL]);
+
+	bcm_usb_reg32_clrbits(regs + offset[PLL_CTRL],
+			      BIT(u3pll_ctrl[SSPLL_SUSPEND_EN]));
+	bcm_usb_reg32_setbits(regs + offset[PLL_CTRL],
+			      BIT(u3pll_ctrl[PLL_SEQ_START]));
+	bcm_usb_reg32_setbits(regs + offset[PLL_CTRL],
+			      BIT(u3pll_ctrl[PLL_RESETB]));
+
+	/* Maximum timeout for PLL reset done */
+	msleep(30);
+
+	ret = bcm_usb_pll_lock_check(regs + offset[PLL_CTRL],
+				     BIT(u3pll_ctrl[PLL_LOCK]));
+
+	return ret;
+}
+
+static int bcm_usb_hs_phy_init(struct bcm_usb_phy_cfg *phy_cfg)
+{
+	int ret = 0;
+	void __iomem *regs = phy_cfg->regs;
+	const u8 *offset;
+	u32 rd_data;
+
+	offset = phy_cfg->offset;
+
+	writel(HSPLL_NDIV_INT_VAL, regs + offset[PLL_NDIV_INT]);
+	writel(HSPLL_NDIV_FRAC_VAL, regs + offset[PLL_NDIV_FRAC]);
+
+	rd_data = readl(regs + offset[PLL_CTRL]);
+	rd_data &= ~(HSPLL_PDIV_MASK << u2pll_ctrl[PLL_PDIV]);
+	rd_data |= (HSPLL_PDIV_VAL << u2pll_ctrl[PLL_PDIV]);
+	writel(rd_data, regs + offset[PLL_CTRL]);
+
+	/* Set Core Ready high */
+	bcm_usb_reg32_setbits(regs + offset[PHY_CTRL],
+			      BIT(u2phy_ctrl[CORERDY]));
+
+	/* Maximum timeout for Core Ready done */
+	msleep(30);
+
+	bcm_usb_reg32_setbits(regs + offset[PLL_CTRL],
+			      BIT(u2pll_ctrl[PLL_RESETB]));
+	bcm_usb_reg32_setbits(regs + offset[PHY_CTRL],
+			      BIT(u2phy_ctrl[PHY_RESETB]));
+
+
+	rd_data = readl(regs + offset[PHY_CTRL]);
+	rd_data &= ~(PHY_PCTL_MASK << u2phy_ctrl[PHY_PCTL]);
+	rd_data |= (HSPHY_PCTL_VAL << u2phy_ctrl[PHY_PCTL]);
+	writel(rd_data, regs + offset[PHY_CTRL]);
+
+	/* Maximum timeout for PLL reset done */
+	msleep(30);
+
+	ret = bcm_usb_pll_lock_check(regs + offset[PLL_CTRL],
+				     BIT(u2pll_ctrl[PLL_LOCK]));
+
+	return ret;
+}
+
+static int bcm_usb_phy_reset(struct phy *phy)
+{
+	struct bcm_usb_phy_cfg *phy_cfg = phy_get_drvdata(phy);
+	void __iomem *regs = phy_cfg->regs;
+	const u8 *offset;
+
+	offset = phy_cfg->offset;
+
+	if (phy_cfg->type == USB_HS_PHY) {
+		bcm_usb_reg32_clrbits(regs + offset[PHY_CTRL],
+				      BIT(u2phy_ctrl[CORERDY]));
+		bcm_usb_reg32_setbits(regs + offset[PHY_CTRL],
+				      BIT(u2phy_ctrl[CORERDY]));
+	}
+
+	return 0;
+}
+
+static int bcm_usb_phy_init(struct phy *phy)
+{
+	struct bcm_usb_phy_cfg *phy_cfg = phy_get_drvdata(phy);
+	int ret = -EINVAL;
+
+	if (phy_cfg->type == USB_SS_PHY)
+		ret = bcm_usb_ss_phy_init(phy_cfg);
+	else if (phy_cfg->type == USB_HS_PHY)
+		ret = bcm_usb_hs_phy_init(phy_cfg);
+
+	return ret;
+}
+
+static struct phy_ops sr_phy_ops = {
+	.init		= bcm_usb_phy_init,
+	.reset		= bcm_usb_phy_reset,
+	.owner		= THIS_MODULE,
+};
+
+static int bcm_usb_phy_create(struct device *dev, struct device_node *node,
+			     void __iomem *regs, uint32_t version)
+{
+	struct bcm_usb_phy_cfg *phy_cfg;
+
+	phy_cfg = devm_kzalloc(dev, sizeof(struct bcm_usb_phy_cfg), GFP_KERNEL);
+	if (!phy_cfg)
+		return -ENOMEM;
+
+	phy_cfg->regs = regs;
+	phy_cfg->ver = version;
+
+	if (phy_cfg->ver == BCM_USB_PHY_V1) {
+		unsigned int id;
+
+		if (of_property_read_u32(node, "reg", &id)) {
+			dev_err(dev, "missing reg property in node %s\n",
+				node->name);
+			return -EINVAL;
+		}
+
+		if (id == 0) {
+			phy_cfg->offset = bcm_usb_u2phy_v1;
+			phy_cfg->type = USB_HS_PHY;
+		} else if (id == 1) {
+			phy_cfg->offset = bcm_usb_u3phy_v1;
+			phy_cfg->type = USB_SS_PHY;
+		} else {
+			return -ENODEV;
+		}
+	} else if (phy_cfg->ver == BCM_USB_PHY_V2) {
+		phy_cfg->offset = bcm_usb_u2phy_v2;
+		phy_cfg->type = USB_HS_PHY;
+	}
+
+	phy_cfg->phy = devm_phy_create(dev, node, &sr_phy_ops);
+	if (IS_ERR(phy_cfg->phy))
+		return PTR_ERR(phy_cfg->phy);
+
+	phy_set_drvdata(phy_cfg->phy, phy_cfg);
+
+	return 0;
+}
+
+static const struct of_device_id bcm_usb_phy_of_match[] = {
+	{
+		.compatible = "brcm,sr-usb-phy",
+		.data = (void *)BCM_USB_PHY_V1,
+	},
+	{
+		.compatible = "brcm,sr-usb-phy-v2",
+		.data = (void *)BCM_USB_PHY_V2,
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, bcm_usb_phy_of_match);
+
+static int bcm_usb_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *dn = dev->of_node, *child;
+	const struct of_device_id *of_id;
+	struct resource *res;
+	void __iomem *regs;
+	int ret;
+	enum bcm_usb_phy_version version;
+	struct phy_provider *phy_provider;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	of_id = of_match_node(bcm_usb_phy_of_match, dn);
+	if (of_id)
+		version = (enum bcm_usb_phy_version)of_id->data;
+	else
+		return -ENODEV;
+
+	if (of_get_child_count(dn) == 0) {
+		ret = bcm_usb_phy_create(dev, dn, regs, version);
+		if (ret)
+			return ret;
+	} else {
+		for_each_available_child_of_node(dn, child) {
+			ret = bcm_usb_phy_create(dev, child, regs, version);
+			if (ret) {
+				of_node_put(child);
+				return ret;
+			}
+		}
+	}
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static struct platform_driver bcm_usb_phy_driver = {
+	.driver = {
+		.name = "phy-bcm-sr-usb",
+		.of_match_table = bcm_usb_phy_of_match,
+	},
+	.probe = bcm_usb_phy_probe,
+};
+module_platform_driver(bcm_usb_phy_driver);
+
+MODULE_AUTHOR("Broadcom");
+MODULE_DESCRIPTION("Broadcom stingray USB Phy driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

