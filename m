Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5858EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE852070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501285;
	bh=UZqmBvyGkp5XKRpopOT/b04dKpEo3ya82MLY4LnMAvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U+XgAUtG7/vkHHuPEAOoFFfsgnYzPeuWme470Uq9ScieeHlfZPx3K4oIIClB68UTq
	 7uz5VEzSCYTgVnMGMSgTr+NJnreXdfvcjcjMWTFihVziBXCf8EAHUzz/JaZwuNh4pH
	 9daSSn0rnRCb3NCwbGC4DBVhb1ultPvDghQQ56l0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbfBROsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:48:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731301AbfBRNpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 611E2217F5;
        Mon, 18 Feb 2019 13:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497520;
        bh=UZqmBvyGkp5XKRpopOT/b04dKpEo3ya82MLY4LnMAvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFwmDbnYOAnmLFE5iWIdIrUL26mxgAKKsFQvCyI8SqRFXCIhmjTPAqW8zzSBU1/UA
         bRnYo1DRiaq1fCI9K0hTEtZOdNuIBZPpEKL5UvaOSu0KuzLV5WjoEXospdXwr/hN4K
         2DacbtPS8EUiUQsQ3SSJ86Kbe4/RMpROkpxRgJfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Emily Deng <Emily.Deng@amd.com>,
        Xiangliang Yu <Xiangliang.Yu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 04/92] drm/amdgpu/sriov:Correct pfvf exchange logic
Date:   Mon, 18 Feb 2019 14:42:07 +0100
Message-Id: <20190218133455.030250084@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -2597,9 +2599,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
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



