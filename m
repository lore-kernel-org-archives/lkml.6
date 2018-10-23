Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABBBC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C030520813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C030520813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbeJXIXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 04:23:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbeJXIXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 04:23:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BAD8300260C;
        Tue, 23 Oct 2018 23:57:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11CCE60F80;
        Tue, 23 Oct 2018 23:57:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/25] iov_iter: Use accessor function [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Oct 2018 00:57:57 +0100
Message-ID: <154033907731.12041.15677154092495801379.stgit@warthog.procyon.org.uk>
In-Reply-To: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk>
References: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 23 Oct 2018 23:57:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use accessor functions to access an iterator's type and direction.  This
allows for the possibility of using some other method of determining the
type of iterator than if-chains with bitwise-AND conditions.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 block/bio.c           |    2 +-
 fs/block_dev.c        |    2 +-
 fs/ceph/file.c        |    2 +-
 fs/cifs/file.c        |    4 ++--
 fs/cifs/misc.c        |    2 +-
 fs/cifs/smbdirect.c   |   17 +++++++++++----
 fs/direct-io.c        |    2 +-
 fs/fuse/file.c        |    2 +-
 fs/iomap.c            |    2 +-
 include/linux/uio.h   |   48 +++++++++++++++++++++++++++++-------------
 lib/iov_iter.c        |   56 +++++++++++++++++++++++++------------------------
 mm/filemap.c          |    2 +-
 net/9p/trans_virtio.c |    2 +-
 net/tls/tls_sw.c      |    4 ++--
 14 files changed, 87 insertions(+), 60 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 0093bed81c0e..c55f36bbe12a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1255,7 +1255,7 @@ struct bio *bio_copy_user_iov(struct request_queue *q,
 	/*
 	 * success
 	 */
-	if (((iter->type & WRITE) && (!map_data || !map_data->null_mapped)) ||
+	if ((iov_iter_rw(iter) == WRITE && (!map_data || !map_data->null_mapped)) ||
 	    (map_data && map_data->from_user)) {
 		ret = bio_copy_from_iter(bio, iter);
 		if (ret)
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 38b8ce05cbc7..a80b4f0ee7c4 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -349,7 +349,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 	dio->size = 0;
 	dio->multi_bio = false;
-	dio->should_dirty = is_read && (iter->type == ITER_IOVEC);
+	dio->should_dirty = is_read && iter_is_iovec(iter);
 
 	blk_start_plug(&plug);
 	for (;;) {
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 92ab20433682..524ecc95b04d 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -658,7 +658,7 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 	if (ret < 0)
 		return ret;
 
-	if (unlikely(to->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(to))) {
 		size_t page_off;
 		ret = iov_iter_get_pages_alloc(to, &pages, len,
 					       &page_off);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 8d41ca7bfcf1..dcdbcb6f09f8 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2990,7 +2990,7 @@ cifs_readdata_to_iov(struct cifs_readdata *rdata, struct iov_iter *iter)
 		size_t copy = min_t(size_t, remaining, PAGE_SIZE);
 		size_t written;
 
-		if (unlikely(iter->type & ITER_PIPE)) {
+		if (unlikely(iov_iter_is_pipe(iter))) {
 			void *addr = kmap_atomic(page);
 
 			written = copy_to_iter(addr, copy, iter);
@@ -3302,7 +3302,7 @@ ssize_t cifs_user_readv(struct kiocb *iocb, struct iov_iter *to)
 	if (!is_sync_kiocb(iocb))
 		ctx->iocb = iocb;
 
-	if (to->type == ITER_IOVEC)
+	if (iter_is_iovec(to))
 		ctx->should_dirty = true;
 
 	rc = setup_aio_ctx_iter(ctx, to, READ);
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 6926685e513c..7b5b960a04b8 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -786,7 +786,7 @@ setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw)
 	struct page **pages = NULL;
 	struct bio_vec *bv = NULL;
 
-	if (iter->type & ITER_KVEC) {
+	if (iov_iter_is_kvec(iter)) {
 		memcpy(&ctx->iter, iter, sizeof(struct iov_iter));
 		ctx->len = count;
 		iov_iter_advance(iter, count);
diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 5fdb9a509a97..5b05bf255268 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -2054,14 +2054,22 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 
 	info->smbd_recv_pending++;
 
-	switch (msg->msg_iter.type) {
-	case READ | ITER_KVEC:
+	if (iov_iter_rw(&msg->msg_iter) == WRITE) {
+		/* It's a bug in upper layer to get there */
+		cifs_dbg(VFS, "CIFS: invalid msg iter dir %u\n",
+			 iov_iter_rw(&msg->msg_iter));
+		rc = -EINVAL;
+		goto out;
+	}
+
+	switch (iov_iter_type(&msg->msg_iter)) {
+	case ITER_KVEC:
 		buf = msg->msg_iter.kvec->iov_base;
 		to_read = msg->msg_iter.kvec->iov_len;
 		rc = smbd_recv_buf(info, buf, to_read);
 		break;
 
-	case READ | ITER_BVEC:
+	case ITER_BVEC:
 		page = msg->msg_iter.bvec->bv_page;
 		page_offset = msg->msg_iter.bvec->bv_offset;
 		to_read = msg->msg_iter.bvec->bv_len;
@@ -2071,10 +2079,11 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 	default:
 		/* It's a bug in upper layer to get there */
 		cifs_dbg(VFS, "CIFS: invalid msg type %d\n",
-			msg->msg_iter.type);
+			 iov_iter_type(&msg->msg_iter));
 		rc = -EINVAL;
 	}
 
+out:
 	info->smbd_recv_pending--;
 	wake_up(&info->wait_smbd_recv_pending);
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 093fb54cd316..722d17c88edb 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1313,7 +1313,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	spin_lock_init(&dio->bio_lock);
 	dio->refcount = 1;
 
-	dio->should_dirty = (iter->type == ITER_IOVEC);
+	dio->should_dirty = iter_is_iovec(iter) && iov_iter_rw(iter) == READ;
 	sdio.iter = iter;
 	sdio.final_block_in_request = end >> blkbits;
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 32d0b883e74f..c9ccd45156dc 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1271,7 +1271,7 @@ static int fuse_get_user_pages(struct fuse_req *req, struct iov_iter *ii,
 	ssize_t ret = 0;
 
 	/* Special case for kernel I/O: can copy directly into the buffer */
-	if (ii->type & ITER_KVEC) {
+	if (iov_iter_is_kvec(ii)) {
 		unsigned long user_addr = fuse_get_user_addr(ii);
 		size_t frag_size = fuse_get_frag_size(ii, *nbytesp);
 
diff --git a/fs/iomap.c b/fs/iomap.c
index ec15cf2ec696..2c53400aa802 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1795,7 +1795,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		if (pos >= dio->i_size)
 			goto out_free_dio;
 
-		if (iter->type == ITER_IOVEC)
+		if (iter_is_iovec(iter) && iov_iter_rw(iter) == READ)
 			dio->flags |= IOMAP_DIO_DIRTY;
 	} else {
 		flags |= IOMAP_WRITE;
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 422b1c01ee0d..fcabc959c794 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -21,7 +21,7 @@ struct kvec {
 	size_t iov_len;
 };
 
-enum {
+enum iter_type {
 	ITER_IOVEC = 0,
 	ITER_KVEC = 2,
 	ITER_BVEC = 4,
@@ -47,6 +47,36 @@ struct iov_iter {
 	};
 };
 
+static inline enum iter_type iov_iter_type(const struct iov_iter *i)
+{
+	return i->type & ~(READ | WRITE);
+}
+
+static inline bool iter_is_iovec(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_IOVEC;
+}
+
+static inline bool iov_iter_is_kvec(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_KVEC;
+}
+
+static inline bool iov_iter_is_bvec(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_BVEC;
+}
+
+static inline bool iov_iter_is_pipe(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_PIPE;
+}
+
+static inline unsigned char iov_iter_rw(const struct iov_iter *i)
+{
+	return i->type & (READ | WRITE);
+}
+
 /*
  * Total number of bytes covered by an iovec.
  *
@@ -74,7 +104,8 @@ static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
 }
 
 #define iov_for_each(iov, iter, start)				\
-	if (!((start).type & (ITER_BVEC | ITER_PIPE)))		\
+	if (iov_iter_type(start) == ITER_IOVEC ||		\
+	    iov_iter_type(start) == ITER_KVEC)			\
 	for (iter = (start);					\
 	     (iter).count &&					\
 	     ((iov = iov_iter_iovec(&(iter))), 1);		\
@@ -202,19 +233,6 @@ static inline size_t iov_iter_count(const struct iov_iter *i)
 	return i->count;
 }
 
-static inline bool iter_is_iovec(const struct iov_iter *i)
-{
-	return !(i->type & (ITER_BVEC | ITER_KVEC | ITER_PIPE));
-}
-
-/*
- * Get one of READ or WRITE out of iter->type without any other flags OR'd in
- * with it.
- *
- * The ?: is just for type safety.
- */
-#define iov_iter_rw(i) ((0 ? (struct iov_iter *)0 : (i))->type & (READ | WRITE))
-
 /*
  * Cap the iov_iter by given limit; note that the second argument is
  * *not* the new size - it's upper limit for such.  Passing it a value
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 8be175df3075..42d39116a556 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -558,7 +558,7 @@ static size_t copy_pipe_to_iter(const void *addr, size_t bytes,
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	const char *from = addr;
-	if (unlikely(i->type & ITER_PIPE))
+	if (unlikely(iov_iter_is_pipe(i)))
 		return copy_pipe_to_iter(addr, bytes, i);
 	if (iter_is_iovec(i))
 		might_fault();
@@ -658,7 +658,7 @@ size_t _copy_to_iter_mcsafe(const void *addr, size_t bytes, struct iov_iter *i)
 	const char *from = addr;
 	unsigned long rem, curr_addr, s_addr = (unsigned long) addr;
 
-	if (unlikely(i->type & ITER_PIPE))
+	if (unlikely(iov_iter_is_pipe(i)))
 		return copy_pipe_to_iter_mcsafe(addr, bytes, i);
 	if (iter_is_iovec(i))
 		might_fault();
@@ -692,7 +692,7 @@ EXPORT_SYMBOL_GPL(_copy_to_iter_mcsafe);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return 0;
 	}
@@ -712,7 +712,7 @@ EXPORT_SYMBOL(_copy_from_iter);
 bool _copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return false;
 	}
@@ -739,7 +739,7 @@ EXPORT_SYMBOL(_copy_from_iter_full);
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return 0;
 	}
@@ -773,7 +773,7 @@ EXPORT_SYMBOL(_copy_from_iter_nocache);
 size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return 0;
 	}
@@ -794,7 +794,7 @@ EXPORT_SYMBOL_GPL(_copy_from_iter_flushcache);
 bool _copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
 {
 	char *to = addr;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return false;
 	}
@@ -836,7 +836,7 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 		size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
 		return wanted;
-	} else if (likely(!(i->type & ITER_PIPE)))
+	} else if (likely(!iov_iter_is_pipe(i)))
 		return copy_page_to_iter_iovec(page, offset, bytes, i);
 	else
 		return copy_page_to_iter_pipe(page, offset, bytes, i);
@@ -848,7 +848,7 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 {
 	if (unlikely(!page_copy_sane(page, offset, bytes)))
 		return 0;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return 0;
 	}
@@ -888,7 +888,7 @@ static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 
 size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 {
-	if (unlikely(i->type & ITER_PIPE))
+	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_zero(bytes, i);
 	iterate_and_advance(i, bytes, v,
 		clear_user(v.iov_base, v.iov_len),
@@ -908,7 +908,7 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
 		kunmap_atomic(kaddr);
 		return 0;
 	}
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		kunmap_atomic(kaddr);
 		WARN_ON(1);
 		return 0;
@@ -972,7 +972,7 @@ static void pipe_advance(struct iov_iter *i, size_t size)
 
 void iov_iter_advance(struct iov_iter *i, size_t size)
 {
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		pipe_advance(i, size);
 		return;
 	}
@@ -987,7 +987,7 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 	if (WARN_ON(unroll > MAX_RW_COUNT))
 		return;
 	i->count += unroll;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		struct pipe_inode_info *pipe = i->pipe;
 		int idx = i->idx;
 		size_t off = i->iov_offset;
@@ -1016,7 +1016,7 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 		return;
 	}
 	unroll -= i->iov_offset;
-	if (i->type & ITER_BVEC) {
+	if (iov_iter_is_bvec(i)) {
 		const struct bio_vec *bvec = i->bvec;
 		while (1) {
 			size_t n = (--bvec)->bv_len;
@@ -1049,11 +1049,11 @@ EXPORT_SYMBOL(iov_iter_revert);
  */
 size_t iov_iter_single_seg_count(const struct iov_iter *i)
 {
-	if (unlikely(i->type & ITER_PIPE))
+	if (unlikely(iov_iter_is_pipe(i)))
 		return i->count;	// it is a silly place, anyway
 	if (i->nr_segs == 1)
 		return i->count;
-	else if (i->type & ITER_BVEC)
+	else if (iov_iter_is_bvec(i))
 		return min(i->count, i->bvec->bv_len - i->iov_offset);
 	else
 		return min(i->count, i->iov->iov_len - i->iov_offset);
@@ -1106,7 +1106,7 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 	unsigned long res = 0;
 	size_t size = i->count;
 
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		if (size && i->iov_offset && allocated(&i->pipe->bufs[i->idx]))
 			return size | i->iov_offset;
 		return size;
@@ -1125,7 +1125,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 	unsigned long res = 0;
 	size_t size = i->count;
 
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return ~0U;
 	}
@@ -1193,7 +1193,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 	if (maxsize > i->count)
 		maxsize = i->count;
 
-	if (unlikely(i->type & ITER_PIPE))
+	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_get_pages(i, pages, maxsize, maxpages, start);
 	iterate_all_kinds(i, maxsize, v, ({
 		unsigned long addr = (unsigned long)v.iov_base;
@@ -1205,7 +1205,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 			len = maxpages * PAGE_SIZE;
 		addr &= ~(PAGE_SIZE - 1);
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
-		res = get_user_pages_fast(addr, n, (i->type & WRITE) != WRITE, pages);
+		res = get_user_pages_fast(addr, n, iov_iter_rw(i) != WRITE, pages);
 		if (unlikely(res < 0))
 			return res;
 		return (res == n ? len : res * PAGE_SIZE) - *start;
@@ -1270,7 +1270,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 	if (maxsize > i->count)
 		maxsize = i->count;
 
-	if (unlikely(i->type & ITER_PIPE))
+	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_get_pages_alloc(i, pages, maxsize, start);
 	iterate_all_kinds(i, maxsize, v, ({
 		unsigned long addr = (unsigned long)v.iov_base;
@@ -1283,7 +1283,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		p = get_pages_array(n);
 		if (!p)
 			return -ENOMEM;
-		res = get_user_pages_fast(addr, n, (i->type & WRITE) != WRITE, p);
+		res = get_user_pages_fast(addr, n, iov_iter_rw(i) != WRITE, p);
 		if (unlikely(res < 0)) {
 			kvfree(p);
 			return res;
@@ -1313,7 +1313,7 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return 0;
 	}
@@ -1355,7 +1355,7 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);
 		return false;
 	}
@@ -1400,7 +1400,7 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum,
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		WARN_ON(1);	/* for now */
 		return 0;
 	}
@@ -1443,7 +1443,7 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 	if (!size)
 		return 0;
 
-	if (unlikely(i->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(i))) {
 		struct pipe_inode_info *pipe = i->pipe;
 		size_t off;
 		int idx;
@@ -1481,11 +1481,11 @@ EXPORT_SYMBOL(iov_iter_npages);
 const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 {
 	*new = *old;
-	if (unlikely(new->type & ITER_PIPE)) {
+	if (unlikely(iov_iter_is_pipe(new))) {
 		WARN_ON(1);
 		return NULL;
 	}
-	if (new->type & ITER_BVEC)
+	if (iov_iter_is_bvec(new))
 		return new->bvec = kmemdup(new->bvec,
 				    new->nr_segs * sizeof(struct bio_vec),
 				    flags);
diff --git a/mm/filemap.c b/mm/filemap.c
index 52517f28e6f4..bdeee0168ea7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2122,7 +2122,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 					!mapping->a_ops->is_partially_uptodate)
 				goto page_not_up_to_date;
 			/* pipes can't handle partially uptodate pages */
-			if (unlikely(iter->type & ITER_PIPE))
+			if (unlikely(iov_iter_is_pipe(iter)))
 				goto page_not_up_to_date;
 			if (!trylock_page(page))
 				goto page_not_up_to_date;
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 7728b0acde09..4d7d2070e9c8 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -322,7 +322,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 	if (!iov_iter_count(data))
 		return 0;
 
-	if (!(data->type & ITER_KVEC)) {
+	if (iov_iter_is_kvec(data)) {
 		int n;
 		/*
 		 * We allow only p9_max_pages pinned. We wait for the
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index a525fc4c2a4b..ad64b9c8b600 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -799,7 +799,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	struct crypto_tfm *tfm = crypto_aead_tfm(ctx->aead_send);
 	bool async_capable = tfm->__crt_alg->cra_flags & CRYPTO_ALG_ASYNC;
 	unsigned char record_type = TLS_RECORD_TYPE_DATA;
-	bool is_kvec = msg->msg_iter.type & ITER_KVEC;
+	bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
 	bool eor = !(msg->msg_flags & MSG_MORE);
 	size_t try_to_copy, copied = 0;
 	struct sk_msg *msg_pl, *msg_en;
@@ -1457,7 +1457,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	bool cmsg = false;
 	int target, err = 0;
 	long timeo;
-	bool is_kvec = msg->msg_iter.type & ITER_KVEC;
+	bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
 	int num_async = 0;
 
 	flags |= nonblock;

