Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756502AbeEHSla (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:41:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:53809 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754386AbeEHSEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:04:50 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 01/76] vfs: Introduce struct fs_view
Date: Tue,  8 May 2018 11:03:21 -0700
Message-Id: <20180508180436.716-2-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to de-couple some items from struct super_block, in particular those
that provide a 'fiew' into an fs.

Introduce a small struct, fs_view to contain these fields. This first patch
has a mostly empty fs_view. We do however, link it into the VFS:

Each super_block gets a default fs_view which is filled in via the
usual superblock intialization methods.

struct inode is updated to point to an fs_view structure via a new
'i_view' pointer, which replaces i_sb.

A filesystem can now optionally provide their own fs_view to point i_view
to.

So we don't lose our link from inode to superblock, fs_view gets
an embedded super_block pointer. A helper function, inode_sb() is
introduced to make getting the superblock from an inode less clunky.

Filesystems need no functional changes, and the only additional memory
usage here is the added pointer on struct super_block.

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/inode.c         |  2 +-
 fs/super.c         |  1 +
 include/linux/fs.h | 21 ++++++++++++++++++++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index ef362364d396..4f08fdc2c60f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -133,7 +133,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	static const struct file_operations no_open_fops = {.open = no_open};
 	struct address_space *const mapping = &inode->i_data;
 
-	inode->i_sb = sb;
+	inode->i_view = &sb->s_view;
 	inode->i_blkbits = sb->s_blocksize_bits;
 	inode->i_flags = 0;
 	atomic_set(&inode->i_count, 1);
diff --git a/fs/super.c b/fs/super.c
index 672538ca9831..5258a57d410a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -245,6 +245,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_op = &default_op;
 	s->s_time_gran = 1000000000;
 	s->cleancache_poolid = CLEANCACHE_NO_POOL;
+	s->s_view.v_sb = s;
 
 	s->s_shrink.seeks = DEFAULT_SEEKS;
 	s->s_shrink.scan_objects = super_cache_scan;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c6baf767619e..4561cb9156d4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -580,7 +580,7 @@ struct inode {
 #endif
 
 	const struct inode_operations	*i_op;
-	struct super_block	*i_sb;
+	struct fs_view		*i_view;
 	struct address_space	*i_mapping;
 
 #ifdef CONFIG_SECURITY
@@ -1340,6 +1340,24 @@ struct sb_writers {
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
 
+/*
+ * "View" into a filesystem. Allows us to abstract out those
+ * superblock fields which change between the roots on a given
+ * filesystem. Most filesystems can ignore this - inodes are pointed
+ * to the default view 's_view' during initialization.
+ *
+ * A file system with multiple roots should allocate a view structure
+ * per root and point each inodes view pointer to it in iget.
+ */
+struct fs_view {
+	struct super_block	*v_sb;
+};
+
+static inline struct super_block *inode_sb(const struct inode *inode)
+{
+	return inode->i_view->v_sb;
+}
+
 struct super_block {
 	struct list_head	s_list;		/* Keep this first */
 	dev_t			s_dev;		/* search index; _not_ kdev_t */
@@ -1358,6 +1376,7 @@ struct super_block {
 	struct rw_semaphore	s_umount;
 	int			s_count;
 	atomic_t		s_active;
+	struct fs_view		s_view;		/* default view into the fs */
 #ifdef CONFIG_SECURITY
 	void                    *s_security;
 #endif
-- 
2.15.1
