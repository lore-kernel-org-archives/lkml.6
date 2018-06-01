Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbeFATZK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:25:10 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34014 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbeFATZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:25:08 -0400
X-Google-Smtp-Source: ADUXVKLRf7PsNyuQlgTv6/lqZmu3tM4pZCK0DQwxu9MmAWTDgDBvYqeeHA1MCkF8iMTgNneXRopgzA==
Date: Sat, 2 Jun 2018 00:57:24 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: christian.koenig@amd.com, airlied@linux.ie, willy@infradead.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpu: drm: ttm: Adding new return type vm_fault_t
Message-ID: <20180601192724.GA2001@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Previously vm_insert_{mixed,pfn} returns err which driver
mapped into VM_FAULT_* type. The new function
vmf_insert_{mixed,pfn} will replace this inefficiency by
returning VM_FAULT_* type.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2: Address christian's comment. Put reverse
    xmas tree order for variable declarations.

 drivers/gpu/drm/ttm/ttm_bo_vm.c | 45 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 8eba95b..9de8b4f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -43,10 +43,11 @@
 
 #define TTM_BO_VM_NUM_PREFAULT 16
 
-static int ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
+static vm_fault_t ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
 				struct vm_fault *vmf)
 {
-	int ret = 0;
+	vm_fault_t ret = 0;
+	int err = 0;
 
 	if (likely(!bo->moving))
 		goto out_unlock;
@@ -77,9 +78,9 @@ static int ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
 	/*
 	 * Ordinary wait.
 	 */
-	ret = dma_fence_wait(bo->moving, true);
-	if (unlikely(ret != 0)) {
-		ret = (ret != -ERESTARTSYS) ? VM_FAULT_SIGBUS :
+	err = dma_fence_wait(bo->moving, true);
+	if (unlikely(err != 0)) {
+		ret = (err != -ERESTARTSYS) ? VM_FAULT_SIGBUS :
 			VM_FAULT_NOPAGE;
 		goto out_unlock;
 	}
@@ -104,7 +105,7 @@ static unsigned long ttm_bo_io_mem_pfn(struct ttm_buffer_object *bo,
 		+ page_offset;
 }
 
-static int ttm_bo_vm_fault(struct vm_fault *vmf)
+static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
@@ -115,8 +116,9 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
 	unsigned long pfn;
 	struct ttm_tt *ttm = NULL;
 	struct page *page;
-	int ret;
+	int err;
 	int i;
+	vm_fault_t ret = VM_FAULT_NOPAGE;
 	unsigned long address = vmf->address;
 	struct ttm_mem_type_manager *man =
 		&bdev->man[bo->mem.mem_type];
@@ -128,9 +130,9 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
 	 * for reserve, and if it fails, retry the fault after waiting
 	 * for the buffer to become unreserved.
 	 */
-	ret = ttm_bo_reserve(bo, true, true, NULL);
-	if (unlikely(ret != 0)) {
-		if (ret != -EBUSY)
+	err = ttm_bo_reserve(bo, true, true, NULL);
+	if (unlikely(err != 0)) {
+		if (err != -EBUSY)
 			return VM_FAULT_NOPAGE;
 
 		if (vmf->flags & FAULT_FLAG_ALLOW_RETRY) {
@@ -162,8 +164,8 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
 	}
 
 	if (bdev->driver->fault_reserve_notify) {
-		ret = bdev->driver->fault_reserve_notify(bo);
-		switch (ret) {
+		err = bdev->driver->fault_reserve_notify(bo);
+		switch (err) {
 		case 0:
 			break;
 		case -EBUSY:
@@ -191,13 +193,13 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
 		goto out_unlock;
 	}
 
-	ret = ttm_mem_io_lock(man, true);
-	if (unlikely(ret != 0)) {
+	err = ttm_mem_io_lock(man, true);
+	if (unlikely(err != 0)) {
 		ret = VM_FAULT_NOPAGE;
 		goto out_unlock;
 	}
-	ret = ttm_mem_io_reserve_vm(bo);
-	if (unlikely(ret != 0)) {
+	err = ttm_mem_io_reserve_vm(bo);
+	if (unlikely(err != 0)) {
 		ret = VM_FAULT_SIGBUS;
 		goto out_io_unlock;
 	}
@@ -265,23 +267,20 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
 		}
 
 		if (vma->vm_flags & VM_MIXEDMAP)
-			ret = vm_insert_mixed(&cvma, address,
+			ret = vmf_insert_mixed(&cvma, address,
 					__pfn_to_pfn_t(pfn, PFN_DEV));
 		else
-			ret = vm_insert_pfn(&cvma, address, pfn);
+			ret = vmf_insert_pfn(&cvma, address, pfn);
 
 		/*
 		 * Somebody beat us to this PTE or prefaulting to
 		 * an already populated PTE, or prefaulting error.
 		 */
 
-		if (unlikely((ret == -EBUSY) || (ret != 0 && i > 0)))
+		if (unlikely((ret == VM_FAULT_NOPAGE && i > 0)))
 			break;
-		else if (unlikely(ret != 0)) {
-			ret =
-			    (ret == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
+		else if (unlikely(ret & VM_FAULT_ERROR))
 			goto out_io_unlock;
-		}
 
 		address += PAGE_SIZE;
 		if (unlikely(++page_offset >= page_last))
-- 
1.9.1
