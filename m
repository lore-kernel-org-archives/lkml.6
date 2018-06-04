Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeFDHB1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752828AbeFDHBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:01:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 26/52] drm/amd/powerplay: Fix enum mismatch
Date: Mon,  4 Jun 2018 08:58:21 +0200
Message-Id: <20180604065607.625995346@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065606.532044490@linuxfoundation.org>
References: <20180604065606.532044490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 42b5122e828a6ccd9952ad3116343dc032d33efe upstream.

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

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c   |    8 ++++----
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
@@ -176,10 +176,10 @@ int cz_dpm_powergate_uvd(struct pp_hwmgr
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
 
@@ -208,11 +208,11 @@ int cz_dpm_powergate_vce(struct pp_hwmgr
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
 		return 0;
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c
@@ -162,7 +162,7 @@ int smu7_powergate_uvd(struct pp_hwmgr *
 				AMD_CG_STATE_UNGATE);
 		cgs_set_powergating_state(hwmgr->device,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_CG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE);
 		smu7_update_uvd_dpm(hwmgr, false);
 	}
 
