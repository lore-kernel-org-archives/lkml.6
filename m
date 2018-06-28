Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4244AC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0146274BE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0146274BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966517AbeF1ORl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:17:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34657 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S966247AbeF1ORj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:17:39 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 097EB73C0BB4;
        Thu, 28 Jun 2018 22:17:33 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.382.0; Thu, 28 Jun
 2018 22:17:28 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2] <linux/tagptr.h>: Introduce tagged pointer
Date:   Thu, 28 Jun 2018 22:17:18 +0800
Message-ID: <1530195438-81985-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530176789-107541-1-git-send-email-gaoxiang25@huawei.com>
References: <1530176789-107541-1-git-send-email-gaoxiang25@huawei.com>
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
tags into a pointer integer. It currently supports the last n bits
of the pointer for tags, which can be selected by users.

In addition, it will also be used for the upcoming EROFS filesystem,
which heavily uses tagged pointer approach for high performance
and reducing extra memory allocation.

Refer to:
https://en.wikipedia.org/wiki/Tagged_pointer

To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: Miao Xie <miaoxie@huawei.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
change log v2:
  - add support to select the last {1,2,3,...} bits for tags

Tagged pointers are good for performance and memory saving,
hoping for a generic taggedptr approach to clean up redundant dirty code.

Any comments, suggestions or alternative approaches are welcomed. :)

Thanks,
Gao Xiang

 fs/file.c              | 23 ++++++++-------
 include/linux/file.h   | 12 ++++----
 include/linux/tagptr.h | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/tagptr.h

diff --git a/fs/file.c b/fs/file.c
index 7ffd6e9..5f1270b 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -727,7 +727,7 @@ struct file *fget_raw(unsigned int fd)
  * The fput_needed flag returned by fget_light should be passed to the
  * corresponding fput_light.
  */
-static unsigned long __fget_light(unsigned int fd, fmode_t mask)
+static tagptr2_t __fget_light(unsigned int fd, fmode_t mask)
 {
 	struct files_struct *files = current->files;
 	struct file *file;
@@ -735,34 +735,35 @@ static unsigned long __fget_light(unsigned int fd, fmode_t mask)
 	if (atomic_read(&files->count) == 1) {
 		file = __fcheck_files(files, fd);
 		if (!file || unlikely(file->f_mode & mask))
-			return 0;
-		return (unsigned long)file;
+			return tagptr_fold(tagptr2_t, NULL, 0);
+		return tagptr_fold(tagptr2_t, file, 0);
 	} else {
 		file = __fget(fd, mask);
 		if (!file)
-			return 0;
-		return FDPUT_FPUT | (unsigned long)file;
+			return tagptr_fold(tagptr2_t, NULL, 0);
+		return tagptr_fold(tagptr2_t, file, FDPUT_FPUT);
 	}
 }
-unsigned long __fdget(unsigned int fd)
+
+tagptr2_t __fdget(unsigned int fd)
 {
 	return __fget_light(fd, FMODE_PATH);
 }
 EXPORT_SYMBOL(__fdget);
 
-unsigned long __fdget_raw(unsigned int fd)
+tagptr2_t __fdget_raw(unsigned int fd)
 {
 	return __fget_light(fd, 0);
 }
 
-unsigned long __fdget_pos(unsigned int fd)
+tagptr2_t __fdget_pos(unsigned int fd)
 {
-	unsigned long v = __fdget(fd);
-	struct file *file = (struct file *)(v & ~3);
+	tagptr2_t v = __fdget(fd);
+	struct file *file = tagptr_unfold_ptr(v);
 
 	if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
 		if (file_count(file) > 1) {
-			v |= FDPUT_POS_UNLOCK;
+			tagptr_set_tags(&v, FDPUT_POS_UNLOCK);
 			mutex_lock(&file->f_pos_lock);
 		}
 	}
diff --git a/include/linux/file.h b/include/linux/file.h
index 279720d..dbaa915 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/posix_types.h>
+#include <linux/tagptr.h>
 
 struct file;
 
@@ -42,14 +43,15 @@ static inline void fdput(struct fd fd)
 
 extern struct file *fget(unsigned int fd);
 extern struct file *fget_raw(unsigned int fd);
-extern unsigned long __fdget(unsigned int fd);
-extern unsigned long __fdget_raw(unsigned int fd);
-extern unsigned long __fdget_pos(unsigned int fd);
+extern tagptr2_t __fdget(unsigned int fd);
+extern tagptr2_t __fdget_raw(unsigned int fd);
+extern tagptr2_t __fdget_pos(unsigned int fd);
 extern void __f_unlock_pos(struct file *);
 
-static inline struct fd __to_fd(unsigned long v)
+static inline struct fd __to_fd(tagptr2_t v)
 {
-	return (struct fd){(struct file *)(v & ~3),v & 3};
+	return (struct fd){ tagptr_unfold_ptr(v),
+		tagptr_unfold_tags(v) };
 }
 
 static inline struct fd fdget(unsigned int fd)
diff --git a/include/linux/tagptr.h b/include/linux/tagptr.h
new file mode 100644
index 0000000..6905b51
--- /dev/null
+++ b/include/linux/tagptr.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Tagged pointer implementation
+ *
+ * Copyright (C) 2018 Gao Xiang <gaoxiang25@huawei.com>
+ */
+#ifndef _LINUX_TAGPTR_H
+#define _LINUX_TAGPTR_H
+
+#include <linux/types.h>
+#include <linux/build_bug.h>
+
+/* the name of types are tagptr{1, 2, 3...}_t */
+#define __MAKE_TAGPTR(n) \
+typedef struct tagptr##n {	\
+	uintptr_t v;	\
+} tagptr##n##_t;
+
+__MAKE_TAGPTR(1)
+__MAKE_TAGPTR(2)
+__MAKE_TAGPTR(3)
+__MAKE_TAGPTR(4)
+
+#undef __MAKE_TAGPTR
+
+extern void __compiletime_error("bad tagptr tags")
+	__bad_tagptr_tags(void);
+
+extern void __compiletime_error("bad tagptr type")
+	__bad_tagptr_type(void);
+
+#define __tagptr_mask_1(ptr, n)	\
+	__builtin_types_compatible_p(typeof(ptr), tagptr##n##_t) ? \
+		(1UL << (n)) - 1 :
+
+#define __tagptr_mask(ptr)	(\
+	__tagptr_mask_1(ptr, 1) ( \
+	__tagptr_mask_1(ptr, 2) ( \
+	__tagptr_mask_1(ptr, 3) ( \
+	__tagptr_mask_1(ptr, 4) ( \
+	__bad_tagptr_type(), 0)))))
+
+/* encode the tagged pointer */
+#define tagptr_fold(type, ptr, _tags) ({ \
+	const typeof(_tags) tags = (_tags); \
+	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(type))) \
+		__bad_tagptr_tags(); \
+((typeof(type)){ .v = (uintptr_t)ptr | tags }); })
+
+#define tagptr_unfold_ptr(tptr) \
+	((void *)((tptr).v & ~__tagptr_mask(tptr)))
+
+#define tagptr_unfold_tags(tptr) \
+	((tptr).v & __tagptr_mask(tptr))
+
+#define tagptr_replace_tags(_ptptr, tags) ({ \
+	typeof(_ptptr) ptptr = (_ptptr); \
+	*ptptr = tagptr_fold(*ptptr, tagptr_unfold_ptr(*ptptr), tags); \
+*ptptr; })
+
+#define tagptr_set_tags(_ptptr, _tags) ({ \
+	typeof(_ptptr) ptptr = (_ptptr); \
+	const typeof(_tags) tags = (_tags); \
+	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(*ptptr))) \
+		__bad_tagptr_tags(); \
+	ptptr->v |= tags; \
+*ptptr; })
+
+#define tagptr_clear_tags(_ptptr, _tags) ({ \
+	typeof(_ptptr) ptptr = (_ptptr); \
+	const typeof(_tags) tags = (_tags); \
+	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(*ptptr))) \
+		__bad_tagptr_tags(); \
+	ptptr->v &= ~tags; \
+*ptptr; })
+
+#endif
+
-- 
1.9.1

