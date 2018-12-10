Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D484C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B8D20851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B8D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbeLJRR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:17:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbeLJRNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30A4030024E0;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA2F45C7B4;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6E9F8224265; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 26/52] fuse: Implement basic DAX read/write support commands
Date:   Mon, 10 Dec 2018 12:12:52 -0500
Message-Id: <20181210171318.16998-27-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

This patch implements basic DAX support. mmap() is not implemented
yet and will come in later patches. This patch looks into implemeting
read/write.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c            | 400 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          |   6 +
 fs/fuse/inode.c           |   6 +
 include/uapi/linux/fuse.h |   1 +
 4 files changed, 413 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b52f9baaa3e7..449a6b315327 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -18,9 +18,16 @@
 #include <linux/swap.h>
 #include <linux/falloc.h>
 #include <linux/uio.h>
+#include <linux/dax.h>
+#include <linux/iomap.h>
+#include <linux/interval_tree_generic.h>
 
 static const struct file_operations fuse_direct_io_file_operations;
 
+INTERVAL_TREE_DEFINE(struct fuse_dax_mapping,
+                     rb, __u64, __subtree_last,
+                     START, LAST, static inline, fuse_dax_interval_tree);
+
 static int fuse_send_open(struct fuse_conn *fc, u64 nodeid, struct file *file,
 			  int opcode, struct fuse_open_out *outargp)
 {
@@ -172,6 +179,171 @@ static void fuse_link_write_file(struct file *file)
 	spin_unlock(&fc->lock);
 }
 
+static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
+{
+	struct fuse_dax_mapping *dmap = NULL;
+
+	spin_lock(&fc->lock);
+
+	/* TODO: Add logic to try to free up memory if wait is allowed */
+	if (fc->nr_free_ranges <= 0) {
+		spin_unlock(&fc->lock);
+		return NULL;
+	}
+
+	WARN_ON(list_empty(&fc->free_ranges));
+
+	/* Take a free range */
+	dmap = list_first_entry(&fc->free_ranges, struct fuse_dax_mapping,
+					list);
+	list_del_init(&dmap->list);
+	fc->nr_free_ranges--;
+	spin_unlock(&fc->lock);
+	return dmap;
+}
+
+/* This assumes fc->lock is held */
+static void __free_dax_mapping(struct fuse_conn *fc,
+				struct fuse_dax_mapping *dmap)
+{
+	list_add_tail(&dmap->list, &fc->free_ranges);
+	fc->nr_free_ranges++;
+}
+
+static void free_dax_mapping(struct fuse_conn *fc,
+				struct fuse_dax_mapping *dmap)
+{
+	/* Return fuse_dax_mapping to free list */
+	spin_lock(&fc->lock);
+	__free_dax_mapping(fc, dmap);
+	spin_unlock(&fc->lock);
+}
+
+/* offset passed in should be aligned to FUSE_DAX_MEM_RANGE_SZ */
+static int fuse_setup_one_mapping(struct inode *inode,
+				struct file *file, loff_t offset,
+				struct fuse_dax_mapping *dmap)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_file *ff = NULL;
+	struct fuse_setupmapping_in inarg;
+	FUSE_ARGS(args);
+	ssize_t err;
+
+	if (file)
+		ff = file->private_data;
+
+	WARN_ON(offset % FUSE_DAX_MEM_RANGE_SZ);
+	WARN_ON(fc->nr_free_ranges < 0);
+
+	/* Ask fuse daemon to setup mapping */
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.foffset = offset;
+	if (ff)
+		inarg.fh = ff->fh;
+	else
+		inarg.fh = -1;
+	inarg.moffset = dmap->window_offset;
+	inarg.len = FUSE_DAX_MEM_RANGE_SZ;
+	if (file) {
+		inarg.flags |= (file->f_mode & FMODE_WRITE) ?
+				FUSE_SETUPMAPPING_FLAG_WRITE : 0;
+		inarg.flags |= (file->f_mode & FMODE_READ) ?
+				FUSE_SETUPMAPPING_FLAG_READ : 0;
+	} else {
+		inarg.flags |= FUSE_SETUPMAPPING_FLAG_READ;
+		inarg.flags |= FUSE_SETUPMAPPING_FLAG_WRITE;
+	}
+	args.in.h.opcode = FUSE_SETUPMAPPING;
+	args.in.h.nodeid = fi->nodeid;
+	args.in.numargs = 1;
+	args.in.args[0].size = sizeof(inarg);
+	args.in.args[0].value = &inarg;
+	err = fuse_simple_request(fc, &args);
+	if (err < 0) {
+		printk(KERN_ERR "%s request failed at mem_offset=0x%llx %zd\n",
+				 __func__, dmap->window_offset, err);
+		return err;
+	}
+
+	pr_debug("fuse_setup_one_mapping() succeeded. offset=0x%llx err=%zd\n", offset, err);
+
+	/* TODO: What locking is required here. For now, using fc->lock */
+	dmap->start = offset;
+	dmap->end = offset + FUSE_DAX_MEM_RANGE_SZ - 1;
+	/* Protected by fi->i_dmap_sem */
+	fuse_dax_interval_tree_insert(dmap, &fi->dmap_tree);
+	fi->nr_dmaps++;
+	return 0;
+}
+
+static int fuse_removemapping_one(struct inode *inode,
+					struct fuse_dax_mapping *dmap)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_removemapping_in inarg;
+	FUSE_ARGS(args);
+	ssize_t err = 0;
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.moffset = dmap->window_offset;
+	inarg.len = dmap->length;
+	args.in.h.opcode = FUSE_REMOVEMAPPING;
+	args.in.h.nodeid = fi->nodeid;
+	args.in.numargs = 1;
+	args.in.args[0].size = sizeof(inarg);
+	args.in.args[0].value = &inarg;
+	err = fuse_simple_request(fc, &args);
+	if (err < 0) {
+		printk(KERN_ERR "%s request failed %zd\n", __func__, err);
+		return err;
+	}
+	pr_debug("%s request succeeded\n", __func__);
+	return 0;
+}
+
+void fuse_removemapping(struct inode *inode)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	ssize_t err;
+	struct fuse_dax_mapping *dmap;
+
+	down_write(&fi->i_dmap_sem);
+
+	/* Clear the mappings list */
+	while (true) {
+		WARN_ON(fi->nr_dmaps < 0);
+
+		dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, 0,
+								-1);
+		if (dmap) {
+			fuse_dax_interval_tree_remove(dmap, &fi->dmap_tree);
+			fi->nr_dmaps--;
+		}
+
+		if (!dmap)
+			break;
+
+		err = fuse_removemapping_one(inode, dmap);
+		if (err) {
+			/* TODO: Add it back to tree. */
+			printk("Failed to removemapping. offset=0x%llx"
+				" len=0x%llx\n", dmap->window_offset,
+				dmap->length);
+			continue;
+		}
+
+		/* Add it back to free ranges list */
+		free_dax_mapping(fc, dmap);
+	}
+
+	up_write(&fi->i_dmap_sem);
+	pr_debug("%s request succeeded\n", __func__);
+}
+
 void fuse_finish_open(struct inode *inode, struct file *file)
 {
 	struct fuse_file *ff = file->private_data;
@@ -1452,6 +1624,204 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return res;
 }
 
+static void fuse_fill_iomap_hole(struct iomap *iomap, loff_t length)
+{
+	iomap->addr = IOMAP_NULL_ADDR;
+	iomap->length = length;
+	iomap->type = IOMAP_HOLE;
+}
+
+static void fuse_fill_iomap(struct inode *inode, loff_t pos, loff_t length,
+			struct iomap *iomap, struct fuse_dax_mapping *dmap,
+			unsigned flags)
+{
+	loff_t offset, len;
+	loff_t i_size = i_size_read(inode);
+
+	offset = pos - dmap->start;
+	len = min(length, dmap->length - offset);
+
+	/* If length is beyond end of file, truncate further */
+	if (pos + len > i_size)
+		len = i_size - pos;
+
+	if (len > 0) {
+		iomap->addr = dmap->window_offset + offset;
+		iomap->length = len;
+		if (flags & IOMAP_FAULT)
+			iomap->length = ALIGN(len, PAGE_SIZE);
+		iomap->type = IOMAP_MAPPED;
+		pr_debug("%s: returns iomap: addr 0x%llx offset 0x%llx"
+				" length 0x%llx\n", __func__, iomap->addr,
+				iomap->offset, iomap->length);
+	} else {
+		/* Mapping beyond end of file is hole */
+		fuse_fill_iomap_hole(iomap, length);
+		pr_debug("%s: returns iomap: addr 0x%llx offset 0x%llx"
+				"length 0x%llx\n", __func__, iomap->addr,
+				iomap->offset, iomap->length);
+	}
+}
+
+/* This is just for DAX and the mapping is ephemeral, do not use it for other
+ * purposes since there is no block device with a permanent mapping.
+ */
+static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
+			    unsigned flags, struct iomap *iomap)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_dax_mapping *dmap, *alloc_dmap = NULL;
+	int ret;
+
+	/* We don't support FIEMAP */
+	BUG_ON(flags & IOMAP_REPORT);
+
+	pr_debug("fuse_iomap_begin() called. pos=0x%llx length=0x%llx\n",
+			pos, length);
+
+	iomap->offset = pos;
+	iomap->flags = 0;
+	iomap->bdev = NULL;
+	iomap->dax_dev = fc->dax_dev;
+
+	/*
+	 * Both read/write and mmap path can race here. So we need something
+	 * to make sure if we are setting up mapping, then other path waits
+	 *
+	 * For now, use a semaphore for this. It probably needs to be
+	 * optimized later.
+	 */
+	down_read(&fi->i_dmap_sem);
+	dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos, pos);
+
+	if (dmap) {
+		fuse_fill_iomap(inode, pos, length, iomap, dmap, flags);
+		up_read(&fi->i_dmap_sem);
+		return 0;
+	} else {
+		up_read(&fi->i_dmap_sem);
+		pr_debug("%s: no mapping at offset 0x%llx length 0x%llx\n",
+				__func__, pos, length);
+		if (pos >= i_size_read(inode))
+			goto iomap_hole;
+
+		alloc_dmap = alloc_dax_mapping(fc);
+		if (!alloc_dmap)
+			return -EBUSY;
+
+		/*
+		 * Drop read lock and take write lock so that only one
+		 * caller can try to setup mapping and other waits
+		 */
+		down_write(&fi->i_dmap_sem);
+		/*
+		 * We dropped lock. Check again if somebody else setup
+		 * mapping already.
+		 */
+		dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos,
+							pos);
+		if (dmap) {
+			fuse_fill_iomap(inode, pos, length, iomap, dmap, flags);
+			free_dax_mapping(fc, alloc_dmap);
+			up_write(&fi->i_dmap_sem);
+			return 0;
+		}
+
+		/* Setup one mapping */
+		ret = fuse_setup_one_mapping(inode, NULL,
+				ALIGN_DOWN(pos, FUSE_DAX_MEM_RANGE_SZ),
+				alloc_dmap);
+		if (ret < 0) {
+			printk("fuse_setup_one_mapping() failed. err=%d"
+				" pos=0x%llx\n", ret, pos);
+			free_dax_mapping(fc, alloc_dmap);
+			up_write(&fi->i_dmap_sem);
+			return ret;
+		}
+		fuse_fill_iomap(inode, pos, length, iomap, alloc_dmap, flags);
+		up_write(&fi->i_dmap_sem);
+		return 0;
+	}
+
+	/*
+	 * If read beyond end of file happnes, fs code seems to return
+	 * it as hole
+	 */
+iomap_hole:
+	fuse_fill_iomap_hole(iomap, length);
+	pr_debug("fuse_iomap_begin() returning hole mapping. pos=0x%llx length_asked=0x%llx length_returned=0x%llx\n", pos, length, iomap->length);
+	return 0;
+}
+
+static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t length,
+			  ssize_t written, unsigned flags,
+			  struct iomap *iomap)
+{
+	/* DAX writes beyond end-of-file aren't handled using iomap, so the
+	 * file size is unchanged and there is nothing to do here.
+	 */
+	return 0;
+}
+
+static const struct iomap_ops fuse_iomap_ops = {
+	.iomap_begin = fuse_iomap_begin,
+	.iomap_end = fuse_iomap_end,
+};
+
+static ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock_shared(inode);
+	}
+
+	ret = dax_iomap_rw(iocb, to, &fuse_iomap_ops);
+	inode_unlock_shared(inode);
+
+	/* TODO file_accessed(iocb->f_filp) */
+
+	return ret;
+}
+
+static ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock(inode);
+	}
+
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out;
+
+	ret = file_remove_privs(iocb->ki_filp);
+	if (ret)
+		goto out;
+	/* TODO file_update_time() but we don't want metadata I/O */
+
+	/* TODO handle growing the file */
+
+	ret = dax_iomap_rw(iocb, from, &fuse_iomap_ops);
+
+out:
+	inode_unlock(inode);
+
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+	return ret;
+}
+
 static void fuse_writepage_free(struct fuse_conn *fc, struct fuse_req *req)
 {
 	int i;
@@ -2104,6 +2474,11 @@ static int fuse_direct_mmap(struct file *file, struct vm_area_struct *vma)
 	return generic_file_mmap(file, vma);
 }
 
+static int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	return -EINVAL; /* TODO */
+}
+
 static int convert_fuse_file_lock(struct fuse_conn *fc,
 				  const struct fuse_file_lock *ffl,
 				  struct file_lock *fl)
@@ -3137,6 +3512,24 @@ static const struct file_operations fuse_direct_io_file_operations = {
 	/* no splice_read */
 };
 
+static const struct file_operations fuse_dax_file_operations = {
+	.llseek		= fuse_file_llseek,
+	.read_iter	= fuse_dax_read_iter,
+	.write_iter	= fuse_dax_write_iter,
+	.mmap		= fuse_dax_mmap,
+	.open		= fuse_open,
+	.flush		= fuse_flush,
+	.release	= fuse_release,
+	.fsync		= fuse_fsync,
+	.lock		= fuse_file_lock,
+	.flock		= fuse_file_flock,
+	.unlocked_ioctl	= fuse_file_ioctl,
+	.compat_ioctl	= fuse_file_compat_ioctl,
+	.poll		= fuse_file_poll,
+	.fallocate	= fuse_file_fallocate,
+	/* no splice_read */
+};
+
 static const struct address_space_operations fuse_file_aops  = {
 	.readpage	= fuse_readpage,
 	.writepage	= fuse_writepage,
@@ -3153,6 +3546,7 @@ static const struct address_space_operations fuse_file_aops  = {
 void fuse_init_file_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
@@ -3162,4 +3556,10 @@ void fuse_init_file_inode(struct inode *inode)
 	fi->writectr = 0;
 	init_waitqueue_head(&fi->page_waitq);
 	INIT_LIST_HEAD(&fi->writepages);
+	fi->dmap_tree = RB_ROOT_CACHED;
+
+	if (fc->dax_dev) {
+		inode->i_flags |= S_DAX;
+		inode->i_fop = &fuse_dax_file_operations;
+	}
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index a24f31156b47..3b17fb336256 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -203,6 +203,11 @@ struct fuse_inode {
 	/** Lock for serializing lookup and readdir for back compatibility*/
 	struct mutex mutex;
 
+	/*
+	 * Semaphore to protect modifications to dmap_tree
+	 */
+	struct rw_semaphore i_dmap_sem;
+
 	/** Sorted rb tree of struct fuse_dax_mapping elements */
 	struct rb_root_cached dmap_tree;
 	unsigned long nr_dmaps;
@@ -1225,5 +1230,6 @@ unsigned fuse_len_args(unsigned numargs, struct fuse_arg *args);
  * Get the next unique ID for a request
  */
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
+void fuse_removemapping(struct inode *inode);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 075997977cfd..56310d10cd4c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -83,7 +83,9 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->attr_version = 0;
 	fi->orig_ino = 0;
 	fi->state = 0;
+	fi->nr_dmaps = 0;
 	mutex_init(&fi->mutex);
+	init_rwsem(&fi->i_dmap_sem);
 	fi->forget = fuse_alloc_forget();
 	if (!fi->forget) {
 		kmem_cache_free(fuse_inode_cachep, inode);
@@ -118,6 +120,10 @@ static void fuse_evict_inode(struct inode *inode)
 	if (inode->i_sb->s_flags & SB_ACTIVE) {
 		struct fuse_conn *fc = get_fuse_conn(inode);
 		struct fuse_inode *fi = get_fuse_inode(inode);
+		if (IS_DAX(inode)) {
+			fuse_removemapping(inode);
+			WARN_ON(fi->nr_dmaps);
+		}
 		fuse_queue_forget(fc, fi->forget, fi->nodeid, fi->nlookup);
 		fi->forget = NULL;
 	}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 867fdafc4a5e..1657253cb7d6 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -821,6 +821,7 @@ struct fuse_copy_file_range_in {
 
 #define FUSE_SETUPMAPPING_ENTRIES 8
 #define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
+#define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
 struct fuse_setupmapping_in {
 	/* An already open handle */
 	uint64_t	fh;
-- 
2.13.6

