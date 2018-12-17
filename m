Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D4FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404572145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbeLQMhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:37:32 -0500
Received: from gloria.sntech.de ([185.11.138.130]:57724 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732635AbeLQMhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:37:21 -0500
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gYs8s-0003o4-Tn; Mon, 17 Dec 2018 13:37:02 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org, hjc@rock-chips.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, mark.rutland@arm.com, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        linux-clk@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 06/15] drm/rockchip: analogix_dp: add support for the rk3368 variant
Date:   Mon, 17 Dec 2018 13:36:41 +0100
Message-Id: <20181217123650.6773-7-heiko@sntech.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217123650.6773-1-heiko@sntech.de>
References: <20181217123650.6773-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible and allow the driver to also not set any crtc input
on socs that only have one vop. While that was already possible
because the driver checked against the grf-reg being 0, make that
var an int as "0x0" is a valid grf address itself. So standardize
on -1 for "no setting needed".

The dp controller behaves similar to the one found on rk3288, so we
don't add a new chip_type to not overly pollute the bridge driver.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../display/rockchip/analogix_dp-rockchip.txt   |  1 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt
index 43561584c13a..d0f7a1292355 100644
--- a/Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt
@@ -3,6 +3,7 @@ Rockchip RK3288 specific extensions to the Analogix Display Port
 
 Required properties:
 - compatible: "rockchip,rk3288-dp",
+	      "rockchip,rk3368-dp",
 	      "rockchip,rk3399-edp";
 
 - reg: physical base address of the controller and length
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 080f05352195..acfcffc279ea 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -54,7 +54,7 @@
  * @chip_type: specific chip type
  */
 struct rockchip_dp_chip_data {
-	u32	lcdsel_grf_reg;
+	int	lcdsel_grf_reg;
 	u32	lcdsel_big;
 	u32	lcdsel_lit;
 	u32	chip_type;
@@ -207,9 +207,12 @@ static void rockchip_dp_drm_encoder_enable(struct drm_encoder *encoder)
 		return;
 	}
 
-	ret = regmap_write(dp->grf, dp->data->lcdsel_grf_reg, val);
-	if (ret != 0)
-		DRM_DEV_ERROR(dp->dev, "Could not write to GRF: %d\n", ret);
+	if (dp->data->lcdsel_grf_reg >= 0) {
+		ret = regmap_write(dp->grf, dp->data->lcdsel_grf_reg, val);
+		if (ret != 0)
+			DRM_DEV_ERROR(dp->dev, "Could not write to GRF: %d\n",
+				      ret);
+	}
 
 	clk_disable_unprepare(dp->grfclk);
 }
@@ -455,8 +458,14 @@ static const struct rockchip_dp_chip_data rk3288_dp = {
 	.chip_type = RK3288_DP,
 };
 
+static const struct rockchip_dp_chip_data rk3368_dp = {
+	.lcdsel_grf_reg = -1,
+	.chip_type = RK3288_DP,
+};
+
 static const struct of_device_id rockchip_dp_dt_ids[] = {
 	{.compatible = "rockchip,rk3288-dp", .data = &rk3288_dp },
+	{.compatible = "rockchip,rk3368-dp", .data = &rk3368_dp },
 	{.compatible = "rockchip,rk3399-edp", .data = &rk3399_edp },
 	{}
 };
-- 
2.19.2

