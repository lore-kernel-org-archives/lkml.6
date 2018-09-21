Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08799ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16E421545
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16E421545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389130AbeIUJPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:15:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:17142 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388084AbeIUJPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:15:25 -0400
X-UUID: 1a66865ec8a04e9ba7f755fea8ab7e3e-20180921
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1071297533; Fri, 21 Sep 2018 11:28:33 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 21 Sep 2018 11:28:26 +0800
Received: from mtkslt209.mediatek.inc (10.21.15.96) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 21 Sep 2018 11:28:26 +0800
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
Subject: [PATCH v3 02/12] drm/mediatek: move hardware register to node data
Date:   Fri, 21 Sep 2018 11:28:12 +0800
Message-ID: <20180921032822.30771-3-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.12.5.2.gbdf23ab
In-Reply-To: <20180921032822.30771-1-bibby.hsieh@mediatek.com>
References: <20180921032822.30771-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5C31CF06870BCC0054B6FC753FE6BCBA1348A3046470F3022BE71AA5E60347722000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chunhui dai <chunhui.dai@mediatek.com>

The address of register DPI_H_FRE_CON is different in different IC.
Using of_node data to find this address.

Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c      | 19 ++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h |  1 -
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index d9373e67d328..74a32833bde1 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -18,6 +18,7 @@
 #include <linux/component.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/interrupt.h>
 #include <linux/types.h>
@@ -72,6 +73,7 @@ struct mtk_dpi {
 	struct clk *tvd_clk;
 	int irq;
 	struct drm_display_mode mode;
+	const struct mtk_dpi_conf *conf;
 	enum mtk_dpi_out_color_format color_format;
 	enum mtk_dpi_out_yc_map yc_map;
 	enum mtk_dpi_out_bit_num bit_num;
@@ -117,6 +119,10 @@ struct mtk_dpi_yc_limit {
 	u16 c_bottom;
 };
 
+struct mtk_dpi_conf {
+	u32 reg_h_fre_con;
+};
+
 static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
 {
 	u32 tmp = readl(dpi->regs + offset) & ~mask;
@@ -342,7 +348,7 @@ static void mtk_dpi_config_swap_input(struct mtk_dpi *dpi, bool enable)
 
 static void mtk_dpi_config_2n_h_fre(struct mtk_dpi *dpi)
 {
-	mtk_dpi_mask(dpi, DPI_H_FRE_CON, H_FRE_2N, H_FRE_2N);
+	mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, H_FRE_2N, H_FRE_2N);
 }
 
 static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
@@ -668,6 +674,10 @@ static const struct component_ops mtk_dpi_component_ops = {
 	.unbind = mtk_dpi_unbind,
 };
 
+static const struct mtk_dpi_conf mt8173_conf = {
+	.reg_h_fre_con = 0xe0,
+};
+
 static int mtk_dpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -682,6 +692,7 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dpi->dev = dev;
+	dpi->conf = (struct mtk_dpi_conf *)of_device_get_match_data(dev);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dpi->regs = devm_ioremap_resource(dev, mem);
@@ -761,8 +772,10 @@ static int mtk_dpi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id mtk_dpi_of_ids[] = {
-	{ .compatible = "mediatek,mt8173-dpi", },
-	{}
+	{ .compatible = "mediatek,mt8173-dpi",
+	  .data = &mt8173_conf,
+	},
+	{ },
 };
 
 struct platform_driver mtk_dpi_driver = {
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
index 4b6ad4751a31..040444d7718d 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
+++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
@@ -223,6 +223,5 @@
 #define ESAV_CODE2			(0xFFF << 0)
 #define ESAV_CODE3_MSB			BIT(16)
 
-#define DPI_H_FRE_CON		0xE0
 #define H_FRE_2N			BIT(25)
 #endif /* __MTK_DPI_REGS_H */
-- 
2.12.5.2.gbdf23ab

