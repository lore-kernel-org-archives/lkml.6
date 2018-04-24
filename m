Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933393AbeDXNOo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:14:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51419 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757942AbeDXNOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:14:41 -0400
X-Google-Smtp-Source: AIpwx4/1mklVBjCRVGsu2cxxzXuSKBpanwtT4kdUUbIb9hnExCPyhJRwry8+YFPuv6PkGE6Ojfg8WQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Dave Airlie <airlied@redhat.com>, Samuel Li <Samuel.Li@amd.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Keith Packard <keithp@keithp.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, Monk Liu <Monk.Liu@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Rosin <peda@axentia.se>, Harry Wentland <harry.wentland@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, Shirish S <shirish.s@amd.com>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/admgpu: fix mode_valid's return type
Date: Tue, 24 Apr 2018 15:14:18 +0200
Message-Id: <20180424131438.1751-1-luc.vanoostenryck@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c          | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 96501ff0e..8e66851eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -691,7 +691,7 @@ static int amdgpu_connector_lvds_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static int amdgpu_connector_lvds_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status amdgpu_connector_lvds_mode_valid(struct drm_connector *connector,
 					     struct drm_display_mode *mode)
 {
 	struct drm_encoder *encoder = amdgpu_connector_best_single_encoder(connector);
@@ -843,7 +843,7 @@ static int amdgpu_connector_vga_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static int amdgpu_connector_vga_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status amdgpu_connector_vga_mode_valid(struct drm_connector *connector,
 					    struct drm_display_mode *mode)
 {
 	struct drm_device *dev = connector->dev;
@@ -1172,7 +1172,7 @@ static void amdgpu_connector_dvi_force(struct drm_connector *connector)
 		amdgpu_connector->use_digital = true;
 }
 
-static int amdgpu_connector_dvi_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status amdgpu_connector_dvi_mode_valid(struct drm_connector *connector,
 					    struct drm_display_mode *mode)
 {
 	struct drm_device *dev = connector->dev;
@@ -1448,7 +1448,7 @@ amdgpu_connector_dp_detect(struct drm_connector *connector, bool force)
 	return ret;
 }
 
-static int amdgpu_connector_dp_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status amdgpu_connector_dp_mode_valid(struct drm_connector *connector,
 					   struct drm_display_mode *mode)
 {
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index b51f05dc9..476c9b987 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -329,7 +329,7 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
 	return 0;
 }
 
-static int dce_virtual_mode_valid(struct drm_connector *connector,
+static enum drm_mode_status dce_virtual_mode_valid(struct drm_connector *connector,
 				  struct drm_display_mode *mode)
 {
 	return MODE_OK;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4e2f379ce..d7e52c4f6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2855,7 +2855,7 @@ static void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
 	create_eml_sink(aconnector);
 }
 
-int amdgpu_dm_connector_mode_valid(struct drm_connector *connector,
+enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connector,
 				   struct drm_display_mode *mode)
 {
 	int result = MODE_ERROR;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index b68400c11..cb7e20cb3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -246,7 +246,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				     struct dc_link *link,
 				     int link_index);
 
-int amdgpu_dm_connector_mode_valid(struct drm_connector *connector,
+enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connector,
 				   struct drm_display_mode *mode);
 
 void dm_restore_drm_connector_state(struct drm_device *dev,
-- 
2.17.0
