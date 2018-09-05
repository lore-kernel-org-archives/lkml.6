Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6103FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0926A206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0926A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeIENBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:01:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51718 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728033AbeIENB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:01:29 -0400
X-UUID: ec8791831a294971a82621a6dd4d6649-20180905
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 203700691; Wed, 05 Sep 2018 16:32:14 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 5 Sep 2018 16:31:48 +0800
Received: from mtkslt209.mediatek.inc (10.21.15.96) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 5 Sep 2018 16:31:48 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, Mao Huang <littlecvr@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>
Subject: [PATCH v2 07/13] drm/mediatek: separae hdmi phy to different file
Date:   Wed, 5 Sep 2018 16:31:40 +0800
Message-ID: <20180905083146.14727-8-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.12.5.2.gbdf23ab
In-Reply-To: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
References: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chunhui dai <chunhui.dai@mediatek.com>

Different IC has different phy setting of HDMI.
This patch separaes the phy hardware relate part for mt8173.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
---
 drivers/gpu/drm/mediatek/Makefile              |  15 +--
 drivers/gpu/drm/mediatek/mtk_hdmi.c            |  30 +++--
 drivers/gpu/drm/mediatek/mtk_hdmi.h            |  26 +++++
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 154 +++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 129 ++-------------------
 5 files changed, 216 insertions(+), 138 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index ce83c396a742..7f947979d68f 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -1,4 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
+mediatek-drm-hdmi-objs := mtk_cec.o \
+			  mtk_hdmi.o \
+			  mtk_hdmi_ddc.o \
+			  mtk_mt8173_hdmi_phy.o \
+			  mtk_hdmi_phy.o
+
+obj-$(CONFIG_DRM_MEDIATEK_HDMI) += mediatek-drm-hdmi.o
+
 mediatek-drm-y := mtk_disp_color.o \
 		  mtk_disp_ovl.o \
 		  mtk_disp_rdma.o \
@@ -14,10 +22,3 @@ mediatek-drm-y := mtk_disp_color.o \
 		  mtk_dpi.o
 
 obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
-
-mediatek-drm-hdmi-objs := mtk_cec.o \
-			  mtk_hdmi.o \
-			  mtk_hdmi_ddc.o \
-			  mtk_mt8173_hdmi_phy.o
-
-obj-$(CONFIG_DRM_MEDIATEK_HDMI) += mediatek-drm-hdmi.o
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 2d45d1dd9554..7c022f3f53ec 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -233,6 +233,7 @@ static void mtk_hdmi_hw_vid_black(struct mtk_hdmi *hdmi, bool black)
 static void mtk_hdmi_hw_make_reg_writable(struct mtk_hdmi *hdmi, bool enable)
 {
 	struct arm_smccc_res res;
+	struct mtk_hdmi_phy *hdmi_phy = phy_get_drvdata(hdmi->phy);
 
 	/*
 	 * MT8173 HDMI hardware has an output control bit to enable/disable HDMI
@@ -240,8 +241,13 @@ static void mtk_hdmi_hw_make_reg_writable(struct mtk_hdmi *hdmi, bool enable)
 	 * The ARM trusted firmware provides an API for the HDMI driver to set
 	 * this control bit to enable HDMI output in supervisor mode.
 	 */
-	arm_smccc_smc(MTK_SIP_SET_AUTHORIZED_SECURE_REG, 0x14000904, 0x80000000,
-		      0, 0, 0, 0, 0, &res);
+	if (hdmi_phy->conf && hdmi_phy->conf->tz_enabled)
+		arm_smccc_smc(MTK_SIP_SET_AUTHORIZED_SECURE_REG, 0x14000904,
+			      0x80000000, 0, 0, 0, 0, 0, &res);
+	else
+		regmap_update_bits(hdmi->sys_regmap,
+				   hdmi->sys_offset + HDMI_SYS_CFG20,
+				   0x80008005, enable ? 0x80000005 : 0x8000);
 
 	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG20,
 			   HDMI_PCLK_FREE_RUN, enable ? HDMI_PCLK_FREE_RUN : 0);
@@ -1437,6 +1443,7 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	struct platform_device *cec_pdev;
 	struct regmap *regmap;
 	struct resource *mem;
+	const char *phy_name;
 	int ret;
 
 	ret = mtk_hdmi_get_all_clk(hdmi, np);
@@ -1445,6 +1452,18 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 		return ret;
 	}
 
+	ret = of_property_read_string(np, "phy-names", &phy_name);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read phy-names: %d\n", ret);
+		return ret;
+	}
+	hdmi->phy = devm_phy_get(dev, phy_name);
+	if (IS_ERR(hdmi->phy)) {
+		ret = PTR_ERR(hdmi->phy);
+		dev_err(dev, "Failed to get HDMI PHY: %d\n", ret);
+		return ret;
+	}
+
 	/* The CEC module handles HDMI hotplug detection */
 	cec_np = of_find_compatible_node(np->parent, NULL,
 					 "mediatek,mt8173-cec");
@@ -1677,13 +1696,6 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	hdmi->phy = devm_phy_get(dev, "hdmi");
-	if (IS_ERR(hdmi->phy)) {
-		ret = PTR_ERR(hdmi->phy);
-		dev_err(dev, "Failed to get HDMI PHY: %d\n", ret);
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, hdmi);
 
 	ret = mtk_hdmi_output_init(hdmi);
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.h b/drivers/gpu/drm/mediatek/mtk_hdmi.h
index 6371b3de1ff6..a350a6c9271f 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.h
@@ -13,11 +13,37 @@
  */
 #ifndef _MTK_HDMI_CTRL_H
 #define _MTK_HDMI_CTRL_H
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+struct mtk_hdmi_phy_conf {
+	bool tz_enabled;
+	const struct clk_ops *hdmi_phy_clk_ops;
+	const struct phy_ops *hdmi_phy_dev_ops;
+};
+
+struct mtk_hdmi_phy {
+	void __iomem *regs;
+	struct device *dev;
+	struct mtk_hdmi_phy_conf *conf;
+	struct clk *pll;
+	struct clk_hw pll_hw;
+	unsigned long pll_rate;
+	unsigned char drv_imp_clk;
+	unsigned char drv_imp_d2;
+	unsigned char drv_imp_d1;
+	unsigned char drv_imp_d0;
+	unsigned int ibias;
+	unsigned int ibias_up;
+};
 
 struct platform_driver;
 
 extern struct platform_driver mtk_cec_driver;
 extern struct platform_driver mtk_hdmi_ddc_driver;
 extern struct platform_driver mtk_hdmi_phy_driver;
+extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
 
 #endif /* _MTK_HDMI_CTRL_H */
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
new file mode 100644
index 000000000000..82ed73575e04
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Jie Qiu <jie.qiu@mediatek.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include "mtk_hdmi.h"
+
+static void mtk_hdmi_phy_clk_get_ops(struct mtk_hdmi_phy *hdmi_phy,
+				     const struct clk_ops **ops)
+{
+	if (hdmi_phy && hdmi_phy->conf && hdmi_phy->conf->hdmi_phy_clk_ops)
+		*ops = hdmi_phy->conf->hdmi_phy_clk_ops;
+	else
+		dev_err(hdmi_phy->dev, "Failed to get clk ops of phy\n");
+}
+
+static const struct phy_ops *
+mtk_hdmi_phy_dev_get_ops(const struct mtk_hdmi_phy *hdmi_phy)
+{
+	if (hdmi_phy && hdmi_phy->conf && hdmi_phy->conf->hdmi_phy_dev_ops)
+		return hdmi_phy->conf->hdmi_phy_dev_ops;
+	dev_err(hdmi_phy->dev, "Failed to get dev ops of phy\n");
+		return NULL;
+}
+
+static int mtk_hdmi_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_hdmi_phy *hdmi_phy;
+	struct resource *mem;
+	struct clk *ref_clk;
+	const char *ref_clk_name;
+	struct clk_init_data clk_init = {
+		.num_parents = 1,
+		.parent_names = (const char * const *)&ref_clk_name,
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
+	};
+
+	struct phy *phy;
+	struct phy_provider *phy_provider;
+	int ret;
+
+	hdmi_phy = devm_kzalloc(dev, sizeof(*hdmi_phy), GFP_KERNEL);
+	if (!hdmi_phy)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hdmi_phy->regs = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(hdmi_phy->regs)) {
+		ret = PTR_ERR(hdmi_phy->regs);
+		dev_err(dev, "Failed to get memory resource: %d\n", ret);
+		return ret;
+	}
+
+	ref_clk = devm_clk_get(dev, "pll_ref");
+	if (IS_ERR(ref_clk)) {
+		ret = PTR_ERR(ref_clk);
+		dev_err(&pdev->dev, "Failed to get PLL reference clock: %d\n",
+			ret);
+		return ret;
+	}
+	ref_clk_name = __clk_get_name(ref_clk);
+
+	ret = of_property_read_string(dev->of_node, "clock-output-names",
+				      &clk_init.name);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read clock-output-names: %d\n", ret);
+		return ret;
+	}
+
+	hdmi_phy->dev = dev;
+	hdmi_phy->conf =
+		(struct mtk_hdmi_phy_conf *)of_device_get_match_data(dev);
+	mtk_hdmi_phy_clk_get_ops(hdmi_phy, &clk_init.ops);
+	hdmi_phy->pll_hw.init = &clk_init;
+	hdmi_phy->pll = devm_clk_register(dev, &hdmi_phy->pll_hw);
+	if (IS_ERR(hdmi_phy->pll)) {
+		ret = PTR_ERR(hdmi_phy->pll);
+		dev_err(dev, "Failed to register PLL: %d\n", ret);
+		return ret;
+	}
+
+	ret = of_property_read_u32(dev->of_node, "mediatek,ibias",
+				   &hdmi_phy->ibias);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to get ibias: %d\n", ret);
+		return ret;
+	}
+
+	ret = of_property_read_u32(dev->of_node, "mediatek,ibias_up",
+				   &hdmi_phy->ibias_up);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to get ibias up: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(dev, "Using default TX DRV impedance: 4.2k/36\n");
+	hdmi_phy->drv_imp_clk = 0x30;
+	hdmi_phy->drv_imp_d2 = 0x30;
+	hdmi_phy->drv_imp_d1 = 0x30;
+	hdmi_phy->drv_imp_d0 = 0x30;
+
+	phy = devm_phy_create(dev, NULL, mtk_hdmi_phy_dev_get_ops(hdmi_phy));
+	if (IS_ERR(phy)) {
+		dev_err(dev, "Failed to create HDMI PHY\n");
+		return PTR_ERR(phy);
+	}
+	phy_set_drvdata(phy, hdmi_phy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider)) {
+		dev_err(dev, "Failed to register HDMI PHY\n");
+		return PTR_ERR(phy_provider);
+	}
+
+	return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
+				   hdmi_phy->pll);
+}
+
+static int mtk_hdmi_phy_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id mtk_hdmi_phy_match[] = {
+	{ .compatible = "mediatek,mt8173-hdmi-phy",
+	  .data = &mtk_hdmi_phy_8173_conf,
+	},
+	{},
+};
+
+struct platform_driver mtk_hdmi_phy_driver = {
+	.probe = mtk_hdmi_phy_probe,
+	.remove = mtk_hdmi_phy_remove,
+	.driver = {
+		.name = "mediatek-hdmi-phy",
+		.of_match_table = mtk_hdmi_phy_match,
+	},
+};
+
+MODULE_DESCRIPTION("MediaTek HDMI PHY Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
index 51cb9cfb6646..1a35fdd405d8 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
@@ -21,6 +21,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include "mtk_hdmi.h"
 
 #define HDMI_CON0		0x00
 #define RG_HDMITX_PLL_EN		BIT(31)
@@ -123,20 +124,6 @@
 #define RGS_HDMITX_5T1_EDG		(0xf << 4)
 #define RGS_HDMITX_PLUG_TST		BIT(0)
 
-struct mtk_hdmi_phy {
-	void __iomem *regs;
-	struct device *dev;
-	struct clk *pll;
-	struct clk_hw pll_hw;
-	unsigned long pll_rate;
-	u8 drv_imp_clk;
-	u8 drv_imp_d2;
-	u8 drv_imp_d1;
-	u8 drv_imp_d0;
-	u32 ibias;
-	u32 ibias_up;
-};
-
 static const u8 PREDIV[3][4] = {
 	{0x0, 0x0, 0x0, 0x0},	/* 27Mhz */
 	{0x1, 0x1, 0x1, 0x1},	/* 74Mhz */
@@ -367,7 +354,7 @@ static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
 	return hdmi_phy->pll_rate;
 }
 
-static const struct clk_ops mtk_hdmi_pll_ops = {
+static const struct clk_ops mtk_hdmi_phy_pll_ops = {
 	.prepare = mtk_hdmi_pll_prepare,
 	.unprepare = mtk_hdmi_pll_unprepare,
 	.set_rate = mtk_hdmi_pll_set_rate,
@@ -414,118 +401,16 @@ static int mtk_hdmi_phy_power_off(struct phy *phy)
 	return 0;
 }
 
-static const struct phy_ops mtk_hdmi_phy_ops = {
+static const struct phy_ops mtk_hdmi_phy_dev_ops = {
 	.power_on = mtk_hdmi_phy_power_on,
 	.power_off = mtk_hdmi_phy_power_off,
 	.owner = THIS_MODULE,
 };
 
-static int mtk_hdmi_phy_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct mtk_hdmi_phy *hdmi_phy;
-	struct resource *mem;
-	struct clk *ref_clk;
-	const char *ref_clk_name;
-	struct clk_init_data clk_init = {
-		.ops = &mtk_hdmi_pll_ops,
-		.num_parents = 1,
-		.parent_names = (const char * const *)&ref_clk_name,
-		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
-	};
-	struct phy *phy;
-	struct phy_provider *phy_provider;
-	int ret;
-
-	hdmi_phy = devm_kzalloc(dev, sizeof(*hdmi_phy), GFP_KERNEL);
-	if (!hdmi_phy)
-		return -ENOMEM;
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hdmi_phy->regs = devm_ioremap_resource(dev, mem);
-	if (IS_ERR(hdmi_phy->regs)) {
-		ret = PTR_ERR(hdmi_phy->regs);
-		dev_err(dev, "Failed to get memory resource: %d\n", ret);
-		return ret;
-	}
-
-	ref_clk = devm_clk_get(dev, "pll_ref");
-	if (IS_ERR(ref_clk)) {
-		ret = PTR_ERR(ref_clk);
-		dev_err(&pdev->dev, "Failed to get PLL reference clock: %d\n",
-			ret);
-		return ret;
-	}
-	ref_clk_name = __clk_get_name(ref_clk);
-
-	ret = of_property_read_string(dev->of_node, "clock-output-names",
-				      &clk_init.name);
-	if (ret < 0) {
-		dev_err(dev, "Failed to read clock-output-names: %d\n", ret);
-		return ret;
-	}
-
-	hdmi_phy->pll_hw.init = &clk_init;
-	hdmi_phy->pll = devm_clk_register(dev, &hdmi_phy->pll_hw);
-	if (IS_ERR(hdmi_phy->pll)) {
-		ret = PTR_ERR(hdmi_phy->pll);
-		dev_err(dev, "Failed to register PLL: %d\n", ret);
-		return ret;
-	}
-
-	ret = of_property_read_u32(dev->of_node, "mediatek,ibias",
-				   &hdmi_phy->ibias);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to get ibias: %d\n", ret);
-		return ret;
-	}
-
-	ret = of_property_read_u32(dev->of_node, "mediatek,ibias_up",
-				   &hdmi_phy->ibias_up);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to get ibias up: %d\n", ret);
-		return ret;
-	}
-
-	dev_info(dev, "Using default TX DRV impedance: 4.2k/36\n");
-	hdmi_phy->drv_imp_clk = 0x30;
-	hdmi_phy->drv_imp_d2 = 0x30;
-	hdmi_phy->drv_imp_d1 = 0x30;
-	hdmi_phy->drv_imp_d0 = 0x30;
-
-	phy = devm_phy_create(dev, NULL, &mtk_hdmi_phy_ops);
-	if (IS_ERR(phy)) {
-		dev_err(dev, "Failed to create HDMI PHY\n");
-		return PTR_ERR(phy);
-	}
-	phy_set_drvdata(phy, hdmi_phy);
-
-	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-	if (IS_ERR(phy_provider))
-		return PTR_ERR(phy_provider);
-
-	hdmi_phy->dev = dev;
-	return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
-				   hdmi_phy->pll);
-}
-
-static int mtk_hdmi_phy_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static const struct of_device_id mtk_hdmi_phy_match[] = {
-	{ .compatible = "mediatek,mt8173-hdmi-phy", },
-	{},
-};
-
-struct platform_driver mtk_hdmi_phy_driver = {
-	.probe = mtk_hdmi_phy_probe,
-	.remove = mtk_hdmi_phy_remove,
-	.driver = {
-		.name = "mediatek-hdmi-phy",
-		.of_match_table = mtk_hdmi_phy_match,
-	},
+struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf = {
+	.tz_enabled = true,
+	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
+	.hdmi_phy_dev_ops = &mtk_hdmi_phy_dev_ops,
 };
 
 MODULE_AUTHOR("Jie Qiu <jie.qiu@mediatek.com>");
-- 
2.12.5.2.gbdf23ab

