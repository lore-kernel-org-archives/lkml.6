Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD28C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69254218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389967AbeLTVgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:36:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:31754 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbeLTVgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:36:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2018 13:36:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,378,1539673200"; 
   d="scan'208";a="120062114"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2018 13:36:49 -0800
Subject: [PATCH] mm/hmm: Fix memremap.h,
 move dev_page_fault_t callback to hmm
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 20 Dec 2018 13:24:13 -0800
Message-ID: <154534090899.3120190.6652620807617715272.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kbuild robot reported the following on a development branch that
used memremap.h in a new path:

   In file included from arch/m68k/include/asm/pgtable_mm.h:148:0,
                     from arch/m68k/include/asm/pgtable.h:5,
                     from include/linux/memremap.h:7,
                     from drivers//dax/bus.c:3:
    arch/m68k/include/asm/motorola_pgtable.h: In function 'pgd_offset':
 >> arch/m68k/include/asm/motorola_pgtable.h:199:11: error: dereferencing pointer to incomplete type 'const struct mm_struct'
      return mm->pgd + pgd_index(address);
               ^~

The ->page_fault() callback is specific to HMM. Move it to 'struct
hmm_devmem' where the unusual asm/pgtable.h dependency can be contained
in include/linux/hmm.h.  Longer term refactoring this dependency out of
HMM is recommended, but in the meantime memremap.h remains generic.

Fixes: 5042db43cc26 "mm/ZONE_DEVICE: new type of ZONE_DEVICE memory..."
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Hi Andrew, a fairly straightfoward fix, hopefully Jérôme has time to ack
it before the holidays.

It has been exposed to 0day for a few hours with no reported compile
breakage.

 include/linux/hmm.h      |   24 ++++++++++++++++++++++++
 include/linux/memremap.h |   32 --------------------------------
 kernel/memremap.c        |    6 +++++-
 mm/hmm.c                 |    4 ++--
 4 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index ed89fbc525d2..66f9ebbb1df3 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -69,6 +69,7 @@
 #define LINUX_HMM_H
 
 #include <linux/kconfig.h>
+#include <asm/pgtable.h>
 
 #if IS_ENABLED(CONFIG_HMM)
 
@@ -486,6 +487,7 @@ struct hmm_devmem_ops {
  * @device: device to bind resource to
  * @ops: memory operations callback
  * @ref: per CPU refcount
+ * @page_fault: callback when CPU fault on an unaddressable device page
  *
  * This an helper structure for device drivers that do not wish to implement
  * the gory details related to hotplugging new memoy and allocating struct
@@ -493,7 +495,28 @@ struct hmm_devmem_ops {
  *
  * Device drivers can directly use ZONE_DEVICE memory on their own if they
  * wish to do so.
+ *
+ * The page_fault() callback must migrate page back, from device memory to
+ * system memory, so that the CPU can access it. This might fail for various
+ * reasons (device issues,  device have been unplugged, ...). When such error
+ * conditions happen, the page_fault() callback must return VM_FAULT_SIGBUS and
+ * set the CPU page table entry to "poisoned".
+ *
+ * Note that because memory cgroup charges are transferred to the device memory,
+ * this should never fail due to memory restrictions. However, allocation
+ * of a regular system page might still fail because we are out of memory. If
+ * that happens, the page_fault() callback must return VM_FAULT_OOM.
+ *
+ * The page_fault() callback can also try to migrate back multiple pages in one
+ * chunk, as an optimization. It must, however, prioritize the faulting address
+ * over all the others.
  */
+typedef int (*dev_page_fault_t)(struct vm_area_struct *vma,
+				unsigned long addr,
+				const struct page *page,
+				unsigned int flags,
+				pmd_t *pmdp);
+
 struct hmm_devmem {
 	struct completion		completion;
 	unsigned long			pfn_first;
@@ -503,6 +526,7 @@ struct hmm_devmem {
 	struct dev_pagemap		pagemap;
 	const struct hmm_devmem_ops	*ops;
 	struct percpu_ref		ref;
+	dev_page_fault_t		page_fault;
 };
 
 /*
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 55db66b3716f..f0628660d541 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -4,8 +4,6 @@
 #include <linux/ioport.h>
 #include <linux/percpu-refcount.h>
 
-#include <asm/pgtable.h>
-
 struct resource;
 struct device;
 
@@ -66,47 +64,18 @@ enum memory_type {
 };
 
 /*
- * For MEMORY_DEVICE_PRIVATE we use ZONE_DEVICE and extend it with two
- * callbacks:
- *   page_fault()
- *   page_free()
- *
  * Additional notes about MEMORY_DEVICE_PRIVATE may be found in
  * include/linux/hmm.h and Documentation/vm/hmm.rst. There is also a brief
  * explanation in include/linux/memory_hotplug.h.
  *
- * The page_fault() callback must migrate page back, from device memory to
- * system memory, so that the CPU can access it. This might fail for various
- * reasons (device issues,  device have been unplugged, ...). When such error
- * conditions happen, the page_fault() callback must return VM_FAULT_SIGBUS and
- * set the CPU page table entry to "poisoned".
- *
- * Note that because memory cgroup charges are transferred to the device memory,
- * this should never fail due to memory restrictions. However, allocation
- * of a regular system page might still fail because we are out of memory. If
- * that happens, the page_fault() callback must return VM_FAULT_OOM.
- *
- * The page_fault() callback can also try to migrate back multiple pages in one
- * chunk, as an optimization. It must, however, prioritize the faulting address
- * over all the others.
- *
- *
  * The page_free() callback is called once the page refcount reaches 1
  * (ZONE_DEVICE pages never reach 0 refcount unless there is a refcount bug.
  * This allows the device driver to implement its own memory management.)
- *
- * For MEMORY_DEVICE_PUBLIC only the page_free() callback matter.
  */
-typedef int (*dev_page_fault_t)(struct vm_area_struct *vma,
-				unsigned long addr,
-				const struct page *page,
-				unsigned int flags,
-				pmd_t *pmdp);
 typedef void (*dev_page_free_t)(struct page *page, void *data);
 
 /**
  * struct dev_pagemap - metadata for ZONE_DEVICE mappings
- * @page_fault: callback when CPU fault on an unaddressable device page
  * @page_free: free page callback when page refcount reaches 1
  * @altmap: pre-allocated/reserved memory for vmemmap allocations
  * @res: physical address range covered by @ref
@@ -117,7 +86,6 @@ typedef void (*dev_page_free_t)(struct page *page, void *data);
  * @type: memory type: see MEMORY_* in memory_hotplug.h
  */
 struct dev_pagemap {
-	dev_page_fault_t page_fault;
 	dev_page_free_t page_free;
 	struct vmem_altmap altmap;
 	bool altmap_valid;
diff --git a/kernel/memremap.c b/kernel/memremap.c
index 66cbf334203b..f458b44303c9 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/wait_bit.h>
 #include <linux/xarray.h>
+#include <linux/hmm.h>
 
 static DEFINE_XARRAY(pgmap_array);
 #define SECTION_MASK ~((1UL << PA_SECTION_SHIFT) - 1)
@@ -24,6 +25,9 @@ vm_fault_t device_private_entry_fault(struct vm_area_struct *vma,
 		       pmd_t *pmdp)
 {
 	struct page *page = device_private_entry_to_page(entry);
+	struct hmm_devmem *devmem;
+
+	devmem = container_of(page->pgmap, typeof(*devmem), pagemap);
 
 	/*
 	 * The page_fault() callback must migrate page back to system memory
@@ -39,7 +43,7 @@ vm_fault_t device_private_entry_fault(struct vm_area_struct *vma,
 	 * There is a more in-depth description of what that callback can and
 	 * cannot do, in include/linux/memremap.h
 	 */
-	return page->pgmap->page_fault(vma, addr, page, flags, pmdp);
+	return devmem->page_fault(vma, addr, page, flags, pmdp);
 }
 EXPORT_SYMBOL(device_private_entry_fault);
 #endif /* CONFIG_DEVICE_PRIVATE */
diff --git a/mm/hmm.c b/mm/hmm.c
index 789587731217..a04e4b810610 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1087,10 +1087,10 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
 	devmem->pfn_first = devmem->resource->start >> PAGE_SHIFT;
 	devmem->pfn_last = devmem->pfn_first +
 			   (resource_size(devmem->resource) >> PAGE_SHIFT);
+	devmem->page_fault = hmm_devmem_fault;
 
 	devmem->pagemap.type = MEMORY_DEVICE_PRIVATE;
 	devmem->pagemap.res = *devmem->resource;
-	devmem->pagemap.page_fault = hmm_devmem_fault;
 	devmem->pagemap.page_free = hmm_devmem_free;
 	devmem->pagemap.altmap_valid = false;
 	devmem->pagemap.ref = &devmem->ref;
@@ -1141,10 +1141,10 @@ struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
 	devmem->pfn_first = devmem->resource->start >> PAGE_SHIFT;
 	devmem->pfn_last = devmem->pfn_first +
 			   (resource_size(devmem->resource) >> PAGE_SHIFT);
+	devmem->page_fault = hmm_devmem_fault;
 
 	devmem->pagemap.type = MEMORY_DEVICE_PUBLIC;
 	devmem->pagemap.res = *devmem->resource;
-	devmem->pagemap.page_fault = hmm_devmem_fault;
 	devmem->pagemap.page_free = hmm_devmem_free;
 	devmem->pagemap.altmap_valid = false;
 	devmem->pagemap.ref = &devmem->ref;

