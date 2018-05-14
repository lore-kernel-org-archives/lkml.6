Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeENH4E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:56:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42507 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752366AbeENHwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:52:53 -0400
X-UUID: fa67a0d62a9640958df90b9d31abad49-20180514
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
Subject: [PATCH v1 1/7] drm/mediatek: move dpi private data to device
Date: Mon, 14 May 2018 15:52:37 +0800
Message-ID: <20180514075243.5442-2-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20180514075243.5442-1-bibby.hsieh@mediatek.com>
References: <20180514075243.5442-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chunhui dai <chunhui.dai@mediatek.com>

move clock factor and edge enable setting to private data.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c      | 82 ++++++++++++++++++++++++++-------
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h |  2 +-
 2 files changed, 66 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index e80a603e5fb0..993dc44368bd 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -71,11 +71,13 @@ struct mtk_dpi {
 	struct clk *tvd_clk;
 	int irq;
 	struct drm_display_mode mode;
+	const struct mtk_dpi_conf *conf;
 	enum mtk_dpi_out_color_format color_format;
 	enum mtk_dpi_out_yc_map yc_map;
 	enum mtk_dpi_out_bit_num bit_num;
 	enum mtk_dpi_out_channel_swap channel_swap;
 	bool power_sta;
+	int refcount;
 	u8 power_ctl;
 };
 
@@ -115,6 +117,12 @@ struct mtk_dpi_yc_limit {
 	u16 c_bottom;
 };
 
+struct mtk_dpi_conf {
+	unsigned int (*cal_factor)(int clock);
+	const u32 reg_h_fre_con;
+	bool edge_sel_en;
+};
+
 static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
 {
 	u32 tmp = readl(dpi->regs + offset) & ~mask;
@@ -340,7 +348,13 @@ static void mtk_dpi_config_swap_input(struct mtk_dpi *dpi, bool enable)
 
 static void mtk_dpi_config_2n_h_fre(struct mtk_dpi *dpi)
 {
-	mtk_dpi_mask(dpi, DPI_H_FRE_CON, H_FRE_2N, H_FRE_2N);
+	mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, H_FRE_2N, H_FRE_2N);
+}
+
+static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
+{
+	if (dpi->conf->edge_sel_en)
+		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
 }
 
 static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
@@ -368,6 +382,12 @@ static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
 
 static void mtk_dpi_power_off(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
 {
+	if (WARN_ON(dpi->refcount == 0))
+		return;
+
+	if (--dpi->refcount != 0)
+		return;
+
 	dpi->power_ctl &= ~pctl;
 
 	if ((dpi->power_ctl & DPI_POWER_START) ||
@@ -385,16 +405,19 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
 
 static int mtk_dpi_power_on(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
 {
-	int ret;
+	int ret = 0;
+
+	if (++dpi->refcount != 1)
+		return 0;
 
 	dpi->power_ctl |= pctl;
 
 	if (!(dpi->power_ctl & DPI_POWER_START) &&
 	    !(dpi->power_ctl & DPI_POWER_ENABLE))
-		return 0;
+		goto err_refcount;
 
 	if (dpi->power_sta)
-		return 0;
+		goto err_refcount;
 
 	ret = clk_prepare_enable(dpi->engine_clk);
 	if (ret) {
@@ -416,6 +439,8 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi, enum mtk_dpi_power_ctl pctl)
 	clk_disable_unprepare(dpi->engine_clk);
 err_eng:
 	dpi->power_ctl &= ~pctl;
+err_refcount:
+	dpi->refcount--;
 	return ret;
 }
 
@@ -433,16 +458,13 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	unsigned long pll_rate;
 	unsigned int factor;
 
+	if (!dpi) {
+		dev_err(dpi->dev, "invalid argument\n");
+		return -EINVAL;
+	}
 	/* let pll_rate can fix the valid range of tvdpll (1G~2GHz) */
 	pix_rate = 1000UL * mode->clock;
-	if (mode->clock <= 27000)
-		factor = 16 * 3;
-	else if (mode->clock <= 84000)
-		factor = 8 * 3;
-	else if (mode->clock <= 167000)
-		factor = 4 * 3;
-	else
-		factor = 2 * 3;
+	factor = dpi->conf->cal_factor(mode->clock);
 	pll_rate = pix_rate * factor;
 
 	dev_dbg(dpi->dev, "Want PLL %lu Hz, pixel clock %lu Hz\n",
@@ -518,6 +540,7 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	mtk_dpi_config_yc_map(dpi, dpi->yc_map);
 	mtk_dpi_config_color_format(dpi, dpi->color_format);
 	mtk_dpi_config_2n_h_fre(dpi);
+	mtk_dpi_config_disable_edge(dpi);
 	mtk_dpi_sw_reset(dpi, false);
 
 	return 0;
@@ -656,6 +679,31 @@ static const struct component_ops mtk_dpi_component_ops = {
 	.unbind = mtk_dpi_unbind,
 };
 
+static unsigned int mt8173_calculate_factor(int clock)
+{
+	if (clock <= 27000)
+		return 16 * 3;
+	else if (clock <= 74250)
+		return 8 * 3;
+	else if (clock <= 167000)
+		return 4 * 3;
+	else
+		return 2 * 3;
+}
+
+static const struct mtk_dpi_conf mt8173_conf = {
+	.cal_factor = mt8173_calculate_factor,
+	.reg_h_fre_con = 0xe0,
+};
+
+static const struct of_device_id mtk_dpi_of_ids[] = {
+	{ .compatible = "mediatek,mt8173-dpi",
+	  .data = &mt8173_conf,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mtk_dpi_of_ids);
+
 static int mtk_dpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -663,13 +711,18 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 	struct resource *mem;
 	struct device_node *bridge_node;
 	int comp_id;
+	const struct of_device_id *match;
 	int ret;
 
+	match = of_match_node(mtk_dpi_of_ids, dev->of_node);
+	if (!match)
+		return -ENODEV;
 	dpi = devm_kzalloc(dev, sizeof(*dpi), GFP_KERNEL);
 	if (!dpi)
 		return -ENOMEM;
 
 	dpi->dev = dev;
+	dpi->conf = (struct mtk_dpi_conf *)match->data;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dpi->regs = devm_ioremap_resource(dev, mem);
@@ -748,11 +801,6 @@ static int mtk_dpi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mtk_dpi_of_ids[] = {
-	{ .compatible = "mediatek,mt8173-dpi", },
-	{}
-};
-
 struct platform_driver mtk_dpi_driver = {
 	.probe = mtk_dpi_probe,
 	.remove = mtk_dpi_remove,
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
index 4b6ad4751a31..d9db8c4cacd7 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
+++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
@@ -223,6 +223,6 @@
 #define ESAV_CODE2			(0xFFF << 0)
 #define ESAV_CODE3_MSB			BIT(16)
 
-#define DPI_H_FRE_CON		0xE0
+#define EDGE_SEL_EN			BIT(5)
 #define H_FRE_2N			BIT(25)
 #endif /* __MTK_DPI_REGS_H */
-- 
2.12.5
