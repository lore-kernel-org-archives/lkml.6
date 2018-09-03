Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3CEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753C420843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753C420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbeICV1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:27:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39756 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbeICV1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:27:55 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 84D62D02;
        Mon,  3 Sep 2018 17:06:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 4.9 063/107] staging: android: ion: fix ION_IOC_{MAP,SHARE} use-after-free
Date:   Mon,  3 Sep 2018 18:56:27 +0200
Message-Id: <20180903165640.363207389@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165637.293735109@linuxfoundation.org>
References: <20180903165637.293735109@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Hackmann <ghackmann@android.com>

This patch is 4.9.y only.  Kernels 4.12 and later are unaffected, since
all the underlying ion_handle infrastructure has been ripped out.

The ION_IOC_{MAP,SHARE} ioctls drop and reacquire client->lock several
times while operating on one of the client's ion_handles.  This creates
windows where userspace can call ION_IOC_FREE on the same client with
the same handle, and effectively make the kernel drop its own reference.
For example:

- thread A: ION_IOC_ALLOC creates an ion_handle with refcount 1
- thread A: starts ION_IOC_MAP and increments the refcount to 2
- thread B: ION_IOC_FREE decrements the refcount to 1
- thread B: ION_IOC_FREE decrements the refcount to 0 and frees the
            handle
- thread A: continues ION_IOC_MAP with a dangling ion_handle * to
            freed memory

Fix this by holding client->lock for the duration of
ION_IOC_{MAP,SHARE}, preventing the concurrent ION_IOC_FREE.  Also
remove ion_handle_get_by_id(), since there's literally no way to use it
safely.

Cc: stable@vger.kernel.org # v4.11-
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/android/ion/ion-ioctl.c |   12 +++++---
 drivers/staging/android/ion/ion.c       |   48 +++++++++++++++++++-------------
 drivers/staging/android/ion/ion_priv.h  |    6 ++--
 3 files changed, 40 insertions(+), 26 deletions(-)

--- a/drivers/staging/android/ion/ion-ioctl.c
+++ b/drivers/staging/android/ion/ion-ioctl.c
@@ -128,11 +128,15 @@ long ion_ioctl(struct file *filp, unsign
 	{
 		struct ion_handle *handle;
 
-		handle = ion_handle_get_by_id(client, data.handle.handle);
-		if (IS_ERR(handle))
+		mutex_lock(&client->lock);
+		handle = ion_handle_get_by_id_nolock(client, data.handle.handle);
+		if (IS_ERR(handle)) {
+			mutex_unlock(&client->lock);
 			return PTR_ERR(handle);
-		data.fd.fd = ion_share_dma_buf_fd(client, handle);
-		ion_handle_put(handle);
+		}
+		data.fd.fd = ion_share_dma_buf_fd_nolock(client, handle);
+		ion_handle_put_nolock(handle);
+		mutex_unlock(&client->lock);
 		if (data.fd.fd < 0)
 			ret = data.fd.fd;
 		break;
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -352,18 +352,6 @@ struct ion_handle *ion_handle_get_by_id_
 	return handle ? handle : ERR_PTR(-EINVAL);
 }
 
-struct ion_handle *ion_handle_get_by_id(struct ion_client *client,
-					       int id)
-{
-	struct ion_handle *handle;
-
-	mutex_lock(&client->lock);
-	handle = ion_handle_get_by_id_nolock(client, id);
-	mutex_unlock(&client->lock);
-
-	return handle;
-}
-
 static bool ion_handle_validate(struct ion_client *client,
 				struct ion_handle *handle)
 {
@@ -1029,24 +1017,28 @@ static struct dma_buf_ops dma_buf_ops =
 	.kunmap = ion_dma_buf_kunmap,
 };
 
-struct dma_buf *ion_share_dma_buf(struct ion_client *client,
-				  struct ion_handle *handle)
+static struct dma_buf *__ion_share_dma_buf(struct ion_client *client,
+					   struct ion_handle *handle,
+					   bool lock_client)
 {
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct ion_buffer *buffer;
 	struct dma_buf *dmabuf;
 	bool valid_handle;
 
-	mutex_lock(&client->lock);
+	if (lock_client)
+		mutex_lock(&client->lock);
 	valid_handle = ion_handle_validate(client, handle);
 	if (!valid_handle) {
 		WARN(1, "%s: invalid handle passed to share.\n", __func__);
-		mutex_unlock(&client->lock);
+		if (lock_client)
+			mutex_unlock(&client->lock);
 		return ERR_PTR(-EINVAL);
 	}
 	buffer = handle->buffer;
 	ion_buffer_get(buffer);
-	mutex_unlock(&client->lock);
+	if (lock_client)
+		mutex_unlock(&client->lock);
 
 	exp_info.ops = &dma_buf_ops;
 	exp_info.size = buffer->size;
@@ -1061,14 +1053,21 @@ struct dma_buf *ion_share_dma_buf(struct
 
 	return dmabuf;
 }
+
+struct dma_buf *ion_share_dma_buf(struct ion_client *client,
+				  struct ion_handle *handle)
+{
+	return __ion_share_dma_buf(client, handle, true);
+}
 EXPORT_SYMBOL(ion_share_dma_buf);
 
-int ion_share_dma_buf_fd(struct ion_client *client, struct ion_handle *handle)
+static int __ion_share_dma_buf_fd(struct ion_client *client,
+				  struct ion_handle *handle, bool lock_client)
 {
 	struct dma_buf *dmabuf;
 	int fd;
 
-	dmabuf = ion_share_dma_buf(client, handle);
+	dmabuf = __ion_share_dma_buf(client, handle, lock_client);
 	if (IS_ERR(dmabuf))
 		return PTR_ERR(dmabuf);
 
@@ -1078,8 +1077,19 @@ int ion_share_dma_buf_fd(struct ion_clie
 
 	return fd;
 }
+
+int ion_share_dma_buf_fd(struct ion_client *client, struct ion_handle *handle)
+{
+	return __ion_share_dma_buf_fd(client, handle, true);
+}
 EXPORT_SYMBOL(ion_share_dma_buf_fd);
 
+int ion_share_dma_buf_fd_nolock(struct ion_client *client,
+				struct ion_handle *handle)
+{
+	return __ion_share_dma_buf_fd(client, handle, false);
+}
+
 struct ion_handle *ion_import_dma_buf(struct ion_client *client,
 				      struct dma_buf *dmabuf)
 {
--- a/drivers/staging/android/ion/ion_priv.h
+++ b/drivers/staging/android/ion/ion_priv.h
@@ -463,11 +463,11 @@ void ion_free_nolock(struct ion_client *
 
 int ion_handle_put_nolock(struct ion_handle *handle);
 
-struct ion_handle *ion_handle_get_by_id(struct ion_client *client,
-						int id);
-
 int ion_handle_put(struct ion_handle *handle);
 
 int ion_query_heaps(struct ion_client *client, struct ion_heap_query *query);
 
+int ion_share_dma_buf_fd_nolock(struct ion_client *client,
+				struct ion_handle *handle);
+
 #endif /* _ION_PRIV_H */


