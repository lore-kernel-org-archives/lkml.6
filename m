Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeCPWEm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:04:42 -0400
Received: from anholt.net ([50.246.234.109]:49002 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751562AbeCPWEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:04:39 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
        <ville.syrjala@linux.intel.com>
Subject: [PATCH 1/3] drm: Trust format_mod_supported() when it OKs a plane modifier.
Date: Fri, 16 Mar 2018 15:04:33 -0700
Message-Id: <20180316220435.31416-1-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For parameterized modifiers (Broadcom's SAND and UIF), we need to
allow the parameter fields to be filled in, while exposing only the
variant of the modifier with the parameter unfilled in the internal
arrays and the format blob.

Signed-off-by: Eric Anholt <eric@anholt.net>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_plane.c | 23 ++++++++++++-----------
 include/drm/drm_plane.h     |  5 ++++-
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 46fbd019a337..5bb501f1aae8 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -561,19 +561,20 @@ int drm_plane_check_pixel_format(struct drm_plane *plane,
 	if (i == plane->format_count)
 		return -EINVAL;
 
-	if (!plane->modifier_count)
-		return 0;
+	if (plane->funcs->format_mod_supported) {
+		if (!plane->funcs->format_mod_supported(plane, format, modifier))
+			return -EINVAL;
+	} else {
+		if (!plane->modifier_count)
+			return 0;
 
-	for (i = 0; i < plane->modifier_count; i++) {
-		if (modifier == plane->modifiers[i])
-			break;
+		for (i = 0; i < plane->modifier_count; i++) {
+			if (modifier == plane->modifiers[i])
+				break;
+		}
+		if (i == plane->modifier_count)
+			return -EINVAL;
 	}
-	if (i == plane->modifier_count)
-		return -EINVAL;
-
-	if (plane->funcs->format_mod_supported &&
-	    !plane->funcs->format_mod_supported(plane, format, modifier))
-		return -EINVAL;
 
 	return 0;
 }
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index f7bf4a48b1c3..6b1b51645f75 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -420,7 +420,10 @@ struct drm_plane_funcs {
 	 * This optional hook is used for the DRM to determine if the given
 	 * format/modifier combination is valid for the plane. This allows the
 	 * DRM to generate the correct format bitmask (which formats apply to
-	 * which modifier).
+	 * which modifier), and to valdiate modifiers at atomic_check time.
+	 *
+	 * If not present, then any modifier in the plane's modifier
+	 * list is allowed with any of the plane's formats.
 	 *
 	 * Returns:
 	 *
-- 
2.16.2
