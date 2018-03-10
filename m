Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeCJSou (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:44:50 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46747 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932107AbeCJSUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:20:23 -0500
X-Google-Smtp-Source: AG47ELvUmZWf0Jz4YA0eH3I/MRdvbGOSIJyA12429pzvou1cgZNQrWHIvrYOWFA2BBfAxxuhhoUnQw==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 06/83] Add inode get/read methods.
Date: Sat, 10 Mar 2018 10:17:47 -0800
Message-Id: <1520705944-6723-7-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

These routines are incomplete and currently only support reserved inodes,
whose addresses are fixed. This is necessary for fill_super to work.
File/dir operations are left NULL.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/inode.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nova/inode.h |   3 +
 2 files changed, 179 insertions(+)
 create mode 100644 fs/nova/inode.c

diff --git a/fs/nova/inode.c b/fs/nova/inode.c
new file mode 100644
index 0000000..bfdc5dc
--- /dev/null
+++ b/fs/nova/inode.c
@@ -0,0 +1,176 @@
+/*
+ * BRIEF DESCRIPTION
+ *
+ * Inode methods (allocate/free/read/write).
+ *
+ * Copyright 2015-2016 Regents of the University of California,
+ * UCSD Non-Volatile Systems Lab, Andiry Xu <jix024@cs.ucsd.edu>
+ * Copyright 2012-2013 Intel Corporation
+ * Copyright 2009-2011 Marco Stornelli <marco.stornelli@gmail.com>
+ * Copyright 2003 Sony Corporation
+ * Copyright 2003 Matsushita Electric Industrial Co., Ltd.
+ * 2003-2004 (c) MontaVista Software, Inc. , Steve Longerbeam
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/fs.h>
+#include <linux/aio.h>
+#include <linux/highuid.h>
+#include <linux/module.h>
+#include <linux/mpage.h>
+#include <linux/backing-dev.h>
+#include <linux/types.h>
+#include <linux/ratelimit.h>
+#include "nova.h"
+#include "inode.h"
+
+unsigned int blk_type_to_shift[NOVA_BLOCK_TYPE_MAX] = {12, 21, 30};
+uint32_t blk_type_to_size[NOVA_BLOCK_TYPE_MAX] = {0x1000, 0x200000, 0x40000000};
+
+void nova_set_inode_flags(struct inode *inode, struct nova_inode *pi,
+	unsigned int flags)
+{
+	inode->i_flags &=
+		~(S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME | S_DIRSYNC);
+	if (flags & FS_SYNC_FL)
+		inode->i_flags |= S_SYNC;
+	if (flags & FS_APPEND_FL)
+		inode->i_flags |= S_APPEND;
+	if (flags & FS_IMMUTABLE_FL)
+		inode->i_flags |= S_IMMUTABLE;
+	if (flags & FS_NOATIME_FL)
+		inode->i_flags |= S_NOATIME;
+	if (flags & FS_DIRSYNC_FL)
+		inode->i_flags |= S_DIRSYNC;
+	if (!pi->i_xattr)
+		inode_has_no_xattr(inode);
+	inode->i_flags |= S_DAX;
+}
+
+/* copy persistent state to struct inode */
+static int nova_read_inode(struct super_block *sb, struct inode *inode,
+	u64 pi_addr)
+{
+	struct nova_inode_info *si = NOVA_I(inode);
+	struct nova_inode *pi, fake_pi;
+	struct nova_inode_info_header *sih = &si->header;
+	int ret = -EIO;
+	unsigned long ino;
+
+	ret = nova_get_reference(sb, pi_addr, &fake_pi,
+			(void **)&pi, sizeof(struct nova_inode));
+	if (ret) {
+		nova_dbg("%s: read pi @ 0x%llx failed\n",
+				__func__, pi_addr);
+		goto bad_inode;
+	}
+
+	inode->i_mode = sih->i_mode;
+	i_uid_write(inode, le32_to_cpu(pi->i_uid));
+	i_gid_write(inode, le32_to_cpu(pi->i_gid));
+//	set_nlink(inode, le16_to_cpu(pi->i_links_count));
+	inode->i_generation = le32_to_cpu(pi->i_generation);
+	nova_set_inode_flags(inode, pi, le32_to_cpu(pi->i_flags));
+	ino = inode->i_ino;
+
+	/* check if the inode is active. */
+	if (inode->i_mode == 0 || pi->deleted == 1) {
+		/* this inode is deleted */
+		ret = -ESTALE;
+		goto bad_inode;
+	}
+
+	inode->i_blocks = sih->i_blocks;
+
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFREG:
+		break;
+	case S_IFDIR:
+		break;
+	case S_IFLNK:
+		break;
+	default:
+		init_special_inode(inode, inode->i_mode,
+				   le32_to_cpu(pi->dev.rdev));
+		break;
+	}
+
+	/* Update size and time after rebuild the tree */
+	inode->i_size = le64_to_cpu(sih->i_size);
+	inode->i_atime.tv_sec = (__s32)le32_to_cpu(pi->i_atime);
+	inode->i_ctime.tv_sec = (__s32)le32_to_cpu(pi->i_ctime);
+	inode->i_mtime.tv_sec = (__s32)le32_to_cpu(pi->i_mtime);
+	inode->i_atime.tv_nsec = inode->i_mtime.tv_nsec =
+					 inode->i_ctime.tv_nsec = 0;
+	set_nlink(inode, le16_to_cpu(pi->i_links_count));
+	return 0;
+
+bad_inode:
+	make_bad_inode(inode);
+	return ret;
+}
+
+/* Get the address in PMEM of an inode by inode number.  Allocate additional
+ * block to store additional inodes if necessary.
+ */
+int nova_get_inode_address(struct super_block *sb, u64 ino,
+	u64 *pi_addr, int extendable)
+{
+	if (ino < NOVA_NORMAL_INODE_START) {
+		*pi_addr = nova_get_reserved_inode_addr(sb, ino);
+		return 0;
+	}
+
+	*pi_addr = 0;
+	return 0;
+}
+
+struct inode *nova_iget(struct super_block *sb, unsigned long ino)
+{
+	struct nova_inode_info *si;
+	struct inode *inode;
+	u64 pi_addr;
+	int err;
+
+	inode = iget_locked(sb, ino);
+	if (unlikely(!inode))
+		return ERR_PTR(-ENOMEM);
+	if (!(inode->i_state & I_NEW))
+		return inode;
+
+	si = NOVA_I(inode);
+
+	nova_dbgv("%s: inode %lu\n", __func__, ino);
+
+	err = nova_get_inode_address(sb, ino, &pi_addr, 0);
+	if (err) {
+		nova_dbg("%s: get inode %lu address failed %d\n",
+			 __func__, ino, err);
+		goto fail;
+	}
+
+	if (pi_addr == 0) {
+		nova_dbg("%s: failed to get pi_addr for inode %lu\n",
+			 __func__, ino);
+		err = -EACCES;
+		goto fail;
+	}
+
+	err = nova_read_inode(sb, inode, pi_addr);
+	if (unlikely(err)) {
+		nova_dbg("%s: failed to read inode %lu\n", __func__, ino);
+		goto fail;
+
+	}
+
+	inode->i_ino = ino;
+
+	unlock_new_inode(inode);
+	return inode;
+fail:
+	iget_failed(inode);
+	return ERR_PTR(err);
+}
+
diff --git a/fs/nova/inode.h b/fs/nova/inode.h
index f9187e3..dbd5256 100644
--- a/fs/nova/inode.h
+++ b/fs/nova/inode.h
@@ -184,4 +184,7 @@ static inline int nova_persist_inode(struct nova_inode *pi)
 	return 0;
 }
 
+int nova_get_inode_address(struct super_block *sb, u64 ino,
+	u64 *pi_addr, int extendable);
+struct inode *nova_iget(struct super_block *sb, unsigned long ino);
 #endif
-- 
2.7.4
