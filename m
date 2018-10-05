Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F069C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A5721480
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="df+/lKGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A5721480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbeJEXOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729628AbeJEXO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42FBA2147D;
        Fri,  5 Oct 2018 16:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756105;
        bh=LQpa8oTpNbhxQD46nm/13n8TxT5bHmh6gfoKRcthoEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=df+/lKGR/4BHg3Y0e3Mkt4Owk5GbqzH5XiQDt7j2bZp3MnGQ8Tziw8in9v4L2kvpu
         1oiaMmZqunvhjR7szggEOqpmiH3MUZmR95Jkh+htJqkUMaKzgliTKLy0RahVRmNahv
         vWcneMkvfem/D0zEUU8BPdY287LT8veOauFZvMXU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yong Zhao <yong.zhao@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 45/48] drm/amdkfd: Change the control stack MTYPE from UC to NC on GFX9
Date:   Fri,  5 Oct 2018 12:14:21 -0400
Message-Id: <20181005161424.20521-45-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yong Zhao <yong.zhao@amd.com>

[ Upstream commit 15426dbb65c5b37680d27e84d58a1ed3b8532518 ]

CWSR fails on Raven if the control stack is MTYPE_UC, which is used
for regular GART mappings. As a workaround we map it using MTYPE_NC.

The MEC firmware expects the control stack at one page offset from the
start of the MQD so it is part of the MQD allocation on GFXv9. AMDGPU
added a memory allocation flag just for this purpose.

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yong Zhao <yong.zhao@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c         | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h | 2 +-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 305143fcc1ce..1ac7933cccc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -245,7 +245,7 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev)
 
 int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
 			void **mem_obj, uint64_t *gpu_addr,
-			void **cpu_ptr)
+			void **cpu_ptr, bool mqd_gfx9)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	struct amdgpu_bo *bo = NULL;
@@ -261,6 +261,10 @@ int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
 	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
+
+	if (mqd_gfx9)
+		bp.flags |= AMDGPU_GEM_CREATE_MQD_GFX9;
+
 	r = amdgpu_bo_create(adev, &bp, &bo);
 	if (r) {
 		dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index a8418a3f4e9d..e3cf1c9fb3db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -129,7 +129,7 @@ bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
 /* Shared API */
 int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
 			void **mem_obj, uint64_t *gpu_addr,
-			void **cpu_ptr);
+			void **cpu_ptr, bool mqd_gfx9);
 void free_gtt_mem(struct kgd_dev *kgd, void *mem_obj);
 void get_local_mem_info(struct kgd_dev *kgd,
 			struct kfd_local_mem_info *mem_info);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 7ee6cec2c060..6881b5a9275f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -423,7 +423,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	if (kfd->kfd2kgd->init_gtt_mem_allocation(
 			kfd->kgd, size, &kfd->gtt_mem,
-			&kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr)){
+			&kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
+			false)) {
 		dev_err(kfd_device, "Could not allocate %d bytes\n", size);
 		goto out;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 684054ff02cd..8da079cc6fb9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -63,7 +63,7 @@ static int init_mqd(struct mqd_manager *mm, void **mqd,
 				ALIGN(sizeof(struct v9_mqd), PAGE_SIZE),
 			&((*mqd_mem_obj)->gtt_mem),
 			&((*mqd_mem_obj)->gpu_addr),
-			(void *)&((*mqd_mem_obj)->cpu_ptr));
+			(void *)&((*mqd_mem_obj)->cpu_ptr), true);
 	} else
 		retval = kfd_gtt_sa_allocate(mm->dev, sizeof(struct v9_mqd),
 				mqd_mem_obj);
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 5733fbee07f7..f56b7553e5ed 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -266,7 +266,7 @@ struct tile_config {
 struct kfd2kgd_calls {
 	int (*init_gtt_mem_allocation)(struct kgd_dev *kgd, size_t size,
 					void **mem_obj, uint64_t *gpu_addr,
-					void **cpu_ptr);
+					void **cpu_ptr, bool mqd_gfx9);
 
 	void (*free_gtt_mem)(struct kgd_dev *kgd, void *mem_obj);
 
-- 
2.17.1

