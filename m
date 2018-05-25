Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971968AbeEYAKg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:10:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S971845AbeEYAHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:07:55 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 23/32] VFS: Implement logging through fs_context [ver #8]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 01:07:53 +0100
Message-ID: <152720687323.9073.8203139324888988263.stgit@warthog.procyon.org.uk>
In-Reply-To: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
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

 fs/fs_context.c            |   92 ++++++++++++++++++++++++++++++++++++++++++++
 fs/fsopen.c                |   71 ++++++++++++++++++++++++++++++++++
 include/linux/fs_context.h |   58 ++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index bef68a12ddb5..326a334b8860 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -11,6 +11,7 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/module.h>
 #include <linux/fs_context.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
@@ -23,6 +24,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
 #include <net/net_namespace.h>
+#include <asm/sections.h>
 #include "mount.h"
 
 enum legacy_fs_param {
@@ -327,7 +329,7 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
 	int ret;
 
 	if (!src_fc->ops->dup)
-		return ERR_PTR(-ENOTSUPP);
+		return ERR_PTR(-EOPNOTSUPP);
 
 	fc = kmemdup(src_fc, sizeof(struct legacy_fs_context), GFP_KERNEL);
 	if (!fc)
@@ -340,6 +342,8 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
 	get_net(fc->net_ns);
 	get_user_ns(fc->user_ns);
 	get_cred(fc->cred);
+	if (fc->log)
+		refcount_inc(&fc->log->usage);
 
 	/* Can't call put until we've called ->dup */
 	ret = fc->ops->dup(fc, src_fc);
@@ -357,6 +361,91 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
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
+	struct fc_log *log = fc->log;
+	unsigned int logsize = ARRAY_SIZE(log->buffer);
+	const char *p;
+	va_list va;
+	char *q;
+	u8 freeable, index;
+
+	if (!log)
+		return;
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
+	if (within_module_core((unsigned long)p, log->owner))
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
+	index = log->head & (logsize - 1);
+	if ((int)log->head - (int)log->tail == 8) {
+		/* The buffer is full, discard the oldest message */
+		if (log->need_free & (1 << index))
+			kfree(log->buffer[index]);
+		log->tail++;
+	}
+
+	log->buffer[index] = q;
+	log->need_free &= ~(1 << index);
+	log->need_free |= freeable << index;
+	log->head++;
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
@@ -385,6 +474,7 @@ void put_fs_context(struct fs_context *fc)
 	if (fc->cred)
 		put_cred(fc->cred);
 	kfree(fc->subtype);
+	put_fc_log(fc);
 	put_filesystem(fc->fs_type);
 	kfree(fc->source);
 	kfree(fc);
diff --git a/fs/fsopen.c b/fs/fsopen.c
index d69155b9303e..df3f603001a3 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -159,7 +159,57 @@ static ssize_t fscontext_fs_write(struct file *file,
 	goto err_unlock;
 }
 
+/*
+ * Allow the user to read back any error, warning or informational messages.
+ */
+static ssize_t fscontext_fs_read(struct file *file,
+				 char __user *_buf, size_t len, loff_t *pos)
+{
+	struct fs_context *fc = file->private_data;
+	struct fc_log *log = fc->log;
+	struct inode *inode = file_inode(file);
+	unsigned int logsize = ARRAY_SIZE(log->buffer);
+	ssize_t ret;
+	char *p;
+	bool need_free;
+	int index, n;
+
+	ret = inode_lock_killable(inode);
+	if (ret < 0)
+		return ret;
+
+	ret = -ENODATA;
+	if (log->head != log->tail) {
+		index = log->tail & (logsize - 1);
+		p = log->buffer[index];
+		need_free = log->need_free & (1 << index);
+		log->buffer[index] = NULL;
+		log->need_free &= ~(1 << index);
+		log->tail++;
+		ret = 0;
+	}
+
+	inode_unlock(inode);
+	if (ret < 0)
+		return ret;
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
 const struct file_operations fscontext_fs_fops = {
+	.read		= fscontext_fs_read,
 	.write		= fscontext_fs_write,
 	.release	= fscontext_fs_release,
 	.llseek		= no_llseek,
@@ -330,6 +380,7 @@ SYSCALL_DEFINE5(fsopen, const char __user *, _fs_name, unsigned int, flags,
 	struct file_system_type *fs_type;
 	struct fs_context *fc;
 	const char *fs_name;
+	int ret;
 
 	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
@@ -353,7 +404,18 @@ SYSCALL_DEFINE5(fsopen, const char __user *, _fs_name, unsigned int, flags,
 
 	fc->phase = FS_CONTEXT_CREATE_PARAMS;
 
+	ret = -ENOMEM;
+	fc->log = kzalloc(sizeof(*fc->log), GFP_KERNEL);
+	if (!fc->log)
+		goto err_fc;
+	refcount_set(&fc->log->usage, 1);
+	fc->log->owner = fs_type->owner;
+
 	return fsopen_create_fd(fc, flags & FSOPEN_CLOEXEC);
+
+err_fc:
+	put_fs_context(fc);
+	return ret;
 }
 
 /*
@@ -396,9 +458,18 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char *, path, unsigned int, flags)
 
 	fc->phase = FS_CONTEXT_RECONF_PARAMS;
 
+	ret = -ENOMEM;
+	fc->log = kzalloc(sizeof(*fc->log), GFP_KERNEL);
+	if (!fc->log)
+		goto err_fc;
+	refcount_set(&fc->log->usage, 1);
+	fc->log->owner = fc->fs_type->owner;
+
 	path_put(&target);
 	return fsopen_create_fd(fc, flags & FSPICK_CLOEXEC);
 
+err_fc:
+	put_fs_context(fc);
 err_path:
 	path_put(&target);
 err:
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index bec4022e3f4b..c6c4c403b3f9 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -13,6 +13,7 @@
 #define _LINUX_FS_CONTEXT_H
 
 #include <linux/kernel.h>
+#include <linux/refcount.h>
 #include <linux/errno.h>
 
 struct cred;
@@ -64,6 +65,7 @@ struct fs_context {
 	struct user_namespace	*user_ns;	/* The user namespace for this mount */
 	struct net		*net_ns;	/* The network namespace for this mount */
 	const struct cred	*cred;		/* The mounter's credentials */
+	struct fc_log		*log;		/* Logging buffer */
 	char			*source;	/* The source name (eg. dev path) */
 	char			*subtype;	/* The subtype to set on the superblock */
 	void			*security;	/* The LSM context */
@@ -117,4 +119,60 @@ extern int vfs_get_super(struct fs_context *fc,
 
 extern const struct file_operations fscontext_fs_fops;
 
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
+
+/**
+ * infof - Store supplementary informational message
+ * @fc: The context in which to log the informational message
+ * @fmt: The format string
+ *
+ * Store the supplementary informational message for the process if the process
+ * has enabled the facility.
+ */
+#define infof(fc, fmt, ...) ({ logfc(fc, "i "fmt, ## __VA_ARGS__); })
+
+/**
+ * warnf - Store supplementary warning message
+ * @fc: The context in which to log the error message
+ * @fmt: The format string
+ *
+ * Store the supplementary warning message for the process if the process has
+ * enabled the facility.
+ */
+#define warnf(fc, fmt, ...) ({ logfc(fc, "w "fmt, ## __VA_ARGS__); })
+
+/**
+ * errorf - Store supplementary error message
+ * @fc: The context in which to log the error message
+ * @fmt: The format string
+ *
+ * Store the supplementary error message for the process if the process has
+ * enabled the facility.
+ */
+#define errorf(fc, fmt, ...) ({ logfc(fc, "e "fmt, ## __VA_ARGS__); })
+
+/**
+ * invalf - Store supplementary invalid argument error message
+ * @fc: The context in which to log the error message
+ * @fmt: The format string
+ *
+ * Store the supplementary error message for the process if the process has
+ * enabled the facility and return -EINVAL.
+ */
+#define invalf(fc, fmt, ...) ({	errorf(fc, fmt, ## __VA_ARGS__); -EINVAL; })
+
 #endif /* _LINUX_FS_CONTEXT_H */
