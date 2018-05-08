Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753947AbeEHCVq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:21:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19579 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753785AbeEHCVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:21:06 -0400
X-UUID: 190a40159b114b83a095392500adfc52-20180508
From: Bibby Hsieh <bibby.hsieh@mediatek.com>
To: David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC: Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>, CK Hu <ck.hu@mediatek.com>,
        Mao Huang <littlecvr@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>
Subject: [PATCH 4/7] drm/mediatek: add hdmi driver for different hardware
Date: Tue, 8 May 2018 10:20:54 +0800
Message-ID: <20180508022057.29379-5-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20180508022057.29379-1-bibby.hsieh@mediatek.com>
References: <20180508022057.29379-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chunhui dai <chunhui.dai@mediatek.com>

This patch adds hdmi dirver suppot for both MT2701 and MT7623.
And also support other (existing or future) chips that use
the same binding and driver.

Signed-off-by: Chunhui Dai <chunhui.dai@mediatek.com>
---
 drivers/gpu/drm/mediatek/Makefile              |   4 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c            |  88 +++++--
 drivers/gpu/drm/mediatek/mtk_hdmi.h            |  28 +++
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 157 +++++++++++++
 drivers/gpu/drm/mediatek/mtk_hdmi_regs.h       |   1 +
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 307 +++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 129 +----------
 7 files changed, 566 insertions(+), 148 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index ce83c396a742..44464893c1cb 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -18,6 +18,8 @@ obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
 mediatek-drm-hdmi-objs := mtk_cec.o \
 			  mtk_hdmi.o \
 			  mtk_hdmi_ddc.o \
-			  mtk_mt8173_hdmi_phy.o
+			  mtk_mt2701_hdmi_phy.o \
+			  mtk_mt8173_hdmi_phy.o \
+			  mtk_hdmi_phy.o
 
 obj-$(CONFIG_DRM_MEDIATEK_HDMI) += mediatek-drm-hdmi.o
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 59a11026dceb..accafd95d6a8 100644
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
+				   HDMI_PSECUR_EN, enable ? 0 : HDMI_PSECUR_EN);
 
 	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG20,
 			   HDMI_PCLK_FREE_RUN, enable ? HDMI_PCLK_FREE_RUN : 0);
@@ -1437,6 +1443,7 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	struct platform_device *cec_pdev;
 	struct regmap *regmap;
 	struct resource *mem;
+	const char *phy_name;
 	int ret;
 
 	ret = mtk_hdmi_get_all_clk(hdmi, np);
@@ -1445,9 +1452,20 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
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
-	cec_np = of_find_compatible_node(np->parent, NULL,
-					 "mediatek,mt8173-cec");
+	cec_np = of_parse_phandle(np, "cec", 0);
 	if (!cec_np) {
 		dev_err(dev, "Failed to find CEC node\n");
 		return -EINVAL;
@@ -1486,8 +1504,14 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 		return PTR_ERR(hdmi->regs);
 
 	remote = of_graph_get_remote_node(np, 1, 0);
-	if (!remote)
-		return -EINVAL;
+	if (!remote) {
+		i2c_np = of_parse_phandle(np, "ddc-i2c-bus", 0);
+		if (!i2c_np) {
+			dev_err(dev, "Failed to find ddc-i2c-bus node\n");
+			return -EINVAL;
+		}
+		goto find_ddc_adpt;
+	}
 
 	if (!of_device_is_compatible(remote, "hdmi-connector")) {
 		hdmi->next_bridge = of_drm_find_bridge(remote);
@@ -1507,6 +1531,7 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	}
 	of_node_put(remote);
 
+find_ddc_adpt:
 	hdmi->ddc_adpt = of_find_i2c_adapter_by_node(i2c_np);
 	if (!hdmi->ddc_adpt) {
 		dev_err(dev, "Failed to get ddc i2c adapter by node\n");
@@ -1575,6 +1600,11 @@ static int mtk_hdmi_audio_hw_params(struct device *dev, void *data,
 		hdmi_params.aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
 		hdmi_params.aud_mclk = HDMI_AUD_MCLK_128FS;
 		break;
+	case HDMI_SPDIF:
+		hdmi_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
+		hdmi_params.aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+		hdmi_params.aud_input_type = HDMI_AUD_INPUT_SPDIF;
+		break;
 	default:
 		dev_err(hdmi->dev, "%s: Invalid DAI format %d\n", __func__,
 			daifmt->fmt);
@@ -1650,15 +1680,15 @@ static void mtk_hdmi_register_audio_driver(struct device *dev)
 		.max_i2s_channels = 2,
 		.i2s = 1,
 	};
-	struct platform_device *pdev;
+	static struct platform_device *pdev;
 
-	pdev = platform_device_register_data(dev, HDMI_CODEC_DRV_NAME,
-					     PLATFORM_DEVID_AUTO, &codec_data,
-					     sizeof(codec_data));
-	if (IS_ERR(pdev))
+	if (!pdev) {
+		pdev = platform_device_register_data(dev, HDMI_CODEC_DRV_NAME,
+						     PLATFORM_DEVID_NONE, &codec_data,
+						     sizeof(codec_data));
+		DRM_INFO("%s driver bound to HDMI\n", HDMI_CODEC_DRV_NAME);
+	}
 		return;
-
-	DRM_INFO("%s driver bound to HDMI\n", HDMI_CODEC_DRV_NAME);
 }
 
 static int mtk_drm_hdmi_probe(struct platform_device *pdev)
@@ -1672,18 +1702,12 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hdmi->dev = dev;
+	mtk_hdmi_register_audio_driver(dev);
 
 	ret = mtk_hdmi_dt_parse_pdata(hdmi, pdev);
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
@@ -1692,8 +1716,6 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	mtk_hdmi_register_audio_driver(dev);
-
 	hdmi->bridge.funcs = &mtk_hdmi_bridge_funcs;
 	hdmi->bridge.of_node = pdev->dev.of_node;
 	drm_bridge_add(&hdmi->bridge);
@@ -1704,7 +1726,6 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 		goto err_bridge_remove;
 	}
 
-	dev_dbg(dev, "mediatek hdmi probe success\n");
 	return 0;
 
 err_bridge_remove:
@@ -1773,8 +1794,25 @@ static struct platform_driver * const mtk_hdmi_drivers[] = {
 
 static int __init mtk_hdmitx_init(void)
 {
-	return platform_register_drivers(mtk_hdmi_drivers,
-					 ARRAY_SIZE(mtk_hdmi_drivers));
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mtk_hdmi_drivers); i++) {
+		ret = platform_driver_register(mtk_hdmi_drivers[i]);
+		if (ret < 0) {
+			pr_err("Failed to register %s driver: %d\n",
+			       mtk_hdmi_drivers[i]->driver.name, ret);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	while (--i >= 0)
+		platform_driver_unregister(mtk_hdmi_drivers[i]);
+
+	return ret;
 }
 
 static void __exit mtk_hdmitx_exit(void)
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.h b/drivers/gpu/drm/mediatek/mtk_hdmi.h
index 6371b3de1ff6..a4546b83329f 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.h
@@ -13,11 +13,39 @@
  */
 #ifndef _MTK_HDMI_CTRL_H
 #define _MTK_HDMI_CTRL_H
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
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
+extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf;
+
 
 #endif /* _MTK_HDMI_CTRL_H */
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
new file mode 100644
index 000000000000..325790abd469
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Jie Qiu <jie.qiu@mediatek.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/phy/phy.h>
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
+	{ .compatible = "mediatek,mt2701-hdmi-phy",
+	  .data = &mtk_hdmi_phy_2701_conf,
+	},
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
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h b/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
index a5cb07d12c9c..e53c6646571c 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
@@ -227,6 +227,7 @@
 #define DEEP_COLOR_EN			BIT(0)
 #define HDMI_AUDIO_TEST_SEL		BIT(8)
 #define HDMI2P0_EN			BIT(11)
+#define HDMI_PSECUR_EN			BIT(15)
 #define HDMI_OUT_FIFO_EN		BIT(16)
 #define HDMI_OUT_FIFO_CLK_INV		BIT(17)
 #define MHL_MODE_ON			BIT(28)
diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
new file mode 100644
index 000000000000..8af5e6c1aecc
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *Copyright (c) 2018 MediaTek Inc.
+ *Author: Chunhui Dai <chunhui.dai@mediatek.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/phy/phy.h>
+#include "mtk_hdmi.h"
+
+#define HDMI_CON0	0x00
+#define RG_HDMITX_DRV_IBIAS		(0)
+#define RG_HDMITX_DRV_IBIAS_MASK	(0x3F << 0)
+#define RG_HDMITX_EN_SER		(12)
+#define RG_HDMITX_EN_SER_MASK		(0x0F << 12)
+#define RG_HDMITX_EN_SLDO		(16)
+#define RG_HDMITX_EN_SLDO_MASK		(0x0F << 16)
+#define RG_HDMITX_EN_PRED		(20)
+#define RG_HDMITX_EN_PRED_MASK		(0x0F << 20)
+#define RG_HDMITX_EN_IMP		(24)
+#define RG_HDMITX_EN_IMP_MASK		(0x0F << 24)
+#define RG_HDMITX_EN_DRV		(28)
+#define RG_HDMITX_EN_DRV_MASK		(0x0F << 28)
+
+#define HDMI_CON1	0x04
+#define RG_HDMITX_PRED_IBIAS		(18)
+#define RG_HDMITX_PRED_IBIAS_MASK	(0x0F << 18)
+#define RG_HDMITX_PRED_IMP		(0x01 << 22)
+#define RG_HDMITX_DRV_IMP		(26)
+#define RG_HDMITX_DRV_IMP_MASK		(0x3F << 26)
+
+#define HDMI_CON2	0x08
+#define RG_HDMITX_EN_TX_CKLDO		(0x01 << 0)
+#define RG_HDMITX_EN_TX_POSDIV		(0x01 << 1)
+#define RG_HDMITX_TX_POSDIV		(3)
+#define RG_HDMITX_TX_POSDIV_MASK	(0x03 << 3)
+#define RG_HDMITX_EN_MBIAS		(0x01 << 6)
+#define RG_HDMITX_MBIAS_LPF_EN		(0x01 << 7)
+
+#define HDMI_CON4	0x10
+#define RG_HDMITX_RESERVE_MASK		(0xFFFFFFFF << 0)
+
+#define HDMI_CON6	0x18
+#define RG_HTPLL_BR			(0)
+#define RG_HTPLL_BR_MASK		(0x03 << 0)
+#define RG_HTPLL_BC			(2)
+#define RG_HTPLL_BC_MASK		(0x03 << 2)
+#define RG_HTPLL_BP			(4)
+#define RG_HTPLL_BP_MASK		(0x0F << 4)
+#define RG_HTPLL_IR			(8)
+#define RG_HTPLL_IR_MASK		(0x0F << 8)
+#define RG_HTPLL_IC			(12)
+#define RG_HTPLL_IC_MASK		(0x0F << 12)
+#define RG_HTPLL_POSDIV			(16)
+#define RG_HTPLL_POSDIV_MASK		(0x03 << 16)
+#define RG_HTPLL_PREDIV			(18)
+#define RG_HTPLL_PREDIV_MASK		(0x03 << 18)
+#define RG_HTPLL_FBKSEL			(20)
+#define RG_HTPLL_FBKSEL_MASK		(0x03 << 20)
+#define RG_HTPLL_RLH_EN			(0x01 << 22)
+#define RG_HTPLL_FBKDIV			(24)
+#define RG_HTPLL_FBKDIV_MASK		(0x7F << 24)
+#define RG_HTPLL_EN			(0x01 << 31)
+
+#define HDMI_CON7	0x1c
+#define RG_HTPLL_AUTOK_EN		(0x01 << 23)
+#define RG_HTPLL_DIVEN			(28)
+#define RG_HTPLL_DIVEN_MASK		(0x07 << 28)
+
+static inline struct mtk_hdmi_phy *to_mtk_hdmi_pll(struct clk_hw *hw)
+{
+	return container_of(hw, struct mtk_hdmi_phy, pll_hw);
+}
+
+static inline void mtk_hdmi_pll_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
+				     u32 val, u32 mask)
+{
+	u32 tmp = readl(hdmi_phy->regs  + offset) & ~mask;
+
+	tmp |= (val & mask);
+	writel(tmp, hdmi_phy->regs + offset);
+}
+
+static int mtk_hdmi_pll_enable(struct clk_hw *hw)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_pll(hw);
+
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON7, RG_HTPLL_AUTOK_EN,
+			  RG_HTPLL_AUTOK_EN);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, 0, RG_HTPLL_RLH_EN);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, (0x3 << RG_HTPLL_POSDIV),
+			  RG_HTPLL_POSDIV_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_MBIAS,
+			  RG_HDMITX_EN_MBIAS);
+	usleep_range(80, 100);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, RG_HTPLL_EN, RG_HTPLL_EN);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_CKLDO,
+			  RG_HDMITX_EN_TX_CKLDO);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, (0xf << RG_HDMITX_EN_SLDO),
+			  RG_HDMITX_EN_SLDO_MASK);
+	usleep_range(80, 100);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN,
+			  RG_HDMITX_MBIAS_LPF_EN);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV,
+			  RG_HDMITX_EN_TX_POSDIV);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, (0xf << RG_HDMITX_EN_SER),
+			  RG_HDMITX_EN_SER_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, (0xf << RG_HDMITX_EN_PRED),
+			  RG_HDMITX_EN_PRED_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, (0xf << RG_HDMITX_EN_DRV),
+			  RG_HDMITX_EN_DRV_MASK);
+	usleep_range(80, 100);
+	return 0;
+}
+
+static void mtk_hdmi_pll_disable(struct clk_hw *hw)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_pll(hw);
+
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, 0, RG_HDMITX_EN_DRV_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, 0, RG_HDMITX_EN_PRED_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, 0, RG_HDMITX_EN_SER_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, 0, RG_HDMITX_EN_TX_POSDIV);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, 0, RG_HDMITX_MBIAS_LPF_EN);
+	usleep_range(80, 100);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, 0, RG_HDMITX_EN_SLDO_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, 0, RG_HDMITX_EN_TX_CKLDO);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, 0, RG_HTPLL_EN);
+	usleep_range(80, 100);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, 0, RG_HDMITX_EN_MBIAS);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, 0, RG_HTPLL_POSDIV_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, 0, RG_HTPLL_RLH_EN);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON7, 0, RG_HTPLL_AUTOK_EN);
+	usleep_range(80, 100);
+}
+
+static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_pll(hw);
+	u32 pos_div;
+
+	if (rate <= 64000000)
+		pos_div = 3;
+	else if (rate <= 12800000)
+		pos_div = 1;
+	else
+		pos_div = 1;
+
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, (0x3 << RG_HTPLL_PREDIV),
+			  RG_HTPLL_PREDIV_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, (0x3 << RG_HTPLL_POSDIV),
+			  RG_HTPLL_POSDIV_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, (0x1 << RG_HTPLL_IC),
+			  RG_HTPLL_IC_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, (0x1 << RG_HTPLL_IR),
+			  RG_HTPLL_IR_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, (pos_div << RG_HDMITX_TX_POSDIV),
+			  RG_HDMITX_TX_POSDIV_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, (1 << RG_HTPLL_FBKSEL),
+			  RG_HTPLL_FBKSEL_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, (19 << RG_HTPLL_FBKDIV),
+			  RG_HTPLL_FBKDIV_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON7, (0x2 << RG_HTPLL_DIVEN),
+			  RG_HTPLL_DIVEN_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, (0xc << RG_HTPLL_BP),
+			  RG_HTPLL_BP_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, (0x2 << RG_HTPLL_BC),
+			  RG_HTPLL_BC_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, (0x1 << RG_HTPLL_BR),
+			  RG_HTPLL_BR_MASK);
+
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON1, 0, RG_HDMITX_PRED_IMP);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON1, (0x3 << RG_HDMITX_PRED_IBIAS),
+			  RG_HDMITX_PRED_IBIAS_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, (0x0 << RG_HDMITX_EN_IMP),
+			  RG_HDMITX_EN_IMP_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON1, (0x28 << RG_HDMITX_DRV_IMP),
+			  RG_HDMITX_DRV_IMP_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON4, 0x28, RG_HDMITX_RESERVE_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, (0xa << RG_HDMITX_DRV_IBIAS),
+			  RG_HDMITX_DRV_IBIAS_MASK);
+	return 0;
+}
+
+static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long *parent_rate)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_pll(hw);
+
+	hdmi_phy->pll_rate = rate;
+	return rate;
+}
+
+static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_pll(hw);
+
+	return hdmi_phy->pll_rate;
+}
+
+static const struct clk_ops mtk_hdmi_phy_pll_ops = {
+	.enable = mtk_hdmi_pll_enable,
+	.disable = mtk_hdmi_pll_disable,
+	.set_rate = mtk_hdmi_pll_set_rate,
+	.round_rate = mtk_hdmi_pll_round_rate,
+	.recalc_rate = mtk_hdmi_pll_recalc_rate,
+};
+
+static void mtk_hdmi_phy_enable_tmds(struct mtk_hdmi_phy *hdmi_phy)
+{
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON7, RG_HTPLL_AUTOK_EN,
+			  RG_HTPLL_AUTOK_EN);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, 0, RG_HTPLL_RLH_EN);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, (0x3 << RG_HTPLL_POSDIV),
+			  RG_HTPLL_POSDIV_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_MBIAS,
+			  RG_HDMITX_EN_MBIAS);
+	usleep_range(80, 100);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, RG_HTPLL_EN, RG_HTPLL_EN);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_CKLDO,
+			  RG_HDMITX_EN_TX_CKLDO);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, (0xf << RG_HDMITX_EN_SLDO),
+			  RG_HDMITX_EN_SLDO_MASK);
+	usleep_range(80, 100);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN,
+			  RG_HDMITX_MBIAS_LPF_EN);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV,
+			  RG_HDMITX_EN_TX_POSDIV);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, (0xf << RG_HDMITX_EN_SER),
+			  RG_HDMITX_EN_SER_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, (0xf << RG_HDMITX_EN_PRED),
+			  RG_HDMITX_EN_PRED_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, (0xf << RG_HDMITX_EN_DRV),
+			  RG_HDMITX_EN_DRV_MASK);
+	usleep_range(80, 100);
+}
+
+static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
+{
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, 0, RG_HDMITX_EN_DRV_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, 0, RG_HDMITX_EN_PRED_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, 0, RG_HDMITX_EN_SER_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, 0, RG_HDMITX_EN_TX_POSDIV);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, 0, RG_HDMITX_MBIAS_LPF_EN);
+	usleep_range(80, 100);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON0, 0, RG_HDMITX_EN_SLDO_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, 0, RG_HDMITX_EN_TX_CKLDO);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, 0, RG_HTPLL_EN);
+	usleep_range(80, 100);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON2, 0, RG_HDMITX_EN_MBIAS);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, 0, RG_HTPLL_POSDIV_MASK);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON6, 0, RG_HTPLL_RLH_EN);
+	mtk_hdmi_pll_mask(hdmi_phy, HDMI_CON7, 0, RG_HTPLL_AUTOK_EN);
+	usleep_range(80, 100);
+}
+
+static int mtk_hdmi_phy_power_on(struct phy *phy)
+{
+	struct mtk_hdmi_phy *hdmi_phy = phy_get_drvdata(phy);
+	int ret;
+
+	ret = clk_prepare_enable(hdmi_phy->pll);
+	if (ret < 0)
+		return ret;
+
+	mtk_hdmi_phy_enable_tmds(hdmi_phy);
+
+	return 0;
+}
+
+static int mtk_hdmi_phy_power_off(struct phy *phy)
+{
+	struct mtk_hdmi_phy *hdmi_phy = phy_get_drvdata(phy);
+
+	mtk_hdmi_phy_disable_tmds(hdmi_phy);
+	clk_disable_unprepare(hdmi_phy->pll);
+
+	return 0;
+}
+
+static const struct phy_ops mtk_hdmi_phy_dev_ops = {
+	.power_on = mtk_hdmi_phy_power_on,
+	.power_off = mtk_hdmi_phy_power_off,
+	.owner = THIS_MODULE,
+};
+
+struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf = {
+	.tz_enabled = false,
+	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
+	.hdmi_phy_dev_ops = &mtk_hdmi_phy_dev_ops,
+};
+
+MODULE_AUTHOR("Chunhui Dai <chunhui.dai@mediatek.com>");
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
2.12.5
