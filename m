Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FCEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F71206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F71206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeIENBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:01:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3878 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727991AbeIENBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:01:51 -0400
X-UUID: e63dc700b51b484191fe592149a1969b-20180905
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 913863713; Wed, 05 Sep 2018 16:32:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 5 Sep 2018 16:31:49 +0800
Received: from mtkslt209.mediatek.inc (10.21.15.96) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 5 Sep 2018 16:31:49 +0800
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
Subject: [PATCH v2 10/13] drm/mediatek: add hdmi driver for MT2701 and MT7623
Date:   Wed, 5 Sep 2018 16:31:43 +0800
Message-ID: <20180905083146.14727-11-bibby.hsieh@mediatek.com>
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

This patch adds hdmi dirver suppot for both MT2701 and MT7623.
And also support other (existing or future) chips that use
the same binding and driver.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
---
 drivers/gpu/drm/mediatek/Makefile              |   1 +
 drivers/gpu/drm/mediatek/mtk_hdmi.h            |   1 +
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        |   3 +
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 307 +++++++++++++++++++++++++
 4 files changed, 312 insertions(+)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index 7f947979d68f..bf0067b5ee6f 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -2,6 +2,7 @@
 mediatek-drm-hdmi-objs := mtk_cec.o \
 			  mtk_hdmi.o \
 			  mtk_hdmi_ddc.o \
+                          mtk_mt2701_hdmi_phy.o \
 			  mtk_mt8173_hdmi_phy.o \
 			  mtk_hdmi_phy.o
 
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.h b/drivers/gpu/drm/mediatek/mtk_hdmi.h
index a350a6c9271f..fa12eb6288f3 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.h
@@ -45,5 +45,6 @@ extern struct platform_driver mtk_cec_driver;
 extern struct platform_driver mtk_hdmi_ddc_driver;
 extern struct platform_driver mtk_hdmi_phy_driver;
 extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
+extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf;
 
 #endif /* _MTK_HDMI_CTRL_H */
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
index 82ed73575e04..606fc7a0c13b 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
@@ -135,6 +135,9 @@ static int mtk_hdmi_phy_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id mtk_hdmi_phy_match[] = {
+	{ .compatible = "mediatek,mt2701-hdmi-phy",
+	  .data = &mtk_hdmi_phy_2701_conf,
+	},
 	{ .compatible = "mediatek,mt8173-hdmi-phy",
 	  .data = &mtk_hdmi_phy_8173_conf,
 	},
diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
new file mode 100644
index 000000000000..428ef1557a14
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Chunhui Dai <chunhui.dai@mediatek.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/slab.h>
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
-- 
2.12.5.2.gbdf23ab

