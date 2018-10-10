Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8253BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3422075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3422075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJJTEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:04:06 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:35752 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbeJJTEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:04:06 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id F065EBFE87;
        Wed, 10 Oct 2018 13:42:19 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 228C5C100C; Wed, 10 Oct 2018 13:42:19 +0200 (CEST)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 8F5ABC04D1;
        Wed, 10 Oct 2018 13:41:55 +0200 (CEST)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
        Mark Van den Borre <mark@fosdem.org>,
        Gerry Demaret <gerry@fosdem.org>,
        Luc Verhaegen <libv@skynet.be>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 1/4] drm/sun4i: tcon: Support an active-low DE signal with RGB interface
Date:   Wed, 10 Oct 2018 13:41:31 +0200
Message-Id: <20181010114134.8211-1-contact@paulk.fr>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some panels need an active-low data enable (DE) signal for the RGB
interface. This requires flipping a bit in the TCON0 polarity register
when setting up the mode for the RGB interface.

Add a new helper function to match specific bus flags and use it to set
the polarity inversion bit for the DE signal when required.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 28 ++++++++++++++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 3fb084f802e2..d249a462ec09 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -78,6 +78,24 @@ static int sun4i_tcon_get_pixel_depth(const struct drm_encoder *encoder)
 	return -EINVAL;
 }
 
+static bool sun4i_tcon_match_bus_flags(const struct drm_encoder *encoder,
+				       u32 bus_flags)
+{
+	struct drm_connector *connector;
+	struct drm_display_info *info;
+
+	connector = sun4i_tcon_get_connector(encoder);
+	if (!connector)
+		return false;
+
+	info = &connector->display_info;
+
+	if ((info->bus_flags & bus_flags) == bus_flags)
+		return true;
+
+	return false;
+}
+
 static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
 					  bool enabled)
 {
@@ -415,6 +433,7 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 }
 
 static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
+				     const struct drm_encoder *encoder,
 				     const struct drm_display_mode *mode)
 {
 	unsigned int bp, hsync, vsync;
@@ -474,8 +493,13 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
 
+	if (sun4i_tcon_match_bus_flags(encoder, DRM_BUS_FLAG_DE_LOW))
+		val |= SUN4I_TCON0_IO_POL_DE_NEGATIVE;
+
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
-			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
+			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |
+			   SUN4I_TCON0_IO_POL_VSYNC_POSITIVE |
+			   SUN4I_TCON0_IO_POL_DE_NEGATIVE,
 			   val);
 
 	/* Map output pins to channel 0 */
@@ -596,7 +620,7 @@ void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
 		sun4i_tcon0_mode_set_lvds(tcon, encoder, mode);
 		break;
 	case DRM_MODE_ENCODER_NONE:
-		sun4i_tcon0_mode_set_rgb(tcon, mode);
+		sun4i_tcon0_mode_set_rgb(tcon, encoder, mode);
 		sun4i_tcon_set_mux(tcon, 0, encoder);
 		break;
 	case DRM_MODE_ENCODER_TVDAC:
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index f6a071cd5a6f..708399c80561 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -113,6 +113,7 @@
 
 #define SUN4I_TCON0_IO_POL_REG			0x88
 #define SUN4I_TCON0_IO_POL_DCLK_PHASE(phase)		((phase & 3) << 28)
+#define SUN4I_TCON0_IO_POL_DE_NEGATIVE			BIT(27)
 #define SUN4I_TCON0_IO_POL_HSYNC_POSITIVE		BIT(25)
 #define SUN4I_TCON0_IO_POL_VSYNC_POSITIVE		BIT(24)
 
-- 
2.19.0

