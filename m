Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EBAECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602A82081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602A82081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbeKEDn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:43:59 -0500
Received: from mailoutvs42.siol.net ([185.57.226.233]:47303 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387509AbeKEDn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:43:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 7CD4A52126B;
        Sun,  4 Nov 2018 19:27:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LkZ_d4sL9IJ8; Sun,  4 Nov 2018 19:27:54 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id BBE865212A6;
        Sun,  4 Nov 2018 19:27:54 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 44EE15212AC;
        Sun,  4 Nov 2018 19:27:52 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v3 09/28] drm/sun4i: Rework DE2 register defines
Date:   Sun,  4 Nov 2018 19:26:46 +0100
Message-Id: <20181104182705.18047-10-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most, if not all, registers found in DE2 still exists in DE3. However,
units are on different base addresses.

To prepare for addition of DE3 support, registers macros are reworked so
they take base address as parameter.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
[rebased]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c     | 14 ++++---
 drivers/gpu/drm/sun4i/sun8i_mixer.h     | 44 +++++++++++++-------
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c  | 47 ++++++++++++++--------
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h  | 37 +++++++++--------
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c | 41 +++++++++++--------
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.h | 27 +++++--------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c  | 47 ++++++++++++++--------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h  | 23 ++++++-----
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c | 53 +++++++++++++++----------
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h | 45 ++++++++++-----------
 10 files changed, 219 insertions(+), 159 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
index 8b3d02b146b7..6129c350f7bd 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -368,6 +368,7 @@ static int sun8i_mixer_bind(struct device *dev, struc=
t device *master,
 	struct sun8i_mixer *mixer;
 	struct resource *res;
 	void __iomem *regs;
+	unsigned int base;
 	int plane_cnt;
 	int i, ret;
=20
@@ -456,6 +457,8 @@ static int sun8i_mixer_bind(struct device *dev, struc=
t device *master,
=20
 	list_add_tail(&mixer->engine.list, &drv->engine_list);
=20
+	base =3D sun8i_blender_base(mixer);
+
 	/* Reset the registers */
 	for (i =3D 0x0; i < 0x20000; i +=3D 4)
 		regmap_write(mixer->engine.regs, i, 0);
@@ -465,24 +468,25 @@ static int sun8i_mixer_bind(struct device *dev, str=
uct device *master,
 		     SUN8I_MIXER_GLOBAL_CTL_RT_EN);
=20
 	/* Set background color to black */
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_BKCOLOR,
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_BKCOLOR(base),
 		     SUN8I_MIXER_BLEND_COLOR_BLACK);
=20
 	/*
 	 * Set fill color of bottom plane to black. Generally not needed
 	 * except when VI plane is at bottom (zpos =3D 0) and enabled.
 	 */
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL,
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL(base),
 		     SUN8I_MIXER_BLEND_PIPE_CTL_FC_EN(0));
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ATTR_FCOLOR(0),
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_ATTR_FCOLOR(base, 0)=
,
 		     SUN8I_MIXER_BLEND_COLOR_BLACK);
=20
 	plane_cnt =3D mixer->cfg->vi_num + mixer->cfg->ui_num;
 	for (i =3D 0; i < plane_cnt; i++)
-		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_MODE(i),
+		regmap_write(mixer->engine.regs,
+			     SUN8I_MIXER_BLEND_MODE(base, i),
 			     SUN8I_MIXER_BLEND_MODE_DEF);
=20
-	regmap_update_bits(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL,
+	regmap_update_bits(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL(base)=
,
 			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
=20
 	return 0;
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
index 406c42e752d7..025550a1f539 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -29,20 +29,24 @@
=20
 #define SUN8I_MIXER_GLOBAL_DBUFF_ENABLE		BIT(0)
=20
-#define SUN8I_MIXER_BLEND_PIPE_CTL		0x1000
-#define SUN8I_MIXER_BLEND_ATTR_FCOLOR(x)	(0x1004 + 0x10 * (x) + 0x0)
-#define SUN8I_MIXER_BLEND_ATTR_INSIZE(x)	(0x1004 + 0x10 * (x) + 0x4)
-#define SUN8I_MIXER_BLEND_ATTR_COORD(x)		(0x1004 + 0x10 * (x) + 0x8)
-#define SUN8I_MIXER_BLEND_ROUTE			0x1080
-#define SUN8I_MIXER_BLEND_PREMULTIPLY		0x1084
-#define SUN8I_MIXER_BLEND_BKCOLOR		0x1088
-#define SUN8I_MIXER_BLEND_OUTSIZE		0x108c
-#define SUN8I_MIXER_BLEND_MODE(x)		(0x1090 + 0x04 * (x))
-#define SUN8I_MIXER_BLEND_CK_CTL		0x10b0
-#define SUN8I_MIXER_BLEND_CK_CFG		0x10b4
-#define SUN8I_MIXER_BLEND_CK_MAX(x)		(0x10c0 + 0x04 * (x))
-#define SUN8I_MIXER_BLEND_CK_MIN(x)		(0x10e0 + 0x04 * (x))
-#define SUN8I_MIXER_BLEND_OUTCTL		0x10fc
+#define DE2_BLD_BASE				0x1000
+#define DE2_CH_BASE				0x2000
+#define DE2_CH_SIZE				0x1000
+
+#define SUN8I_MIXER_BLEND_PIPE_CTL(base)	((base) + 0)
+#define SUN8I_MIXER_BLEND_ATTR_FCOLOR(base, x)	((base) + 0x4 + 0x10 * (x=
))
+#define SUN8I_MIXER_BLEND_ATTR_INSIZE(base, x)	((base) + 0x8 + 0x10 * (x=
))
+#define SUN8I_MIXER_BLEND_ATTR_COORD(base, x)	((base) + 0xc + 0x10 * (x)=
)
+#define SUN8I_MIXER_BLEND_ROUTE(base)		((base) + 0x80)
+#define SUN8I_MIXER_BLEND_PREMULTIPLY(base)	((base) + 0x84)
+#define SUN8I_MIXER_BLEND_BKCOLOR(base)		((base) + 0x88)
+#define SUN8I_MIXER_BLEND_OUTSIZE(base)		((base) + 0x8c)
+#define SUN8I_MIXER_BLEND_MODE(base, x)		((base) + 0x90 + 0x04 * (x))
+#define SUN8I_MIXER_BLEND_CK_CTL(base)		((base) + 0xb0)
+#define SUN8I_MIXER_BLEND_CK_CFG(base)		((base) + 0xb4)
+#define SUN8I_MIXER_BLEND_CK_MAX(base, x)	((base) + 0xc0 + 0x04 * (x))
+#define SUN8I_MIXER_BLEND_CK_MIN(base, x)	((base) + 0xe0 + 0x04 * (x))
+#define SUN8I_MIXER_BLEND_OUTCTL(base)		((base) + 0xfc)
=20
 #define SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK	GENMASK(12, 8)
 #define SUN8I_MIXER_BLEND_PIPE_CTL_EN(pipe)	BIT(8 + pipe)
@@ -153,5 +157,17 @@ engine_to_sun8i_mixer(struct sunxi_engine *engine)
 	return container_of(engine, struct sun8i_mixer, engine);
 }
=20
+static inline u32
+sun8i_blender_base(struct sun8i_mixer *mixer)
+{
+	return DE2_BLD_BASE;
+}
+
+static inline u32
+sun8i_channel_base(struct sun8i_mixer *mixer, int channel)
+{
+	return DE2_CH_BASE + channel * DE2_CH_SIZE;
+}
+
 const struct de2_fmt_info *sun8i_mixer_format_info(u32 format);
 #endif /* _SUN8I_MIXER_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
index 28c15c6ef1ef..e3fc8fa920fb 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -30,7 +30,10 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer *=
mixer, int channel,
 				  int overlay, bool enable, unsigned int zpos,
 				  unsigned int old_zpos)
 {
-	u32 val;
+	u32 val, bld_base, ch_base;
+
+	bld_base =3D sun8i_blender_base(mixer);
+	ch_base =3D sun8i_channel_base(mixer, channel);
=20
 	DRM_DEBUG_DRIVER("%sabling channel %d overlay %d\n",
 			 enable ? "En" : "Dis", channel, overlay);
@@ -41,17 +44,17 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer =
*mixer, int channel,
 		val =3D 0;
=20
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(channel, overlay),
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
=20
 	if (!enable || zpos !=3D old_zpos) {
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL,
+				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
 				   SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
 				   0);
=20
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE,
+				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
 				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
 				   0);
 	}
@@ -60,12 +63,13 @@ static void sun8i_ui_layer_enable(struct sun8i_mixer =
*mixer, int channel,
 		val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
=20
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL, val, val);
+				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
+				   val, val);
=20
 		val =3D channel << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
=20
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE,
+				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
 				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
 				   val);
 	}
@@ -77,12 +81,16 @@ static int sun8i_ui_layer_update_coord(struct sun8i_m=
ixer *mixer, int channel,
 {
 	struct drm_plane_state *state =3D plane->state;
 	u32 src_w, src_h, dst_w, dst_h;
+	u32 bld_base, ch_base;
 	u32 outsize, insize;
 	u32 hphase, vphase;
=20
 	DRM_DEBUG_DRIVER("Updating UI channel %d overlay %d\n",
 			 channel, overlay);
=20
+	bld_base =3D sun8i_blender_base(mixer);
+	ch_base =3D sun8i_channel_base(mixer, channel);
+
 	src_w =3D drm_rect_width(&state->src) >> 16;
 	src_h =3D drm_rect_height(&state->src) >> 16;
 	dst_w =3D drm_rect_width(&state->dst);
@@ -103,8 +111,8 @@ static int sun8i_ui_layer_update_coord(struct sun8i_m=
ixer *mixer, int channel,
 		regmap_write(mixer->engine.regs,
 			     SUN8I_MIXER_GLOBAL_SIZE,
 			     outsize);
-		regmap_write(mixer->engine.regs, SUN8I_MIXER_BLEND_OUTSIZE,
-			     outsize);
+		regmap_write(mixer->engine.regs,
+			     SUN8I_MIXER_BLEND_OUTSIZE(bld_base), outsize);
=20
 		if (state->crtc)
 			interlaced =3D state->crtc->state->adjusted_mode.flags
@@ -116,7 +124,7 @@ static int sun8i_ui_layer_update_coord(struct sun8i_m=
ixer *mixer, int channel,
 			val =3D 0;
=20
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_OUTCTL,
+				   SUN8I_MIXER_BLEND_OUTCTL(bld_base),
 				   SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
 				   val);
=20
@@ -129,10 +137,10 @@ static int sun8i_ui_layer_update_coord(struct sun8i=
_mixer *mixer, int channel,
 			 state->src.x1 >> 16, state->src.y1 >> 16);
 	DRM_DEBUG_DRIVER("Layer source size W: %d H: %d\n", src_w, src_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(channel, overlay),
+		     SUN8I_MIXER_CHAN_UI_LAYER_SIZE(ch_base, overlay),
 		     insize);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_OVL_SIZE(channel),
+		     SUN8I_MIXER_CHAN_UI_OVL_SIZE(ch_base),
 		     insize);
=20
 	if (insize !=3D outsize || hphase || vphase) {
@@ -156,10 +164,10 @@ static int sun8i_ui_layer_update_coord(struct sun8i=
_mixer *mixer, int channel,
 			 state->dst.x1, state->dst.y1);
 	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_COORD(zpos),
+		     SUN8I_MIXER_BLEND_ATTR_COORD(bld_base, zpos),
 		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_INSIZE(zpos),
+		     SUN8I_MIXER_BLEND_ATTR_INSIZE(bld_base, zpos),
 		     outsize);
=20
 	return 0;
@@ -170,7 +178,9 @@ static int sun8i_ui_layer_update_formats(struct sun8i=
_mixer *mixer, int channel,
 {
 	struct drm_plane_state *state =3D plane->state;
 	const struct de2_fmt_info *fmt_info;
-	u32 val;
+	u32 val, ch_base;
+
+	ch_base =3D sun8i_channel_base(mixer, channel);
=20
 	fmt_info =3D sun8i_mixer_format_info(state->fb->format->format);
 	if (!fmt_info || !fmt_info->rgb) {
@@ -180,7 +190,7 @@ static int sun8i_ui_layer_update_formats(struct sun8i=
_mixer *mixer, int channel,
=20
 	val =3D fmt_info->de2_fmt << SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSE=
T;
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(channel, overlay),
+			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val);
=20
 	return 0;
@@ -193,8 +203,11 @@ static int sun8i_ui_layer_update_buffer(struct sun8i=
_mixer *mixer, int channel,
 	struct drm_framebuffer *fb =3D state->fb;
 	struct drm_gem_cma_object *gem;
 	dma_addr_t paddr;
+	u32 ch_base;
 	int bpp;
=20
+	ch_base =3D sun8i_channel_base(mixer, channel);
+
 	/* Get the physical address of the buffer in memory */
 	gem =3D drm_fb_cma_get_gem_obj(fb, 0);
=20
@@ -211,13 +224,13 @@ static int sun8i_ui_layer_update_buffer(struct sun8=
i_mixer *mixer, int channel,
 	/* Set the line width */
 	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_PITCH(channel, overlay),
+		     SUN8I_MIXER_CHAN_UI_LAYER_PITCH(ch_base, overlay),
 		     fb->pitches[0]);
=20
 	DRM_DEBUG_DRIVER("Setting buffer address to %pad\n", &paddr);
=20
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(channel, overlay),
+		     SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(ch_base, overlay),
 		     lower_32_bits(paddr));
=20
 	return 0;
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.h
index 123b15ea9918..f4389cf0ba20 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.h
@@ -18,23 +18,26 @@
=20
 #include <drm/drm_plane.h>
=20
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch, layer) \
-			(0x2000 + 0x1000 * (ch) + 0x20 * (layer) + 0x0)
-#define SUN8I_MIXER_CHAN_UI_LAYER_SIZE(ch, layer) \
-			(0x2000 + 0x1000 * (ch) + 0x20 * (layer) + 0x4)
-#define SUN8I_MIXER_CHAN_UI_LAYER_COORD(ch, layer) \
-			(0x2000 + 0x1000 * (ch) + 0x20 * (layer) + 0x8)
-#define SUN8I_MIXER_CHAN_UI_LAYER_PITCH(ch, layer) \
-			(0x2000 + 0x1000 * (ch) + 0x20 * (layer) + 0xc)
-#define SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(ch, layer) \
-			(0x2000 + 0x1000 * (ch) + 0x20 * (layer) + 0x10)
-#define SUN8I_MIXER_CHAN_UI_LAYER_BOT_LADDR(ch, layer) \
-			(0x2000 + 0x1000 * (ch) + 0x20 * (layer) + 0x14)
-#define SUN8I_MIXER_CHAN_UI_LAYER_FCOLOR(ch, layer) \
-			(0x2000 + 0x1000 * (ch) + 0x20 * (layer) + 0x18)
-#define SUN8I_MIXER_CHAN_UI_TOP_HADDR(ch)	(0x2000 + 0x1000 * (ch) + 0x80=
)
-#define SUN8I_MIXER_CHAN_UI_BOT_HADDR(ch)	(0x2000 + 0x1000 * (ch) + 0x84=
)
-#define SUN8I_MIXER_CHAN_UI_OVL_SIZE(ch)	(0x2000 + 0x1000 * (ch) + 0x88)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR(base, layer) \
+			((base) + 0x20 * (layer) + 0x0)
+#define SUN8I_MIXER_CHAN_UI_LAYER_SIZE(base, layer) \
+			((base) + 0x20 * (layer) + 0x4)
+#define SUN8I_MIXER_CHAN_UI_LAYER_COORD(base, layer) \
+			((base) + 0x20 * (layer) + 0x8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_PITCH(base, layer) \
+			((base) + 0x20 * (layer) + 0xc)
+#define SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(base, layer) \
+			((base) + 0x20 * (layer) + 0x10)
+#define SUN8I_MIXER_CHAN_UI_LAYER_BOT_LADDR(base, layer) \
+			((base) + 0x20 * (layer) + 0x14)
+#define SUN8I_MIXER_CHAN_UI_LAYER_FCOLOR(base, layer) \
+			((base) + 0x20 * (layer) + 0x18)
+#define SUN8I_MIXER_CHAN_UI_TOP_HADDR(base) \
+			((base) + 0x80)
+#define SUN8I_MIXER_CHAN_UI_BOT_HADDR(base) \
+			((base) + 0x84)
+#define SUN8I_MIXER_CHAN_UI_OVL_SIZE(base) \
+			((base) + 0x88)
=20
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN		BIT(0)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK	GENMASK(2, 1)
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c b/drivers/gpu/drm/su=
n4i/sun8i_ui_scaler.c
index 6bb2aa164c8e..698401ecb53d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
@@ -10,6 +10,7 @@
  */
=20
 #include "sun8i_ui_scaler.h"
+#include "sun8i_vi_scaler.h"
=20
 static const u32 lan2coefftab16[240] =3D {
 	0x00004000, 0x00033ffe, 0x00063efc, 0x000a3bfb,
@@ -88,6 +89,14 @@ static const u32 lan2coefftab16[240] =3D {
 	0x0b1c1603, 0x0d1c1502, 0x0e1d1401, 0x0f1d1301,
 };
=20
+static u32 sun8i_ui_scaler_base(struct sun8i_mixer *mixer, int channel)
+{
+	int vi_num =3D mixer->cfg->vi_num;
+
+	return DE2_VI_SCALER_UNIT_BASE + DE2_VI_SCALER_UNIT_SIZE * vi_num +
+	       DE2_UI_SCALER_UNIT_SIZE * (channel - vi_num);
+}
+
 static int sun8i_ui_scaler_coef_index(unsigned int step)
 {
 	unsigned int scale, int_part, float_part;
@@ -114,33 +123,35 @@ static int sun8i_ui_scaler_coef_index(unsigned int =
step)
=20
 void sun8i_ui_scaler_enable(struct sun8i_mixer *mixer, int layer, bool e=
nable)
 {
-	int vi_cnt =3D mixer->cfg->vi_num;
-	u32 val;
+	u32 val, base;
=20
-	if (WARN_ON(layer < vi_cnt))
+	if (WARN_ON(layer < mixer->cfg->vi_num))
 		return;
=20
+	base =3D sun8i_ui_scaler_base(mixer, layer);
+
 	if (enable)
 		val =3D SUN8I_SCALER_GSU_CTRL_EN |
 		      SUN8I_SCALER_GSU_CTRL_COEFF_RDY;
 	else
 		val =3D 0;
=20
-	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_GSU_CTRL(vi_cnt, layer - vi_cnt), val);
+	regmap_write(mixer->engine.regs, SUN8I_SCALER_GSU_CTRL(base), val);
 }
=20
 void sun8i_ui_scaler_setup(struct sun8i_mixer *mixer, int layer,
 			   u32 src_w, u32 src_h, u32 dst_w, u32 dst_h,
 			   u32 hscale, u32 vscale, u32 hphase, u32 vphase)
 {
-	int vi_cnt =3D mixer->cfg->vi_num;
 	u32 insize, outsize;
 	int i, offset;
+	u32 base;
=20
-	if (WARN_ON(layer < vi_cnt))
+	if (WARN_ON(layer < mixer->cfg->vi_num))
 		return;
=20
+	base =3D sun8i_ui_scaler_base(mixer, layer);
+
 	hphase <<=3D SUN8I_UI_SCALER_PHASE_FRAC - 16;
 	vphase <<=3D SUN8I_UI_SCALER_PHASE_FRAC - 16;
 	hscale <<=3D SUN8I_UI_SCALER_SCALE_FRAC - 16;
@@ -149,24 +160,22 @@ void sun8i_ui_scaler_setup(struct sun8i_mixer *mixe=
r, int layer,
 	insize =3D SUN8I_UI_SCALER_SIZE(src_w, src_h);
 	outsize =3D SUN8I_UI_SCALER_SIZE(dst_w, dst_h);
=20
-	layer -=3D vi_cnt;
-
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_GSU_OUTSIZE(vi_cnt, layer), outsize);
+		     SUN8I_SCALER_GSU_OUTSIZE(base), outsize);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_GSU_INSIZE(vi_cnt, layer), insize);
+		     SUN8I_SCALER_GSU_INSIZE(base), insize);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_GSU_HSTEP(vi_cnt, layer), hscale);
+		     SUN8I_SCALER_GSU_HSTEP(base), hscale);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_GSU_VSTEP(vi_cnt, layer), vscale);
+		     SUN8I_SCALER_GSU_VSTEP(base), vscale);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_GSU_HPHASE(vi_cnt, layer), hphase);
+		     SUN8I_SCALER_GSU_HPHASE(base), hphase);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_GSU_VPHASE(vi_cnt, layer), vphase);
+		     SUN8I_SCALER_GSU_VPHASE(base), vphase);
 	offset =3D sun8i_ui_scaler_coef_index(hscale) *
 			SUN8I_UI_SCALER_COEFF_COUNT;
 	for (i =3D 0; i < SUN8I_UI_SCALER_COEFF_COUNT; i++)
 		regmap_write(mixer->engine.regs,
-			     SUN8I_SCALER_GSU_HCOEFF(vi_cnt, layer, i),
+			     SUN8I_SCALER_GSU_HCOEFF(base, i),
 			     lan2coefftab16[offset + i]);
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.h b/drivers/gpu/drm/su=
n4i/sun8i_ui_scaler.h
index 86295be8be78..6b4bc1ff3e2c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.h
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.h
@@ -11,6 +11,8 @@
=20
 #include "sun8i_mixer.h"
=20
+#define DE2_UI_SCALER_UNIT_SIZE 0x10000
+
 /* this two macros assumes 16 fractional bits which is standard in DRM *=
/
 #define SUN8I_UI_SCALER_SCALE_MIN		1
 #define SUN8I_UI_SCALER_SCALE_MAX		((1UL << 20) - 1)
@@ -20,23 +22,14 @@
 #define SUN8I_UI_SCALER_COEFF_COUNT		16
 #define SUN8I_UI_SCALER_SIZE(w, h)		(((h) - 1) << 16 | ((w) - 1))
=20
-#define SUN8I_SCALER_GSU_CTRL(vi_cnt, ui_idx) \
-	(0x20000 + 0x20000 * (vi_cnt) + 0x10000 * (ui_idx) + 0x0)
-#define SUN8I_SCALER_GSU_OUTSIZE(vi_cnt, ui_idx) \
-	(0x20000 + 0x20000 * (vi_cnt) + 0x10000 * (ui_idx) + 0x40)
-#define SUN8I_SCALER_GSU_INSIZE(vi_cnt, ui_idx) \
-	(0x20000 + 0x20000 * (vi_cnt) + 0x10000 * (ui_idx) + 0x80)
-#define SUN8I_SCALER_GSU_HSTEP(vi_cnt, ui_idx) \
-	(0x20000 + 0x20000 * (vi_cnt) + 0x10000 * (ui_idx) + 0x88)
-#define SUN8I_SCALER_GSU_VSTEP(vi_cnt, ui_idx) \
-	(0x20000 + 0x20000 * (vi_cnt) + 0x10000 * (ui_idx) + 0x8c)
-#define SUN8I_SCALER_GSU_HPHASE(vi_cnt, ui_idx) \
-	(0x20000 + 0x20000 * (vi_cnt) + 0x10000 * (ui_idx) + 0x90)
-#define SUN8I_SCALER_GSU_VPHASE(vi_cnt, ui_idx) \
-	(0x20000 + 0x20000 * (vi_cnt) + 0x10000 * (ui_idx) + 0x98)
-#define SUN8I_SCALER_GSU_HCOEFF(vi_cnt, ui_idx, index) \
-	(0x20000 + 0x20000 * (vi_cnt) + 0x10000 * (ui_idx) + 0x200 + \
-	0x4 * (index))
+#define SUN8I_SCALER_GSU_CTRL(base)		((base) + 0x0)
+#define SUN8I_SCALER_GSU_OUTSIZE(base)		((base) + 0x40)
+#define SUN8I_SCALER_GSU_INSIZE(base)		((base) + 0x80)
+#define SUN8I_SCALER_GSU_HSTEP(base)		((base) + 0x88)
+#define SUN8I_SCALER_GSU_VSTEP(base)		((base) + 0x8c)
+#define SUN8I_SCALER_GSU_HPHASE(base)		((base) + 0x90)
+#define SUN8I_SCALER_GSU_VPHASE(base)		((base) + 0x98)
+#define SUN8I_SCALER_GSU_HCOEFF(base, index)	((base) + 0x200 + 0x4 * (in=
dex))
=20
 #define SUN8I_SCALER_GSU_CTRL_EN		BIT(0)
 #define SUN8I_SCALER_GSU_CTRL_COEFF_RDY		BIT(4)
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index f4fe97813f94..79811eae3735 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -24,7 +24,10 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer *=
mixer, int channel,
 				  int overlay, bool enable, unsigned int zpos,
 				  unsigned int old_zpos)
 {
-	u32 val;
+	u32 val, bld_base, ch_base;
+
+	bld_base =3D sun8i_blender_base(mixer);
+	ch_base =3D sun8i_channel_base(mixer, channel);
=20
 	DRM_DEBUG_DRIVER("%sabling VI channel %d overlay %d\n",
 			 enable ? "En" : "Dis", channel, overlay);
@@ -35,17 +38,17 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer =
*mixer, int channel,
 		val =3D 0;
=20
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(channel, overlay),
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
=20
 	if (!enable || zpos !=3D old_zpos) {
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL,
+				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
 				   SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
 				   0);
=20
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE,
+				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
 				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
 				   0);
 	}
@@ -54,12 +57,13 @@ static void sun8i_vi_layer_enable(struct sun8i_mixer =
*mixer, int channel,
 		val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
=20
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_PIPE_CTL, val, val);
+				   SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
+				   val, val);
=20
 		val =3D channel << SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(zpos);
=20
 		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_BLEND_ROUTE,
+				   SUN8I_MIXER_BLEND_ROUTE(bld_base),
 				   SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(zpos),
 				   val);
 	}
@@ -72,6 +76,7 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mix=
er *mixer, int channel,
 	struct drm_plane_state *state =3D plane->state;
 	const struct drm_format_info *format =3D state->fb->format;
 	u32 src_w, src_h, dst_w, dst_h;
+	u32 bld_base, ch_base;
 	u32 outsize, insize;
 	u32 hphase, vphase;
 	bool subsampled;
@@ -79,6 +84,9 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mix=
er *mixer, int channel,
 	DRM_DEBUG_DRIVER("Updating VI channel %d overlay %d\n",
 			 channel, overlay);
=20
+	bld_base =3D sun8i_blender_base(mixer);
+	ch_base =3D sun8i_channel_base(mixer, channel);
+
 	src_w =3D drm_rect_width(&state->src) >> 16;
 	src_h =3D drm_rect_height(&state->src) >> 16;
 	dst_w =3D drm_rect_width(&state->dst);
@@ -115,10 +123,10 @@ static int sun8i_vi_layer_update_coord(struct sun8i=
_mixer *mixer, int channel,
 			 (state->src.y1 >> 16) & ~(format->vsub - 1));
 	DRM_DEBUG_DRIVER("Layer source size W: %d H: %d\n", src_w, src_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_VI_LAYER_SIZE(channel, overlay),
+		     SUN8I_MIXER_CHAN_VI_LAYER_SIZE(ch_base, overlay),
 		     insize);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_CHAN_VI_OVL_SIZE(channel),
+		     SUN8I_MIXER_CHAN_VI_OVL_SIZE(ch_base),
 		     insize);
=20
 	/*
@@ -149,10 +157,10 @@ static int sun8i_vi_layer_update_coord(struct sun8i=
_mixer *mixer, int channel,
 			 state->dst.x1, state->dst.y1);
 	DRM_DEBUG_DRIVER("Layer destination size W: %d H: %d\n", dst_w, dst_h);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_COORD(zpos),
+		     SUN8I_MIXER_BLEND_ATTR_COORD(bld_base, zpos),
 		     SUN8I_MIXER_COORD(state->dst.x1, state->dst.y1));
 	regmap_write(mixer->engine.regs,
-		     SUN8I_MIXER_BLEND_ATTR_INSIZE(zpos),
+		     SUN8I_MIXER_BLEND_ATTR_INSIZE(bld_base, zpos),
 		     outsize);
=20
 	return 0;
@@ -163,7 +171,9 @@ static int sun8i_vi_layer_update_formats(struct sun8i=
_mixer *mixer, int channel,
 {
 	struct drm_plane_state *state =3D plane->state;
 	const struct de2_fmt_info *fmt_info;
-	u32 val;
+	u32 val, ch_base;
+
+	ch_base =3D sun8i_channel_base(mixer, channel);
=20
 	fmt_info =3D sun8i_mixer_format_info(state->fb->format->format);
 	if (!fmt_info) {
@@ -173,7 +183,7 @@ static int sun8i_vi_layer_update_formats(struct sun8i=
_mixer *mixer, int channel,
=20
 	val =3D fmt_info->de2_fmt << SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSE=
T;
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(channel, overlay),
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK, val);
=20
 	if (fmt_info->csc !=3D SUN8I_CSC_MODE_OFF) {
@@ -189,7 +199,7 @@ static int sun8i_vi_layer_update_formats(struct sun8i=
_mixer *mixer, int channel,
 		val =3D 0;
=20
 	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(channel, overlay),
+			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE, val);
=20
 	return 0;
@@ -204,8 +214,11 @@ static int sun8i_vi_layer_update_buffer(struct sun8i=
_mixer *mixer, int channel,
 	struct drm_gem_cma_object *gem;
 	u32 dx, dy, src_x, src_y;
 	dma_addr_t paddr;
+	u32 ch_base;
 	int i;
=20
+	ch_base =3D sun8i_channel_base(mixer, channel);
+
 	/* Adjust x and y to be dividable by subsampling factor */
 	src_x =3D (state->src.x1 >> 16) & ~(format->hsub - 1);
 	src_y =3D (state->src.y1 >> 16) & ~(format->vsub - 1);
@@ -235,17 +248,17 @@ static int sun8i_vi_layer_update_buffer(struct sun8=
i_mixer *mixer, int channel,
 		DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
 				 i + 1, fb->pitches[i]);
 		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_CHAN_VI_LAYER_PITCH(channel,
+			     SUN8I_MIXER_CHAN_VI_LAYER_PITCH(ch_base,
 							     overlay, i),
-	       fb->pitches[i]);
+			     fb->pitches[i]);
=20
 		DRM_DEBUG_DRIVER("Setting %d. buffer address to %pad\n",
 				 i + 1, &paddr);
=20
 		regmap_write(mixer->engine.regs,
-			     SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(channel,
+			     SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(ch_base,
 								 overlay, i),
-	       lower_32_bits(paddr));
+			     lower_32_bits(paddr));
 	}
=20
 	return 0;
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.h
index 6996627a0a76..46f0237c17bb 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
@@ -12,17 +12,18 @@
=20
 #include <drm/drm_plane.h>
=20
-#define SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch, layer) \
-		(0x2000 + 0x1000 * (ch) + 0x30 * (layer) + 0x0)
-#define SUN8I_MIXER_CHAN_VI_LAYER_SIZE(ch, layer) \
-		(0x2000 + 0x1000 * (ch) + 0x30 * (layer) + 0x4)
-#define SUN8I_MIXER_CHAN_VI_LAYER_COORD(ch, layer) \
-		(0x2000 + 0x1000 * (ch) + 0x30 * (layer) + 0x8)
-#define SUN8I_MIXER_CHAN_VI_LAYER_PITCH(ch, layer, plane) \
-		(0x2000 + 0x1000 * (ch) + 0x30 * (layer) + 0xc + 4 * (plane))
-#define SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(ch, layer, plane) \
-		(0x2000 + 0x1000 * (ch) + 0x30 * (layer) + 0x18 + 4 * (plane))
-#define SUN8I_MIXER_CHAN_VI_OVL_SIZE(ch)	(0x2000 + 0x1000 * (ch) + 0xe8)
+#define SUN8I_MIXER_CHAN_VI_LAYER_ATTR(base, layer) \
+		((base) + 0x30 * (layer) + 0x0)
+#define SUN8I_MIXER_CHAN_VI_LAYER_SIZE(base, layer) \
+		((base) + 0x30 * (layer) + 0x4)
+#define SUN8I_MIXER_CHAN_VI_LAYER_COORD(base, layer) \
+		((base) + 0x30 * (layer) + 0x8)
+#define SUN8I_MIXER_CHAN_VI_LAYER_PITCH(base, layer, plane) \
+		((base) + 0x30 * (layer) + 0xc + 4 * (plane))
+#define SUN8I_MIXER_CHAN_VI_LAYER_TOP_LADDR(base, layer, plane) \
+		((base) + 0x30 * (layer) + 0x18 + 4 * (plane))
+#define SUN8I_MIXER_CHAN_VI_OVL_SIZE(base) \
+		((base) + 0xe8)
=20
 #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN		BIT(0)
 /* RGB mode should be set for RGB formats and cleared for YCbCr */
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c b/drivers/gpu/drm/su=
n4i/sun8i_vi_scaler.c
index d3f1acb234b7..9f6834c143d7 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
@@ -833,6 +833,11 @@ static const u32 bicubic4coefftab32[480] =3D {
 	0x1012110d, 0x1012110d, 0x1013110c, 0x1013110c,
 };
=20
+static u32 sun8i_vi_scaler_base(struct sun8i_mixer *mixer, int channel)
+{
+	return DE2_VI_SCALER_UNIT_BASE + DE2_VI_SCALER_UNIT_SIZE * channel;
+}
+
 static int sun8i_vi_scaler_coef_index(unsigned int step)
 {
 	unsigned int scale, int_part, float_part;
@@ -857,7 +862,7 @@ static int sun8i_vi_scaler_coef_index(unsigned int st=
ep)
 	}
 }
=20
-static void sun8i_vi_scaler_set_coeff(struct regmap *map, int layer,
+static void sun8i_vi_scaler_set_coeff(struct regmap *map, u32 base,
 				      u32 hstep, u32 vstep,
 				      const struct drm_format_info *format)
 {
@@ -877,29 +882,31 @@ static void sun8i_vi_scaler_set_coeff(struct regmap=
 *map, int layer,
 	offset =3D sun8i_vi_scaler_coef_index(hstep) *
 			SUN8I_VI_SCALER_COEFF_COUNT;
 	for (i =3D 0; i < SUN8I_VI_SCALER_COEFF_COUNT; i++) {
-		regmap_write(map, SUN8I_SCALER_VSU_YHCOEFF0(layer, i),
+		regmap_write(map, SUN8I_SCALER_VSU_YHCOEFF0(base, i),
 			     lan3coefftab32_left[offset + i]);
-		regmap_write(map, SUN8I_SCALER_VSU_YHCOEFF1(layer, i),
+		regmap_write(map, SUN8I_SCALER_VSU_YHCOEFF1(base, i),
 			     lan3coefftab32_right[offset + i]);
-		regmap_write(map, SUN8I_SCALER_VSU_CHCOEFF0(layer, i),
+		regmap_write(map, SUN8I_SCALER_VSU_CHCOEFF0(base, i),
 			     ch_left[offset + i]);
-		regmap_write(map, SUN8I_SCALER_VSU_CHCOEFF1(layer, i),
+		regmap_write(map, SUN8I_SCALER_VSU_CHCOEFF1(base, i),
 			     ch_right[offset + i]);
 	}
=20
 	offset =3D sun8i_vi_scaler_coef_index(hstep) *
 			SUN8I_VI_SCALER_COEFF_COUNT;
 	for (i =3D 0; i < SUN8I_VI_SCALER_COEFF_COUNT; i++) {
-		regmap_write(map, SUN8I_SCALER_VSU_YVCOEFF(layer, i),
+		regmap_write(map, SUN8I_SCALER_VSU_YVCOEFF(base, i),
 			     lan2coefftab32[offset + i]);
-		regmap_write(map, SUN8I_SCALER_VSU_CVCOEFF(layer, i),
+		regmap_write(map, SUN8I_SCALER_VSU_CVCOEFF(base, i),
 			     cy[offset + i]);
 	}
 }
=20
 void sun8i_vi_scaler_enable(struct sun8i_mixer *mixer, int layer, bool e=
nable)
 {
-	u32 val;
+	u32 val, base;
+
+	base =3D sun8i_vi_scaler_base(mixer, layer);
=20
 	if (enable)
 		val =3D SUN8I_SCALER_VSU_CTRL_EN |
@@ -907,7 +914,8 @@ void sun8i_vi_scaler_enable(struct sun8i_mixer *mixer=
, int layer, bool enable)
 	else
 		val =3D 0;
=20
-	regmap_write(mixer->engine.regs, SUN8I_SCALER_VSU_CTRL(layer), val);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_SCALER_VSU_CTRL(base), val);
 }
=20
 void sun8i_vi_scaler_setup(struct sun8i_mixer *mixer, int layer,
@@ -917,6 +925,9 @@ void sun8i_vi_scaler_setup(struct sun8i_mixer *mixer,=
 int layer,
 {
 	u32 chphase, cvphase;
 	u32 insize, outsize;
+	u32 base;
+
+	base =3D sun8i_vi_scaler_base(mixer, layer);
=20
 	hphase <<=3D SUN8I_VI_SCALER_PHASE_FRAC - 16;
 	vphase <<=3D SUN8I_VI_SCALER_PHASE_FRAC - 16;
@@ -941,31 +952,31 @@ void sun8i_vi_scaler_setup(struct sun8i_mixer *mixe=
r, int layer,
 	}
=20
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_OUTSIZE(layer), outsize);
+		     SUN8I_SCALER_VSU_OUTSIZE(base), outsize);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_YINSIZE(layer), insize);
+		     SUN8I_SCALER_VSU_YINSIZE(base), insize);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_YHSTEP(layer), hscale);
+		     SUN8I_SCALER_VSU_YHSTEP(base), hscale);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_YVSTEP(layer), vscale);
+		     SUN8I_SCALER_VSU_YVSTEP(base), vscale);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_YHPHASE(layer), hphase);
+		     SUN8I_SCALER_VSU_YHPHASE(base), hphase);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_YVPHASE(layer), vphase);
+		     SUN8I_SCALER_VSU_YVPHASE(base), vphase);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_CINSIZE(layer),
+		     SUN8I_SCALER_VSU_CINSIZE(base),
 		     SUN8I_VI_SCALER_SIZE(src_w / format->hsub,
 					  src_h / format->vsub));
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_CHSTEP(layer),
+		     SUN8I_SCALER_VSU_CHSTEP(base),
 		     hscale / format->hsub);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_CVSTEP(layer),
+		     SUN8I_SCALER_VSU_CVSTEP(base),
 		     vscale / format->vsub);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_CHPHASE(layer), chphase);
+		     SUN8I_SCALER_VSU_CHPHASE(base), chphase);
 	regmap_write(mixer->engine.regs,
-		     SUN8I_SCALER_VSU_CVPHASE(layer), cvphase);
-	sun8i_vi_scaler_set_coeff(mixer->engine.regs, layer,
+		     SUN8I_SCALER_VSU_CVPHASE(base), cvphase);
+	sun8i_vi_scaler_set_coeff(mixer->engine.regs, base,
 				  hscale, vscale, format);
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h b/drivers/gpu/drm/su=
n4i/sun8i_vi_scaler.h
index a595ab643a5a..f3de87122f07 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
@@ -12,6 +12,9 @@
 #include <drm/drm_fourcc.h>
 #include "sun8i_mixer.h"
=20
+#define DE2_VI_SCALER_UNIT_BASE 0x20000
+#define DE2_VI_SCALER_UNIT_SIZE 0x20000
+
 /* this two macros assumes 16 fractional bits which is standard in DRM *=
/
 #define SUN8I_VI_SCALER_SCALE_MIN		1
 #define SUN8I_VI_SCALER_SCALE_MAX		((1UL << 20) - 1)
@@ -21,30 +24,24 @@
 #define SUN8I_VI_SCALER_COEFF_COUNT		32
 #define SUN8I_VI_SCALER_SIZE(w, h)		(((h) - 1) << 16 | ((w) - 1))
=20
-#define SUN8I_SCALER_VSU_CTRL(ch)	(0x20000 + 0x20000 * (ch) + 0x0)
-#define SUN8I_SCALER_VSU_OUTSIZE(ch)	(0x20000 + 0x20000 * (ch) + 0x40)
-#define SUN8I_SCALER_VSU_YINSIZE(ch)	(0x20000 + 0x20000 * (ch) + 0x80)
-#define SUN8I_SCALER_VSU_YHSTEP(ch)	(0x20000 + 0x20000 * (ch) + 0x88)
-#define SUN8I_SCALER_VSU_YVSTEP(ch)	(0x20000 + 0x20000 * (ch) + 0x8c)
-#define SUN8I_SCALER_VSU_YHPHASE(ch)	(0x20000 + 0x20000 * (ch) + 0x90)
-#define SUN8I_SCALER_VSU_YVPHASE(ch)	(0x20000 + 0x20000 * (ch) + 0x98)
-#define SUN8I_SCALER_VSU_CINSIZE(ch)	(0x20000 + 0x20000 * (ch) + 0xc0)
-#define SUN8I_SCALER_VSU_CHSTEP(ch)	(0x20000 + 0x20000 * (ch) + 0xc8)
-#define SUN8I_SCALER_VSU_CVSTEP(ch)	(0x20000 + 0x20000 * (ch) + 0xcc)
-#define SUN8I_SCALER_VSU_CHPHASE(ch)	(0x20000 + 0x20000 * (ch) + 0xd0)
-#define SUN8I_SCALER_VSU_CVPHASE(ch)	(0x20000 + 0x20000 * (ch) + 0xd8)
-#define SUN8I_SCALER_VSU_YHCOEFF0(ch, i) \
-	(0x20000 + 0x20000 * (ch) + 0x200 + 0x4 * (i))
-#define SUN8I_SCALER_VSU_YHCOEFF1(ch, i) \
-	(0x20000 + 0x20000 * (ch) + 0x300 + 0x4 * (i))
-#define SUN8I_SCALER_VSU_YVCOEFF(ch, i) \
-	(0x20000 + 0x20000 * (ch) + 0x400 + 0x4 * (i))
-#define SUN8I_SCALER_VSU_CHCOEFF0(ch, i) \
-	(0x20000 + 0x20000 * (ch) + 0x600 + 0x4 * (i))
-#define SUN8I_SCALER_VSU_CHCOEFF1(ch, i) \
-	(0x20000 + 0x20000 * (ch) + 0x700 + 0x4 * (i))
-#define SUN8I_SCALER_VSU_CVCOEFF(ch, i) \
-	(0x20000 + 0x20000 * (ch) + 0x800 + 0x4 * (i))
+#define SUN8I_SCALER_VSU_CTRL(base)		((base) + 0x0)
+#define SUN8I_SCALER_VSU_OUTSIZE(base)		((base) + 0x40)
+#define SUN8I_SCALER_VSU_YINSIZE(base)		((base) + 0x80)
+#define SUN8I_SCALER_VSU_YHSTEP(base)		((base) + 0x88)
+#define SUN8I_SCALER_VSU_YVSTEP(base)		((base) + 0x8c)
+#define SUN8I_SCALER_VSU_YHPHASE(base)		((base) + 0x90)
+#define SUN8I_SCALER_VSU_YVPHASE(base)		((base) + 0x98)
+#define SUN8I_SCALER_VSU_CINSIZE(base)		((base) + 0xc0)
+#define SUN8I_SCALER_VSU_CHSTEP(base)		((base) + 0xc8)
+#define SUN8I_SCALER_VSU_CVSTEP(base)		((base) + 0xcc)
+#define SUN8I_SCALER_VSU_CHPHASE(base)		((base) + 0xd0)
+#define SUN8I_SCALER_VSU_CVPHASE(base)		((base) + 0xd8)
+#define SUN8I_SCALER_VSU_YHCOEFF0(base, i)	((base) + 0x200 + 0x4 * (i))
+#define SUN8I_SCALER_VSU_YHCOEFF1(base, i)	((base) + 0x300 + 0x4 * (i))
+#define SUN8I_SCALER_VSU_YVCOEFF(base, i)	((base) + 0x400 + 0x4 * (i))
+#define SUN8I_SCALER_VSU_CHCOEFF0(base, i)	((base) + 0x600 + 0x4 * (i))
+#define SUN8I_SCALER_VSU_CHCOEFF1(base, i)	((base) + 0x700 + 0x4 * (i))
+#define SUN8I_SCALER_VSU_CVCOEFF(base, i)	((base) + 0x800 + 0x4 * (i))
=20
 #define SUN8I_SCALER_VSU_CTRL_EN		BIT(0)
 #define SUN8I_SCALER_VSU_CTRL_COEFF_RDY		BIT(4)
--=20
2.19.1

