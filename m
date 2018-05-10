Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966071AbeEJPCp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:02:45 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34491 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965404AbeEJPCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:02:44 -0400
X-Google-Smtp-Source: AB8JxZqhTRp+XqRcM7nzmQoeTpQ7LiNpjGZrqAh83www385IFjw5/8H3idF6mIzmHTk+YaJZpxSgkA==
Date: Thu, 10 May 2018 20:34:48 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: linux@armlinux.org.uk, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH v2] gpu: drm: armada: Adding new typedef vm_fault_t
Message-ID: <20180510150448.GA26306@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler in
struct vm_operations_struct. For now, this is just
documenting that the function returns a VM_FAULT
value rather than an errno. Once all instances are
converted, vm_fault_t will become a distinct type.

commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Previously vm_insert_pfn() returns err which driver
mapped into VM_FAULT_* type. The new function
vmf_insert_pfn() will replace this inefficiency by
returning VM_FAULT_* type.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
v2: Updated the change log

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
