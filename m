Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38AAC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9632089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9632089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJBOxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:53:03 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37250 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727429AbeJBOw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:52:58 -0400
X-UUID: 4c9653be44294fd7b10cb335193c047a-20181002
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1918995768; Tue, 02 Oct 2018 16:10:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 2 Oct 2018 16:10:45 +0800
Received: from mtkslt209.mediatek.inc (10.21.15.96) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 2 Oct 2018 16:10:45 +0800
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
Subject: [PATCH v4 09/11] drm/mediatek: add hdmi driver for MT2701 and MT7623
Date:   Tue, 2 Oct 2018 16:10:39 +0800
Message-ID: <20181002081041.32629-10-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.12.5.2.gbdf23ab
In-Reply-To: <20181002081041.32629-1-bibby.hsieh@mediatek.com>
References: <20181002081041.32629-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chunhui dai <chunhui.dai@mediatek.com>

This patch adds hdmi dirver suppot for both MT2701 and MT7623.
And also support other (existing or future) chips that use
the same binding and driver.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
---
 drivers/gpu/drm/mediatek/Makefile              |   3 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c            |   9 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        |  25 +++
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |   6 +
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 212 +++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |  22 ---
 6 files changed, 252 insertions(+), 25 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index 61cf0d2ab28a..82ae49c64221 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -19,7 +19,8 @@ obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
 mediatek-drm-hdmi-objs := mtk_cec.o \
 			  mtk_hdmi.o \
 			  mtk_hdmi_ddc.o \
+                          mtk_mt2701_hdmi_phy.o \
 			  mtk_mt8173_hdmi_phy.o \
 			  mtk_hdmi_phy.o
 
-obj-$(CONFIG_DRM_MEDIATEK_HDMI) += mediatek-drm-hdmi.o
\ No newline at end of file
+obj-$(CONFIG_DRM_MEDIATEK_HDMI) += mediatek-drm-hdmi.o
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index d62e685cec73..11e3644da79a 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -241,8 +241,13 @@ static void mtk_hdmi_hw_make_reg_writable(struct mtk_hdmi *hdmi, bool enable)
 	 * The ARM trusted firmware provides an API for the HDMI driver to set
 	 * this control bit to enable HDMI output in supervisor mode.
 	 */
-	arm_smccc_smc(MTK_SIP_SET_AUTHORIZED_SECURE_REG, 0x14000904, 0x80000000,
-		      0, 0, 0, 0, 0, &res);
+	if (hdmi_phy->conf && hdmi_phy->conf->tz_disabled)
+		regmap_update_bits(hdmi->sys_regmap,
+				   hdmi->sys_offset + HDMI_SYS_CFG20,
+				   0x80008005, enable ? 0x80000005 : 0x8000);
+	else
+		arm_smccc_smc(MTK_SIP_SET_AUTHORIZED_SECURE_REG, 0x14000904,
+			      0x80000000, 0, 0, 0, 0, 0, &res);
 
 	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG20,
 			   HDMI_PCLK_FREE_RUN, enable ? HDMI_PCLK_FREE_RUN : 0);
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
index d2dc50db1feb..4ef9c57ffd44 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
@@ -15,6 +15,28 @@ static const struct phy_ops mtk_hdmi_phy_dev_ops = {
 	.owner = THIS_MODULE,
 };
 
+long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long *parent_rate)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+
+	hdmi_phy->pll_rate = rate;
+	if (rate <= 74250000)
+		*parent_rate = rate;
+	else
+		*parent_rate = rate / 2;
+
+	return rate;
+}
+
+unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
+				       unsigned long parent_rate)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+
+	return hdmi_phy->pll_rate;
+}
+
 void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
 			     u32 bits)
 {
@@ -192,6 +214,9 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id mtk_hdmi_phy_match[] = {
+	{ .compatible = "mediatek,mt2701-hdmi-phy",
+	  .data = &mtk_hdmi_phy_2701_conf,
+	},
 	{ .compatible = "mediatek,mt8173-hdmi-phy",
 	  .data = &mtk_hdmi_phy_8173_conf,
 	},
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
index e346fe319621..f39b1fc66612 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
@@ -20,6 +20,7 @@
 struct mtk_hdmi_phy;
 
 struct mtk_hdmi_phy_conf {
+	bool tz_disabled;
 	const struct clk_ops *hdmi_phy_clk_ops;
 	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
 	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
@@ -47,8 +48,13 @@ void mtk_hdmi_phy_set_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
 void mtk_hdmi_phy_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
 		       u32 val, u32 mask);
 struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
+long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long *parent_rate);
+unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
+				       unsigned long parent_rate);
 
 extern struct platform_driver mtk_hdmi_phy_driver;
 extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
+extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf;
 
 #endif /* _MTK_HDMI_PHY_H */
diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
new file mode 100644
index 000000000000..fcc42dc6ea7f
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Chunhui Dai <chunhui.dai@mediatek.com>
+ */
+
+#include "mtk_hdmi_phy.h"
+
+#define HDMI_CON0	0x00
+#define RG_HDMITX_DRV_IBIAS		0
+#define RG_HDMITX_DRV_IBIAS_MASK	(0x3f << 0)
+#define RG_HDMITX_EN_SER		12
+#define RG_HDMITX_EN_SER_MASK		(0x0f << 12)
+#define RG_HDMITX_EN_SLDO		16
+#define RG_HDMITX_EN_SLDO_MASK		(0x0f << 16)
+#define RG_HDMITX_EN_PRED		20
+#define RG_HDMITX_EN_PRED_MASK		(0x0f << 20)
+#define RG_HDMITX_EN_IMP		24
+#define RG_HDMITX_EN_IMP_MASK		(0x0f << 24)
+#define RG_HDMITX_EN_DRV		28
+#define RG_HDMITX_EN_DRV_MASK		(0x0f << 28)
+
+#define HDMI_CON1	0x04
+#define RG_HDMITX_PRED_IBIAS		18
+#define RG_HDMITX_PRED_IBIAS_MASK	(0x0f << 18)
+#define RG_HDMITX_PRED_IMP		(0x01 << 22)
+#define RG_HDMITX_DRV_IMP		26
+#define RG_HDMITX_DRV_IMP_MASK		(0x3f << 26)
+
+#define HDMI_CON2	0x08
+#define RG_HDMITX_EN_TX_CKLDO		(0x01 << 0)
+#define RG_HDMITX_EN_TX_POSDIV		(0x01 << 1)
+#define RG_HDMITX_TX_POSDIV		3
+#define RG_HDMITX_TX_POSDIV_MASK	(0x03 << 3)
+#define RG_HDMITX_EN_MBIAS		(0x01 << 6)
+#define RG_HDMITX_MBIAS_LPF_EN		(0x01 << 7)
+
+#define HDMI_CON4	0x10
+#define RG_HDMITX_RESERVE_MASK		(0xffffffff << 0)
+
+#define HDMI_CON6	0x18
+#define RG_HTPLL_BR			0
+#define RG_HTPLL_BR_MASK		(0x03 << 0)
+#define RG_HTPLL_BC			2
+#define RG_HTPLL_BC_MASK		(0x03 << 2)
+#define RG_HTPLL_BP			4
+#define RG_HTPLL_BP_MASK		(0x0f << 4)
+#define RG_HTPLL_IR			8
+#define RG_HTPLL_IR_MASK		(0x0f << 8)
+#define RG_HTPLL_IC			12
+#define RG_HTPLL_IC_MASK		(0x0f << 12)
+#define RG_HTPLL_POSDIV			16
+#define RG_HTPLL_POSDIV_MASK		(0x03 << 16)
+#define RG_HTPLL_PREDIV			18
+#define RG_HTPLL_PREDIV_MASK		(0x03 << 18)
+#define RG_HTPLL_FBKSEL			20
+#define RG_HTPLL_FBKSEL_MASK		(0x03 << 20)
+#define RG_HTPLL_RLH_EN			(0x01 << 22)
+#define RG_HTPLL_FBKDIV			24
+#define RG_HTPLL_FBKDIV_MASK		(0x7f << 24)
+#define RG_HTPLL_EN			(0x01 << 31)
+
+#define HDMI_CON7	0x1c
+#define RG_HTPLL_AUTOK_EN		(0x01 << 23)
+#define RG_HTPLL_DIVEN			28
+#define RG_HTPLL_DIVEN_MASK		(0x07 << 28)
+
+static int mtk_hdmi_pll_prepare(struct clk_hw *hw)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON7, RG_HTPLL_AUTOK_EN);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_RLH_EN);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_POSDIV_MASK);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_MBIAS);
+	usleep_range(80, 100);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_EN);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_CKLDO);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
+	usleep_range(80, 100);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
+	usleep_range(80, 100);
+	return 0;
+}
+
+static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
+	usleep_range(80, 100);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_CKLDO);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_EN);
+	usleep_range(80, 100);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_MBIAS);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_POSDIV_MASK);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_RLH_EN);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON7, RG_HTPLL_AUTOK_EN);
+	usleep_range(80, 100);
+}
+
+static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+	u32 pos_div;
+
+	if (rate <= 64000000)
+		pos_div = 3;
+	else if (rate <= 12800000)
+		pos_div = 1;
+	else
+		pos_div = 1;
+
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_PREDIV_MASK);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_POSDIV_MASK);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (0x1 << RG_HTPLL_IC),
+			  RG_HTPLL_IC_MASK);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (0x1 << RG_HTPLL_IR),
+			  RG_HTPLL_IR_MASK);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON2, (pos_div << RG_HDMITX_TX_POSDIV),
+			  RG_HDMITX_TX_POSDIV_MASK);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (1 << RG_HTPLL_FBKSEL),
+			  RG_HTPLL_FBKSEL_MASK);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (19 << RG_HTPLL_FBKDIV),
+			  RG_HTPLL_FBKDIV_MASK);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON7, (0x2 << RG_HTPLL_DIVEN),
+			  RG_HTPLL_DIVEN_MASK);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (0xc << RG_HTPLL_BP),
+			  RG_HTPLL_BP_MASK);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (0x2 << RG_HTPLL_BC),
+			  RG_HTPLL_BC_MASK);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (0x1 << RG_HTPLL_BR),
+			  RG_HTPLL_BR_MASK);
+
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON1, RG_HDMITX_PRED_IMP);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON1, (0x3 << RG_HDMITX_PRED_IBIAS),
+			  RG_HDMITX_PRED_IBIAS_MASK);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_IMP_MASK);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON1, (0x28 << RG_HDMITX_DRV_IMP),
+			  RG_HDMITX_DRV_IMP_MASK);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON4, 0x28, RG_HDMITX_RESERVE_MASK);
+	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON0, (0xa << RG_HDMITX_DRV_IBIAS),
+			  RG_HDMITX_DRV_IBIAS_MASK);
+	return 0;
+}
+
+static const struct clk_ops mtk_hdmi_phy_pll_ops = {
+	.prepare = mtk_hdmi_pll_prepare,
+	.unprepare = mtk_hdmi_pll_unprepare,
+	.set_rate = mtk_hdmi_pll_set_rate,
+	.round_rate = mtk_hdmi_pll_round_rate,
+	.recalc_rate = mtk_hdmi_pll_recalc_rate,
+};
+
+static void mtk_hdmi_phy_enable_tmds(struct mtk_hdmi_phy *hdmi_phy)
+{
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON7, RG_HTPLL_AUTOK_EN);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_RLH_EN);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_POSDIV_MASK);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_MBIAS);
+	usleep_range(80, 100);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_EN);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_CKLDO);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
+	usleep_range(80, 100);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
+	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
+	usleep_range(80, 100);
+}
+
+static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
+{
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
+	usleep_range(80, 100);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_CKLDO);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_EN);
+	usleep_range(80, 100);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_MBIAS);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_POSDIV_MASK);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_RLH_EN);
+	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON7, RG_HTPLL_AUTOK_EN);
+	usleep_range(80, 100);
+}
+
+struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf = {
+	.tz_disabled = true,
+	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
+	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
+	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
+};
+
+MODULE_AUTHOR("Chunhui Dai <chunhui.dai@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek HDMI PHY Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
index 5dea03334042..ed5916b27658 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
@@ -285,28 +285,6 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long *parent_rate)
-{
-	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
-
-	hdmi_phy->pll_rate = rate;
-	if (rate <= 74250000)
-		*parent_rate = rate;
-	else
-		*parent_rate = rate / 2;
-
-	return rate;
-}
-
-static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
-					      unsigned long parent_rate)
-{
-	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
-
-	return hdmi_phy->pll_rate;
-}
-
 static const struct clk_ops mtk_hdmi_phy_pll_ops = {
 	.prepare = mtk_hdmi_pll_prepare,
 	.unprepare = mtk_hdmi_pll_unprepare,
-- 
2.12.5.2.gbdf23ab

