Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7310C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A443820854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A443820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeIMSl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:41:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58448 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbeIMSl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:41:26 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DE931D16;
        Thu, 13 Sep 2018 13:31:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg Hackmann <ghackmann@google.com>,
        Laura Abbott <labbott@redhat.com>
Subject: [PATCH 4.4 02/60] staging: android: ion: fix ION_IOC_{MAP,SHARE} use-after-free
Date:   Thu, 13 Sep 2018 15:30:09 +0200
Message-Id: <20180913131745.390423347@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
References: <20180913131745.261413581@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Hackmann <ghackmann@android.com>

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

This patch is applied on top of 4.4.y, and applies to older kernels
too.  4.9.y was fixed separately.  Kernels 4.12 and later are
unaffected, since all the underlying ion_handle infrastructure has been
ripped out.

Cc: stable@vger.kernel.org # v4.4-
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Acked-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: remove Change-Id line from commit message

 drivers/staging/android/ion/ion.c |   60 +++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 23 deletions(-)

--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -449,18 +449,6 @@ static struct ion_handle *ion_handle_get
 	return ERR_PTR(-EINVAL);
 }
 
-struct ion_handle *ion_handle_get_by_id(struct ion_client *client,
-						int id)
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
@@ -1138,24 +1126,28 @@ static struct dma_buf_ops dma_buf_ops =
 	.kunmap = ion_dma_buf_kunmap,
 };
 
-struct dma_buf *ion_share_dma_buf(struct ion_client *client,
-						struct ion_handle *handle)
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
@@ -1170,14 +1162,21 @@ struct dma_buf *ion_share_dma_buf(struct
 
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
 
@@ -1187,8 +1186,19 @@ int ion_share_dma_buf_fd(struct ion_clie
 
 	return fd;
 }
+
+int ion_share_dma_buf_fd(struct ion_client *client, struct ion_handle *handle)
+{
+	return __ion_share_dma_buf_fd(client, handle, true);
+}
 EXPORT_SYMBOL(ion_share_dma_buf_fd);
 
+static int ion_share_dma_buf_fd_nolock(struct ion_client *client,
+				       struct ion_handle *handle)
+{
+	return __ion_share_dma_buf_fd(client, handle, false);
+}
+
 struct ion_handle *ion_import_dma_buf(struct ion_client *client, int fd)
 {
 	struct dma_buf *dmabuf;
@@ -1335,11 +1345,15 @@ static long ion_ioctl(struct file *filp,
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


