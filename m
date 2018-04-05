Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbeDEUbJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:31:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753121AbeDEUbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:31:05 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/20] afs: Fix directory handling
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:31:02 +0100
Message-ID: <152296026284.31027.7710357950194602537.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFS directories are structured blobs that are downloaded just like files
and then parsed by the lookup and readdir code and, as such, are currently
handled in the pagecache like any other file, with the entire directory
content being thrown away each time the directory changes.

However, since the blob is a known structure and since the data version
counter on a directory increases by exactly one for each change committed
to that directory, we can actually edit the directory locally rather than
fetching it from the server after each locally-induced change.

What we can't do, though, is mix data from the server and data from the
client since the server is technically at liberty to rearrange or compress
a directory if it sees fit, provided it updates the data version number
when it does so and breaks the callback (ie. sends a notification).

Further, lookup with lookup-ahead, readdir and, when it arrives, local
editing are likely want to scan the whole of a directory.

So directory handling needs to be improved to maintain the coherency of the
directory blob prior to permitting local directory editing.

To this end:

 (1) If any directory page gets discarded, invalidate and reread the entire
     directory.

 (2) If readpage notes that if when it fetches a single page that the
     version number has changed, the entire directory is flagged for
     invalidation.

 (3) Read as much of the directory in one go as we can.

Note that this removes local caching of directories in fscache for the
moment as we can't pass the pages to fscache_read_or_alloc_pages() since
page->lru is in use by the LRU.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c      |  294 +++++++++++++++++++++++++++++++++++++++++------------
 fs/afs/file.c     |   14 +--
 fs/afs/fsclient.c |   24 +++-
 fs/afs/inode.c    |   26 ++---
 fs/afs/internal.h |   13 +-
 fs/afs/proc.c     |    5 +
 fs/afs/write.c    |    3 -
 7 files changed, 271 insertions(+), 108 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 8f2df235b07f..e989a8fe9a9b 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1,6 +1,6 @@
 /* dir.c: AFS filesystem directory handling
  *
- * Copyright (C) 2002 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2002, 2018 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -13,8 +13,10 @@
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/pagemap.h>
+#include <linux/swap.h>
 #include <linux/ctype.h>
 #include <linux/sched.h>
+#include <linux/task_io_accounting_ops.h>
 #include "internal.h"
 
 static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
@@ -39,6 +41,14 @@ static int afs_symlink(struct inode *dir, struct dentry *dentry,
 static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		      struct inode *new_dir, struct dentry *new_dentry,
 		      unsigned int flags);
+static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags);
+static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
+				   unsigned int length);
+
+static int afs_dir_set_page_dirty(struct page *page)
+{
+	BUG(); /* This should never happen. */
+}
 
 const struct file_operations afs_dir_file_operations = {
 	.open		= afs_dir_open,
@@ -63,6 +73,12 @@ const struct inode_operations afs_dir_inode_operations = {
 	.listxattr	= afs_listxattr,
 };
 
+const struct address_space_operations afs_dir_aops = {
+	.set_page_dirty	= afs_dir_set_page_dirty,
+	.releasepage	= afs_dir_releasepage,
+	.invalidatepage	= afs_dir_invalidatepage,
+};
+
 const struct dentry_operations afs_fs_dentry_operations = {
 	.d_revalidate	= afs_d_revalidate,
 	.d_delete	= afs_d_delete,
@@ -140,32 +156,17 @@ struct afs_lookup_cookie {
 /*
  * check that a directory page is valid
  */
-bool afs_dir_check_page(struct inode *dir, struct page *page)
+static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *page,
+			       loff_t i_size)
 {
 	struct afs_dir_page *dbuf;
-	struct afs_vnode *vnode = AFS_FS_I(dir);
-	loff_t latter, i_size, off;
+	loff_t latter, off;
 	int tmp, qty;
 
-#if 0
-	/* check the page count */
-	qty = desc.size / sizeof(dbuf->blocks[0]);
-	if (qty == 0)
-		goto error;
-
-	if (page->index == 0 && qty != ntohs(dbuf->blocks[0].pagehdr.npages)) {
-		printk("kAFS: %s(%lu): wrong number of dir blocks %d!=%hu\n",
-		       __func__, dir->i_ino, qty,
-		       ntohs(dbuf->blocks[0].pagehdr.npages));
-		goto error;
-	}
-#endif
-
 	/* Determine how many magic numbers there should be in this page, but
 	 * we must take care because the directory may change size under us.
 	 */
 	off = page_offset(page);
-	i_size = i_size_read(dir);
 	if (i_size <= off)
 		goto checked;
 
@@ -181,59 +182,21 @@ bool afs_dir_check_page(struct inode *dir, struct page *page)
 	for (tmp = 0; tmp < qty; tmp++) {
 		if (dbuf->blocks[tmp].pagehdr.magic != AFS_DIR_MAGIC) {
 			printk("kAFS: %s(%lx): bad magic %d/%d is %04hx\n",
-			       __func__, dir->i_ino, tmp, qty,
+			       __func__, dvnode->vfs_inode.i_ino, tmp, qty,
 			       ntohs(dbuf->blocks[tmp].pagehdr.magic));
-			trace_afs_dir_check_failed(vnode, off, i_size);
+			trace_afs_dir_check_failed(dvnode, off, i_size);
 			goto error;
 		}
 	}
 
 checked:
-	afs_stat_v(vnode, n_read_dir);
-	SetPageChecked(page);
+	afs_stat_v(dvnode, n_read_dir);
 	return true;
 
 error:
-	SetPageError(page);
 	return false;
 }
 
-/*
- * discard a page cached in the pagecache
- */
-static inline void afs_dir_put_page(struct page *page)
-{
-	kunmap(page);
-	unlock_page(page);
-	put_page(page);
-}
-
-/*
- * get a page into the pagecache
- */
-static struct page *afs_dir_get_page(struct inode *dir, unsigned long index,
-				     struct key *key)
-{
-	struct page *page;
-	_enter("{%lu},%lu", dir->i_ino, index);
-
-	page = read_cache_page(dir->i_mapping, index, afs_page_filler, key);
-	if (!IS_ERR(page)) {
-		lock_page(page);
-		kmap(page);
-		if (unlikely(!PageChecked(page))) {
-			if (PageError(page))
-				goto fail;
-		}
-	}
-	return page;
-
-fail:
-	afs_dir_put_page(page);
-	_leave(" = -EIO");
-	return ERR_PTR(-EIO);
-}
-
 /*
  * open an AFS directory file
  */
@@ -250,6 +213,147 @@ static int afs_dir_open(struct inode *inode, struct file *file)
 	return afs_open(inode, file);
 }
 
+/*
+ * Read the directory into the pagecache in one go, scrubbing the previous
+ * contents.  The list of pages is returned, pinning them so that they don't
+ * get reclaimed during the iteration.
+ */
+static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
+{
+	struct afs_read *req;
+	loff_t i_size;
+	int nr_pages, nr_inline, i, n;
+	int ret = -ENOMEM;
+
+retry:
+	i_size = i_size_read(&dvnode->vfs_inode);
+	if (i_size < 2048)
+		return ERR_PTR(-EIO);
+	if (i_size > 2048 * 1024)
+		return ERR_PTR(-EFBIG);
+
+	_enter("%llu", i_size);
+
+	/* Get a request record to hold the page list.  We want to hold it
+	 * inline if we can, but we don't want to make an order 1 allocation.
+	 */
+	nr_pages = (i_size + PAGE_SIZE - 1) / PAGE_SIZE;
+	nr_inline = nr_pages;
+	if (nr_inline > (PAGE_SIZE - sizeof(*req)) / sizeof(struct page *))
+		nr_inline = 0;
+
+	req = kzalloc(sizeof(*req) + sizeof(struct page *) * nr_inline,
+		      GFP_KERNEL);
+	if (!req)
+		return ERR_PTR(-ENOMEM);
+
+	refcount_set(&req->usage, 1);
+	req->nr_pages = nr_pages;
+	req->actual_len = i_size; /* May change */
+	req->len = nr_pages * PAGE_SIZE; /* We can ask for more than there is */
+	req->data_version = dvnode->status.data_version; /* May change */
+	if (nr_inline > 0) {
+		req->pages = req->array;
+	} else {
+		req->pages = kcalloc(nr_pages, sizeof(struct page *),
+				     GFP_KERNEL);
+		if (!req->pages)
+			goto error;
+	}
+
+	/* Get a list of all the pages that hold or will hold the directory
+	 * content.  We need to fill in any gaps that we might find where the
+	 * memory reclaimer has been at work.  If there are any gaps, we will
+	 * need to reread the entire directory contents.
+	 */
+	i = 0;
+	do {
+		n = find_get_pages_contig(dvnode->vfs_inode.i_mapping, i,
+					  req->nr_pages - i,
+					  req->pages + i);
+		_debug("find %u at %u/%u", n, i, req->nr_pages);
+		if (n == 0) {
+			gfp_t gfp = dvnode->vfs_inode.i_mapping->gfp_mask;
+
+			if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
+				afs_stat_v(dvnode, n_inval);
+
+			ret = -ENOMEM;
+			req->pages[i] = __page_cache_alloc(gfp);
+			if (!req->pages[i])
+				goto error;
+			ret = add_to_page_cache_lru(req->pages[i],
+						    dvnode->vfs_inode.i_mapping,
+						    i, gfp);
+			if (ret < 0)
+				goto error;
+
+			set_page_private(req->pages[i], 1);
+			SetPagePrivate(req->pages[i]);
+			unlock_page(req->pages[i]);
+			i++;
+		} else {
+			i += n;
+		}
+	} while (i < req->nr_pages);
+
+	/* If we're going to reload, we need to lock all the pages to prevent
+	 * races.
+	 */
+	if (!test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags)) {
+		ret = -ERESTARTSYS;
+		for (i = 0; i < req->nr_pages; i++)
+			if (lock_page_killable(req->pages[i]) < 0)
+				goto error_unlock;
+
+		if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
+			goto success;
+
+		ret = afs_fetch_data(dvnode, key, req);
+		if (ret < 0)
+			goto error_unlock_all;
+
+		task_io_account_read(PAGE_SIZE * req->nr_pages);
+
+		if (req->len < req->file_size)
+			goto content_has_grown;
+		
+		/* Validate the data we just read. */
+		ret = -EIO;
+		for (i = 0; i < req->nr_pages; i++)
+			if (!afs_dir_check_page(dvnode, req->pages[i],
+						req->actual_len))
+				goto error_unlock_all;
+
+		// TODO: Trim excess pages
+		
+		set_bit(AFS_VNODE_DIR_VALID, &dvnode->flags);
+	}
+
+success:
+	i = req->nr_pages;
+	while (i > 0)
+		unlock_page(req->pages[--i]);
+	return req;
+
+error_unlock_all:
+	i = req->nr_pages;
+error_unlock:
+	while (i > 0)
+		unlock_page(req->pages[--i]);
+error:
+	afs_put_read(req);
+	_leave(" = %d", ret);
+	return ERR_PTR(ret);
+
+content_has_grown:
+	i = req->nr_pages;
+	while (i > 0)
+		unlock_page(req->pages[--i]);
+	afs_put_read(req);
+	goto retry;
+}
+
 /*
  * deal with one block in an AFS directory
  */
@@ -347,8 +451,10 @@ static int afs_dir_iterate_block(struct dir_context *ctx,
 static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 			   struct key *key)
 {
+	struct afs_vnode *dvnode = AFS_FS_I(dir);
 	union afs_dir_block *dblock;
 	struct afs_dir_page *dbuf;
+	struct afs_read *req;
 	struct page *page;
 	unsigned blkoff, limit;
 	int ret;
@@ -360,25 +466,32 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 		return -ESTALE;
 	}
 
+	req = afs_read_dir(dvnode, key);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
 	/* round the file position up to the next entry boundary */
 	ctx->pos += sizeof(union afs_dirent) - 1;
 	ctx->pos &= ~(sizeof(union afs_dirent) - 1);
 
 	/* walk through the blocks in sequence */
 	ret = 0;
-	while (ctx->pos < dir->i_size) {
+	while (ctx->pos < req->actual_len) {
 		blkoff = ctx->pos & ~(sizeof(union afs_dir_block) - 1);
 
-		/* fetch the appropriate page from the directory */
-		page = afs_dir_get_page(dir, blkoff / PAGE_SIZE, key);
-		if (IS_ERR(page)) {
-			ret = PTR_ERR(page);
+		/* Fetch the appropriate page from the directory and re-add it
+		 * to the LRU.
+		 */
+		page = req->pages[blkoff / PAGE_SIZE];
+		if (!page) {
+			ret = -EIO;
 			break;
 		}
+		mark_page_accessed(page);
 
 		limit = blkoff & ~(PAGE_SIZE - 1);
 
-		dbuf = page_address(page);
+		dbuf = kmap(page);
 
 		/* deal with the individual blocks stashed on this page */
 		do {
@@ -386,7 +499,7 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 					       sizeof(union afs_dir_block)];
 			ret = afs_dir_iterate_block(ctx, dblock, blkoff);
 			if (ret != 1) {
-				afs_dir_put_page(page);
+				kunmap(page);
 				goto out;
 			}
 
@@ -394,11 +507,12 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 
 		} while (ctx->pos < dir->i_size && blkoff < limit);
 
-		afs_dir_put_page(page);
+		kunmap(page);
 		ret = 0;
 	}
 
 out:
+	afs_put_read(req);
 	_leave(" = %d", ret);
 	return ret;
 }
@@ -1504,3 +1618,47 @@ static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	_leave(" = %d", ret);
 	return ret;
 }
+
+/*
+ * Release a directory page and clean up its private state if it's not busy
+ * - return true if the page can now be released, false if not
+ */
+static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags)
+{
+	struct afs_vnode *dvnode = AFS_FS_I(page->mapping->host);
+
+	_enter("{{%x:%u}[%lu]}", dvnode->fid.vid, dvnode->fid.vnode, page->index);
+
+	set_page_private(page, 0);
+	ClearPagePrivate(page);
+
+	/* The directory will need reloading. */
+	if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
+		afs_stat_v(dvnode, n_relpg);
+	return 1;
+}
+
+/*
+ * invalidate part or all of a page
+ * - release a page and clean up its private data if offset is 0 (indicating
+ *   the entire page)
+ */
+static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
+				   unsigned int length)
+{
+	struct afs_vnode *dvnode = AFS_FS_I(page->mapping->host);
+
+	_enter("{%lu},%u,%u", page->index, offset, length);
+
+	BUG_ON(!PageLocked(page));
+
+	/* The directory will need reloading. */
+	if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
+		afs_stat_v(dvnode, n_inval);
+
+	/* we clean up only if the entire page is being invalidated */
+	if (offset == 0 && length == PAGE_SIZE) {
+		set_page_private(page, 0);
+		ClearPagePrivate(page);
+	}
+}
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 79e665a35fea..91ff1335fd33 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -187,10 +187,12 @@ void afs_put_read(struct afs_read *req)
 {
 	int i;
 
-	if (atomic_dec_and_test(&req->usage)) {
+	if (refcount_dec_and_test(&req->usage)) {
 		for (i = 0; i < req->nr_pages; i++)
 			if (req->pages[i])
 				put_page(req->pages[i]);
+		if (req->pages != req->array)
+			kfree(req->pages);
 		kfree(req);
 	}
 }
@@ -297,10 +299,11 @@ int afs_page_filler(void *data, struct page *page)
 		 * end of the file, the server will return a short read and the
 		 * unmarshalling code will clear the unfilled space.
 		 */
-		atomic_set(&req->usage, 1);
+		refcount_set(&req->usage, 1);
 		req->pos = (loff_t)page->index << PAGE_SHIFT;
 		req->len = PAGE_SIZE;
 		req->nr_pages = 1;
+		req->pages = req->array;
 		req->pages[0] = page;
 		get_page(page);
 
@@ -309,10 +312,6 @@ int afs_page_filler(void *data, struct page *page)
 		ret = afs_fetch_data(vnode, key, req);
 		afs_put_read(req);
 
-		if (ret >= 0 && S_ISDIR(inode->i_mode) &&
-		    !afs_dir_check_page(inode, page))
-			ret = -EIO;
-
 		if (ret < 0) {
 			if (ret == -ENOENT) {
 				_debug("got NOENT from server"
@@ -447,10 +446,11 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 	if (!req)
 		return -ENOMEM;
 
-	atomic_set(&req->usage, 1);
+	refcount_set(&req->usage, 1);
 	req->page_done = afs_readpages_page_done;
 	req->pos = first->index;
 	req->pos <<= PAGE_SHIFT;
+	req->pages = req->array;
 
 	/* Transfer the pages to the request.  We add them in until one fails
 	 * to add to the LRU and then we stop (as that'll make a hole in the
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index f7570d229dcc..b66ff0dc8a5a 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -101,8 +101,12 @@ void afs_update_inode_from_status(struct afs_vnode *vnode,
 			       vnode->fid.vid, vnode->fid.vnode,
 			       (unsigned long long) *expected_version);
 			vnode->invalid_before = status->data_version;
-			set_bit(AFS_VNODE_DIR_MODIFIED, &vnode->flags);
-			set_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);
+			if (vnode->status.type == AFS_FTYPE_DIR) {
+				if (test_and_clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
+					afs_stat_v(vnode, n_inval);
+			} else {
+				set_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);
+			}
 		}
 	}
 
@@ -119,7 +123,7 @@ static int xdr_decode_AFSFetchStatus(const __be32 **_bp,
 				     struct afs_file_status *status,
 				     struct afs_vnode *vnode,
 				     const afs_dataversion_t *expected_version,
-				     afs_dataversion_t *_version)
+				     struct afs_read *read_req)
 {
 	const struct afs_xdr_AFSFetchStatus *xdr = (const void *)*_bp;
 	u64 data_version, size;
@@ -197,8 +201,11 @@ static int xdr_decode_AFSFetchStatus(const __be32 **_bp,
 		status->data_version = data_version;
 		flags |= AFS_VNODE_DATA_CHANGED;
 	}
-	if (_version)
-		*_version = data_version;
+
+	if (read_req) {
+		read_req->data_version = data_version;
+		read_req->file_size = size;
+	}
 
 	*_bp = (const void *)*_bp + sizeof(*xdr);
 
@@ -543,8 +550,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 
 		bp = call->buffer;
 		if (xdr_decode_AFSFetchStatus(&bp, &vnode->status, vnode,
-					      &vnode->status.data_version,
-					      &req->new_version) < 0)
+					      &vnode->status.data_version, req) < 0)
 			return -EBADMSG;
 		xdr_decode_AFSCallBack(call, vnode, &bp);
 		if (call->reply[1])
@@ -628,7 +634,7 @@ static int afs_fs_fetch_data64(struct afs_fs_cursor *fc, struct afs_read *req)
 	bp[6] = 0;
 	bp[7] = htonl(lower_32_bits(req->len));
 
-	atomic_inc(&req->usage);
+	refcount_inc(&req->usage);
 	call->cb_break = fc->cb_break;
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
@@ -671,7 +677,7 @@ int afs_fs_fetch_data(struct afs_fs_cursor *fc, struct afs_read *req)
 	bp[4] = htonl(lower_32_bits(req->pos));
 	bp[5] = htonl(lower_32_bits(req->len));
 
-	atomic_inc(&req->usage);
+	refcount_inc(&req->usage);
 	call->cb_break = fc->cb_break;
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 07f450513f3e..69bcfb82dd69 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -53,11 +53,13 @@ static int afs_inode_init_from_status(struct afs_vnode *vnode, struct key *key)
 		inode->i_mode	= S_IFREG | vnode->status.mode;
 		inode->i_op	= &afs_file_inode_operations;
 		inode->i_fop	= &afs_file_operations;
+		inode->i_mapping->a_ops	= &afs_fs_aops;
 		break;
 	case AFS_FTYPE_DIR:
 		inode->i_mode	= S_IFDIR | vnode->status.mode;
 		inode->i_op	= &afs_dir_inode_operations;
 		inode->i_fop	= &afs_dir_file_operations;
+		inode->i_mapping->a_ops	= &afs_dir_aops;
 		break;
 	case AFS_FTYPE_SYMLINK:
 		/* Symlinks with a mode of 0644 are actually mountpoints. */
@@ -69,9 +71,11 @@ static int afs_inode_init_from_status(struct afs_vnode *vnode, struct key *key)
 			inode->i_mode	= S_IFDIR | 0555;
 			inode->i_op	= &afs_mntpt_inode_operations;
 			inode->i_fop	= &afs_mntpt_file_operations;
+			inode->i_mapping->a_ops	= &afs_fs_aops;
 		} else {
 			inode->i_mode	= S_IFLNK | vnode->status.mode;
 			inode->i_op	= &afs_symlink_inode_operations;
+			inode->i_mapping->a_ops	= &afs_fs_aops;
 		}
 		inode_nohighmem(inode);
 		break;
@@ -82,15 +86,9 @@ static int afs_inode_init_from_status(struct afs_vnode *vnode, struct key *key)
 	}
 
 	inode->i_blocks		= 0;
-	inode->i_mapping->a_ops	= &afs_fs_aops;
 	vnode->invalid_before	= vnode->status.data_version;
 
 	read_sequnlock_excl(&vnode->cb_lock);
-
-#ifdef CONFIG_AFS_FSCACHE
-	if (vnode->status.size > 0)
-		fscache_attr_changed(vnode->cache);
-#endif
 	return 0;
 }
 
@@ -247,6 +245,11 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 	} __packed key;
 	struct afs_vnode_cache_aux aux;
 
+	if (vnode->status.type == AFS_FTYPE_DIR) {
+		vnode->cache = NULL;
+		return;
+	}
+
 	key.vnode_id		= vnode->fid.vnode;
 	key.unique		= vnode->fid.unique;
 	key.vnode_id_ext[0]	= 0;
@@ -338,10 +341,6 @@ struct inode *afs_iget(struct super_block *sb, struct key *key,
 
 	/* failure */
 bad_inode:
-#ifdef CONFIG_AFS_FSCACHE
-	fscache_relinquish_cookie(vnode->cache, NULL, ret == -ENOENT);
-	vnode->cache = NULL;
-#endif
 	iget_failed(inode);
 	_leave(" = %d [bad]", ret);
 	return ERR_PTR(ret);
@@ -355,9 +354,6 @@ void afs_zap_data(struct afs_vnode *vnode)
 {
 	_enter("{%x:%u}", vnode->fid.vid, vnode->fid.vnode);
 
-	if (S_ISDIR(vnode->vfs_inode.i_mode))
-		afs_stat_v(vnode, n_inval);
-
 #ifdef CONFIG_AFS_FSCACHE
 	fscache_invalidate(vnode->cache);
 #endif
@@ -399,7 +395,7 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 	if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
 		if (vnode->cb_s_break != vnode->cb_interest->server->cb_s_break) {
 			vnode->cb_s_break = vnode->cb_interest->server->cb_s_break;
-		} else if (!test_bit(AFS_VNODE_DIR_MODIFIED, &vnode->flags) &&
+		} else if (test_bit(AFS_VNODE_DIR_VALID, &vnode->flags) &&
 			   !test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags) &&
 			   vnode->cb_expires_at - 10 > now) {
 				valid = true;
@@ -445,8 +441,6 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 	 * different */
 	if (test_and_clear_bit(AFS_VNODE_ZAP_DATA, &vnode->flags))
 		afs_zap_data(vnode);
-
-	clear_bit(AFS_VNODE_DIR_MODIFIED, &vnode->flags);
 	mutex_unlock(&vnode->validate_lock);
 valid:
 	_leave(" = 0");
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 3bad5b8e38dc..3a73c87e7ca8 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -174,12 +174,14 @@ struct afs_read {
 	loff_t			len;		/* How much we're asking for */
 	loff_t			actual_len;	/* How much we're actually getting */
 	loff_t			remain;		/* Amount remaining */
-	afs_dataversion_t	new_version;	/* Version number returned by server */
-	atomic_t		usage;
+	loff_t			file_size;	/* File size returned by server */
+	afs_dataversion_t	data_version;	/* Version number returned by server */
+	refcount_t		usage;
 	unsigned int		index;		/* Which page we're reading into */
 	unsigned int		nr_pages;
 	void (*page_done)(struct afs_call *, struct afs_read *);
-	struct page		*pages[];
+	struct page		**pages;
+	struct page		*array[];
 };
 
 /*
@@ -265,6 +267,7 @@ struct afs_net {
 	atomic_t		n_lookup;	/* Number of lookups done */
 	atomic_t		n_reval;	/* Number of dentries needing revalidation */
 	atomic_t		n_inval;	/* Number of invalidations by the server */
+	atomic_t		n_relpg;	/* Number of invalidations by releasepage */
 	atomic_t		n_read_dir;	/* Number of directory pages read */
 };
 
@@ -489,7 +492,7 @@ struct afs_vnode {
 	unsigned long		flags;
 #define AFS_VNODE_CB_PROMISED	0		/* Set if vnode has a callback promise */
 #define AFS_VNODE_UNSET		1		/* set if vnode attributes not yet set */
-#define AFS_VNODE_DIR_MODIFIED	2		/* set if dir vnode's data modified */
+#define AFS_VNODE_DIR_VALID	2		/* Set if dir contents are valid */
 #define AFS_VNODE_ZAP_DATA	3		/* set if vnode's data should be invalidated */
 #define AFS_VNODE_DELETED	4		/* set if vnode deleted on server */
 #define AFS_VNODE_MOUNTPOINT	5		/* set if vnode is a mountpoint symlink */
@@ -669,9 +672,9 @@ extern bool afs_cm_incoming_call(struct afs_call *);
  */
 extern const struct file_operations afs_dir_file_operations;
 extern const struct inode_operations afs_dir_inode_operations;
+extern const struct address_space_operations afs_dir_aops;
 extern const struct dentry_operations afs_fs_dentry_operations;
 
-extern bool afs_dir_check_page(struct inode *, struct page *);
 extern void afs_d_release(struct dentry *);
 
 /*
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index e1e13a568845..090fa8c30ea8 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -890,10 +890,11 @@ static int afs_proc_stats_show(struct seq_file *m, void *v)
 
 	seq_puts(m, "kAFS statistics\n");
 
-	seq_printf(m, "dir-mgmt: look=%u reval=%u inval=%u\n",
+	seq_printf(m, "dir-mgmt: look=%u reval=%u inval=%u relpg=%u\n",
 		   atomic_read(&net->n_lookup),
 		   atomic_read(&net->n_reval),
-		   atomic_read(&net->n_inval));
+		   atomic_read(&net->n_inval),
+		   atomic_read(&net->n_relpg));
 
 	seq_printf(m, "dir-data: rdpg=%u\n",
 		   atomic_read(&net->n_read_dir));
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 9370e2feb999..70a563c14e6f 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -42,10 +42,11 @@ static int afs_fill_page(struct afs_vnode *vnode, struct key *key,
 	if (!req)
 		return -ENOMEM;
 
-	atomic_set(&req->usage, 1);
+	refcount_set(&req->usage, 1);
 	req->pos = pos;
 	req->len = len;
 	req->nr_pages = 1;
+	req->pages = req->array;
 	req->pages[0] = page;
 	get_page(page);
 
