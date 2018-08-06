Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3C4C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3295821A0C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3295821A0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbeHFP0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:26:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729714AbeHFP0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:26:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B879287A87;
        Mon,  6 Aug 2018 13:17:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7147176F2;
        Mon,  6 Aug 2018 13:17:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/10] iov_iter: Add mapping and discard iterator types
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew@wil.cx
Date:   Mon, 06 Aug 2018 14:17:05 +0100
Message-ID: <153356142497.1195.12462638099995772468.stgit@warthog.procyon.org.uk>
In-Reply-To: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
References: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 06 Aug 2018 13:17:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 06 Aug 2018 13:17:07 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two new iterator types to iov_iter:

 (1) ITER_MAPPING

     This walks through a set of pages attached to an address_space that
     are pinned or locked, starting at a given page and offset and walking
     for the specified amount of space.  A facility to get a callback each
     time a page is entirely processed is provided.

     This is useful for copying data from socket buffers to inodes in
     network filesystems.

 (2) ITER_DISCARD

     This is a sink iterator that can only be used in READ mode and just
     discards any data copied to it.

     This is useful in a network filesystem for discarding any unwanted
     data sent by a server.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/uio.h |    8 +
 lib/iov_iter.c      |  365 +++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 330 insertions(+), 43 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index d0655b74fd7e..24f6901472e9 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -14,6 +14,7 @@
 #include <uapi/linux/uio.h>
 
 struct page;
+struct address_space;
 struct pipe_inode_info;
 
 struct kvec {
@@ -26,6 +27,8 @@ enum iter_type {
 	ITER_KVEC,
 	ITER_BVEC,
 	ITER_PIPE,
+	ITER_DISCARD,
+	ITER_MAPPING,
 };
 
 struct iov_iter {
@@ -37,6 +40,7 @@ struct iov_iter {
 		const struct iovec *iov;
 		const struct kvec *kvec;
 		const struct bio_vec *bvec;
+		struct address_space *mapping;
 		struct pipe_inode_info *pipe;
 	};
 	union {
@@ -45,6 +49,7 @@ struct iov_iter {
 			int idx;
 			int start_idx;
 		};
+		void (*page_done)(const struct iov_iter *, const struct bio_vec *);
 	};
 };
 
@@ -211,6 +216,9 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_
 			unsigned long nr_segs, size_t count);
 void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode_info *pipe,
 			size_t count);
+void iov_iter_mapping(struct iov_iter *i, unsigned int direction, struct address_space *mapping,
+		      loff_t start, size_t count);
+void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
 ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 8231f0e38f20..22b35464891b 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -72,7 +72,35 @@
 	}						\
 }
 
-#define iterate_all_kinds(i, n, v, I, B, K) {			\
+#define iterate_mapping(i, n, __v, do_done, skip, STEP) {	\
+	struct radix_tree_iter cursor;				\
+	size_t wanted = n, seg, offset;				\
+	pgoff_t index = skip >> PAGE_SHIFT;			\
+	void __rcu **slot;					\
+								\
+	rcu_read_lock();					\
+	radix_tree_for_each_contig(slot, &i->mapping->i_pages,	\
+				   &cursor, index) {		\
+		if (!n)						\
+			break;					\
+		__v.bv_page = radix_tree_deref_slot(slot);	\
+		if (!__v.bv_page)				\
+			break;					\
+		offset = skip & ~PAGE_MASK;			\
+		seg = PAGE_SIZE - offset;			\
+		__v.bv_offset = offset;				\
+		__v.bv_len = min(n, seg);			\
+		(void)(STEP);					\
+		if (do_done && __v.bv_offset + __v.bv_len == PAGE_SIZE)	\
+			i->page_done(i, &__v);			\
+		n -= __v.bv_len;				\
+		skip += __v.bv_len;				\
+	}							\
+	rcu_read_unlock();					\
+	n = wanted - n;						\
+}
+
+#define iterate_all_kinds(i, n, v, I, B, K, M) {		\
 	if (likely(n)) {					\
 		loff_t skip = i->iov_offset;			\
 		switch (iov_iter_type(i)) {			\
@@ -91,6 +119,14 @@
 		case ITER_PIPE: {				\
 			break;					\
 		}						\
+		case ITER_MAPPING: {				\
+			struct bio_vec v;			\
+			iterate_mapping(i, n, v, false, skip, (M));	\
+			break;					\
+		}						\
+		case ITER_DISCARD: {				\
+			break;					\
+		}						\
 		case ITER_IOVEC: {				\
 			const struct iovec *iov;		\
 			struct iovec v;				\
@@ -101,7 +137,7 @@
 	}							\
 }
 
-#define iterate_and_advance(i, n, v, I, B, K) {			\
+#define iterate_and_advance(i, n, v, I, B, K, M) {		\
 	if (unlikely(i->count < n))				\
 		n = i->count;					\
 	if (i->count) {						\
@@ -129,6 +165,11 @@
 			i->kvec = kvec;				\
 			break;					\
 		}						\
+		case ITER_MAPPING: {				\
+			struct bio_vec v;			\
+			iterate_mapping(i, n, v, i->page_done, skip, (M))	\
+			break;					\
+		}						\
 		case ITER_IOVEC: {				\
 			const struct iovec *iov;		\
 			struct iovec v;				\
@@ -144,6 +185,10 @@
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
@@ -448,6 +493,8 @@ int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
 		break;
 	case ITER_KVEC:
 	case ITER_BVEC:
+	case ITER_MAPPING:
+	case ITER_DISCARD:
 		break;
 	}
 	return 0;
@@ -593,7 +640,9 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 		copyout(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len),
 		memcpy_to_page(v.bv_page, v.bv_offset,
 			       (from += v.bv_len) - v.bv_len, v.bv_len),
-		memcpy(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len)
+		memcpy(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len),
+		memcpy_to_page(v.bv_page, v.bv_offset,
+			       (from += v.bv_len) - v.bv_len, v.bv_len)
 	)
 
 	return bytes;
@@ -708,6 +757,15 @@ size_t _copy_to_iter_mcsafe(const void *addr, size_t bytes, struct iov_iter *i)
 			bytes = curr_addr - s_addr - rem;
 			return bytes;
 		}
+		}),
+		({
+		rem = memcpy_mcsafe_to_page(v.bv_page, v.bv_offset,
+                               (from += v.bv_len) - v.bv_len, v.bv_len);
+		if (rem) {
+			curr_addr = (unsigned long) from;
+			bytes = curr_addr - s_addr - rem;
+			return bytes;
+		}
 		})
 	)
 
@@ -729,7 +787,9 @@ size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 		copyin((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
 		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 
 	return bytes;
@@ -755,7 +815,9 @@ bool _copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
 		0;}),
 		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 
 	iov_iter_advance(i, bytes);
@@ -775,7 +837,9 @@ size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
 					 v.iov_base, v.iov_len),
 		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 
 	return bytes;
@@ -810,7 +874,9 @@ size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 		memcpy_page_flushcache((to += v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
 		memcpy_flushcache((to += v.iov_len) - v.iov_len, v.iov_base,
-			v.iov_len)
+			v.iov_len),
+		memcpy_page_flushcache((to += v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 
 	return bytes;
@@ -834,7 +900,9 @@ bool _copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
 		0;}),
 		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
-		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy((to += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+		memcpy_from_page((to += v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 
 	iov_iter_advance(i, bytes);
@@ -860,7 +928,8 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 		return 0;
 	switch (iov_iter_type(i)) {
 	case ITER_BVEC:
-	case ITER_KVEC: {
+	case ITER_KVEC:
+	case ITER_MAPPING: {
 		void *kaddr = kmap_atomic(page);
 		size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
@@ -870,6 +939,8 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 		return copy_page_to_iter_iovec(page, offset, bytes, i);
 	case ITER_PIPE:
 		return copy_page_to_iter_pipe(page, offset, bytes, i);
+	case ITER_DISCARD:
+		return bytes;
 	}
 	BUG();
 }
@@ -882,7 +953,9 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 		return 0;
 	switch (iov_iter_type(i)) {
 	case ITER_PIPE:
+	case ITER_DISCARD:
 		break;
+	case ITER_MAPPING:
 	case ITER_BVEC:
 	case ITER_KVEC: {
 		void *kaddr = kmap_atomic(page);
@@ -930,7 +1003,8 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 	iterate_and_advance(i, bytes, v,
 		clear_user(v.iov_base, v.iov_len),
 		memzero_page(v.bv_page, v.bv_offset, v.bv_len),
-		memset(v.iov_base, 0, v.iov_len)
+		memset(v.iov_base, 0, v.iov_len),
+		memzero_page(v.bv_page, v.bv_offset, v.bv_len)
 	)
 
 	return bytes;
@@ -945,7 +1019,7 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
 		kunmap_atomic(kaddr);
 		return 0;
 	}
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_type(i) == ITER_DISCARD)) {
 		kunmap_atomic(kaddr);
 		WARN_ON(1);
 		return 0;
@@ -954,7 +1028,9 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
 		copyin((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
 		memcpy_from_page((p += v.bv_len) - v.bv_len, v.bv_page,
 				 v.bv_offset, v.bv_len),
-		memcpy((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
+		memcpy((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
+		memcpy_from_page((p += v.bv_len) - v.bv_len, v.bv_page,
+				 v.bv_offset, v.bv_len)
 	)
 	kunmap_atomic(kaddr);
 	return bytes;
@@ -1016,7 +1092,14 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 	case ITER_IOVEC:
 	case ITER_KVEC:
 	case ITER_BVEC:
-		iterate_and_advance(i, size, v, 0, 0, 0);
+		iterate_and_advance(i, size, v, 0, 0, 0, 0);
+		return;
+	case ITER_MAPPING:
+		/* We really don't want to fetch pages is we can avoid it */
+		i->iov_offset += size;
+		/* Fall through */
+	case ITER_DISCARD:
+		i->count -= size;
 		return;
 	}
 	BUG();
@@ -1060,6 +1143,14 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 	}
 	unroll -= i->iov_offset;
 	switch (iov_iter_type(i)) {
+	case ITER_MAPPING:
+		BUG(); /* We should never go beyond the start of the mapping
+			* since iov_offset includes that page number as well as
+			* the in-page offset.
+			*/
+	case ITER_DISCARD:
+		i->iov_offset = 0;
+		return;
 	case ITER_BVEC: {
 		const struct bio_vec *bvec = i->bvec;
 		while (1) {
@@ -1103,6 +1194,8 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 		return i->count;
 	switch (iov_iter_type(i)) {
 	case ITER_PIPE:
+	case ITER_DISCARD:
+	case ITER_MAPPING:
 		return i->count;	// it is a silly place, anyway
 	case ITER_BVEC:
 		return min_t(size_t, i->count, i->bvec->bv_len - i->iov_offset);
@@ -1158,6 +1251,52 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_pipe);
 
+/**
+ * iov_iter_mapping - Initialise an I/O iterator to use the pages in a mapping
+ * @i: The iterator to initialise.
+ * @direction: The direction of the transfer.
+ * @mapping: The mapping to access.
+ * @start: The start file position.
+ * @count: The size of the I/O buffer in bytes.
+ *
+ * Set up an I/O iterator to either draw data out of the pages attached to an
+ * inode or to inject data into those pages.  The pages *must* be prevented
+ * from evaporation, either by taking a ref on them or locking them by the
+ * caller.
+ */
+void iov_iter_mapping(struct iov_iter *i, unsigned int direction,
+		      struct address_space *mapping,
+		      loff_t start, size_t count)
+{
+	BUG_ON(direction & ~1);
+	i->iter_dir = direction;
+	i->iter_type = ITER_MAPPING;
+	i->mapping = mapping;
+	i->count = count;
+	i->iov_offset = start;
+	i->page_done = NULL;
+}
+EXPORT_SYMBOL(iov_iter_mapping);
+
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
@@ -1171,7 +1310,8 @@ unsigned long iov_iter_alignment(const struct iov_iter *i)
 	iterate_all_kinds(i, size, v,
 		(res |= (unsigned long)v.iov_base | v.iov_len, 0),
 		res |= v.bv_offset | v.bv_len,
-		res |= (unsigned long)v.iov_base | v.iov_len
+		res |= (unsigned long)v.iov_base | v.iov_len,
+		res |= v.bv_offset | v.bv_len
 	)
 	return res;
 }
@@ -1182,7 +1322,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 	unsigned long res = 0;
 	size_t size = i->count;
 
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_type(i) == ITER_DISCARD)) {
 		WARN_ON(1);
 		return ~0U;
 	}
@@ -1193,7 +1333,9 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 		(res |= (!res ? 0 : (unsigned long)v.bv_offset) |
 			(size != v.bv_len ? size : 0)),
 		(res |= (!res ? 0 : (unsigned long)v.iov_base) |
-			(size != v.iov_len ? size : 0))
+			(size != v.iov_len ? size : 0)),
+		(res |= (!res ? 0 : (unsigned long)v.bv_offset) |
+			(size != v.bv_len ? size : 0))
 		);
 	return res;
 }
@@ -1243,6 +1385,43 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	return __pipe_get_pages(i, min(maxsize, capacity), pages, idx, start);
 }
 
+static ssize_t iter_mapping_get_pages(struct iov_iter *i,
+				      struct page **pages, size_t maxsize,
+				      unsigned maxpages, size_t *start)
+{
+	unsigned nr, offset;
+	pgoff_t index, count;
+	size_t size = maxsize;
+
+	if (!size || !maxpages)
+		return 0;
+
+	index = i->iov_offset >> PAGE_SHIFT;
+	offset = i->iov_offset & ~PAGE_MASK;
+	*start = offset;
+
+	count = 1;
+	if (size > PAGE_SIZE - offset) {
+		size -= PAGE_SIZE - offset;
+		count += size >> PAGE_SHIFT;
+		size &= ~PAGE_MASK;
+		if (size)
+			count++;
+	}
+
+	if (count > maxpages)
+		count = maxpages;
+
+	nr = find_get_pages_contig(i->mapping, index, count, pages);
+	if (nr == count)
+		return maxsize;
+	if (nr == 0)
+		return 0;
+	if (nr == 1)
+		return PAGE_SIZE - offset;
+	return (PAGE_SIZE - offset) + count * PAGE_SIZE;
+}
+
 ssize_t iov_iter_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
 		   size_t *start)
@@ -1253,6 +1432,9 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 	switch (iov_iter_type(i)) {
 	case ITER_PIPE:
 		return pipe_get_pages(i, pages, maxsize, maxpages, start);
+	case ITER_MAPPING:
+		return iter_mapping_get_pages(i, pages, maxsize, maxpages, start);
+	case ITER_DISCARD:
 	case ITER_KVEC:
 		return -EFAULT;
 	case ITER_IOVEC:
@@ -1279,9 +1461,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		*start = v.bv_offset;
 		get_page(*pages = v.bv_page);
 		return v.bv_len;
-	}),({
-		return -EFAULT;
-	})
+	}), 0, 0
 	)
 	return 0;
 }
@@ -1326,6 +1506,48 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 	return n;
 }
 
+static ssize_t iter_mapping_get_pages_alloc(struct iov_iter *i,
+					    struct page ***pages, size_t maxsize,
+					    size_t *start)
+{
+	struct page **p;
+	unsigned nr, offset;
+	pgoff_t index, count;
+	size_t size = maxsize;
+
+	if (!size)
+		return 0;
+
+	index = i->iov_offset >> PAGE_SHIFT;
+	offset = i->iov_offset & ~PAGE_MASK;
+	*start = offset;
+
+	count = 1;
+	if (size > PAGE_SIZE - offset) {
+		size -= PAGE_SIZE - offset;
+		count += size >> PAGE_SHIFT;
+		size &= ~PAGE_MASK;
+		if (size)
+			count++;
+	}
+
+	p = get_pages_array(count);
+	if (!p)
+		return -ENOMEM;
+	*pages = p;
+
+	nr = find_get_pages_contig(i->mapping, index, count, p);
+	if (nr == count)
+		return maxsize;
+	if (nr == 0) {
+		kvfree(p);
+		return 0;
+	}
+	if (nr == 1)
+		return PAGE_SIZE - offset;
+	return (PAGE_SIZE - offset) + count * PAGE_SIZE;
+}
+
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
 		   size_t *start)
@@ -1338,6 +1560,9 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 	switch (iov_iter_type(i)) {
 	case ITER_PIPE:
 		return pipe_get_pages_alloc(i, pages, maxsize, start);
+	case ITER_MAPPING:
+		return iter_mapping_get_pages_alloc(i, pages, maxsize, start);
+	case ITER_DISCARD:
 	case ITER_KVEC:
 		return -EFAULT;
 	case ITER_IOVEC:
@@ -1371,9 +1596,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 			return -ENOMEM;
 		get_page(*p = v.bv_page);
 		return v.bv_len;
-	}),({
-		return -EFAULT;
-	})
+	}), 0, 0
 	)
 	return 0;
 }
@@ -1386,7 +1609,7 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_type(i) == ITER_DISCARD)) {
 		WARN_ON(1);
 		return 0;
 	}
@@ -1414,6 +1637,14 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 						 v.iov_len, 0);
 		sum = csum_block_add(sum, next, off);
 		off += v.iov_len;
+	}), ({
+		char *p = kmap_atomic(v.bv_page);
+		next = csum_partial_copy_nocheck(p + v.bv_offset,
+						 (to += v.bv_len) - v.bv_len,
+						 v.bv_len, 0);
+		kunmap_atomic(p);
+		sum = csum_block_add(sum, next, off);
+		off += v.bv_len;
 	})
 	)
 	*csum = sum;
@@ -1428,7 +1659,7 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_type(i) == ITER_DISCARD)) {
 		WARN_ON(1);
 		return false;
 	}
@@ -1458,6 +1689,14 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 						 v.iov_len, 0);
 		sum = csum_block_add(sum, next, off);
 		off += v.iov_len;
+	}), ({
+		char *p = kmap_atomic(v.bv_page);
+		next = csum_partial_copy_nocheck(p + v.bv_offset,
+						 (to += v.bv_len) - v.bv_len,
+						 v.bv_len, 0);
+		kunmap_atomic(p);
+		sum = csum_block_add(sum, next, off);
+		off += v.bv_len;
 	})
 	)
 	*csum = sum;
@@ -1473,7 +1712,7 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum,
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_type(i) == ITER_DISCARD)) {
 		WARN_ON(1);	/* for now */
 		return 0;
 	}
@@ -1501,6 +1740,14 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum,
 						 v.iov_len, 0);
 		sum = csum_block_add(sum, next, off);
 		off += v.iov_len;
+	}), ({
+		char *p = kmap_atomic(v.bv_page);
+		next = csum_partial_copy_nocheck((from += v.bv_len) - v.bv_len,
+						 p + v.bv_offset,
+						 v.bv_len, 0);
+		kunmap_atomic(p);
+		sum = csum_block_add(sum, next, off);
+		off += v.bv_len;
 	})
 	)
 	*csum = sum;
@@ -1516,7 +1763,8 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 	if (!size)
 		return 0;
 
-	if (unlikely(iov_iter_is_pipe(i))) {
+	switch (iov_iter_type(i)) {
+	case ITER_PIPE: {
 		struct pipe_inode_info *pipe = i->pipe;
 		size_t off;
 		int idx;
@@ -1529,24 +1777,47 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
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
+	}
+	case ITER_MAPPING: {
+		unsigned offset;
+
+		offset = i->iov_offset & ~PAGE_MASK;
+
+		npages = 1;
+		if (size > PAGE_SIZE - offset) {
+			size -= PAGE_SIZE - offset;
+			npages += size >> PAGE_SHIFT;
+			size &= ~PAGE_MASK;
+			if (size)
+				npages++;
+		}
 		if (npages >= maxpages)
 			return maxpages;
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
+		}),
+		0
+		)
+	}
 	return npages;
 }
 EXPORT_SYMBOL(iov_iter_npages);
@@ -1567,6 +1838,9 @@ const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 		return new->iov = kmemdup(new->iov,
 				   new->nr_segs * sizeof(struct iovec),
 				   flags);
+	case ITER_MAPPING:
+	case ITER_DISCARD:
+		return NULL;
 	}
 
 	WARN_ON(1);
@@ -1670,7 +1944,12 @@ int iov_iter_for_each_range(struct iov_iter *i, size_t bytes,
 		kunmap(v.bv_page);
 		err;}), ({
 		w = v;
-		err = f(&w, context);})
+		err = f(&w, context);}), ({
+		w.iov_base = kmap(v.bv_page) + v.bv_offset;
+		w.iov_len = v.bv_len;
+		err = f(&w, context);
+		kunmap(v.bv_page);
+		err;})
 	)
 	return err;
 }

