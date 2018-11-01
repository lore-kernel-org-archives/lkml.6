Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EAAC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB232082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cSayO5Qn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G1yPaMWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB232082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeKBHUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:20:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51608 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeKBHUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:20:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AFBBD6037C; Thu,  1 Nov 2018 22:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541110508;
        bh=60uS7RfaJ8nCVg3IOqxYIbNEs4Sbt/QjpM6CwiKJi0s=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=cSayO5Qnm4gYwkSvRw4SnTwHZQ3XVO8CArzXKEr63hDsjfRK5IsIvAu1EwnWdRpzl
         JAQblwUcByjWWrnrfnWLMiOy4ZyZJab0YqidrHMMJQrM5mJ4O3P7oDwu8uPrzjz0t9
         vJGdW2YYAzarQbx8yiMSYtXLgqQzA8u8S+Z+aaO8=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9AE176037C;
        Thu,  1 Nov 2018 22:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541110507;
        bh=60uS7RfaJ8nCVg3IOqxYIbNEs4Sbt/QjpM6CwiKJi0s=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=G1yPaMWe3Kwimm1qibc2gOZ/N7C03dFpiH5PBu7kHw7XT/WaDNXShZvBSMIFKsj48
         f3tLeVoIvaSP3/Jf/l9nnOAN1QoEaga4C+yBDjhqFmDfGplOzFd5ghzRN3ATaOKqYE
         4HkXz/mnCz9nccq2slGazF1OMeDIvxoAcw20oRxs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9AE176037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Thu, 1 Nov 2018 15:15:06 -0700 (PDT)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     Laura Abbott <labbott@redhat.com>
cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Martijn Coenen <maco@android.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@android.com>,
        Arve Hjonnevag <arve@android.com>,
        linaro-mm-sig@lists.linaro.org
Subject:  [RFC PATCH v2] android: ion: How to properly clean caches for
 uncached allocations
In-Reply-To: <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com>
Message-ID: <alpine.DEB.2.10.1811011454430.23412@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com> <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com> <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the suggestions from Laura I created a first draft for a change 
which will attempt to ensure that uncached mappings are only applied to 
ION memory who's cache lines have been cleaned.
It does this by providing cached mappings (for uncached ION allocations) 
until the ION buffer is dma mapped and successfully cleaned, then it drops 
the userspace mappings and when pages are accessed they are faulted back 
in and uncached mappings are created.

This change has the following potential disadvantages:
- It assumes that userpace clients won't attempt to access the buffer 
while it is being mapped as we are removing the userpspace mappings at 
this point (though it is okay for them to have it mapped)
- It assumes that kernel clients won't hold a kernel mapping to the buffer 
(ie dma_buf_kmap) while it is being dma-mapped. What should we do if there 
is a kernel mapping at the time of dma mapping, fail the mapping, warn?
- There may be a performance penalty as a result of having to fault in the 
pages after removing the userspace mappings.

It passes basic testing involving reading writing and reading from 
uncached system heap allocations before and after dma mapping.

Please let me know if this is heading in the right direction and if there 
are any concerns.

Signed-off-by: Liam Mark <lmark@codeaurora.org>
---
 drivers/staging/android/ion/ion.c | 146 +++++++++++++++++++++++++++++++++++++-
 drivers/staging/android/ion/ion.h |   9 +++
 2 files changed, 152 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 99073325b0c0..3dc0f5a265bf 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -96,6 +96,7 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
 	}
 
 	INIT_LIST_HEAD(&buffer->attachments);
+	INIT_LIST_HEAD(&buffer->vmas);
 	mutex_init(&buffer->lock);
 	mutex_lock(&dev->buffer_lock);
 	ion_buffer_add(dev, buffer);
@@ -117,6 +118,7 @@ void ion_buffer_destroy(struct ion_buffer *buffer)
 		buffer->heap->ops->unmap_kernel(buffer->heap, buffer);
 	}
 	buffer->heap->ops->free(buffer);
+	vfree(buffer->pages);
 	kfree(buffer);
 }
 
@@ -245,11 +247,29 @@ static void ion_dma_buf_detatch(struct dma_buf *dmabuf,
 	kfree(a);
 }
 
+static bool ion_buffer_uncached_clean(struct ion_buffer *buffer)
+{
+	return buffer->uncached_clean;
+}
+
+/* expect buffer->lock to be already taken */
+static void ion_buffer_zap_mappings(struct ion_buffer *buffer)
+{
+	struct ion_vma_list *vma_list;
+
+	list_for_each_entry(vma_list, &buffer->vmas, list) {
+		struct vm_area_struct *vma = vma_list->vma;
+
+		zap_page_range(vma, vma->vm_start, vma->vm_end - vma->vm_start);
+	}
+}
+
 static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
 					enum dma_data_direction direction)
 {
 	struct ion_dma_buf_attachment *a = attachment->priv;
 	struct sg_table *table;
+	struct ion_buffer *buffer = attachment->dmabuf->priv;
 
 	table = a->table;
 
@@ -257,6 +277,19 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
 			direction))
 		return ERR_PTR(-ENOMEM);
 
+	if (!ion_buffer_cached(buffer)) {
+		mutex_lock(&buffer->lock);
+		if (!ion_buffer_uncached_clean(buffer)) {
+			ion_buffer_zap_mappings(buffer);
+			if (buffer->kmap_cnt > 0) {
+				pr_warn_once("%s: buffer still mapped in the kernel\n",
+					     __func__);
+			}
+			buffer->uncached_clean = true;
+		}
+		mutex_unlock(&buffer->lock);
+	}
+
 	return table;
 }
 
@@ -267,6 +300,94 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
 	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
 }
 
+static void __ion_vm_open(struct vm_area_struct *vma, bool lock)
+{
+	struct ion_buffer *buffer = vma->vm_private_data;
+	struct ion_vma_list *vma_list;
+
+	vma_list = kmalloc(sizeof(*vma_list), GFP_KERNEL);
+	if (!vma_list)
+		return;
+	vma_list->vma = vma;
+
+	if (lock)
+		mutex_lock(&buffer->lock);
+	list_add(&vma_list->list, &buffer->vmas);
+	if (lock)
+		mutex_unlock(&buffer->lock);
+}
+
+static void ion_vm_open(struct vm_area_struct *vma)
+{
+	__ion_vm_open(vma, true);
+}
+
+static void ion_vm_close(struct vm_area_struct *vma)
+{
+	struct ion_buffer *buffer = vma->vm_private_data;
+	struct ion_vma_list *vma_list, *tmp;
+
+	mutex_lock(&buffer->lock);
+	list_for_each_entry_safe(vma_list, tmp, &buffer->vmas, list) {
+		if (vma_list->vma != vma)
+			continue;
+		list_del(&vma_list->list);
+		kfree(vma_list);
+		break;
+	}
+	mutex_unlock(&buffer->lock);
+}
+
+static int ion_vm_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct ion_buffer *buffer = vma->vm_private_data;
+	unsigned long pfn;
+	int ret;
+
+	mutex_lock(&buffer->lock);
+	if (!buffer->pages || !buffer->pages[vmf->pgoff]) {
+		mutex_unlock(&buffer->lock);
+		return VM_FAULT_ERROR;
+	}
+
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	pfn = page_to_pfn(buffer->pages[vmf->pgoff]);
+	ret = vm_insert_pfn(vma, vmf->address, pfn);
+	mutex_unlock(&buffer->lock);
+	if (ret)
+		return VM_FAULT_ERROR;
+
+	return VM_FAULT_NOPAGE;
+}
+
+static const struct vm_operations_struct ion_vma_ops = {
+	.open = ion_vm_open,
+	.close = ion_vm_close,
+	.fault = ion_vm_fault,
+};
+
+static int ion_init_fault_pages(struct ion_buffer *buffer)
+{
+	int num_pages = PAGE_ALIGN(buffer->size) / PAGE_SIZE;
+	struct scatterlist *sg;
+	int i, j, k = 0;
+	struct sg_table *table = buffer->sg_table;
+
+	buffer->pages = vmalloc(sizeof(struct page *) * num_pages);
+	if (!buffer->pages)
+		return -ENOMEM;
+
+	for_each_sg(table->sgl, sg, table->nents, i) {
+		struct page *page = sg_page(sg);
+
+		for (j = 0; j < sg->length / PAGE_SIZE; j++)
+			buffer->pages[k++] = page++;
+	}
+
+	return 0;
+}
+
 static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 {
 	struct ion_buffer *buffer = dmabuf->priv;
@@ -278,12 +399,31 @@ static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
-	if (!(buffer->flags & ION_FLAG_CACHED))
-		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-
 	mutex_lock(&buffer->lock);
+
+	if (!ion_buffer_cached(buffer)) {
+		if (!ion_buffer_uncached_clean(buffer)) {
+			if (!buffer->pages)
+				ret = ion_init_fault_pages(buffer);
+
+			if (ret)
+				goto end;
+
+			vma->vm_private_data = buffer;
+			vma->vm_ops = &ion_vma_ops;
+			vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND |
+					 VM_DONTDUMP;
+			__ion_vm_open(vma, false);
+		} else {
+			vma->vm_page_prot =
+				pgprot_writecombine(vma->vm_page_prot);
+		}
+	}
+
 	/* now map it to userspace */
 	ret = buffer->heap->ops->map_user(buffer->heap, buffer, vma);
+
+end:
 	mutex_unlock(&buffer->lock);
 
 	if (ret)
diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index c006fc1e5a16..438c9f4fa125 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -44,6 +44,11 @@ struct ion_platform_heap {
 	void *priv;
 };
 
+struct ion_vma_list {
+	struct list_head list;
+	struct vm_area_struct *vma;
+};
+
 /**
  * struct ion_buffer - metadata for a particular buffer
  * @ref:		reference count
@@ -59,6 +64,7 @@ struct ion_platform_heap {
  * @kmap_cnt:		number of times the buffer is mapped to the kernel
  * @vaddr:		the kernel mapping if kmap_cnt is not zero
  * @sg_table:		the sg table for the buffer if dmap_cnt is not zero
+ * @vmas:		list of vma's mapping for uncached buffer
  */
 struct ion_buffer {
 	union {
@@ -76,6 +82,9 @@ struct ion_buffer {
 	void *vaddr;
 	struct sg_table *sg_table;
 	struct list_head attachments;
+	struct list_head vmas;
+	struct page **pages;
+	bool uncached_clean;
 };
 
 void ion_buffer_destroy(struct ion_buffer *buffer);
-- 
1.9.1


Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
