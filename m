Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754429AbeBGS7c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:59:32 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:53482 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754028AbeBGS7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:59:31 -0500
X-Google-Smtp-Source: AH8x226y0A5XOga+zImBL06stLfWch8m8a6IAEx/rKBShuAZ2ffs7FnFsorpyfio7dUevspzrtqc2g==
From: Matthias Kaehlcke <mka@chromium.org>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Rex Zhu <Rex.Zhu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] drm/amd/powerplay: Fix enum mismatch
Date: Wed,  7 Feb 2018 10:58:43 -0800
Message-Id: <20180207185843.75983-1-mka@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In several locations the driver uses AMD_CG_STATE_UNGATE (type enum
amd_clockgating_state) instead of AMD_PG_STATE_UNGATE (type enum
amd_powergating_stat) and vice versa. Both constants have the same
value, so this doesn't cause any problems, but we still want to pass
the correct type.

Fixing the mismatch resolves multiple warnings like this when building
with clang:

drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/cz_clockpowergating.c:169:7:
  error: implicit conversion from enumeration type 'enum
  amd_powergating_state' to different enumeration type 'enum
  amd_clockgating_state' [-Werror,-Wenum-conversion]
    AMD_PG_STATE_UNGATE);

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c   | 8 ++++----
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
index 44de0874629f..416abebb8b86 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
@@ -166,10 +166,10 @@ void cz_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 		cz_dpm_powerup_uvd(hwmgr);
 		cgs_set_clockgating_state(hwmgr->device,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_UNGATE);
+						AMD_CG_STATE_UNGATE);
 		cgs_set_powergating_state(hwmgr->device,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_CG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE);
 		cz_dpm_update_uvd_dpm(hwmgr, false);
 	}
 
@@ -197,11 +197,11 @@ void cz_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 		cgs_set_clockgating_state(
 					hwmgr->device,
 					AMD_IP_BLOCK_TYPE_VCE,
-					AMD_PG_STATE_UNGATE);
+					AMD_CG_STATE_UNGATE);
 		cgs_set_powergating_state(
 					hwmgr->device,
 					AMD_IP_BLOCK_TYPE_VCE,
-					AMD_CG_STATE_UNGATE);
+					AMD_PG_STATE_UNGATE);
 		cz_dpm_update_vce_dpm(hwmgr);
 		cz_enable_disable_vce_dpm(hwmgr, true);
 	}
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c
index 69a0678ace98..402aa9cb1f78 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c
@@ -162,7 +162,7 @@ void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 				AMD_CG_STATE_UNGATE);
 		cgs_set_powergating_state(hwmgr->device,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_CG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE);
 		smu7_update_uvd_dpm(hwmgr, false);
 	}
 
-- 
2.16.0.rc1.238.g530d649a79-goog
