Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22B8C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9BD20844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3QVl+RY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfA2Lf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:35:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38479 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfA2LfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:35:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so21615586wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 03:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VBrpJcJs752W++ic9rn3GaeRCbiL/4SmAU6bli7+VYk=;
        b=W3QVl+RYCf6dOsZsWrtHzzBIfeTbHxubg4r1eqqud9cuKvcNxKo/2XqVjCz0vx3HKC
         O66PDhKDpyYG9oa63RPNRupINT9f6gi7VDRoSA4RJ23/pNdlAkhJQBCSLB+9SNzunRSf
         1g2miB73Qw9GdPGzLUoElnTxJPdT1YpbeWwEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VBrpJcJs752W++ic9rn3GaeRCbiL/4SmAU6bli7+VYk=;
        b=EpRLv5FgrFiROKbJBfybM55NjmrzeQj9iZVhNTcZvM3kdN+nhOgMld35uFB49tVtXX
         TlqsBkoJiMNoLkCCG8cCUfo8GaeLr/Cfp819Ovr0YvCEUQBhR3ow3bL5WRLVGyVu/2uZ
         NH9rcBptPAtYNg3Mf1fpyGe7NO2i7vLb6JIBHoucgElz0If0F0yYMztv92yGi78l7xCj
         bWrtVIc7PSGE0OFnxAIbUUFLYNMm3lDOwaXAIpsS+fB2l0MNxhGIZDWCV42VaMQ194e/
         jiLjnTc4QHmUOUPotfj28rcwWrJfixN0jIWfNSbNbYNmM6Oc5gR6Xj8pxv8pEBl6g7cs
         ZhgA==
X-Gm-Message-State: AJcUukerzxd9FpE6bntyWYye/FZBDdkLke1oqLHpoMJtqFIxwp+amAfz
        Omv4YySX0fK+wKiiGR/jm5e5pA==
X-Google-Smtp-Source: ALg8bN5hWgbVM4nxHAu3jl35edxuRl9813cf11QPZPQ66bN9YwVXUk9mctVm9W83MFNPyOYzjmrmuw==
X-Received: by 2002:adf:afdc:: with SMTP id y28mr24857802wrd.275.1548761722001;
        Tue, 29 Jan 2019 03:35:22 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net. [81.47.145.233])
        by smtp.gmail.com with ESMTPSA id i192sm1960129wmg.7.2019.01.29.03.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Jan 2019 03:35:21 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, kishon@ti.com, jackp@codeaurora.org,
        andy.gross@linaro.org, swboyd@chromium.org
Cc:     shawn.guo@linaro.org, vkoul@kernel.org, bjorn.andersson@linaro.org,
        khasim.mohammed@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] phy: qualcomm: usb: Add Super-Speed PHY driver
Date:   Tue, 29 Jan 2019 12:35:15 +0100
Message-Id: <1548761715-4004-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver to control the Synopsys SS PHY 1.0.0 implemeneted in QCS404
Based on Sriharsha Allenki's <sallenki@codeaurora.org> original code.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/phy/qualcomm/Kconfig           |  11 ++
 drivers/phy/qualcomm/Makefile          |   1 +
 drivers/phy/qualcomm/phy-qcom-usb-ss.c | 347 +++++++++++++++++++++++++++++++++
 3 files changed, 359 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-ss.c

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index c7b5ee8..35a5a67 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -92,3 +92,14 @@ config PHY_QCOM_USB_HS_SNPS_28NM
 	  Enable this to support the Synopsys 28nm Femto USB PHY on Qualcomm
 	  chips. This driver supports the high-speed PHY which is usually
 	  paired with either the ChipIdea or Synopsys DWC3 USB IPs on MSM SOCs.
+
+config PHY_QCOM_USB_SS
+	tristate "Qualcomm USB SS PHY driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on EXTCON || !EXTCON # if EXTCON=m, this cannot be built-in
+	select GENERIC_PHY
+	help
+	  Enable this to support the Super-Speed USB transceiver on Qualcomm
+	  chips. This driver supports the PHY which uses the QSCRATCH-based
+	  register set for its control sequences, normally paired with newer
+	  DWC3-based Super-Speed controllers on Qualcomm SoCs.
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index dc238d9..7149261 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_PHY_QCOM_UFS_20NM)		+= phy-qcom-ufs-qmp-20nm.o
 obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
 obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
 obj-$(CONFIG_PHY_QCOM_USB_HS_SNPS_28NM)	+= phy-qcom-usb-hs-snsp-28nm.o
+obj-$(CONFIG_PHY_QCOM_USB_SS)		+= phy-qcom-usb-ss.o
diff --git a/drivers/phy/qualcomm/phy-qcom-usb-ss.c b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
new file mode 100644
index 0000000..e6ae96e
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012-2014,2017 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+#define PHY_CTRL0			0x6C
+#define PHY_CTRL1			0x70
+#define PHY_CTRL2			0x74
+#define PHY_CTRL4			0x7C
+
+/* PHY_CTRL bits */
+#define REF_PHY_EN			BIT(0)
+#define LANE0_PWR_ON			BIT(2)
+#define SWI_PCS_CLK_SEL			BIT(4)
+#define TST_PWR_DOWN			BIT(4)
+#define PHY_RESET			BIT(7)
+
+enum phy_vdd_ctrl { ENABLE, DISABLE, };
+enum phy_regulator { VDD, VDDA1P8, };
+
+struct ssphy_priv {
+	void __iomem *base;
+	struct device *dev;
+	struct reset_control *reset_com;
+	struct reset_control *reset_phy;
+	struct regulator *vbus;
+	struct regulator_bulk_data *regs;
+	int num_regs;
+	struct clk_bulk_data *clks;
+	int num_clks;
+	enum phy_mode mode;
+};
+
+static inline void qcom_ssphy_updatel(void __iomem *addr, u32 mask, u32 val)
+{
+	writel((readl(addr) & ~mask) | val, addr);
+}
+
+static inline int qcom_ssphy_vbus_enable(struct regulator *vbus)
+{
+	return !regulator_is_enabled(vbus) ? regulator_enable(vbus) : 0;
+}
+
+static inline int qcom_ssphy_vbus_disable(struct regulator *vbus)
+{
+	return regulator_is_enabled(vbus) ? regulator_disable(vbus) : 0;
+}
+
+static int qcom_ssphy_vdd_ctrl(struct ssphy_priv *priv, enum phy_vdd_ctrl ctrl)
+{
+	const int vdd_min = ctrl == ENABLE ? 1050000 : 0;
+	const int vdd_max = 1050000;
+	int ret;
+
+	ret = regulator_set_voltage(priv->regs[VDD].consumer, vdd_min, vdd_max);
+	if (ret)
+		dev_err(priv->dev, "Failed to set regulator vdd to %d\n",
+			vdd_min);
+
+	return ret;
+}
+
+static int qcom_ssphy_vbus_ctrl(struct regulator *vbus, enum phy_mode mode)
+{
+	if (!vbus)
+		return 0;
+
+	if (mode == PHY_MODE_INVALID)
+		return 0;
+
+	/* gadget attached */
+	if (mode == PHY_MODE_USB_HOST)
+		return qcom_ssphy_vbus_enable(vbus);
+
+	/* USB_DEVICE: gadget removed: enable detection */
+	return qcom_ssphy_vbus_disable(vbus);
+}
+
+static int qcom_ssphy_do_reset(struct ssphy_priv *priv)
+{
+	int ret;
+
+	if (!priv->reset_com) {
+		qcom_ssphy_updatel(priv->base + PHY_CTRL1, PHY_RESET,
+				   PHY_RESET);
+		usleep_range(10, 20);
+		qcom_ssphy_updatel(priv->base + PHY_CTRL1, PHY_RESET, 0);
+	} else {
+		ret = reset_control_assert(priv->reset_com);
+		if (ret) {
+			dev_err(priv->dev, "Failed to assert reset com\n");
+			return ret;
+		}
+
+		ret = reset_control_assert(priv->reset_phy);
+		if (ret) {
+			dev_err(priv->dev, "Failed to assert reset phy\n");
+			return ret;
+		}
+
+		usleep_range(10, 20);
+
+		ret = reset_control_deassert(priv->reset_com);
+		if (ret) {
+			dev_err(priv->dev, "Failed to deassert reset com\n");
+			return ret;
+		}
+
+		ret = reset_control_deassert(priv->reset_phy);
+		if (ret) {
+			dev_err(priv->dev, "Failed to deassert reset phy\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int qcom_ssphy_power_on(struct phy *phy)
+{
+	struct ssphy_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = qcom_ssphy_vdd_ctrl(priv, ENABLE);
+	if (ret)
+		return ret;
+
+	ret = regulator_bulk_enable(priv->num_regs, priv->regs);
+	if (ret)
+		goto err1;
+
+	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
+	if (ret)
+		goto err2;
+
+	ret = qcom_ssphy_vbus_ctrl(priv->vbus, priv->mode);
+	if (ret)
+		goto err3;
+
+	ret = qcom_ssphy_do_reset(priv);
+	if (ret)
+		goto err4;
+
+	writeb(SWI_PCS_CLK_SEL, priv->base + PHY_CTRL0);
+	qcom_ssphy_updatel(priv->base + PHY_CTRL4, LANE0_PWR_ON, LANE0_PWR_ON);
+	qcom_ssphy_updatel(priv->base + PHY_CTRL2, REF_PHY_EN, REF_PHY_EN);
+	qcom_ssphy_updatel(priv->base + PHY_CTRL4, TST_PWR_DOWN, 0);
+
+	return 0;
+err4:
+	if (priv->vbus && priv->mode != PHY_MODE_INVALID)
+		qcom_ssphy_vbus_disable(priv->vbus);
+err3:
+	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
+err2:
+	regulator_bulk_disable(priv->num_regs, priv->regs);
+err1:
+	qcom_ssphy_vdd_ctrl(priv, DISABLE);
+
+	return ret;
+}
+
+static int qcom_ssphy_power_off(struct phy *phy)
+{
+	struct ssphy_priv *priv = phy_get_drvdata(phy);
+
+	qcom_ssphy_updatel(priv->base + PHY_CTRL4, LANE0_PWR_ON, 0);
+	qcom_ssphy_updatel(priv->base + PHY_CTRL2, REF_PHY_EN, 0);
+	qcom_ssphy_updatel(priv->base + PHY_CTRL4, TST_PWR_DOWN, TST_PWR_DOWN);
+
+	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
+	regulator_bulk_disable(priv->num_regs, priv->regs);
+
+	if (priv->vbus && priv->mode != PHY_MODE_INVALID)
+		qcom_ssphy_vbus_disable(priv->vbus);
+
+	qcom_ssphy_vdd_ctrl(priv, DISABLE);
+
+	return 0;
+}
+
+static int qcom_ssphy_init_clock(struct ssphy_priv *priv)
+{
+	const char * const clk_id[] = { "ref", "phy", "pipe", };
+	int i;
+
+	priv->num_clks = ARRAY_SIZE(clk_id);
+	priv->clks = devm_kcalloc(priv->dev, priv->num_clks,
+				  sizeof(*priv->clks), GFP_KERNEL);
+	if (!priv->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->num_clks; i++)
+		priv->clks[i].id = clk_id[i];
+
+	return devm_clk_bulk_get(priv->dev, priv->num_clks, priv->clks);
+}
+
+static int qcom_ssphy_init_regulator(struct ssphy_priv *priv)
+{
+	const char * const reg_supplies[] = {
+		[VDD] = "vdd",
+		[VDDA1P8] = "vdda1p8",
+	};
+	int ret, i;
+
+	priv->num_regs = ARRAY_SIZE(reg_supplies);
+	priv->regs = devm_kcalloc(priv->dev, priv->num_regs,
+				  sizeof(*priv->regs), GFP_KERNEL);
+	if (!priv->regs)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->num_regs; i++)
+		priv->regs[i].supply = reg_supplies[i];
+
+	ret = devm_regulator_bulk_get(priv->dev, priv->num_regs, priv->regs);
+	if (ret)
+		return ret;
+
+	priv->vbus = devm_regulator_get_optional(priv->dev, "vbus");
+	if (IS_ERR(priv->vbus))
+		return PTR_ERR(priv->vbus);
+
+	return 0;
+}
+
+static int qcom_ssphy_init_reset(struct ssphy_priv *priv)
+{
+	priv->reset_com = devm_reset_control_get_optional(priv->dev, "com");
+	if (IS_ERR(priv->reset_com)) {
+		dev_err(priv->dev, "Failed to get reset control com\n");
+		return PTR_ERR(priv->reset_com);
+	}
+
+	if (priv->reset_com) {
+		/* if reset_com is present, reset_phy is no longer optional */
+		priv->reset_phy = devm_reset_control_get(priv->dev, "phy");
+		if (IS_ERR(priv->reset_phy)) {
+			dev_err(priv->dev, "Failed to get reset control phy\n");
+			return PTR_ERR(priv->reset_phy);
+		}
+	}
+
+	return 0;
+}
+
+static int qcom_ssphy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct ssphy_priv *priv = phy_get_drvdata(phy);
+
+	if (!priv->vbus)
+		return 0;
+
+	if (mode != PHY_MODE_USB_HOST && mode != PHY_MODE_USB_DEVICE)
+		return -EINVAL;
+
+	priv->mode = mode;
+
+	dev_dbg(priv->dev, "mode %d", mode);
+
+	return qcom_ssphy_vbus_ctrl(priv->vbus, priv->mode);
+}
+
+static const struct phy_ops qcom_ssphy_ops = {
+	.set_mode = qcom_ssphy_set_mode,
+	.power_off = qcom_ssphy_power_off,
+	.power_on = qcom_ssphy_power_on,
+	.owner = THIS_MODULE,
+};
+
+static int qcom_ssphy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct phy_provider *provider;
+	struct ssphy_priv *priv;
+	struct resource *res;
+	struct phy *phy;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(struct ssphy_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->mode = PHY_MODE_INVALID;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	ret = qcom_ssphy_init_clock(priv);
+	if (ret)
+		return ret;
+
+	ret = qcom_ssphy_init_reset(priv);
+	if (ret)
+		return ret;
+
+	ret = qcom_ssphy_init_regulator(priv);
+	if (ret)
+		return ret;
+
+	phy = devm_phy_create(dev, dev->of_node, &qcom_ssphy_ops);
+	if (IS_ERR(phy)) {
+		dev_err(dev, "Failed to create the SS phy\n");
+		return PTR_ERR(phy);
+	}
+
+	phy_set_drvdata(phy, priv);
+
+	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static const struct of_device_id qcom_ssphy_match[] = {
+	{ .compatible = "qcom,usb-ssphy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qcom_ssphy_match);
+
+static struct platform_driver qcom_ssphy_driver = {
+	.probe		= qcom_ssphy_probe,
+	.driver = {
+		.name	= "qcom_usb_ssphy",
+		.of_match_table = qcom_ssphy_match,
+	},
+};
+module_platform_driver(qcom_ssphy_driver);
+
+MODULE_DESCRIPTION("Qualcomm Super-Speed USB PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

