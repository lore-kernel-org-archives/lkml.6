Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAFBC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDC621A27
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDC621A27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbeHFP01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:26:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729714AbeHFP00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:26:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 999F5406E8C4;
        Mon,  6 Aug 2018 13:17:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D8B42026D74;
        Mon,  6 Aug 2018 13:17:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/10] afs: Set up the iov_iter before calling
 afs_extract_data()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew@wil.cx
Date:   Mon, 06 Aug 2018 14:17:19 +0100
Message-ID: <153356143950.1195.15275056515173761816.stgit@warthog.procyon.org.uk>
In-Reply-To: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
References: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 06 Aug 2018 13:17:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 06 Aug 2018 13:17:21 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

afs_extract_data sets up a temporary iov_iter and passes it to AF_RXRPC
each time it is called to describe the remaining buffer to be filled.

Instead:

 (1) Put an iterator in the afs_call struct.

 (2) Set the iterator for each marshalling stage to load data into the
     appropriate places.  A number of convenience functions are provided to
     this end (eg. afs_extract_to_buf()).

     This iterator is then passed to afs_extract_data().

 (3) Use the new ITER_MAPPING iterator when reading data to load directly
     into the inode's pages without needing to create a list of them.  This
     comes with a page-done callback that can be used to unlock pages as
     they are filled.

 (4) Use the new ITER_DISCARD iterator to discard any excess data provided
     by FetchData.

This will allow O_DIRECT calls to be supported in future patches.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cmservice.c         |   40 +++----
 fs/afs/dir.c               |  193 +++++++++++++++++++++++-----------
 fs/afs/file.c              |  200 +++++++++++++++++++++++------------
 fs/afs/fsclient.c          |  252 ++++++++++++--------------------------------
 fs/afs/internal.h          |   52 ++++++++-
 fs/afs/rxrpc.c             |   41 ++-----
 fs/afs/vlclient.c          |  104 ++++++++----------
 fs/afs/write.c             |    8 +
 include/linux/fscache.h    |   31 +++++
 include/trace/events/afs.h |   22 ++--
 10 files changed, 502 insertions(+), 441 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 58f79301a716..4db62ae8dc1a 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -176,13 +176,13 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
 		/* extract the FID array and its count in two steps */
 	case 1:
 		_debug("extract FID count");
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -196,13 +196,12 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 				       GFP_KERNEL);
 		if (!call->buffer)
 			return -ENOMEM;
-		call->offset = 0;
+		afs_extract_to_buf(call, call->count * 3 * 4);
 		call->unmarshall++;
 
 	case 2:
 		_debug("extract FID array");
-		ret = afs_extract_data(call, call->buffer,
-				       call->count * 3 * 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -222,13 +221,13 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 			cb->cb.type	= AFSCM_CB_UNTYPED;
 		}
 
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
 		/* extract the callback array and its count in two steps */
 	case 3:
 		_debug("extract CB count");
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -237,13 +236,12 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 		if (call->count2 != call->count && call->count2 != 0)
 			return afs_protocol_error(call, -EBADMSG,
 						  afs_eproto_cb_count);
-		call->offset = 0;
+		afs_extract_to_buf(call, call->count2 * 3 * 4);
 		call->unmarshall++;
 
 	case 4:
 		_debug("extract CB array");
-		ret = afs_extract_data(call, call->buffer,
-				       call->count2 * 3 * 4, false);
+		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
 
@@ -256,7 +254,6 @@ static int afs_deliver_cb_callback(struct afs_call *call)
 			cb->cb.type	= ntohl(*bp++);
 		}
 
-		call->offset = 0;
 		call->unmarshall++;
 	case 5:
 		break;
@@ -303,7 +300,8 @@ static int afs_deliver_cb_init_call_back_state(struct afs_call *call)
 
 	rxrpc_kernel_get_peer(call->net->socket, call->rxcall, &srx);
 
-	ret = afs_extract_data(call, NULL, 0, false);
+	afs_extract_discard(call, 0);
+	ret = afs_extract_data(call, false);
 	if (ret < 0)
 		return ret;
 
@@ -332,16 +330,15 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
 		call->buffer = kmalloc_array(11, sizeof(__be32), GFP_KERNEL);
 		if (!call->buffer)
 			return -ENOMEM;
+		afs_extract_to_buf(call, 11 * sizeof(__be32));
 		call->unmarshall++;
 
 	case 1:
 		_debug("extract UUID");
-		ret = afs_extract_data(call, call->buffer,
-				       11 * sizeof(__be32), false);
+		ret = afs_extract_data(call, false);
 		switch (ret) {
 		case 0:		break;
 		case -EAGAIN:	return 0;
@@ -364,7 +361,6 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 		for (loop = 0; loop < 6; loop++)
 			r->node[loop] = ntohl(b[loop + 5]);
 
-		call->offset = 0;
 		call->unmarshall++;
 
 	case 2:
@@ -407,7 +403,8 @@ static int afs_deliver_cb_probe(struct afs_call *call)
 
 	_enter("");
 
-	ret = afs_extract_data(call, NULL, 0, false);
+	afs_extract_discard(call, 0);
+	ret = afs_extract_data(call, false);
 	if (ret < 0)
 		return ret;
 
@@ -455,16 +452,15 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
 		call->buffer = kmalloc_array(11, sizeof(__be32), GFP_KERNEL);
 		if (!call->buffer)
 			return -ENOMEM;
+		afs_extract_to_buf(call, 11 * sizeof(__be32));
 		call->unmarshall++;
 
 	case 1:
 		_debug("extract UUID");
-		ret = afs_extract_data(call, call->buffer,
-				       11 * sizeof(__be32), false);
+		ret = afs_extract_data(call, false);
 		switch (ret) {
 		case 0:		break;
 		case -EAGAIN:	return 0;
@@ -487,7 +483,6 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 		for (loop = 0; loop < 6; loop++)
 			r->node[loop] = ntohl(b[loop + 5]);
 
-		call->offset = 0;
 		call->unmarshall++;
 
 	case 2:
@@ -572,7 +567,8 @@ static int afs_deliver_cb_tell_me_about_yourself(struct afs_call *call)
 
 	_enter("");
 
-	ret = afs_extract_data(call, NULL, 0, false);
+	afs_extract_discard(call, 0);
+	ret = afs_extract_data(call, false);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 7d623008157f..1357a10804bb 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -105,6 +105,41 @@ struct afs_lookup_cookie {
 	struct afs_fid		fids[50];
 };
 
+/*
+ * Drop the refs that we're holding on the pages we were reading into.  We've
+ * got refs on the first nr_pages pages.
+ */
+static void afs_dir_read_cleanup(struct afs_read *req)
+{
+	struct radix_tree_iter iter;
+	struct address_space *mapping = req->iter.mapping;
+	struct page *page;
+	pgoff_t index = req->pos >> PAGE_SHIFT;
+	void __rcu **slot;
+
+	if (unlikely(!req->nr_pages))
+		return;
+
+	rcu_read_lock();
+	radix_tree_for_each_contig(slot, &mapping->i_pages, &iter, index) {
+		page = radix_tree_deref_slot(slot);
+		if (unlikely(!page))
+			continue;
+
+		BUG_ON(radix_tree_exception(page));
+		BUG_ON(PageCompound(page));
+		BUG_ON(page->mapping != req->iter.mapping);
+		BUG_ON(page_to_pgoff(page) != iter.index);
+
+		put_page(page);
+		req->nr_pages--;
+		if (req->nr_pages == 0)
+			break;
+	}
+
+	rcu_read_unlock();
+}
+
 /*
  * check that a directory page is valid
  */
@@ -130,7 +165,7 @@ static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *page,
 	qty /= sizeof(union afs_xdr_dir_block);
 
 	/* check them */
-	dbuf = kmap(page);
+	dbuf = kmap_atomic(page);
 	for (tmp = 0; tmp < qty; tmp++) {
 		if (dbuf->blocks[tmp].hdr.magic != AFS_DIR_MAGIC) {
 			printk("kAFS: %s(%lx): bad magic %d/%d is %04hx\n",
@@ -148,7 +183,7 @@ static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *page,
 		((u8 *)&dbuf->blocks[tmp])[AFS_DIR_BLOCK_SIZE - 1] = 0;
 	}
 
-	kunmap(page);
+	kunmap_atomic(dbuf);
 
 checked:
 	afs_stat_v(dvnode, n_read_dir);
@@ -158,6 +193,46 @@ static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *page,
 	return false;
 }
 
+/*
+ * Check all the pages in a directory.  All the pages are held pinned.
+ */
+static int afs_dir_check(struct afs_vnode *dvnode, unsigned int nr_pages,
+			 loff_t i_size)
+{
+	struct radix_tree_iter iter;
+	struct address_space *mapping = dvnode->vfs_inode.i_mapping;
+	struct page *page;
+	void __rcu **slot;
+	int ret = 0;
+
+	if (unlikely(!nr_pages))
+		return 0;
+
+	rcu_read_lock();
+	radix_tree_for_each_contig(slot, &mapping->i_pages, &iter, 0) {
+		page = radix_tree_deref_slot(slot);
+		if (unlikely(!page)) {
+			pr_warn("kAFS: Missing page in dircheck\n");
+			ret = -EIO;
+			break;
+		}
+		if (page->index >= nr_pages)
+			break;
+
+		BUG_ON(radix_tree_exception(page));
+		BUG_ON(PageCompound(page));
+		BUG_ON(page->mapping != mapping);
+		BUG_ON(page_to_pgoff(page) != iter.index);
+
+		ret = afs_dir_check_page(dvnode, page, i_size);
+		if (ret < 0)
+			break;
+	}
+
+	rcu_read_unlock();
+	return ret;
+}
+
 /*
  * open an AFS directory file
  */
@@ -184,56 +259,49 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 {
 	struct afs_read *req;
 	loff_t i_size;
-	int nr_pages, nr_inline, i, n;
-	int ret = -ENOMEM;
+	int nr_pages, i, n;
+	int ret;
+
+	_enter("");
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return ERR_PTR(-ENOMEM);
+
+	refcount_set(&req->usage, 1);
+	req->cleanup = afs_dir_read_cleanup;
 
-retry:
+expand:
 	i_size = i_size_read(&dvnode->vfs_inode);
+	ret = -EIO;
 	if (i_size < 2048)
-		return ERR_PTR(-EIO);
+		goto error;
+	ret = -EFBIG;
 	if (i_size > 2048 * 1024)
-		return ERR_PTR(-EFBIG);
-
-	_enter("%llu", i_size);
+		goto error;
 
-	/* Get a request record to hold the page list.  We want to hold it
-	 * inline if we can, but we don't want to make an order 1 allocation.
-	 */
 	nr_pages = (i_size + PAGE_SIZE - 1) / PAGE_SIZE;
-	nr_inline = nr_pages;
-	if (nr_inline > (PAGE_SIZE - sizeof(*req)) / sizeof(struct page *))
-		nr_inline = 0;
 
-	req = kzalloc(sizeof(*req) + sizeof(struct page *) * nr_inline,
-		      GFP_KERNEL);
-	if (!req)
-		return ERR_PTR(-ENOMEM);
-
-	refcount_set(&req->usage, 1);
-	req->nr_pages = nr_pages;
 	req->actual_len = i_size; /* May change */
 	req->len = nr_pages * PAGE_SIZE; /* We can ask for more than there is */
 	req->data_version = dvnode->status.data_version; /* May change */
-	if (nr_inline > 0) {
-		req->pages = req->array;
-	} else {
-		req->pages = kcalloc(nr_pages, sizeof(struct page *),
-				     GFP_KERNEL);
-		if (!req->pages)
-			goto error;
-	}
+	iov_iter_mapping(&req->iter, READ, dvnode->vfs_inode.i_mapping,
+			 0, i_size);
 
-	/* Get a list of all the pages that hold or will hold the directory
-	 * content.  We need to fill in any gaps that we might find where the
-	 * memory reclaimer has been at work.  If there are any gaps, we will
+	/* Fill in any gaps that we might find where the memory reclaimer has
+	 * been at work and pin all the pages.  If there are any gaps, we will
 	 * need to reread the entire directory contents.
 	 */
-	i = 0;
-	do {
+	i = req->nr_pages;
+	while (i < nr_pages) {
+		struct page *pages[8], *page;
+
 		n = find_get_pages_contig(dvnode->vfs_inode.i_mapping, i,
-					  req->nr_pages - i,
-					  req->pages + i);
-		_debug("find %u at %u/%u", n, i, req->nr_pages);
+					  min_t(unsigned int, nr_pages - i,
+						ARRAY_SIZE(pages)),
+					  pages);
+		_debug("find %u at %u/%u", n, i, nr_pages);
+
 		if (n == 0) {
 			gfp_t gfp = dvnode->vfs_inode.i_mapping->gfp_mask;
 
@@ -241,23 +309,25 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 				afs_stat_v(dvnode, n_inval);
 
 			ret = -ENOMEM;
-			req->pages[i] = __page_cache_alloc(gfp);
-			if (!req->pages[i])
+			page = __page_cache_alloc(gfp);
+			if (!page)
 				goto error;
-			ret = add_to_page_cache_lru(req->pages[i],
+			ret = add_to_page_cache_lru(page,
 						    dvnode->vfs_inode.i_mapping,
 						    i, gfp);
 			if (ret < 0)
 				goto error;
 
-			set_page_private(req->pages[i], 1);
-			SetPagePrivate(req->pages[i]);
-			unlock_page(req->pages[i]);
+			set_page_private(page, 1);
+			SetPagePrivate(page);
+			unlock_page(page);
+			req->nr_pages++;
 			i++;
 		} else {
+			req->nr_pages += n;
 			i += n;
 		}
-	} while (i < req->nr_pages);
+	}
 
 	/* If we're going to reload, we need to lock all the pages to prevent
 	 * races.
@@ -280,15 +350,18 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 
 		task_io_account_read(PAGE_SIZE * req->nr_pages);
 
-		if (req->len < req->file_size)
-			goto content_has_grown;
+		if (req->len < req->file_size) {
+			/* The content has grown, so we need to expand the
+			 * buffer.
+			 */
+			up_write(&dvnode->validate_lock);
+			goto expand;
+		}
 
 		/* Validate the data we just read. */
-		ret = -EIO;
-		for (i = 0; i < req->nr_pages; i++)
-			if (!afs_dir_check_page(dvnode, req->pages[i],
-						req->actual_len))
-				goto error_unlock;
+		ret = afs_dir_check(dvnode, req->nr_pages, req->actual_len);
+		if (ret < 0)
+			goto error_unlock;
 
 		// TODO: Trim excess pages
 
@@ -305,11 +378,6 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 	afs_put_read(req);
 	_leave(" = %d", ret);
 	return ERR_PTR(ret);
-
-content_has_grown:
-	up_write(&dvnode->validate_lock);
-	afs_put_read(req);
-	goto retry;
 }
 
 /*
@@ -415,6 +483,7 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 	struct afs_read *req;
 	struct page *page;
 	unsigned blkoff, limit;
+	void __rcu **slot;
 	int ret;
 
 	_enter("{%lu},%u,,", dir->i_ino, (unsigned)ctx->pos);
@@ -438,9 +507,15 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 		blkoff = ctx->pos & ~(sizeof(union afs_xdr_dir_block) - 1);
 
 		/* Fetch the appropriate page from the directory and re-add it
-		 * to the LRU.
+		 * to the LRU.  We have all the pages pinned with an extra ref.
 		 */
-		page = req->pages[blkoff / PAGE_SIZE];
+		rcu_read_lock();
+		page = NULL;
+		slot = radix_tree_lookup_slot(&dvnode->vfs_inode.i_mapping->i_pages,
+					      blkoff / PAGE_SIZE);
+		if (slot)
+			page = radix_tree_deref_slot(slot);
+		rcu_read_unlock();
 		if (!page) {
 			ret = -EIO;
 			break;
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 7d4f26198573..6d55dabccd79 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -148,7 +148,7 @@ int afs_open(struct inode *inode, struct file *file)
 
 	if (file->f_flags & O_TRUNC)
 		set_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
-	
+
 	file->private_data = af;
 	_leave(" = 0");
 	return 0;
@@ -185,24 +185,80 @@ int afs_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+/*
+ * Make pages available as they're filled.  This function may not sleep.
+ */
+static void afs_readpages_page_done(const struct iov_iter *iter,
+				    const struct bio_vec *bv)
+{
+	struct page *page = bv->bv_page;
+	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
+	struct afs_read *req = container_of(iter, struct afs_read, iter);
+
+	SetPageUptodate(page);
+
+	if (0 && afs_vnode_cache(vnode))
+		SetPageFsCache(page);
+	unlock_page(page);
+	put_page(page);
+	req->done_pages++;
+}
+
+/*
+ * Unlock the pages we were reading into.  We've got locks and refs on the
+ * first nr_pages pages.
+ */
+static void afs_file_read_cleanup(struct afs_read *req)
+{
+	struct radix_tree_iter iter;
+	struct address_space *mapping = req->iter.mapping;
+	struct page *page;
+	pgoff_t index = req->pos >> PAGE_SHIFT;
+	void **slot;
+
+	_enter("%lu,%u,%u,%llu",
+	       index, req->done_pages, req->nr_pages, iov_iter_count(&req->iter));
+
+	if (likely(req->done_pages >= req->nr_pages))
+		return;
+
+	rcu_read_lock();
+	radix_tree_for_each_contig(slot, &mapping->i_pages, &iter, index) {
+		page = radix_tree_deref_slot(slot);
+		if (unlikely(!page))
+			continue;
+
+		BUG_ON(radix_tree_exception(page));
+		BUG_ON(PageCompound(page));
+		BUG_ON(page != *slot);
+		BUG_ON(page->mapping != req->iter.mapping);
+		BUG_ON(page_to_pgoff(page) != iter.index);
+
+		if (req->error)
+			SetPageError(page);
+		unlock_page(page);
+		put_page(page);
+		req->done_pages++;
+		if (req->done_pages >= req->nr_pages)
+			break;
+	}
+
+	rcu_read_unlock();
+}
+
 /*
  * Dispose of a ref to a read record.
  */
 void afs_put_read(struct afs_read *req)
 {
-	int i;
-
 	if (refcount_dec_and_test(&req->usage)) {
-		for (i = 0; i < req->nr_pages; i++)
-			if (req->pages[i])
-				put_page(req->pages[i]);
-		if (req->pages != req->array)
-			kfree(req->pages);
+		if (req->cleanup)
+			req->cleanup(req);
 		kfree(req);
 	}
 }
 
-#ifdef CONFIG_AFS_FSCACHE
+#if 0 //def CONFIG_AFS_FSCACHE
 /*
  * deal with notification that a page was read from the cache
  */
@@ -257,6 +313,22 @@ int afs_fetch_data(struct afs_vnode *vnode, struct key *key, struct afs_read *de
 	return ret;
 }
 
+/*
+ * Clear the trailer after a short read.
+ */
+static void afs_clear_after_read(struct afs_vnode *vnode, struct afs_read *req,
+				 bool catch_page_done)
+{
+	if (req->actual_len >= req->len)
+		return;
+	iov_iter_mapping(&req->iter, READ, vnode->vfs_inode.i_mapping,
+			 req->pos + req->actual_len,
+			 req->len - req->actual_len);
+	if (catch_page_done)
+		req->iter.page_done = afs_readpages_page_done;
+	iov_iter_zero(req->len - req->actual_len, &req->iter);
+}
+
 /*
  * read page from file, directory or symlink, given a key to use
  */
@@ -277,7 +349,7 @@ int afs_page_filler(void *data, struct page *page)
 		goto error;
 
 	/* is it cached? */
-#ifdef CONFIG_AFS_FSCACHE
+#if 0 //def CONFIG_AFS_FSCACHE
 	ret = fscache_read_or_alloc_page(vnode->cache,
 					 page,
 					 afs_file_readpage_read_complete,
@@ -301,8 +373,7 @@ int afs_page_filler(void *data, struct page *page)
 		_debug("cache said ENOBUFS");
 	default:
 	go_on:
-		req = kzalloc(sizeof(struct afs_read) + sizeof(struct page *),
-			      GFP_KERNEL);
+		req = kzalloc(sizeof(struct afs_read), GFP_KERNEL);
 		if (!req)
 			goto enomem;
 
@@ -314,10 +385,11 @@ int afs_page_filler(void *data, struct page *page)
 		req->pos = (loff_t)page->index << PAGE_SHIFT;
 		req->len = PAGE_SIZE;
 		req->nr_pages = 1;
-		req->pages = req->array;
-		req->pages[0] = page;
 		get_page(page);
 
+		iov_iter_mapping(&req->iter, READ, page->mapping,
+				 (loff_t)page->index << PAGE_SHIFT, PAGE_SIZE);
+
 		/* read the contents of the file from the server into the
 		 * page */
 		ret = afs_fetch_data(vnode, key, req);
@@ -331,11 +403,6 @@ int afs_page_filler(void *data, struct page *page)
 				ret = -ESTALE;
 			}
 
-#ifdef CONFIG_AFS_FSCACHE
-			fscache_uncache_page(vnode->cache, page);
-#endif
-			BUG_ON(PageFsCache(page));
-
 			if (ret == -EINTR ||
 			    ret == -ENOMEM ||
 			    ret == -ERESTARTSYS ||
@@ -344,10 +411,11 @@ int afs_page_filler(void *data, struct page *page)
 			goto io_error;
 		}
 
+		afs_clear_after_read(vnode, req, false);
 		SetPageUptodate(page);
 
 		/* send the page to the cache */
-#ifdef CONFIG_AFS_FSCACHE
+#if 0 //def CONFIG_AFS_FSCACHE
 		if (PageFsCache(page) &&
 		    fscache_write_page(vnode->cache, page, vnode->status.size,
 				       GFP_KERNEL) != 0) {
@@ -398,31 +466,39 @@ static int afs_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
+#if 0
 /*
- * Make pages available as they're filled.
+ * Allow writing to a page to take place.  This function may not sleep.
  */
-static void afs_readpages_page_done(struct afs_call *call, struct afs_read *req)
+static void afs_clear_page_fscache_mark(const struct iov_iter *iter,
+					struct page *page)
 {
-#ifdef CONFIG_AFS_FSCACHE
-	struct afs_vnode *vnode = call->reply[0];
-#endif
-	struct page *page = req->pages[req->index];
+	ClearPageFsCache(page);
+}
 
-	req->pages[req->index] = NULL;
-	SetPageUptodate(page);
+static void afs_fscache_write_done(struct fscache_cookie *cookie,
+				   struct iov_iter *iter)
+{
+	struct afs_read *req = container_of(iter, struct afs_read, iter);
+
+	afs_put_read(req);
+}
+
+/*
+ * Write the read data to the cache.
+ */
+static void afs_readpages_write_to_cache(struct afs_read *req)
+{
+	struct afs_vnode *vnode = AFS_FS_I(req->iter.mapping->host);
 
-	/* send the page to the cache */
-#ifdef CONFIG_AFS_FSCACHE
-	if (PageFsCache(page) &&
-	    fscache_write_page(vnode->cache, page, vnode->status.size,
-			       GFP_KERNEL) != 0) {
-		fscache_uncache_page(vnode->cache, page);
-		BUG_ON(PageFsCache(page));
+	if (afs_vnode_cache(vnode)) {
+		req->iter.page_done = afs_clear_page_fscache_mark;
+		fscache_write(vnode->cache, &req->iter, req->pos,
+			      req->file_size, GFP_KERNEL,
+			      afs_fscache_write_done);
 	}
-#endif
-	unlock_page(page);
-	put_page(page);
 }
+#endif
 
 /*
  * Read a contiguous set of pages.
@@ -436,7 +512,7 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 	struct page *first, *page;
 	struct key *key = afs_file_key(file);
 	pgoff_t index;
-	int ret, n, i;
+	int ret, n;
 
 	/* Count the number of contiguous pages at the front of the list.  Note
 	 * that the list goes prev-wards rather than next-wards.
@@ -452,20 +528,17 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 		n++;
 	}
 
-	req = kzalloc(sizeof(struct afs_read) + sizeof(struct page *) * n,
-		      GFP_NOFS);
+	req = kzalloc(sizeof(struct afs_read), GFP_NOFS);
 	if (!req)
 		return -ENOMEM;
 
 	refcount_set(&req->usage, 1);
-	req->page_done = afs_readpages_page_done;
+	req->cleanup = afs_file_read_cleanup;
 	req->pos = first->index;
 	req->pos <<= PAGE_SHIFT;
-	req->pages = req->array;
 
-	/* Transfer the pages to the request.  We add them in until one fails
-	 * to add to the LRU and then we stop (as that'll make a hole in the
-	 * contiguous run.
+	/* Add pages to the LRU until it fails.  We keep the pages ref'd and
+	 * locked until the read is complete.
 	 *
 	 * Note that it's possible for the file size to change whilst we're
 	 * doing this, but we rely on the server returning less than we asked
@@ -478,15 +551,11 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 		index = page->index;
 		if (add_to_page_cache_lru(page, mapping, index,
 					  readahead_gfp_mask(mapping))) {
-#ifdef CONFIG_AFS_FSCACHE
-			fscache_uncache_page(vnode->cache, page);
-#endif
 			put_page(page);
 			break;
 		}
 
-		req->pages[req->nr_pages++] = page;
-		req->len += PAGE_SIZE;
+		req->nr_pages++;
 	} while (req->nr_pages < n);
 
 	if (req->nr_pages == 0) {
@@ -494,33 +563,26 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 		return 0;
 	}
 
+	req->len = req->nr_pages * PAGE_SIZE;
+	iov_iter_mapping(&req->iter, READ, file->f_mapping, req->pos, req->len);
+	req->iter.page_done = afs_readpages_page_done;
+
 	ret = afs_fetch_data(vnode, key, req);
 	if (ret < 0)
 		goto error;
 
-	task_io_account_read(PAGE_SIZE * req->nr_pages);
-	afs_put_read(req);
+	afs_clear_after_read(vnode, req, true);
+	task_io_account_read(req->len);
 	return 0;
 
 error:
 	if (ret == -ENOENT) {
-		_debug("got NOENT from server"
-		       " - marking file deleted and stale");
+		_debug("got NOENT from server - marking file deleted and stale");
 		set_bit(AFS_VNODE_DELETED, &vnode->flags);
 		ret = -ESTALE;
 	}
 
-	for (i = 0; i < req->nr_pages; i++) {
-		page = req->pages[i];
-		if (page) {
-#ifdef CONFIG_AFS_FSCACHE
-			fscache_uncache_page(vnode->cache, page);
-#endif
-			SetPageError(page);
-			unlock_page(page);
-		}
-	}
-
+	req->error = true;
 	afs_put_read(req);
 	return ret;
 }
@@ -547,7 +609,7 @@ static int afs_readpages(struct file *file, struct address_space *mapping,
 	}
 
 	/* attempt to read as many of the pages as possible */
-#ifdef CONFIG_AFS_FSCACHE
+#if 0 //def CONFIG_AFS_FSCACHE
 	ret = fscache_read_or_alloc_pages(vnode->cache,
 					  mapping,
 					  pages,
@@ -605,7 +667,7 @@ static void afs_invalidatepage(struct page *page, unsigned int offset,
 
 	/* we clean up only if the entire page is being invalidated */
 	if (offset == 0 && length == PAGE_SIZE) {
-#ifdef CONFIG_AFS_FSCACHE
+#if 0 //def CONFIG_AFS_FSCACHE
 		if (PageFsCache(page)) {
 			struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
 			fscache_wait_on_page_write(vnode->cache, page);
@@ -640,7 +702,7 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 
 	/* deny if page is being written to the cache and the caller hasn't
 	 * elected to wait */
-#ifdef CONFIG_AFS_FSCACHE
+#if 0 //def CONFIG_AFS_FSCACHE
 	if (!fscache_maybe_release_page(vnode->cache, page, gfp_flags)) {
 		_leave(" = F [cache busy]");
 		return 0;
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index d9a5815945dc..eb60c570dca2 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -20,12 +20,6 @@
 
 static const struct afs_fid afs_zero_fid;
 
-/*
- * We need somewhere to discard into in case the server helpfully returns more
- * than we asked for in FS.FetchData{,64}.
- */
-static u8 afs_discard_buffer[64];
-
 static inline void afs_use_fs_server(struct afs_call *call, struct afs_cb_interest *cbi)
 {
 	call->cbi = afs_get_cb_interest(cbi);
@@ -468,115 +462,82 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 	struct afs_vnode *vnode = call->reply[0];
 	struct afs_read *req = call->reply[2];
 	const __be32 *bp;
-	unsigned int size;
-	void *buffer;
 	int ret;
 
-	_enter("{%u,%zu/%u;%llu/%llu}",
-	       call->unmarshall, call->offset, call->count,
-	       req->remain, req->actual_len);
+	_enter("{%u,%llu/%llu}",
+	       call->unmarshall, iov_iter_count(&call->iter), req->actual_len);
 
 	switch (call->unmarshall) {
 	case 0:
 		req->actual_len = 0;
-		call->offset = 0;
 		call->unmarshall++;
 		if (call->operation_ID != FSFETCHDATA64) {
 			call->unmarshall++;
 			goto no_msw;
 		}
+		afs_extract_to_tmp(call);
 
 		/* extract the upper part of the returned data length of an
-		 * FSFETCHDATA64 op (which should always be 0 using this
-		 * client) */
+		 * FSFETCHDATA64 op.
+		 */
 	case 1:
 		_debug("extract data length (MSW)");
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
 		req->actual_len = ntohl(call->tmp);
 		req->actual_len <<= 32;
-		call->offset = 0;
 		call->unmarshall++;
-
 	no_msw:
+		afs_extract_to_tmp(call);
+
 		/* extract the returned data length */
 	case 2:
 		_debug("extract data length");
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
 		req->actual_len |= ntohl(call->tmp);
 		_debug("DATA length: %llu", req->actual_len);
 
-		req->remain = req->actual_len;
-		call->offset = req->pos & (PAGE_SIZE - 1);
-		req->index = 0;
 		if (req->actual_len == 0)
 			goto no_more_data;
 		call->unmarshall++;
-
-	begin_page:
-		ASSERTCMP(req->index, <, req->nr_pages);
-		if (req->remain > PAGE_SIZE - call->offset)
-			size = PAGE_SIZE - call->offset;
-		else
-			size = req->remain;
-		call->count = call->offset + size;
-		ASSERTCMP(call->count, <=, PAGE_SIZE);
-		req->remain -= size;
+		call->_iter = &req->iter;
+		iov_iter_truncate(&req->iter, req->actual_len);
 
 		/* extract the returned data */
 	case 3:
-		_debug("extract data %llu/%llu %zu/%u",
-		       req->remain, req->actual_len, call->offset, call->count);
+		_debug("extract data %llu/%llu",
+		       iov_iter_count(&call->iter), req->actual_len);
 
-		buffer = kmap(req->pages[req->index]);
-		ret = afs_extract_data(call, buffer, call->count, true);
-		kunmap(req->pages[req->index]);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
-		if (call->offset == PAGE_SIZE) {
-			if (req->page_done)
-				req->page_done(call, req);
-			req->index++;
-			if (req->remain > 0) {
-				call->offset = 0;
-				if (req->index >= req->nr_pages) {
-					call->unmarshall = 4;
-					goto begin_discard;
-				}
-				goto begin_page;
-			}
-		}
-		goto no_more_data;
+
+		call->_iter = &call->iter;
+		if (req->actual_len <= req->len)
+			goto no_more_data;
 
 		/* Discard any excess data the server gave us */
-	begin_discard:
+		iov_iter_discard(&call->iter, READ, req->actual_len - req->len);
 	case 4:
-		size = min_t(loff_t, sizeof(afs_discard_buffer), req->remain);
-		call->count = size;
-		_debug("extract discard %llu/%llu %zu/%u",
-		       req->remain, req->actual_len, call->offset, call->count);
-
-		call->offset = 0;
-		ret = afs_extract_data(call, afs_discard_buffer, call->count, true);
-		req->remain -= call->offset;
+		_debug("extract discard %llu/%llu",
+		       iov_iter_count(&call->iter), req->actual_len - req->len);
+
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
-		if (req->remain > 0)
-			goto begin_discard;
 
 	no_more_data:
-		call->offset = 0;
 		call->unmarshall = 5;
+		afs_extract_to_buf(call, (21 + 3 + 6) * 4);
 
 		/* extract the metadata */
 	case 5:
-		ret = afs_extract_data(call, call->buffer,
-				       (21 + 3 + 6) * 4, false);
+		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
 
@@ -589,22 +550,12 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		if (call->reply[1])
 			xdr_decode_AFSVolSync(&bp, call->reply[1]);
 
-		call->offset = 0;
 		call->unmarshall++;
 
 	case 6:
 		break;
 	}
 
-	for (; req->index < req->nr_pages; req->index++) {
-		if (call->count < PAGE_SIZE)
-			zero_user_segment(req->pages[req->index],
-					  call->count, PAGE_SIZE);
-		if (req->page_done)
-			req->page_done(call, req);
-		call->count = 0;
-	}
-
 	_leave(" = 0 [done]");
 	return 0;
 }
@@ -700,6 +651,7 @@ int afs_fs_fetch_data(struct afs_fs_cursor *fc, struct afs_read *req)
 	call->reply[1] = NULL; /* volsync */
 	call->reply[2] = req;
 	call->expected_version = vnode->status.data_version;
+	req->call_debug_id = call->debug_id;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1598,31 +1550,31 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 {
 	const __be32 *bp;
 	char *p;
+	u32 size;
 	int ret;
 
 	_enter("{%u}", call->unmarshall);
 
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
 		call->unmarshall++;
+		afs_extract_to_buf(call, 12 * 4);
 
 		/* extract the returned status record */
 	case 1:
 		_debug("extract status");
-		ret = afs_extract_data(call, call->buffer,
-				       12 * 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
 		bp = call->buffer;
 		xdr_decode_AFSFetchVolumeStatus(&bp, call->reply[1]);
-		call->offset = 0;
 		call->unmarshall++;
+		afs_extract_to_tmp(call);
 
 		/* extract the volume name length */
 	case 2:
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -1631,46 +1583,26 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		if (call->count >= AFSNAMEMAX)
 			return afs_protocol_error(call, -EBADMSG,
 						  afs_eproto_volname_len);
-		call->offset = 0;
+		size = (call->count + 3) & ~3; /* It's padded */
+		afs_extract_begin(call, call->reply[2], size);
 		call->unmarshall++;
 
 		/* extract the volume name */
 	case 3:
 		_debug("extract volname");
-		if (call->count > 0) {
-			ret = afs_extract_data(call, call->reply[2],
-					       call->count, true);
-			if (ret < 0)
-				return ret;
-		}
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
 
 		p = call->reply[2];
 		p[call->count] = 0;
 		_debug("volname '%s'", p);
-
-		call->offset = 0;
-		call->unmarshall++;
-
-		/* extract the volume name padding */
-		if ((call->count & 3) == 0) {
-			call->unmarshall++;
-			goto no_volname_padding;
-		}
-		call->count = 4 - (call->count & 3);
-
-	case 4:
-		ret = afs_extract_data(call, call->buffer,
-				       call->count, true);
-		if (ret < 0)
-			return ret;
-
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 		call->unmarshall++;
-	no_volname_padding:
 
 		/* extract the offline message length */
-	case 5:
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+	case 4:
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -1679,46 +1611,27 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		if (call->count >= AFSNAMEMAX)
 			return afs_protocol_error(call, -EBADMSG,
 						  afs_eproto_offline_msg_len);
-		call->offset = 0;
+		size = (call->count + 3) & ~3; /* It's padded */
+		afs_extract_begin(call, call->reply[2], size);
 		call->unmarshall++;
 
 		/* extract the offline message */
-	case 6:
+	case 5:
 		_debug("extract offline");
-		if (call->count > 0) {
-			ret = afs_extract_data(call, call->reply[2],
-					       call->count, true);
-			if (ret < 0)
-				return ret;
-		}
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
 
 		p = call->reply[2];
 		p[call->count] = 0;
 		_debug("offline '%s'", p);
 
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
-		/* extract the offline message padding */
-		if ((call->count & 3) == 0) {
-			call->unmarshall++;
-			goto no_offline_padding;
-		}
-		call->count = 4 - (call->count & 3);
-
-	case 7:
-		ret = afs_extract_data(call, call->buffer,
-				       call->count, true);
-		if (ret < 0)
-			return ret;
-
-		call->offset = 0;
-		call->unmarshall++;
-	no_offline_padding:
-
 		/* extract the message of the day length */
-	case 8:
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+	case 6:
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -1727,38 +1640,24 @@ static int afs_deliver_fs_get_volume_status(struct afs_call *call)
 		if (call->count >= AFSNAMEMAX)
 			return afs_protocol_error(call, -EBADMSG,
 						  afs_eproto_motd_len);
-		call->offset = 0;
+		size = (call->count + 3) & ~3; /* It's padded */
+		afs_extract_begin(call, call->reply[2], size);
 		call->unmarshall++;
 
 		/* extract the message of the day */
-	case 9:
+	case 7:
 		_debug("extract motd");
-		if (call->count > 0) {
-			ret = afs_extract_data(call, call->reply[2],
-					       call->count, true);
-			if (ret < 0)
-				return ret;
-		}
+		ret = afs_extract_data(call, false);
+		if (ret < 0)
+			return ret;
 
 		p = call->reply[2];
 		p[call->count] = 0;
 		_debug("motd '%s'", p);
 
-		call->offset = 0;
 		call->unmarshall++;
 
-		/* extract the message of the day padding */
-		call->count = (4 - (call->count & 3)) & 3;
-
-	case 10:
-		ret = afs_extract_data(call, call->buffer,
-				       call->count, false);
-		if (ret < 0)
-			return ret;
-
-		call->offset = 0;
-		call->unmarshall++;
-	case 11:
+	case 8:
 		break;
 	}
 
@@ -2024,19 +1923,16 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 	u32 count;
 	int ret;
 
-	_enter("{%u,%zu/%u}", call->unmarshall, call->offset, call->count);
+	_enter("{%u,%llu}", call->unmarshall, iov_iter_count(&call->iter));
 
-again:
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
 		/* Extract the capabilities word count */
 	case 1:
-		ret = afs_extract_data(call, &call->tmp,
-				       1 * sizeof(__be32),
-				       true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -2044,24 +1940,17 @@ static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 
 		call->count = count;
 		call->count2 = count;
-		call->offset = 0;
+		iov_iter_discard(&call->iter, READ, count * sizeof(__be32));
 		call->unmarshall++;
 
 		/* Extract capabilities words */
 	case 2:
-		count = min(call->count, 16U);
-		ret = afs_extract_data(call, call->buffer,
-				       count * sizeof(__be32),
-				       call->count > 16);
+		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
 
 		/* TODO: Examine capabilities */
 
-		call->count -= count;
-		if (call->count > 0)
-			goto again;
-		call->offset = 0;
 		call->unmarshall++;
 		break;
 	}
@@ -2215,13 +2104,13 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
 		/* Extract the file status count and array in two steps */
 	case 1:
 		_debug("extract status count");
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -2234,11 +2123,11 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->count = 0;
 		call->unmarshall++;
 	more_counts:
-		call->offset = 0;
+		afs_extract_to_buf(call, 21 * sizeof(__be32));
 
 	case 2:
 		_debug("extract status array %u", call->count);
-		ret = afs_extract_data(call, call->buffer, 21 * 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -2256,12 +2145,12 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 
 		call->count = 0;
 		call->unmarshall++;
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 
 		/* Extract the callback count and array in two steps */
 	case 3:
 		_debug("extract CB count");
-		ret = afs_extract_data(call, &call->tmp, 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -2273,11 +2162,11 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		call->count = 0;
 		call->unmarshall++;
 	more_cbs:
-		call->offset = 0;
+		afs_extract_to_buf(call, 3 * sizeof(__be32));
 
 	case 4:
 		_debug("extract CB array");
-		ret = afs_extract_data(call, call->buffer, 3 * 4, true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -2294,11 +2183,11 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		if (call->count < call->count2)
 			goto more_cbs;
 
-		call->offset = 0;
+		afs_extract_to_buf(call, 6 * sizeof(__be32));
 		call->unmarshall++;
 
 	case 5:
-		ret = afs_extract_data(call, call->buffer, 6 * 4, false);
+		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
 
@@ -2306,7 +2195,6 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		if (call->reply[3])
 			xdr_decode_AFSVolSync(&bp, call->reply[3]);
 
-		call->offset = 0;
 		call->unmarshall++;
 
 	case 6:
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 852f68a400b8..8e248051afde 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -94,11 +94,16 @@ struct afs_call {
 	struct afs_cb_interest	*cbi;		/* Callback interest for server used */
 	void			*request;	/* request data (first part) */
 	struct address_space	*mapping;	/* Pages being written from */
+	struct iov_iter		iter;		/* Buffer iterator */
+	struct iov_iter		*_iter;		/* Iterator currently in use */
+	union {	/* Convenience for ->iter */
+		struct kvec	kvec[1];
+		struct bio_vec	bvec[1];
+	};
 	void			*buffer;	/* reply receive buffer */
 	void			*reply[4];	/* Where to put the reply */
 	pgoff_t			first;		/* first page in mapping to deal with */
 	pgoff_t			last;		/* last page in mapping to deal with */
-	size_t			offset;		/* offset into received data store */
 	atomic_t		usage;
 	enum afs_call_state	state;
 	spinlock_t		state_lock;
@@ -175,15 +180,15 @@ struct afs_read {
 	loff_t			pos;		/* Where to start reading */
 	loff_t			len;		/* How much we're asking for */
 	loff_t			actual_len;	/* How much we're actually getting */
-	loff_t			remain;		/* Amount remaining */
 	loff_t			file_size;	/* File size returned by server */
 	afs_dataversion_t	data_version;	/* Version number returned by server */
 	refcount_t		usage;
-	unsigned int		index;		/* Which page we're reading into */
 	unsigned int		nr_pages;
-	void (*page_done)(struct afs_call *, struct afs_read *);
-	struct page		**pages;
-	struct page		*array[];
+	unsigned int		done_pages;
+	bool			error;
+	unsigned int		call_debug_id;
+	void (*cleanup)(struct afs_read *);
+	struct iov_iter		iter;		/* Buffer */
 };
 
 /*
@@ -547,6 +552,15 @@ struct afs_vnode {
 	afs_callback_type_t	cb_type;	/* type of callback */
 };
 
+static inline struct fscache_cookie *afs_vnode_cache(struct afs_vnode *vnode)
+{
+#ifdef CONFIG_AFS_FSCACHE
+	return vnode->cache;
+#else
+	return NULL;
+#endif
+}
+
 /*
  * cached security record for one user's attempt to access a vnode
  */
@@ -927,12 +941,34 @@ extern struct afs_call *afs_alloc_flat_call(struct afs_net *,
 extern void afs_flat_call_destructor(struct afs_call *);
 extern void afs_send_empty_reply(struct afs_call *);
 extern void afs_send_simple_reply(struct afs_call *, const void *, size_t);
-extern int afs_extract_data(struct afs_call *, void *, size_t, bool);
+extern int afs_extract_data(struct afs_call *, bool);
 extern int afs_protocol_error(struct afs_call *, int, enum afs_eproto_cause);
 
+static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t size)
+{
+	call->kvec[0].iov_base = buf;
+	call->kvec[0].iov_len = size;
+	iov_iter_kvec(&call->iter, READ, call->kvec, 1, size);
+}
+
+static inline void afs_extract_to_tmp(struct afs_call *call)
+{
+	afs_extract_begin(call, &call->tmp, sizeof(call->tmp));
+}
+
+static inline void afs_extract_discard(struct afs_call *call, size_t size)
+{
+	iov_iter_discard(&call->iter, READ, size);
+}
+
+static inline void afs_extract_to_buf(struct afs_call *call, size_t size)
+{
+	afs_extract_begin(call, call->buffer, size);
+}
+
 static inline int afs_transfer_reply(struct afs_call *call)
 {
-	return afs_extract_data(call, call->buffer, call->reply_max, false);
+	return afs_extract_data(call, false);
 }
 
 static inline bool afs_check_call_state(struct afs_call *call,
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 37811901a5c9..09479677f11f 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -143,6 +143,7 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
 	INIT_WORK(&call->async_work, afs_process_async_call);
 	init_waitqueue_head(&call->waitq);
 	spin_lock_init(&call->state_lock);
+	call->_iter = &call->iter;
 
 	o = atomic_inc_return(&net->nr_outstanding_calls);
 	trace_afs_call(call, afs_call_trace_alloc, 1, o,
@@ -233,6 +234,7 @@ struct afs_call *afs_alloc_flat_call(struct afs_net *net,
 			goto nomem_free;
 	}
 
+	afs_extract_to_buf(call, call->reply_max);
 	call->operation_ID = type->op;
 	init_waitqueue_head(&call->waitq);
 	return call;
@@ -465,14 +467,12 @@ static void afs_deliver_to_call(struct afs_call *call)
 	       state == AFS_CALL_SV_AWAIT_ACK
 	       ) {
 		if (state == AFS_CALL_SV_AWAIT_ACK) {
-			struct iov_iter iter;
-
-			iov_iter_kvec(&iter, READ, NULL, 0, 0);
+			iov_iter_kvec(&call->iter, READ, NULL, 0, 0);
 			ret = rxrpc_kernel_recv_data(call->net->socket,
-						     call->rxcall, &iter, false,
-						     &remote_abort,
+						     call->rxcall, &call->iter,
+						     false, &remote_abort,
 						     &call->service_id);
-			trace_afs_recv_data(call, 0, 0, false, ret);
+			trace_afs_receive_data(call, &call->iter, false, ret);
 
 			if (ret == -EINPROGRESS || ret == -EAGAIN)
 				return;
@@ -516,7 +516,7 @@ static void afs_deliver_to_call(struct afs_call *call)
 			if (state != AFS_CALL_CL_AWAIT_REPLY)
 				abort_code = RXGEN_SS_UNMARSHAL;
 			rxrpc_kernel_abort_call(call->net->socket, call->rxcall,
-						abort_code, -EBADMSG, "KUM");
+						abort_code, ret, "KUM");
 			goto local_abort;
 		}
 	}
@@ -729,6 +729,7 @@ void afs_charge_preallocation(struct work_struct *work)
 			call->async = true;
 			call->state = AFS_CALL_SV_AWAIT_OP_ID;
 			init_waitqueue_head(&call->waitq);
+			afs_extract_to_tmp(call);
 		}
 
 		if (rxrpc_kernel_charge_accept(net->socket,
@@ -774,18 +775,15 @@ static int afs_deliver_cm_op_id(struct afs_call *call)
 {
 	int ret;
 
-	_enter("{%zu}", call->offset);
-
-	ASSERTCMP(call->offset, <, 4);
+	_enter("{%llu}", iov_iter_count(call->_iter));
 
 	/* the operation ID forms the first four bytes of the request data */
-	ret = afs_extract_data(call, &call->tmp, 4, true);
+	ret = afs_extract_data(call, true);
 	if (ret < 0)
 		return ret;
 
 	call->operation_ID = ntohl(call->tmp);
 	afs_set_call_state(call, AFS_CALL_SV_AWAIT_OP_ID, AFS_CALL_SV_AWAIT_REQUEST);
-	call->offset = 0;
 
 	/* ask the cache manager to route the call (it'll change the call type
 	 * if successful) */
@@ -889,30 +887,19 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
 /*
  * Extract a piece of data from the received data socket buffers.
  */
-int afs_extract_data(struct afs_call *call, void *buf, size_t count,
-		     bool want_more)
+int afs_extract_data(struct afs_call *call, bool want_more)
 {
 	struct afs_net *net = call->net;
-	struct iov_iter iter;
-	struct kvec iov;
+	struct iov_iter *iter = call->_iter;
 	enum afs_call_state state;
 	u32 remote_abort = 0;
 	int ret;
 
-	_enter("{%s,%zu},,%zu,%d",
-	       call->type->name, call->offset, count, want_more);
-
-	ASSERTCMP(call->offset, <=, count);
-
-	iov.iov_base = buf + call->offset;
-	iov.iov_len = count - call->offset;
-	iov_iter_kvec(&iter, READ, &iov, 1, count - call->offset);
+	_enter("{%s,%llu},%d", call->type->name, iov_iter_count(iter), want_more);
 
-	ret = rxrpc_kernel_recv_data(net->socket, call->rxcall, &iter,
+	ret = rxrpc_kernel_recv_data(net->socket, call->rxcall, iter,
 				     want_more, &remote_abort,
 				     &call->service_id);
-	call->offset += (count - call->offset) - iov_iter_count(&iter);
-	trace_afs_recv_data(call, count, call->offset, want_more, ret);
 	if (ret == 0 || ret == -EAGAIN)
 		return ret;
 
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index d0f95c4ab05e..37656ba14d54 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -187,19 +187,18 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 	u32 uniquifier, nentries, count;
 	int i, ret;
 
-	_enter("{%u,%zu/%u}", call->unmarshall, call->offset, call->count);
+	_enter("{%u,%llu/%u}",
+	       call->unmarshall, iov_iter_count(call->_iter), call->count);
 
-again:
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
+		afs_extract_to_buf(call,
+				   sizeof(struct afs_uuid__xdr) + 3 * sizeof(__be32));
 		call->unmarshall++;
 
 		/* Extract the returned uuid, uniquifier, nentries and blkaddrs size */
 	case 1:
-		ret = afs_extract_data(call, call->buffer,
-				       sizeof(struct afs_uuid__xdr) + 3 * sizeof(__be32),
-				       true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -216,28 +215,28 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 		call->reply[0] = alist;
 		call->count = count;
 		call->count2 = nentries;
-		call->offset = 0;
 		call->unmarshall++;
 
+	more_entries:
+		count = min(call->count, 4U);
+		afs_extract_to_buf(call, count * sizeof(__be32));
+
 		/* Extract entries */
 	case 2:
-		count = min(call->count, 4U);
-		ret = afs_extract_data(call, call->buffer,
-				       count * sizeof(__be32),
-				       call->count > 4);
+		ret = afs_extract_data(call, call->count > 4);
 		if (ret < 0)
 			return ret;
 
 		alist = call->reply[0];
 		bp = call->buffer;
+		count = min(call->count, 4U);
 		for (i = 0; i < count; i++)
 			if (alist->nr_addrs < call->count2)
 				afs_merge_fs_addr4(alist, *bp++, AFS_FS_PORT);
 
 		call->count -= count;
 		if (call->count > 0)
-			goto again;
-		call->offset = 0;
+			goto more_entries;
 		call->unmarshall++;
 		break;
 	}
@@ -318,44 +317,35 @@ static int afs_deliver_vl_get_capabilities(struct afs_call *call)
 	u32 count;
 	int ret;
 
-	_enter("{%u,%zu/%u}", call->unmarshall, call->offset, call->count);
+	_enter("{%u,%llu/%u}",
+	       call->unmarshall, iov_iter_count(call->_iter), call->count);
 
-again:
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
+		afs_extract_to_tmp(call);
 		call->unmarshall++;
 
 		/* Extract the capabilities word count */
 	case 1:
-		ret = afs_extract_data(call, &call->tmp,
-				       1 * sizeof(__be32),
-				       true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
 		count = ntohl(call->tmp);
-
 		call->count = count;
 		call->count2 = count;
-		call->offset = 0;
+
 		call->unmarshall++;
+		afs_extract_discard(call, count * sizeof(__be32));
 
 		/* Extract capabilities words */
 	case 2:
-		count = min(call->count, 16U);
-		ret = afs_extract_data(call, call->buffer,
-				       count * sizeof(__be32),
-				       call->count > 16);
+		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
 
 		/* TODO: Examine capabilities */
 
-		call->count -= count;
-		if (call->count > 0)
-			goto again;
-		call->offset = 0;
 		call->unmarshall++;
 		break;
 	}
@@ -426,22 +416,19 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 	u32 uniquifier, size;
 	int ret;
 
-	_enter("{%u,%zu/%u,%u}", call->unmarshall, call->offset, call->count, call->count2);
+	_enter("{%u,%llu,%u}",
+	       call->unmarshall, iov_iter_count(call->_iter), call->count2);
 
-again:
 	switch (call->unmarshall) {
 	case 0:
-		call->offset = 0;
+		afs_extract_to_buf(call, sizeof(uuid_t) + 3 * sizeof(__be32));
 		call->unmarshall = 1;
 
 		/* Extract the returned uuid, uniquifier, fsEndpoints count and
 		 * either the first fsEndpoint type or the volEndpoints
 		 * count if there are no fsEndpoints. */
 	case 1:
-		ret = afs_extract_data(call, call->buffer,
-				       sizeof(uuid_t) +
-				       3 * sizeof(__be32),
-				       true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -459,15 +446,11 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 			return -ENOMEM;
 		alist->version = uniquifier;
 		call->reply[0] = alist;
-		call->offset = 0;
 
 		if (call->count == 0)
 			goto extract_volendpoints;
 
-		call->unmarshall = 2;
-
-		/* Extract fsEndpoints[] entries */
-	case 2:
+	next_fsendpoint:
 		switch (call->count2) {
 		case YFS_ENDPOINT_IPV4:
 			size = sizeof(__be32) * (1 + 1 + 1);
@@ -481,7 +464,12 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		}
 
 		size += sizeof(__be32);
-		ret = afs_extract_data(call, call->buffer, size, true);
+		afs_extract_to_buf(call, size);
+		call->unmarshall = 2;
+
+		/* Extract fsEndpoints[] entries */
+	case 2:
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -512,10 +500,9 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		 */
 		call->count2 = ntohl(*bp++);
 
-		call->offset = 0;
 		call->count--;
 		if (call->count > 0)
-			goto again;
+			goto next_fsendpoint;
 
 	extract_volendpoints:
 		/* Extract the list of volEndpoints. */
@@ -526,6 +513,7 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 			return afs_protocol_error(call, -EBADMSG,
 						  afs_eproto_yvl_vlendpt_type);
 
+		afs_extract_to_buf(call, 1 * sizeof(__be32));
 		call->unmarshall = 3;
 
 		/* Extract the type of volEndpoints[0].  Normally we would
@@ -533,17 +521,14 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		 * data of the current one, but this is the first...
 		 */
 	case 3:
-		ret = afs_extract_data(call, call->buffer, sizeof(__be32), true);
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
 		bp = call->buffer;
-		call->count2 = ntohl(*bp++);
-		call->offset = 0;
-		call->unmarshall = 4;
 
-		/* Extract volEndpoints[] entries */
-	case 4:
+	next_volendpoint:
+		call->count2 = ntohl(*bp++);
 		switch (call->count2) {
 		case YFS_ENDPOINT_IPV4:
 			size = sizeof(__be32) * (1 + 1 + 1);
@@ -557,8 +542,13 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		}
 
 		if (call->count > 1)
-			size += sizeof(__be32);
-		ret = afs_extract_data(call, call->buffer, size, true);
+			size += sizeof(__be32); /* Get next type too */
+		afs_extract_to_buf(call, size);
+		call->unmarshall = 4;
+
+		/* Extract volEndpoints[] entries */
+	case 4:
+		ret = afs_extract_data(call, true);
 		if (ret < 0)
 			return ret;
 
@@ -584,19 +574,17 @@ static int afs_deliver_yfsvl_get_endpoints(struct afs_call *call)
 		/* Got either the type of the next entry or the count of
 		 * volEndpoints if no more fsEndpoints.
 		 */
-		call->offset = 0;
 		call->count--;
-		if (call->count > 0) {
-			call->count2 = ntohl(*bp++);
-			goto again;
-		}
+		if (call->count > 0)
+			goto next_volendpoint;
 
 	end:
+		afs_extract_discard(call, 0);
 		call->unmarshall = 5;
 
 		/* Done */
 	case 5:
-		ret = afs_extract_data(call, call->buffer, 0, false);
+		ret = afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
 		call->unmarshall = 6;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 8b39e6ebb40b..ad3d706aa9e3 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -37,8 +37,7 @@ static int afs_fill_page(struct afs_vnode *vnode, struct key *key,
 
 	_enter(",,%llu", (unsigned long long)pos);
 
-	req = kzalloc(sizeof(struct afs_read) + sizeof(struct page *),
-		      GFP_KERNEL);
+	req = kzalloc(sizeof(struct afs_read), GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
 
@@ -46,9 +45,8 @@ static int afs_fill_page(struct afs_vnode *vnode, struct key *key,
 	req->pos = pos;
 	req->len = len;
 	req->nr_pages = 1;
-	req->pages = req->array;
-	req->pages[0] = page;
-	get_page(page);
+	iov_iter_mapping(&req->iter, READ, vnode->vfs_inode.i_mapping,
+			 pos, len);
 
 	ret = afs_fetch_data(vnode, key, req);
 	afs_put_read(req);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 84b90a79d75a..d99294c75e9a 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -218,6 +218,9 @@ extern int __fscache_read_or_alloc_pages(struct fscache_cookie *,
 					 gfp_t);
 extern int __fscache_alloc_page(struct fscache_cookie *, struct page *, gfp_t);
 extern int __fscache_write_page(struct fscache_cookie *, struct page *, loff_t, gfp_t);
+extern int __fscache_write(struct fscache_cookie *, struct iov_iter *,
+			   loff_t, loff_t, gfp_t,
+			   void (*)(struct fscache_cookie *, struct iov_iter *));
 extern void __fscache_uncache_page(struct fscache_cookie *, struct page *);
 extern bool __fscache_check_page_write(struct fscache_cookie *, struct page *);
 extern void __fscache_wait_on_page_write(struct fscache_cookie *, struct page *);
@@ -655,6 +658,34 @@ void fscache_readpages_cancel(struct fscache_cookie *cookie,
 		__fscache_readpages_cancel(cookie, pages);
 }
 
+/**
+ * fscache_write - Request storage of data in the cache
+ * @cookie: The cookie representing the cache object
+ * @iter: The data to store
+ * @pos: The position in the cached data
+ * @object_size: Updated size of object
+ * @gfp: The conditions under which memory allocation should be made
+ * @done: Called upon operation completion
+ *
+ * Request the data described by the iterator be written into the cache.  This
+ * request may be ignored if insufficient space exists in the cache, in which
+ * case -ENOBUFS will be returned.
+ *
+ * See Documentation/filesystems/caching/netfs-api.txt for a complete
+ * description.
+ */
+static inline
+int fscache_write(struct fscache_cookie *cookie, struct iov_iter *iter,
+		  loff_t pos, loff_t object_size, gfp_t gfp,
+		  void (*done)(struct fscache_cookie *cookie,
+			       struct iov_iter *iter))
+{
+	if (fscache_cookie_valid(cookie))
+		return __fscache_write(cookie, iter, pos, object_size, gfp, done);
+	else
+		return -ENOBUFS;
+}
+
 /**
  * fscache_write_page - Request storage of a page in the cache
  * @cookie: The cookie representing the cache object
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 5c60ade2c7d8..5e0f8dcede26 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -207,17 +207,16 @@ afs_edit_dir_reasons;
 #define EM(a, b)	{ a, b },
 #define E_(a, b)	{ a, b }
 
-TRACE_EVENT(afs_recv_data,
-	    TP_PROTO(struct afs_call *call, unsigned count, unsigned offset,
+TRACE_EVENT(afs_receive_data,
+	    TP_PROTO(struct afs_call *call, struct iov_iter *iter,
 		     bool want_more, int ret),
 
-	    TP_ARGS(call, count, offset, want_more, ret),
+	    TP_ARGS(call, iter, want_more, ret),
 
 	    TP_STRUCT__entry(
+		    __field(loff_t,			remain		)
 		    __field(unsigned int,		call		)
 		    __field(enum afs_call_state,	state		)
-		    __field(unsigned int,		count		)
-		    __field(unsigned int,		offset		)
 		    __field(unsigned short,		unmarshall	)
 		    __field(bool,			want_more	)
 		    __field(int,			ret		)
@@ -227,17 +226,18 @@ TRACE_EVENT(afs_recv_data,
 		    __entry->call	= call->debug_id;
 		    __entry->state	= call->state;
 		    __entry->unmarshall	= call->unmarshall;
-		    __entry->count	= count;
-		    __entry->offset	= offset;
+		    __entry->remain	= iov_iter_count(iter);
 		    __entry->want_more	= want_more;
 		    __entry->ret	= ret;
 			   ),
 
-	    TP_printk("c=%08x s=%u u=%u %u/%u wm=%u ret=%d",
+	    TP_printk("c=%08x r=%llu u=%u w=%u s=%u ret=%d",
 		      __entry->call,
-		      __entry->state, __entry->unmarshall,
-		      __entry->offset, __entry->count,
-		      __entry->want_more, __entry->ret)
+		      __entry->remain,
+		      __entry->unmarshall,
+		      __entry->want_more,
+		      __entry->state,
+		      __entry->ret)
 	    );
 
 TRACE_EVENT(afs_notify_call,

