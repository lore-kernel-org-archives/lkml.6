Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933463AbeDXNPF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:15:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39136 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeDXNO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:14:58 -0400
X-Google-Smtp-Source: AIpwx4/F4YhSNC3EOwmkOgvJs5HwewW1v0S8VhCYPCin2CARKJKEVqlo/s9ycr5xEo8DsbiML7QO9w==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/gma500: fix mode_valid's return type
Date: Tue, 24 Apr 2018 15:14:54 +0200
Message-Id: <20180424131455.2011-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method struct drm_connector_helper_funcs::mode_valid is defined
as returning an 'enum drm_mode_status' but the driver implementation
for this method uses an 'int' for it.

Fix this by using 'enum drm_mode_status' in the driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/gpu/drm/gma500/cdv_intel_crt.c    | 2 +-
 drivers/gpu/drm/gma500/cdv_intel_dp.c     | 2 +-
 drivers/gpu/drm/gma500/cdv_intel_hdmi.c   | 2 +-
 drivers/gpu/drm/gma500/cdv_intel_lvds.c   | 2 +-
 drivers/gpu/drm/gma500/mdfld_dsi_output.c | 2 +-
 drivers/gpu/drm/gma500/oaktrail_hdmi.c    | 2 +-
 drivers/gpu/drm/gma500/psb_intel_sdvo.c   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_crt.c b/drivers/gpu/drm/gma500/cdv_intel_crt.c
index b837e7a92..cb5a14b7e 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_crt.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_crt.c
@@ -64,7 +64,7 @@ static void cdv_intel_crt_dpms(struct drm_encoder *encoder, int mode)
 	REG_WRITE(reg, temp);
 }
 
-static int cdv_intel_crt_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status cdv_intel_crt_mode_valid(struct drm_connector *connector,
 				struct drm_display_mode *mode)
 {
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index a4bb89b78..5ea785f07 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -505,7 +505,7 @@ static void cdv_intel_edp_backlight_off (struct gma_encoder *intel_encoder)
 	msleep(intel_dp->backlight_off_delay);
 }
 
-static int
+static enum drm_mode_status
 cdv_intel_dp_mode_valid(struct drm_connector *connector,
 		    struct drm_display_mode *mode)
 {
diff --git a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
index 563f193fc..f08789985 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_hdmi.c
@@ -223,7 +223,7 @@ static int cdv_hdmi_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static int cdv_hdmi_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status cdv_hdmi_mode_valid(struct drm_connector *connector,
 				 struct drm_display_mode *mode)
 {
 	if (mode->clock > 165000)
diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
index e64960db3..de9531caa 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
@@ -244,7 +244,7 @@ static void cdv_intel_lvds_restore(struct drm_connector *connector)
 {
 }
 
-static int cdv_intel_lvds_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status cdv_intel_lvds_mode_valid(struct drm_connector *connector,
 			      struct drm_display_mode *mode)
 {
 	struct drm_device *dev = connector->dev;
diff --git a/drivers/gpu/drm/gma500/mdfld_dsi_output.c b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
index acb3848ef..fe020926e 100644
--- a/drivers/gpu/drm/gma500/mdfld_dsi_output.c
+++ b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
@@ -346,7 +346,7 @@ static int mdfld_dsi_connector_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
-static int mdfld_dsi_connector_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status mdfld_dsi_connector_mode_valid(struct drm_connector *connector,
 						struct drm_display_mode *mode)
 {
 	struct mdfld_dsi_connector *dsi_connector =
diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index 8b2eb32ee..78566a80a 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -509,7 +509,7 @@ static void oaktrail_hdmi_dpms(struct drm_encoder *encoder, int mode)
 	HDMI_WRITE(HDMI_VIDEO_REG, temp);
 }
 
-static int oaktrail_hdmi_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status oaktrail_hdmi_mode_valid(struct drm_connector *connector,
 				struct drm_display_mode *mode)
 {
 	if (mode->clock > 165000)
diff --git a/drivers/gpu/drm/gma500/psb_intel_sdvo.c b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
index 84507912b..8dc2b19f9 100644
--- a/drivers/gpu/drm/gma500/psb_intel_sdvo.c
+++ b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
@@ -1157,7 +1157,7 @@ static void psb_intel_sdvo_dpms(struct drm_encoder *encoder, int mode)
 	return;
 }
 
-static int psb_intel_sdvo_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status psb_intel_sdvo_mode_valid(struct drm_connector *connector,
 				 struct drm_display_mode *mode)
 {
 	struct psb_intel_sdvo *psb_intel_sdvo = intel_attached_sdvo(connector);
-- 
2.17.0
