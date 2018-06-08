Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kfZZDrJPGlu2DgAAmS7hNA
	; Fri, 08 Jun 2018 09:43:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 25521607DC; Fri,  8 Jun 2018 09:43:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8082960275;
	Fri,  8 Jun 2018 09:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8082960275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeFHJnK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:43:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41236 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeFHJnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:43:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 356FE28A732
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH v7 2/2] drm/i915: remove intel_cursor_plane_funcs
Date: Fri,  8 Jun 2018 11:42:52 +0200
Message-Id: <20180608094252.12629-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180608094252.12629-1-enric.balletbo@collabora.com>
References: <20180608094252.12629-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Padovan <gustavo.padovan@collabora.com>

After converting legacy cursor updates to atomic async commits
intel_cursor_plane_funcs just duplicates intel_plane_funcs now.

Cc: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None

 drivers/gpu/drm/i915/intel_display.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 4ff73bfd1616..06f53960ccd8 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -13320,16 +13320,6 @@ static bool intel_primary_plane_format_mod_supported(struct drm_plane *plane,
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
@@ -13341,17 +13331,6 @@ static struct drm_plane_funcs intel_plane_funcs = {
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
@@ -13614,7 +13593,7 @@ intel_cursor_plane_create(struct drm_i915_private *dev_priv,
 		cursor->cursor.size = ~0;
 
 	ret = drm_universal_plane_init(&dev_priv->drm, &cursor->base,
-				       0, &intel_cursor_plane_funcs,
+				       0, &intel_plane_funcs,
 				       intel_cursor_formats,
 				       ARRAY_SIZE(intel_cursor_formats),
 				       cursor_format_modifiers,
-- 
2.17.1
