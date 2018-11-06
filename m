Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA76CC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEBB20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEBB20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbeKFTIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:08:24 -0500
Received: from relay.sw.ru ([185.231.240.75]:59858 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbeKFTIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:08:24 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gJxto-00035W-Vl; Tue, 06 Nov 2018 12:43:53 +0300
Subject: [PATCH 3/6] fuse: Introduce fuse_inode::lock to protect write
 related fields and statistics
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 12:43:52 +0300
Message-ID: <154149743264.18189.13410694718277188138.stgit@localhost.localdomain>
In-Reply-To: <154149673368.18189.14752124997476502777.stgit@localhost.localdomain>
References: <154149673368.18189.14752124997476502777.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To minimize contention of fuse_conn::lock, this patch
introduces a new spinlock for protection fuse_inode
metadata:
		fuse_inode::
			writectr
			writepages
			write_files
			queued_writes
			attr_version

		inode::
			i_size
			i_nlink
			i_mtime
			i_ctime

Also, it protects the fields changed in fuse_change_attributes_common()
(too many to list).

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dir.c    |   25 ++++++++-------
 fs/fuse/file.c   |   93 ++++++++++++++++++++++++++++++------------------------
 fs/fuse/fuse_i.h |    7 +++-
 fs/fuse/inode.c  |   12 +++++--
 4 files changed, 81 insertions(+), 56 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7058bbf69c3c..794b9f48fb8e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -673,8 +673,10 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 		struct inode *inode = d_inode(entry);
 		struct fuse_inode *fi = get_fuse_inode(inode);
 
+		spin_lock(&fi->lock);
 		spin_lock(&fc->lock);
 		fi->attr_version = ++fc->attr_version;
+		spin_unlock(&fc->lock);
 		/*
 		 * If i_nlink == 0 then unlink doesn't make sense, yet this can
 		 * happen if userspace filesystem is careless.  It would be
@@ -683,7 +685,7 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 		 */
 		if (inode->i_nlink > 0)
 			drop_nlink(inode);
-		spin_unlock(&fc->lock);
+		spin_unlock(&fi->lock);
 		fuse_invalidate_attr(inode);
 		fuse_dir_changed(dir);
 		fuse_invalidate_entry_cache(entry);
@@ -827,10 +829,12 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	if (!err) {
 		struct fuse_inode *fi = get_fuse_inode(inode);
 
+		spin_lock(&fi->lock);
 		spin_lock(&fc->lock);
 		fi->attr_version = ++fc->attr_version;
-		inc_nlink(inode);
 		spin_unlock(&fc->lock);
+		inc_nlink(inode);
+		spin_unlock(&fi->lock);
 		fuse_invalidate_attr(inode);
 		fuse_update_ctime(inode);
 	} else if (err == -EINTR) {
@@ -1338,15 +1342,14 @@ static void iattr_to_fattr(struct fuse_conn *fc, struct iattr *iattr,
  */
 void fuse_set_nowrite(struct inode *inode)
 {
-	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	BUG_ON(!inode_is_locked(inode));
 
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 	BUG_ON(fi->writectr < 0);
 	fi->writectr += FUSE_NOWRITE;
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 	wait_event(fi->page_waitq, fi->writectr == FUSE_NOWRITE);
 }
 
@@ -1367,11 +1370,11 @@ static void __fuse_release_nowrite(struct inode *inode)
 
 void fuse_release_nowrite(struct inode *inode)
 {
-	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 	__fuse_release_nowrite(inode);
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 }
 
 static void fuse_setattr_fill(struct fuse_conn *fc, struct fuse_args *args,
@@ -1506,7 +1509,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		goto error;
 	}
 
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 	/* the kernel maintains i_mtime locally */
 	if (trust_local_cmtime) {
 		if (attr->ia_valid & ATTR_MTIME)
@@ -1524,10 +1527,10 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		i_size_write(inode, outarg.attr.size);
 
 	if (is_truncate) {
-		/* NOTE: this may release/reacquire fc->lock */
+		/* NOTE: this may release/reacquire fi->lock */
 		__fuse_release_nowrite(inode);
 	}
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 
 	/*
 	 * Only call invalidate_inode_pages2() after removing
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index fa7580d47d0c..48e2889ba6a6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -159,17 +159,16 @@ EXPORT_SYMBOL_GPL(fuse_do_open);
 static void fuse_link_write_file(struct file *file)
 {
 	struct inode *inode = file_inode(file);
-	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_file *ff = file->private_data;
 	/*
 	 * file may be written through mmap, so chain it onto the
 	 * inodes's write_file list
 	 */
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 	if (list_empty(&ff->write_entry))
 		list_add(&ff->write_entry, &fi->write_files);
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 }
 
 void fuse_finish_open(struct inode *inode, struct file *file)
@@ -186,10 +185,12 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 	if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC)) {
 		struct fuse_inode *fi = get_fuse_inode(inode);
 
+		spin_lock(&fi->lock);
 		spin_lock(&fc->lock);
 		fi->attr_version = ++fc->attr_version;
-		i_size_write(inode, 0);
 		spin_unlock(&fc->lock);
+		i_size_write(inode, 0);
+		spin_unlock(&fi->lock);
 		fuse_invalidate_attr(inode);
 		if (fc->writeback_cache)
 			file_update_time(file);
@@ -231,8 +232,13 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 	struct fuse_req *req = ff->reserved_req;
 	struct fuse_release_in *inarg = &req->misc.release.in;
 
+	/* Inode is NULL on error path of fuse_create_open() */
+	if (likely(fi)) {
+		spin_lock(&fi->lock);
+		list_del(&ff->write_entry);
+		spin_unlock(&fi->lock);
+	}
 	spin_lock(&fc->lock);
-	list_del(&ff->write_entry);
 	if (!RB_EMPTY_NODE(&ff->polled_node))
 		rb_erase(&ff->polled_node, &fc->polled_files);
 	spin_unlock(&fc->lock);
@@ -339,12 +345,11 @@ u64 fuse_lock_owner_id(struct fuse_conn *fc, fl_owner_t id)
 static bool fuse_range_is_writeback(struct inode *inode, pgoff_t idx_from,
 				   pgoff_t idx_to)
 {
-	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_req *req;
 	bool found = false;
 
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 	list_for_each_entry(req, &fi->writepages, writepages_entry) {
 		pgoff_t curr_index;
 
@@ -356,7 +361,7 @@ static bool fuse_range_is_writeback(struct inode *inode, pgoff_t idx_from,
 			break;
 		}
 	}
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 
 	return found;
 }
@@ -598,9 +603,11 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 			struct fuse_conn *fc = get_fuse_conn(inode);
 			struct fuse_inode *fi = get_fuse_inode(inode);
 
+			spin_lock(&fi->lock);
 			spin_lock(&fc->lock);
 			fi->attr_version = ++fc->attr_version;
 			spin_unlock(&fc->lock);
+			spin_unlock(&fi->lock);
 		}
 
 		io->iocb->ki_complete(io->iocb, res, 0);
@@ -675,13 +682,15 @@ static void fuse_read_update_size(struct inode *inode, loff_t size,
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 	if (attr_ver == fi->attr_version && size < inode->i_size &&
 	    !test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) {
+		spin_lock(&fc->lock);
 		fi->attr_version = ++fc->attr_version;
+		spin_unlock(&fc->lock);
 		i_size_write(inode, size);
 	}
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 }
 
 static void fuse_short_read(struct fuse_req *req, struct inode *inode,
@@ -996,13 +1005,15 @@ bool fuse_write_update_size(struct inode *inode, loff_t pos)
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	bool ret = false;
 
+	spin_lock(&fi->lock);
 	spin_lock(&fc->lock);
 	fi->attr_version = ++fc->attr_version;
+	spin_unlock(&fc->lock);
 	if (pos > inode->i_size) {
 		i_size_write(inode, pos);
 		ret = true;
 	}
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 
 	return ret;
 }
@@ -1481,20 +1492,17 @@ static void fuse_writepage_finish(struct fuse_conn *fc, struct fuse_req *req)
 	wake_up(&fi->page_waitq);
 }
 
-/* Called under fc->lock, may release and reacquire it */
+/* Called under fi->lock, may release and reacquire it */
 static void fuse_send_writepage(struct fuse_conn *fc, struct fuse_req *req,
 				loff_t size)
-__releases(fc->lock)
-__acquires(fc->lock)
+__releases(fi->lock)
+__acquires(fi->lock)
 {
 	struct fuse_inode *fi = get_fuse_inode(req->inode);
 	struct fuse_write_in *inarg = &req->misc.write.in;
 	__u64 data_size = req->num_pages * PAGE_SIZE;
 	bool queued;
 
-	if (!fc->connected)
-		goto out_free;
-
 	if (inarg->offset + data_size <= size) {
 		inarg->size = data_size;
 	} else if (inarg->offset < size) {
@@ -1505,28 +1513,31 @@ __acquires(fc->lock)
 	}
 
 	req->in.args[1].size = inarg->size;
-	fi->writectr++;
 	queued = fuse_request_queue_background(fc, req);
-	WARN_ON(!queued);
+	/* Fails on broken connection only */
+	if (unlikely(!queued))
+		goto out_free;
+
+	fi->writectr++;
 	return;
 
  out_free:
 	fuse_writepage_finish(fc, req);
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 	fuse_writepage_free(fc, req);
 	fuse_put_request(fc, req);
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 }
 
 /*
  * If fi->writectr is positive (no truncate or fsync going on) send
  * all queued writepage requests.
  *
- * Called with fc->lock
+ * Called with fi->lock
  */
 void fuse_flush_writepages(struct fuse_inode *fi)
-__releases(fc->lock)
-__acquires(fc->lock)
+__releases(fi->lock)
+__acquires(fi->lock)
 {
 	struct inode *inode = &fi->inode;
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -1546,7 +1557,7 @@ static void fuse_writepage_end(struct fuse_conn *fc, struct fuse_req *req)
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	mapping_set_error(inode->i_mapping, req->out.h.error);
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 	while (req->misc.write.next) {
 		struct fuse_conn *fc = get_fuse_conn(inode);
 		struct fuse_write_in *inarg = &req->misc.write.in;
@@ -1583,7 +1594,7 @@ static void fuse_writepage_end(struct fuse_conn *fc, struct fuse_req *req)
 	}
 	fi->writectr--;
 	fuse_writepage_finish(fc, req);
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 	fuse_writepage_free(fc, req);
 }
 
@@ -1592,13 +1603,13 @@ static struct fuse_file *__fuse_write_file_get(struct fuse_conn *fc,
 {
 	struct fuse_file *ff = NULL;
 
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 	if (!list_empty(&fi->write_files)) {
 		ff = list_entry(fi->write_files.next, struct fuse_file,
 				write_entry);
 		fuse_file_get(ff);
 	}
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 
 	return ff;
 }
@@ -1669,11 +1680,11 @@ static int fuse_writepage_locked(struct page *page)
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
 	inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
 
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 	list_add(&req->writepages_entry, &fi->writepages);
 	list_add_tail(&req->list, &fi->queued_writes);
 	fuse_flush_writepages(fi);
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 
 	end_page_writeback(page);
 
@@ -1722,16 +1733,15 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
 {
 	struct fuse_req *req = data->req;
 	struct inode *inode = data->inode;
-	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	int num_pages = req->num_pages;
 	int i;
 
 	req->ff = fuse_file_get(data->ff);
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 	list_add_tail(&req->list, &fi->queued_writes);
 	fuse_flush_writepages(fi);
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 
 	for (i = 0; i < num_pages; i++)
 		end_page_writeback(data->orig_pages[i]);
@@ -1749,7 +1759,7 @@ static bool fuse_writepage_in_flight(struct fuse_req *new_req,
 
 	BUG_ON(new_req->num_pages != 0);
 
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 	list_del(&new_req->writepages_entry);
 	list_for_each_entry(old_req, &fi->writepages, writepages_entry) {
 		BUG_ON(old_req->inode != new_req->inode);
@@ -1779,7 +1789,7 @@ static bool fuse_writepage_in_flight(struct fuse_req *new_req,
 		struct backing_dev_info *bdi = inode_to_bdi(page->mapping->host);
 
 		copy_highpage(old_req->pages[0], page);
-		spin_unlock(&fc->lock);
+		spin_unlock(&fi->lock);
 
 		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
 		dec_node_page_state(page, NR_WRITEBACK_TEMP);
@@ -1792,7 +1802,7 @@ static bool fuse_writepage_in_flight(struct fuse_req *new_req,
 		old_req->misc.write.next = new_req;
 	}
 out_unlock:
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 out:
 	return found;
 }
@@ -1803,6 +1813,7 @@ static int fuse_writepages_fill(struct page *page,
 	struct fuse_fill_wb_data *data = _data;
 	struct fuse_req *req = data->req;
 	struct inode *inode = data->inode;
+	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct page *tmp_page;
 	bool is_writeback;
@@ -1873,9 +1884,9 @@ static int fuse_writepages_fill(struct page *page,
 		req->end = fuse_writepage_end;
 		req->inode = inode;
 
-		spin_lock(&fc->lock);
+		spin_lock(&fi->lock);
 		list_add(&req->writepages_entry, &fi->writepages);
-		spin_unlock(&fc->lock);
+		spin_unlock(&fi->lock);
 
 		data->req = req;
 	}
@@ -1898,12 +1909,12 @@ static int fuse_writepages_fill(struct page *page,
 	data->orig_pages[req->num_pages] = page;
 
 	/*
-	 * Protected by fc->lock against concurrent access by
+	 * Protected by fi->lock against concurrent access by
 	 * fuse_page_is_writeback().
 	 */
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 	req->num_pages++;
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 
 out_unlock:
 	unlock_page(page);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9e23e871873b..075da40499b8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -96,7 +96,7 @@ struct fuse_inode {
 	union {
 		/* Write related fields (regular file only) */
 		struct {
-			/* Files usable in writepage.  Protected by fc->lock */
+			/* Files usable in writepage.  Protected by fi->lock */
 			struct list_head write_files;
 
 			/* Writepages pending on truncate or fsync */
@@ -144,6 +144,9 @@ struct fuse_inode {
 
 	/** Lock for serializing lookup and readdir for back compatibility*/
 	struct mutex mutex;
+
+	/** Lock to protect write related fields */
+	spinlock_t lock;
 };
 
 /** FUSE inode state bits */
@@ -500,6 +503,8 @@ struct fuse_dev {
  * This structure is created, when the filesystem is mounted, and is
  * destroyed, when the client device is closed and the filesystem is
  * unmounted.
+ *
+ * Locking order: fuse_inode::lock -> fuse_conn::lock -> fuse_conn::bg_lock
  */
 struct fuse_conn {
 	/** Lock protecting accessess to  members of this structure */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 4727ef612019..f62d45686b42 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -97,6 +97,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->orig_ino = 0;
 	fi->state = 0;
 	mutex_init(&fi->mutex);
+	spin_lock_init(&fi->lock);
 	fi->forget = fuse_alloc_forget();
 	if (!fi->forget) {
 		kmem_cache_free(fuse_inode_cachep, inode);
@@ -164,7 +165,12 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
+	lockdep_assert_held(&fi->lock);
+
+	spin_lock(&fc->lock);
 	fi->attr_version = ++fc->attr_version;
+	spin_unlock(&fc->lock);
+
 	fi->i_time = attr_valid;
 	WRITE_ONCE(fi->inval_mask, 0);
 
@@ -210,10 +216,10 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	loff_t oldsize;
 	struct timespec64 old_mtime;
 
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 	if ((attr_version != 0 && fi->attr_version > attr_version) ||
 	    test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) {
-		spin_unlock(&fc->lock);
+		spin_unlock(&fi->lock);
 		return;
 	}
 
@@ -228,7 +234,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	 */
 	if (!is_wb || !S_ISREG(inode->i_mode))
 		i_size_write(inode, attr->size);
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 
 	if (!is_wb && S_ISREG(inode->i_mode)) {
 		bool inval = false;

