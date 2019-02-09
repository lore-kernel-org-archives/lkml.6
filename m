Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCCAC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8808420821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738059;
	bh=xlMinsUh28iFhejDQZ5kBMqcF4vRxA4M4wsvOhUNFSg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DW+8Ij8KN6phGjgZQDBfwla7wsnmK+3D1if0papqJWI9x16GpWHHbPeVKOF/TYw4R
	 Z04C/wfd1AOPS22pqVYkQljIiXzZ8u4BDvX89SuLHzxeP8+jaVLzsUpLDOeoe6hPlf
	 O2F/f/vgiaBUyq+vl8cSMBoEo4DF2sC+OvEIGpmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfBISrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfBISrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:47:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15C0A20821;
        Sat,  9 Feb 2019 18:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738056;
        bh=xlMinsUh28iFhejDQZ5kBMqcF4vRxA4M4wsvOhUNFSg=;
        h=From:To:Cc:Subject:Date:From;
        b=USQ3ADWu8U27CPoU7gXlQLWQBdVhiUq2xomSUlWQVsRWjKiHPH+U3rWcvCbeJwWdk
         MkE+Msuh200A5+fK2wCd34BDmotw1lT8DW8IUnnkW0eMZHoMhp4We6ThAP9d5G0G14
         o1NKXXPgoZlwuVnwe+TwR9zsH+NZFevbhrabiRgQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Emily Deng <Emily.Deng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 01/42] drm/amdgpu/sriov:Correct pfvf exchange logic
Date:   Sat,  9 Feb 2019 13:46:53 -0500
Message-Id: <20190209184734.125935-1-sashal@kernel.org>
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
index 30bc345d6fdf..8547fdaf8273 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1684,8 +1684,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	amdgpu_xgmi_add_device(adev);
 	amdgpu_amdkfd_device_init(adev);
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_virt_init_data_exchange(adev);
 		amdgpu_virt_release_full_gpu(adev, true);
+	}
 
 	return 0;
 }
@@ -2597,9 +2599,6 @@ fence_driver_init:
 		goto failed;
 	}
 
-	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_init_data_exchange(adev);
-
 	amdgpu_fbdev_init(adev);
 
 	r = amdgpu_pm_sysfs_init(adev);
@@ -3271,6 +3270,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	r = amdgpu_ib_ring_tests(adev);
 
 error:
+	amdgpu_virt_init_data_exchange(adev);
 	amdgpu_virt_release_full_gpu(adev, true);
 	if (!r && adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
 		atomic_inc(&adev->vram_lost_counter);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 8cbb4655896a..b11a1c17a7f2 100644
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

