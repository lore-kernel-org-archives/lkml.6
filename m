Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeDJCYm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 22:24:42 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38325 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeDJCYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 22:24:40 -0400
X-Google-Smtp-Source: AIpwx4/zdx3KJtnryvhc1ffIQIEbILExSLMBkAuh28HzXxCXT/Mwa8UVlTGRLJQkp0mEZ7Fd9pxv3Q==
From: Geliang Tang <geliangtang@gmail.com>
To: Phillip Lougher <phillip@squashfs.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, kbuild test robot <lkp@intel.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] squashfs: Add posix acl support
Date: Tue, 10 Apr 2018 10:24:35 +0800
Message-Id: <975b0f7acbb65445551ee374a2dd38d553ac2e6a.1523326310.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <201804100217.d2VDp6Fv%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add posix acl (Access Control Lists) support for squashfs, which is
marked as a todo item in squashfs' documentation.  This patch implements
the squashfs_get_acl function to read file's acl information from its
xattr lists.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
Changes in v2:
 - fix build error, set squashfs_get_acl to NULL when CONFIG_SQUASHFS_POSIX_ACL is not selected.
---
 Documentation/filesystems/squashfs.txt |  2 -
 fs/squashfs/Kconfig                    | 11 ++++++
 fs/squashfs/Makefile                   |  1 +
 fs/squashfs/acl.c                      | 69 ++++++++++++++++++++++++++++++++++
 fs/squashfs/acl.h                      | 31 +++++++++++++++
 fs/squashfs/inode.c                    |  4 +-
 fs/squashfs/namei.c                    |  6 ++-
 fs/squashfs/squashfs_fs.h              | 12 +++---
 fs/squashfs/super.c                    |  3 ++
 fs/squashfs/symlink.c                  |  6 ++-
 fs/squashfs/xattr.c                    | 13 ++++++-
 fs/squashfs/xattr.h                    |  8 ++++
 12 files changed, 153 insertions(+), 13 deletions(-)
 create mode 100644 fs/squashfs/acl.c
 create mode 100644 fs/squashfs/acl.h

diff --git a/Documentation/filesystems/squashfs.txt b/Documentation/filesystems/squashfs.txt
index e5274f84dc56..539fad6b4db0 100644
--- a/Documentation/filesystems/squashfs.txt
+++ b/Documentation/filesystems/squashfs.txt
@@ -235,8 +235,6 @@ list using a second xattr id lookup table.
 4.1 Todo list
 -------------
 
-Implement ACL support.
-
 4.2 Squashfs internal cache
 ---------------------------
 
diff --git a/fs/squashfs/Kconfig b/fs/squashfs/Kconfig
index 1adb3346b9d6..f9587bcf9dd9 100644
--- a/fs/squashfs/Kconfig
+++ b/fs/squashfs/Kconfig
@@ -107,6 +107,17 @@ config SQUASHFS_XATTR
 
 	  If unsure, say N.
 
+config SQUASHFS_POSIX_ACL
+	bool "Squashfs POSIX ACL support"
+	depends on SQUASHFS_XATTR
+	select FS_POSIX_ACL
+	help
+	  Saying Y here includes support for Access Control Lists (acls).
+	  Acls are used to define more fine-grained discretionary access
+	  rights for files and directories (see the acl(5) manual page).
+
+	  If unsure, say N.
+
 config SQUASHFS_ZLIB
 	bool "Include support for ZLIB compressed file systems"
 	depends on SQUASHFS
diff --git a/fs/squashfs/Makefile b/fs/squashfs/Makefile
index 7bd9b8b856d0..73bc1c8a8df6 100644
--- a/fs/squashfs/Makefile
+++ b/fs/squashfs/Makefile
@@ -12,6 +12,7 @@ squashfs-$(CONFIG_SQUASHFS_DECOMP_SINGLE) += decompressor_single.o
 squashfs-$(CONFIG_SQUASHFS_DECOMP_MULTI) += decompressor_multi.o
 squashfs-$(CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU) += decompressor_multi_percpu.o
 squashfs-$(CONFIG_SQUASHFS_XATTR) += xattr.o xattr_id.o
+squashfs-$(CONFIG_SQUASHFS_POSIX_ACL) += acl.o
 squashfs-$(CONFIG_SQUASHFS_LZ4) += lz4_wrapper.o
 squashfs-$(CONFIG_SQUASHFS_LZO) += lzo_wrapper.o
 squashfs-$(CONFIG_SQUASHFS_XZ) += xz_wrapper.o
diff --git a/fs/squashfs/acl.c b/fs/squashfs/acl.c
new file mode 100644
index 000000000000..1c9eb2d13c2b
--- /dev/null
+++ b/fs/squashfs/acl.c
@@ -0,0 +1,69 @@
+/*
+ * Squashfs - a compressed read only filesystem for Linux
+ *
+ * Copyright (c) 2018
+ * Phillip Lougher <phillip@squashfs.org.uk>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2,
+ * or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ *
+ * acl.c
+ */
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include "squashfs_fs.h"
+#include "xattr.h"
+#include "acl.h"
+
+struct posix_acl *squashfs_get_acl(struct inode *inode, int type)
+{
+	int name_index;
+	char *name;
+	struct posix_acl *acl = NULL;
+	char *value = NULL;
+	int retval;
+
+	switch (type) {
+	case ACL_TYPE_ACCESS:
+		name_index = SQUASHFS_XATTR_POSIX_ACL_ACCESS;
+		name = XATTR_POSIX_ACL_ACCESS;
+		break;
+	case ACL_TYPE_DEFAULT:
+		name_index = SQUASHFS_XATTR_POSIX_ACL_DEFAULT;
+		name = XATTR_POSIX_ACL_DEFAULT;
+		break;
+	default:
+		BUG();
+	}
+
+	retval = squashfs_xattr_get(inode, name_index, name, NULL, 0);
+	if (retval > 0) {
+		value = kmalloc(retval, GFP_KERNEL);
+		if (!value)
+			return ERR_PTR(-ENOMEM);
+		retval = squashfs_xattr_get(inode, name_index, name, value, retval);
+	}
+	if (retval > 0)
+		acl = posix_acl_from_xattr(&init_user_ns, value, retval);
+	else if (retval == -ENODATA || retval == -ENOSYS)
+		acl = NULL;
+	else
+		acl = ERR_PTR(retval);
+
+	kfree(value);
+
+	return acl;
+}
diff --git a/fs/squashfs/acl.h b/fs/squashfs/acl.h
new file mode 100644
index 000000000000..06f704e05450
--- /dev/null
+++ b/fs/squashfs/acl.h
@@ -0,0 +1,31 @@
+/*
+ * Squashfs - a compressed read only filesystem for Linux
+ *
+ * Copyright (c) 2018
+ * Phillip Lougher <phillip@squashfs.org.uk>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2,
+ * or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ *
+ * acl.h
+ */
+
+#include <linux/fs.h>
+#include <linux/posix_acl_xattr.h>
+
+#ifdef CONFIG_SQUASHFS_POSIX_ACL
+extern struct posix_acl *squashfs_get_acl(struct inode *inode, int type);
+#else
+#define squashfs_get_acl	NULL
+#endif
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index e9793b1e49a5..2035a1acffd7 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -48,6 +48,7 @@
 #include "squashfs_fs_i.h"
 #include "squashfs.h"
 #include "xattr.h"
+#include "acl.h"
 
 /*
  * Initialise VFS inode with the base inode information common to all
@@ -425,6 +426,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 
 
 const struct inode_operations squashfs_inode_ops = {
-	.listxattr = squashfs_listxattr
+	.listxattr	= squashfs_listxattr,
+	.get_acl	= squashfs_get_acl
 };
 
diff --git a/fs/squashfs/namei.c b/fs/squashfs/namei.c
index 40c10d9974c9..33ad74780040 100644
--- a/fs/squashfs/namei.c
+++ b/fs/squashfs/namei.c
@@ -64,6 +64,7 @@
 #include "squashfs_fs_i.h"
 #include "squashfs.h"
 #include "xattr.h"
+#include "acl.h"
 
 /*
  * Lookup name in the directory index, returning the location of the metadata
@@ -246,6 +247,7 @@ static struct dentry *squashfs_lookup(struct inode *dir, struct dentry *dentry,
 
 
 const struct inode_operations squashfs_dir_inode_ops = {
-	.lookup = squashfs_lookup,
-	.listxattr = squashfs_listxattr
+	.lookup		= squashfs_lookup,
+	.listxattr	= squashfs_listxattr,
+	.get_acl	= squashfs_get_acl
 };
diff --git a/fs/squashfs/squashfs_fs.h b/fs/squashfs/squashfs_fs.h
index 24d12fd14177..c7ac9fc4f8f4 100644
--- a/fs/squashfs/squashfs_fs.h
+++ b/fs/squashfs/squashfs_fs.h
@@ -107,11 +107,13 @@
 #define SQUASHFS_MAX_DIR_TYPE		7
 
 /* Xattr types */
-#define SQUASHFS_XATTR_USER             0
-#define SQUASHFS_XATTR_TRUSTED          1
-#define SQUASHFS_XATTR_SECURITY         2
-#define SQUASHFS_XATTR_VALUE_OOL        256
-#define SQUASHFS_XATTR_PREFIX_MASK      0xff
+#define SQUASHFS_XATTR_USER			0
+#define SQUASHFS_XATTR_POSIX_ACL_ACCESS		1
+#define SQUASHFS_XATTR_POSIX_ACL_DEFAULT	2
+#define SQUASHFS_XATTR_TRUSTED			3
+#define SQUASHFS_XATTR_SECURITY			4
+#define SQUASHFS_XATTR_VALUE_OOL		256
+#define SQUASHFS_XATTR_PREFIX_MASK		0xff
 
 /* Flag whether block is compressed or uncompressed, bit is set if block is
  * uncompressed */
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 8a73b97217c8..beea564f1063 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -196,6 +196,9 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_flags |= SB_RDONLY;
+#ifdef CONFIG_SQUASHFS_POSIX_ACL
+	sb->s_flags |= SB_POSIXACL;
+#endif
 	sb->s_op = &squashfs_super_ops;
 
 	err = -ENOMEM;
diff --git a/fs/squashfs/symlink.c b/fs/squashfs/symlink.c
index befeba0fa70a..a7f30d890905 100644
--- a/fs/squashfs/symlink.c
+++ b/fs/squashfs/symlink.c
@@ -42,6 +42,7 @@
 #include "squashfs_fs_i.h"
 #include "squashfs.h"
 #include "xattr.h"
+#include "acl.h"
 
 static int squashfs_symlink_readpage(struct file *file, struct page *page)
 {
@@ -118,7 +119,8 @@ const struct address_space_operations squashfs_symlink_aops = {
 };
 
 const struct inode_operations squashfs_symlink_inode_ops = {
-	.get_link = page_get_link,
-	.listxattr = squashfs_listxattr
+	.get_link	= page_get_link,
+	.listxattr	= squashfs_listxattr,
+	.get_acl	= squashfs_get_acl
 };
 
diff --git a/fs/squashfs/xattr.c b/fs/squashfs/xattr.c
index 1548b3784548..a1d773b5b0bc 100644
--- a/fs/squashfs/xattr.c
+++ b/fs/squashfs/xattr.c
@@ -33,6 +33,7 @@
 #include "squashfs_fs_sb.h"
 #include "squashfs_fs_i.h"
 #include "squashfs.h"
+#include "acl.h"
 
 static const struct xattr_handler *squashfs_xattr_handler(int);
 
@@ -115,7 +116,7 @@ ssize_t squashfs_listxattr(struct dentry *d, char *buffer,
 }
 
 
-static int squashfs_xattr_get(struct inode *inode, int name_index,
+int squashfs_xattr_get(struct inode *inode, int name_index,
 	const char *name, void *buffer, size_t buffer_size)
 {
 	struct super_block *sb = inode->i_sb;
@@ -265,6 +266,12 @@ static const struct xattr_handler *squashfs_xattr_handler(int type)
 	switch (type & SQUASHFS_XATTR_PREFIX_MASK) {
 	case SQUASHFS_XATTR_USER:
 		return &squashfs_xattr_user_handler;
+#ifdef CONFIG_SQUASHFS_POSIX_ACL
+	case SQUASHFS_XATTR_POSIX_ACL_ACCESS:
+		return &posix_acl_access_xattr_handler;
+	case SQUASHFS_XATTR_POSIX_ACL_DEFAULT:
+		return &posix_acl_default_xattr_handler;
+#endif
 	case SQUASHFS_XATTR_TRUSTED:
 		return &squashfs_xattr_trusted_handler;
 	case SQUASHFS_XATTR_SECURITY:
@@ -277,6 +284,10 @@ static const struct xattr_handler *squashfs_xattr_handler(int type)
 
 const struct xattr_handler *squashfs_xattr_handlers[] = {
 	&squashfs_xattr_user_handler,
+#ifdef CONFIG_SQUASHFS_POSIX_ACL
+	&posix_acl_access_xattr_handler,
+	&posix_acl_default_xattr_handler,
+#endif
 	&squashfs_xattr_trusted_handler,
 	&squashfs_xattr_security_handler,
 	NULL
diff --git a/fs/squashfs/xattr.h b/fs/squashfs/xattr.h
index afe70f815e3d..ac08650c08cc 100644
--- a/fs/squashfs/xattr.h
+++ b/fs/squashfs/xattr.h
@@ -26,6 +26,8 @@ extern __le64 *squashfs_read_xattr_id_table(struct super_block *, u64,
 		u64 *, int *);
 extern int squashfs_xattr_lookup(struct super_block *, unsigned int, int *,
 		unsigned int *, unsigned long long *);
+extern int squashfs_xattr_get(struct inode *inode, int name_index,
+	const char *name, void *buffer, size_t buffer_size);
 #else
 static inline __le64 *squashfs_read_xattr_id_table(struct super_block *sb,
 		u64 start, u64 *xattr_table_start, int *xattr_ids)
@@ -41,6 +43,12 @@ static inline int squashfs_xattr_lookup(struct super_block *sb,
 {
 	return 0;
 }
+
+static int squashfs_xattr_get(struct inode *inode, int name_index,
+	const char *name, void *buffer, size_t buffer_size)
+{
+	return 0;
+}
 #define squashfs_listxattr NULL
 #define squashfs_xattr_handlers NULL
 #endif
-- 
2.14.1
