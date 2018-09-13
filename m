Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9C1C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4302420861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4302420861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbeIMTQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:16:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbeIMTQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:16:21 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C75ACD3C;
        Thu, 13 Sep 2018 14:06:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.18 186/197] drm/amdgpu: Keep track of amount of pinned CPU visible VRAM
Date:   Thu, 13 Sep 2018 15:32:15 +0200
Message-Id: <20180913131849.002063378@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Michel Dänzer <michel.daenzer@amd.com>

commit ddc21af4d0f37f42b33c54cb69b215997fe5b082 upstream.

Instead of CPU invisible VRAM. Preparation for the following, no
functional change intended.

v2:
* Also change amdgpu_vram_mgr_bo_invisible_size to
  amdgpu_vram_mgr_bo_visible_size, allowing further simplification
  (Christian König)

Cc: stable@vger.kernel.org
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      |    5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   |    4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |   20 ++++++++------------
 5 files changed, 14 insertions(+), 19 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1580,7 +1580,7 @@ struct amdgpu_device {
 
 	/* tracking pinned memory */
 	u64 vram_pin_size;
-	u64 invisible_pin_size;
+	u64 visible_pin_size;
 	u64 gart_pin_size;
 
 	/* amdkfd interface */
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -497,7 +497,7 @@ static int amdgpu_info_ioctl(struct drm_
 		vram_gtt.vram_size = adev->gmc.real_vram_size;
 		vram_gtt.vram_size -= adev->vram_pin_size;
 		vram_gtt.vram_cpu_accessible_size = adev->gmc.visible_vram_size;
-		vram_gtt.vram_cpu_accessible_size -= (adev->vram_pin_size - adev->invisible_pin_size);
+		vram_gtt.vram_cpu_accessible_size -= adev->visible_pin_size;
 		vram_gtt.gtt_size = adev->mman.bdev.man[TTM_PL_TT].size;
 		vram_gtt.gtt_size *= PAGE_SIZE;
 		vram_gtt.gtt_size -= adev->gart_pin_size;
@@ -518,8 +518,7 @@ static int amdgpu_info_ioctl(struct drm_
 		mem.cpu_accessible_vram.total_heap_size =
 			adev->gmc.visible_vram_size;
 		mem.cpu_accessible_vram.usable_heap_size =
-			adev->gmc.visible_vram_size -
-			(adev->vram_pin_size - adev->invisible_pin_size);
+			adev->gmc.visible_vram_size - adev->visible_pin_size;
 		mem.cpu_accessible_vram.heap_usage =
 			amdgpu_vram_mgr_vis_usage(&adev->mman.bdev.man[TTM_PL_VRAM]);
 		mem.cpu_accessible_vram.max_allocation =
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -762,7 +762,7 @@ int amdgpu_bo_pin_restricted(struct amdg
 	domain = amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type);
 	if (domain == AMDGPU_GEM_DOMAIN_VRAM) {
 		adev->vram_pin_size += amdgpu_bo_size(bo);
-		adev->invisible_pin_size += amdgpu_vram_mgr_bo_invisible_size(bo);
+		adev->visible_pin_size += amdgpu_vram_mgr_bo_visible_size(bo);
 	} else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
 		adev->gart_pin_size += amdgpu_bo_size(bo);
 	}
@@ -792,7 +792,7 @@ int amdgpu_bo_unpin(struct amdgpu_bo *bo
 
 	if (bo->tbo.mem.mem_type == TTM_PL_VRAM) {
 		adev->vram_pin_size -= amdgpu_bo_size(bo);
-		adev->invisible_pin_size -= amdgpu_vram_mgr_bo_invisible_size(bo);
+		adev->visible_pin_size -= amdgpu_vram_mgr_bo_visible_size(bo);
 	} else if (bo->tbo.mem.mem_type == TTM_PL_TT) {
 		adev->gart_pin_size -= amdgpu_bo_size(bo);
 	}
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -73,7 +73,7 @@ bool amdgpu_gtt_mgr_has_gart_addr(struct
 uint64_t amdgpu_gtt_mgr_usage(struct ttm_mem_type_manager *man);
 int amdgpu_gtt_mgr_recover(struct ttm_mem_type_manager *man);
 
-u64 amdgpu_vram_mgr_bo_invisible_size(struct amdgpu_bo *bo);
+u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo);
 uint64_t amdgpu_vram_mgr_usage(struct ttm_mem_type_manager *man);
 uint64_t amdgpu_vram_mgr_vis_usage(struct ttm_mem_type_manager *man);
 
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -97,33 +97,29 @@ static u64 amdgpu_vram_mgr_vis_size(stru
 }
 
 /**
- * amdgpu_vram_mgr_bo_invisible_size - CPU invisible BO size
+ * amdgpu_vram_mgr_bo_visible_size - CPU visible BO size
  *
  * @bo: &amdgpu_bo buffer object (must be in VRAM)
  *
  * Returns:
- * How much of the given &amdgpu_bo buffer object lies in CPU invisible VRAM.
+ * How much of the given &amdgpu_bo buffer object lies in CPU visible VRAM.
  */
-u64 amdgpu_vram_mgr_bo_invisible_size(struct amdgpu_bo *bo)
+u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct ttm_mem_reg *mem = &bo->tbo.mem;
 	struct drm_mm_node *nodes = mem->mm_node;
 	unsigned pages = mem->num_pages;
-	u64 usage = 0;
+	u64 usage;
 
 	if (adev->gmc.visible_vram_size == adev->gmc.real_vram_size)
-		return 0;
+		return amdgpu_bo_size(bo);
 
 	if (mem->start >= adev->gmc.visible_vram_size >> PAGE_SHIFT)
-		return amdgpu_bo_size(bo);
+		return 0;
 
-	while (nodes && pages) {
-		usage += nodes->size << PAGE_SHIFT;
-		usage -= amdgpu_vram_mgr_vis_size(adev, nodes);
-		pages -= nodes->size;
-		++nodes;
-	}
+	for (usage = 0; nodes && pages; pages -= nodes->size, nodes++)
+		usage += amdgpu_vram_mgr_vis_size(adev, nodes);
 
 	return usage;
 }


