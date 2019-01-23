Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBD6C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C989E21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P65mmvrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfAWT2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:28:49 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51210 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAWT2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:28:49 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0NJSaiZ030615;
        Wed, 23 Jan 2019 13:28:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548271716;
        bh=KXj/YPAdWuIfHNZ2rrKfJnUEqINprOzIH1IaAyPl5iE=;
        h=From:To:CC:Subject:Date;
        b=P65mmvrcggZOa6e3DwxULu7sP3gbtOJWWboMsBkR8OwyjtMlz4fOJmQIJhMkIYKxB
         Qn6j2Kfq8RKxCuuHcAJXisPOQLrixdu98DjyNP4O4I69iRB1G9tPnDp63btgpxIXvh
         plUB5HQNb7bMEVAfHiYoOstubDkD/EPVZJXx9nvk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0NJSaHO110879
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 13:28:36 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 23
 Jan 2019 13:28:36 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 23 Jan 2019 13:28:36 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0NJSaKh014018;
        Wed, 23 Jan 2019 13:28:36 -0600
Received: from localhost (uda0226330.dhcp.ti.com [172.22.97.60])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x0NJSZU21595;
        Wed, 23 Jan 2019 13:28:35 -0600 (CST)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christoph Hellwig <hch@infradead.org>,
        Liam Mark <lmark@codeaurora.org>
CC:     <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH] staging: android: ion: Allocate from heap ID directly without mask
Date:   Wed, 23 Jan 2019 13:28:35 -0600
Message-ID: <20190123192835.21827-1-afd@ti.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the heap to allocate from was selected by a mask of allowed
heap types. This may have been done as a primitive form of constraint
solving, the first heap type that matched any set bit of the heap mask
was allocated from, unless that heap was excluded by having its heap
ID bit not set in the separate passed in heap ID mask.

The heap type does not really represent constraints that should be
matched against to begin with. So the patch [0] removed the the heap type
mask matching but unfortunately left the heap ID mask check (possibly by
mistake or to preserve API). Therefor we now only have a mask of heap
IDs, but heap IDs are unique identifiers and have nothing to do with the
underling heap, so mask matching is not useful here. This also limits us
to 32 heaps total in a system.

With the heap query API users can find the right heap based on type or
name themselves then just supply the ID for that heap. Remove heap ID
mask and allow users to specify heap ID directly by its number.

I know this is an ABI break, but we are in staging so lets get this over
with now rather than limit ourselves later.

[0] 2bb9f5034ec7 ("gpu: ion: Remove heapmask from client")

Signed-off-by: Andrew F. Davis <afd@ti.com>
---

This also means we don't need to store the available heaps in a plist,
we only operation we care about is lookup, so a better data structure
should be chosen at some point, regular list or xarray maybe?

This is base on -next as to be on top of the other taken Ion patches.

 drivers/staging/android/ion/ion.c  | 21 ++++++++++-----------
 drivers/staging/android/uapi/ion.h |  6 ++----
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 92c2914239e3..06dd5bb10ecb 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -387,7 +387,7 @@ static const struct dma_buf_ops dma_buf_ops = {
 	.unmap = ion_dma_buf_kunmap,
 };
 
-static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
+static int ion_alloc(size_t len, unsigned int heap_id, unsigned int flags)
 {
 	struct ion_device *dev = internal_dev;
 	struct ion_buffer *buffer = NULL;
@@ -396,23 +396,22 @@ static int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
 	int fd;
 	struct dma_buf *dmabuf;
 
-	pr_debug("%s: len %zu heap_id_mask %u flags %x\n", __func__,
-		 len, heap_id_mask, flags);
-	/*
-	 * traverse the list of heaps available in this system in priority
-	 * order.  If the heap type is supported by the client, and matches the
-	 * request of the caller allocate from it.  Repeat until allocate has
-	 * succeeded or all heaps have been tried
-	 */
+	pr_debug("%s: len %zu heap_id %u flags %x\n", __func__,
+		 len, heap_id, flags);
+
 	len = PAGE_ALIGN(len);
 
 	if (!len)
 		return -EINVAL;
 
+	/*
+	 * Traverse the list of heaps available in this system.  If the
+	 * heap id matches the request of the caller allocate from it.
+	 */
 	down_read(&dev->lock);
 	plist_for_each_entry(heap, &dev->heaps, node) {
 		/* if the caller didn't specify this heap id */
-		if (!((1 << heap->id) & heap_id_mask))
+		if (heap->id != heap_id)
 			continue;
 		buffer = ion_buffer_create(heap, dev, len, flags);
 		if (!IS_ERR(buffer))
@@ -541,7 +540,7 @@ static long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		int fd;
 
 		fd = ion_alloc(data.allocation.len,
-			       data.allocation.heap_id_mask,
+			       data.allocation.heap_id,
 			       data.allocation.flags);
 		if (fd < 0)
 			return fd;
diff --git a/drivers/staging/android/uapi/ion.h b/drivers/staging/android/uapi/ion.h
index 5d7009884c13..6a78a1e23251 100644
--- a/drivers/staging/android/uapi/ion.h
+++ b/drivers/staging/android/uapi/ion.h
@@ -35,8 +35,6 @@ enum ion_heap_type {
 			       */
 };
 
-#define ION_NUM_HEAP_IDS		(sizeof(unsigned int) * 8)
-
 /**
  * allocation flags - the lower 16 bits are used by core ion, the upper 16
  * bits are reserved for use by the heaps themselves.
@@ -59,7 +57,7 @@ enum ion_heap_type {
 /**
  * struct ion_allocation_data - metadata passed from userspace for allocations
  * @len:		size of the allocation
- * @heap_id_mask:	mask of heap ids to allocate from
+ * @heap_id:		heap id to allocate from
  * @flags:		flags passed to heap
  * @handle:		pointer that will be populated with a cookie to use to
  *			refer to this allocation
@@ -68,7 +66,7 @@ enum ion_heap_type {
  */
 struct ion_allocation_data {
 	__u64 len;
-	__u32 heap_id_mask;
+	__u32 heap_id;
 	__u32 flags;
 	__u32 fd;
 	__u32 unused;
-- 
2.19.1

