Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8AAC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC6920661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="DMOSYC2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC6920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeIDVAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:00:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35121 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeIDVAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:00:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id 7-v6so1938084pgf.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iU6BNHB7OckYwh30AndNm/d4srC1z8jvOb340/3a9Ak=;
        b=DMOSYC2BOlxaWeDIsOCvn9tJsDuxJnY+qiZRPaAtNt9lZ0g5q+wXaGh12tkgVwP3dV
         eIyoeQYhp++R2lnY4Ke7eJK2GG2AGmus0jBgUSbT+ZfpX9++Hm7VrX5l6LJS4m3rjcHq
         N8JX2No6Cuvvz/ALQRwyjmCBh9uUpk07QYpWQbG0KpFDt+EVPwlTYgO8MTTsy6lZOSu9
         ORCI9iehoA9HpiEl71bxufA47mR7PXAsL9ugdQv32yC84Jqq0sRyFJsYWkyw/L9YNgxH
         Lh4/us7ywBOtUwu7QNA3morCXB3yTwuA+LxmB0IdqX/6MhAmpgKORefQsstZJzOo8YgW
         2J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iU6BNHB7OckYwh30AndNm/d4srC1z8jvOb340/3a9Ak=;
        b=RUyOiavC+0Y0Q4rAH6ju9JQK4tkDgZh7FMgmyONPevo5PadW8FXLrVccbngELYSvUT
         ysRpl6RoWy8qJXEjOWHVpWEhhfoTZii7+OskWhFa10i5CBgEk5EpHH23/bFPaAA2mYEO
         lKm0eFoDPY6XtyeU+/Dgp38+N5bfDUEOvG3yDsew7j2Xak7weyPmbBYU3eXu/McstX9T
         uh6lsneF6zc1Hd/FBEPy24f6yGx4eIIOdwWBWo3VewivVKFOSjTXxrqdvNwbfkqR/vyB
         w0ZMbHs/Q0Nx206xfiJwFrtQyPgDXWCCLUJtvhtNo8ZYBtkrLkfE+rF+2ZcHUlKR6Rib
         jGEw==
X-Gm-Message-State: APzg51BV27WXDSHLiC1tAc1A3lvB6IpD0yPb/8YbCZcerK6bpAFfIB3B
        JB5kK2I8/dOHG6Cb3olznC9G2KrePuk=
X-Google-Smtp-Source: ANB0VdZGh1MzSzYDiGNT1Jzqoo2TkKh/i5fJT2F65ex9nsEUZDPjqmV1CRxu9QFocP1Ry3XkW/BBdA==
X-Received: by 2002:a63:dd09:: with SMTP id t9-v6mr30706610pgg.370.1536078861485;
        Tue, 04 Sep 2018 09:34:21 -0700 (PDT)
Received: from hackmann.mtv.corp.google.com ([2620:0:1000:1601:82f7:8f1:8c08:a97a])
        by smtp.gmail.com with ESMTPSA id e14-v6sm29178412pff.128.2018.09.04.09.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 09:34:20 -0700 (PDT)
From:   Greg Hackmann <ghackmann@android.com>
X-Google-Original-From: Greg Hackmann <ghackmann@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, kernel-team@android.com,
        Greg Hackmann <ghackmann@google.com>, stable@vger.kernel.org
Subject: [PATCH v2] staging: android: ion: fix ION_IOC_{MAP,SHARE} use-after-free
Date:   Tue,  4 Sep 2018 09:33:36 -0700
Message-Id: <20180904163336.234819-1-ghackmann@google.com>
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

This patch is applied on top of 4.4.y, and applies to older kernels
too.  4.9.y was fixed separately.  Kernels 4.12 and later are
unaffected, since all the underlying ion_handle infrastructure has been
ripped out.

Cc: stable@vger.kernel.org # v4.4-
Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
v2: remove Change-Id line from commit message

 drivers/staging/android/ion/ion.c | 60 +++++++++++++++++++------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 47cb163da9a0..4adb1138af09 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -449,18 +449,6 @@ static struct ion_handle *ion_handle_get_by_id_nolock(struct ion_client *client,
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
@@ -1138,24 +1126,28 @@ static struct dma_buf_ops dma_buf_ops = {
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
@@ -1170,14 +1162,21 @@ struct dma_buf *ion_share_dma_buf(struct ion_client *client,
 
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
 
@@ -1187,8 +1186,19 @@ int ion_share_dma_buf_fd(struct ion_client *client, struct ion_handle *handle)
 
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
@@ -1335,11 +1345,15 @@ static long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

