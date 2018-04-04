Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752834AbeDEAGI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 20:06:08 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:58457 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752794AbeDEAGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 20:06:05 -0400
From: Deepak Rawat <drawat@vmware.com>
To: <dri-devel@lists.freedesktop.org>, <thellstrom@vmware.com>,
        <syeh@vmware.com>
CC: <linux-graphics-maintainer@vmware.com>, <daniel@ffwll.ch>,
        <ville.syrjala@linux.intel.com>, <lukasz.spintzyk@displaylink.com>,
        <noralf@tronnes.org>, <robdclark@gmail.com>, <gustavo@padovan.org>,
        <maarten.lankhorst@linux.intel.com>, <seanpaul@chromium.org>,
        <airlied@linux.ie>, <linux-kernel@vger.kernel.org>,
        Deepak Rawat <drawat@vmware.com>
Subject: [RFC 3/3] drm: Add helper to validate damage during modeset_check
Date: Wed, 4 Apr 2018 16:49:08 -0700
Message-ID: <1522885748-67122-4-git-send-email-drawat@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522885748-67122-1-git-send-email-drawat@vmware.com>
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a helper which should be called by driver which enable
damage (by calling drm_plane_enable_damage_clips) from atomic_check
hook. This helper for now set the damage to NULL for the planes on crtc
which need full modeset.

The driver also need to check for other crtc properties which can
affect damage in atomic_check hook, like gamma, ctm, etc. Plane related
properties which affect damage can be handled in damage iterator.

Signed-off-by: Deepak Rawat <drawat@vmware.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 47 +++++++++++++++++++++++++++++++++++++
 include/drm/drm_atomic_helper.h     |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 355b514..23f44ab 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3987,3 +3987,50 @@ drm_atomic_helper_damage_iter_next(struct drm_atomic_helper_damage_iter *iter,
 	return true;
 }
 EXPORT_SYMBOL(drm_atomic_helper_damage_iter_next);
+
+/**
+ * drm_atomic_helper_check_damage - validate state object for damage changes
+ * @dev: DRM device
+ * @state: the driver state object
+ *
+ * Check the state object if damage is required or not. In case damage is not
+ * required e.g. need modeset, the damage blob is set to NULL.
+ *
+ * NOTE: This helper is not called by core. Those driver which enable damage
+ * using drm_plane_enable_damage_clips should call this from their @atomic_check
+ * hook.
+ */
+int drm_atomic_helper_check_damage(struct drm_device *dev,
+				   struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_plane *plane;
+	struct drm_crtc_state *crtc_state;
+	unsigned plane_mask;
+	int i;
+
+	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
+		if (!drm_atomic_crtc_needs_modeset(crtc_state))
+			continue;
+
+		plane_mask = crtc_state->plane_mask;
+		plane_mask |= crtc->state->plane_mask;
+
+		drm_for_each_plane_mask(plane, dev, plane_mask) {
+			struct drm_plane_state *plane_state =
+				drm_atomic_get_plane_state(state, plane);
+
+			if (IS_ERR(plane_state))
+				return PTR_ERR(plane_state);
+
+			if (plane_state->damage_clips) {
+				drm_property_blob_put(plane_state->damage_clips);
+				plane_state->damage_clips = NULL;
+				plane_state->num_clips = 0;
+			}
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_atomic_helper_check_damage);
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index ebd4b66..b12335c 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -224,6 +224,8 @@ drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
 bool
 drm_atomic_helper_damage_iter_next(struct drm_atomic_helper_damage_iter *iter,
 				   struct drm_rect *rect);
+int drm_atomic_helper_check_damage(struct drm_device *dev,
+				   struct drm_atomic_state *state);
 
 /**
  * drm_atomic_crtc_for_each_plane - iterate over planes currently attached to CRTC
-- 
2.7.4
