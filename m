Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E2FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9A62243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKHx/+36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9A62243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbeKLWya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:54:30 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41473 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbeKLWya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:54:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so4048780pgh.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 05:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BK+IMe6nxgHcV8eee4JLl27mV7vRLqO//qIiyk+adCg=;
        b=YKHx/+36VdiOYDURMo20NxwKMJWo9o/2tDfbLuFqMdfVxiffS69Gp2pdYapDaOMSVP
         fBCtelT+F+XQsVF64rCO5NY/00rCZX82UbHWixmBOsqljzAAcLS2JaLI1o6ssJ+CLDQd
         GMD47YocGeIVZU1Ugs1JdP/ILhg/U0XpgmTF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BK+IMe6nxgHcV8eee4JLl27mV7vRLqO//qIiyk+adCg=;
        b=TLvBc0zgrQMJ2aq+dxnXxSPZNzX8Ueydnxt4sf5iz5/O///mXKh5zs9ato2HEmD5bN
         fWuEgGbTVzyZiK9PxCx35kthj7zN2/GabQACxt3lQ3foTsq/rWZntgV9xjROc2LIUbR4
         mW/FisGvSfk9d+ltqZNb9WI8Blilu7WgCLPvfEVhI2fbGLLs5hzEUZ6ZRsrjoiLPhiaV
         Yoxr+BhEu/pBP1yYTYYEjbXKTSY6+h5nWsWxU+iEam5lYwSyNGiyJMDzkQVlcWA1WmBw
         7cBUM98Qt6r2QqI1FBMOiKer6OrG3kbc/3214d8YqgdV6Qm8+W4MQiVT3bZykqqRolfv
         Amgw==
X-Gm-Message-State: AGRZ1gL/HVkmS21X+tIZ284ydOw/kB4ao0Y8qfH++OY7MNOLPWvcP76V
        N+enInttAkmQE1pN6/TvgjRu0Q==
X-Google-Smtp-Source: AJdET5cdlERXbXmqZrsENU+7bAMXohnJ4WKaTCAwG8kAgeIukThs3S0N+ARdpN8hDBV6RZcPlyjeow==
X-Received: by 2002:a63:2109:: with SMTP id h9mr718540pgh.277.1542027678352;
        Mon, 12 Nov 2018 05:01:18 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id w2-v6sm20152023pfn.89.2018.11.12.05.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 05:01:17 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY driver
Date:   Mon, 12 Nov 2018 21:00:40 +0800
Message-Id: <20181112130040.18793-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181112130040.18793-1-shawn.guo@linaro.org>
References: <20181112130040.18793-1-shawn.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds Synopsys 28nm Femto High-Speed USB PHY driver support, which
is usually paired with Synopsys DWC3 USB controllers on Qualcomm SoCs.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/phy/qualcomm/Kconfig                  |  10 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 .../phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c  | 505 ++++++++++++++++++
 3 files changed, 516 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 32f7d34eb784..c7b5ee82895d 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -82,3 +82,13 @@ config PHY_QCOM_USB_HSIC
 	select GENERIC_PHY
 	help
 	  Support for the USB HSIC ULPI compliant PHY on QCOM chipsets.
+
+config PHY_QCOM_USB_HS_SNPS_28NM
+	tristate "Qualcomm Synopsys 28nm USB HS PHY driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on EXTCON || !EXTCON # if EXTCON=m, this cannot be built-in
+	select GENERIC_PHY
+	help
+	  Enable this to support the Synopsys 28nm Femto USB PHY on Qualcomm
+	  chips. This driver supports the high-speed PHY which is usually
+	  paired with either the ChipIdea or Synopsys DWC3 USB IPs on MSM SOCs.
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index c56efd3af205..dc238d95b18c 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PHY_QCOM_UFS_14NM)		+= phy-qcom-ufs-qmp-14nm.o
 obj-$(CONFIG_PHY_QCOM_UFS_20NM)		+= phy-qcom-ufs-qmp-20nm.o
 obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
 obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
+obj-$(CONFIG_PHY_QCOM_USB_HS_SNPS_28NM)	+= phy-qcom-usb-hs-snsp-28nm.o
diff --git a/drivers/phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c b/drivers/phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c
new file mode 100644
index 000000000000..589d417dbb7b
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-usb-hs-snsp-28nm.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2009-2018, Linux Foundation. All rights reserved.
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/extcon.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+/* PHY register and bit definitions */
+#define PHY_CTRL_COMMON0		0x078
+#define SIDDQ				BIT(2)
+#define PHY_IRQ_CMD			0x0d0
+#define PHY_INTR_MASK0			0x0d4
+#define PHY_INTR_CLEAR0			0x0dc
+#define DPDM_MASK			0x1e
+#define DP_1_0				BIT(4)
+#define DP_0_1				BIT(3)
+#define DM_1_0				BIT(2)
+#define DM_0_1				BIT(1)
+
+enum hsphy_voltage {
+	VOL_NONE,
+	VOL_MIN,
+	VOL_MAX,
+	VOL_NUM,
+};
+
+enum hsphy_vreg {
+	VDD,
+	VDDA_1P8,
+	VDDA_3P3,
+	VREG_NUM,
+};
+
+struct hsphy_init_seq {
+	int offset;
+	int val;
+	int delay;
+};
+
+struct hsphy_priv {
+	void __iomem *base;
+	struct clk_bulk_data *clks;
+	int num_clks;
+	struct reset_control *phy_reset;
+	struct reset_control *por_reset;
+	struct regulator_bulk_data vregs[VREG_NUM];
+	unsigned int voltages[VREG_NUM][VOL_NUM];
+	struct hsphy_init_seq *init_seq;
+	bool cable_connected;
+	struct extcon_dev *vbus_edev;
+	struct notifier_block vbus_notify;
+	enum phy_mode mode;
+};
+
+static int qcom_snps_hsphy_config_regulators(struct hsphy_priv *priv, int high)
+{
+	int old_uV[VREG_NUM];
+	int min, ret, i;
+
+	min = high ? 1 : 0; /* low or none? */
+
+	for (i = 0; i < VREG_NUM; i++) {
+		old_uV[i] = regulator_get_voltage(priv->vregs[i].consumer);
+		ret = regulator_set_voltage(priv->vregs[i].consumer,
+					    priv->voltages[i][min],
+					    priv->voltages[i][VOL_MAX]);
+		if (ret)
+			goto roll_back;
+	}
+
+	return 0;
+
+roll_back:
+	for (; i >= 0; i--)
+		regulator_set_voltage(priv->vregs[i].consumer,
+				      old_uV[i], old_uV[i]);
+	return ret;
+}
+
+static int qcom_snps_hsphy_enable_regulators(struct hsphy_priv *priv)
+{
+	int ret;
+
+	ret = qcom_snps_hsphy_config_regulators(priv, 1);
+	if (ret)
+		return ret;
+
+	ret = regulator_set_load(priv->vregs[VDDA_1P8].consumer, 19000);
+	if (ret < 0)
+		goto unconfig_regulators;
+
+	ret = regulator_set_load(priv->vregs[VDDA_3P3].consumer, 16000);
+	if (ret < 0)
+		goto unset_1p8_load;
+
+	ret = regulator_bulk_enable(VREG_NUM, priv->vregs);
+	if (ret)
+		goto unset_3p3_load;
+
+	return 0;
+
+unset_3p3_load:
+	regulator_set_load(priv->vregs[VDDA_3P3].consumer, 0);
+unset_1p8_load:
+	regulator_set_load(priv->vregs[VDDA_1P8].consumer, 0);
+unconfig_regulators:
+	qcom_snps_hsphy_config_regulators(priv, 0);
+	return ret;
+}
+
+static void qcom_snps_hsphy_disable_regulators(struct hsphy_priv *priv)
+{
+	regulator_bulk_disable(VREG_NUM, priv->vregs);
+	regulator_set_load(priv->vregs[VDDA_1P8].consumer, 0);
+	regulator_set_load(priv->vregs[VDDA_3P3].consumer, 0);
+	qcom_snps_hsphy_config_regulators(priv, 0);
+}
+
+static int qcom_snps_hsphy_set_mode(struct phy *phy, enum phy_mode mode)
+{
+	struct hsphy_priv *priv = phy_get_drvdata(phy);
+
+	priv->mode = mode;
+
+	return 0;
+}
+
+static void qcom_snps_hsphy_enable_hv_interrupts(struct hsphy_priv *priv)
+{
+	u32 val;
+
+	/* Clear any existing interrupts before enabling the interrupts */
+	val = readb(priv->base + PHY_INTR_CLEAR0);
+	val |= DPDM_MASK;
+	writeb(val, priv->base + PHY_INTR_CLEAR0);
+
+	writeb(0x0, priv->base + PHY_IRQ_CMD);
+	usleep_range(200, 220);
+	writeb(0x1, priv->base + PHY_IRQ_CMD);
+
+	/* Make sure the interrupts are cleared */
+	usleep_range(200, 220);
+
+	val = readb(priv->base + PHY_INTR_MASK0);
+	switch (priv->mode) {
+	case PHY_MODE_USB_HOST_HS:
+	case PHY_MODE_USB_HOST_FS:
+	case PHY_MODE_USB_DEVICE_HS:
+	case PHY_MODE_USB_DEVICE_FS:
+		val |= DP_1_0 | DM_0_1;
+		break;
+	case PHY_MODE_USB_HOST_LS:
+	case PHY_MODE_USB_DEVICE_LS:
+		val |= DP_0_1 | DM_1_0;
+		break;
+	default:
+		/* No device connected */
+		val |= DP_0_1 | DM_0_1;
+		break;
+	}
+	writeb(val, priv->base + PHY_INTR_MASK0);
+}
+
+static void qcom_snps_hsphy_disable_hv_interrupts(struct hsphy_priv *priv)
+{
+	u32 val;
+
+	val = readb(priv->base + PHY_INTR_MASK0);
+	val &= ~DPDM_MASK;
+	writeb(val, priv->base + PHY_INTR_MASK0);
+
+	/* Clear any pending interrupts */
+	val = readb(priv->base + PHY_INTR_CLEAR0);
+	val |= DPDM_MASK;
+	writeb(val, priv->base + PHY_INTR_CLEAR0);
+
+	writeb(0x0, priv->base + PHY_IRQ_CMD);
+	usleep_range(200, 220);
+
+	writeb(0x1, priv->base + PHY_IRQ_CMD);
+	usleep_range(200, 220);
+}
+
+static void qcom_snps_hsphy_enter_retention(struct hsphy_priv *priv)
+{
+	u32 val;
+
+	val = readb(priv->base + PHY_CTRL_COMMON0);
+	val |= SIDDQ;
+	writeb(val, priv->base + PHY_CTRL_COMMON0);
+}
+
+static void qcom_snps_hsphy_exit_retention(struct hsphy_priv *priv)
+{
+	u32 val;
+
+	val = readb(priv->base + PHY_CTRL_COMMON0);
+	val &= ~SIDDQ;
+	writeb(val, priv->base + PHY_CTRL_COMMON0);
+}
+
+static int qcom_snps_hsphy_vbus_notifier(struct notifier_block *nb,
+					 unsigned long event, void *ptr)
+{
+	struct hsphy_priv *priv = container_of(nb, struct hsphy_priv,
+						    vbus_notify);
+	priv->cable_connected = !!event;
+	return 0;
+}
+
+static int qcom_snps_hsphy_power_on(struct phy *phy)
+{
+	struct hsphy_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	if (priv->cable_connected) {
+		ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
+		if (ret)
+			return ret;
+		qcom_snps_hsphy_disable_hv_interrupts(priv);
+	} else {
+		ret = qcom_snps_hsphy_enable_regulators(priv);
+		if (ret)
+			return ret;
+		ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
+		if (ret)
+			return ret;
+		qcom_snps_hsphy_exit_retention(priv);
+	}
+
+	return 0;
+}
+
+static int qcom_snps_hsphy_power_off(struct phy *phy)
+{
+	struct hsphy_priv *priv = phy_get_drvdata(phy);
+
+	if (priv->cable_connected) {
+		qcom_snps_hsphy_enable_hv_interrupts(priv);
+		clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
+	} else {
+		qcom_snps_hsphy_enter_retention(priv);
+		clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
+		qcom_snps_hsphy_disable_regulators(priv);
+	}
+
+	return 0;
+}
+
+static int qcom_snps_hsphy_reset(struct hsphy_priv *priv)
+{
+	int ret;
+
+	ret = reset_control_assert(priv->phy_reset);
+	if (ret)
+		return ret;
+
+	usleep_range(10, 15);
+
+	ret = reset_control_deassert(priv->phy_reset);
+	if (ret)
+		return ret;
+
+	usleep_range(80, 100);
+
+	return 0;
+}
+
+static void qcom_snps_hsphy_init_sequence(struct hsphy_priv *priv)
+{
+	struct hsphy_init_seq *seq;
+
+	for (seq = priv->init_seq; seq->offset != -1; seq++) {
+		writeb(seq->val, priv->base + seq->offset);
+		if (seq->delay)
+			usleep_range(seq->delay, seq->delay + 10);
+	}
+
+	/* Ensure that the above parameter overrides is successful. */
+	mb();
+}
+
+static int qcom_snps_hsphy_por_reset(struct hsphy_priv *priv)
+{
+	int ret;
+
+	ret = reset_control_assert(priv->por_reset);
+	if (ret)
+		return ret;
+
+	/*
+	 * The Femto PHY is POR reset in the following scenarios.
+	 *
+	 * 1. After overriding the parameter registers.
+	 * 2. Low power mode exit from PHY retention.
+	 *
+	 * Ensure that SIDDQ is cleared before bringing the PHY
+	 * out of reset.
+	 */
+	qcom_snps_hsphy_exit_retention(priv);
+
+	/*
+	 * As per databook, 10 usec delay is required between
+	 * PHY POR assert and de-assert.
+	 */
+	usleep_range(10, 20);
+	ret = reset_control_deassert(priv->por_reset);
+	if (ret)
+		return ret;
+
+	/*
+	 * As per databook, it takes 75 usec for PHY to stabilize
+	 * after the reset.
+	 */
+	usleep_range(80, 100);
+
+	/* Ensure that RESET operation is completed. */
+	mb();
+
+	return 0;
+}
+
+static int qcom_snps_hsphy_init(struct phy *phy)
+{
+	struct hsphy_priv *priv = phy_get_drvdata(phy);
+	int state;
+	int ret;
+
+	ret = qcom_snps_hsphy_reset(priv);
+	if (ret)
+		return ret;
+
+	qcom_snps_hsphy_init_sequence(priv);
+
+	ret = qcom_snps_hsphy_por_reset(priv);
+	if (ret)
+		return ret;
+
+	/* Setup initial state */
+	if (priv->vbus_edev) {
+		state = extcon_get_state(priv->vbus_edev, EXTCON_USB);
+		ret = qcom_snps_hsphy_vbus_notifier(&priv->vbus_notify, state,
+						    priv->vbus_edev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct phy_ops qcom_snps_hsphy_ops = {
+	.init = qcom_snps_hsphy_init,
+	.power_on = qcom_snps_hsphy_power_on,
+	.power_off = qcom_snps_hsphy_power_off,
+	.set_mode = qcom_snps_hsphy_set_mode,
+	.owner = THIS_MODULE,
+};
+
+static const char * const qcom_snps_hsphy_clks[] = {
+	"ref",
+	"phy",
+	"sleep",
+};
+
+static int qcom_snps_hsphy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct phy_provider *provider;
+	struct hsphy_priv *priv;
+	struct resource *res;
+	struct phy *phy;
+	int size;
+	int ret;
+	int i;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->num_clks = ARRAY_SIZE(qcom_snps_hsphy_clks);
+	priv->clks = devm_kcalloc(dev, priv->num_clks, sizeof(*priv->clks),
+				  GFP_KERNEL);
+	if (!priv->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->num_clks; i++)
+		priv->clks[i].id = qcom_snps_hsphy_clks[i];
+
+	ret = devm_clk_bulk_get(dev, priv->num_clks, priv->clks);
+	if (ret)
+		return ret;
+
+	priv->phy_reset = devm_reset_control_get(dev, "phy");
+	if (IS_ERR(priv->phy_reset))
+		return PTR_ERR(priv->phy_reset);
+
+	priv->por_reset = devm_reset_control_get(dev, "por");
+	if (IS_ERR(priv->por_reset))
+		return PTR_ERR(priv->por_reset);
+
+	priv->vregs[VDD].supply = "vdd";
+	priv->vregs[VDDA_1P8].supply = "vdda1p8";
+	priv->vregs[VDDA_3P3].supply = "vdda3p3";
+
+	ret = devm_regulator_bulk_get(dev, VREG_NUM, priv->vregs);
+	if (ret)
+		return ret;
+
+	priv->voltages[VDDA_1P8][VOL_NONE] = 0;
+	priv->voltages[VDDA_1P8][VOL_MIN] = 1800000;
+	priv->voltages[VDDA_1P8][VOL_MAX] = 1800000;
+
+	priv->voltages[VDDA_3P3][VOL_NONE] = 0;
+	priv->voltages[VDDA_3P3][VOL_MIN] = 3050000;
+	priv->voltages[VDDA_3P3][VOL_MAX] = 3300000;
+
+	ret = of_property_read_u32_array(dev->of_node, "qcom,vdd-voltage-level",
+					 priv->voltages[VDD], VOL_NUM);
+	if (ret) {
+		dev_err(dev, "failed to read qcom,vdd-voltage-level\n");
+		return ret;
+	}
+
+	size = of_property_count_u32_elems(dev->of_node, "qcom,init-seq");
+	if (size < 0)
+		size = 0;
+
+	/*
+	 * The init-seq is a sequence of tuple which consists of 3
+	 * numbers <offset value delay>.
+	 */
+	priv->init_seq = devm_kcalloc(dev, (size / 3) + 1,
+				      sizeof(*priv->init_seq), GFP_KERNEL);
+	if (!priv->init_seq)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(dev->of_node, "qcom,init-seq",
+					 (u32 *) priv->init_seq, size);
+	if (ret && size)
+		return ret;
+
+	/* terminator */
+	priv->init_seq[size / 3].offset = -1;
+
+	phy = devm_phy_create(dev, dev->of_node, &qcom_snps_hsphy_ops);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	priv->vbus_edev = extcon_get_edev_by_phandle(dev, 0);
+	if (IS_ERR(priv->vbus_edev)) {
+		if (PTR_ERR(priv->vbus_edev) != -ENODEV)
+			return PTR_ERR(priv->vbus_edev);
+		priv->vbus_edev = NULL;
+	}
+
+	if (priv->vbus_edev) {
+		priv->vbus_notify.notifier_call = qcom_snps_hsphy_vbus_notifier;
+		ret = devm_extcon_register_notifier(dev, priv->vbus_edev,
+						    EXTCON_USB,
+						    &priv->vbus_notify);
+		if (ret)
+			return ret;
+	}
+
+	phy_set_drvdata(phy, priv);
+
+	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static const struct of_device_id qcom_snps_hsphy_match[] = {
+	{ .compatible = "qcom,usb-snps-hsphy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qcom_snps_hsphy_match);
+
+static struct platform_driver qcom_snps_hsphy_driver = {
+	.probe = qcom_snps_hsphy_probe,
+	.driver	= {
+		.name = "qcom-usb-snps-hsphy",
+		.of_match_table = qcom_snps_hsphy_match,
+	},
+};
+module_platform_driver(qcom_snps_hsphy_driver);
+
+MODULE_DESCRIPTION("Qualcomm Synopsys 28nm USB High-Speed PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

