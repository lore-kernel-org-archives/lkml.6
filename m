Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19533C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CB420672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbeLQMht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:37:49 -0500
Received: from gloria.sntech.de ([185.11.138.130]:57702 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbeLQMhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:37:20 -0500
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gYs8t-0003o4-8O; Mon, 17 Dec 2018 13:37:03 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org, hjc@rock-chips.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, mark.rutland@arm.com, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        linux-clk@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 07/15] drm/rockchip: dw-mipi-dsi: add support for rk3368-variant
Date:   Mon, 17 Dec 2018 13:36:42 +0100
Message-Id: <20181217123650.6773-8-heiko@sntech.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217123650.6773-1-heiko@sntech.de>
References: <20181217123650.6773-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible and grf values and allow the driver to also
not select a specific crtc input on systems with only one vop.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../display/rockchip/dw_mipi_dsi_rockchip.txt |  1 +
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 25 +++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
index 6bb59ab39f2f..869fbc256d51 100644
--- a/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
@@ -5,6 +5,7 @@ Required properties:
 - #address-cells: Should be <1>.
 - #size-cells: Should be <0>.
 - compatible: "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi".
+	      "rockchip,rk3368-mipi-dsi", "snps,dw-mipi-dsi".
 	      "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi".
 - reg: Represent the physical address range of the controller.
 - interrupts: Represent the controller's interrupt to the CPU(s).
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 7ee359bcee62..041647bfce71 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -142,6 +142,11 @@
 #define RK3288_DSI0_LCDC_SEL		BIT(6)
 #define RK3288_DSI1_LCDC_SEL		BIT(9)
 
+#define RK3368_GRF_SOC_CON7		0x41c
+#define RK3368_DSI_TURNDISABLE		BIT(5)
+#define RK3368_DSI_FORCERXMODE		BIT(6)
+#define RK3368_DSI_FORCETXSTOPMODE	(0xf << 7)
+
 #define RK3399_GRF_SOC_CON20		0x6250
 #define RK3399_DSI0_LCDC_SEL		BIT(0)
 #define RK3399_DSI1_LCDC_SEL		BIT(4)
@@ -192,7 +197,7 @@ enum {
 struct rockchip_dw_dsi_chip_data {
 	u32 reg;
 
-	u32 lcdsel_grf_reg;
+	int lcdsel_grf_reg;
 	u32 lcdsel_big;
 	u32 lcdsel_lit;
 
@@ -566,7 +571,7 @@ static const struct dw_mipi_dsi_phy_ops dw_mipi_dsi_rockchip_phy_ops = {
 static void dw_mipi_dsi_rockchip_config(struct dw_mipi_dsi_rockchip *dsi,
 					int mux)
 {
-	if (dsi->cdata->lcdsel_grf_reg)
+	if (dsi->cdata->lcdsel_grf_reg >= 0)
 		regmap_write(dsi->grf_regmap, dsi->cdata->lcdsel_grf_reg,
 			mux ? dsi->cdata->lcdsel_lit : dsi->cdata->lcdsel_big);
 
@@ -1008,6 +1013,19 @@ static const struct rockchip_dw_dsi_chip_data rk3288_chip_data[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_dw_dsi_chip_data rk3368_chip_data[] = {
+	{
+		.reg = 0xff960000,
+		.lcdsel_grf_reg = -1,
+		.lanecfg1_grf_reg = RK3368_GRF_SOC_CON7,
+		.lanecfg1 = HIWORD_UPDATE(0, RK3368_DSI_TURNDISABLE |
+					     RK3368_DSI_FORCERXMODE |
+					     RK3368_DSI_FORCETXSTOPMODE),
+		.max_data_lanes = 4,
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
 	{
 		.reg = 0xff960000,
@@ -1058,6 +1076,9 @@ static const struct of_device_id dw_mipi_dsi_rockchip_dt_ids[] = {
 	{
 	 .compatible = "rockchip,rk3288-mipi-dsi",
 	 .data = &rk3288_chip_data,
+	}, {
+	 .compatible = "rockchip,rk3368-mipi-dsi",
+	 .data = &rk3368_chip_data,
 	}, {
 	 .compatible = "rockchip,rk3399-mipi-dsi",
 	 .data = &rk3399_chip_data,
-- 
2.19.2

