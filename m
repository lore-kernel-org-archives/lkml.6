Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbeDEAGc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 20:06:32 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:14300 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752353AbeDEAGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 20:06:03 -0400
From: Deepak Rawat <drawat@vmware.com>
To: <dri-devel@lists.freedesktop.org>, <thellstrom@vmware.com>,
        <syeh@vmware.com>
CC: <linux-graphics-maintainer@vmware.com>, <daniel@ffwll.ch>,
        <ville.syrjala@linux.intel.com>, <lukasz.spintzyk@displaylink.com>,
        <noralf@tronnes.org>, <robdclark@gmail.com>, <gustavo@padovan.org>,
        <maarten.lankhorst@linux.intel.com>, <seanpaul@chromium.org>,
        <airlied@linux.ie>, <linux-kernel@vger.kernel.org>,
        Deepak Rawat <drawat@vmware.com>
Subject: [RFC 1/3] drm: Add DAMAGE_CLIPS property to plane
Date: Wed, 4 Apr 2018 16:49:06 -0700
Message-ID: <1522885748-67122-2-git-send-email-drawat@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522885748-67122-1-git-send-email-drawat@vmware.com>
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>

Optional plane property to mark damaged regions on the plane in
framebuffer coordinates of the framebuffer attached to the plane.

The layout of blob data is simply an array of drm_mode_rect with maximum
array size limited by DRM_MODE_FB_DIRTY_MAX_CLIPS. Unlike plane src
coordinates, damage clips are not in 16.16 fixed point.

Damage clips are a hint to kernel as which area of framebuffer has
changed since last page-flip. This should be helpful for some drivers
especially for virtual devices where each framebuffer change needs to
be transmitted over network, usb, etc.

Driver which are interested in enabling DAMAGE_CLIPS property for a
plane should enable this property using drm_plane_enable_damage_clips.

Signed-off-by: Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
Signed-off-by: Deepak Rawat <drawat@vmware.com>
---
 drivers/gpu/drm/drm_atomic.c        | 42 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_atomic_helper.c |  4 ++++
 drivers/gpu/drm/drm_mode_config.c   |  5 +++++
 drivers/gpu/drm/drm_plane.c         | 12 +++++++++++
 include/drm/drm_mode_config.h       | 15 +++++++++++++
 include/drm/drm_plane.h             | 16 ++++++++++++++
 include/uapi/drm/drm_mode.h         | 15 +++++++++++++
 7 files changed, 109 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 7d25c42..9226d24 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -669,6 +669,40 @@ static void drm_atomic_crtc_print_state(struct drm_printer *p,
 }
 
 /**
+ * drm_atomic_set_damage_for_plane - sets the damage clips property to plane
+ * @state: plane state
+ * @blob: damage clips in framebuffer coordinates
+ *
+ * Returns:
+ *
+ * Zero on success, error code on failure.
+ */
+static int drm_atomic_set_damage_for_plane(struct drm_plane_state *state,
+					   struct drm_property_blob *blob)
+{
+	if (blob == state->damage_clips)
+		return 0;
+
+	drm_property_blob_put(state->damage_clips);
+	state->damage_clips = NULL;
+
+	if (blob) {
+		uint32_t count = blob->length/sizeof(struct drm_rect);
+
+		if (count > DRM_MODE_FB_DIRTY_MAX_CLIPS)
+			return -EINVAL;
+
+		state->damage_clips = drm_property_blob_get(blob);
+		state->num_clips = count;
+	} else {
+		state->damage_clips = NULL;
+		state->num_clips = 0;
+	}
+
+	return 0;
+}
+
+/**
  * drm_atomic_get_plane_state - get plane state
  * @state: global atomic state object
  * @plane: plane to get state object for
@@ -793,6 +827,12 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		state->color_encoding = val;
 	} else if (property == plane->color_range_property) {
 		state->color_range = val;
+	} else if (property == config->prop_damage_clips) {
+		struct drm_property_blob *blob =
+			drm_property_lookup_blob(dev, val);
+		int ret = drm_atomic_set_damage_for_plane(state, blob);
+		drm_property_blob_put(blob);
+		return ret;
 	} else if (plane->funcs->atomic_set_property) {
 		return plane->funcs->atomic_set_property(plane, state,
 				property, val);
@@ -856,6 +896,8 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
 		*val = state->color_encoding;
 	} else if (property == plane->color_range_property) {
 		*val = state->color_range;
+	} else if (property == config->prop_damage_clips) {
+		*val = (state->damage_clips) ? state->damage_clips->base.id : 0;
 	} else if (plane->funcs->atomic_get_property) {
 		return plane->funcs->atomic_get_property(plane, state, property, val);
 	} else {
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index c356545..55b44e3 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3506,6 +3506,8 @@ void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
 
 	state->fence = NULL;
 	state->commit = NULL;
+	state->damage_clips = NULL;
+	state->num_clips = 0;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_plane_duplicate_state);
 
@@ -3550,6 +3552,8 @@ void __drm_atomic_helper_plane_destroy_state(struct drm_plane_state *state)
 
 	if (state->commit)
 		drm_crtc_commit_put(state->commit);
+
+	drm_property_blob_put(state->damage_clips);
 }
 EXPORT_SYMBOL(__drm_atomic_helper_plane_destroy_state);
 
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index e5c6533..e93b127 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -293,6 +293,11 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
 		return -ENOMEM;
 	dev->mode_config.prop_crtc_id = prop;
 
+	prop = drm_property_create(dev, DRM_MODE_PROP_BLOB, "DAMAGE_CLIPS", 0);
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.prop_damage_clips = prop;
+
 	prop = drm_property_create_bool(dev, DRM_MODE_PROP_ATOMIC,
 			"ACTIVE");
 	if (!prop)
diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 6d2a6e4..071221b 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -1101,3 +1101,15 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
 
 	return ret;
 }
+
+/**
+ * drm_plane_enable_damage_clips - enable damage clips property
+ * @plane: plane on which this property to enable.
+ */
+void drm_plane_enable_damage_clips(struct drm_plane *plane)
+{
+	struct drm_device *dev = plane->dev;
+	struct drm_mode_config *config = &dev->mode_config;
+
+	drm_object_attach_property(&plane->base, config->prop_damage_clips, 0);
+}
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 7569f22..d8767da 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -628,6 +628,21 @@ struct drm_mode_config {
 	 */
 	struct drm_property *prop_crtc_id;
 	/**
+	 * @prop_damage_clips: Optional plane property to mark damaged regions
+	 * on the plane in framebuffer coordinates of the framebuffer attached
+	 * to the plane.
+	 *
+	 * The layout of blob data is simply an array of drm_mode_rect with
+	 * maximum array size limited by DRM_MODE_FB_DIRTY_MAX_CLIPS. Unlike
+	 * plane src coordinates, damage clips are not in 16.16 fixed point.
+	 *
+	 * Damage clips are a hint to kernel as which area of framebuffer has
+	 * changed since last page-flip. This should be helpful
+	 * for some drivers especially for virtual devices where each
+	 * framebuffer change needs to be transmitted over network, usb, etc.
+	 */
+	struct drm_property *prop_damage_clips;
+	/**
 	 * @prop_active: Default atomic CRTC property to control the active
 	 * state, which is the simplified implementation for DPMS in atomic
 	 * drivers.
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index f7bf4a4..9f24548 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -146,6 +146,21 @@ struct drm_plane_state {
 	 */
 	struct drm_crtc_commit *commit;
 
+	/*
+	 * @damage_clips
+	 *
+	 * blob property with damage as array of drm_rect in framebuffer
+	 * coodinates.
+	 */
+	struct drm_property_blob *damage_clips;
+
+	/*
+	 * @num_clips
+	 *
+	 * Number of drm_rect in @damage_clips.
+	 */
+	uint32_t num_clips;
+
 	struct drm_atomic_state *state;
 };
 
@@ -611,6 +626,7 @@ int drm_plane_init(struct drm_device *dev,
 		   const uint32_t *formats, unsigned int format_count,
 		   bool is_primary);
 void drm_plane_cleanup(struct drm_plane *plane);
+void drm_plane_enable_damage_clips(struct drm_plane *plane);
 
 /**
  * drm_plane_index - find the index of a registered plane
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 50bcf42..0ad0d5b 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -873,6 +873,21 @@ struct drm_mode_revoke_lease {
 	__u32 lessee_id;
 };
 
+/**
+ * struct drm_mode_rect - two dimensional rectangle drm_rect exported to
+ * user-space.
+ * @x1: horizontal starting coordinate (inclusive)
+ * @y1: vertical starting coordinate (inclusive)
+ * @x2: horizontal ending coordinate (exclusive)
+ * @y2: vertical ending coordinate (exclusive)
+ */
+struct drm_mode_rect {
+	__s32 x1;
+	__s32 y1;
+	__s32 x2;
+	__s32 y2;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.7.4
