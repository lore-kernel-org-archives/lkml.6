Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEFEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE18820869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE18820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeIGJHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 05:07:42 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:39962 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbeIGJHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 05:07:42 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id B67F45FCDF; Fri,  7 Sep 2018 12:19:50 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Jonathan Liu <net147@gmail.com>
Subject: [PATCH v2 1/6] drm/sun4i: tcon: Pass drm_encoder * into sun4i_tcon0_mode_set_cpu
Date:   Fri,  7 Sep 2018 12:19:43 +0800
Message-Id: <20180907041948.19913-2-wens@csie.org>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20180907041948.19913-1-wens@csie.org>
References: <20180907041948.19913-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index 0cebb2db5b99..d6f9d5f3b15b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -278,9 +278,12 @@ static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
 }
 
 static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
-				     struct mipi_dsi_device *device,
+				     const struct drm_encoder *encoder,
 				     const struct drm_display_mode *mode)
 {
+	/* TODO support normal CPU interface modes */
+	struct sun6i_dsi *dsi = encoder_to_sun6i_dsi(encoder);
+	struct mipi_dsi_device *device = dsi->device;
 	u8 bpp = mipi_dsi_pixel_format_to_bpp(device->format);
 	u8 lanes = device->lanes;
 	u32 block_space, start_delay;
@@ -610,16 +613,10 @@ void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
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
2.19.0.rc1

