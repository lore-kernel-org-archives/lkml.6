Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D6AECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089AC214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089AC214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJTJTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:19:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbeJTJTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:19:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69AFB7D0F1;
        Sat, 20 Oct 2018 01:11:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C85919495;
        Sat, 20 Oct 2018 01:11:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/24] iov_iter: Add I/O discard iterator
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:10:59 +0100
Message-ID: <153999785961.866.5674146318200239679.stgit@warthog.procyon.org.uk>
In-Reply-To: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sat, 20 Oct 2018 01:11:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new iterator, ITER_DISCARD, that can only be used in READ mode and
just discards any data copied to it.

This is useful in a network filesystem for discarding any unwanted data
sent by a server.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/uio.h |    7 ++++
 lib/iov_iter.c      |   96 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 79 insertions(+), 24 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index f445d5cbb571..58efe514b253 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -26,6 +26,7 @@ enum iter_type {
 	ITER_KVEC,
 	ITER_BVEC,
 	ITER_PIPE,
+	ITER_DISCARD,
 };
 
 struct iov_iter {
@@ -73,6 +74,11 @@ static inline bool iov_iter_is_pipe(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_PIPE;
 }
 
+static inline bool iov_iter_is_discard(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_DISCARD;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->iter_dir;
@@ -221,6 +227,7 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_
 			unsigned long nr_segs, size_t count);
 void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode_info *pipe,
 			size_t count);
+void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
 ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 3d8c459e7cd8..2288488e8aaa 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -91,6 +91,9 @@
 		case ITER_PIPE: {				\
 			break;					\
 		}						\
+		case ITER_DISCARD: {				\
+			break;					\
+		}						\
 		case ITER_IOVEC: {				\
 			const struct iovec *iov;		\
 			struct iovec v;				\
@@ -144,6 +147,10 @@
 		case ITER_PIPE: {				\
 			break;					\
 		}						\
+		case ITER_DISCARD: {				\
+			skip += n;				\
+			break;					\
+		}						\
 		}						\
 		i->count -= n;					\
 		i->iov_offset = skip;				\
@@ -448,6 +455,7 @@ int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
 		break;
 	case ITER_KVEC:
 	case ITER_BVEC:
+	case ITER_DISCARD:
 		break;
 	}
 	return 0;
@@ -870,6 +878,8 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 		return copy_page_to_iter_iovec(page, offset, bytes, i);
 	case ITER_PIPE:
 		return copy_page_to_iter_pipe(page, offset, bytes, i);
+	case ITER_DISCARD:
+		return bytes;
 	}
 	BUG();
 }
@@ -882,6 +892,7 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 		return 0;
 	switch (iov_iter_type(i)) {
 	case ITER_PIPE:
+	case ITER_DISCARD:
 		break;
 	case ITER_BVEC:
 	case ITER_KVEC: {
@@ -945,7 +956,7 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
 		kunmap_atomic(kaddr);
 		return 0;
 	}
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_type(i) == ITER_DISCARD)) {
 		kunmap_atomic(kaddr);
 		WARN_ON(1);
 		return 0;
@@ -1018,6 +1029,9 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 	case ITER_BVEC:
 		iterate_and_advance(i, size, v, 0, 0, 0);
 		return;
+	case ITER_DISCARD:
+		i->count -= size;
+		return;
 	}
 	BUG();
 }
@@ -1060,6 +1074,9 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 	}
 	unroll -= i->iov_offset;
 	switch (iov_iter_type(i)) {
+	case ITER_DISCARD:
+		i->iov_offset = 0;
+		return;
 	case ITER_BVEC: {
 		const struct bio_vec *bvec = i->bvec;
 		while (1) {
@@ -1103,6 +1120,7 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 		return i->count;
 	switch (iov_iter_type(i)) {
 	case ITER_PIPE:
+	case ITER_DISCARD:
 		return i->count;	// it is a silly place, anyway
 	case ITER_BVEC:
 		return min(i->count, i->bvec->bv_len - i->iov_offset);
@@ -1158,6 +1176,25 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_pipe);
 
+/**
+ * iov_iter_discard - Initialise an I/O iterator that discards data
+ * @i: The iterator to initialise.
+ * @direction: The direction of the transfer.
+ * @count: The size of the I/O buffer in bytes.
+ *
+ * Set up an I/O iterator that just discards everything that's written to it.
+ * It's only available as a READ iterator.
+ */
+void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
+{
+	BUG_ON(direction != READ);
+	i->iter_dir = READ;
+	i->iter_type = ITER_DISCARD;
+	i->count = count;
+	i->iov_offset = 0;
+}
+EXPORT_SYMBOL(iov_iter_discard);
+
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
 	unsigned long res = 0;
@@ -1182,7 +1219,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 	unsigned long res = 0;
 	size_t size = i->count;
 
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_type(i) == ITER_DISCARD)) {
 		WARN_ON(1);
 		return ~0U;
 	}
@@ -1253,6 +1290,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 	switch (iov_iter_type(i)) {
 	case ITER_PIPE:
 		return pipe_get_pages(i, pages, maxsize, maxpages, start);
+	case ITER_DISCARD:
 	case ITER_KVEC:
 		return -EFAULT;
 	case ITER_IOVEC:
@@ -1336,6 +1374,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 	switch (iov_iter_type(i)) {
 	case ITER_PIPE:
 		return pipe_get_pages_alloc(i, pages, maxsize, start);
+	case ITER_DISCARD:
 	case ITER_KVEC:
 		return -EFAULT;
 	case ITER_IOVEC:
@@ -1382,7 +1421,7 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_type(i) == ITER_DISCARD)) {
 		WARN_ON(1);
 		return 0;
 	}
@@ -1424,7 +1463,7 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_type(i) == ITER_DISCARD)) {
 		WARN_ON(1);
 		return false;
 	}
@@ -1469,7 +1508,7 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum,
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_type(i) == ITER_DISCARD)) {
 		WARN_ON(1);	/* for now */
 		return 0;
 	}
@@ -1512,7 +1551,8 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 	if (!size)
 		return 0;
 
-	if (unlikely(iov_iter_is_pipe(i))) {
+	switch (iov_iter_type(i)) {
+	case ITER_PIPE: {
 		struct pipe_inode_info *pipe = i->pipe;
 		size_t off;
 		int idx;
@@ -1525,24 +1565,30 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 		npages = ((pipe->curbuf - idx - 1) & (pipe->buffers - 1)) + 1;
 		if (npages >= maxpages)
 			return maxpages;
-	} else iterate_all_kinds(i, size, v, ({
-		unsigned long p = (unsigned long)v.iov_base;
-		npages += DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
-			- p / PAGE_SIZE;
-		if (npages >= maxpages)
-			return maxpages;
-	0;}),({
-		npages++;
-		if (npages >= maxpages)
-			return maxpages;
-	}),({
-		unsigned long p = (unsigned long)v.iov_base;
-		npages += DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
-			- p / PAGE_SIZE;
-		if (npages >= maxpages)
-			return maxpages;
-	})
-	)
+	}
+	case ITER_DISCARD:
+		return 0;
+
+	default:
+		iterate_all_kinds(i, size, v, ({
+			unsigned long p = (unsigned long)v.iov_base;
+			npages += DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
+				- p / PAGE_SIZE;
+			if (npages >= maxpages)
+				return maxpages;
+		0;}),({
+			npages++;
+			if (npages >= maxpages)
+				return maxpages;
+		}),({
+			unsigned long p = (unsigned long)v.iov_base;
+			npages += DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
+				- p / PAGE_SIZE;
+			if (npages >= maxpages)
+				return maxpages;
+		})
+		)
+	}
 	return npages;
 }
 EXPORT_SYMBOL(iov_iter_npages);
@@ -1563,6 +1609,8 @@ const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 		return new->iov = kmemdup(new->iov,
 				   new->nr_segs * sizeof(struct iovec),
 				   flags);
+	case ITER_DISCARD:
+		return NULL;
 	}
 
 	WARN_ON(1);

