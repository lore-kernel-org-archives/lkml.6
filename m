Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCE425524
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCE425524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeGBOy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:54:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39035 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752003AbeGBOyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:54:25 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8E00FA4469E68;
        Mon,  2 Jul 2018 22:54:21 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.382.0; Mon, 2 Jul 2018
 22:54:15 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     <linux-erofs@lists.ozlabs.org>
CC:     <yuchao0@huawei.com>, <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        "Gao Xiang" <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [WIP] [NOMERGE] [RFC PATCH v0.4 1/7] <linux/tagptr.h>: Introduce tagged pointer
Date:   Mon, 2 Jul 2018 22:53:47 +0800
Message-ID: <1530543233-65279-2-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530543233-65279-1-git-send-email-gaoxiang25@huawei.com>
References: <1530109204-7321-1-git-send-email-gaoxiang25@huawei.com>
 <1530543233-65279-1-git-send-email-gaoxiang25@huawei.com>
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
 fs/file.c              |  24 ++++++-----
 include/linux/file.h   |  15 ++++---
 include/linux/tagptr.h | 110 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/tagptr.h

diff --git a/fs/file.c b/fs/file.c
index 7ffd6e9..c54cb50 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -727,42 +727,44 @@ struct file *fget_raw(unsigned int fd)
  * The fput_needed flag returned by fget_light should be passed to the
  * corresponding fput_light.
  */
-static unsigned long __fget_light(unsigned int fd, fmode_t mask)
+static fdtagptr_t __fget_light(unsigned int fd, fmode_t mask)
 {
+	const fdtagptr_t nil = tagptr_init(fdtagptr_t, NULL);
 	struct files_struct *files = current->files;
 	struct file *file;
 
 	if (atomic_read(&files->count) == 1) {
 		file = __fcheck_files(files, fd);
 		if (!file || unlikely(file->f_mode & mask))
-			return 0;
-		return (unsigned long)file;
+			return nil;
+		return tagptr_fold(fdtagptr_t, file, 0);
 	} else {
 		file = __fget(fd, mask);
 		if (!file)
-			return 0;
-		return FDPUT_FPUT | (unsigned long)file;
+			return nil;
+		return tagptr_fold(fdtagptr_t, file, FDPUT_FPUT);
 	}
 }
-unsigned long __fdget(unsigned int fd)
+
+fdtagptr_t __fdget(unsigned int fd)
 {
 	return __fget_light(fd, FMODE_PATH);
 }
 EXPORT_SYMBOL(__fdget);
 
-unsigned long __fdget_raw(unsigned int fd)
+fdtagptr_t __fdget_raw(unsigned int fd)
 {
 	return __fget_light(fd, 0);
 }
 
-unsigned long __fdget_pos(unsigned int fd)
+fdtagptr_t __fdget_pos(unsigned int fd)
 {
-	unsigned long v = __fdget(fd);
-	struct file *file = (struct file *)(v & ~3);
+	fdtagptr_t v = __fdget(fd);
+	struct file *file = tagptr_unfold_ptr(v);
 
 	if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
 		if (file_count(file) > 1) {
-			v |= FDPUT_POS_UNLOCK;
+			tagptr_set_tags(&v, FDPUT_POS_UNLOCK);
 			mutex_lock(&file->f_pos_lock);
 		}
 	}
diff --git a/include/linux/file.h b/include/linux/file.h
index 279720d..e2bb489 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/posix_types.h>
+#include <linux/tagptr.h>
 
 struct file;
 
@@ -34,6 +35,9 @@ struct fd {
 #define FDPUT_FPUT       1
 #define FDPUT_POS_UNLOCK 2
 
+/* tagged pointer for fd */
+typedef tagptr2_t	fdtagptr_t;
+
 static inline void fdput(struct fd fd)
 {
 	if (fd.flags & FDPUT_FPUT)
@@ -42,14 +46,15 @@ static inline void fdput(struct fd fd)
 
 extern struct file *fget(unsigned int fd);
 extern struct file *fget_raw(unsigned int fd);
-extern unsigned long __fdget(unsigned int fd);
-extern unsigned long __fdget_raw(unsigned int fd);
-extern unsigned long __fdget_pos(unsigned int fd);
+extern fdtagptr_t __fdget(unsigned int fd);
+extern fdtagptr_t __fdget_raw(unsigned int fd);
+extern fdtagptr_t __fdget_pos(unsigned int fd);
 extern void __f_unlock_pos(struct file *);
 
-static inline struct fd __to_fd(unsigned long v)
+static inline struct fd __to_fd(fdtagptr_t v)
 {
-	return (struct fd){(struct file *)(v & ~3),v & 3};
+	return (struct fd){ tagptr_unfold_ptr(v),
+		tagptr_unfold_tags(v) };
 }
 
 static inline struct fd fdget(unsigned int fd)
diff --git a/include/linux/tagptr.h b/include/linux/tagptr.h
new file mode 100644
index 0000000..b5c6016
--- /dev/null
+++ b/include/linux/tagptr.h
@@ -0,0 +1,110 @@
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
+/*
+ * the name of tagged pointer types are tagptr{1, 2, 3...}_t
+ * avoid directly using the internal structs __tagptr{1, 2, 3...}
+ */
+#define __MAKE_TAGPTR(n) \
+typedef struct __tagptr##n {	\
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
+/* fix the broken usage of "#define tagptr2_t tagptr3_t" by users */
+#define __tagptr_mask_1(ptr, n)	\
+	__builtin_types_compatible_p(typeof(ptr), struct __tagptr##n) ? \
+		(1UL << (n)) - 1 :
+
+#define __tagptr_mask(ptr)	(\
+	__tagptr_mask_1(ptr, 1) ( \
+	__tagptr_mask_1(ptr, 2) ( \
+	__tagptr_mask_1(ptr, 3) ( \
+	__tagptr_mask_1(ptr, 4) ( \
+	__bad_tagptr_type(), 0)))))
+
+/* generate a tagged pointer from a raw value */
+#define tagptr_init(type, val) \
+	((typeof(type)){ .v = (uintptr_t)(val) })
+
+/*
+ * directly cast a tagged pointer to the native pointer type, which
+ * could be used for backward compatibility of existing code.
+ */
+#define tagptr_cast_ptr(tptr) ((void *)(tptr).v)
+
+/* encode tagged pointers */
+#define tagptr_fold(type, ptr, _tags) ({ \
+	const typeof(_tags) tags = (_tags); \
+	if (__builtin_constant_p(tags) && (tags & ~__tagptr_mask(type))) \
+		__bad_tagptr_tags(); \
+tagptr_init(type, (uintptr_t)(ptr) | tags); })
+
+/* decode tagged pointers */
+#define tagptr_unfold_ptr(tptr) \
+	((void *)((tptr).v & ~__tagptr_mask(tptr)))
+
+#define tagptr_unfold_tags(tptr) \
+	((tptr).v & __tagptr_mask(tptr))
+
+/* operations for the tagger pointer */
+#define tagptr_eq(_tptr1, _tptr2) ({ \
+	typeof(_tptr1) tptr1 = (_tptr1); \
+	typeof(_tptr2) tptr2 = (_tptr2); \
+	(void) (&tptr1 == &tptr2); \
+(tptr1).v == (tptr2).v; })
+
+/* lock-free CAS operation */
+#define tagptr_cmpxchg(_ptptr, _o, _n) ({ \
+	typeof(_ptptr) ptptr = (_ptptr); \
+	typeof(_o) o = (_o); \
+	typeof(_n) n = (_n); \
+	(void) (&o == &n); \
+	(void) (&o == ptptr); \
+tagptr_init(o, cmpxchg(&ptptr->v, o.v, n.v)); })
+
+/* wrap WRITE_ONCE if atomic update is needed */
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

