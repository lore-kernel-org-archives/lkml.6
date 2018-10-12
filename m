Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D2AC71123
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBBC21477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M2rvsJ+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBBC21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeJMDvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:51:33 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56586 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeJMDvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:51:32 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9CKHIIh031510;
        Fri, 12 Oct 2018 15:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539375438;
        bh=ne7PB44QuPc4Z9+DK+WazWclTjvnRsyuh24nxu+sfVU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=M2rvsJ+xt4PbqbDlWACivcdt7EJs0Yt67G+MaZuZSWZTkezvXB2Pbj37ECYTJqugB
         Ignc+rMDZ79cKouXUOoCUtVicopu43o2MFbfBMdiNcXmH8ZUgrxOkYYJA0trEMFuhs
         URIMUM8hjb+kqhKsfyXhpc51glZ+aaqm0CkjMfcI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9CKHIMt030251;
        Fri, 12 Oct 2018 15:17:18 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 12
 Oct 2018 15:17:17 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 12 Oct 2018 15:17:17 -0500
Received: from uda0869644a.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9CKH7Ea000402;
        Fri, 12 Oct 2018 15:17:17 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>, Benoit Parrot <bparrot@ti.com>
Subject: [Patch v4 6/8] drm/omap: dynamically assign hw overlays to planes
Date:   Fri, 12 Oct 2018 15:17:01 -0500
Message-ID: <20181012201703.29065-7-bparrot@ti.com>
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

(re)assign the hw overlays to planes based on required caps, and to
handle situations where we could not modify an in-use plane.

This means all planes advertise the superset of formats and properties.
Userspace must (as always) use atomic TEST_ONLY step for atomic updates,
as not all planes may be available for use on every frame.

The mapping of hwoverlays to plane is stored in omap_global_state, so
that state updates are atomically committed in the same way that
plane/etc state updates are managed.  This is needed because the
omap_plane_state keeps a pointer to the hwoverlay, and we don't want
global state to become out of sync with the plane state if an atomic
update fails, we hit deadlock/ backoff scenario, etc.  The use of
global_state_lock keeps multiple parallel updates which both re-assign
hwoverlays properly serialized.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.h     |   3 +
 drivers/gpu/drm/omapdrm/omap_overlay.c | 143 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/omapdrm/omap_overlay.h |   9 ++
 drivers/gpu/drm/omapdrm/omap_plane.c   | 153 ++++++++++++++++++++++++++-------
 4 files changed, 276 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index f374dc100447..00326f2a2c2c 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -64,6 +64,9 @@ struct omap_global_state {
 	struct drm_private_state base;
 
 	struct drm_atomic_state *state;
+
+	/* global atomic state of assignment between overlays and planes */
+	struct drm_plane *hwoverlay_to_plane[8];
 };
 
 struct omap_drm_private {
diff --git a/drivers/gpu/drm/omapdrm/omap_overlay.c b/drivers/gpu/drm/omapdrm/omap_overlay.c
index 7a09b0aa823a..3a58582cd56f 100644
--- a/drivers/gpu/drm/omapdrm/omap_overlay.c
+++ b/drivers/gpu/drm/omapdrm/omap_overlay.c
@@ -21,6 +21,149 @@ static const char * const overlay_id_to_name[] = {
 	[OMAP_DSS_VIDEO3] = "vid3",
 };
 
+static struct omap_hw_overlay *
+omap_plane_find_free_overlay(struct drm_device *dev,
+			     struct drm_plane *hwoverlay_to_plane[],
+			     u32 caps, u32 fourcc, u32 crtc_mask)
+{
+	struct omap_drm_private *priv = dev->dev_private;
+	const struct dispc_ops *ops = priv->dispc_ops;
+	int i;
+
+	DBG("caps: %x fourcc: %x crtc: %x", caps, fourcc, crtc_mask);
+
+	for (i = 0; i < priv->num_ovls; i++) {
+		struct omap_hw_overlay *cur = priv->overlays[i];
+
+		DBG("%d: id: %d cur->caps: %x cur->crtc: %x",
+		    cur->idx, cur->overlay_id, cur->caps, cur->possible_crtcs);
+
+		/* skip if already in-use */
+		if (hwoverlay_to_plane[cur->idx])
+			continue;
+
+		/* check if allowed on crtc */
+		if (!(cur->possible_crtcs & crtc_mask))
+			continue;
+
+		/* skip if doesn't support some required caps: */
+		if (caps & ~cur->caps)
+			continue;
+
+		/* check supported format */
+		if (!ops->ovl_color_mode_supported(priv->dispc,
+						   cur->overlay_id,
+						   fourcc))
+			continue;
+
+		return cur;
+	}
+
+	DBG("no match");
+	return NULL;
+}
+
+int omap_overlay_assign(struct drm_atomic_state *s, struct drm_plane *plane,
+			u32 caps, u32 fourcc, u32 crtc_mask,
+			struct omap_hw_overlay **overlay)
+{
+	struct omap_drm_private *priv = s->dev->dev_private;
+	struct omap_global_state *new_global_state, *old_global_state;
+	struct drm_plane **overlay_map;
+	struct omap_hw_overlay *ovl;
+
+	new_global_state = omap_get_global_state(s);
+	if (IS_ERR(new_global_state))
+		return PTR_ERR(new_global_state);
+
+	/*
+	 * grab old_state after omap_get_global_state(),
+	 * since now we hold lock:
+	 */
+	old_global_state = omap_get_existing_global_state(priv);
+	DBG("new_global_state: %p old_global_state: %p",
+	    new_global_state, old_global_state);
+
+	overlay_map = new_global_state->hwoverlay_to_plane;
+
+	if (!*overlay) {
+		ovl = omap_plane_find_free_overlay(s->dev, overlay_map,
+						   caps, fourcc, crtc_mask);
+		if (!ovl)
+			return -ENOMEM;
+
+		ovl->possible_crtcs = crtc_mask;
+		overlay_map[ovl->idx] = plane;
+		*overlay = ovl;
+
+		DBG("%s: assign to plane %s caps %x on crtc %x",
+		    (*overlay)->name, plane->name, caps, crtc_mask);
+	}
+
+	return 0;
+}
+
+void omap_overlay_release(struct drm_atomic_state *s,
+			  struct drm_plane *plane,
+			  struct omap_hw_overlay *overlay)
+{
+	struct omap_global_state *state = omap_get_global_state(s);
+	struct drm_plane **overlay_map = state->hwoverlay_to_plane;
+
+	if (!overlay)
+		return;
+
+	if (WARN_ON(!overlay_map[overlay->idx]))
+		return;
+	/*
+	 * Check that the overlay we are releasing is actually
+	 * assigned to the plane we are trying to release it from.
+	 */
+	if (overlay_map[overlay->idx] == plane) {
+		DBG("%s: release from plane %s", overlay->name, plane->name);
+
+		overlay_map[overlay->idx] = NULL;
+	}
+}
+
+void omap_overlay_disable(struct drm_atomic_state *s,
+			  struct drm_plane *plane,
+			  struct omap_hw_overlay *overlay)
+{
+	struct omap_drm_private *priv = s->dev->dev_private;
+	struct drm_plane **overlay_map;
+	struct omap_global_state *old_state;
+
+	old_state = omap_get_existing_global_state(priv);
+	overlay_map = old_state->hwoverlay_to_plane;
+
+	if (!overlay)
+		return;
+
+	/*
+	 * Check that the overlay we are trying to disable has not
+	 * been re-assigned to another plane already
+	 */
+	if (!overlay_map[overlay->idx]) {
+		DBG("%s: on %s disabled", overlay->name, plane->name);
+
+		/* disable the overlay */
+		priv->dispc_ops->ovl_enable(priv->dispc,
+					    overlay->overlay_id, false);
+
+		/*
+		 * Since we are disabling this overlay in this
+		 * atomic cycle we can reset the available crtcs
+		 * it can be used on
+		 */
+		overlay->possible_crtcs = (1 << priv->num_pipes) - 1;
+	}
+
+	/*
+	 * Otherwise the overlay is still in use so leave it alone
+	 */
+}
+
 static void omap_overlay_destroy(struct omap_hw_overlay *overlay)
 {
 	kfree(overlay);
diff --git a/drivers/gpu/drm/omapdrm/omap_overlay.h b/drivers/gpu/drm/omapdrm/omap_overlay.h
index 892fecb67adb..d5033ee481c2 100644
--- a/drivers/gpu/drm/omapdrm/omap_overlay.h
+++ b/drivers/gpu/drm/omapdrm/omap_overlay.h
@@ -28,4 +28,13 @@ struct omap_hw_overlay {
 
 int omap_hwoverlays_init(struct omap_drm_private *priv);
 void omap_hwoverlays_destroy(struct omap_drm_private *priv);
+int omap_overlay_assign(struct drm_atomic_state *s, struct drm_plane *plane,
+			u32 caps, u32 fourcc, u32 crtc_mask,
+			struct omap_hw_overlay **overlay);
+void omap_overlay_release(struct drm_atomic_state *s,
+			  struct drm_plane *plane,
+			  struct omap_hw_overlay *overlay);
+void omap_overlay_disable(struct drm_atomic_state *s,
+			  struct drm_plane *plane,
+			  struct omap_hw_overlay *overlay);
 #endif /* __OMAPDRM_OVERLAY_H__ */
diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
index b0e60119c0a1..224520348fc5 100644
--- a/drivers/gpu/drm/omapdrm/omap_plane.c
+++ b/drivers/gpu/drm/omapdrm/omap_plane.c
@@ -30,6 +30,8 @@
 
 struct omap_plane_state {
 	struct drm_plane_state base;
+
+	struct omap_hw_overlay *overlay;
 };
 
 #define to_omap_plane(x) container_of(x, struct omap_plane, base)
@@ -38,8 +40,6 @@ struct omap_plane {
 	struct drm_plane base;
 	enum omap_plane_id id;
 	const char *name;
-
-	struct omap_hw_overlay *overlay;
 };
 
 static int omap_plane_prepare_fb(struct drm_plane *plane,
@@ -64,10 +64,25 @@ static void omap_plane_atomic_update(struct drm_plane *plane,
 	struct omap_drm_private *priv = plane->dev->dev_private;
 	struct omap_plane *omap_plane = to_omap_plane(plane);
 	struct drm_plane_state *state = plane->state;
+	struct omap_plane_state *new_omap_state;
+	struct omap_plane_state *old_omap_state;
 	struct omap_overlay_info info;
-	enum omap_plane_id ovl_id = omap_plane->overlay->overlay_id;
+	enum omap_plane_id ovl_id;
 	int ret;
 
+	new_omap_state = to_omap_plane_state(state);
+	old_omap_state = to_omap_plane_state(old_state);
+
+	/* Cleanup previously held overlay if needed */
+	omap_overlay_disable(old_state->state, plane, old_omap_state->overlay);
+
+	if (!new_omap_state->overlay) {
+		DBG("[PLANE:%d:%s] overlay_id: ??? (%p)", plane->base.id, plane->name,
+		    new_omap_state->overlay);
+		return;
+	}
+
+	ovl_id = new_omap_state->overlay->overlay_id;
 	DBG("[PLANE:%d:%s] overlay_id: %d", plane->base.id, plane->name,
 	    ovl_id);
 	DBG("%s, crtc=%p fb=%p", omap_plane->name, state->crtc, state->fb);
@@ -81,11 +96,11 @@ static void omap_plane_atomic_update(struct drm_plane *plane,
 	/* update scanout: */
 	omap_framebuffer_update_scanout(state->fb, state, &info);
 
-	DBG("%dx%d -> %dx%d (%d)", info.width, info.height,
-			info.out_width, info.out_height,
-			info.screen_width);
+	DBG("%s: %dx%d -> %dx%d (%d)",
+	    new_omap_state->overlay->name, info.width, info.height,
+	    info.out_width, info.out_height, info.screen_width);
 	DBG("%d,%d %pad %pad", info.pos_x, info.pos_y,
-			&info.paddr, &info.p_uv_addr);
+	    &info.paddr, &info.p_uv_addr);
 
 	/* and finally, update omapdss: */
 	ret = priv->dispc_ops->ovl_setup(priv->dispc, ovl_id, &info,
@@ -104,53 +119,62 @@ static void omap_plane_atomic_update(struct drm_plane *plane,
 static void omap_plane_atomic_disable(struct drm_plane *plane,
 				      struct drm_plane_state *old_state)
 {
-	struct omap_drm_private *priv = plane->dev->dev_private;
-	struct omap_plane *omap_plane = to_omap_plane(plane);
-	enum omap_plane_id ovl_id = omap_plane->overlay->overlay_id;
+	struct drm_plane_state *state = plane->state;
+	struct omap_plane_state *new_omap_state;
+	struct omap_plane_state *old_omap_state;
+
+	new_omap_state = to_omap_plane_state(state);
+	old_omap_state = to_omap_plane_state(old_state);
+
+	if (!old_omap_state->overlay)
+		return;
 
 	plane->state->rotation = DRM_MODE_ROTATE_0;
 	plane->state->zpos = plane->type == DRM_PLANE_TYPE_PRIMARY
-			   ? 0 : ovl_id;
+			   ? 0 : old_omap_state->overlay->overlay_id;
 
-	priv->dispc_ops->ovl_enable(priv->dispc, ovl_id, false);
+	omap_overlay_disable(old_state->state, plane, old_omap_state->overlay);
+	new_omap_state->overlay = NULL;
 }
 
+#define FRAC_16_16(mult, div)    (((mult) << 16) / (div))
 static int omap_plane_atomic_check(struct drm_plane *plane,
 				   struct drm_plane_state *state)
 {
 	struct omap_drm_private *priv = plane->dev->dev_private;
+	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
 	u16 width, height;
 	u32 width_fp, height_fp;
+	struct drm_plane_state *old_state = plane->state;
+	struct omap_plane_state *omap_state = to_omap_plane_state(state);
+	struct omap_global_state *omap_overlay_global_state;
+	u32 crtc_mask;
+	u32 fourcc;
+	u32 caps = 0;
+	bool new_hw_overlay = false;
+	int min_scale, max_scale;
+	int ret;
 
-	if (!state->fb)
-		return 0;
+	omap_overlay_global_state = omap_get_global_state(state->state);
+	if (IS_ERR(omap_overlay_global_state))
+		return PTR_ERR(omap_overlay_global_state);
+	DBG("%s: omap_overlay_global_state: %p", plane->name,
+	    omap_overlay_global_state);
 
 	priv->dispc_ops->ovl_get_max_size(priv->dispc, &width, &height);
 	width_fp = width << 16;
 	height_fp = height << 16;
 
-	/* crtc should only be NULL when disabling (i.e., !state->fb) */
-	if (WARN_ON(!state->crtc))
+	crtc = state->crtc ? state->crtc : plane->state->crtc;
+	if (!crtc)
 		return 0;
 
-	crtc_state = drm_atomic_get_existing_crtc_state(state->state, state->crtc);
+	crtc_state = drm_atomic_get_existing_crtc_state(state->state, crtc);
 	/* we should have a crtc state if the plane is attached to a crtc */
 	if (WARN_ON(!crtc_state))
 		return 0;
 
-	if (!crtc_state->enable)
-		return 0;
-
-	if (state->crtc_x < 0 || state->crtc_y < 0)
-		return -EINVAL;
-
-	if (state->crtc_x + state->crtc_w > crtc_state->adjusted_mode.hdisplay)
-		return -EINVAL;
-
-	if (state->crtc_y + state->crtc_h > crtc_state->adjusted_mode.vdisplay)
-		return -EINVAL;
-
 	/* Make sure dimensions are within bounds. */
 	if (state->src_h > height_fp || state->crtc_h > height)
 		return -EINVAL;
@@ -158,10 +182,76 @@ static int omap_plane_atomic_check(struct drm_plane *plane,
 	if (state->src_w > width_fp || state->crtc_w > width)
 		return -EINVAL;
 
+	min_scale = FRAC_16_16(1, 4);
+	max_scale = FRAC_16_16(8, 1);
+
+	ret = drm_atomic_helper_check_plane_state(state, crtc_state,
+						  min_scale, max_scale,
+						  true, true);
+	if (ret)
+		return ret;
+
 	if (state->rotation != DRM_MODE_ROTATE_0 &&
 	    !omap_framebuffer_supports_rotation(state->fb))
 		return -EINVAL;
 
+	DBG("%s: check (%d -> %d)", plane->name,
+	    old_state->visible, state->visible);
+
+	if (state->visible) {
+		if ((state->src_w >> 16) != state->crtc_w ||
+		    (state->src_h >> 16) != state->crtc_h)
+			caps |= OMAP_DSS_OVL_CAP_SCALE;
+
+		fourcc = state->fb->format->format;
+		crtc_mask = drm_crtc_mask(state->crtc);
+
+		/*
+		 * (re)allocate hw overlay if we don't have one or
+		 * there is a caps mismatch
+		 */
+		if (!omap_state->overlay ||
+		    (caps & ~omap_state->overlay->caps)) {
+			new_hw_overlay = true;
+		} else {
+			/* check if allowed on crtc */
+			if (!(omap_state->overlay->possible_crtcs & crtc_mask))
+				new_hw_overlay = true;
+
+			/* check supported format */
+			if (!priv->dispc_ops->ovl_color_mode_supported(priv->dispc,
+						omap_state->overlay->overlay_id,
+						fourcc))
+				new_hw_overlay = true;
+		}
+
+		if (new_hw_overlay) {
+			struct omap_hw_overlay *old_ovl =
+						omap_state->overlay;
+			struct omap_hw_overlay *new_ovl = NULL;
+
+			omap_overlay_release(state->state, plane, old_ovl);
+
+			ret = omap_overlay_assign(state->state, plane, caps,
+						  fourcc, crtc_mask, &new_ovl);
+			if (ret) {
+				DBG("%s: failed to assign hw_overlay(s)!",
+				    plane->name);
+				omap_state->overlay = NULL;
+				return ret;
+			}
+
+			omap_state->overlay = new_ovl;
+		}
+	} else {
+		omap_overlay_release(state->state, plane, omap_state->overlay);
+		omap_state->overlay = NULL;
+	}
+
+	if (omap_state->overlay)
+		DBG("plane: %s overlay_id: %d", plane->name,
+		    omap_state->overlay->overlay_id);
+
 	return 0;
 }
 
@@ -236,7 +326,7 @@ static void omap_plane_reset(struct drm_plane *plane)
 	 * plane.
 	 */
 	plane->state->zpos = plane->type == DRM_PLANE_TYPE_PRIMARY
-			   ? 0 : omap_plane->overlay->overlay_id;
+			   ? 0 : omap_plane->id;
 }
 
 static struct drm_plane_state *
@@ -328,14 +418,13 @@ struct drm_plane *omap_plane_init(struct drm_device *dev,
 
 	omap_plane->id = idx;
 	omap_plane->name = plane_id_to_name[idx];
-	omap_plane->overlay = priv->overlays[idx];
 
 	DBG("%s: type=%d", omap_plane->name, type);
 	DBG("	omap_plane->id: %d", omap_plane->id);
 	DBG("	crtc_mask: 0x%04x", possible_crtcs);
 
 	formats = priv->dispc_ops->ovl_get_color_modes(priv->dispc,
-						       omap_plane->overlay->overlay_id);
+						       omap_plane->id);
 	for (nformats = 0; formats[nformats]; ++nformats)
 		;
 
-- 
2.9.0

