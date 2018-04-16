Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbeDPQAp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:00:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46456 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752881AbeDPQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:00:44 -0400
X-Google-Smtp-Source: AIpwx4/AtTKGbLof9+MoKWIxMkx35EcM9BxRv/qGgrtJSVeaB3+V9lo8DmzxT7lLzuuc4VyOmE78ZA==
Date: Mon, 16 Apr 2018 21:32:33 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: linux@armlinux.org.uk, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH] gpu: drm: armada: Adding new typedef vm_fault_t
Message-ID: <20180416160233.GA27043@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler
in struct vm_operations_struct. For now, this is
just documenting that the function returns a VM_
FAULT value rather than an errno.  Once all inst
ances are converted, vm_fault_t will become a di
stinct type.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/gpu/drm/armada/armada_gem.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index a97f509..81a55b7 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -13,25 +13,14 @@
 #include <drm/armada_drm.h>
 #include "armada_ioctlP.h"

-static int armada_gem_vm_fault(struct vm_fault *vmf)
+static vm_fault_t armada_gem_vm_fault(struct vm_fault *vmf)
 {
 	struct drm_gem_object *gobj = vmf->vma->vm_private_data;
 	struct armada_gem_object *obj = drm_to_armada_gem(gobj);
 	unsigned long pfn = obj->phys_addr >> PAGE_SHIFT;
-	int ret;

 	pfn += (vmf->address - vmf->vma->vm_start) >> PAGE_SHIFT;
-	ret = vm_insert_pfn(vmf->vma, vmf->address, pfn);
-
-	switch (ret) {
-	case 0:
-	case -EBUSY:
-		return VM_FAULT_NOPAGE;
-	case -ENOMEM:
-		return VM_FAULT_OOM;
-	default:
-		return VM_FAULT_SIGBUS;
-	}
+	return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
 }

 const struct vm_operations_struct armada_gem_vm_ops = {
--
1.9.1
