Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072D3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E85820841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="im2hgZnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E85820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeIAART (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:17:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39360 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbeIAART (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:17:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id g20-v6so5913027pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZQF/L5Cq1+DNQ3ZeWq/nCXPomXku6PeyemlhYFsm+SM=;
        b=im2hgZnGe6xTWDmyx4f0F+PUKg8R/VnfIDQC0rtFuE/6686tIww8sATviXNplP1CRM
         l8S0WIAP2wrrkogJ1aNvszWTKgd6KqOwD/zGhMzmKIN4j1AXMFANDHcOiKuyotxbJx+f
         SXFzIYk9gfnbwz+OtAy8CusRiZf9AnddoNtGTAc6fLP8229MN16Ur2R8vU0lsjnGTEJT
         rSUV7zZyID7VEoNd3zc/txJ9qEBLdDLdSUw3kWjhyU8tpFmtAlQ5z88Tsgwjt5T7AZ1C
         RRz5nZCaIRnnY0UmDjuD5pD9kjYxOMKwLnMz0LsU+xWEaeN5eJjN7+UjMJJ07DEyQNUq
         4oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZQF/L5Cq1+DNQ3ZeWq/nCXPomXku6PeyemlhYFsm+SM=;
        b=qac5s4NKh5Pas1QW2w2RlvFFWQkI7kroN6U67lvN4O5lLcUxdOnxIYlBmBw+iBlGYj
         +O1Gge4CnH0iuPFyiszN22ZsY37vDQHZq/kfYWWNmYwkAJekzsjrdLld28pcsMzYoqSn
         dMt2183+lCxzhuATAn6QeX15Dlalx+rps5TLz8PMU32LPYIT9VFksxNx/exTH8BbHH3e
         ZXT0SgOlz1Fb9itzQ0bgGe3QpAVel4LLSc6HSalvicJ4NIpC9swFxnCmaX0M8kY07tNf
         zEDyq6Tub8gMZLWvo77kw8Ext19bOLZtD9blVvAv1Jm9vYcbFbW7gEvLY5RKUVX8+f/v
         uomg==
X-Gm-Message-State: APzg51BtVGe005SpNnOOv7H3HjhFq5L4ChkDQ+WoIenvwjjZWCQ5WfFw
        uCS81r3bZ8n6WNpUfJI4y9ydk7Q3WqE=
X-Google-Smtp-Source: ANB0VdYvPwcx5lu+fCdQFoLzKcM+GU0+YPSs9atvisO3K+g5oxVjOI9jjySOVMpxOzJdG5Ls3zi6BA==
X-Received: by 2002:a65:40cd:: with SMTP id u13-v6mr1073705pgp.334.1535746095522;
        Fri, 31 Aug 2018 13:08:15 -0700 (PDT)
Received: from hackmann.mtv.corp.google.com ([2620:0:1000:1601:82f7:8f1:8c08:a97a])
        by smtp.gmail.com with ESMTPSA id b73-v6sm20060039pfj.93.2018.08.31.13.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:08:14 -0700 (PDT)
From:   Greg Hackmann <ghackmann@android.com>
X-Google-Original-From: Greg Hackmann <ghackmann@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, kernel-team@android.com,
        Greg Hackmann <ghackmann@google.com>, stable@vger.kernel.org
Subject: [PATCH] staging: android: ion: fix ION_IOC_{MAP,SHARE} use-after-free
Date:   Fri, 31 Aug 2018 13:06:27 -0700
Message-Id: <20180831200627.59712-1-ghackmann@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

This patch is applied on top of 4.9.y.  Kernels 4.12 and later are
unaffected, since all the underlying ion_handle infrastructure has been
ripped out.

Cc: stable@vger.kernel.org # v4.11-
Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
 drivers/staging/android/ion/ion-ioctl.c | 12 ++++---
 drivers/staging/android/ion/ion.c       | 48 +++++++++++++++----------
 drivers/staging/android/ion/ion_priv.h  |  6 ++--
 3 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/android/ion/ion-ioctl.c b/drivers/staging/android/ion/ion-ioctl.c
index 2b700e8455c6..e3596855a703 100644
--- a/drivers/staging/android/ion/ion-ioctl.c
+++ b/drivers/staging/android/ion/ion-ioctl.c
@@ -128,11 +128,15 @@ long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 6f9974cb0e15..403df8bf4b48 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -352,18 +352,6 @@ struct ion_handle *ion_handle_get_by_id_nolock(struct ion_client *client,
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
@@ -1029,24 +1017,28 @@ static struct dma_buf_ops dma_buf_ops = {
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
@@ -1061,14 +1053,21 @@ struct dma_buf *ion_share_dma_buf(struct ion_client *client,
 
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
 
@@ -1078,8 +1077,19 @@ int ion_share_dma_buf_fd(struct ion_client *client, struct ion_handle *handle)
 
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
diff --git a/drivers/staging/android/ion/ion_priv.h b/drivers/staging/android/ion/ion_priv.h
index 3c3b3245275d..760e41885448 100644
--- a/drivers/staging/android/ion/ion_priv.h
+++ b/drivers/staging/android/ion/ion_priv.h
@@ -463,11 +463,11 @@ void ion_free_nolock(struct ion_client *client, struct ion_handle *handle);
 
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
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

