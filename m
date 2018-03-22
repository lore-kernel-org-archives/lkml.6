Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeCVXMo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:12:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53299 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeCVXMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:12:42 -0400
From: Colin King <colin.king@canonical.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/pp: don't dereference hwmgr until after it is null checked
Date: Thu, 22 Mar 2018 23:12:39 +0000
Message-Id: <20180322231239.16935-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer hwmgr is dereferenced before it is null checked, hence there
is a possibility of a null pointer dereference.  Fix this by only
dereferencing hwmgr once it is null checked.

Detected by CoverityScan, CID#1466428 ("Dereference before null check")

Fixes: 59156faf810e ("drm/amd/pp: Remove the cgs wrapper for notify smu version on APU")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
index 8c49704b81af..6e88ed67e291 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
@@ -698,18 +698,18 @@ static int smu8_start_smu(struct pp_hwmgr *hwmgr)
 {
 	int ret = 0;
 	uint32_t fw_to_check = 0;
-	struct amdgpu_device *adev = hwmgr->adev;
+	struct amdgpu_device *adev;
 
 	uint32_t index = SMN_MP1_SRAM_START_ADDR +
 			 SMU8_FIRMWARE_HEADER_LOCATION +
 			 offsetof(struct SMU8_Firmware_Header, Version);
 
-
 	if (hwmgr == NULL || hwmgr->device == NULL)
 		return -EINVAL;
 
 	cgs_write_register(hwmgr->device, mmMP0PUB_IND_INDEX, index);
 	hwmgr->smu_version = cgs_read_register(hwmgr->device, mmMP0PUB_IND_DATA);
+	adev = hwmgr->adev;
 	adev->pm.fw_version = hwmgr->smu_version >> 8;
 
 	fw_to_check = UCODE_ID_RLC_G_MASK |
-- 
2.15.1
