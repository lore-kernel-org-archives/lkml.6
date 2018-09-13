Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE1FC6176
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CCA2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CCA2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeIMVCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:02:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbeIMVCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:02:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADB953082B54;
        Thu, 13 Sep 2018 15:52:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76D70608E0;
        Thu, 13 Sep 2018 15:52:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/10] iov_iter: Make count and iov_offset loff_t not size_t
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Sep 2018 16:52:00 +0100
Message-ID: <153685392069.14766.2190371088829334996.stgit@warthog.procyon.org.uk>
In-Reply-To: <153685389564.14766.11306559824641824935.stgit@warthog.procyon.org.uk>
References: <153685389564.14766.11306559824641824935.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 13 Sep 2018 15:52:02 +0000 (UTC)
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

 fs/btrfs/file.c     |    7 ++++---
 fs/nfs/direct.c     |    2 +-
 include/linux/uio.h |    4 ++--
 lib/iov_iter.c      |   14 +++++++-------
 net/9p/client.c     |    2 +-
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2be00e873e92..cdf3149a5871 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1596,9 +1596,10 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
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
index aa12c3063bae..6550e712b063 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -974,7 +974,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 	struct nfs_lock_context *l_ctx;
 	loff_t pos, end;
 
-	dfprintk(FILE, "NFS: direct write(%pD2, %zd@%Ld)\n",
+	dfprintk(FILE, "NFS: direct write(%pD2, %zu@%lld)\n",
 		file, iov_iter_count(iter), (long long) iocb->ki_pos);
 
 	result = generic_write_checks(iocb, iter);
diff --git a/include/linux/uio.h b/include/linux/uio.h
index d5f8755bf778..1e03cb50a0e0 100644
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
index a9cd1401bd09..10f74bd027dd 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1631,7 +1631,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 	int total = 0;
 	*err = 0;
 
-	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %zd\n",
+	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %zu\n",
 				fid->fid, (unsigned long long) offset,
 				iov_iter_count(from));
 

