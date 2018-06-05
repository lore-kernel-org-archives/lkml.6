Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeFETMh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:12:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51234 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbeFETMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:12:35 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH v6 2/2] drm/i915: remove intel_cursor_plane_funcs
Date: Tue,  5 Jun 2018 21:12:26 +0200
Message-Id: <20180605191226.32310-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605191226.32310-1-enric.balletbo@collabora.com>
References: <20180605191226.32310-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Padovan <gustavo.padovan@collabora.com>

After converting legacy cursor updates to atomic async commits
intel_cursor_plane_funcs just duplicates intel_plane_funcs now.

Cc: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None

 drivers/gpu/drm/i915/intel_display.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index b14d39e2d1f0..762a84e401a3 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -13061,16 +13061,6 @@ static bool intel_primary_plane_format_mod_supported(struct drm_plane *plane,
 		return i8xx_mod_supported(format, modifier);
 }
 
-static bool intel_cursor_plane_format_mod_supported(struct drm_plane *plane,
-						    uint32_t format,
-						    uint64_t modifier)
-{
-	if (WARN_ON(modifier == DRM_FORMAT_MOD_INVALID))
-		return false;
-
-	return modifier == DRM_FORMAT_MOD_LINEAR && format == DRM_FORMAT_ARGB8888;
-}
-
 static struct drm_plane_funcs intel_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
@@ -13082,17 +13072,6 @@ static struct drm_plane_funcs intel_plane_funcs = {
 	.format_mod_supported = intel_primary_plane_format_mod_supported,
 };
 
-static const struct drm_plane_funcs intel_cursor_plane_funcs = {
-	.update_plane = drm_atomic_helper_update_plane,
-	.disable_plane = drm_atomic_helper_disable_plane,
-	.destroy = intel_plane_destroy,
-	.atomic_get_property = intel_plane_atomic_get_property,
-	.atomic_set_property = intel_plane_atomic_set_property,
-	.atomic_duplicate_state = intel_plane_duplicate_state,
-	.atomic_destroy_state = intel_plane_destroy_state,
-	.format_mod_supported = intel_cursor_plane_format_mod_supported,
-};
-
 static bool i9xx_plane_has_fbc(struct drm_i915_private *dev_priv,
 			       enum i9xx_plane_id i9xx_plane)
 {
@@ -13326,7 +13305,7 @@ intel_cursor_plane_create(struct drm_i915_private *dev_priv,
 		cursor->cursor.size = ~0;
 
 	ret = drm_universal_plane_init(&dev_priv->drm, &cursor->base,
-				       0, &intel_cursor_plane_funcs,
+				       0, &intel_plane_funcs,
 				       intel_cursor_formats,
 				       ARRAY_SIZE(intel_cursor_formats),
 				       cursor_format_modifiers,
-- 
2.17.1
