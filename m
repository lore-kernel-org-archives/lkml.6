Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B97DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1072054F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeLSJQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:16:04 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41071 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727159AbeLSJQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:16:04 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A55518862400A;
        Wed, 19 Dec 2018 17:16:00 +0800 (CST)
Received: from dessert.huawei.com (10.69.192.158) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Wed, 19 Dec 2018 17:15:53 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <labbott@redhat.com>, <sumit.semwal@linaro.org>
CC:     Zeng Tao <prime.zeng@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: android: ion: add buffer flag update ioctl
Date:   Thu, 20 Dec 2018 01:19:03 +0800
Message-ID: <1545239943-15414-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some usecases, the buffer cached attribute is not determined at
allocation time, it's determined just before the real cpu mapping.
And from the memory view of point, a buffer should not have the cached
attribute util is really mapped by the cpu. So in this patch, we
introduced the new ioctl command to target the requirement.

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 drivers/staging/android/ion/ion-ioctl.c |  4 ++++
 drivers/staging/android/ion/ion.c       | 17 +++++++++++++++++
 drivers/staging/android/ion/ion.h       |  1 +
 drivers/staging/android/uapi/ion.h      | 22 ++++++++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/drivers/staging/android/ion/ion-ioctl.c b/drivers/staging/android/ion/ion-ioctl.c
index a8d3cc4..60bb702 100644
--- a/drivers/staging/android/ion/ion-ioctl.c
+++ b/drivers/staging/android/ion/ion-ioctl.c
@@ -12,6 +12,7 @@
 
 union ion_ioctl_arg {
 	struct ion_allocation_data allocation;
+	struct ion_buffer_flag_data update;
 	struct ion_heap_query query;
 };
 
@@ -83,6 +84,9 @@ long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		break;
 	}
+	case ION_IOC_BUFFER_UPDATE:
+		ret = ion_buffer_update(data.update.fd, data.update.flags);
+		break;
 	case ION_IOC_HEAP_QUERY:
 		ret = ion_query_heaps(&data.query);
 		break;
diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 9907332..f1404dc 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -436,6 +436,23 @@ int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
 	return fd;
 }
 
+int ion_buffer_update(unsigned int fd, unsigned int flags)
+{
+	struct dma_buf *dmabuf;
+	struct ion_buffer *buffer;
+
+	dmabuf = dma_buf_get(fd);
+
+	if (!dmabuf)
+		return -EINVAL;
+
+	buffer = dmabuf->priv;
+	buffer->flags = flags;
+	dma_buf_put(dmabuf);
+
+	return 0;
+}
+
 int ion_query_heaps(struct ion_heap_query *query)
 {
 	struct ion_device *dev = internal_dev;
diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index c006fc1..99bf9ab 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -199,6 +199,7 @@ int ion_heap_pages_zero(struct page *page, size_t size, pgprot_t pgprot);
 int ion_alloc(size_t len,
 	      unsigned int heap_id_mask,
 	      unsigned int flags);
+int ion_buffer_update(unsigned int fd, unsigned int flags);
 
 /**
  * ion_heap_init_shrinker
diff --git a/drivers/staging/android/uapi/ion.h b/drivers/staging/android/uapi/ion.h
index 5d70098..99753fc 100644
--- a/drivers/staging/android/uapi/ion.h
+++ b/drivers/staging/android/uapi/ion.h
@@ -74,6 +74,20 @@ struct ion_allocation_data {
 	__u32 unused;
 };
 
+/**
+ * struct ion_buffer_flag_data - metadata passed from userspace for update
+ * buffer flags
+ * @fd:			file descriptor of the buffer
+ * @flags:		flags passed to the buffer
+ *
+ * Provided by userspace as an argument to the ioctl
+ */
+
+struct ion_buffer_flag_data {
+	__u32 fd;
+	__u32 flags;
+}
+
 #define MAX_HEAP_NAME			32
 
 /**
@@ -116,6 +130,14 @@ struct ion_heap_query {
 				      struct ion_allocation_data)
 
 /**
+ * DOC: ION_IOC_BUFFER_UPDATE - update the specified ion buffer flags
+ *
+ * Takes an ion_buffer_flag_data structure and returns the result of the
+ * buffer flag update operation.
+ */
+#define ION_IOC_BUFFER_UPDATE	_IOWR(ION_IOC_MAGIC, 1, \
+				      struct ion_buffer_flag_data)
+/**
  * DOC: ION_IOC_HEAP_QUERY - information about available heaps
  *
  * Takes an ion_heap_query structure and populates information about
-- 
2.7.4

