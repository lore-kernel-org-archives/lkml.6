Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA6AECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB9121566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB9121566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390974AbeIUWXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:23:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbeIUWXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:23:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2E4230001DC;
        Fri, 21 Sep 2018 16:33:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10D881949F;
        Fri, 21 Sep 2018 16:33:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 27/34] vfs: Implement logging through fs_context [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:33:49 +0100
Message-ID: <153754762931.17872.2825472098741709854.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 21 Sep 2018 16:33:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the ability for filesystems to log error, warning and
informational messages through the fs_context.  These can be extracted by
userspace by reading from an fd created by fsopen().

Error messages are prefixed with "e ", warnings with "w " and informational
messages with "i ".

Inside the kernel, formatted messages are malloc'd but unformatted messages
are not copied if they're either in the core .rodata section or in the
.rodata section of the filesystem module pinned by fs_context::fs_type.
The messages are only good till the fs_type is released.

Note that the logging object is shared between duplicated fs_context
structures.  This is so that such as NFS which do a mount within a mount
can get at least some of the errors from the inner mount.

Five logging functions are provided for this:

 (1) void logfc(struct fs_context *fc, const char *fmt, ...);

     This logs a message into the context.  If the buffer is full, the
     earliest message is discarded.

 (2) void errorf(fc, fmt, ...);

     This wraps logfc() to log an error.

 (3) void invalf(fc, fmt, ...);

     This wraps errorf() and returns -EINVAL for convenience.

 (4) void warnf(fc, fmt, ...);

     This wraps logfc() to log a warning.

 (5) void infof(fc, fmt, ...);

     This wraps logfc() to log an informational message.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fs_context.c            |  107 ++++++++++++++++++++++++++++++++++++++++++++
 fs/fsopen.c                |   67 ++++++++++++++++++++++++++++
 include/linux/fs_context.h |   24 ++++++++--
 include/linux/module.h     |    6 ++
 4 files changed, 200 insertions(+), 4 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 5d93c86c649d..e242bfe12084 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -11,6 +11,7 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/module.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/fs.h>
@@ -24,6 +25,7 @@
 #include <linux/user_namespace.h>
 #include <linux/bsearch.h>
 #include <net/net_namespace.h>
+#include <asm/sections.h>
 #include "mount.h"
 #include "internal.h"
 
@@ -346,6 +348,8 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc,
 	get_net(fc->net_ns);
 	get_user_ns(fc->user_ns);
 	get_cred(fc->cred);
+	if (fc->log)
+		refcount_inc(&fc->log->usage);
 
 	/* Can't call put until we've called ->dup */
 	ret = fc->ops->dup(fc, src_fc);
@@ -363,6 +367,108 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc,
 }
 EXPORT_SYMBOL(vfs_dup_fs_context);
 
+/**
+ * logfc - Log a message to a filesystem context
+ * @fc: The filesystem context to log to.
+ * @fmt: The format of the buffer.
+ */
+void logfc(struct fs_context *fc, const char *fmt, ...)
+{
+	static const char store_failure[] = "OOM: Can't store error string";
+	struct fc_log *log = fc ? fc->log : NULL;
+	const char *p;
+	va_list va;
+	char *q;
+	u8 freeable;
+
+	va_start(va, fmt);
+	if (!strchr(fmt, '%')) {
+		p = fmt;
+		goto unformatted_string;
+	}
+	if (strcmp(fmt, "%s") == 0) {
+		p = va_arg(va, const char *);
+		goto unformatted_string;
+	}
+
+	q = kvasprintf(GFP_KERNEL, fmt, va);
+copied_string:
+	if (!q)
+		goto store_failure;
+	freeable = 1;
+	goto store_string;
+
+unformatted_string:
+	if ((unsigned long)p >= (unsigned long)__start_rodata &&
+	    (unsigned long)p <  (unsigned long)__end_rodata)
+		goto const_string;
+	if (log && within_module_core((unsigned long)p, log->owner))
+		goto const_string;
+	q = kstrdup(p, GFP_KERNEL);
+	goto copied_string;
+
+store_failure:
+	p = store_failure;
+const_string:
+	q = (char *)p;
+	freeable = 0;
+store_string:
+	if (!log) {
+		switch (fmt[0]) {
+		case 'w':
+			printk(KERN_WARNING "%s\n", q + 2);
+			break;
+		case 'e':
+			printk(KERN_ERR "%s\n", q + 2);
+			break;
+		default:
+			printk(KERN_NOTICE "%s\n", q + 2);
+			break;
+		}
+		if (freeable)
+			kfree(q);
+	} else {
+		unsigned int logsize = ARRAY_SIZE(log->buffer);
+		u8 index;
+
+		index = log->head & (logsize - 1);
+		BUILD_BUG_ON(sizeof(log->head) != sizeof(u8) ||
+			     sizeof(log->tail) != sizeof(u8));
+		if ((u8)(log->head - log->tail) == logsize) {
+			/* The buffer is full, discard the oldest message */
+			if (log->need_free & (1 << index))
+				kfree(log->buffer[index]);
+			log->tail++;
+		}
+
+		log->buffer[index] = q;
+		log->need_free &= ~(1 << index);
+		log->need_free |= freeable << index;
+		log->head++;
+	}
+	va_end(va);
+}
+EXPORT_SYMBOL(logfc);
+
+/*
+ * Free a logging structure.
+ */
+static void put_fc_log(struct fs_context *fc)
+{
+	struct fc_log *log = fc->log;
+	int i;
+
+	if (log) {
+		if (refcount_dec_and_test(&log->usage)) {
+			fc->log = NULL;
+			for (i = 0; i <= 7; i++)
+				if (log->need_free & (1 << i))
+					kfree(log->buffer[i]);
+			kfree(log);
+		}
+	}
+}
+
 /**
  * put_fs_context - Dispose of a superblock configuration context.
  * @fc: The context to dispose of.
@@ -388,6 +494,7 @@ void put_fs_context(struct fs_context *fc)
 	if (fc->cred)
 		put_cred(fc->cred);
 	kfree(fc->subtype);
+	put_fc_log(fc);
 	put_filesystem(fc->fs_type);
 	kfree(fc->source);
 	kfree(fc);
diff --git a/fs/fsopen.c b/fs/fsopen.c
index a9a36f61d76c..1b966b0c15f7 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -19,6 +19,52 @@
 #include <linux/file.h>
 #include "mount.h"
 
+/*
+ * Allow the user to read back any error, warning or informational messages.
+ */
+static ssize_t fscontext_read(struct file *file,
+			      char __user *_buf, size_t len, loff_t *pos)
+{
+	struct fs_context *fc = file->private_data;
+	struct fc_log *log = fc->log;
+	unsigned int logsize = ARRAY_SIZE(log->buffer);
+	ssize_t ret;
+	char *p;
+	bool need_free;
+	int index, n;
+
+	ret = mutex_lock_interruptible(&fc->uapi_mutex);
+	if (ret < 0)
+		return ret;
+
+	if (log->head == log->tail) {
+		mutex_unlock(&fc->uapi_mutex);
+		return -ENODATA;
+	}
+
+	index = log->tail & (logsize - 1);
+	p = log->buffer[index];
+	need_free = log->need_free & (1 << index);
+	log->buffer[index] = NULL;
+	log->need_free &= ~(1 << index);
+	log->tail++;
+	mutex_unlock(&fc->uapi_mutex);
+
+	ret = -EMSGSIZE;
+	n = strlen(p);
+	if (n > len)
+		goto err_free;
+	ret = -EFAULT;
+	if (copy_to_user(_buf, p, n) != 0)
+		goto err_free;
+	ret = n;
+
+err_free:
+	if (need_free)
+		kfree(p);
+	return ret;
+}
+
 static int fscontext_release(struct inode *inode, struct file *file)
 {
 	struct fs_context *fc = file->private_data;
@@ -31,6 +77,7 @@ static int fscontext_release(struct inode *inode, struct file *file)
 }
 
 const struct file_operations fscontext_fops = {
+	.read		= fscontext_read,
 	.release	= fscontext_release,
 	.llseek		= no_llseek,
 };
@@ -49,6 +96,16 @@ static int fscontext_create_fd(struct fs_context *fc, unsigned int o_flags)
 	return fd;
 }
 
+static int fscontext_alloc_log(struct fs_context *fc)
+{
+	fc->log = kzalloc(sizeof(*fc->log), GFP_KERNEL);
+	if (!fc->log)
+		return -ENOMEM;
+	refcount_set(&fc->log->usage, 1);
+	fc->log->owner = fc->fs_type->owner;
+	return 0;
+}
+
 /*
  * Open a filesystem by name so that it can be configured for mounting.
  *
@@ -61,6 +118,7 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
 	struct file_system_type *fs_type;
 	struct fs_context *fc;
 	const char *fs_name;
+	int ret;
 
 	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
@@ -83,5 +141,14 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
 		return PTR_ERR(fc);
 
 	fc->phase = FS_CONTEXT_CREATE_PARAMS;
+
+	ret = fscontext_alloc_log(fc);
+	if (ret < 0)
+		goto err_fc;
+
 	return fscontext_create_fd(fc, flags & FSOPEN_CLOEXEC ? O_CLOEXEC : 0);
+
+err_fc:
+	put_fs_context(fc);
+	return ret;
 }
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 37f8bafaaec3..bb584db982ff 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -13,6 +13,7 @@
 #define _LINUX_FS_CONTEXT_H
 
 #include <linux/kernel.h>
+#include <linux/refcount.h>
 #include <linux/errno.h>
 #include <linux/mutex.h>
 
@@ -98,6 +99,7 @@ struct fs_context {
 	struct user_namespace	*user_ns;	/* The user namespace for this mount */
 	struct net		*net_ns;	/* The network namespace for this mount */
 	const struct cred	*cred;		/* The mounter's credentials */
+	struct fc_log		*log;		/* Logging buffer */
 	char			*source;	/* The source name (eg. dev path) */
 	char			*subtype;	/* The subtype to set on the superblock */
 	void			*security;	/* The LSM context */
@@ -154,7 +156,21 @@ extern int vfs_get_super(struct fs_context *fc,
 
 extern const struct file_operations fscontext_fops;
 
-#define logfc(FC, FMT, ...) pr_notice(FMT, ## __VA_ARGS__)
+/*
+ * Mount error, warning and informational message logging.  This structure is
+ * shareable between a mount and a subordinate mount.
+ */
+struct fc_log {
+	refcount_t	usage;
+	u8		head;		/* Insertion index in buffer[] */
+	u8		tail;		/* Removal index in buffer[] */
+	u8		need_free;	/* Mask of kfree'able items in buffer[] */
+	struct module	*owner;		/* Owner module for strings that don't then need freeing */
+	char		*buffer[8];
+};
+
+extern __attribute__((format(printf, 2, 3)))
+void logfc(struct fs_context *fc, const char *fmt, ...);
 
 /**
  * infof - Store supplementary informational message
@@ -164,7 +180,7 @@ extern const struct file_operations fscontext_fops;
  * Store the supplementary informational message for the process if the process
  * has enabled the facility.
  */
-#define infof(fc, fmt, ...) ({ logfc(fc, fmt, ## __VA_ARGS__); })
+#define infof(fc, fmt, ...) ({ logfc(fc, "i "fmt, ## __VA_ARGS__); })
 
 /**
  * warnf - Store supplementary warning message
@@ -174,7 +190,7 @@ extern const struct file_operations fscontext_fops;
  * Store the supplementary warning message for the process if the process has
  * enabled the facility.
  */
-#define warnf(fc, fmt, ...) ({ logfc(fc, fmt, ## __VA_ARGS__); })
+#define warnf(fc, fmt, ...) ({ logfc(fc, "w "fmt, ## __VA_ARGS__); })
 
 /**
  * errorf - Store supplementary error message
@@ -184,7 +200,7 @@ extern const struct file_operations fscontext_fops;
  * Store the supplementary error message for the process if the process has
  * enabled the facility.
  */
-#define errorf(fc, fmt, ...) ({ logfc(fc, fmt, ## __VA_ARGS__); })
+#define errorf(fc, fmt, ...) ({ logfc(fc, "e "fmt, ## __VA_ARGS__); })
 
 /**
  * invalf - Store supplementary invalid argument error message
diff --git a/include/linux/module.h b/include/linux/module.h
index f807f15bebbe..0add4e176a06 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -682,6 +682,12 @@ static inline bool is_module_text_address(unsigned long addr)
 	return false;
 }
 
+static inline bool within_module_core(unsigned long addr,
+				      const struct module *mod)
+{
+	return false;
+}
+
 /* Get/put a kernel symbol (calls should be symmetric) */
 #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
 #define symbol_put(x) do { } while (0)

