Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1112DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD32A21721
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbeLXITy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:19:54 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60293 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726788AbeLXITy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:19:54 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 58632A8E6B83B;
        Mon, 24 Dec 2018 16:19:50 +0800 (CST)
Received: from huawei.com (10.141.125.218) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Mon, 24 Dec 2018
 16:19:45 +0800
From:   Qing Xia <saberlily.xia@hisilicon.com>
To:     <labbott@redhat.com>, <sumit.semwal@linaro.org>,
        <gregkh@linuxfoundation.org>, <arve@android.com>,
        <tkjos@android.com>, <maco@android.com>
CC:     <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <devel@driverdev.osuosl.org>,
        <daniel.liuyi@hisilicon.com>, <yudongbin@hisilicon.com>,
        <kongfei@hisilicon.com>
Subject: [PATCH] staging: android: ion: move map_kernel to ion_dma_buf_kmap
Date:   Mon, 24 Dec 2018 16:19:45 +0800
Message-ID: <1545639585-24785-1-git-send-email-saberlily.xia@hisilicon.com>
X-Mailer: git-send-email 2.7.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.141.125.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, as Google's user guide, if userspace need clean ION buffer's
cache, they should call ioctl(fd, DMA_BUF_IOCTL_SYNC, sync). Then
we found that ion_dma_buf_begin_cpu_access/ion_dma_buf_end_cpu_access
will do ION buffer's map_kernel, it's not necessary. And if usersapce
only need clean cache, they will call ion_dma_buf_end_cpu_access by
dmabuf's ioctl, ION buffer's kmap_cnt will be wrong value -1, then
driver could not get right kernel vaddr by dma_buf_kmap.

Signed-off-by: Qing Xia <saberlily.xia@hisilicon.com>
---
 drivers/staging/android/ion/ion.c | 46 ++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 9907332..f7e2812 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -303,45 +303,47 @@ static void ion_dma_buf_release(struct dma_buf *dmabuf)
 static void *ion_dma_buf_kmap(struct dma_buf *dmabuf, unsigned long offset)
 {
 	struct ion_buffer *buffer = dmabuf->priv;
+	void *vaddr;
 
-	return buffer->vaddr + offset * PAGE_SIZE;
+	if (buffer->heap->ops->map_kernel) {
+		mutex_lock(&buffer->lock);
+		vaddr = ion_buffer_kmap_get(buffer);
+		mutex_unlock(&buffer->lock);
+		if (IS_ERR(vaddr))
+			return vaddr;
+
+		return vaddr + offset * PAGE_SIZE;
+	}
+
+	return NULL;
 }
 
 static void ion_dma_buf_kunmap(struct dma_buf *dmabuf, unsigned long offset,
 			       void *ptr)
 {
+	struct ion_buffer *buffer = dmabuf->priv;
+
+	if (buffer->heap->ops->map_kernel) {
+		mutex_lock(&buffer->lock);
+		ion_buffer_kmap_put(buffer);
+		mutex_unlock(&buffer->lock);
+	}
 }
 
 static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 					enum dma_data_direction direction)
 {
 	struct ion_buffer *buffer = dmabuf->priv;
-	void *vaddr;
 	struct ion_dma_buf_attachment *a;
-	int ret = 0;
-
-	/*
-	 * TODO: Move this elsewhere because we don't always need a vaddr
-	 */
-	if (buffer->heap->ops->map_kernel) {
-		mutex_lock(&buffer->lock);
-		vaddr = ion_buffer_kmap_get(buffer);
-		if (IS_ERR(vaddr)) {
-			ret = PTR_ERR(vaddr);
-			goto unlock;
-		}
-		mutex_unlock(&buffer->lock);
-	}
 
 	mutex_lock(&buffer->lock);
 	list_for_each_entry(a, &buffer->attachments, list) {
 		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->nents,
 				    direction);
 	}
-
-unlock:
 	mutex_unlock(&buffer->lock);
-	return ret;
+
+	return 0;
 }
 
 static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
@@ -350,12 +352,6 @@ static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
 	struct ion_buffer *buffer = dmabuf->priv;
 	struct ion_dma_buf_attachment *a;
 
-	if (buffer->heap->ops->map_kernel) {
-		mutex_lock(&buffer->lock);
-		ion_buffer_kmap_put(buffer);
-		mutex_unlock(&buffer->lock);
-	}
-
 	mutex_lock(&buffer->lock);
 	list_for_each_entry(a, &buffer->attachments, list) {
 		dma_sync_sg_for_device(a->dev, a->table->sgl, a->table->nents,
-- 
2.7.3

