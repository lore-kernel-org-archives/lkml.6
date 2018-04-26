Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756940AbeDZQyQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:54:16 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58080 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755871AbeDZQx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:53:59 -0400
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR RENESAS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 07/17] drm: rcar-du: Add R8A77965 support
Date: Thu, 26 Apr 2018 17:53:36 +0100
Message-Id: <20180426165346.494-8-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R8A77965 (M3-N) SoC provides VGA, HDMI and LVDS output.

This platform is unusual in that the VGA is connected to DU3 leaving DU2
unpopulated. This is reflected by the channel_mask accordingly.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index d6ebc628fc22..4d195ff8c569 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -246,6 +246,34 @@ static const struct rcar_du_device_info rcar_du_r8a7796_info = {
 	.dpll_ch =  BIT(1),
 };
 
+static const struct rcar_du_device_info rcar_du_r8a77965_info = {
+	.gen = 3,
+	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
+		  | RCAR_DU_FEATURE_VSP1_SOURCE,
+	.channel_mask = BIT(0) | BIT(1) | BIT(3),
+	.routes = {
+		/*
+		 * R8A77965 has one RGB output, one LVDS output and one HDMI
+		 * output.
+		 */
+		[RCAR_DU_OUTPUT_DPAD0] = {
+			.possible_crtcs = BIT(2),
+			.port = 0,
+		},
+		[RCAR_DU_OUTPUT_HDMI0] = {
+			.possible_crtcs = BIT(1),
+			.port = 1,
+		},
+		[RCAR_DU_OUTPUT_LVDS0] = {
+			.possible_crtcs = BIT(0),
+			.port = 2,
+		},
+	},
+	.num_lvds = 1,
+	.dpll_ch =  BIT(1),
+};
+
 static const struct rcar_du_device_info rcar_du_r8a77970_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
@@ -277,6 +305,7 @@ static const struct of_device_id rcar_du_of_table[] = {
 	{ .compatible = "renesas,du-r8a7794", .data = &rcar_du_r8a7794_info },
 	{ .compatible = "renesas,du-r8a7795", .data = &rcar_du_r8a7795_info },
 	{ .compatible = "renesas,du-r8a7796", .data = &rcar_du_r8a7796_info },
+	{ .compatible = "renesas,du-r8a77965", .data = &rcar_du_r8a77965_info },
 	{ .compatible = "renesas,du-r8a77970", .data = &rcar_du_r8a77970_info },
 	{ }
 };
-- 
2.17.0
