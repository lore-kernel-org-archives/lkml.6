Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeBJSOP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 13:14:15 -0500
Received: from shell.v3.sk ([92.60.52.57]:59765 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751057AbeBJSOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 13:14:14 -0500
From: Lubomir Rintel <lkundrak@v3.sk>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sean Paul <seanpaul@chromium.org>, Lubomir Rintel <lkundrak@v3.sk>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH] drm/edid: drop the dcc probe before drm_do_get_edid
Date: Sat, 10 Feb 2018 19:03:55 +0100
Message-Id: <20180210180355.2284-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that drm_do_get_edid() handles override and firmware EDIDs it makes
no sense to conditionalize it with a DCC probe. On the contrary -- the
overrides are useful specifically when DCC is not functioning.

drm_do_get_edid() already bails out when DCC fails, there's no need for
an extra check. It seems entirely safe to just drop this.

Working around the issue by forcing the connector on is not a good
solution because that way the desktop shell can't tell when a monitor is
plugged in or removed.

Cc: Jani Nikula <jani.nikula@intel.com>
Fixes: 53fd40a ("drm: handle override and firmware EDID at drm_do_get_edid() level")
---
 drivers/gpu/drm/drm_edid.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index cb487148359a..72169d84256d 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1642,21 +1642,6 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
 }
 EXPORT_SYMBOL_GPL(drm_do_get_edid);
 
-/**
- * drm_probe_ddc() - probe DDC presence
- * @adapter: I2C adapter to probe
- *
- * Return: True on success, false on failure.
- */
-bool
-drm_probe_ddc(struct i2c_adapter *adapter)
-{
-	unsigned char out;
-
-	return (drm_do_probe_ddc_edid(adapter, &out, 0, 1) == 0);
-}
-EXPORT_SYMBOL(drm_probe_ddc);
-
 /**
  * drm_get_edid - get EDID data, if available
  * @connector: connector we're probing
@@ -1675,9 +1660,6 @@ struct edid *drm_get_edid(struct drm_connector *connector,
 	if (connector->force == DRM_FORCE_OFF)
 		return NULL;
 
-	if (connector->force == DRM_FORCE_UNSPECIFIED && !drm_probe_ddc(adapter))
-		return NULL;
-
 	edid = drm_do_get_edid(connector, drm_do_probe_ddc_edid, adapter);
 	if (edid)
 		drm_get_displayid(connector, edid);
-- 
2.14.3
