Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE70C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D63B20652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s0533yIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389709AbfAKSF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:05:56 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42058 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389610AbfAKSFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:05:44 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BI5brN058999;
        Fri, 11 Jan 2019 12:05:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547229937;
        bh=Jc1OL8GeWWEGmFbW9ZJ2okPOD3+6fm9W/jl9Ijy/eG4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=s0533yILwWFiGj3iNFig8ZKchF3QzPSeVP1wevfesfg7DPlv0jzZYRTy12G5GXyWJ
         yEmyjfcreGeVNaxHrbNLJ4VQgyk0jUmNcSlMo0VJW2BIzuWwFOHRSh7VXAxIF/k2SN
         9SVJ9XZyuHEKFJb8CqBOxivXIHX/w10ZH9LsEgNY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BI5bMQ022637
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 12:05:37 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 12:05:36 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 12:05:36 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BI5aHF006509;
        Fri, 11 Jan 2019 12:05:36 -0600
Received: from localhost (uda0226330.dhcp.ti.com [172.22.109.196])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0BI5aU07772;
        Fri, 11 Jan 2019 12:05:36 -0600 (CST)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 14/14] staging: android: ion: Add UNMAPPED heap type and helper
Date:   Fri, 11 Jan 2019 12:05:23 -0600
Message-ID: <20190111180523.27862-15-afd@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111180523.27862-1-afd@ti.com>
References: <20190111180523.27862-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "unmapped" heap is very similar to the carveout heap except
the backing memory is presumed to be unmappable by the host, in
my specific case due to firewalls. This memory can still be
allocated from and used by devices that do have access to the
backing memory.

Based originally on the secure/unmapped heap from Linaro for
the OP-TEE SDP implementation, this was re-written to match
the carveout heap helper code.

Suggested-by: Etienne Carriere <etienne.carriere@linaro.org>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/staging/android/ion/Kconfig           |  10 ++
 drivers/staging/android/ion/Makefile          |   1 +
 drivers/staging/android/ion/ion.h             |  16 +++
 .../staging/android/ion/ion_unmapped_heap.c   | 123 ++++++++++++++++++
 drivers/staging/android/uapi/ion.h            |   3 +
 5 files changed, 153 insertions(+)
 create mode 100644 drivers/staging/android/ion/ion_unmapped_heap.c

diff --git a/drivers/staging/android/ion/Kconfig b/drivers/staging/android/ion/Kconfig
index 0fdda6f62953..a117b8b91b14 100644
--- a/drivers/staging/android/ion/Kconfig
+++ b/drivers/staging/android/ion/Kconfig
@@ -42,3 +42,13 @@ config ION_CMA_HEAP
 	  Choose this option to enable CMA heaps with Ion. This heap is backed
 	  by the Contiguous Memory Allocator (CMA). If your system has these
 	  regions, you should say Y here.
+
+config ION_UNMAPPED_HEAP
+	bool "ION unmapped heap support"
+	depends on ION
+	help
+	  Choose this option to enable UNMAPPED heaps with Ion. This heap is
+	  backed in specific memory pools, carveout from the Linux memory.
+	  Unlike carveout heaps these are assumed to be not mappable by
+	  kernel or user-space.
+	  Unless you know your system has these regions, you should say N here.
diff --git a/drivers/staging/android/ion/Makefile b/drivers/staging/android/ion/Makefile
index 17f3a7569e3d..c71a1f3de581 100644
--- a/drivers/staging/android/ion/Makefile
+++ b/drivers/staging/android/ion/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_ION_SYSTEM_HEAP) += ion_system_heap.o ion_page_pool.o
 obj-$(CONFIG_ION_CARVEOUT_HEAP) += ion_carveout_heap.o
 obj-$(CONFIG_ION_CHUNK_HEAP) += ion_chunk_heap.o
 obj-$(CONFIG_ION_CMA_HEAP) += ion_cma_heap.o
+obj-$(CONFIG_ION_UNMAPPED_HEAP) += ion_unmapped_heap.o
diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index 97b2876b165a..ce74332018ba 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -341,4 +341,20 @@ static inline struct ion_heap *ion_chunk_heap_create(phys_addr_t base, size_t si
 }
 #endif
 
+#ifdef CONFIG_ION_UNMAPPED_HEAP
+/**
+ * ion_unmapped_heap_create
+ * @base:		base address of carveout memory
+ * @size:		size of carveout memory region
+ *
+ * Creates an unmapped ion_heap using the passed in data
+ */
+struct ion_heap *ion_unmapped_heap_create(phys_addr_t base, size_t size);
+#else
+struct ion_heap *ion_unmapped_heap_create(phys_addr_t base, size_t size)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+
 #endif /* _ION_H */
diff --git a/drivers/staging/android/ion/ion_unmapped_heap.c b/drivers/staging/android/ion/ion_unmapped_heap.c
new file mode 100644
index 000000000000..7602b659c2ec
--- /dev/null
+++ b/drivers/staging/android/ion/ion_unmapped_heap.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ION Memory Allocator unmapped heap helper
+ *
+ * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ *	Andrew F. Davis <afd@ti.com>
+ *
+ * ION "unmapped" heaps are physical memory heaps not by default mapped into
+ * a virtual address space. The buffer owner can explicitly request kernel
+ * space mappings but the underlying memory may still not be accessible for
+ * various reasons, such as firewalls.
+ */
+
+#include <linux/err.h>
+#include <linux/genalloc.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+
+#include "ion.h"
+
+#define ION_UNMAPPED_ALLOCATE_FAIL -1
+
+struct ion_unmapped_heap {
+	struct ion_heap heap;
+	struct gen_pool *pool;
+};
+
+static phys_addr_t ion_unmapped_allocate(struct ion_heap *heap,
+					 unsigned long size)
+{
+	struct ion_unmapped_heap *unmapped_heap =
+		container_of(heap, struct ion_unmapped_heap, heap);
+	unsigned long offset;
+
+	offset = gen_pool_alloc(unmapped_heap->pool, size);
+	if (!offset)
+		return ION_UNMAPPED_ALLOCATE_FAIL;
+
+	return offset;
+}
+
+static void ion_unmapped_free(struct ion_heap *heap, phys_addr_t addr,
+			      unsigned long size)
+{
+	struct ion_unmapped_heap *unmapped_heap =
+		container_of(heap, struct ion_unmapped_heap, heap);
+
+	gen_pool_free(unmapped_heap->pool, addr, size);
+}
+
+static int ion_unmapped_heap_allocate(struct ion_heap *heap,
+				      struct ion_buffer *buffer,
+				      unsigned long size,
+				      unsigned long flags)
+{
+	struct sg_table *table;
+	phys_addr_t paddr;
+	int ret;
+
+	table = kmalloc(sizeof(*table), GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+	ret = sg_alloc_table(table, 1, GFP_KERNEL);
+	if (ret)
+		goto err_free;
+
+	paddr = ion_unmapped_allocate(heap, size);
+	if (paddr == ION_UNMAPPED_ALLOCATE_FAIL) {
+		ret = -ENOMEM;
+		goto err_free_table;
+	}
+
+	sg_set_page(table->sgl, pfn_to_page(PFN_DOWN(paddr)), size, 0);
+	buffer->sg_table = table;
+
+	return 0;
+
+err_free_table:
+	sg_free_table(table);
+err_free:
+	kfree(table);
+	return ret;
+}
+
+static void ion_unmapped_heap_free(struct ion_buffer *buffer)
+{
+	struct ion_heap *heap = buffer->heap;
+	struct sg_table *table = buffer->sg_table;
+	struct page *page = sg_page(table->sgl);
+	phys_addr_t paddr = PFN_PHYS(page_to_pfn(page));
+
+	ion_unmapped_free(heap, paddr, buffer->size);
+	sg_free_table(buffer->sg_table);
+	kfree(buffer->sg_table);
+}
+
+static struct ion_heap_ops unmapped_heap_ops = {
+	.allocate = ion_unmapped_heap_allocate,
+	.free = ion_unmapped_heap_free,
+	/* no .map_user, user mapping of unmapped heaps not allowed */
+	.map_kernel = ion_heap_map_kernel,
+	.unmap_kernel = ion_heap_unmap_kernel,
+};
+
+struct ion_heap *ion_unmapped_heap_create(phys_addr_t base, size_t size)
+{
+	struct ion_unmapped_heap *unmapped_heap;
+
+	unmapped_heap = kzalloc(sizeof(*unmapped_heap), GFP_KERNEL);
+	if (!unmapped_heap)
+		return ERR_PTR(-ENOMEM);
+
+	unmapped_heap->pool = gen_pool_create(PAGE_SHIFT, -1);
+	if (!unmapped_heap->pool) {
+		kfree(unmapped_heap);
+		return ERR_PTR(-ENOMEM);
+	}
+	gen_pool_add(unmapped_heap->pool, base, size, -1);
+	unmapped_heap->heap.ops = &unmapped_heap_ops;
+	unmapped_heap->heap.type = ION_HEAP_TYPE_UNMAPPED;
+
+	return &unmapped_heap->heap;
+}
diff --git a/drivers/staging/android/uapi/ion.h b/drivers/staging/android/uapi/ion.h
index 5d7009884c13..d5f98bc5f340 100644
--- a/drivers/staging/android/uapi/ion.h
+++ b/drivers/staging/android/uapi/ion.h
@@ -19,6 +19,8 @@
  *				 carveout heap, allocations are physically
  *				 contiguous
  * @ION_HEAP_TYPE_DMA:		 memory allocated via DMA API
+ * @ION_HEAP_TYPE_UNMAPPED:	 memory not intended to be mapped into the
+ *				 linux address space unless for debug cases
  * @ION_NUM_HEAPS:		 helper for iterating over heaps, a bit mask
  *				 is used to identify the heaps, so only 32
  *				 total heap types are supported
@@ -29,6 +31,7 @@ enum ion_heap_type {
 	ION_HEAP_TYPE_CARVEOUT,
 	ION_HEAP_TYPE_CHUNK,
 	ION_HEAP_TYPE_DMA,
+	ION_HEAP_TYPE_UNMAPPED,
 	ION_HEAP_TYPE_CUSTOM, /*
 			       * must be last so device specific heaps always
 			       * are at the end of this enum
-- 
2.19.1

