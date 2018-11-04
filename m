Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAB2ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5397D2081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5397D2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbeKEDoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:44:05 -0500
Received: from mailoutvs27.siol.net ([185.57.226.218]:47416 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387509AbeKEDoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:44:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 881BD5212A8;
        Sun,  4 Nov 2018 19:28:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cz-q_94HBrzR; Sun,  4 Nov 2018 19:28:02 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 922225212AF;
        Sun,  4 Nov 2018 19:28:02 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id DC8D05212A8;
        Sun,  4 Nov 2018 19:27:59 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net
Subject: [PATCH v3 12/28] drm/sun4i: Add basic support for DE3
Date:   Sun,  4 Nov 2018 19:26:49 +0100
Message-Id: <20181104182705.18047-13-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display Engine 3 is an upgrade of DE2 with new features like support for
10 bit color formats and support for AFBC.

Most of DE2 code works with DE3, except some small details.

Implement basic support for DE3. Support for 10 bit colort formats and
AFBC, among others missing features, will be added later.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_csc.c       | 83 +++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.c     | 38 +++++++----
 drivers/gpu/drm/sun4i/sun8i_mixer.h     | 34 +++++++++-
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c | 10 ++-
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.h |  1 +
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c  |  8 +++
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h  |  2 +
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.c | 19 +++++-
 drivers/gpu/drm/sun4i/sun8i_vi_scaler.h | 23 +++++++
 9 files changed, 202 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/su=
n8i_csc.c
index b14925b40ccf..e7608a72f26f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_csc.c
+++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
@@ -34,6 +34,41 @@ static const u32 yvu2rgb[] =3D {
 	0x000004A8, 0x00000000, 0x00000813, 0xFFFBAC4A,
 };
=20
+/*
+ * DE3 has a bit different CSC units. Factors are in two's complement fo=
rmat.
+ * First three factors in a row are multiplication factors which have 17=
 bits
+ * for fractional part. Fourth value in a row is comprised of two factor=
s.
+ * Upper 16 bits represents difference, which is subtracted from the inp=
ut
+ * value before multiplication and lower 16 bits represents constant, wh=
ich
+ * is addes at the end.
+ *
+ * x' =3D c00 * (x + d0) + c01 * (y + d1) + c02 * (z + d2) + const0
+ * y' =3D c10 * (x + d0) + c11 * (y + d1) + c12 * (z + d2) + const1
+ * z' =3D c20 * (x + d0) + c21 * (y + d1) + c22 * (z + d2) + const2
+ *
+ * Please note that above formula is true only for Blender CSC. Other DE=
3 CSC
+ * units takes only positive value for difference. From what can be dedu=
cted
+ * from BSP driver code, those units probably automatically assume that
+ * difference has to be subtracted.
+ *
+ * Layout of factors in table:
+ * c00 c01 c02 [d0 const0]
+ * c10 c11 c12 [d1 const1]
+ * c20 c21 c22 [d2 const2]
+ */
+
+static const u32 yuv2rgb_de3[] =3D {
+	0x0002542a, 0x00000000, 0x0003312a, 0xffc00000,
+	0x0002542a, 0xffff376b, 0xfffe5fc3, 0xfe000000,
+	0x0002542a, 0x000408d3, 0x00000000, 0xfe000000,
+};
+
+static const u32 yvu2rgb_de3[] =3D {
+	0x0002542a, 0x0003312a, 0x00000000, 0xffc00000,
+	0x0002542a, 0xfffe5fc3, 0xffff376b, 0xfe000000,
+	0x0002542a, 0x00000000, 0x000408d3, 0xfe000000,
+};
+
 static void sun8i_csc_set_coefficients(struct regmap *map, u32 base,
 				       enum sun8i_csc_mode mode)
 {
@@ -61,6 +96,28 @@ static void sun8i_csc_set_coefficients(struct regmap *=
map, u32 base,
 	}
 }
=20
+static void sun8i_de3_ccsc_set_coefficients(struct regmap *map, int laye=
r,
+					    enum sun8i_csc_mode mode)
+{
+	const u32 *table;
+	u32 base_reg;
+
+	switch (mode) {
+	case SUN8I_CSC_MODE_YUV2RGB:
+		table =3D yuv2rgb_de3;
+		break;
+	case SUN8I_CSC_MODE_YVU2RGB:
+		table =3D yvu2rgb_de3;
+		break;
+	default:
+		DRM_WARN("Wrong CSC mode specified.\n");
+		return;
+	}
+
+	base_reg =3D SUN50I_MIXER_BLEND_CSC_COEFF(DE3_BLD_BASE, layer, 0, 0);
+	regmap_bulk_write(map, base_reg, table, 12);
+}
+
 static void sun8i_csc_enable(struct regmap *map, u32 base, bool enable)
 {
 	u32 val;
@@ -73,11 +130,32 @@ static void sun8i_csc_enable(struct regmap *map, u32=
 base, bool enable)
 	regmap_update_bits(map, SUN8I_CSC_CTRL(base), SUN8I_CSC_CTRL_EN, val);
 }
=20
+static void sun8i_de3_ccsc_enable(struct regmap *map, int layer, bool en=
able)
+{
+	u32 val, mask;
+
+	mask =3D SUN50I_MIXER_BLEND_CSC_CTL_EN(layer);
+
+	if (enable)
+		val =3D mask;
+	else
+		val =3D 0;
+
+	regmap_update_bits(map, SUN50I_MIXER_BLEND_CSC_CTL(DE3_BLD_BASE),
+			   mask, val);
+}
+
 void sun8i_csc_set_ccsc_coefficients(struct sun8i_mixer *mixer, int laye=
r,
 				     enum sun8i_csc_mode mode)
 {
 	u32 base;
=20
+	if (mixer->cfg->is_de3) {
+		sun8i_de3_ccsc_set_coefficients(mixer->engine.regs,
+						layer, mode);
+		return;
+	}
+
 	base =3D ccsc_base[mixer->cfg->ccsc][layer];
=20
 	sun8i_csc_set_coefficients(mixer->engine.regs, base, mode);
@@ -87,6 +165,11 @@ void sun8i_csc_enable_ccsc(struct sun8i_mixer *mixer,=
 int layer, bool enable)
 {
 	u32 base;
=20
+	if (mixer->cfg->is_de3) {
+		sun8i_de3_ccsc_enable(mixer->engine.regs, layer, enable);
+		return;
+	}
+
 	base =3D ccsc_base[mixer->cfg->ccsc][layer];
=20
 	sun8i_csc_enable(mixer->engine.regs, base, enable);
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/=
sun8i_mixer.c
index ec2c264f9481..ca402cf0f5ba 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -459,17 +459,33 @@ static int sun8i_mixer_bind(struct device *dev, str=
uct device *master,
=20
 	base =3D sun8i_blender_base(mixer);
=20
-	/* Reset the registers */
-	for (i =3D 0; i < DE2_MIXER_UNIT_SIZE; i +=3D 4)
-		regmap_write(mixer->engine.regs, i, 0);
-	/* Disable unused sub-engines */
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_FCE_EN, 0);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_BWS_EN, 0);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_LTI_EN, 0);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_PEAK_EN, 0);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_ASE_EN, 0);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_FCC_EN, 0);
-	regmap_write(mixer->engine.regs, SUN8I_MIXER_DCSC_EN, 0);
+	/* Reset registers and disable unused sub-engines */
+	if (mixer->cfg->is_de3) {
+		for (i =3D 0; i < DE3_MIXER_UNIT_SIZE; i +=3D 4)
+			regmap_write(mixer->engine.regs, i, 0);
+
+		regmap_write(mixer->engine.regs, SUN50I_MIXER_FCE_EN, 0);
+		regmap_write(mixer->engine.regs, SUN50I_MIXER_PEAK_EN, 0);
+		regmap_write(mixer->engine.regs, SUN50I_MIXER_LCTI_EN, 0);
+		regmap_write(mixer->engine.regs, SUN50I_MIXER_BLS_EN, 0);
+		regmap_write(mixer->engine.regs, SUN50I_MIXER_FCC_EN, 0);
+		regmap_write(mixer->engine.regs, SUN50I_MIXER_DNS_EN, 0);
+		regmap_write(mixer->engine.regs, SUN50I_MIXER_DRC_EN, 0);
+		regmap_write(mixer->engine.regs, SUN50I_MIXER_FMT_EN, 0);
+		regmap_write(mixer->engine.regs, SUN50I_MIXER_CDC0_EN, 0);
+		regmap_write(mixer->engine.regs, SUN50I_MIXER_CDC1_EN, 0);
+	} else {
+		for (i =3D 0; i < DE2_MIXER_UNIT_SIZE; i +=3D 4)
+			regmap_write(mixer->engine.regs, i, 0);
+
+		regmap_write(mixer->engine.regs, SUN8I_MIXER_FCE_EN, 0);
+		regmap_write(mixer->engine.regs, SUN8I_MIXER_BWS_EN, 0);
+		regmap_write(mixer->engine.regs, SUN8I_MIXER_LTI_EN, 0);
+		regmap_write(mixer->engine.regs, SUN8I_MIXER_PEAK_EN, 0);
+		regmap_write(mixer->engine.regs, SUN8I_MIXER_ASE_EN, 0);
+		regmap_write(mixer->engine.regs, SUN8I_MIXER_FCC_EN, 0);
+		regmap_write(mixer->engine.regs, SUN8I_MIXER_DCSC_EN, 0);
+	}
=20
 	/* Enable the mixer */
 	regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_CTL,
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/=
sun8i_mixer.h
index a4175b993e0d..913d14ce68b0 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -30,11 +30,16 @@
 #define SUN8I_MIXER_GLOBAL_DBUFF_ENABLE		BIT(0)
=20
 #define DE2_MIXER_UNIT_SIZE			0x6000
+#define DE3_MIXER_UNIT_SIZE			0x3000
=20
 #define DE2_BLD_BASE				0x1000
 #define DE2_CH_BASE				0x2000
 #define DE2_CH_SIZE				0x1000
=20
+#define DE3_BLD_BASE				0x0800
+#define DE3_CH_BASE				0x1000
+#define DE3_CH_SIZE				0x0800
+
 #define SUN8I_MIXER_BLEND_PIPE_CTL(base)	((base) + 0)
 #define SUN8I_MIXER_BLEND_ATTR_FCOLOR(base, x)	((base) + 0x4 + 0x10 * (x=
))
 #define SUN8I_MIXER_BLEND_ATTR_INSIZE(base, x)	((base) + 0x8 + 0x10 * (x=
))
@@ -49,10 +54,16 @@
 #define SUN8I_MIXER_BLEND_CK_MAX(base, x)	((base) + 0xc0 + 0x04 * (x))
 #define SUN8I_MIXER_BLEND_CK_MIN(base, x)	((base) + 0xe0 + 0x04 * (x))
 #define SUN8I_MIXER_BLEND_OUTCTL(base)		((base) + 0xfc)
+#define SUN50I_MIXER_BLEND_CSC_CTL(base)	((base) + 0x100)
+#define SUN50I_MIXER_BLEND_CSC_COEFF(base, layer, x, y) \
+	((base) + 0x110 + (layer) * 0x30 +  (x) * 0x10 + 4 * (y))
+#define SUN50I_MIXER_BLEND_CSC_CONST(base, layer, i) \
+	((base) + 0x110 + (layer) * 0x30 +  (i) * 0x10 + 0x0c)
=20
 #define SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK	GENMASK(12, 8)
 #define SUN8I_MIXER_BLEND_PIPE_CTL_EN(pipe)	BIT(8 + pipe)
 #define SUN8I_MIXER_BLEND_PIPE_CTL_FC_EN(pipe)	BIT(pipe)
+
 /* colors are always in AARRGGBB format */
 #define SUN8I_MIXER_BLEND_COLOR_BLACK		0xff000000
 /* The following numbers are some still unknown magic numbers */
@@ -63,6 +74,9 @@
=20
 #define SUN8I_MIXER_BLEND_OUTCTL_INTERLACED	BIT(1)
=20
+#define SUN50I_MIXER_BLEND_CSC_CTL_EN(ch)	BIT(ch)
+#define SUN50I_MIXER_BLEND_CSC_CONST_VAL(d, c)	(((d) << 16) | ((c) & 0xf=
fff))
+
 #define SUN8I_MIXER_FBFMT_ARGB8888	0
 #define SUN8I_MIXER_FBFMT_ABGR8888	1
 #define SUN8I_MIXER_FBFMT_RGBA8888	2
@@ -112,6 +126,17 @@
 #define SUN8I_MIXER_FCC_EN			0xaa000
 #define SUN8I_MIXER_DCSC_EN			0xb0000
=20
+#define SUN50I_MIXER_FCE_EN			0x70000
+#define SUN50I_MIXER_PEAK_EN			0x70800
+#define SUN50I_MIXER_LCTI_EN			0x71000
+#define SUN50I_MIXER_BLS_EN			0x71800
+#define SUN50I_MIXER_FCC_EN			0x72000
+#define SUN50I_MIXER_DNS_EN			0x80000
+#define SUN50I_MIXER_DRC_EN			0xa0000
+#define SUN50I_MIXER_FMT_EN			0xa8000
+#define SUN50I_MIXER_CDC0_EN			0xd0000
+#define SUN50I_MIXER_CDC1_EN			0xd8000
+
 struct de2_fmt_info {
 	u32			drm_fmt;
 	u32			de2_fmt;
@@ -133,6 +158,7 @@ struct de2_fmt_info {
  *	are invalid.
  * @mod_rate: module clock rate that needs to be set in order to have
  *	a functional block.
+ * @is_de3: true, if this is next gen display engine 3.0, false otherwis=
e.
  */
 struct sun8i_mixer_cfg {
 	int		vi_num;
@@ -140,6 +166,7 @@ struct sun8i_mixer_cfg {
 	int		scaler_mask;
 	int		ccsc;
 	unsigned long	mod_rate;
+	unsigned int	is_de3 : 1;
 };
=20
 struct sun8i_mixer {
@@ -162,13 +189,16 @@ engine_to_sun8i_mixer(struct sunxi_engine *engine)
 static inline u32
 sun8i_blender_base(struct sun8i_mixer *mixer)
 {
-	return DE2_BLD_BASE;
+	return mixer->cfg->is_de3 ? DE3_BLD_BASE : DE2_BLD_BASE;
 }
=20
 static inline u32
 sun8i_channel_base(struct sun8i_mixer *mixer, int channel)
 {
-	return DE2_CH_BASE + channel * DE2_CH_SIZE;
+	if (mixer->cfg->is_de3)
+		return DE3_CH_BASE + channel * DE3_CH_SIZE;
+	else
+		return DE2_CH_BASE + channel * DE2_CH_SIZE;
 }
=20
 const struct de2_fmt_info *sun8i_mixer_format_info(u32 format);
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c b/drivers/gpu/drm/su=
n4i/sun8i_ui_scaler.c
index 698401ecb53d..ae0806bccac7 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
@@ -93,8 +93,14 @@ static u32 sun8i_ui_scaler_base(struct sun8i_mixer *mi=
xer, int channel)
 {
 	int vi_num =3D mixer->cfg->vi_num;
=20
-	return DE2_VI_SCALER_UNIT_BASE + DE2_VI_SCALER_UNIT_SIZE * vi_num +
-	       DE2_UI_SCALER_UNIT_SIZE * (channel - vi_num);
+	if (mixer->cfg->is_de3)
+		return DE3_VI_SCALER_UNIT_BASE +
+		       DE3_VI_SCALER_UNIT_SIZE * vi_num +
+		       DE3_UI_SCALER_UNIT_SIZE * (channel - vi_num);
+	else
+		return DE2_VI_SCALER_UNIT_BASE +
+		       DE2_VI_SCALER_UNIT_SIZE * vi_num +
+		       DE2_UI_SCALER_UNIT_SIZE * (channel - vi_num);
 }
=20
 static int sun8i_ui_scaler_coef_index(unsigned int step)
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.h b/drivers/gpu/drm/su=
n4i/sun8i_ui_scaler.h
index 6b4bc1ff3e2c..1ef4bd6f2718 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.h
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.h
@@ -12,6 +12,7 @@
 #include "sun8i_mixer.h"
=20
 #define DE2_UI_SCALER_UNIT_SIZE 0x10000
+#define DE3_UI_SCALER_UNIT_SIZE 0x08000
=20
 /* this two macros assumes 16 fractional bits which is standard in DRM *=
/
 #define SUN8I_UI_SCALER_SCALE_MIN		1
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
index 79811eae3735..4249edfb47ed 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -202,6 +202,14 @@ static int sun8i_vi_layer_update_formats(struct sun8=
i_mixer *mixer, int channel,
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE, val);
=20
+	/* It seems that YUV formats use global alpha setting. */
+	if (mixer->cfg->is_de3)
+		regmap_update_bits(mixer->engine.regs,
+				   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base,
+								  overlay),
+				   SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MASK,
+				   SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA(0xff));
+
 	return 0;
 }
=20
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.h
index 46f0237c17bb..8a5e6d01c85d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.h
@@ -30,6 +30,8 @@
 #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE		BIT(15)
 #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET	8
 #define SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
+#define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
+#define SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA(x)	((x) << 24)
=20
 struct sun8i_mixer;
=20
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c b/drivers/gpu/drm/su=
n4i/sun8i_vi_scaler.c
index 9f6834c143d7..7ba75011adf9 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
@@ -835,7 +835,12 @@ static const u32 bicubic4coefftab32[480] =3D {
=20
 static u32 sun8i_vi_scaler_base(struct sun8i_mixer *mixer, int channel)
 {
-	return DE2_VI_SCALER_UNIT_BASE + DE2_VI_SCALER_UNIT_SIZE * channel;
+	if (mixer->cfg->is_de3)
+		return DE3_VI_SCALER_UNIT_BASE +
+		       DE3_VI_SCALER_UNIT_SIZE * channel;
+	else
+		return DE2_VI_SCALER_UNIT_BASE +
+		       DE2_VI_SCALER_UNIT_SIZE * channel;
 }
=20
 static int sun8i_vi_scaler_coef_index(unsigned int step)
@@ -951,6 +956,18 @@ void sun8i_vi_scaler_setup(struct sun8i_mixer *mixer=
, int layer,
 		cvphase =3D vphase;
 	}
=20
+	if (mixer->cfg->is_de3) {
+		u32 val;
+
+		if (format->hsub =3D=3D 1 && format->vsub =3D=3D 1)
+			val =3D SUN50I_SCALER_VSU_SCALE_MODE_UI;
+		else
+			val =3D SUN50I_SCALER_VSU_SCALE_MODE_NORMAL;
+
+		regmap_write(mixer->engine.regs,
+			     SUN50I_SCALER_VSU_SCALE_MODE(base), val);
+	}
+
 	regmap_write(mixer->engine.regs,
 		     SUN8I_SCALER_VSU_OUTSIZE(base), outsize);
 	regmap_write(mixer->engine.regs,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h b/drivers/gpu/drm/su=
n4i/sun8i_vi_scaler.h
index f3de87122f07..68f6593b369a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
@@ -15,6 +15,9 @@
 #define DE2_VI_SCALER_UNIT_BASE 0x20000
 #define DE2_VI_SCALER_UNIT_SIZE 0x20000
=20
+#define DE3_VI_SCALER_UNIT_BASE 0x20000
+#define DE3_VI_SCALER_UNIT_SIZE 0x08000
+
 /* this two macros assumes 16 fractional bits which is standard in DRM *=
/
 #define SUN8I_VI_SCALER_SCALE_MIN		1
 #define SUN8I_VI_SCALER_SCALE_MAX		((1UL << 20) - 1)
@@ -25,6 +28,11 @@
 #define SUN8I_VI_SCALER_SIZE(w, h)		(((h) - 1) << 16 | ((w) - 1))
=20
 #define SUN8I_SCALER_VSU_CTRL(base)		((base) + 0x0)
+#define SUN50I_SCALER_VSU_SCALE_MODE(base)		((base) + 0x10)
+#define SUN50I_SCALER_VSU_DIR_THR(base)		((base) + 0x20)
+#define SUN50I_SCALER_VSU_EDGE_THR(base)		((base) + 0x24)
+#define SUN50I_SCALER_VSU_EDSCL_CTRL(base)		((base) + 0x28)
+#define SUN50I_SCALER_VSU_ANGLE_THR(base)		((base) + 0x2c)
 #define SUN8I_SCALER_VSU_OUTSIZE(base)		((base) + 0x40)
 #define SUN8I_SCALER_VSU_YINSIZE(base)		((base) + 0x80)
 #define SUN8I_SCALER_VSU_YHSTEP(base)		((base) + 0x88)
@@ -46,6 +54,21 @@
 #define SUN8I_SCALER_VSU_CTRL_EN		BIT(0)
 #define SUN8I_SCALER_VSU_CTRL_COEFF_RDY		BIT(4)
=20
+#define SUN50I_SCALER_VSU_SUB_ZERO_DIR_THR(x)	(((x) << 24) & 0xFF)
+#define SUN50I_SCALER_VSU_ZERO_DIR_THR(x)		(((x) << 16) & 0xFF)
+#define SUN50I_SCALER_VSU_HORZ_DIR_THR(x)		(((x) << 8) & 0xFF)
+#define SUN50I_SCALER_VSU_VERT_DIR_THR(x)		((x) & 0xFF)
+
+#define SUN50I_SCALER_VSU_SCALE_MODE_UI		0
+#define SUN50I_SCALER_VSU_SCALE_MODE_NORMAL	1
+#define SUN50I_SCALER_VSU_SCALE_MODE_ED_SCALE	2
+
+#define SUN50I_SCALER_VSU_EDGE_SHIFT(x)		(((x) << 16) & 0xF)
+#define SUN50I_SCALER_VSU_EDGE_OFFSET(x)		((x) & 0xFF)
+
+#define SUN50I_SCALER_VSU_ANGLE_SHIFT(x)		(((x) << 16) & 0xF)
+#define SUN50I_SCALER_VSU_ANGLE_OFFSET(x)		((x) & 0xFF)
+
 void sun8i_vi_scaler_enable(struct sun8i_mixer *mixer, int layer, bool e=
nable);
 void sun8i_vi_scaler_setup(struct sun8i_mixer *mixer, int layer,
 			   u32 src_w, u32 src_h, u32 dst_w, u32 dst_h,
--=20
2.19.1

