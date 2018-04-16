Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeDPPAp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:00:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35483 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeDPPAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:00:40 -0400
X-Google-Smtp-Source: AIpwx49kb5qbulTMMz9Cz3uLt4qkBFO6T4UT0kyRShkDrI9dilegMo14/fGAA+DegnKnhTXiOlkPXQ==
Date: Mon, 16 Apr 2018 20:32:32 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH] gpu: drm: vgem: Change return type to vm_fault_t
Message-ID: <20180416150232.GA26745@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index 2524ff1..c64a859 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -61,13 +61,13 @@ static void vgem_gem_free_object(struct drm_gem_object *obj)
 	kfree(vgem_obj);
 }
 
-static int vgem_gem_fault(struct vm_fault *vmf)
+static vm_fault_t vgem_gem_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct drm_vgem_gem_object *obj = vma->vm_private_data;
 	/* We don't use vmf->pgoff since that has the fake offset */
 	unsigned long vaddr = vmf->address;
-	int ret;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
 	loff_t num_pages;
 	pgoff_t page_offset;
 	page_offset = (vaddr - vma->vm_start) >> PAGE_SHIFT;
@@ -77,7 +77,6 @@ static int vgem_gem_fault(struct vm_fault *vmf)
 	if (page_offset > num_pages)
 		return VM_FAULT_SIGBUS;
 
-	ret = -ENOENT;
 	mutex_lock(&obj->pages_lock);
 	if (obj->pages) {
 		get_page(obj->pages[page_offset]);
-- 
1.9.1
