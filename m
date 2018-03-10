Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933071AbeCJSYP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:24:15 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34961 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932925AbeCJSVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:48 -0500
X-Google-Smtp-Source: AG47ELvnRxhRLakMrDKlTPiYzoenCyFU3bRSSBQ+B4WIa3eCXIjbJmvCScswx8w3pYXtBlyEWT0dgw==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 76/83] Ioctl support.
Date: Sat, 10 Mar 2018 10:18:57 -0800
Message-Id: <1520705944-6723-77-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

NOVA appends link change entry to the inode log to implement
SETFLAGS and SETVERSION.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/Makefile |   4 +-
 fs/nova/dir.c    |   4 ++
 fs/nova/file.c   |   4 ++
 fs/nova/inode.h  |   2 +
 fs/nova/ioctl.c  | 184 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nova/nova.h   |   7 +++
 6 files changed, 203 insertions(+), 2 deletions(-)
 create mode 100644 fs/nova/ioctl.c

diff --git a/fs/nova/Makefile b/fs/nova/Makefile
index 7bf6403..87e56c6 100644
--- a/fs/nova/Makefile
+++ b/fs/nova/Makefile
@@ -4,5 +4,5 @@
 
 obj-$(CONFIG_NOVA_FS) += nova.o
 
-nova-y := balloc.o bbuild.o dax.o dir.o file.o inode.o journal.o log.o namei.o\
-	  rebuild.o stats.o super.o symlink.o
+nova-y := balloc.o bbuild.o dax.o dir.o file.o inode.o ioctl.o journal.o\
+	  log.o namei.o rebuild.o stats.o super.o symlink.o
diff --git a/fs/nova/dir.c b/fs/nova/dir.c
index 47ee9ad..3694d9d 100644
--- a/fs/nova/dir.c
+++ b/fs/nova/dir.c
@@ -513,4 +513,8 @@ const struct file_operations nova_dir_operations = {
 	.read		= generic_read_dir,
 	.iterate	= nova_readdir,
 	.fsync		= noop_fsync,
+	.unlocked_ioctl = nova_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= nova_compat_ioctl,
+#endif
 };
diff --git a/fs/nova/file.c b/fs/nova/file.c
index 7e90415..2b70b9d 100644
--- a/fs/nova/file.c
+++ b/fs/nova/file.c
@@ -714,7 +714,11 @@ const struct file_operations nova_dax_file_operations = {
 	.open		= nova_open,
 	.fsync		= nova_fsync,
 	.flush		= nova_flush,
+	.unlocked_ioctl	= nova_ioctl,
 	.fallocate	= nova_fallocate,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= nova_compat_ioctl,
+#endif
 };
 
 const struct inode_operations nova_file_inode_operations = {
diff --git a/fs/nova/inode.h b/fs/nova/inode.h
index 693aa90..086a7cb 100644
--- a/fs/nova/inode.h
+++ b/fs/nova/inode.h
@@ -264,6 +264,8 @@ int nova_delete_file_tree(struct super_block *sb,
 	struct nova_inode_info_header *sih, unsigned long start_blocknr,
 	unsigned long last_blocknr, bool delete_nvmm, bool delete_dead,
 	u64 epoch_id);
+extern void nova_set_inode_flags(struct inode *inode, struct nova_inode *pi,
+	unsigned int flags);
 unsigned long nova_find_region(struct inode *inode, loff_t *offset, int hole);
 extern void nova_evict_inode(struct inode *inode);
 extern int nova_write_inode(struct inode *inode, struct writeback_control *wbc);
diff --git a/fs/nova/ioctl.c b/fs/nova/ioctl.c
new file mode 100644
index 0000000..2509371
--- /dev/null
+++ b/fs/nova/ioctl.c
@@ -0,0 +1,184 @@
+/*
+ * BRIEF DESCRIPTION
+ *
+ * Ioctl operations.
+ *
+ * Copyright 2015-2016 Regents of the University of California,
+ * UCSD Non-Volatile Systems Lab, Andiry Xu <jix024@cs.ucsd.edu>
+ * Copyright 2012-2013 Intel Corporation
+ * Copyright 2010-2011 Marco Stornelli <marco.stornelli@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/capability.h>
+#include <linux/time.h>
+#include <linux/sched.h>
+#include <linux/compat.h>
+#include <linux/mount.h>
+#include "nova.h"
+#include "inode.h"
+
+long nova_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct address_space *mapping = filp->f_mapping;
+	struct inode    *inode = mapping->host;
+	struct nova_inode_info *si = NOVA_I(inode);
+	struct nova_inode_info_header *sih = &si->header;
+	struct nova_inode *pi;
+	struct super_block *sb = inode->i_sb;
+	struct nova_inode_update update;
+	unsigned int flags;
+	int ret;
+
+	pi = nova_get_inode(sb, inode);
+	if (!pi)
+		return -EACCES;
+
+	switch (cmd) {
+	case FS_IOC_GETFLAGS:
+		flags = (sih->i_flags) & NOVA_FL_USER_VISIBLE;
+		return put_user(flags, (int __user *)arg);
+	case FS_IOC_SETFLAGS: {
+		unsigned int oldflags;
+		u64 old_linkc = 0;
+		u64 epoch_id;
+
+		ret = mnt_want_write_file(filp);
+		if (ret)
+			return ret;
+
+		if (!inode_owner_or_capable(inode)) {
+			ret = -EPERM;
+			goto flags_out;
+		}
+
+		if (get_user(flags, (int __user *)arg)) {
+			ret = -EFAULT;
+			goto flags_out;
+		}
+
+		inode_lock(inode);
+		sih_lock(sih);
+		oldflags = le32_to_cpu(pi->i_flags);
+
+		if ((flags ^ oldflags) &
+		    (FS_APPEND_FL | FS_IMMUTABLE_FL)) {
+			if (!capable(CAP_LINUX_IMMUTABLE)) {
+				inode_unlock(inode);
+				ret = -EPERM;
+				goto flags_out_unlock;
+			}
+		}
+
+		if (!S_ISDIR(inode->i_mode))
+			flags &= ~FS_DIRSYNC_FL;
+
+		epoch_id = nova_get_epoch_id(sb);
+		flags = flags & FS_FL_USER_MODIFIABLE;
+		flags |= oldflags & ~FS_FL_USER_MODIFIABLE;
+		inode->i_ctime = current_time(inode);
+		nova_set_inode_flags(inode, pi, flags);
+		sih->i_flags = flags;
+
+		update.tail = 0;
+		ret = nova_append_link_change_entry(sb, pi, inode,
+					&update, &old_linkc, epoch_id);
+		if (!ret) {
+			nova_update_inode(sb, inode, pi, &update);
+			nova_invalidate_link_change_entry(sb, old_linkc);
+		}
+		sih->trans_id++;
+flags_out_unlock:
+		sih_unlock(sih);
+		inode_unlock(inode);
+flags_out:
+		mnt_drop_write_file(filp);
+		return ret;
+	}
+	case FS_IOC_GETVERSION:
+		return put_user(inode->i_generation, (int __user *)arg);
+	case FS_IOC_SETVERSION: {
+		u64 old_linkc = 0;
+		u64 epoch_id;
+		__u32 generation;
+
+		if (!inode_owner_or_capable(inode))
+			return -EPERM;
+		ret = mnt_want_write_file(filp);
+		if (ret)
+			return ret;
+		if (get_user(generation, (int __user *)arg)) {
+			ret = -EFAULT;
+			goto setversion_out;
+		}
+
+		epoch_id = nova_get_epoch_id(sb);
+		inode_lock(inode);
+		sih_lock(sih);
+		inode->i_ctime = current_time(inode);
+		inode->i_generation = generation;
+
+		update.tail = 0;
+		ret = nova_append_link_change_entry(sb, pi, inode,
+					&update, &old_linkc, epoch_id);
+		if (!ret) {
+			nova_update_inode(sb, inode, pi, &update);
+			nova_invalidate_link_change_entry(sb, old_linkc);
+		}
+		sih->trans_id++;
+		sih_unlock(sih);
+		inode_unlock(inode);
+setversion_out:
+		mnt_drop_write_file(filp);
+		return ret;
+	}
+	case NOVA_PRINT_TIMING: {
+		nova_print_timing_stats(sb);
+		return 0;
+	}
+	case NOVA_CLEAR_STATS: {
+		nova_clear_stats(sb);
+		return 0;
+	}
+	case NOVA_PRINT_LOG: {
+		nova_print_inode_log(sb, inode);
+		return 0;
+	}
+	case NOVA_PRINT_LOG_PAGES: {
+		nova_print_inode_log_pages(sb, inode);
+		return 0;
+	}
+	case NOVA_PRINT_FREE_LISTS: {
+		nova_print_free_lists(sb);
+		return 0;
+	}
+	default:
+		return -ENOTTY;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+long nova_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case FS_IOC32_GETFLAGS:
+		cmd = FS_IOC_GETFLAGS;
+		break;
+	case FS_IOC32_SETFLAGS:
+		cmd = FS_IOC_SETFLAGS;
+		break;
+	case FS_IOC32_GETVERSION:
+		cmd = FS_IOC_GETVERSION;
+		break;
+	case FS_IOC32_SETVERSION:
+		cmd = FS_IOC_SETVERSION;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+	return nova_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
diff --git a/fs/nova/nova.h b/fs/nova/nova.h
index d209cfc..ab9153e 100644
--- a/fs/nova/nova.h
+++ b/fs/nova/nova.h
@@ -515,6 +515,13 @@ int nova_remove_dentry(struct dentry *dentry, int dec_link,
 extern const struct file_operations nova_dax_file_operations;
 extern const struct inode_operations nova_file_inode_operations;
 
+/* ioctl.c */
+extern long nova_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+#ifdef CONFIG_COMPAT
+extern long nova_compat_ioctl(struct file *file, unsigned int cmd,
+	unsigned long arg);
+#endif
+
 /* namei.c */
 extern const struct inode_operations nova_dir_inode_operations;
 extern const struct inode_operations nova_special_inode_operations;
-- 
2.7.4
