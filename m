Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755365AbeDPMRd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:17:33 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35034 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755178AbeDPMR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:17:28 -0400
X-Google-Smtp-Source: AIpwx49k/qd1pFRKY+xFFhicx0oK9XJIUOS5iykWksA4tNvsIth18TyXCvsPg70ecV0TpRfrvSroSw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] drm/tegra: plane: Implement zPos plane property for older Tegra's
Date: Mon, 16 Apr 2018 15:16:25 +0300
Message-Id: <bcc621ed511719f1c0ffb04a2790179256b7f4e0.1523880381.git.digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1523880381.git.digetx@gmail.com>
References: <cover.1523880381.git.digetx@gmail.com>
In-Reply-To: <cover.1523880381.git.digetx@gmail.com>
References: <cover.1523880381.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older Tegra's do not support planes z position handling in hardware,
but HW provides knobs for zPos implementation in software.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c    | 134 ++++++++++++++++-------
 drivers/gpu/drm/tegra/plane.c | 193 ++++++++++++++++++++++++----------
 drivers/gpu/drm/tegra/plane.h |  13 ++-
 3 files changed, 244 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 9d885d63724d..a2bf216d8854 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -162,29 +162,90 @@ static void tegra_plane_setup_blending_legacy(struct tegra_plane *plane)
 	u32 foreground = BLEND_WEIGHT1(255) | BLEND_WEIGHT0(255) |
 			 BLEND_COLOR_KEY_NONE;
 	u32 blendnokey = BLEND_WEIGHT1(255) | BLEND_WEIGHT0(255);
+	u32 blending[2];
 	struct tegra_plane_state *state;
 	unsigned int i;
 
+	/* disable blending for non-overlapping case */
+	tegra_plane_writel(plane, blendnokey, DC_WIN_BLEND_NOKEY);
+	tegra_plane_writel(plane, foreground, DC_WIN_BLEND_1WIN);
+
 	state = to_tegra_plane_state(plane->base.state);
 
-	/* alpha contribution is 1 minus sum of overlapping windows */
-	for (i = 0; i < 3; i++) {
-		if (state->dependent[i])
-			background[i] |= BLEND_CONTROL_DEPENDENT;
-	}
+	if (state->opaque) {
+		/*
+		 * Since custom fix-weight blending isn't utilized and weight
+		 * of top window is set to max, we can enforce dependent
+		 * blending which in this case results in transparent bottom
+		 * window if top window is opaque and if top window enables
+		 * alpha blending, then bottom window is getting alpha value
+		 * of 1 minus the sum of alpha components of the overlapping
+		 * plane.
+		 */
+		background[0] |= BLEND_CONTROL_DEPENDENT;
+		background[1] |= BLEND_CONTROL_DEPENDENT;
 
-	/* enable alpha blending if pixel format has an alpha component */
-	if (!state->opaque)
+		/*
+		 * The region where three windows overlap is the intersection
+		 * of the two regions where two windows overlap. It contributes
+		 * to the area if all of the windows on top of it have an alpha
+		 * component.
+		 */
+		switch (state->base.normalized_zpos) {
+		case 0:
+			if (state->blending[0].alpha &&
+			    state->blending[1].alpha)
+				background[2] |= BLEND_CONTROL_DEPENDENT;
+			break;
+
+		case 1:
+			background[2] |= BLEND_CONTROL_DEPENDENT;
+			break;
+		}
+	} else {
+		/*
+		 * Enable alpha blending if pixel format has an alpha
+		 * component.
+		 */
 		foreground |= BLEND_CONTROL_ALPHA;
 
-	/*
-	 * Disable blending and assume Window A is the bottom-most window,
-	 * Window C is the top-most window and Window B is in the middle.
-	 */
-	tegra_plane_writel(plane, blendnokey, DC_WIN_BLEND_NOKEY);
-	tegra_plane_writel(plane, foreground, DC_WIN_BLEND_1WIN);
+		/*
+		 * If any of the windows on top of this window is opaque, it
+		 * will completely conceal this window within that area. If
+		 * top window has an alpha component, it is blended over the
+		 * bottom window.
+		 */
+		for (i = 0; i < 2; i++) {
+			if (state->blending[i].alpha &&
+			    state->blending[i].top)
+				background[i] |= BLEND_CONTROL_DEPENDENT;
+		}
+
+		switch (state->base.normalized_zpos) {
+		case 0:
+			if (state->blending[0].alpha &&
+			    state->blending[1].alpha)
+				background[2] |= BLEND_CONTROL_DEPENDENT;
+			break;
+
+		case 1:
+			/*
+			 * When both middle and topmost windows have an alpha,
+			 * these windows a mixed together and then the result
+			 * is blended over the bottom window.
+			 */
+			if ((state->blending[0].alpha &&
+			     state->blending[0].top))
+				background[2] |= BLEND_CONTROL_ALPHA;
 
-	switch (plane->index) {
+			if (state->blending[1].alpha &&
+			    state->blending[1].top)
+				background[2] |= BLEND_CONTROL_ALPHA;
+			break;
+		}
+	}
+
+	switch (state->base.normalized_zpos) {
 	case 0:
 		tegra_plane_writel(plane, background[0], DC_WIN_BLEND_2WIN_X);
 		tegra_plane_writel(plane, background[1], DC_WIN_BLEND_2WIN_Y);
@@ -192,8 +253,21 @@ static void tegra_plane_setup_blending_legacy(struct tegra_plane *plane)
 		break;
 
 	case 1:
-		tegra_plane_writel(plane, foreground, DC_WIN_BLEND_2WIN_X);
-		tegra_plane_writel(plane, background[1], DC_WIN_BLEND_2WIN_Y);
+		/*
+		 * If window B / C is topmost, then X / Y registers are
+		 * matching the order of blending[...] state indices,
+		 * otherwise a swap is required.
+		 */
+		if (!state->blending[0].top && state->blending[1].top) {
+			blending[0] = foreground;
+			blending[1] = background[1];
+		} else {
+			blending[0] = background[0];
+			blending[1] = foreground;
+		}
+
+		tegra_plane_writel(plane, blending[0], DC_WIN_BLEND_2WIN_X);
+		tegra_plane_writel(plane, blending[1], DC_WIN_BLEND_2WIN_Y);
 		tegra_plane_writel(plane, background[2], DC_WIN_BLEND_3WIN_XY);
 		break;
 
@@ -457,14 +531,14 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 	struct tegra_bo_tiling *tiling = &plane_state->tiling;
 	struct tegra_plane *tegra = to_tegra_plane(plane);
 	struct tegra_dc *dc = to_tegra_dc(state->crtc);
-	unsigned int format;
 	int err;
 
 	/* no need for further checks if the plane is being disabled */
 	if (!state->crtc)
 		return 0;
 
-	err = tegra_plane_format(state->fb->format->format, &format,
+	err = tegra_plane_format(state->fb->format->format,
+				 &plane_state->format,
 				 &plane_state->swap);
 	if (err < 0)
 		return err;
@@ -476,21 +550,11 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 	 * be emulated by disabling alpha blending for the plane.
 	 */
 	if (!dc->soc->supports_blending) {
-		if (!tegra_plane_format_has_alpha(format)) {
-			err = tegra_plane_format_get_alpha(format, &format);
-			if (err < 0)
-				return err;
-
-			plane_state->opaque = true;
-		} else {
-			plane_state->opaque = false;
-		}
-
-		tegra_plane_check_dependent(tegra, plane_state);
+		err = tegra_plane_setup_legacy_state(tegra, plane_state);
+		if (err < 0)
+			return err;
 	}
 
-	plane_state->format = format;
-
 	err = tegra_fb_get_tiling(state->fb, tiling);
 	if (err < 0)
 		return err;
@@ -698,9 +762,7 @@ static struct drm_plane *tegra_primary_plane_create(struct drm_device *drm,
 	}
 
 	drm_plane_helper_add(&plane->base, &tegra_plane_helper_funcs);
-
-	if (dc->soc->supports_blending)
-		drm_plane_create_zpos_property(&plane->base, 0, 0, 255);
+	drm_plane_create_zpos_property(&plane->base, plane->index, 0, 255);
 
 	return &plane->base;
 }
@@ -979,9 +1041,7 @@ static struct drm_plane *tegra_dc_overlay_plane_create(struct drm_device *drm,
 	}
 
 	drm_plane_helper_add(&plane->base, &tegra_plane_helper_funcs);
-
-	if (dc->soc->supports_blending)
-		drm_plane_create_zpos_property(&plane->base, 0, 0, 255);
+	drm_plane_create_zpos_property(&plane->base, plane->index, 0, 255);
 
 	return &plane->base;
 }
diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index 176ef46c615c..0406c2ef432c 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -23,6 +23,7 @@ static void tegra_plane_destroy(struct drm_plane *plane)
 
 static void tegra_plane_reset(struct drm_plane *plane)
 {
+	struct tegra_plane *p = to_tegra_plane(plane);
 	struct tegra_plane_state *state;
 
 	if (plane->state)
@@ -35,6 +36,8 @@ static void tegra_plane_reset(struct drm_plane *plane)
 	if (state) {
 		plane->state = &state->base;
 		plane->state->plane = plane;
+		plane->state->zpos = p->index;
+		plane->state->normalized_zpos = p->index;
 	}
 }
 
@@ -55,8 +58,8 @@ tegra_plane_atomic_duplicate_state(struct drm_plane *plane)
 	copy->swap = state->swap;
 	copy->opaque = state->opaque;
 
-	for (i = 0; i < 3; i++)
-		copy->dependent[i] = state->dependent[i];
+	for (i = 0; i < 2; i++)
+		copy->blending[i] = state->blending[i];
 
 	return &copy->base;
 }
@@ -267,24 +270,8 @@ static bool __drm_format_has_alpha(u32 format)
 	return false;
 }
 
-/*
- * This is applicable to Tegra20 and Tegra30 only where the opaque formats can
- * be emulated using the alpha formats and alpha blending disabled.
- */
-bool tegra_plane_format_has_alpha(unsigned int format)
-{
-	switch (format) {
-	case WIN_COLOR_DEPTH_B5G5R5A1:
-	case WIN_COLOR_DEPTH_A1B5G5R5:
-	case WIN_COLOR_DEPTH_R8G8B8A8:
-	case WIN_COLOR_DEPTH_B8G8R8A8:
-		return true;
-	}
-
-	return false;
-}
-
-int tegra_plane_format_get_alpha(unsigned int opaque, unsigned int *alpha)
+static int tegra_plane_format_get_alpha(unsigned int opaque,
+					unsigned int *alpha)
 {
 	if (tegra_plane_format_is_yuv(opaque, NULL)) {
 		*alpha = opaque;
@@ -316,6 +303,67 @@ int tegra_plane_format_get_alpha(unsigned int opaque, unsigned int *alpha)
 	return -EINVAL;
 }
 
+/*
+ * This is applicable to Tegra20 and Tegra30 only where the opaque formats can
+ * be emulated using the alpha formats and alpha blending disabled.
+ */
+static int tegra_plane_setup_opacity(struct tegra_plane *tegra,
+				     struct tegra_plane_state *state)
+{
+	unsigned int format;
+	int err;
+
+	switch (state->format) {
+	case WIN_COLOR_DEPTH_B5G5R5A1:
+	case WIN_COLOR_DEPTH_A1B5G5R5:
+	case WIN_COLOR_DEPTH_R8G8B8A8:
+	case WIN_COLOR_DEPTH_B8G8R8A8:
+		state->opaque = false;
+		break;
+
+	default:
+		err = tegra_plane_format_get_alpha(state->format, &format);
+		if (err < 0)
+			return err;
+
+		state->format = format;
+		state->opaque = true;
+		break;
+	}
+
+	return 0;
+}
+
+static int tegra_plane_check_transparency(struct tegra_plane *tegra,
+					  struct tegra_plane_state *state)
+{
+	struct drm_plane_state *old, *plane_state;
+	struct drm_plane *plane;
+
+	old = drm_atomic_get_old_plane_state(state->base.state, &tegra->base);
+
+	/* check if zpos / transparency changed */
+	if (old->normalized_zpos == state->base.normalized_zpos &&
+	    to_tegra_plane_state(old)->opaque == state->opaque)
+		return 0;
+
+	/* include all sibling planes into this commit */
+	drm_for_each_plane(plane, tegra->base.dev) {
+		struct tegra_plane *p = to_tegra_plane(plane);
+
+		/* skip this plane and planes on different CRTCs */
+		if (p == tegra || p->dc != tegra->dc)
+			continue;
+
+		plane_state = drm_atomic_get_plane_state(state->base.state,
+							 plane);
+		if (IS_ERR(plane_state))
+			return PTR_ERR(plane_state);
+	}
+
+	return 1;
+}
+
 static unsigned int tegra_plane_get_overlap_index(struct tegra_plane *plane,
 						  struct tegra_plane *other)
 {
@@ -336,61 +384,98 @@ static unsigned int tegra_plane_get_overlap_index(struct tegra_plane *plane,
 	return index;
 }
 
-void tegra_plane_check_dependent(struct tegra_plane *tegra,
-				 struct tegra_plane_state *state)
+static void tegra_plane_update_transparency(struct tegra_plane *tegra,
+					    struct tegra_plane_state *state)
 {
-	struct drm_plane_state *old, *new;
+	struct drm_plane_state *new;
 	struct drm_plane *plane;
-	unsigned int zpos[2];
 	unsigned int i;
 
-	for (i = 0; i < 2; i++)
-		zpos[i] = 0;
-
-	for_each_oldnew_plane_in_state(state->base.state, plane, old, new, i) {
+	for_each_new_plane_in_state(state->base.state, plane, new, i) {
 		struct tegra_plane *p = to_tegra_plane(plane);
 		unsigned index;
 
 		/* skip this plane and planes on different CRTCs */
-		if (p == tegra || new->crtc != state->base.crtc)
+		if (p == tegra || p->dc != tegra->dc)
 			continue;
 
 		index = tegra_plane_get_overlap_index(tegra, p);
 
-		state->dependent[index] = false;
+		if (new->fb && __drm_format_has_alpha(new->fb->format->format))
+			state->blending[index].alpha = true;
+		else
+			state->blending[index].alpha = false;
+
+		if (new->normalized_zpos > state->base.normalized_zpos)
+			state->blending[index].top = true;
+		else
+			state->blending[index].top = false;
 
 		/*
-		 * If any of the other planes is on top of this plane and uses
-		 * a format with an alpha component, mark this plane as being
-		 * dependent, meaning it's alpha value will be 1 minus the sum
-		 * of alpha components of the overlapping planes.
+		 * Missing framebuffer means that plane is disabled, in this
+		 * case mark B / C window as top to be able to differentiate
+		 * windows indices order in regards to zPos for the middle
+		 * window X / Y registers programming.
 		 */
-		if (p->index > tegra->index) {
-			if (__drm_format_has_alpha(new->fb->format->format))
-				state->dependent[index] = true;
-
-			/* keep track of the Z position */
-			zpos[index] = p->index;
-		}
+		if (!new->fb)
+			state->blending[index].top = (index == 1);
 	}
+}
+
+static int tegra_plane_setup_transparency(struct tegra_plane *tegra,
+					  struct tegra_plane_state *state)
+{
+	struct tegra_plane_state *tegra_state;
+	struct drm_plane_state *new;
+	struct drm_plane *plane;
+	int err;
 
 	/*
-	 * The region where three windows overlap is the intersection of the
-	 * two regions where two windows overlap. It contributes to the area
-	 * if any of the windows on top of it have an alpha component.
+	 * If planes zpos / transparency changed, sibling planes blending
+	 * state may require adjustment and in this case they will be included
+	 * into this atom commit, otherwise blending state is unchanged.
 	 */
-	for (i = 0; i < 2; i++)
-		state->dependent[2] = state->dependent[2] ||
-				      state->dependent[i];
+	err = tegra_plane_check_transparency(tegra, state);
+	if (err <= 0)
+		return err;
 
 	/*
-	 * However, if any of the windows on top of this window is opaque, it
-	 * will completely conceal this window within that area, so avoid the
-	 * window from contributing to the area.
+	 * All planes are now in the atomic state, walk them up and update
+	 * transparency state for each plane.
 	 */
-	for (i = 0; i < 2; i++) {
-		if (zpos[i] > tegra->index)
-			state->dependent[2] = state->dependent[2] &&
-					      state->dependent[i];
+	drm_for_each_plane(plane, tegra->base.dev) {
+		struct tegra_plane *p = to_tegra_plane(plane);
+
+		/* skip planes on different CRTCs */
+		if (p->dc != tegra->dc)
+			continue;
+
+		new = drm_atomic_get_new_plane_state(state->base.state, plane);
+		tegra_state = to_tegra_plane_state(new);
+
+		/*
+		 * There is no need to update blending state for the disabled
+		 * plane.
+		 */
+		if (new->fb)
+			tegra_plane_update_transparency(p, tegra_state);
 	}
+
+	return 0;
+}
+
+int tegra_plane_setup_legacy_state(struct tegra_plane *tegra,
+				   struct tegra_plane_state *state)
+{
+	int err;
+
+	err = tegra_plane_setup_opacity(tegra, state);
+	if (err < 0)
+		return err;
+
+	err = tegra_plane_setup_transparency(tegra, state);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/plane.h
index 6938719e7e5d..7360ddfafee8 100644
--- a/drivers/gpu/drm/tegra/plane.h
+++ b/drivers/gpu/drm/tegra/plane.h
@@ -34,6 +34,11 @@ static inline struct tegra_plane *to_tegra_plane(struct drm_plane *plane)
 	return container_of(plane, struct tegra_plane, base);
 }
 
+struct tegra_plane_legacy_blending_state {
+	bool alpha;
+	bool top;
+};
+
 struct tegra_plane_state {
 	struct drm_plane_state base;
 
@@ -42,8 +47,8 @@ struct tegra_plane_state {
 	u32 swap;
 
 	/* used for legacy blending support only */
+	struct tegra_plane_legacy_blending_state blending[2];
 	bool opaque;
-	bool dependent[3];
 };
 
 static inline struct tegra_plane_state *
@@ -62,9 +67,7 @@ int tegra_plane_state_add(struct tegra_plane *plane,
 
 int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap);
 bool tegra_plane_format_is_yuv(unsigned int format, bool *planar);
-bool tegra_plane_format_has_alpha(unsigned int format);
-int tegra_plane_format_get_alpha(unsigned int opaque, unsigned int *alpha);
-void tegra_plane_check_dependent(struct tegra_plane *tegra,
-				 struct tegra_plane_state *state);
+int tegra_plane_setup_legacy_state(struct tegra_plane *tegra,
+				   struct tegra_plane_state *state);
 
 #endif /* TEGRA_PLANE_H */
-- 
2.17.0
