Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756477AbeEHSkm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:40:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:53823 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755356AbeEHSEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:04:55 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 04/76] fs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:24 -0700
Message-Id: <20180508180436.716-5-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/aio.c             |  6 ++--
 fs/attr.c            | 12 +++----
 fs/binfmt_misc.c     |  6 ++--
 fs/block_dev.c       |  2 +-
 fs/cachefiles/rdwr.c |  4 +--
 fs/dcache.c          |  8 ++---
 fs/direct-io.c       |  8 ++---
 fs/eventpoll.c       |  2 +-
 fs/fs-writeback.c    | 30 ++++++++--------
 fs/inode.c           | 96 +++++++++++++++++++++++++++-------------------------
 fs/ioctl.c           |  8 ++---
 fs/iomap.c           |  7 ++--
 fs/libfs.c           |  2 +-
 fs/locks.c           | 15 ++++----
 fs/namei.c           | 14 ++++----
 fs/namespace.c       |  6 ++--
 fs/open.c            |  6 ++--
 fs/pipe.c            |  6 ++--
 fs/posix_acl.c       |  2 +-
 fs/stat.c            |  2 +-
 fs/xattr.c           |  2 +-
 21 files changed, 125 insertions(+), 119 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 6bcd3fb5265a..bd2a187ca6d1 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1115,7 +1115,8 @@ static void aio_complete(struct kiocb *kiocb, long res, long res2)
 		 * thread.
 		 */
 		if (S_ISREG(file_inode(file)->i_mode))
-			__sb_writers_acquired(file_inode(file)->i_sb, SB_FREEZE_WRITE);
+			__sb_writers_acquired(inode_sb(file_inode(file)),
+					      SB_FREEZE_WRITE);
 		file_end_write(file);
 	}
 
@@ -1546,7 +1547,8 @@ static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
 		 * complain about held lock when we return to userspace.
 		 */
 		if (S_ISREG(file_inode(file)->i_mode))
-			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
+			__sb_writers_release(inode_sb(file_inode(file)),
+					     SB_FREEZE_WRITE);
 	}
 	kfree(iovec);
 	return ret;
diff --git a/fs/attr.c b/fs/attr.c
index 12ffdb6fb63c..456c082fe636 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -119,7 +119,7 @@ int inode_newsize_ok(const struct inode *inode, loff_t offset)
 		limit = rlimit(RLIMIT_FSIZE);
 		if (limit != RLIM_INFINITY && offset > limit)
 			goto out_sig;
-		if (offset > inode->i_sb->s_maxbytes)
+		if (offset > inode_sb(inode)->s_maxbytes)
 			goto out_big;
 	} else {
 		/*
@@ -164,13 +164,13 @@ void setattr_copy(struct inode *inode, const struct iattr *attr)
 		inode->i_gid = attr->ia_gid;
 	if (ia_valid & ATTR_ATIME)
 		inode->i_atime = timespec_trunc(attr->ia_atime,
-						inode->i_sb->s_time_gran);
+						inode_sb(inode)->s_time_gran);
 	if (ia_valid & ATTR_MTIME)
 		inode->i_mtime = timespec_trunc(attr->ia_mtime,
-						inode->i_sb->s_time_gran);
+						inode_sb(inode)->s_time_gran);
 	if (ia_valid & ATTR_CTIME)
 		inode->i_ctime = timespec_trunc(attr->ia_ctime,
-						inode->i_sb->s_time_gran);
+						inode_sb(inode)->s_time_gran);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 
@@ -288,10 +288,10 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	 * namespace of the superblock.
 	 */
 	if (ia_valid & ATTR_UID &&
-	    !kuid_has_mapping(inode->i_sb->s_user_ns, attr->ia_uid))
+	    !kuid_has_mapping(inode_sb(inode)->s_user_ns, attr->ia_uid))
 		return -EOVERFLOW;
 	if (ia_valid & ATTR_GID &&
-	    !kgid_has_mapping(inode->i_sb->s_user_ns, attr->ia_gid))
+	    !kgid_has_mapping(inode_sb(inode)->s_user_ns, attr->ia_gid))
 		return -EOVERFLOW;
 
 	/* Don't allow modifications of files with invalid uids or
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index a7c5a9861bef..c5f84bf4506b 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -657,7 +657,7 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 		break;
 	case 3:
 		/* Delete this handler. */
-		root = file_inode(file)->i_sb->s_root;
+		root = inode_sb(file_inode(file))->s_root;
 		inode_lock(d_inode(root));
 
 		if (!list_empty(&e->list))
@@ -685,7 +685,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 {
 	Node *e;
 	struct inode *inode;
-	struct super_block *sb = file_inode(file)->i_sb;
+	struct super_block *sb = inode_sb(file_inode(file));
 	struct dentry *root = sb->s_root, *dentry;
 	int err = 0;
 
@@ -786,7 +786,7 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 		break;
 	case 3:
 		/* Delete all handlers. */
-		root = file_inode(file)->i_sb->s_root;
+		root = inode_sb(file_inode(file))->s_root;
 		inode_lock(d_inode(root));
 
 		while (!list_empty(&entries))
diff --git a/fs/block_dev.c b/fs/block_dev.c
index fe09ef9c21f3..c9e00024b89d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -973,7 +973,7 @@ void bd_forget(struct inode *inode)
 	struct block_device *bdev = NULL;
 
 	spin_lock(&bdev_lock);
-	if (!sb_is_blkdev_sb(inode->i_sb))
+	if (!sb_is_blkdev_sb(inode_sb(inode)))
 		bdev = inode->i_bdev;
 	inode->i_bdev = NULL;
 	inode->i_mapping = &inode->i_data;
diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 883bc7bb12c5..807fabb9310b 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -413,7 +413,7 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
 	ASSERT(inode->i_mapping->a_ops->readpages);
 
 	/* calculate the shift required to use bmap */
-	shift = PAGE_SHIFT - inode->i_sb->s_blocksize_bits;
+	shift = PAGE_SHIFT - inode_sb(inode)->s_blocksize_bits;
 
 	op->op.flags &= FSCACHE_OP_KEEP_FLAGS;
 	op->op.flags |= FSCACHE_OP_ASYNC;
@@ -706,7 +706,7 @@ int cachefiles_read_or_alloc_pages(struct fscache_retrieval *op,
 	ASSERT(inode->i_mapping->a_ops->readpages);
 
 	/* calculate the shift required to use bmap */
-	shift = PAGE_SHIFT - inode->i_sb->s_blocksize_bits;
+	shift = PAGE_SHIFT - inode_sb(inode)->s_blocksize_bits;
 
 	pagevec_init(&pagevec);
 
diff --git a/fs/dcache.c b/fs/dcache.c
index 8945e6cabd93..98ac784e6045 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1897,7 +1897,7 @@ struct dentry *d_make_root(struct inode *root_inode)
 	struct dentry *res = NULL;
 
 	if (root_inode) {
-		res = d_alloc_anon(root_inode->i_sb);
+		res = d_alloc_anon(inode_sb(root_inode));
 		if (res)
 			d_instantiate(res, root_inode);
 		else
@@ -1996,7 +1996,7 @@ static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
 	if (res)
 		goto out_iput;
 
-	tmp = d_alloc_anon(inode->i_sb);
+	tmp = d_alloc_anon(inode_sb(inode));
 	if (!tmp) {
 		res = ERR_PTR(-ENOMEM);
 		goto out_iput;
@@ -3038,8 +3038,8 @@ struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 					"VFS: Lookup of '%s' in %s %s"
 					" would have caused loop\n",
 					dentry->d_name.name,
-					inode->i_sb->s_type->name,
-					inode->i_sb->s_id);
+					inode_sb(inode)->s_type->name,
+					inode_sb(inode)->s_id);
 			} else if (!IS_ROOT(new)) {
 				int err = __d_unalias(inode, dentry, new);
 				write_sequnlock(&rename_lock);
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 1357ef563893..1f3f224555d3 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -378,7 +378,7 @@ static void dio_bio_end_aio(struct bio *bio)
 					    dio->inode->i_mapping->nrpages);
 		if (defer_completion) {
 			INIT_WORK(&dio->complete_work, dio_aio_complete_work);
-			queue_work(dio->inode->i_sb->s_dio_done_wq,
+			queue_work(inode_sb(dio->inode)->s_dio_done_wq,
 				   &dio->complete_work);
 		} else {
 			dio_complete(dio, 0, DIO_COMPLETE_ASYNC);
@@ -638,7 +638,7 @@ int sb_init_dio_done_wq(struct super_block *sb)
 
 static int dio_set_defer_completion(struct dio *dio)
 {
-	struct super_block *sb = dio->inode->i_sb;
+	struct super_block *sb = inode_sb(dio->inode);
 
 	if (dio->defer_completion)
 		return 0;
@@ -1276,13 +1276,13 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 		retval = 0;
 		if (iocb->ki_flags & IOCB_DSYNC)
 			retval = dio_set_defer_completion(dio);
-		else if (!dio->inode->i_sb->s_dio_done_wq) {
+		else if (!inode_sb(dio->inode)->s_dio_done_wq) {
 			/*
 			 * In case of AIO write racing with buffered read we
 			 * need to defer completion. We can't decide this now,
 			 * however the workqueue needs to be initialized here.
 			 */
-			retval = sb_init_dio_done_wq(dio->inode->i_sb);
+			retval = sb_init_dio_done_wq(inode_sb(dio->inode));
 		}
 		if (retval) {
 			/*
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 0f3494ed3ed0..a7e3dbc83bbc 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -955,7 +955,7 @@ static void ep_show_fdinfo(struct seq_file *m, struct file *f)
 			   epi->ffd.fd, epi->event.events,
 			   (long long)epi->event.data,
 			   (long long)epi->ffd.file->f_pos,
-			   inode->i_ino, inode->i_sb->s_dev);
+			   inode->i_ino, inode_sb(inode)->s_dev);
 		if (seq_has_overflowed(m))
 			break;
 	}
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index d4d04fee568a..f8496f3651a1 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -490,7 +490,7 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 
 	/* while holding I_WB_SWITCH, no one else can update the association */
 	spin_lock(&inode->i_lock);
-	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
+	if (!(inode_sb(inode)->s_flags & SB_ACTIVE) ||
 	    inode->i_state & (I_WB_SWITCH | I_FREEING) ||
 	    inode_to_wb(inode) == isw->new_wb) {
 		spin_unlock(&inode->i_lock);
@@ -1002,7 +1002,7 @@ void inode_io_list_del(struct inode *inode)
  */
 void sb_mark_inode_writeback(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	unsigned long flags;
 
 	if (list_empty(&inode->i_wb_list)) {
@@ -1020,7 +1020,7 @@ void sb_mark_inode_writeback(struct inode *inode)
  */
 void sb_clear_inode_writeback(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	unsigned long flags;
 
 	if (!list_empty(&inode->i_wb_list)) {
@@ -1122,11 +1122,11 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 		moved++;
 		if (flags & EXPIRE_DIRTY_ATIME)
 			set_bit(__I_DIRTY_TIME_EXPIRED, &inode->i_state);
-		if (sb_is_blkdev_sb(inode->i_sb))
+		if (sb_is_blkdev_sb(inode_sb(inode)))
 			continue;
-		if (sb && sb != inode->i_sb)
+		if (sb && sb != inode_sb(inode))
 			do_sb_sort = 1;
-		sb = inode->i_sb;
+		sb = inode_sb(inode);
 	}
 
 	/* just one sb in list, splice to dispatch_queue and we're done */
@@ -1137,10 +1137,10 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 
 	/* Move inodes from one superblock together */
 	while (!list_empty(&tmp)) {
-		sb = wb_inode(tmp.prev)->i_sb;
+		sb = inode_sb(wb_inode(tmp.prev));
 		list_for_each_prev_safe(pos, node, &tmp) {
 			inode = wb_inode(pos);
-			if (inode->i_sb == sb)
+			if (inode_sb(inode) == sb)
 				list_move(&inode->i_io_list, dispatch_queue);
 		}
 	}
@@ -1177,9 +1177,9 @@ static int write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	int ret;
 
-	if (inode->i_sb->s_op->write_inode && !is_bad_inode(inode)) {
+	if (inode_sb(inode)->s_op->write_inode && !is_bad_inode(inode)) {
 		trace_writeback_write_inode_start(inode, wbc);
-		ret = inode->i_sb->s_op->write_inode(inode, wbc);
+		ret = inode_sb(inode)->s_op->write_inode(inode, wbc);
 		trace_writeback_write_inode(inode, wbc);
 		return ret;
 	}
@@ -1513,7 +1513,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		struct inode *inode = wb_inode(wb->b_io.prev);
 		struct bdi_writeback *tmp_wb;
 
-		if (inode->i_sb != sb) {
+		if (inode_sb(inode) != sb) {
 			if (work->sb) {
 				/*
 				 * We only want to write back data for this
@@ -1641,7 +1641,7 @@ static long __writeback_inodes_wb(struct bdi_writeback *wb,
 
 	while (!list_empty(&wb->b_io)) {
 		struct inode *inode = wb_inode(wb->b_io.prev);
-		struct super_block *sb = inode->i_sb;
+		struct super_block *sb = inode_sb(inode);
 
 		if (!trylock_super(sb)) {
 			/*
@@ -2064,7 +2064,7 @@ int dirtytime_interval_handler(struct ctl_table *table, int write,
 
 static noinline void block_dump___mark_inode_dirty(struct inode *inode)
 {
-	if (inode->i_ino || strcmp(inode->i_sb->s_id, "bdev")) {
+	if (inode->i_ino || strcmp(inode_sb(inode)->s_id, "bdev")) {
 		struct dentry *dentry;
 		const char *name = "?";
 
@@ -2076,7 +2076,7 @@ static noinline void block_dump___mark_inode_dirty(struct inode *inode)
 		printk(KERN_DEBUG
 		       "%s(%d): dirtied inode %lu (%s) on %s\n",
 		       current->comm, task_pid_nr(current), inode->i_ino,
-		       name, inode->i_sb->s_id);
+		       name, inode_sb(inode)->s_id);
 		if (dentry) {
 			spin_unlock(&dentry->d_lock);
 			dput(dentry);
@@ -2113,7 +2113,7 @@ static noinline void block_dump___mark_inode_dirty(struct inode *inode)
 void __mark_inode_dirty(struct inode *inode, int flags)
 {
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int dirtytime;
 
 	trace_writeback_mark_inode_dirty(inode, flags);
diff --git a/fs/inode.c b/fs/inode.c
index 4f08fdc2c60f..034b3528cd9d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -28,9 +28,9 @@
  * inode->i_lock protects:
  *   inode->i_state, inode->i_hash, __iget()
  * Inode LRU list locks protect:
- *   inode->i_sb->s_inode_lru, inode->i_lru
- * inode->i_sb->s_inode_list_lock protects:
- *   inode->i_sb->s_inodes, inode->i_sb_list
+ *   inode_sb(inode)->s_inode_lru, inode->i_lru
+ * inode_sb(inode)->s_inode_list_lock protects:
+ *   inode_sb(inode)->s_inodes, inode->i_sb_list
  * bdi->wb.list_lock protects:
  *   bdi->wb.b_{dirty,io,more_io,dirty_time}, inode->i_io_list
  * inode_hash_lock protects:
@@ -38,7 +38,7 @@
  *
  * Lock ordering:
  *
- * inode->i_sb->s_inode_list_lock
+ * inode_sb(inode)->s_inode_list_lock
  *   inode->i_lock
  *     Inode LRU list locks
  *
@@ -46,7 +46,7 @@
  *   inode->i_lock
  *
  * inode_hash_lock
- *   inode->i_sb->s_inode_list_lock
+ *   inode_sb(inode)->s_inode_list_lock
  *   inode->i_lock
  *
  * iunique_lock
@@ -214,10 +214,10 @@ static struct inode *alloc_inode(struct super_block *sb)
 		return NULL;
 
 	if (unlikely(inode_init_always(sb, inode))) {
-		if (inode->i_sb->s_op->destroy_inode)
-			inode->i_sb->s_op->destroy_inode(inode);
-		else
-			kmem_cache_free(inode_cachep, inode);
+		if (inode_sb(inode)->s_op->destroy_inode)
+			inode_sb(inode)->s_op->destroy_inode(inode);
+			else
+				kmem_cache_free(inode_cachep, inode);
 		return NULL;
 	}
 
@@ -238,8 +238,8 @@ void __destroy_inode(struct inode *inode)
 	fsnotify_inode_delete(inode);
 	locks_free_lock_context(inode);
 	if (!inode->i_nlink) {
-		WARN_ON(atomic_long_read(&inode->i_sb->s_remove_count) == 0);
-		atomic_long_dec(&inode->i_sb->s_remove_count);
+		WARN_ON(atomic_long_read(&inode_sb(inode)->s_remove_count) == 0);
+		atomic_long_dec(&inode_sb(inode)->s_remove_count);
 	}
 
 #ifdef CONFIG_FS_POSIX_ACL
@@ -262,10 +262,10 @@ static void destroy_inode(struct inode *inode)
 {
 	BUG_ON(!list_empty(&inode->i_lru));
 	__destroy_inode(inode);
-	if (inode->i_sb->s_op->destroy_inode)
-		inode->i_sb->s_op->destroy_inode(inode);
-	else
-		call_rcu(&inode->i_rcu, i_callback);
+	if (inode_sb(inode)->s_op->destroy_inode)
+		inode_sb(inode)->s_op->destroy_inode(inode);
+		else
+			call_rcu(&inode->i_rcu, i_callback);
 }
 
 /**
@@ -284,7 +284,7 @@ void drop_nlink(struct inode *inode)
 	WARN_ON(inode->i_nlink == 0);
 	inode->__i_nlink--;
 	if (!inode->i_nlink)
-		atomic_long_inc(&inode->i_sb->s_remove_count);
+		atomic_long_inc(&inode_sb(inode)->s_remove_count);
 }
 EXPORT_SYMBOL(drop_nlink);
 
@@ -300,7 +300,7 @@ void clear_nlink(struct inode *inode)
 {
 	if (inode->i_nlink) {
 		inode->__i_nlink = 0;
-		atomic_long_inc(&inode->i_sb->s_remove_count);
+		atomic_long_inc(&inode_sb(inode)->s_remove_count);
 	}
 }
 EXPORT_SYMBOL(clear_nlink);
@@ -320,7 +320,7 @@ void set_nlink(struct inode *inode, unsigned int nlink)
 	} else {
 		/* Yes, some filesystems do change nlink from zero to one */
 		if (inode->i_nlink == 0)
-			atomic_long_dec(&inode->i_sb->s_remove_count);
+			atomic_long_dec(&inode_sb(inode)->s_remove_count);
 
 		inode->__i_nlink = nlink;
 	}
@@ -339,7 +339,7 @@ void inc_nlink(struct inode *inode)
 {
 	if (unlikely(inode->i_nlink == 0)) {
 		WARN_ON(!(inode->i_state & I_LINKABLE));
-		atomic_long_dec(&inode->i_sb->s_remove_count);
+		atomic_long_dec(&inode_sb(inode)->s_remove_count);
 	}
 
 	inode->__i_nlink++;
@@ -402,7 +402,7 @@ EXPORT_SYMBOL(ihold);
 
 static void inode_lru_list_add(struct inode *inode)
 {
-	if (list_lru_add(&inode->i_sb->s_inode_lru, &inode->i_lru))
+	if (list_lru_add(&inode_sb(inode)->s_inode_lru, &inode->i_lru))
 		this_cpu_inc(nr_unused);
 	else
 		inode->i_state |= I_REFERENCED;
@@ -417,7 +417,7 @@ void inode_add_lru(struct inode *inode)
 {
 	if (!(inode->i_state & (I_DIRTY_ALL | I_SYNC |
 				I_FREEING | I_WILL_FREE)) &&
-	    !atomic_read(&inode->i_count) && inode->i_sb->s_flags & SB_ACTIVE)
+	    !atomic_read(&inode->i_count) && inode_sb(inode)->s_flags & SB_ACTIVE)
 		inode_lru_list_add(inode);
 }
 
@@ -425,7 +425,7 @@ void inode_add_lru(struct inode *inode)
 static void inode_lru_list_del(struct inode *inode)
 {
 
-	if (list_lru_del(&inode->i_sb->s_inode_lru, &inode->i_lru))
+	if (list_lru_del(&inode_sb(inode)->s_inode_lru, &inode->i_lru))
 		this_cpu_dec(nr_unused);
 }
 
@@ -435,18 +435,18 @@ static void inode_lru_list_del(struct inode *inode)
  */
 void inode_sb_list_add(struct inode *inode)
 {
-	spin_lock(&inode->i_sb->s_inode_list_lock);
-	list_add(&inode->i_sb_list, &inode->i_sb->s_inodes);
-	spin_unlock(&inode->i_sb->s_inode_list_lock);
+	spin_lock(&inode_sb(inode)->s_inode_list_lock);
+	list_add(&inode->i_sb_list, &inode_sb(inode)->s_inodes);
+	spin_unlock(&inode_sb(inode)->s_inode_list_lock);
 }
 EXPORT_SYMBOL_GPL(inode_sb_list_add);
 
 static inline void inode_sb_list_del(struct inode *inode)
 {
 	if (!list_empty(&inode->i_sb_list)) {
-		spin_lock(&inode->i_sb->s_inode_list_lock);
+		spin_lock(&inode_sb(inode)->s_inode_list_lock);
 		list_del_init(&inode->i_sb_list);
-		spin_unlock(&inode->i_sb->s_inode_list_lock);
+		spin_unlock(&inode_sb(inode)->s_inode_list_lock);
 	}
 }
 
@@ -470,7 +470,8 @@ static unsigned long hash(struct super_block *sb, unsigned long hashval)
  */
 void __insert_inode_hash(struct inode *inode, unsigned long hashval)
 {
-	struct hlist_head *b = inode_hashtable + hash(inode->i_sb, hashval);
+	struct hlist_head *b = inode_hashtable + hash(inode_sb(inode),
+						      hashval);
 
 	spin_lock(&inode_hash_lock);
 	spin_lock(&inode->i_lock);
@@ -531,7 +532,7 @@ EXPORT_SYMBOL(clear_inode);
  */
 static void evict(struct inode *inode)
 {
-	const struct super_operations *op = inode->i_sb->s_op;
+	const struct super_operations *op = inode_sb(inode)->s_op;
 
 	BUG_ON(!(inode->i_state & I_FREEING));
 	BUG_ON(!list_empty(&inode->i_lru));
@@ -790,7 +791,7 @@ static struct inode *find_inode(struct super_block *sb,
 
 repeat:
 	hlist_for_each_entry(inode, head, i_hash) {
-		if (inode->i_sb != sb)
+		if (inode_sb(inode) != sb)
 			continue;
 		if (!test(inode, data))
 			continue;
@@ -819,7 +820,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
 	hlist_for_each_entry(inode, head, i_hash) {
 		if (inode->i_ino != ino)
 			continue;
-		if (inode->i_sb != sb)
+		if (inode_sb(inode) != sb)
 			continue;
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
@@ -927,7 +928,7 @@ EXPORT_SYMBOL(new_inode);
 void lockdep_annotate_inode_mutex_key(struct inode *inode)
 {
 	if (S_ISDIR(inode->i_mode)) {
-		struct file_system_type *type = inode->i_sb->s_type;
+		struct file_system_type *type = inode_sb(inode)->s_type;
 
 		/* Set new key only if filesystem hasn't already changed it */
 		if (lockdep_match_class(&inode->i_rwsem, &type->i_mutex_key)) {
@@ -1169,7 +1170,7 @@ static int test_inode_iunique(struct super_block *sb, unsigned long ino)
 
 	spin_lock(&inode_hash_lock);
 	hlist_for_each_entry(inode, b, i_hash) {
-		if (inode->i_ino == ino && inode->i_sb == sb) {
+		if (inode->i_ino == ino && inode_sb(inode) == sb) {
 			spin_unlock(&inode_hash_lock);
 			return 0;
 		}
@@ -1362,7 +1363,7 @@ struct inode *find_inode_nowait(struct super_block *sb,
 
 	spin_lock(&inode_hash_lock);
 	hlist_for_each_entry(inode, head, i_hash) {
-		if (inode->i_sb != sb)
+		if (inode_sb(inode) != sb)
 			continue;
 		mval = match(inode, hashval, data);
 		if (mval == 0)
@@ -1379,7 +1380,7 @@ EXPORT_SYMBOL(find_inode_nowait);
 
 int insert_inode_locked(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	ino_t ino = inode->i_ino;
 	struct hlist_head *head = inode_hashtable + hash(sb, ino);
 
@@ -1389,7 +1390,7 @@ int insert_inode_locked(struct inode *inode)
 		hlist_for_each_entry(old, head, i_hash) {
 			if (old->i_ino != ino)
 				continue;
-			if (old->i_sb != sb)
+			if (inode_sb(old) != sb)
 				continue;
 			spin_lock(&old->i_lock);
 			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
@@ -1422,7 +1423,7 @@ EXPORT_SYMBOL(insert_inode_locked);
 int insert_inode_locked4(struct inode *inode, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
 
 	while (1) {
@@ -1430,7 +1431,7 @@ int insert_inode_locked4(struct inode *inode, unsigned long hashval,
 
 		spin_lock(&inode_hash_lock);
 		hlist_for_each_entry(old, head, i_hash) {
-			if (old->i_sb != sb)
+			if (inode_sb(old) != sb)
 				continue;
 			if (!test(old, data))
 				continue;
@@ -1481,8 +1482,8 @@ EXPORT_SYMBOL(generic_delete_inode);
  */
 static void iput_final(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
-	const struct super_operations *op = inode->i_sb->s_op;
+	struct super_block *sb = inode_sb(inode);
+	const struct super_operations *op = inode_sb(inode)->s_op;
 	int drop;
 
 	WARN_ON(inode->i_state & I_NEW);
@@ -1645,7 +1646,7 @@ int generic_update_time(struct inode *inode, struct timespec *time, int flags)
 	if (flags & S_MTIME)
 		inode->i_mtime = *time;
 	if ((flags & (S_ATIME | S_CTIME | S_MTIME)) &&
-	    !(inode->i_sb->s_flags & SB_LAZYTIME))
+	    !(inode_sb(inode)->s_flags & SB_LAZYTIME))
 		dirty = true;
 
 	if (dirty)
@@ -1695,7 +1696,7 @@ bool __atime_needs_update(const struct path *path, struct inode *inode,
 
 	if (IS_NOATIME(inode))
 		return false;
-	if ((inode->i_sb->s_flags & SB_NODIRATIME) && S_ISDIR(inode->i_mode))
+	if ((inode_sb(inode)->s_flags & SB_NODIRATIME) && S_ISDIR(inode->i_mode))
 		return false;
 
 	if (mnt->mnt_flags & MNT_NOATIME)
@@ -1723,7 +1724,7 @@ void touch_atime(const struct path *path)
 	if (!__atime_needs_update(path, inode, false))
 		return;
 
-	if (!sb_start_write_trylock(inode->i_sb))
+	if (!sb_start_write_trylock(inode_sb(inode)))
 		return;
 
 	if (__mnt_want_write(mnt) != 0)
@@ -1741,7 +1742,7 @@ void touch_atime(const struct path *path)
 	update_time(inode, &now, S_ATIME);
 	__mnt_drop_write(mnt);
 skip_update:
-	sb_end_write(inode->i_sb);
+	sb_end_write(inode_sb(inode));
 }
 EXPORT_SYMBOL(touch_atime);
 
@@ -1992,7 +1993,8 @@ void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)
 		;	/* leave it no_open_fops */
 	else
 		printk(KERN_DEBUG "init_special_inode: bogus i_mode (%o) for"
-				  " inode %s:%lu\n", mode, inode->i_sb->s_id,
+				  " inode %s:%lu\n", mode,
+				  inode_sb(inode)->s_id,
 				  inode->i_ino);
 }
 EXPORT_SYMBOL(init_special_inode);
@@ -2121,11 +2123,11 @@ struct timespec current_time(struct inode *inode)
 {
 	struct timespec now = current_kernel_time();
 
-	if (unlikely(!inode->i_sb)) {
+	if (unlikely(!inode_sb(inode))) {
 		WARN(1, "current_time() called with uninitialized super_block in the inode");
 		return now;
 	}
 
-	return timespec_trunc(now, inode->i_sb->s_time_gran);
+	return timespec_trunc(now, inode_sb(inode)->s_time_gran);
 }
 EXPORT_SYMBOL(current_time);
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 5ace7efb0d04..37990af8e3ad 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -179,7 +179,7 @@ static int ioctl_fiemap(struct file *filp, unsigned long arg)
 	struct fiemap __user *ufiemap = (struct fiemap __user *) arg;
 	struct fiemap_extent_info fieinfo = { 0, };
 	struct inode *inode = file_inode(filp);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	u64 len;
 	int error;
 
@@ -547,7 +547,7 @@ static int ioctl_fioasync(unsigned int fd, struct file *filp,
 
 static int ioctl_fsfreeze(struct file *filp)
 {
-	struct super_block *sb = file_inode(filp)->i_sb;
+	struct super_block *sb = inode_sb(file_inode(filp));
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -564,7 +564,7 @@ static int ioctl_fsfreeze(struct file *filp)
 
 static int ioctl_fsthaw(struct file *filp)
 {
-	struct super_block *sb = file_inode(filp)->i_sb;
+	struct super_block *sb = inode_sb(file_inode(filp));
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -668,7 +668,7 @@ int do_vfs_ioctl(struct file *filp, unsigned int fd, unsigned int cmd,
 		return ioctl_fiemap(filp, arg);
 
 	case FIGETBSZ:
-		return put_user(inode->i_sb->s_blocksize, argp);
+		return put_user(inode_sb(inode)->s_blocksize, argp);
 
 	case FICLONE:
 		return ioctl_file_clone(filp, arg, 0, 0, 0);
diff --git a/fs/iomap.c b/fs/iomap.c
index afd163586aa0..2c6a327f0223 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -806,7 +806,8 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 			struct inode *inode = file_inode(dio->iocb->ki_filp);
 
 			INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
-			queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
+			queue_work(inode_sb(inode)->s_dio_done_wq,
+				   &dio->aio.work);
 		} else {
 			iomap_dio_complete_work(&dio->aio.work);
 		}
@@ -1034,8 +1035,8 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	ret = 0;
 
 	if (iov_iter_rw(iter) == WRITE && !is_sync_kiocb(iocb) &&
-	    !inode->i_sb->s_dio_done_wq) {
-		ret = sb_init_dio_done_wq(inode->i_sb);
+	    !inode_sb(inode)->s_dio_done_wq) {
+		ret = sb_init_dio_done_wq(inode_sb(inode));
 		if (ret < 0)
 			goto out_free_dio;
 	}
diff --git a/fs/libfs.c b/fs/libfs.c
index 7ff3cb904acd..775eb447a68b 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1018,7 +1018,7 @@ int generic_file_fsync(struct file *file, loff_t start, loff_t end,
 	err = __generic_file_fsync(file, start, end, datasync);
 	if (err)
 		return err;
-	return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+	return blkdev_issue_flush(inode_sb(inode)->s_bdev, GFP_KERNEL, NULL);
 }
 EXPORT_SYMBOL(generic_file_fsync);
 
diff --git a/fs/locks.c b/fs/locks.c
index d6ff4beb70ce..2a86a18c0523 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -263,7 +263,8 @@ locks_check_ctx_lists(struct inode *inode)
 		     !list_empty(&ctx->flc_posix) ||
 		     !list_empty(&ctx->flc_lease))) {
 		pr_warn("Leaked locks on dev=0x%x:0x%x ino=0x%lx:\n",
-			MAJOR(inode->i_sb->s_dev), MINOR(inode->i_sb->s_dev),
+			MAJOR(inode_sb(inode)->s_dev),
+			MINOR(inode_sb(inode)->s_dev),
 			inode->i_ino);
 		locks_dump_ctx_list(&ctx->flc_flock, "FLOCK");
 		locks_dump_ctx_list(&ctx->flc_posix, "POSIX");
@@ -282,8 +283,8 @@ locks_check_ctx_file_list(struct file *filp, struct list_head *list,
 		if (fl->fl_file == filp)
 			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%lx "
 				" fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
-				list_type, MAJOR(inode->i_sb->s_dev),
-				MINOR(inode->i_sb->s_dev), inode->i_ino,
+				list_type, MAJOR(inode_sb(inode)->s_dev),
+				MINOR(inode_sb(inode)->s_dev), inode->i_ino,
 				fl->fl_owner, fl->fl_flags, fl->fl_type, fl->fl_pid);
 }
 
@@ -2622,7 +2623,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 {
 	struct inode *inode = NULL;
 	unsigned int fl_pid;
-	struct pid_namespace *proc_pidns = file_inode(f->file)->i_sb->s_fs_info;
+	struct pid_namespace *proc_pidns = inode_sb(file_inode(f->file))->s_fs_info;
 
 	fl_pid = locks_translate_pid(fl, proc_pidns);
 	/*
@@ -2683,8 +2684,8 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	if (inode) {
 		/* userspace relies on this representation of dev_t */
 		seq_printf(f, "%d %02x:%02x:%ld ", fl_pid,
-				MAJOR(inode->i_sb->s_dev),
-				MINOR(inode->i_sb->s_dev), inode->i_ino);
+				MAJOR(inode_sb(inode)->s_dev),
+				MINOR(inode_sb(inode)->s_dev), inode->i_ino);
 	} else {
 		seq_printf(f, "%d <none>:0 ", fl_pid);
 	}
@@ -2702,7 +2703,7 @@ static int locks_show(struct seq_file *f, void *v)
 {
 	struct locks_iterator *iter = f->private;
 	struct file_lock *fl, *bfl;
-	struct pid_namespace *proc_pidns = file_inode(f->file)->i_sb->s_fs_info;
+	struct pid_namespace *proc_pidns = inode_sb(file_inode(f->file))->s_fs_info;
 
 	fl = hlist_entry(v, struct file_lock, fl_link);
 
diff --git a/fs/namei.c b/fs/namei.c
index cafa365eeb70..03ba6b32aeb7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -425,7 +425,7 @@ int inode_permission(struct inode *inode, int mask)
 {
 	int retval;
 
-	retval = sb_permission(inode->i_sb, inode, mask);
+	retval = sb_permission(inode_sb(inode), inode, mask);
 	if (retval)
 		return retval;
 
@@ -2805,7 +2805,7 @@ static inline int may_create(struct inode *dir, struct dentry *child)
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
-	s_user_ns = dir->i_sb->s_user_ns;
+	s_user_ns = inode_sb(dir)->s_user_ns;
 	if (!kuid_has_mapping(s_user_ns, current_fsuid()) ||
 	    !kgid_has_mapping(s_user_ns, current_fsgid()))
 		return -EOVERFLOW;
@@ -3781,7 +3781,7 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 int vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	int error = may_create(dir, dentry);
-	unsigned max_links = dir->i_sb->s_max_links;
+	unsigned max_links = inode_sb(dir)->s_max_links;
 
 	if (error)
 		return error;
@@ -4167,7 +4167,7 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
 int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_dentry, struct inode **delegated_inode)
 {
 	struct inode *inode = old_dentry->d_inode;
-	unsigned max_links = dir->i_sb->s_max_links;
+	unsigned max_links = inode_sb(dir)->s_max_links;
 	int error;
 
 	if (!inode)
@@ -4177,7 +4177,7 @@ int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_de
 	if (error)
 		return error;
 
-	if (dir->i_sb != inode->i_sb)
+	if (inode_sb(dir) != inode_sb(inode))
 		return -EXDEV;
 
 	/*
@@ -4363,7 +4363,7 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct inode *source = old_dentry->d_inode;
 	struct inode *target = new_dentry->d_inode;
 	bool new_is_dir = false;
-	unsigned max_links = new_dir->i_sb->s_max_links;
+	unsigned max_links = inode_sb(new_dir)->s_max_links;
 	struct name_snapshot old_name;
 
 	if (source == target)
@@ -4453,7 +4453,7 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		dont_mount(new_dentry);
 		detach_mounts(new_dentry);
 	}
-	if (!(old_dir->i_sb->s_type->fs_flags & FS_RENAME_DOES_D_MOVE)) {
+	if (!(inode_sb(old_dir)->s_type->fs_flags & FS_RENAME_DOES_D_MOVE)) {
 		if (!(flags & RENAME_EXCHANGE))
 			d_move(old_dentry, new_dentry);
 		else
diff --git a/fs/namespace.c b/fs/namespace.c
index 9d1374ab6e06..e26da6ef673e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -494,10 +494,10 @@ int mnt_want_write_file(struct file *file)
 
 	ret = may_write_real(file);
 	if (!ret) {
-		sb_start_write(file_inode(file)->i_sb);
+		sb_start_write(inode_sb(file_inode(file)));
 		ret = __mnt_want_write_file(file);
 		if (ret)
-			sb_end_write(file_inode(file)->i_sb);
+			sb_end_write(inode_sb(file_inode(file)));
 	}
 	return ret;
 }
@@ -546,7 +546,7 @@ void mnt_drop_write_file_path(struct file *file)
 void mnt_drop_write_file(struct file *file)
 {
 	__mnt_drop_write(file->f_path.mnt);
-	sb_end_write(file_inode(file)->i_sb);
+	sb_end_write(inode_sb(file_inode(file)));
 }
 EXPORT_SYMBOL(mnt_drop_write_file);
 
diff --git a/fs/open.c b/fs/open.c
index 7ea118471dce..a24e3564050a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -197,13 +197,13 @@ static long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 	if (IS_APPEND(file_inode(f.file)))
 		goto out_putf;
 
-	sb_start_write(inode->i_sb);
+	sb_start_write(inode_sb(inode));
 	error = locks_verify_truncate(inode, f.file, length);
 	if (!error)
 		error = security_path_truncate(&f.file->f_path);
 	if (!error)
 		error = do_truncate(dentry, length, ATTR_MTIME|ATTR_CTIME, f.file);
-	sb_end_write(inode->i_sb);
+	sb_end_write(inode_sb(inode));
 out_putf:
 	fdput(f);
 out:
@@ -309,7 +309,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		return -ENODEV;
 
 	/* Check for wrap through zero too */
-	if (((offset + len) > inode->i_sb->s_maxbytes) || ((offset + len) < 0))
+	if (((offset + len) > inode_sb(inode)->s_maxbytes) || ((offset + len) < 0))
 		return -EFBIG;
 
 	if (!file->f_op->fallocate)
diff --git a/fs/pipe.c b/fs/pipe.c
index 7b1954caf388..f8fd756cc817 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -477,11 +477,11 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		wake_up_interruptible_sync_poll(&pipe->wait, EPOLLIN | EPOLLRDNORM);
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 	}
-	if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb)) {
+	if (ret > 0 && sb_start_write_trylock(inode_sb(file_inode(filp)))) {
 		int err = file_update_time(filp);
 		if (err)
 			ret = err;
-		sb_end_write(file_inode(filp)->i_sb);
+		sb_end_write(inode_sb(file_inode(filp)));
 	}
 	return ret;
 }
@@ -888,7 +888,7 @@ static void wake_up_partner(struct pipe_inode_info *pipe)
 static int fifo_open(struct inode *inode, struct file *filp)
 {
 	struct pipe_inode_info *pipe;
-	bool is_pipe = inode->i_sb->s_magic == PIPEFS_MAGIC;
+	bool is_pipe = inode_sb(inode)->s_magic == PIPEFS_MAGIC;
 	int ret;
 
 	filp->f_version = 0;
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 2fd0fde16fe1..cf485df47d36 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -867,7 +867,7 @@ set_posix_acl(struct inode *inode, int type, struct posix_acl *acl)
 		return -EPERM;
 
 	if (acl) {
-		int ret = posix_acl_valid(inode->i_sb->s_user_ns, acl);
+		int ret = posix_acl_valid(inode_sb(inode)->s_user_ns, acl);
 		if (ret)
 			return ret;
 	}
diff --git a/fs/stat.c b/fs/stat.c
index 873785dae022..178b81d4359e 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -32,7 +32,7 @@
  */
 void generic_fillattr(struct inode *inode, struct kstat *stat)
 {
-	stat->dev = inode->i_sb->s_dev;
+	stat->dev = inode_sb(inode)->s_dev;
 	stat->ino = inode->i_ino;
 	stat->mode = inode->i_mode;
 	stat->nlink = inode->i_nlink;
diff --git a/fs/xattr.c b/fs/xattr.c
index 61cd28ba25f3..ac81607672ee 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -53,7 +53,7 @@ strcmp_prefix(const char *a, const char *a_prefix)
 static const struct xattr_handler *
 xattr_resolve_name(struct inode *inode, const char **name)
 {
-	const struct xattr_handler **handlers = inode->i_sb->s_xattr;
+	const struct xattr_handler **handlers = inode_sb(inode)->s_xattr;
 	const struct xattr_handler *handler;
 
 	if (!(inode->i_opflags & IOP_XATTR)) {
-- 
2.15.1
