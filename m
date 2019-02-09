Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49BBC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F73520823
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738506;
	bh=NWHM7dwK6GKezchnCovN1nqF4CSgdlCybhc6A80e3V0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qeej34tu5BwASPPcrA03qXtNF1vefnvV//YDZLwr6mx+h7x4adbPGFuA3mZIXbbhm
	 VVT8t36/M4SDy0ZlcYKUtJesA0XYgaL33Aq7h5ZoHwQw1qNybW1bbElX0uafd0qXB1
	 95hZVHZOQJEbPR+sOTJgzy9s8WDi+e063EKcuth0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfBISsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:48:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfBISsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:48:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A99C20821;
        Sat,  9 Feb 2019 18:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738122;
        bh=NWHM7dwK6GKezchnCovN1nqF4CSgdlCybhc6A80e3V0=;
        h=From:To:Cc:Subject:Date:From;
        b=b5mGA3XimamSrhUZA4ZBRGHDH9FdCafCeFyHBzGotp7xvvB4cWSnjl8A9itW1sBU5
         kBOXPX8dG5fIuMb2EJ3d1dsnQq8A66/Qg5FGCgTkeaM7EU/GEOdg+l6SEHUItoqHCb
         dQOmYi0TWhFgN41PFVCerEJU7EGBNt6E/s8dzPTI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Emily Deng <Emily.Deng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 01/28] drm/amdgpu/sriov:Correct pfvf exchange logic
Date:   Sat,  9 Feb 2019 13:48:09 -0500
Message-Id: <20190209184840.126418-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emily Deng <Emily.Deng@amd.com>

[ Upstream commit b8cf66182eddb22e9c7539821ed6eecdb4f86d1a ]

The pfvf exchange need be in exclusive mode. And add pfvf exchange in gpu
reset.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Reviewed-By: Xiangliang Yu <Xiangliang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 39bf2ce548c6..7f6af421d3e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1653,8 +1653,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	amdgpu_amdkfd_device_init(adev);
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_virt_init_data_exchange(adev);
 		amdgpu_virt_release_full_gpu(adev, true);
+	}
 
 	return 0;
 }
@@ -2555,9 +2557,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		goto failed;
 	}
 
-	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_init_data_exchange(adev);
-
 	amdgpu_fbdev_init(adev);
 
 	r = amdgpu_pm_sysfs_init(adev);
@@ -3269,6 +3268,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	r = amdgpu_ib_ring_tests(adev);
 
 error:
+	amdgpu_virt_init_data_exchange(adev);
 	amdgpu_virt_release_full_gpu(adev, true);
 	if (!r && adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
 		atomic_inc(&adev->vram_lost_counter);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 078f70faedcb..d06332be59d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -174,7 +174,7 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
 			return r;
 		}
 		/* Retrieve checksum from mailbox2 */
-		if (req == IDH_REQ_GPU_INIT_ACCESS) {
+		if (req == IDH_REQ_GPU_INIT_ACCESS || req == IDH_REQ_GPU_RESET_ACCESS) {
 			adev->virt.fw_reserve.checksum_key =
 				RREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0,
 					mmBIF_BX_PF0_MAILBOX_MSGBUF_RCV_DW2));
-- 
2.19.1

