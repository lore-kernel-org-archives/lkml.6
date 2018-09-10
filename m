Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A7DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D21B20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D21B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeIJIPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:15:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbeIJIPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:15:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30FCA406F8A7;
        Mon, 10 Sep 2018 00:57:58 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-121-42.rdu2.redhat.com [10.10.121.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F92A637B2;
        Mon, 10 Sep 2018 00:57:57 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 2/2] gpu/radeon: use HMM mirror for userptr buffer object.
Date:   Sun,  9 Sep 2018 20:57:53 -0400
Message-Id: <20180910005753.5860-3-jglisse@redhat.com>
In-Reply-To: <20180910005753.5860-1-jglisse@redhat.com>
References: <20180910005753.5860-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 10 Sep 2018 00:57:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 10 Sep 2018 00:57:58 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

This replace existing code that rely on get_user_page() aka GUP with
code that now use HMM mirror to mirror a range of virtual address as
a buffer object accessible by the GPU. There is no functional changes
from userspace point of view.

From kernel point of view we no longer pin pages for userptr buffer
object which is a welcome change (i am assuming that everyone dislike
page pin as i do).

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
Cc: Nicolai Hähnle <nicolai.haehnle@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/radeon/radeon.h     |  14 ++-
 drivers/gpu/drm/radeon/radeon_gem.c |  16 +--
 drivers/gpu/drm/radeon/radeon_mn.c  | 157 +++++++++++++++++++++++++++-
 drivers/gpu/drm/radeon/radeon_ttm.c | 129 +++--------------------
 4 files changed, 196 insertions(+), 120 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 1a6f6edb3515..6c83bf911e9c 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -514,6 +514,8 @@ struct radeon_bo {
 	pid_t				pid;
 
 	struct radeon_mn		*mn;
+	uint64_t			*pfns;
+	unsigned long			userptr;
 	struct list_head		mn_list;
 };
 #define gem_to_radeon_bo(gobj) container_of((gobj), struct radeon_bo, gem_base)
@@ -1787,12 +1789,22 @@ void radeon_test_syncing(struct radeon_device *rdev);
 #if defined(CONFIG_MMU_NOTIFIER)
 int radeon_mn_register(struct radeon_bo *bo, unsigned long addr);
 void radeon_mn_unregister(struct radeon_bo *bo);
+int radeon_mn_bo_map(struct radeon_bo *bo, struct ttm_dma_tt *dma, bool write);
+void radeon_mn_bo_unmap(struct radeon_bo *bo, struct ttm_dma_tt *dma,
+			bool write);
 #else
 static inline int radeon_mn_register(struct radeon_bo *bo, unsigned long addr)
 {
 	return -ENODEV;
 }
 static inline void radeon_mn_unregister(struct radeon_bo *bo) {}
+static int radeon_mn_bo_map(struct radeon_bo *bo, struct ttm_dma_tt *dma,
+			    bool write)
+{
+	return -ENODEV;
+}
+static void radeon_mn_bo_unmap(struct radeon_bo *bo, struct ttm_dma_tt *dma,
+			       bool write) {}
 #endif
 
 /*
@@ -2818,7 +2830,7 @@ extern void radeon_legacy_set_clock_gating(struct radeon_device *rdev, int enabl
 extern void radeon_atom_set_clock_gating(struct radeon_device *rdev, int enable);
 extern void radeon_ttm_placement_from_domain(struct radeon_bo *rbo, u32 domain);
 extern bool radeon_ttm_bo_is_radeon_bo(struct ttm_buffer_object *bo);
-extern int radeon_ttm_tt_set_userptr(struct ttm_tt *ttm, uint64_t addr,
+extern int radeon_ttm_tt_set_userptr(struct ttm_tt *ttm, struct radeon_bo *bo,
 				     uint32_t flags);
 extern bool radeon_ttm_tt_has_userptr(struct ttm_tt *ttm);
 extern bool radeon_ttm_tt_is_readonly(struct ttm_tt *ttm);
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 27d8e7dd2d06..b489025086c4 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -323,15 +323,19 @@ int radeon_gem_userptr_ioctl(struct drm_device *dev, void *data,
 		goto handle_lockup;
 
 	bo = gem_to_radeon_bo(gobj);
-	r = radeon_ttm_tt_set_userptr(bo->tbo.ttm, args->addr, args->flags);
+
+	/*
+	 * Always register an HMM mirror (if one is not already registered).
+	 * This means ignoring RADEON_GEM_USERPTR_REGISTER flag but that flag
+	 * is already made mandatory by flags sanity check above.
+	 */
+	r = radeon_mn_register(bo, args->addr);
 	if (r)
 		goto release_object;
 
-	if (args->flags & RADEON_GEM_USERPTR_REGISTER) {
-		r = radeon_mn_register(bo, args->addr);
-		if (r)
-			goto release_object;
-	}
+	r = radeon_ttm_tt_set_userptr(bo->tbo.ttm, bo, args->flags);
+	if (r)
+		goto release_object;
 
 	if (args->flags & RADEON_GEM_USERPTR_VALIDATE) {
 		down_read(&current->mm->mmap_sem);
diff --git a/drivers/gpu/drm/radeon/radeon_mn.c b/drivers/gpu/drm/radeon/radeon_mn.c
index a3bf74c1a3fc..ff53ffa5deef 100644
--- a/drivers/gpu/drm/radeon/radeon_mn.c
+++ b/drivers/gpu/drm/radeon/radeon_mn.c
@@ -262,9 +262,18 @@ int radeon_mn_register(struct radeon_bo *bo, unsigned long addr)
 	struct list_head bos;
 	struct interval_tree_node *it;
 
+	bo->userptr = addr;
+	bo->pfns = kvmalloc_array(bo->tbo.num_pages, sizeof(uint64_t),
+				  GFP_KERNEL | __GFP_ZERO);
+	if (bo->pfns == NULL)
+		return -ENOMEM;
+
 	rmn = radeon_mn_get(rdev);
-	if (IS_ERR(rmn))
+	if (IS_ERR(rmn)) {
+		kvfree(bo->pfns);
+		bo->pfns = NULL;
 		return PTR_ERR(rmn);
+	}
 
 	INIT_LIST_HEAD(&bos);
 
@@ -283,6 +292,8 @@ int radeon_mn_register(struct radeon_bo *bo, unsigned long addr)
 		node = kmalloc(sizeof(struct radeon_mn_node), GFP_KERNEL);
 		if (!node) {
 			mutex_unlock(&rmn->lock);
+			kvfree(bo->pfns);
+			bo->pfns = NULL;
 			return -ENOMEM;
 		}
 	}
@@ -338,4 +349,148 @@ void radeon_mn_unregister(struct radeon_bo *bo)
 
 	mutex_unlock(&rmn->lock);
 	mutex_unlock(&rdev->mn_lock);
+
+	kvfree(bo->pfns);
+	bo->pfns = NULL;
+}
+
+/**
+ * radeon_mn_bo_map - map range of virtual address as buffer object
+ *
+ * @bo: radeon buffer object
+ * @ttm: ttm_tt object in which holds mirroring result
+ * @write: can GPU write to the range ?
+ * Returns: 0 on success, error code otherwise
+ *
+ * Use HMM to mirror a range of virtual address as a buffer object mapped into
+ * GPU address space (thus allowing transparent GPU access to this range). It
+ * does not pin pages for range but rely on HMM and underlying synchronizations
+ * to make sure that both CPU and GPU points to same physical memory for the
+ * range.
+ */
+int radeon_mn_bo_map(struct radeon_bo *bo, struct ttm_dma_tt *dma, bool write)
+{
+	static const uint64_t radeon_range_flags[HMM_PFN_FLAG_MAX] = {
+		(1 << 0), /* HMM_PFN_VALID */
+		(1 << 1), /* HMM_PFN_WRITE */
+		0 /* HMM_PFN_DEVICE_PRIVATE */
+	};
+	static const uint64_t radeon_range_values[HMM_PFN_VALUE_MAX] = {
+		0xfffffffffffffffeUL, /* HMM_PFN_ERROR */
+		0, /* HMM_PFN_NONE */
+		0xfffffffffffffffcUL /* HMM_PFN_SPECIAL */
+	};
+
+	unsigned long i, npages = bo->tbo.num_pages;
+	enum dma_data_direction direction = write ?
+		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
+	struct radeon_device *rdev = bo->rdev;
+	struct ttm_tt *ttm = &dma->ttm;
+	struct hmm_range range;
+	struct radeon_mn *rmn;
+	int ret;
+
+	/*
+	 * FIXME This whole protection shouldn't be needed as we should only
+	 * reach that code with a valid reserved bo that can not under go a
+	 * concurrent radeon_mn_unregister().
+	 */
+	mutex_lock(&rdev->mn_lock);
+	if (bo->mn == NULL) {
+		mutex_unlock(&rdev->mn_lock);
+		return -EINVAL;
+	}
+	rmn = bo->mn;
+	mutex_unlock(&rdev->mn_lock);
+
+	range.pfn_shift = 12;
+	range.pfns = bo->pfns;
+	range.start = bo->userptr;
+	range.flags = radeon_range_flags;
+	range.values = radeon_range_values;
+	range.end = bo->userptr + radeon_bo_size(bo);
+
+	range.vma = find_vma(rmn->mm, bo->userptr);
+	if (!range.vma || range.vma->vm_file || range.vma->vm_end < range.end)
+		return -EPERM;
+
+	memset(ttm->pages, 0, sizeof(void*) * npages);
+
+again:
+	for (i = 0; i < npages; ++i) {
+		range.pfns[i] = range.flags[HMM_PFN_VALID];
+		range.pfns[i] |= write ? range.flags[HMM_PFN_WRITE] : 0;
+	}
+
+	ret = hmm_vma_fault(&range, true);
+	if (ret)
+		goto err_unmap;
+
+	for (i = 0; i < npages; ++i) {
+		struct page *page = hmm_pfn_to_page(&range, range.pfns[i]);
+
+		if (page == NULL)
+			goto again;
+
+		if (ttm->pages[i] == page)
+			continue;
+
+		if (ttm->pages[i])
+			dma_unmap_page(rdev->dev, dma->dma_address[i],
+				       PAGE_SIZE, direction);
+		ttm->pages[i] = page;
+
+		dma->dma_address[i] = dma_map_page(rdev->dev, page, 0,
+						   PAGE_SIZE, direction);
+		if (dma_mapping_error(rdev->dev, dma->dma_address[i])) {
+			hmm_vma_range_done(&range);
+			ttm->pages[i] = NULL;
+			ret = -ENOMEM;
+			goto err_unmap;
+		}
+	}
+
+	/*
+	 * Taking rmn->lock is not necessary here as we are protected from any
+	 * concurrent invalidation through ttm object reservation. Involved
+	 * functions: radeon_sync_cpu_device_pagetables()
+	 *            radeon_bo_list_validate()
+	 *            radeon_gem_userptr_ioctl()
+	 */
+	if (!hmm_vma_range_done(&range))
+		goto again;
+
+	return 0;
+
+err_unmap:
+	radeon_mn_bo_unmap(bo, dma, write);
+	return ret;
+}
+
+/**
+ * radeon_mn_bo_unmap - unmap range of virtual address as buffer object
+ *
+ * @bo: radeon buffer object
+ * @ttm: ttm_tt object in which holds mirroring result
+ * @write: can GPU write to the range ?
+ * Returns: 0 on success, error code otherwise
+ */
+void radeon_mn_bo_unmap(struct radeon_bo *bo, struct ttm_dma_tt *dma,
+			bool write)
+{
+	unsigned long i, npages = bo->tbo.num_pages;
+	enum dma_data_direction direction = write ?
+		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
+	struct radeon_device *rdev = bo->rdev;
+	struct ttm_tt *ttm = &dma->ttm;
+
+	for (i = 0; i < npages; ++i) {
+		/* No need to go beyond first NULL page */
+		if (ttm->pages[i] == NULL)
+			break;
+
+		dma_unmap_page(rdev->dev, dma->dma_address[i],
+			       PAGE_SIZE, direction);
+		ttm->pages[i] = NULL;
+	}
 }
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index cbb67e9ffb3a..9c33e6c429b2 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -533,103 +533,10 @@ struct radeon_ttm_tt {
 	struct radeon_device		*rdev;
 	u64				offset;
 
-	uint64_t			userptr;
-	struct mm_struct		*usermm;
+	struct radeon_bo		*bo;
 	uint32_t			userflags;
 };
 
-/* prepare the sg table with the user pages */
-static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
-{
-	struct radeon_device *rdev = radeon_get_rdev(ttm->bdev);
-	struct radeon_ttm_tt *gtt = (void *)ttm;
-	unsigned pinned = 0, nents;
-	int r;
-
-	int write = !(gtt->userflags & RADEON_GEM_USERPTR_READONLY);
-	enum dma_data_direction direction = write ?
-		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
-
-	if (current->mm != gtt->usermm)
-		return -EPERM;
-
-	if (gtt->userflags & RADEON_GEM_USERPTR_ANONONLY) {
-		/* check that we only pin down anonymous memory
-		   to prevent problems with writeback */
-		unsigned long end = gtt->userptr + ttm->num_pages * PAGE_SIZE;
-		struct vm_area_struct *vma;
-		vma = find_vma(gtt->usermm, gtt->userptr);
-		if (!vma || vma->vm_file || vma->vm_end < end)
-			return -EPERM;
-	}
-
-	do {
-		unsigned num_pages = ttm->num_pages - pinned;
-		uint64_t userptr = gtt->userptr + pinned * PAGE_SIZE;
-		struct page **pages = ttm->pages + pinned;
-
-		r = get_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
-				   pages, NULL);
-		if (r < 0)
-			goto release_pages;
-
-		pinned += r;
-
-	} while (pinned < ttm->num_pages);
-
-	r = sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm->num_pages, 0,
-				      ttm->num_pages << PAGE_SHIFT,
-				      GFP_KERNEL);
-	if (r)
-		goto release_sg;
-
-	r = -ENOMEM;
-	nents = dma_map_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
-	if (nents != ttm->sg->nents)
-		goto release_sg;
-
-	drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
-					 gtt->ttm.dma_address, ttm->num_pages);
-
-	return 0;
-
-release_sg:
-	kfree(ttm->sg);
-
-release_pages:
-	release_pages(ttm->pages, pinned);
-	return r;
-}
-
-static void radeon_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
-{
-	struct radeon_device *rdev = radeon_get_rdev(ttm->bdev);
-	struct radeon_ttm_tt *gtt = (void *)ttm;
-	struct sg_page_iter sg_iter;
-
-	int write = !(gtt->userflags & RADEON_GEM_USERPTR_READONLY);
-	enum dma_data_direction direction = write ?
-		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
-
-	/* double check that we don't free the table twice */
-	if (!ttm->sg->sgl)
-		return;
-
-	/* free the sg table and pages again */
-	dma_unmap_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
-
-	for_each_sg_page(ttm->sg->sgl, &sg_iter, ttm->sg->nents, 0) {
-		struct page *page = sg_page_iter_page(&sg_iter);
-		if (!(gtt->userflags & RADEON_GEM_USERPTR_READONLY))
-			set_page_dirty(page);
-
-		mark_page_accessed(page);
-		put_page(page);
-	}
-
-	sg_free_table(ttm->sg);
-}
-
 static int radeon_ttm_backend_bind(struct ttm_tt *ttm,
 				   struct ttm_mem_reg *bo_mem)
 {
@@ -638,8 +545,12 @@ static int radeon_ttm_backend_bind(struct ttm_tt *ttm,
 		RADEON_GART_PAGE_WRITE;
 	int r;
 
-	if (gtt->userptr) {
-		radeon_ttm_tt_pin_userptr(ttm);
+	if (gtt->bo) {
+		bool write = !(gtt->userflags & RADEON_GEM_USERPTR_READONLY);
+
+		r = radeon_mn_bo_map(gtt->bo, &gtt->ttm, write);
+		if (r)
+			return r;
 		flags &= ~RADEON_GART_PAGE_WRITE;
 	}
 
@@ -666,8 +577,11 @@ static int radeon_ttm_backend_unbind(struct ttm_tt *ttm)
 
 	radeon_gart_unbind(gtt->rdev, gtt->offset, ttm->num_pages);
 
-	if (gtt->userptr)
-		radeon_ttm_tt_unpin_userptr(ttm);
+	if (gtt->bo) {
+		bool write = !(gtt->userflags & RADEON_GEM_USERPTR_READONLY);
+
+		radeon_mn_bo_unmap(gtt->bo, &gtt->ttm, write);
+	}
 
 	return 0;
 }
@@ -727,12 +641,7 @@ static int radeon_ttm_tt_populate(struct ttm_tt *ttm,
 	struct radeon_device *rdev;
 	bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
 
-	if (gtt && gtt->userptr) {
-		ttm->sg = kzalloc(sizeof(struct sg_table), GFP_KERNEL);
-		if (!ttm->sg)
-			return -ENOMEM;
-
-		ttm->page_flags |= TTM_PAGE_FLAG_SG;
+	if (gtt && gtt->bo) {
 		ttm->state = tt_unbound;
 		return 0;
 	}
@@ -766,11 +675,8 @@ static void radeon_ttm_tt_unpopulate(struct ttm_tt *ttm)
 	struct radeon_ttm_tt *gtt = radeon_ttm_tt_to_gtt(ttm);
 	bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
 
-	if (gtt && gtt->userptr) {
-		kfree(ttm->sg);
-		ttm->page_flags &= ~TTM_PAGE_FLAG_SG;
+	if (gtt && gtt->bo)
 		return;
-	}
 
 	if (slave)
 		return;
@@ -793,7 +699,7 @@ static void radeon_ttm_tt_unpopulate(struct ttm_tt *ttm)
 	ttm_unmap_and_unpopulate_pages(rdev->dev, &gtt->ttm);
 }
 
-int radeon_ttm_tt_set_userptr(struct ttm_tt *ttm, uint64_t addr,
+int radeon_ttm_tt_set_userptr(struct ttm_tt *ttm, struct radeon_bo *bo,
 			      uint32_t flags)
 {
 	struct radeon_ttm_tt *gtt = radeon_ttm_tt_to_gtt(ttm);
@@ -801,8 +707,7 @@ int radeon_ttm_tt_set_userptr(struct ttm_tt *ttm, uint64_t addr,
 	if (gtt == NULL)
 		return -EINVAL;
 
-	gtt->userptr = addr;
-	gtt->usermm = current->mm;
+	gtt->bo = bo;
 	gtt->userflags = flags;
 	return 0;
 }
@@ -814,7 +719,7 @@ bool radeon_ttm_tt_has_userptr(struct ttm_tt *ttm)
 	if (gtt == NULL)
 		return false;
 
-	return !!gtt->userptr;
+	return !!gtt->bo;
 }
 
 bool radeon_ttm_tt_is_readonly(struct ttm_tt *ttm)
-- 
2.17.1

