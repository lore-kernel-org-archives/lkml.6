Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CC6C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED5721A2D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED5721A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbeHFP0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:26:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729714AbeHFP0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:26:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38CF940201A0;
        Mon,  6 Aug 2018 13:17:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46A1B1C4C3;
        Mon,  6 Aug 2018 13:17:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/10] afs: Use ITER_MAPPING for writing
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew@wil.cx
Date:   Mon, 06 Aug 2018 14:17:26 +0100
Message-ID: <153356144676.1195.8872421969921547218.stgit@warthog.procyon.org.uk>
In-Reply-To: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
References: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 06 Aug 2018 13:17:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 06 Aug 2018 13:17:28 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a single ITER_MAPPING iterator to describe the portion of a file to be
transmitted to the server rather than generating a series of small
ITER_BVEC iterators on the fly.  This will make it easier to implement AIO
in afs.

In theory we could maybe use one giant ITER_BVEC, but that means
potentially allocating a huge array of bio_vec structs (max 256 per page)
when in fact the pagecache already has a structure listing all the relevant
pages (radix_tree/xarray) that can be walked over.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c              |    4 --
 fs/afs/fsclient.c          |   40 +++++-------------
 fs/afs/internal.h          |   15 ++-----
 fs/afs/rxrpc.c             |   99 +++++++-------------------------------------
 fs/afs/write.c             |   84 +++++++++++++++++++++----------------
 include/trace/events/afs.h |   51 ++++++++---------------
 6 files changed, 100 insertions(+), 193 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 6d55dabccd79..7d65efe69929 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -195,11 +195,9 @@ static void afs_readpages_page_done(const struct iov_iter *iter,
 	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
 	struct afs_read *req = container_of(iter, struct afs_read, iter);
 
-	SetPageUptodate(page);
-
 	if (0 && afs_vnode_cache(vnode))
 		SetPageFsCache(page);
-	unlock_page(page);
+	page_endio(page, false, 0);
 	put_page(page);
 	req->done_pages++;
 }
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index eb60c570dca2..4c6997d91552 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1230,10 +1230,7 @@ static const struct afs_call_type afs_RXFSStoreData64 = {
 /*
  * store a set of pages to a very large file
  */
-static int afs_fs_store_data64(struct afs_fs_cursor *fc,
-			       struct address_space *mapping,
-			       pgoff_t first, pgoff_t last,
-			       unsigned offset, unsigned to,
+static int afs_fs_store_data64(struct afs_fs_cursor *fc, struct iov_iter *iter,
 			       loff_t size, loff_t pos, loff_t i_size)
 {
 	struct afs_vnode *vnode = fc->vnode;
@@ -1251,13 +1248,10 @@ static int afs_fs_store_data64(struct afs_fs_cursor *fc,
 		return -ENOMEM;
 
 	call->key = fc->key;
-	call->mapping = mapping;
+	call->write_iter = iter;
+	call->write_first = pos >> PAGE_SHIFT;
+	call->write_last = (pos + size - 1) >> PAGE_SHIFT;
 	call->reply[0] = vnode;
-	call->first = first;
-	call->last = last;
-	call->first_offset = offset;
-	call->last_to = to;
-	call->send_pages = true;
 	call->expected_version = vnode->status.data_version + 1;
 
 	/* marshall the parameters */
@@ -1286,26 +1280,20 @@ static int afs_fs_store_data64(struct afs_fs_cursor *fc,
 }
 
 /*
- * store a set of pages
+ * Write data to a file on the server.
  */
-int afs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
-		      pgoff_t first, pgoff_t last,
-		      unsigned offset, unsigned to)
+int afs_fs_store_data(struct afs_fs_cursor *fc, struct iov_iter *iter, loff_t pos)
 {
 	struct afs_vnode *vnode = fc->vnode;
 	struct afs_call *call;
 	struct afs_net *net = afs_v2net(vnode);
-	loff_t size, pos, i_size;
+	loff_t size, i_size;
 	__be32 *bp;
 
 	_enter(",%x,{%x:%u},,",
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
 
-	size = (loff_t)to - (loff_t)offset;
-	if (first != last)
-		size += (loff_t)(last - first) << PAGE_SHIFT;
-	pos = (loff_t)first << PAGE_SHIFT;
-	pos += offset;
+	size = iov_iter_count(iter);
 
 	i_size = i_size_read(&vnode->vfs_inode);
 	if (pos + size > i_size)
@@ -1316,8 +1304,7 @@ int afs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
 	       (unsigned long long) i_size);
 
 	if (pos >> 32 || i_size >> 32 || size >> 32 || (pos + size) >> 32)
-		return afs_fs_store_data64(fc, mapping, first, last, offset, to,
-					   size, pos, i_size);
+		return afs_fs_store_data64(fc, iter, size, pos, i_size);
 
 	call = afs_alloc_flat_call(net, &afs_RXFSStoreData,
 				   (4 + 6 + 3) * 4,
@@ -1326,13 +1313,10 @@ int afs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
 		return -ENOMEM;
 
 	call->key = fc->key;
-	call->mapping = mapping;
+	call->write_iter = iter;
+	call->write_first = pos >> PAGE_SHIFT;
+	call->write_last = (pos + size - 1) >> PAGE_SHIFT;
 	call->reply[0] = vnode;
-	call->first = first;
-	call->last = last;
-	call->first_offset = offset;
-	call->last_to = to;
-	call->send_pages = true;
 	call->expected_version = vnode->status.data_version + 1;
 
 	/* marshall the parameters */
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 8e248051afde..b12566b640f6 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -96,14 +96,15 @@ struct afs_call {
 	struct address_space	*mapping;	/* Pages being written from */
 	struct iov_iter		iter;		/* Buffer iterator */
 	struct iov_iter		*_iter;		/* Iterator currently in use */
+	struct iov_iter		*write_iter;	/* Iterator defining write to be made */
 	union {	/* Convenience for ->iter */
 		struct kvec	kvec[1];
 		struct bio_vec	bvec[1];
 	};
 	void			*buffer;	/* reply receive buffer */
 	void			*reply[4];	/* Where to put the reply */
-	pgoff_t			first;		/* first page in mapping to deal with */
-	pgoff_t			last;		/* last page in mapping to deal with */
+	pgoff_t			write_first;	/* First page of write */
+	pgoff_t			write_last;	/* Last page of write */
 	atomic_t		usage;
 	enum afs_call_state	state;
 	spinlock_t		state_lock;
@@ -111,15 +112,10 @@ struct afs_call {
 	u32			abort_code;	/* Remote abort ID or 0 */
 	unsigned		request_size;	/* size of request data */
 	unsigned		reply_max;	/* maximum size of reply */
-	unsigned		first_offset;	/* offset into mapping[first] */
 	unsigned int		cb_break;	/* cb_break + cb_s_break before the call */
-	union {
-		unsigned	last_to;	/* amount of mapping[last] */
-		unsigned	count2;		/* count used in unmarshalling */
-	};
+	unsigned		count2;		/* count used in unmarshalling */
 	unsigned char		unmarshall;	/* unmarshalling phase */
 	bool			incoming;	/* T if incoming call */
-	bool			send_pages;	/* T if data from mapping should be sent */
 	bool			need_attention;	/* T if RxRPC poked us */
 	bool			async;		/* T if asynchronous */
 	bool			ret_reply0;	/* T if should return reply[0] on success */
@@ -798,8 +794,7 @@ extern int afs_fs_symlink(struct afs_fs_cursor *, const char *, const char *, u6
 			  struct afs_fid *, struct afs_file_status *);
 extern int afs_fs_rename(struct afs_fs_cursor *, const char *,
 			 struct afs_vnode *, const char *, u64, u64);
-extern int afs_fs_store_data(struct afs_fs_cursor *, struct address_space *,
-			     pgoff_t, pgoff_t, unsigned, unsigned);
+extern int afs_fs_store_data(struct afs_fs_cursor *, struct iov_iter *, loff_t);
 extern int afs_fs_setattr(struct afs_fs_cursor *, struct iattr *);
 extern int afs_fs_get_volume_status(struct afs_fs_cursor *, struct afs_volume_status *);
 extern int afs_fs_set_lock(struct afs_fs_cursor *, afs_lock_type_t);
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 09479677f11f..fa22739cbf4f 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -258,39 +258,6 @@ void afs_flat_call_destructor(struct afs_call *call)
 	call->buffer = NULL;
 }
 
-#define AFS_BVEC_MAX 8
-
-/*
- * Load the given bvec with the next few pages.
- */
-static void afs_load_bvec(struct afs_call *call, struct msghdr *msg,
-			  struct bio_vec *bv, pgoff_t first, pgoff_t last,
-			  unsigned offset)
-{
-	struct page *pages[AFS_BVEC_MAX];
-	unsigned int nr, n, i, to, bytes = 0;
-
-	nr = min_t(pgoff_t, last - first + 1, AFS_BVEC_MAX);
-	n = find_get_pages_contig(call->mapping, first, nr, pages);
-	ASSERTCMP(n, ==, nr);
-
-	msg->msg_flags |= MSG_MORE;
-	for (i = 0; i < nr; i++) {
-		to = PAGE_SIZE;
-		if (first + i >= last) {
-			to = call->last_to;
-			msg->msg_flags &= ~MSG_MORE;
-		}
-		bv[i].bv_page = pages[i];
-		bv[i].bv_len = to - offset;
-		bv[i].bv_offset = offset;
-		bytes += to - offset;
-		offset = 0;
-	}
-
-	iov_iter_bvec(&msg->msg_iter, WRITE, bv, nr, bytes);
-}
-
 /*
  * Advance the AFS call state when the RxRPC call ends the transmit phase.
  */
@@ -303,41 +270,6 @@ static void afs_notify_end_request_tx(struct sock *sock,
 	afs_set_call_state(call, AFS_CALL_CL_REQUESTING, AFS_CALL_CL_AWAIT_REPLY);
 }
 
-/*
- * attach the data from a bunch of pages on an inode to a call
- */
-static int afs_send_pages(struct afs_call *call, struct msghdr *msg)
-{
-	struct bio_vec bv[AFS_BVEC_MAX];
-	unsigned int bytes, nr, loop, offset;
-	pgoff_t first = call->first, last = call->last;
-	int ret;
-
-	offset = call->first_offset;
-	call->first_offset = 0;
-
-	do {
-		afs_load_bvec(call, msg, bv, first, last, offset);
-		trace_afs_send_pages(call, msg, first, last, offset);
-
-		offset = 0;
-		bytes = msg->msg_iter.count;
-		nr = msg->msg_iter.nr_segs;
-
-		ret = rxrpc_kernel_send_data(call->net->socket, call->rxcall, msg,
-					     bytes, afs_notify_end_request_tx);
-		for (loop = 0; loop < nr; loop++)
-			put_page(bv[loop].bv_page);
-		if (ret < 0)
-			break;
-
-		first += nr;
-	} while (first <= last);
-
-	trace_afs_sent_pages(call, call->first, last, first, ret);
-	return ret;
-}
-
 /*
  * initiate a call
  */
@@ -367,19 +299,8 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 	 * after the initial fixed part.
 	 */
 	tx_total_len = call->request_size;
-	if (call->send_pages) {
-		if (call->last == call->first) {
-			tx_total_len += call->last_to - call->first_offset;
-		} else {
-			/* It looks mathematically like you should be able to
-			 * combine the following lines with the ones above, but
-			 * unsigned arithmetic is fun when it wraps...
-			 */
-			tx_total_len += PAGE_SIZE - call->first_offset;
-			tx_total_len += call->last_to;
-			tx_total_len += (call->last - call->first - 1) * PAGE_SIZE;
-		}
-	}
+	if (call->write_iter)
+		tx_total_len += iov_iter_count(call->write_iter);
 
 	/* create a call */
 	rxcall = rxrpc_kernel_begin_call(call->net->socket, srx, call->key,
@@ -406,7 +327,7 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, call->request_size);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
-	msg.msg_flags		= MSG_WAITALL | (call->send_pages ? MSG_MORE : 0);
+	msg.msg_flags		= MSG_WAITALL | (call->write_iter ? MSG_MORE : 0);
 
 	ret = rxrpc_kernel_send_data(call->net->socket, rxcall,
 				     &msg, call->request_size,
@@ -414,8 +335,18 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 	if (ret < 0)
 		goto error_do_abort;
 
-	if (call->send_pages) {
-		ret = afs_send_pages(call, &msg);
+	if (call->write_iter) {
+		msg.msg_iter = *call->write_iter;
+		msg.msg_flags &= ~MSG_MORE;
+		trace_afs_send_data(call, &msg);
+
+		ret = rxrpc_kernel_send_data(call->net->socket,
+					     call->rxcall, &msg,
+					     iov_iter_count(&msg.msg_iter),
+					     afs_notify_end_request_tx);
+		*call->write_iter = msg.msg_iter;
+
+		trace_afs_sent_data(call, &msg, ret);
 		if (ret < 0)
 			goto error_do_abort;
 	}
diff --git a/fs/afs/write.c b/fs/afs/write.c
index ad3d706aa9e3..8ce5142f0f08 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -302,22 +302,21 @@ static void afs_redirty_pages(struct writeback_control *wbc,
 /*
  * write to a file
  */
-static int afs_store_data(struct address_space *mapping,
-			  pgoff_t first, pgoff_t last,
-			  unsigned offset, unsigned to)
+static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter,
+			  loff_t pos)
 {
-	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
 	struct afs_fs_cursor fc;
 	struct afs_wb_key *wbk = NULL;
 	struct list_head *p;
+	loff_t count = iov_iter_count(iter);
 	int ret = -ENOKEY, ret2;
 
-	_enter("%s{%x:%u.%u},%lx,%lx,%x,%x",
+	_enter("%s{%x:%u.%u},%llx,%llx",
 	       vnode->volume->name,
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
 	       vnode->fid.unique,
-	       first, last, offset, to);
+	       count, pos);
 
 	spin_lock(&vnode->wb_lock);
 	p = vnode->wb_keys.next;
@@ -350,7 +349,7 @@ static int afs_store_data(struct address_space *mapping,
 	if (afs_begin_vnode_operation(&fc, vnode, wbk->key)) {
 		while (afs_select_fileserver(&fc)) {
 			fc.cb_break = afs_calc_vnode_cb_break(vnode);
-			afs_fs_store_data(&fc, mapping, first, last, offset, to);
+			afs_fs_store_data(&fc, iter, pos);
 		}
 
 		afs_check_for_remote_deletion(&fc, fc.vnode);
@@ -361,9 +360,7 @@ static int afs_store_data(struct address_space *mapping,
 	switch (ret) {
 	case 0:
 		afs_stat_v(vnode, n_stores);
-		atomic_long_add((last * PAGE_SIZE + to) -
-				(first * PAGE_SIZE + offset),
-				&afs_v2net(vnode)->n_store_bytes);
+		atomic_long_add(count, &afs_v2net(vnode)->n_store_bytes);
 		break;
 	case -EACCES:
 	case -EPERM:
@@ -393,10 +390,12 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 					   pgoff_t final_page)
 {
 	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
+	struct iov_iter iter;
 	struct page *pages[8], *page;
 	unsigned long count, priv;
 	unsigned n, offset, to, f, t;
 	pgoff_t start, first, last;
+	loff_t a, b;
 	int loop, ret;
 
 	_enter(",%lx", primary_page->index);
@@ -496,10 +495,17 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 
 	first = primary_page->index;
 	last = first + count - 1;
-
 	_debug("write back %lx[%u..] to %lx[..%u]", first, offset, last, to);
 
-	ret = afs_store_data(mapping, first, last, offset, to);
+	a = first;
+	a <<= PAGE_SHIFT;
+	a += offset;
+	b = last;
+	b <<= PAGE_SHIFT;
+	b += to;
+	iov_iter_mapping(&iter, WRITE, mapping, a, b - a);
+
+	ret = afs_store_data(vnode, &iter, a);
 	switch (ret) {
 	case 0:
 		ret = count;
@@ -668,36 +674,35 @@ int afs_writepages(struct address_space *mapping,
  */
 void afs_pages_written_back(struct afs_vnode *vnode, struct afs_call *call)
 {
-	struct pagevec pv;
+	struct radix_tree_iter iter;
+	struct address_space *mapping = vnode->vfs_inode.i_mapping;
 	unsigned long priv;
-	unsigned count, loop;
-	pgoff_t first = call->first, last = call->last;
+	pgoff_t cursor = call->write_first, last = call->write_last;
+	void __rcu **slot;
 
 	_enter("{%x:%u},{%lx-%lx}",
-	       vnode->fid.vid, vnode->fid.vnode, first, last);
+	       vnode->fid.vid, vnode->fid.vnode, cursor, last);
 
-	pagevec_init(&pv);
+	rcu_read_lock();
 
-	do {
-		_debug("done %lx-%lx", first, last);
+	radix_tree_for_each_contig(slot, &mapping->i_pages, &iter, cursor) {
+		struct page *page = radix_tree_deref_slot(slot);
 
-		count = last - first + 1;
-		if (count > PAGEVEC_SIZE)
-			count = PAGEVEC_SIZE;
-		pv.nr = find_get_pages_contig(vnode->vfs_inode.i_mapping,
-					      first, count, pv.pages);
-		ASSERTCMP(pv.nr, ==, count);
+		ASSERT(page);
+		ASSERT(PageWriteback(page));
 
-		for (loop = 0; loop < count; loop++) {
-			priv = page_private(pv.pages[loop]);
-			trace_afs_page_dirty(vnode, tracepoint_string("clear"),
-					     pv.pages[loop]->index, priv);
-			set_page_private(pv.pages[loop], 0);
-			end_page_writeback(pv.pages[loop]);
-		}
-		first += count;
-		__pagevec_release(&pv);
-	} while (first <= last);
+		priv = page_private(page);
+		trace_afs_page_dirty(vnode, tracepoint_string("clear"),
+				     page->index, priv);
+		set_page_private(page, 0);
+		page_endio(page, true, 0);
+
+		if (cursor >= last)
+			break;
+		cursor++;
+	}
+
+	rcu_read_unlock();
 
 	afs_prune_wb_keys(vnode);
 	_leave("");
@@ -829,6 +834,8 @@ int afs_launder_page(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
+	struct iov_iter iter;
+	struct bio_vec bv[1];
 	unsigned long priv;
 	unsigned int f, t;
 	int ret = 0;
@@ -844,9 +851,14 @@ int afs_launder_page(struct page *page)
 			t = priv >> AFS_PRIV_SHIFT;
 		}
 
+		bv[0].bv_page = page;
+		bv[0].bv_offset = f;
+		bv[0].bv_len = t - f;
+		iov_iter_bvec(&iter, WRITE, bv, 1, bv[0].bv_len);
+
 		trace_afs_page_dirty(vnode, tracepoint_string("launder"),
 				     page->index, priv);
-		ret = afs_store_data(mapping, page->index, page->index, t, f);
+		ret = afs_store_data(vnode, &iter, (loff_t)page->index << PAGE_SHIFT);
 	}
 
 	trace_afs_page_dirty(vnode, tracepoint_string("laundered"),
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 5e0f8dcede26..9c44245987b3 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -392,65 +392,52 @@ TRACE_EVENT(afs_call_done,
 		      __entry->rx_call)
 	    );
 
-TRACE_EVENT(afs_send_pages,
-	    TP_PROTO(struct afs_call *call, struct msghdr *msg,
-		     pgoff_t first, pgoff_t last, unsigned int offset),
+TRACE_EVENT(afs_send_data,
+	    TP_PROTO(struct afs_call *call, struct msghdr *msg),
 
-	    TP_ARGS(call, msg, first, last, offset),
+	    TP_ARGS(call, msg),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call		)
-		    __field(pgoff_t,			first		)
-		    __field(pgoff_t,			last		)
-		    __field(unsigned int,		nr		)
-		    __field(unsigned int,		bytes		)
-		    __field(unsigned int,		offset		)
 		    __field(unsigned int,		flags		)
+		    __field(loff_t,			offset		)
+		    __field(loff_t,			count		)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->call = call->debug_id;
-		    __entry->first = first;
-		    __entry->last = last;
-		    __entry->nr = msg->msg_iter.nr_segs;
-		    __entry->bytes = msg->msg_iter.count;
-		    __entry->offset = offset;
 		    __entry->flags = msg->msg_flags;
+		    __entry->offset = msg->msg_iter.iov_offset;
+		    __entry->count = iov_iter_count(&msg->msg_iter);
 			   ),
 
-	    TP_printk(" c=%08x %lx-%lx-%lx b=%x o=%x f=%x",
-		      __entry->call,
-		      __entry->first, __entry->first + __entry->nr - 1, __entry->last,
-		      __entry->bytes, __entry->offset,
+	    TP_printk(" c=%08x o=%llx c=%llx f=%x",
+		      __entry->call, __entry->offset, __entry->count,
 		      __entry->flags)
 	    );
 
-TRACE_EVENT(afs_sent_pages,
-	    TP_PROTO(struct afs_call *call, pgoff_t first, pgoff_t last,
-		     pgoff_t cursor, int ret),
+TRACE_EVENT(afs_sent_data,
+	    TP_PROTO(struct afs_call *call, struct msghdr *msg, int ret),
 
-	    TP_ARGS(call, first, last, cursor, ret),
+	    TP_ARGS(call, msg, ret),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call		)
-		    __field(pgoff_t,			first		)
-		    __field(pgoff_t,			last		)
-		    __field(pgoff_t,			cursor		)
 		    __field(int,			ret		)
+		    __field(loff_t,			offset		)
+		    __field(loff_t,			count		)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->call = call->debug_id;
-		    __entry->first = first;
-		    __entry->last = last;
-		    __entry->cursor = cursor;
 		    __entry->ret = ret;
+		    __entry->offset = msg->msg_iter.iov_offset;
+		    __entry->count = iov_iter_count(&msg->msg_iter);
 			   ),
 
-	    TP_printk(" c=%08x %lx-%lx c=%lx r=%d",
-		      __entry->call,
-		      __entry->first, __entry->last,
-		      __entry->cursor, __entry->ret)
+	    TP_printk(" c=%08x o=%llx c=%llx r=%d",
+		      __entry->call, __entry->offset, __entry->count,
+		      __entry->ret)
 	    );
 
 TRACE_EVENT(afs_dir_check_failed,

