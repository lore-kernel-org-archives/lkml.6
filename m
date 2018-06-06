Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C7832607E2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeFFMSg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:18:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46724 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeFFMSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:18:35 -0400
From: Colin King <colin.king@canonical.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/pp: initialized result to zero before or'ing in data
Date: Wed,  6 Jun 2018 13:18:31 +0100
Message-Id: <20180606121831.3347-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The current use of result is or'ing in values and checking for
a non-zero result, however, result is not initialized to zero
so it potentially contains garbage to start with. Fix this by
initializing it to the first return from the call to
vega10_program_didt_config_registers.

Detected by cppcheck:
"(error) Uninitialized variable: result"

Fixes: 9b7b8154cdb8 ("drm/amd/powerplay: added didt support for vega10")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
index a9efd8554fbc..dbe4b1f66784 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
@@ -1104,7 +1104,7 @@ static int vega10_enable_psm_gc_edc_config(struct pp_hwmgr *hwmgr)
 	for (count = 0; count < num_se; count++) {
 		data = GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK | GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | ( count << GRBM_GFX_INDEX__SE_INDEX__SHIFT);
 		WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
-		result |= vega10_program_didt_config_registers(hwmgr, PSMSEEDCStallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);
+		result = vega10_program_didt_config_registers(hwmgr, PSMSEEDCStallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);
 		result |= vega10_program_didt_config_registers(hwmgr, PSMSEEDCStallDelayConfig_Vega10, VEGA10_CONFIGREG_DIDT);
 		result |= vega10_program_didt_config_registers(hwmgr, PSMSEEDCCtrlResetConfig_Vega10, VEGA10_CONFIGREG_DIDT);
 		result |= vega10_program_didt_config_registers(hwmgr, PSMSEEDCCtrlConfig_Vega10, VEGA10_CONFIGREG_DIDT);
-- 
2.17.0
