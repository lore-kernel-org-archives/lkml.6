Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BD5C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A5621A09
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A5621A09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbeHFP0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:26:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729714AbeHFP0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:26:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC31C8011454;
        Mon,  6 Aug 2018 13:16:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E96CC2156897;
        Mon,  6 Aug 2018 13:16:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/10] iov_iter: Make count and iov_offset loff_t not size_t
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew@wil.cx
Date:   Mon, 06 Aug 2018 14:16:58 +0100
Message-ID: <153356141842.1195.6854849320089666173.stgit@warthog.procyon.org.uk>
In-Reply-To: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
References: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 13:16:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 13:16:59 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make count and iov_offset loff_t not size_t so that they can handle
transactions larger than 4GiB in size and starting at 4GiB or more into a
file on a 32-bit system.

On a 64-bit system, this should make no difference.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/9p/vfs_file.c    |    2 +-
 fs/btrfs/file.c     |    7 ++++---
 fs/nfs/direct.c     |    2 +-
 fs/nfs/file.c       |    4 ++--
 include/linux/uio.h |    6 +++---
 lib/iov_iter.c      |   14 +++++++-------
 net/9p/client.c     |    2 +-
 net/rxrpc/recvmsg.c |    4 ++--
 8 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 03c9e325bfbc..a83b81ea677f 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -384,7 +384,7 @@ v9fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct p9_fid *fid = iocb->ki_filp->private_data;
 	int ret, err = 0;
 
-	p9_debug(P9_DEBUG_VFS, "count %zu offset %lld\n",
+	p9_debug(P9_DEBUG_VFS, "count %llu offset %lld\n",
 		 iov_iter_count(to), iocb->ki_pos);
 
 	ret = p9_client_read(fid, iocb->ki_pos, to, &err);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 51e77d72068a..48bf2b0af7b5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1599,9 +1599,10 @@ static noinline ssize_t __btrfs_buffered_write(struct file *file,
 	while (iov_iter_count(i) > 0) {
 		size_t offset = pos & (PAGE_SIZE - 1);
 		size_t sector_offset;
-		size_t write_bytes = min(iov_iter_count(i),
-					 nrptrs * (size_t)PAGE_SIZE -
-					 offset);
+		size_t write_bytes = min_t(size_t,
+					   iov_iter_count(i),
+					   nrptrs * (size_t)PAGE_SIZE -
+					   offset);
 		size_t num_pages = DIV_ROUND_UP(write_bytes + offset,
 						PAGE_SIZE);
 		size_t reserve_bytes;
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 621c517b325c..3d438aa2650b 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -974,7 +974,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 	struct nfs_lock_context *l_ctx;
 	loff_t pos, end;
 
-	dfprintk(FILE, "NFS: direct write(%pD2, %zd@%Ld)\n",
+	dfprintk(FILE, "NFS: direct write(%pD2, %lld@%lld)\n",
 		file, iov_iter_count(iter), (long long) iocb->ki_pos);
 
 	result = generic_write_checks(iocb, iter);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 81cca49a8375..ef4fd7124ca1 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -159,7 +159,7 @@ nfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 	if (iocb->ki_flags & IOCB_DIRECT)
 		return nfs_file_direct_read(iocb, to);
 
-	dprintk("NFS: read(%pD2, %zu@%lu)\n",
+	dprintk("NFS: read(%pD2, %llu@%lu)\n",
 		iocb->ki_filp,
 		iov_iter_count(to), (unsigned long) iocb->ki_pos);
 
@@ -608,7 +608,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_flags & IOCB_DIRECT)
 		return nfs_file_direct_write(iocb, from);
 
-	dprintk("NFS: write(%pD2, %zu@%Ld)\n",
+	dprintk("NFS: write(%pD2, %llu@%Ld)\n",
 		file, iov_iter_count(from), (long long) iocb->ki_pos);
 
 	if (IS_SWAPFILE(inode))
diff --git a/include/linux/uio.h b/include/linux/uio.h
index d5f8755bf778..d0655b74fd7e 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -31,7 +31,7 @@ enum iter_type {
 struct iov_iter {
 	enum iter_type iter_type:8;
 	u8 iter_dir;
-	size_t iov_offset;
+	loff_t iov_offset;
 	size_t count;
 	union {
 		const struct iovec *iov;
@@ -89,7 +89,7 @@ static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
 {
 	return (struct iovec) {
 		.iov_base = iter->iov->iov_base + iter->iov_offset,
-		.iov_len = min(iter->count,
+		.iov_len = min_t(size_t, iter->count,
 			       iter->iov->iov_len - iter->iov_offset),
 	};
 }
@@ -219,7 +219,7 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages);
 
 const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
 
-static inline size_t iov_iter_count(const struct iov_iter *i)
+static inline loff_t iov_iter_count(const struct iov_iter *i)
 {
 	return i->count;
 }
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f30ecd263d6e..8231f0e38f20 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -13,7 +13,7 @@
 	size_t left;					\
 	size_t wanted = n;				\
 	__p = i->iov;					\
-	__v.iov_len = min(n, __p->iov_len - skip);	\
+	__v.iov_len = min_t(size_t, n, __p->iov_len - skip);	\
 	if (likely(__v.iov_len)) {			\
 		__v.iov_base = __p->iov_base + skip;	\
 		left = (STEP);				\
@@ -40,7 +40,7 @@
 #define iterate_kvec(i, n, __v, __p, skip, STEP) {	\
 	size_t wanted = n;				\
 	__p = i->kvec;					\
-	__v.iov_len = min(n, __p->iov_len - skip);	\
+	__v.iov_len = min_t(size_t, n, __p->iov_len - skip);	\
 	if (likely(__v.iov_len)) {			\
 		__v.iov_base = __p->iov_base + skip;	\
 		(void)(STEP);				\
@@ -74,7 +74,7 @@
 
 #define iterate_all_kinds(i, n, v, I, B, K) {			\
 	if (likely(n)) {					\
-		size_t skip = i->iov_offset;			\
+		loff_t skip = i->iov_offset;			\
 		switch (iov_iter_type(i)) {			\
 		case ITER_BVEC: {				\
 			struct bio_vec v;			\
@@ -105,7 +105,7 @@
 	if (unlikely(i->count < n))				\
 		n = i->count;					\
 	if (i->count) {						\
-		size_t skip = i->iov_offset;			\
+		loff_t skip = i->iov_offset;			\
 		switch (iov_iter_type(i)) {			\
 		case ITER_BVEC: {				\
 			const struct bio_vec *bvec = i->bvec;	\
@@ -358,7 +358,7 @@ static bool sanity(const struct iov_iter *i)
 	}
 	return true;
 Bad:
-	printk(KERN_ERR "idx = %d, offset = %zd\n", i->idx, i->iov_offset);
+	printk(KERN_ERR "idx = %d, offset = %lld\n", i->idx, i->iov_offset);
 	printk(KERN_ERR "curbuf = %d, nrbufs = %d, buffers = %d\n",
 			pipe->curbuf, pipe->nrbufs, pipe->buffers);
 	for (idx = 0; idx < pipe->buffers; idx++)
@@ -1105,10 +1105,10 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 	case ITER_PIPE:
 		return i->count;	// it is a silly place, anyway
 	case ITER_BVEC:
-		return min(i->count, i->bvec->bv_len - i->iov_offset);
+		return min_t(size_t, i->count, i->bvec->bv_len - i->iov_offset);
 	case ITER_KVEC:
 	case ITER_IOVEC:
-		return min(i->count, i->iov->iov_len - i->iov_offset);
+		return min_t(size_t, i->count, i->iov->iov_len - i->iov_offset);
 	}
 	BUG();
 }
diff --git a/net/9p/client.c b/net/9p/client.c
index 1e853e2a62bb..19b045714206 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1649,7 +1649,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 	int total = 0;
 	*err = 0;
 
-	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %zd\n",
+	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %llu\n",
 				fid->fid, (unsigned long long) offset,
 				iov_iter_count(from));
 
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 816b19a78809..920f505baedd 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -633,7 +633,7 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 	size_t offset = 0;
 	int ret;
 
-	_enter("{%d,%s},%zu,%d",
+	_enter("{%d,%s},%llu,%d",
 	       call->debug_id, rxrpc_call_states[call->state],
 	       iov_iter_count(iter), want_more);
 
@@ -693,7 +693,7 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 	if (_service)
 		*_service = call->service_id;
 	mutex_unlock(&call->user_mutex);
-	_leave(" = %d [%zu,%d]", ret, iov_iter_count(iter), *_abort);
+	_leave(" = %d [%llu,%d]", ret, iov_iter_count(iter), *_abort);
 	return ret;
 
 short_data:

