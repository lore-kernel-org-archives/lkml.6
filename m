Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D198C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECB42713A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECB42713A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934654AbeF1JG7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:06:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932274AbeF1JG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:06:56 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F18B05CE759E2;
        Thu, 28 Jun 2018 17:06:39 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.382.0; Thu, 28 Jun
 2018 17:06:34 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] <linux/taggedptr.h>: Introduce tagged pointer
Date:   Thu, 28 Jun 2018 17:06:29 +0800
Message-ID: <1530176789-107541-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kernel has scattered tagged pointer usages hacked
by hand in plain code, without a unique and portable functionset
to highlight the tagged pointer itself and wrap these hacked code
in order to clean up all over meaningless magic masks.

Therefore, this patch introduces simple generic methods to fold
tags into a pointer integer. It currently reuses the last 2 bits
of the pointer for tags, which are safely for all modern platforms.

In addition, it will also be used for the upcoming EROFS filesystem,
which heavily uses tagged pointer approach for high performance
and reducing extra memory allocation.

Refer to:
https://en.wikipedia.org/wiki/Tagged_pointer

To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: Miao Xie <miaoxie@huawei.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

Tagged pointers are good for performance and memory saving,
hoping for a generic taggedptr approach to clean up redundant dirty code.

Any comments, suggestions or alternative approaches are welcomed. :)

Thanks,
Gao Xiang

 fs/file.c                 | 19 ++++++------
 include/linux/file.h      |  7 +++--
 include/linux/taggedptr.h | 76 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/taggedptr.h

diff --git a/fs/file.c b/fs/file.c
index 7ffd6e9..6d6f185 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -727,7 +727,7 @@ struct file *fget_raw(unsigned int fd)
  * The fput_needed flag returned by fget_light should be passed to the
  * corresponding fput_light.
  */
-static unsigned long __fget_light(unsigned int fd, fmode_t mask)
+static taggedptr_t __fget_light(unsigned int fd, fmode_t mask)
 {
 	struct files_struct *files = current->files;
 	struct file *file;
@@ -736,33 +736,34 @@ static unsigned long __fget_light(unsigned int fd, fmode_t mask)
 		file = __fcheck_files(files, fd);
 		if (!file || unlikely(file->f_mode & mask))
 			return 0;
-		return (unsigned long)file;
+		return taggedptr_fold(file, 0);
 	} else {
 		file = __fget(fd, mask);
 		if (!file)
 			return 0;
-		return FDPUT_FPUT | (unsigned long)file;
+		return taggedptr_fold(file, FDPUT_FPUT);
 	}
 }
-unsigned long __fdget(unsigned int fd)
+
+taggedptr_t __fdget(unsigned int fd)
 {
 	return __fget_light(fd, FMODE_PATH);
 }
 EXPORT_SYMBOL(__fdget);
 
-unsigned long __fdget_raw(unsigned int fd)
+taggedptr_t __fdget_raw(unsigned int fd)
 {
 	return __fget_light(fd, 0);
 }
 
-unsigned long __fdget_pos(unsigned int fd)
+taggedptr_t __fdget_pos(unsigned int fd)
 {
-	unsigned long v = __fdget(fd);
-	struct file *file = (struct file *)(v & ~3);
+	taggedptr_t v = __fdget(fd);
+	struct file *file = taggedptr_unfold_ptr(v);
 
 	if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
 		if (file_count(file) > 1) {
-			v |= FDPUT_POS_UNLOCK;
+			taggedptr_set_tags(v, FDPUT_POS_UNLOCK);
 			mutex_lock(&file->f_pos_lock);
 		}
 	}
diff --git a/include/linux/file.h b/include/linux/file.h
index 279720d..af81f68 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/posix_types.h>
+#include <linux/taggedptr.h>
 
 struct file;
 
@@ -42,9 +43,9 @@ static inline void fdput(struct fd fd)
 
 extern struct file *fget(unsigned int fd);
 extern struct file *fget_raw(unsigned int fd);
-extern unsigned long __fdget(unsigned int fd);
-extern unsigned long __fdget_raw(unsigned int fd);
-extern unsigned long __fdget_pos(unsigned int fd);
+extern taggedptr_t __fdget(unsigned int fd);
+extern taggedptr_t __fdget_raw(unsigned int fd);
+extern taggedptr_t __fdget_pos(unsigned int fd);
 extern void __f_unlock_pos(struct file *);
 
 static inline struct fd __to_fd(unsigned long v)
diff --git a/include/linux/taggedptr.h b/include/linux/taggedptr.h
new file mode 100644
index 0000000..1805394
--- /dev/null
+++ b/include/linux/taggedptr.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Tagged pointer implementation
+ *
+ * Copyright (C) 2018 Gao Xiang <gaoxiang25@huawei.com>
+ */
+#ifndef _LINUX_TAGGEDPTR_H
+#define _LINUX_TAGGEDPTR_H
+
+#include <linux/types.h>
+#include <linux/build_bug.h>
+
+/*
+ * mark these special integers as another type
+ * in order to highlight the tagged pointer usage.
+ */
+typedef uintptr_t	taggedptr_t;
+
+/*
+ * generally for all architectures, the last 2 bits of
+ * pointer can be used safely
+ */
+#ifndef TAGGEDPTR_TAGS_BITS
+#define TAGGEDPTR_TAGS_BITS	2
+#endif
+
+#define TAGGEDPTR_TAGS_MASK	((1 << TAGGEDPTR_TAGS_BITS) - 1)
+
+extern void __compiletime_error("bad taggedptr tags")
+	__bad_taggedptr_tags(void);
+
+/* encode the tagged pointer */
+static inline taggedptr_t taggedptr_fold(void *ptr, unsigned int tags)
+{
+	if (__builtin_constant_p(tags) && (tags & ~TAGGEDPTR_TAGS_MASK))
+		__bad_taggedptr_tags();
+
+	return (taggedptr_t)ptr | tags;
+}
+
+static inline void *taggedptr_unfold_ptr(taggedptr_t tptr)
+{
+	return (void *)(tptr & ~TAGGEDPTR_TAGS_MASK);
+}
+
+static inline unsigned int taggedptr_unfold_tags(taggedptr_t tptr)
+{
+	return tptr & TAGGEDPTR_TAGS_MASK;
+}
+
+static inline taggedptr_t taggedptr_replace_tags(taggedptr_t tptr,
+						 unsigned int tags)
+{
+	return taggedptr_fold(taggedptr_unfold_ptr(tptr), tags);
+}
+
+static inline taggedptr_t taggedptr_set_tags(taggedptr_t tptr,
+					     unsigned int tags)
+{
+	if (__builtin_constant_p(tags) && (tags & ~TAGGEDPTR_TAGS_MASK))
+		__bad_taggedptr_tags();
+
+	return tptr |= tags;
+}
+
+static inline taggedptr_t taggedptr_clear_tags(taggedptr_t tptr,
+					       unsigned int tags)
+{
+	if (__builtin_constant_p(tags) && (tags & ~TAGGEDPTR_TAGS_MASK))
+		__bad_taggedptr_tags();
+
+	return tptr &= ~tags;
+}
+
+#endif
+
-- 
1.9.1

