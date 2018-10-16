Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D28EC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3C12089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0nvWZIyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3C12089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbeJQBGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728331AbeJQBGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:06:41 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D56320866;
        Tue, 16 Oct 2018 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710117;
        bh=+NunGR7hKWRiuoagQOVvXp3AyU78eTavFN7fhxo1Akk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0nvWZIylf2YCgvNxy7DpUFmX52F8PkxpQyxqU0g+m6PH5Yl4PvFwUHGTBuGIWvuCV
         vO7Hk5qOmplCAVQ0aae9xR0T7ouHUYBp+TuEKcw95ke2pBqkY6GM9zzpvAawFm0Xcr
         XFjr+l313W9iurcEYrGupGYQ8is5wOkwziSaZDE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        Yong Zhao <yong.zhao@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 107/135] drm/amdkfd: Change the control stack MTYPE from UC to NC on GFX9
Date:   Tue, 16 Oct 2018 19:05:37 +0200
Message-Id: <20181016170522.753364106@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      |    6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c         |    3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c |    2 +-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h |    2 +-
 5 files changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -245,7 +245,7 @@ int amdgpu_amdkfd_resume(struct amdgpu_d
 
 int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
 			void **mem_obj, uint64_t *gpu_addr,
-			void **cpu_ptr)
+			void **cpu_ptr, bool mqd_gfx9)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	struct amdgpu_bo *bo = NULL;
@@ -261,6 +261,10 @@ int alloc_gtt_mem(struct kgd_dev *kgd, s
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
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -129,7 +129,7 @@ bool amdgpu_amdkfd_is_kfd_vmid(struct am
 /* Shared API */
 int alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
 			void **mem_obj, uint64_t *gpu_addr,
-			void **cpu_ptr);
+			void **cpu_ptr, bool mqd_gfx9);
 void free_gtt_mem(struct kgd_dev *kgd, void *mem_obj);
 void get_local_mem_info(struct kgd_dev *kgd,
 			struct kfd_local_mem_info *mem_info);
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -423,7 +423,8 @@ bool kgd2kfd_device_init(struct kfd_dev
 
 	if (kfd->kfd2kgd->init_gtt_mem_allocation(
 			kfd->kgd, size, &kfd->gtt_mem,
-			&kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr)){
+			&kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
+			false)) {
 		dev_err(kfd_device, "Could not allocate %d bytes\n", size);
 		goto out;
 	}
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -63,7 +63,7 @@ static int init_mqd(struct mqd_manager *
 				ALIGN(sizeof(struct v9_mqd), PAGE_SIZE),
 			&((*mqd_mem_obj)->gtt_mem),
 			&((*mqd_mem_obj)->gpu_addr),
-			(void *)&((*mqd_mem_obj)->cpu_ptr));
+			(void *)&((*mqd_mem_obj)->cpu_ptr), true);
 	} else
 		retval = kfd_gtt_sa_allocate(mm->dev, sizeof(struct v9_mqd),
 				mqd_mem_obj);
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -266,7 +266,7 @@ struct tile_config {
 struct kfd2kgd_calls {
 	int (*init_gtt_mem_allocation)(struct kgd_dev *kgd, size_t size,
 					void **mem_obj, uint64_t *gpu_addr,
-					void **cpu_ptr);
+					void **cpu_ptr, bool mqd_gfx9);
 
 	void (*free_gtt_mem)(struct kgd_dev *kgd, void *mem_obj);
 


