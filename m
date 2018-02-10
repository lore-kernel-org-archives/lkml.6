Return-Path: <alexey.skidanov@intel.com>
X-Google-Smtp-Source: AH8x224LlVzurMlXbXc+qwnX/ZC9IJ3/Pm9Be8q8wKlfrdXLmFU4vqyNtHmVug0N4jYir7gFcEzK
ARC-Seal: i=1; a=rsa-sha256; t=1518258045; cv=none;
        d=google.com; s=arc-20160816;
        b=Uanv6NTK5Vlxz4kdHfZZeBMQSfSZrk8PeKZgTkcBs0XeZdNPUSIVkJVGGCwYwclCsY
         f/Azx+asmhqZausIzMbawWFsijBuxlW9G/cM4Np7X+NTJ6njTsnzKy9PfLvBKXWAVxL8
         I5bLIhI8jY8q/KBxH3TOTD0uZzkJTfazoXitdIjTLh4MuuGmULRmw3WQ71T4UT0FL8K5
         iC9SrqwWg9diZG69Kn6XEcAIgIlwm/oV1Novbrc9UTf42z+r4+dwUmB2qt862Fjw1WHK
         k499iMgdHhUedy04WGbiO0cYqpu69jqF52CN4ZZDCY6IMYMK5rRnkYXVlTokJjv0CvDl
         qYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=sTgaX77jICNSkyNtsMqADfVgms2D1YUo1s7z/ad/+o8=;
        b=Ogl4H/4qrnJhD2Jdk6ScuHi0tILVegV6UCPFc/FpwZrym0XDB4yZFbnpHefOvfx5im
         1vBUz1pHHY9AVzYpvXkXofXFPEjMXleFQ2OvaSXgGuHskrvo15DbOsbxW8TKdTyHE6SH
         dDk1i8oB6HIZL36D4VFxwNyxOPpXXZEEI7vpsm+SlG71N4D4qr327JTKz4MG4MDIBqJ2
         gN3nxZ/0kR2yagGXyI/pQnEl8P0ItDKVhxrNAob4tySBDCEO3KuQh/Qk1N/Iie+ElmpH
         2+xoZrQj0uEj8Rt/nvz7kI+d2jxZlIJx9mFeNFBc5jO5Li6IZmaLdFDDLr5ryuOW3Dqn
         NhHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alexey.skidanov@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=alexey.skidanov@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alexey.skidanov@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=alexey.skidanov@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,488,1511856000";
   d="scan'208";a="33632201"
From: Alexey Skidanov <alexey.skidanov@intel.com>
To: labbott@redhat.com,
	sumit.semwal@linaro.org,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	Alexey Skidanov <alexey.skidanov@intel.com>
Subject: [PATCH] staging: android: ion: Add requested allocation alignment
Date: Sat, 10 Feb 2018 12:17:43 +0200
Message-Id: <1518257863-6903-1-git-send-email-alexey.skidanov@intel.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592008948531833227?=
X-GMAIL-MSGID: =?utf-8?q?1592008948531833227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Current ion defined allocation ioctl doesn't allow to specify the requested
allocation alignment. CMA heap allocates buffers aligned on buffer size
page order.

Sometimes, the alignment requirement is less restrictive. In such cases,
providing specific alignment may reduce the external memory fragmentation
and in some cases it may avoid the allocation request failure.

To fix this, we add an alignment parameter to the allocation ioctl.

Signed-off-by: Alexey Skidanov <alexey.skidanov@intel.com>
---
 drivers/staging/android/ion/ion-ioctl.c         |  3 ++-
 drivers/staging/android/ion/ion.c               | 14 +++++++++-----
 drivers/staging/android/ion/ion.h               |  9 ++++++---
 drivers/staging/android/ion/ion_carveout_heap.c |  3 ++-
 drivers/staging/android/ion/ion_chunk_heap.c    |  3 ++-
 drivers/staging/android/ion/ion_cma_heap.c      | 18 ++++++++++++------
 drivers/staging/android/ion/ion_system_heap.c   |  6 ++++--
 drivers/staging/android/uapi/ion.h              |  7 +++----
 8 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/android/ion/ion-ioctl.c b/drivers/staging/android/ion/ion-ioctl.c
index c789893..9fe022b 100644
--- a/drivers/staging/android/ion/ion-ioctl.c
+++ b/drivers/staging/android/ion/ion-ioctl.c
@@ -83,7 +83,8 @@ long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		fd = ion_alloc(data.allocation.len,
 			       data.allocation.heap_id_mask,
-			       data.allocation.flags);
+			       data.allocation.flags,
+			       data.allocation.align);
 		if (fd < 0)
 			return fd;
 
diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index f480885..35ddc7a 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -78,7 +78,8 @@ static void ion_buffer_add(struct ion_device *dev,
 static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
 					    struct ion_device *dev,
 					    unsigned long len,
-					    unsigned long flags)
+					    unsigned long flags,
+					    unsigned int align)
 {
 	struct ion_buffer *buffer;
 	int ret;
@@ -90,14 +91,14 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
 	buffer->heap = heap;
 	buffer->flags = flags;
 
-	ret = heap->ops->allocate(heap, buffer, len, flags);
+	ret = heap->ops->allocate(heap, buffer, len, flags, align);
 
 	if (ret) {
 		if (!(heap->flags & ION_HEAP_FLAG_DEFER_FREE))
 			goto err2;
 
 		ion_heap_freelist_drain(heap, 0);
-		ret = heap->ops->allocate(heap, buffer, len, flags);
+		ret = heap->ops->allocate(heap, buffer, len, flags, align);
 		if (ret)
 			goto err2;
 	}
@@ -390,7 +391,10 @@ static const struct dma_buf_ops dma_buf_ops = {
 	.unmap = ion_dma_buf_kunmap,
 };
 
-int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
+int ion_alloc(size_t len,
+	      unsigned int heap_id_mask,
+	      unsigned int flags,
+	      unsigned int align)
 {
 	struct ion_device *dev = internal_dev;
 	struct ion_buffer *buffer = NULL;
@@ -417,7 +421,7 @@ int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
 		/* if the caller didn't specify this heap id */
 		if (!((1 << heap->id) & heap_id_mask))
 			continue;
-		buffer = ion_buffer_create(heap, dev, len, flags);
+		buffer = ion_buffer_create(heap, dev, len, flags, align);
 		if (!IS_ERR(buffer))
 			break;
 	}
diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index f5f9cd6..0c161d2 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -123,8 +123,10 @@ struct ion_device {
  */
 struct ion_heap_ops {
 	int (*allocate)(struct ion_heap *heap,
-			struct ion_buffer *buffer, unsigned long len,
-			unsigned long flags);
+			struct ion_buffer *buffer,
+			unsigned long len,
+			unsigned long flags,
+			unsigned int align);
 	void (*free)(struct ion_buffer *buffer);
 	void * (*map_kernel)(struct ion_heap *heap, struct ion_buffer *buffer);
 	void (*unmap_kernel)(struct ion_heap *heap, struct ion_buffer *buffer);
@@ -228,7 +230,8 @@ int ion_heap_pages_zero(struct page *page, size_t size, pgprot_t pgprot);
 
 int ion_alloc(size_t len,
 	      unsigned int heap_id_mask,
-	      unsigned int flags);
+	      unsigned int flags,
+	      unsigned int align);
 
 /**
  * ion_heap_init_shrinker
diff --git a/drivers/staging/android/ion/ion_carveout_heap.c b/drivers/staging/android/ion/ion_carveout_heap.c
index fee7650..deae9dd 100644
--- a/drivers/staging/android/ion/ion_carveout_heap.c
+++ b/drivers/staging/android/ion/ion_carveout_heap.c
@@ -59,7 +59,8 @@ static void ion_carveout_free(struct ion_heap *heap, phys_addr_t addr,
 static int ion_carveout_heap_allocate(struct ion_heap *heap,
 				      struct ion_buffer *buffer,
 				      unsigned long size,
-				      unsigned long flags)
+				      unsigned long flags,
+				      unsigned int align)
 {
 	struct sg_table *table;
 	phys_addr_t paddr;
diff --git a/drivers/staging/android/ion/ion_chunk_heap.c b/drivers/staging/android/ion/ion_chunk_heap.c
index 102c093..15f9518 100644
--- a/drivers/staging/android/ion/ion_chunk_heap.c
+++ b/drivers/staging/android/ion/ion_chunk_heap.c
@@ -35,7 +35,8 @@ struct ion_chunk_heap {
 static int ion_chunk_heap_allocate(struct ion_heap *heap,
 				   struct ion_buffer *buffer,
 				   unsigned long size,
-				   unsigned long flags)
+				   unsigned long flags,
+				   unsigned int align)
 {
 	struct ion_chunk_heap *chunk_heap =
 		container_of(heap, struct ion_chunk_heap, heap);
diff --git a/drivers/staging/android/ion/ion_cma_heap.c b/drivers/staging/android/ion/ion_cma_heap.c
index 86196ff..f3f8deb 100644
--- a/drivers/staging/android/ion/ion_cma_heap.c
+++ b/drivers/staging/android/ion/ion_cma_heap.c
@@ -32,25 +32,31 @@ struct ion_cma_heap {
 #define to_cma_heap(x) container_of(x, struct ion_cma_heap, heap)
 
 /* ION CMA heap operations functions */
-static int ion_cma_allocate(struct ion_heap *heap, struct ion_buffer *buffer,
+static int ion_cma_allocate(struct ion_heap *heap,
+			    struct ion_buffer *buffer,
 			    unsigned long len,
-			    unsigned long flags)
+			    unsigned long flags,
+			    unsigned int align)
 {
 	struct ion_cma_heap *cma_heap = to_cma_heap(heap);
 	struct sg_table *table;
 	struct page *pages;
 	unsigned long size = PAGE_ALIGN(len);
 	unsigned long nr_pages = size >> PAGE_SHIFT;
-	unsigned long align = get_order(size);
+	int order = get_order(align);
 	int ret;
 
-	if (align > CONFIG_CMA_ALIGNMENT)
-		align = CONFIG_CMA_ALIGNMENT;
+	/* CMA allocation alignment is in PAGE_SIZE order */
+	if (order > CONFIG_CMA_ALIGNMENT)
+		order = CONFIG_CMA_ALIGNMENT;
 
-	pages = cma_alloc(cma_heap->cma, nr_pages, align, GFP_KERNEL);
+	pages = cma_alloc(cma_heap->cma, nr_pages, order, GFP_KERNEL);
 	if (!pages)
 		return -ENOMEM;
 
+	pr_debug("Allocated block of %lu pages starting at 0x%lX",
+		 nr_pages, page_to_pfn(pages));
+
 	table = kmalloc(sizeof(*table), GFP_KERNEL);
 	if (!table)
 		goto err;
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index 4dc5d7a..b5a1720 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -125,7 +125,8 @@ static struct page *alloc_largest_available(struct ion_system_heap *heap,
 static int ion_system_heap_allocate(struct ion_heap *heap,
 				    struct ion_buffer *buffer,
 				    unsigned long size,
-				    unsigned long flags)
+				    unsigned long flags,
+				    unsigned int align)
 {
 	struct ion_system_heap *sys_heap = container_of(heap,
 							struct ion_system_heap,
@@ -363,7 +364,8 @@ device_initcall(ion_system_heap_create);
 static int ion_system_contig_heap_allocate(struct ion_heap *heap,
 					   struct ion_buffer *buffer,
 					   unsigned long len,
-					   unsigned long flags)
+					   unsigned long flags,
+					   unsigned int align)
 {
 	int order = get_order(len);
 	struct page *page;
diff --git a/drivers/staging/android/uapi/ion.h b/drivers/staging/android/uapi/ion.h
index 9e21451..b093edd 100644
--- a/drivers/staging/android/uapi/ion.h
+++ b/drivers/staging/android/uapi/ion.h
@@ -70,9 +70,8 @@ enum ion_heap_type {
  * @len:		size of the allocation
  * @heap_id_mask:	mask of heap ids to allocate from
  * @flags:		flags passed to heap
- * @handle:		pointer that will be populated with a cookie to use to
- *			refer to this allocation
- *
+ * @fd:		file descriptor associated with newly allocated buffer
+ * @align:	allocation alignment
  * Provided by userspace as an argument to the ioctl
  */
 struct ion_allocation_data {
@@ -80,7 +79,7 @@ struct ion_allocation_data {
 	__u32 heap_id_mask;
 	__u32 flags;
 	__u32 fd;
-	__u32 unused;
+	__u32 align;
 };
 
 #define MAX_HEAP_NAME			32
-- 
2.7.4
