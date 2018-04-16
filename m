Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755393AbeDPMRr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:17:47 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45442 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754029AbeDPMRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:17:41 -0400
X-Google-Smtp-Source: AIpwx4/3wcKzkww0nBz6FEdRq0g9BD4CH+AQmHZs/CVqxMmI7XzZ+ek+Sy18JxQz3JTotobSpjWVHQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] drm/tegra: plane: Add custom CSC BLOB property
Date: Mon, 16 Apr 2018 15:16:28 +0300
Message-Id: <dac33c4b27107fee37d187d97187431353fe6afc.1523880381.git.digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1523880381.git.digetx@gmail.com>
References: <cover.1523880381.git.digetx@gmail.com>
In-Reply-To: <cover.1523880381.git.digetx@gmail.com>
References: <cover.1523880381.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new property allows userspace to apply custom color conversion
coefficients per plane, making possible to utilize display controller
for color adjustments of a video overlay.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c    | 86 +++++++++++++++++++++++++++++++----
 drivers/gpu/drm/tegra/dc.h    | 11 +++++
 drivers/gpu/drm/tegra/plane.c | 35 ++++++++++++++
 drivers/gpu/drm/tegra/plane.h |  5 ++
 include/uapi/drm/tegra_drm.h  | 11 +++++
 5 files changed, 139 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index b19e954a223f..24a1317871d4 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -435,15 +435,15 @@ static void tegra_dc_setup_window(struct tegra_plane *plane,
 	value = WIN_ENABLE;
 
 	if (yuv) {
-		/* setup default colorspace conversion coefficients */
-		tegra_plane_writel(plane, 0x00f0, DC_WIN_CSC_YOF);
-		tegra_plane_writel(plane, 0x012a, DC_WIN_CSC_KYRGB);
-		tegra_plane_writel(plane, 0x0000, DC_WIN_CSC_KUR);
-		tegra_plane_writel(plane, 0x0198, DC_WIN_CSC_KVR);
-		tegra_plane_writel(plane, 0x039b, DC_WIN_CSC_KUG);
-		tegra_plane_writel(plane, 0x032f, DC_WIN_CSC_KVG);
-		tegra_plane_writel(plane, 0x0204, DC_WIN_CSC_KUB);
-		tegra_plane_writel(plane, 0x0000, DC_WIN_CSC_KVB);
+		/* setup colorspace conversion coefficients */
+		tegra_plane_writel(plane, window->csc.yof, DC_WIN_CSC_YOF);
+		tegra_plane_writel(plane, window->csc.kyrgb, DC_WIN_CSC_KYRGB);
+		tegra_plane_writel(plane, window->csc.kur, DC_WIN_CSC_KUR);
+		tegra_plane_writel(plane, window->csc.kvr, DC_WIN_CSC_KVR);
+		tegra_plane_writel(plane, window->csc.kug, DC_WIN_CSC_KUG);
+		tegra_plane_writel(plane, window->csc.kvg, DC_WIN_CSC_KVG);
+		tegra_plane_writel(plane, window->csc.kub, DC_WIN_CSC_KUB);
+		tegra_plane_writel(plane, window->csc.kvb, DC_WIN_CSC_KVB);
 
 		value |= CSC_ENABLE;
 	} else if (window->bits_per_pixel < 24) {
@@ -624,6 +624,7 @@ static void tegra_plane_atomic_update(struct drm_plane *plane,
 	struct drm_framebuffer *fb = plane->state->fb;
 	struct tegra_plane *p = to_tegra_plane(plane);
 	struct tegra_dc_window window;
+	const struct drm_tegra_plane_csc_blob *csc;
 	unsigned int i;
 
 	/* rien ne va plus */
@@ -665,6 +666,28 @@ static void tegra_plane_atomic_update(struct drm_plane *plane,
 			window.stride[i] = fb->pitches[i];
 	}
 
+	if (state->csc_blob) {
+		csc = state->csc_blob->data;
+
+		window.csc.yof = csc->yof;
+		window.csc.kyrgb = csc->kyrgb;
+		window.csc.kur = csc->kur;
+		window.csc.kvr = csc->kvr;
+		window.csc.kug = csc->kug;
+		window.csc.kvg = csc->kvg;
+		window.csc.kub = csc->kub;
+		window.csc.kvb = csc->kvb;
+	} else {
+		window.csc.yof = 0x00f0;
+		window.csc.kyrgb = 0x012a;
+		window.csc.kur = 0x0000;
+		window.csc.kvr = 0x0198;
+		window.csc.kug = 0x039b;
+		window.csc.kvg = 0x032f;
+		window.csc.kub = 0x0204;
+		window.csc.kvb = 0x0000;
+	}
+
 	tegra_dc_setup_window(p, &window);
 }
 
@@ -776,6 +799,42 @@ static void tegra_plane_create_legacy_properties(struct tegra_plane *plane,
 	dev_err(plane->dc->dev, "failed to create legacy plane properties\n");
 }
 
+static void tegra_plane_create_csc_property(struct tegra_plane *plane)
+{
+	/* set default colorspace conversion coefficients to ITU-R BT.601 */
+	struct drm_tegra_plane_csc_blob csc_bt601 = {
+		.yof   = 0x00f0,
+		.kyrgb = 0x012a,
+		.kur   = 0x0000,
+		.kvr   = 0x0198,
+		.kug   = 0x039b,
+		.kvg   = 0x032f,
+		.kub   = 0x0204,
+		.kvb   = 0x0000,
+	};
+	struct drm_property_blob *blob;
+
+	blob = drm_property_create_blob(plane->base.dev, sizeof(csc_bt601),
+					&csc_bt601);
+	if (!blob) {
+		dev_err(plane->dc->dev, "failed to create CSC BLOB\n");
+		return;
+	}
+
+	plane->props.csc_blob = drm_property_create(
+		plane->base.dev, DRM_MODE_PROP_BLOB, "YUV to RGB CSC", 0);
+
+	if (!plane->props.csc_blob) {
+		dev_err(plane->dc->dev, "failed to create CSC property\n");
+		drm_property_blob_put(blob);
+		return;
+	}
+
+	drm_object_attach_property(&plane->base.base, plane->props.csc_blob, 0);
+
+	plane->csc_default = blob;
+}
+
 static struct drm_plane *tegra_primary_plane_create(struct drm_device *drm,
 						    struct tegra_dc *dc)
 {
@@ -814,6 +873,9 @@ static struct drm_plane *tegra_primary_plane_create(struct drm_device *drm,
 	if (dc->soc->legacy_blending)
 		tegra_plane_create_legacy_properties(plane, drm);
 
+	if (dc->soc->has_win_a_csc)
+		tegra_plane_create_csc_property(plane);
+
 	return &plane->base;
 }
 
@@ -1092,6 +1154,7 @@ static struct drm_plane *tegra_dc_overlay_plane_create(struct drm_device *drm,
 
 	drm_plane_helper_add(&plane->base, &tegra_plane_helper_funcs);
 	drm_plane_create_zpos_property(&plane->base, plane->index, 0, 255);
+	tegra_plane_create_csc_property(plane);
 
 	return &plane->base;
 }
@@ -2269,6 +2332,7 @@ static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
 	.num_overlay_formats = ARRAY_SIZE(tegra20_overlay_formats),
 	.overlay_formats = tegra20_overlay_formats,
 	.modifiers = tegra20_modifiers,
+	.has_win_a_csc = false,
 };
 
 static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
@@ -2287,6 +2351,7 @@ static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
 	.num_overlay_formats = ARRAY_SIZE(tegra20_overlay_formats),
 	.overlay_formats = tegra20_overlay_formats,
 	.modifiers = tegra20_modifiers,
+	.has_win_a_csc = false,
 };
 
 static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
@@ -2305,6 +2370,7 @@ static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
 	.num_overlay_formats = ARRAY_SIZE(tegra114_overlay_formats),
 	.overlay_formats = tegra114_overlay_formats,
 	.modifiers = tegra20_modifiers,
+	.has_win_a_csc = true,
 };
 
 static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
@@ -2323,6 +2389,7 @@ static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
 	.num_overlay_formats = ARRAY_SIZE(tegra124_overlay_formats),
 	.overlay_formats = tegra124_overlay_formats,
 	.modifiers = tegra124_modifiers,
+	.has_win_a_csc = true,
 };
 
 static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
@@ -2341,6 +2408,7 @@ static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
 	.num_overlay_formats = ARRAY_SIZE(tegra114_overlay_formats),
 	.overlay_formats = tegra114_overlay_formats,
 	.modifiers = tegra124_modifiers,
+	.has_win_a_csc = true,
 };
 
 static const struct tegra_windowgroup_soc tegra186_dc_wgrps[] = {
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 3913d047abac..23439eaaa4de 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -77,6 +77,7 @@ struct tegra_dc_soc_info {
 	const u32 *overlay_formats;
 	unsigned int num_overlay_formats;
 	const u64 *modifiers;
+	bool has_win_a_csc;
 };
 
 struct tegra_dc {
@@ -152,6 +153,16 @@ struct tegra_dc_window {
 		unsigned int w;
 		unsigned int h;
 	} dst;
+	struct {
+		unsigned int yof;
+		unsigned int kyrgb;
+		unsigned int kur;
+		unsigned int kvr;
+		unsigned int kug;
+		unsigned int kvg;
+		unsigned int kub;
+		unsigned int kvb;
+	} csc;
 	unsigned int bits_per_pixel;
 	unsigned int stride[2];
 	unsigned long base[3];
diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index 4d794f2b44df..c5733c5a66e9 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -17,6 +17,9 @@ static void tegra_plane_destroy(struct drm_plane *plane)
 {
 	struct tegra_plane *p = to_tegra_plane(plane);
 
+	if (p->csc_default)
+		drm_property_blob_put(p->csc_default);
+
 	drm_plane_cleanup(plane);
 	kfree(p);
 }
@@ -38,6 +41,9 @@ static void tegra_plane_reset(struct drm_plane *plane)
 		plane->state->plane = plane;
 		plane->state->zpos = p->index;
 		plane->state->normalized_zpos = p->index;
+
+		if (p->csc_default)
+			state->csc_blob = drm_property_blob_get(p->csc_default);
 	}
 }
 
@@ -63,12 +69,22 @@ tegra_plane_atomic_duplicate_state(struct drm_plane *plane)
 	for (i = 0; i < 2; i++)
 		copy->blending[i] = state->blending[i];
 
+	if (state->csc_blob)
+		copy->csc_blob = drm_property_blob_get(state->csc_blob);
+	else
+		copy->csc_blob = NULL;
+
 	return &copy->base;
 }
 
 static void tegra_plane_atomic_destroy_state(struct drm_plane *plane,
 					     struct drm_plane_state *state)
 {
+	struct tegra_plane_state *tegra = to_tegra_plane_state(state);
+
+	if (tegra->csc_blob)
+		drm_property_blob_put(tegra->csc_blob);
+
 	__drm_atomic_helper_plane_destroy_state(state);
 	kfree(state);
 }
@@ -95,6 +111,23 @@ static int tegra_plane_set_property(struct drm_plane *plane,
 {
 	struct tegra_plane_state *tegra_state = to_tegra_plane_state(state);
 	struct tegra_plane *tegra = to_tegra_plane(plane);
+	struct drm_property_blob *blob;
+
+	if (property == tegra->props.csc_blob) {
+		blob = drm_property_lookup_blob(plane->dev, value);
+		if (!blob)
+			return -EINVAL;
+
+		if (blob->length != sizeof(struct drm_tegra_plane_csc_blob)) {
+			drm_property_blob_put(blob);
+			return -EINVAL;
+		}
+
+		drm_property_blob_put(tegra_state->csc_blob);
+		tegra_state->csc_blob = blob;
+
+		return 0;
+	}
 
 	if (property == tegra->props.color_key0)
 		tegra_state->ckey0_enabled = value;
@@ -118,6 +151,8 @@ static int tegra_plane_get_property(struct drm_plane *plane,
 		*value = tegra_state->ckey0_enabled;
 	else if (property == tegra->props.color_key1)
 		*value = tegra_state->ckey1_enabled;
+	else if (property == tegra->props.csc_blob)
+		*value = tegra_state->csc_blob->base.id;
 	else
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/plane.h
index dafecea73b29..dc9efa7be502 100644
--- a/drivers/gpu/drm/tegra/plane.h
+++ b/drivers/gpu/drm/tegra/plane.h
@@ -23,7 +23,10 @@ struct tegra_plane {
 	struct {
 		struct drm_property *color_key0;
 		struct drm_property *color_key1;
+		struct drm_property *csc_blob;
 	} props;
+
+	struct drm_property_blob *csc_default;
 };
 
 struct tegra_cursor {
@@ -51,6 +54,8 @@ struct tegra_plane_state {
 	u32 format;
 	u32 swap;
 
+	struct drm_property_blob *csc_blob;
+
 	/* used for legacy blending support only */
 	struct tegra_plane_legacy_blending_state blending[2];
 	bool opaque;
diff --git a/include/uapi/drm/tegra_drm.h b/include/uapi/drm/tegra_drm.h
index a5da44209a68..a3054ea7b222 100644
--- a/include/uapi/drm/tegra_drm.h
+++ b/include/uapi/drm/tegra_drm.h
@@ -29,6 +29,17 @@
 extern "C" {
 #endif
 
+struct drm_tegra_plane_csc_blob {
+	__u32 yof;
+	__u32 kyrgb;
+	__u32 kur;
+	__u32 kvr;
+	__u32 kug;
+	__u32 kvg;
+	__u32 kub;
+	__u32 kvb;
+};
+
 #define DRM_TEGRA_GEM_CREATE_TILED     (1 << 0)
 #define DRM_TEGRA_GEM_CREATE_BOTTOM_UP (1 << 1)
 #define DRM_TEGRA_GEM_CREATE_SCATTERED (1 << 2)
-- 
2.17.0
