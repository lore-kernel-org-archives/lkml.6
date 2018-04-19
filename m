Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbeDSJes (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 05:34:48 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:35662 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752777AbeDSJce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 05:32:34 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jonathan Liu <net147@gmail.com>
Subject: [PATCH 1/6] drm/sun4i: tcon: Pass drm_encoder * into sun4i_tcon0_mode_set_cpu
Date: Thu, 19 Apr 2018 17:32:20 +0800
Message-Id: <20180419093225.614-2-wens@csie.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419093225.614-1-wens@csie.org>
References: <20180419093225.614-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sun4i_tcon0_mode_set_cpu() currently accepts struct mipi_dsi_device *
as its second parameter. This is derived from drm_encoder.

The DSI encoder is tied to the CPU interface mode of the TCON as a
special case. In theory, if hardware were available, we could also
support normal CPU interface modes. It is better to pass the generic
encoder instead of the specialized mipi_dsi_device, and handle the
differences inside the function.

Passing the encoder would also enable the function to pass it, or any
other data structures related to it, to other functions expecting it.
One such example would be dithering support that will be added in a
later patch, which looks at properties tied to the connector to
determine whether dithering should be enabled or not.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 08747fc3ee71..2bd53ef7d4b8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -277,9 +277,12 @@ static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
 }
 
 static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
-				     struct mipi_dsi_device *device,
+				     struct drm_encoder *encoder,
 				     const struct drm_display_mode *mode)
 {
+	/* TODO support normal CPU interface modes */
+	struct sun6i_dsi *dsi = encoder_to_sun6i_dsi(encoder);
+	struct mipi_dsi_device *device = dsi->device;
 	u8 bpp = mipi_dsi_pixel_format_to_bpp(device->format);
 	u8 lanes = device->lanes;
 	u32 block_space, start_delay;
@@ -606,16 +609,10 @@ void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
 			 const struct drm_encoder *encoder,
 			 const struct drm_display_mode *mode)
 {
-	struct sun6i_dsi *dsi;
-
 	switch (encoder->encoder_type) {
 	case DRM_MODE_ENCODER_DSI:
-		/*
-		 * This is not really elegant, but it's the "cleaner"
-		 * way I could think of...
-		 */
-		dsi = encoder_to_sun6i_dsi(encoder);
-		sun4i_tcon0_mode_set_cpu(tcon, dsi->device, mode);
+		/* DSI is tied to special case of CPU interface */
+		sun4i_tcon0_mode_set_cpu(tcon, encoder, mode);
 		break;
 	case DRM_MODE_ENCODER_LVDS:
 		sun4i_tcon0_mode_set_lvds(tcon, encoder, mode);
-- 
2.17.0
