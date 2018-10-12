Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C10C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B75F2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YOM/qwtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B75F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeJMDvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:51:35 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35504 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeJMDvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:51:35 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9CKHLKE028916;
        Fri, 12 Oct 2018 15:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539375441;
        bh=p19EdzCQD7STgl8aN0/v0hgY9PN/3bURDuM55TlhzxM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YOM/qwtEHjX4eMYmFNij5Ky4BgQhRnotRymk0zKjATgGUu46WpDYC8Ixj5IWfqH+1
         PYWs9DiGFeRSrsxe1t8pgu98BELP9Xf2jqx5ZUg/EqnB9iljegu5e9pO+wv//0KA6a
         hvrELxt81jOdlYBnPBRNFsHYyxsm1JRIu9uPLYy0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9CKHLeF030296;
        Fri, 12 Oct 2018 15:17:21 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 12
 Oct 2018 15:17:21 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 12 Oct 2018 15:17:20 -0500
Received: from uda0869644a.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9CKH7Ec000402;
        Fri, 12 Oct 2018 15:17:20 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>, Benoit Parrot <bparrot@ti.com>
Subject: [Patch v4 8/8] drm/omap: Add a 'right overlay' to plane state
Date:   Fri, 12 Oct 2018 15:17:03 -0500
Message-ID: <20181012201703.29065-9-bparrot@ti.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20181012201703.29065-1-bparrot@ti.com>
References: <20181012201703.29065-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the drm_plane has a source width that's greater than the max width
supported by a single hw overlay, then we assign a 'r_overlay' to it in
omap_plane_atomic_check().

Both overlays should have the capabilities required to handle the source
framebuffer. The only parameters that vary between the left and right
hwoverlays are the src_w, crtc_w, src_x and crtc_x as we just even chop
the fb into left and right halves.

We also take care of not creating odd width size when dealing with YUV
formats.

Since both halves need to be 'appear' side by side the zpos is
recalculated when dealing with dual overlay cases so that the other
planes zpos is consistent.

Depending on user space usage it is possible that on occasion the number
of requested planes exceeds the numbers of overlays required to display
them. In that case a failure would be returned for the plane that cannot
be handled at that time. It is up to user space to make sure the H/W
resource are not over-subscribed.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c     |  91 ++++++++++++++++++++++-
 drivers/gpu/drm/omapdrm/omap_fb.c      |  33 ++++++++-
 drivers/gpu/drm/omapdrm/omap_fb.h      |   4 +-
 drivers/gpu/drm/omapdrm/omap_overlay.c |  31 +++++++-
 drivers/gpu/drm/omapdrm/omap_overlay.h |   3 +-
 drivers/gpu/drm/omapdrm/omap_plane.c   | 128 +++++++++++++++++++++++++++++++--
 drivers/gpu/drm/omapdrm/omap_plane.h   |   1 +
 7 files changed, 278 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 94658ec79c76..307cd905fd02 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -118,6 +118,95 @@ static void omap_atomic_commit_tail(struct drm_atomic_state *old_state)
 	priv->dispc_ops->runtime_put(priv->dispc);
 }
 
+static int drm_atomic_state_normalized_zpos_cmp(const void *a, const void *b)
+{
+	const struct drm_plane_state *sa = *(struct drm_plane_state **)a;
+	const struct drm_plane_state *sb = *(struct drm_plane_state **)b;
+
+	if (sa->normalized_zpos != sb->normalized_zpos)
+		return sa->normalized_zpos - sb->normalized_zpos;
+	else
+		return sa->plane->base.id - sb->plane->base.id;
+}
+
+static int omap_atomic_update_normalize_zpos(struct drm_device *dev,
+					     struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *old_state, *new_state;
+	struct drm_plane *plane;
+	int c, i, n, inc;
+	int total_planes = dev->mode_config.num_total_plane;
+	struct drm_plane_state **states;
+	int ret = 0;
+
+	states = kmalloc_array(total_planes, sizeof(*states), GFP_KERNEL);
+	if (!states)
+		return -ENOMEM;
+
+	for_each_oldnew_crtc_in_state(state, crtc, old_state, new_state, c) {
+		if (old_state->plane_mask == new_state->plane_mask &&
+		    !new_state->zpos_changed)
+			continue;
+
+		/* Reset plane increment and index value for every crtc */
+		n = 0;
+
+		/*
+		 * Normalization process might create new states for planes
+		 * which normalized_zpos has to be recalculated.
+		 */
+		drm_for_each_plane_mask(plane, dev, new_state->plane_mask) {
+			struct drm_plane_state *plane_state =
+				drm_atomic_get_plane_state(new_state->state,
+							   plane);
+			if (IS_ERR(plane_state)) {
+				ret = PTR_ERR(plane_state);
+				goto done;
+			}
+			states[n++] = plane_state;
+		}
+
+		sort(states, n, sizeof(*states),
+		     drm_atomic_state_normalized_zpos_cmp, NULL);
+
+		for (i = 0, inc = 0; i < n; i++) {
+			plane = states[i]->plane;
+
+			states[i]->normalized_zpos = i + inc;
+			DRM_DEBUG_ATOMIC("[PLANE:%d:%s] updated normalized zpos value %d\n",
+					 plane->base.id, plane->name,
+					 states[i]->normalized_zpos);
+
+			if (is_omap_plane_dual_overlay(states[i]))
+				inc++;
+		}
+		new_state->zpos_changed = true;
+	}
+
+done:
+	kfree(states);
+	return ret;
+}
+
+static int omap_atomic_check(struct drm_device *dev,
+			     struct drm_atomic_state *state)
+{
+	int ret;
+
+	ret = drm_atomic_helper_check(dev, state);
+	if (ret)
+		return ret;
+
+	if (dev->mode_config.normalize_zpos) {
+		ret = omap_atomic_update_normalize_zpos(dev, state);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct drm_mode_config_helper_funcs omap_mode_config_helper_funcs = {
 	.atomic_commit_tail = omap_atomic_commit_tail,
 };
@@ -125,7 +214,7 @@ static const struct drm_mode_config_helper_funcs omap_mode_config_helper_funcs =
 static const struct drm_mode_config_funcs omap_mode_config_funcs = {
 	.fb_create = omap_framebuffer_create,
 	.output_poll_changed = drm_fb_helper_output_poll_changed,
-	.atomic_check = drm_atomic_helper_check,
+	.atomic_check = omap_atomic_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index 4d264fd554d8..13d7fa7b31fc 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -123,7 +123,9 @@ static u32 drm_rotation_to_tiler(unsigned int drm_rot)
 /* update ovl info for scanout, handles cases of multi-planar fb's, etc.
  */
 void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
-		struct drm_plane_state *state, struct omap_overlay_info *info)
+		struct drm_plane_state *state,
+		struct omap_overlay_info *info,
+		struct omap_overlay_info *r_info)
 {
 	struct omap_framebuffer *omap_fb = to_omap_framebuffer(fb);
 	const struct drm_format_info *format = omap_fb->format;
@@ -213,6 +215,35 @@ void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
 	} else {
 		info->p_uv_addr = 0;
 	}
+
+	if (r_info) {
+		info->width /= 2;
+		info->out_width /= 2;
+
+		*r_info = *info;
+
+		if (fb->format->is_yuv) {
+			if (info->width & 1) {
+				info->width++;
+				r_info->width--;
+			}
+
+			if (info->out_width & 1) {
+				info->out_width++;
+				r_info->out_width--;
+			}
+		}
+
+		r_info->pos_x = info->pos_x + info->out_width;
+
+		r_info->paddr =	get_linear_addr(fb, format, 0,
+						x + info->width, y);
+		if (fb->format->format == DRM_FORMAT_NV12) {
+			r_info->p_uv_addr =
+				get_linear_addr(fb, format, 1,
+						x + info->width, y);
+		}
+	}
 }
 
 /* pin, prepare for scanout: */
diff --git a/drivers/gpu/drm/omapdrm/omap_fb.h b/drivers/gpu/drm/omapdrm/omap_fb.h
index c20cb4bc714d..a649fce0f0f1 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.h
+++ b/drivers/gpu/drm/omapdrm/omap_fb.h
@@ -37,7 +37,9 @@ struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
 int omap_framebuffer_pin(struct drm_framebuffer *fb);
 void omap_framebuffer_unpin(struct drm_framebuffer *fb);
 void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
-		struct drm_plane_state *state, struct omap_overlay_info *info);
+		struct drm_plane_state *state,
+		struct omap_overlay_info *info,
+		struct omap_overlay_info *r_info);
 bool omap_framebuffer_supports_rotation(struct drm_framebuffer *fb);
 void omap_framebuffer_describe(struct drm_framebuffer *fb, struct seq_file *m);
 
diff --git a/drivers/gpu/drm/omapdrm/omap_overlay.c b/drivers/gpu/drm/omapdrm/omap_overlay.c
index 3a58582cd56f..d27b4c3d769b 100644
--- a/drivers/gpu/drm/omapdrm/omap_overlay.c
+++ b/drivers/gpu/drm/omapdrm/omap_overlay.c
@@ -65,12 +65,14 @@ omap_plane_find_free_overlay(struct drm_device *dev,
 
 int omap_overlay_assign(struct drm_atomic_state *s, struct drm_plane *plane,
 			u32 caps, u32 fourcc, u32 crtc_mask,
-			struct omap_hw_overlay **overlay)
+			struct omap_hw_overlay **overlay,
+			struct omap_hw_overlay **r_overlay)
 {
 	struct omap_drm_private *priv = s->dev->dev_private;
 	struct omap_global_state *new_global_state, *old_global_state;
 	struct drm_plane **overlay_map;
-	struct omap_hw_overlay *ovl;
+	struct omap_hw_overlay *ovl, *r_ovl;
+	u32 save_possible_crtcs;
 
 	new_global_state = omap_get_global_state(s);
 	if (IS_ERR(new_global_state))
@@ -92,12 +94,37 @@ int omap_overlay_assign(struct drm_atomic_state *s, struct drm_plane *plane,
 		if (!ovl)
 			return -ENOMEM;
 
+		/* in case we need to backtrack */
+		save_possible_crtcs = ovl->possible_crtcs;
+
 		ovl->possible_crtcs = crtc_mask;
 		overlay_map[ovl->idx] = plane;
 		*overlay = ovl;
 
+		if (r_overlay) {
+			r_ovl = omap_plane_find_free_overlay(s->dev,
+							     overlay_map,
+							     caps, fourcc,
+							     crtc_mask);
+			if (!r_ovl) {
+				ovl->possible_crtcs = save_possible_crtcs;
+				overlay_map[ovl->idx] = NULL;
+				*overlay = NULL;
+				return -ENOMEM;
+			}
+
+			r_ovl->possible_crtcs = crtc_mask;
+			overlay_map[r_ovl->idx] = plane;
+			*r_overlay = r_ovl;
+		}
+
 		DBG("%s: assign to plane %s caps %x on crtc %x",
 		    (*overlay)->name, plane->name, caps, crtc_mask);
+
+		if (r_overlay) {
+			DBG("%s: assign to right of plane %s caps %x on crtc %x",
+			    (*r_overlay)->name, plane->name, caps, crtc_mask);
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/omapdrm/omap_overlay.h b/drivers/gpu/drm/omapdrm/omap_overlay.h
index d5033ee481c2..a800468511f1 100644
--- a/drivers/gpu/drm/omapdrm/omap_overlay.h
+++ b/drivers/gpu/drm/omapdrm/omap_overlay.h
@@ -30,7 +30,8 @@ int omap_hwoverlays_init(struct omap_drm_private *priv);
 void omap_hwoverlays_destroy(struct omap_drm_private *priv);
 int omap_overlay_assign(struct drm_atomic_state *s, struct drm_plane *plane,
 			u32 caps, u32 fourcc, u32 crtc_mask,
-			struct omap_hw_overlay **overlay);
+			struct omap_hw_overlay **overlay,
+			struct omap_hw_overlay **r_overlay);
 void omap_overlay_release(struct drm_atomic_state *s,
 			  struct drm_plane *plane,
 			  struct omap_hw_overlay *overlay);
diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
index 116071982a0e..7fe11c1929d8 100644
--- a/drivers/gpu/drm/omapdrm/omap_plane.c
+++ b/drivers/gpu/drm/omapdrm/omap_plane.c
@@ -32,6 +32,7 @@ struct omap_plane_state {
 	struct drm_plane_state base;
 
 	struct omap_hw_overlay *overlay;
+	struct omap_hw_overlay *r_overlay;  /* right overlay */
 };
 
 #define to_omap_plane(x) container_of(x, struct omap_plane, base)
@@ -42,6 +43,13 @@ struct omap_plane {
 	const char *name;
 };
 
+bool is_omap_plane_dual_overlay(struct drm_plane_state *state)
+{
+	struct omap_plane_state *omap_state = to_omap_plane_state(state);
+
+	return !!omap_state->r_overlay;
+}
+
 static int omap_plane_prepare_fb(struct drm_plane *plane,
 				 struct drm_plane_state *new_state)
 {
@@ -66,15 +74,20 @@ static void omap_plane_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state *state = plane->state;
 	struct omap_plane_state *new_omap_state;
 	struct omap_plane_state *old_omap_state;
-	struct omap_overlay_info info;
-	enum omap_plane_id ovl_id;
+	struct omap_overlay_info info, r_info;
+	enum omap_plane_id ovl_id, r_ovl_id;
 	int ret;
+	bool dual_ovl;
 
 	new_omap_state = to_omap_plane_state(state);
 	old_omap_state = to_omap_plane_state(old_state);
 
+	dual_ovl = is_omap_plane_dual_overlay(state);
+
 	/* Cleanup previously held overlay if needed */
 	omap_overlay_disable(old_state->state, plane, old_omap_state->overlay);
+	omap_overlay_disable(old_state->state, plane,
+			     old_omap_state->r_overlay);
 
 	if (!new_omap_state->overlay) {
 		DBG("[PLANE:%d:%s] overlay_id: ??? (%p)", plane->base.id, plane->name,
@@ -93,8 +106,11 @@ static void omap_plane_atomic_update(struct drm_plane *plane,
 	info.global_alpha = 0xff;
 	info.zorder = state->normalized_zpos;
 
+	r_info = info;
+
 	/* update scanout: */
-	omap_framebuffer_update_scanout(state->fb, state, &info);
+	omap_framebuffer_update_scanout(state->fb, state, &info,
+					dual_ovl ? &r_info : NULL);
 
 	DBG("%s: %dx%d -> %dx%d (%d)",
 	    new_omap_state->overlay->name, info.width, info.height,
@@ -102,18 +118,50 @@ static void omap_plane_atomic_update(struct drm_plane *plane,
 	DBG("%d,%d %pad %pad", info.pos_x, info.pos_y,
 	    &info.paddr, &info.p_uv_addr);
 
+	if (dual_ovl) {
+		r_ovl_id = new_omap_state->r_overlay->overlay_id;
+		/*
+		 * If the current plane uses 2 hw planes the very next
+		 * zorder is used by the r_overlay so we just use the
+		 * main overlay zorder + 1
+		 */
+		r_info.zorder = info.zorder + 1;
+
+		DBG("%s: %dx%d -> %dx%d (%d)",
+		    new_omap_state->r_overlay->name,
+		    r_info.width, r_info.height,
+		    r_info.out_width, r_info.out_height, r_info.screen_width);
+		DBG("%d,%d %pad %pad", r_info.pos_x, r_info.pos_y,
+		    &r_info.paddr, &r_info.p_uv_addr);
+	}
+
 	/* and finally, update omapdss: */
 	ret = priv->dispc_ops->ovl_setup(priv->dispc, ovl_id, &info,
 			      omap_crtc_timings(state->crtc), false,
 			      omap_crtc_channel(state->crtc));
 	if (ret) {
-		dev_err(plane->dev->dev, "Failed to setup plane %s\n",
+		dev_err(plane->dev->dev, "Failed to setup plane1 %s\n",
 			omap_plane->name);
 		priv->dispc_ops->ovl_enable(priv->dispc, ovl_id, false);
 		return;
 	}
 
 	priv->dispc_ops->ovl_enable(priv->dispc, ovl_id, true);
+
+	if (dual_ovl) {
+		ret = priv->dispc_ops->ovl_setup(priv->dispc, r_ovl_id, &r_info,
+				      omap_crtc_timings(state->crtc), false,
+				      omap_crtc_channel(state->crtc));
+		if (ret) {
+			dev_err(plane->dev->dev, "Failed to setup plane2 %s\n",
+				omap_plane->name);
+			priv->dispc_ops->ovl_enable(priv->dispc, r_ovl_id, false);
+			priv->dispc_ops->ovl_enable(priv->dispc, ovl_id, false);
+			return;
+		}
+
+		priv->dispc_ops->ovl_enable(priv->dispc, r_ovl_id, true);
+	}
 }
 
 static void omap_plane_atomic_disable(struct drm_plane *plane,
@@ -135,6 +183,11 @@ static void omap_plane_atomic_disable(struct drm_plane *plane,
 
 	omap_overlay_disable(old_state->state, plane, old_omap_state->overlay);
 	new_omap_state->overlay = NULL;
+	if (is_omap_plane_dual_overlay(old_state)) {
+		omap_overlay_disable(old_state->state, plane,
+				     old_omap_state->r_overlay);
+		new_omap_state->r_overlay = NULL;
+	}
 }
 
 #define FRAC_16_16(mult, div)    (((mult) << 16) / (div))
@@ -153,6 +206,8 @@ static int omap_plane_atomic_check(struct drm_plane *plane,
 	u32 fourcc;
 	u32 caps = 0;
 	bool new_hw_overlay = false;
+	bool new_r_hw_overlay = false;
+	bool is_fourcc_yuv = false;
 	int min_scale, max_scale;
 	int ret;
 
@@ -179,8 +234,31 @@ static int omap_plane_atomic_check(struct drm_plane *plane,
 	if (state->src_h > height_fp || state->crtc_h > height)
 		return -EINVAL;
 
-	if (state->src_w > width_fp || state->crtc_w > width)
-		return -EINVAL;
+	if (state->fb)
+		is_fourcc_yuv = state->fb->format->is_yuv;
+
+	if (state->src_w > width_fp || state->crtc_w > width) {
+		if (is_fourcc_yuv &&
+		    (((state->src_w >> 16) / 2 & 1) ||
+		     state->crtc_w / 2 & 1)) {
+			/*
+			 * When calculating the split overlay width
+			 * and it yield an odd value we will need to adjust
+			 * the indivual width +/- 1. So make sure it fits
+			 */
+			if (state->src_w <= ((2 * width - 1) << 16) &&
+			    state->crtc_w <= (2 * width - 1))
+				new_r_hw_overlay = true;
+			else
+				return -EINVAL;
+		} else {
+			if (state->src_w <= (2 * width_fp) &&
+			    state->crtc_w <= (2 * width))
+				new_r_hw_overlay = true;
+			else
+				return -EINVAL;
+		}
+	}
 
 	min_scale = FRAC_16_16(1, 4);
 	max_scale = FRAC_16_16(8, 1);
@@ -224,33 +302,57 @@ static int omap_plane_atomic_check(struct drm_plane *plane,
 						fourcc))
 				new_hw_overlay = true;
 		}
+		/*
+		 * check if we need two overlays and only have 1 or
+		 * if we had 2 overlays but will only need 1
+		 */
+		if ((new_r_hw_overlay && !omap_state->r_overlay) ||
+		    (!new_r_hw_overlay && omap_state->r_overlay))
+			new_hw_overlay = true;
 
 		if (new_hw_overlay) {
 			struct omap_hw_overlay *old_ovl =
 						omap_state->overlay;
+			struct omap_hw_overlay *old_r_ovl =
+						omap_state->r_overlay;
 			struct omap_hw_overlay *new_ovl = NULL;
+			struct omap_hw_overlay *new_r_ovl = NULL;
 
 			omap_overlay_release(state->state, plane, old_ovl);
+			omap_overlay_release(state->state, plane, old_r_ovl);
 
 			ret = omap_overlay_assign(state->state, plane, caps,
-						  fourcc, crtc_mask, &new_ovl);
+						  fourcc, crtc_mask, &new_ovl,
+						  new_r_hw_overlay ?
+						  &new_r_ovl : NULL);
 			if (ret) {
 				DBG("%s: failed to assign hw_overlay(s)!",
 				    plane->name);
 				omap_state->overlay = NULL;
+				omap_state->r_overlay = NULL;
 				return ret;
 			}
 
 			omap_state->overlay = new_ovl;
+			if (new_r_hw_overlay)
+				omap_state->r_overlay = new_r_ovl;
+			else
+				omap_state->r_overlay = NULL;
 		}
 	} else {
 		omap_overlay_release(state->state, plane, omap_state->overlay);
+		omap_overlay_release(state->state, plane,
+				     omap_state->r_overlay);
 		omap_state->overlay = NULL;
+		omap_state->r_overlay = NULL;
 	}
 
 	if (omap_state->overlay)
 		DBG("plane: %s overlay_id: %d", plane->name,
 		    omap_state->overlay->overlay_id);
+	if (omap_state->r_overlay)
+		DBG("plane: %s r_overlay_id: %d", plane->name,
+		    omap_state->r_overlay->overlay_id);
 
 	return 0;
 }
@@ -363,6 +465,18 @@ static void omap_plane_atomic_print_state(struct drm_printer *p,
 		drm_printf(p, "\t\tpossible_crtcs=0x%x\n",
 			   omap_state->overlay->possible_crtcs);
 	}
+
+	drm_printf(p, "\tr_overlay=%s\n", omap_state->r_overlay ?
+					  omap_state->r_overlay->name :
+					  "(null)");
+	if (omap_state->r_overlay) {
+		drm_printf(p, "\t\tidx=%d\n", omap_state->r_overlay->idx);
+		drm_printf(p, "\t\toverlay_id=%d\n",
+			   omap_state->r_overlay->overlay_id);
+		drm_printf(p, "\t\tcaps=0x%x\n", omap_state->r_overlay->caps);
+		drm_printf(p, "\t\tpossible_crtcs=0x%x\n",
+			   omap_state->r_overlay->possible_crtcs);
+	}
 }
 
 static int omap_plane_atomic_set_property(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/omapdrm/omap_plane.h b/drivers/gpu/drm/omapdrm/omap_plane.h
index dc5e82ad061d..ea31af8b6aa6 100644
--- a/drivers/gpu/drm/omapdrm/omap_plane.h
+++ b/drivers/gpu/drm/omapdrm/omap_plane.h
@@ -33,5 +33,6 @@ struct drm_plane *omap_plane_init(struct drm_device *dev,
 		u32 possible_crtcs);
 void omap_plane_install_properties(struct drm_plane *plane,
 		struct drm_mode_object *obj);
+bool is_omap_plane_dual_overlay(struct drm_plane_state *state);
 
 #endif /* __OMAPDRM_PLANE_H__ */
-- 
2.9.0

