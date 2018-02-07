Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeBGVoM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 16:44:12 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44859 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbeBGVoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 16:44:11 -0500
X-Google-Smtp-Source: AH8x226A1dobN6czRbjUwmghXzlStQCSTIN9BL9C9M2068DJ+I1lbHug2gC/3NGPO43pF7ZLREolLA==
From: Matthias Kaehlcke <mka@chromium.org>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Tony Cheng <tony.cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>, Yue Hin Lau <Yuehin.Lau@amd.com>,
        Zeyu Fan <Zeyu.Fan@amd.com>, Charlene Liu <charlene.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] amdgpu/dc: Fix enum mismatch in calls to program_color_matrix()
Date: Wed,  7 Feb 2018 13:43:52 -0800
Message-Id: <20180207214352.109924-1-mka@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver passes GRAPHICS_CSC_ADJUST_TYPE_SW of type enum
graphics_csc_adjust_type to program_color_matrix(), however the function
expects a parameter of type enum grph_color_adjust_option. Supposedly
the intention was to pass GRPH_COLOR_MATRIX_SW, which has the same value
as GRAPHICS_CSC_ADJUST_TYPE_SW, so the mismatch didn't cause any trouble.

Pass GRPH_COLOR_MATRIX_SW to program_color_matrix() instead of
GRAPHICS_CSC_ADJUST_TYPE_SW, this also fixes the following warning when
building the kernel with clang:

drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.c:1129:24:
  error: implicit conversion from enumeration type
  'enum graphics_csc_adjust_type' to different enumeration type
  'enum grph_color_adjust_option' [-Werror,-Wenum-conversion]
    xfm_dce, tbl_entry, GRAPHICS_CSC_ADJUST_TYPE_SW);

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c       | 2 +-
 drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 0f662e6ee9bd..ac28113c4d67 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -1126,7 +1126,7 @@ void dce110_opp_set_csc_adjustment(
 			CSC_COLOR_MODE_GRAPHICS_OUTPUT_CSC;
 
 	program_color_matrix(
-			xfm_dce, tbl_entry, GRAPHICS_CSC_ADJUST_TYPE_SW);
+			xfm_dce, tbl_entry, GRPH_COLOR_MATRIX_SW);
 
 	/*  We did everything ,now program DxOUTPUT_CSC_CONTROL */
 	configure_graphics_mode(xfm_dce, config, GRAPHICS_CSC_ADJUST_TYPE_SW,
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
index feb397b5c1a3..4245e1f818a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
@@ -727,7 +727,7 @@ void dce110_opp_v_set_csc_adjustment(
 			CSC_COLOR_MODE_GRAPHICS_OUTPUT_CSC;
 
 	program_color_matrix_v(
-			xfm_dce, tbl_entry, GRAPHICS_CSC_ADJUST_TYPE_SW);
+			xfm_dce, tbl_entry, GRPH_COLOR_MATRIX_SW);
 
 	/*  We did everything ,now program DxOUTPUT_CSC_CONTROL */
 	configure_graphics_mode_v(xfm_dce, config, GRAPHICS_CSC_ADJUST_TYPE_SW,
-- 
2.16.0.rc1.238.g530d649a79-goog
