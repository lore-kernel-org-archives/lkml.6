Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D761C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207FB2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207FB2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbeJXIYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 04:24:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbeJXIYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 04:24:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 977693084295;
        Tue, 23 Oct 2018 23:58:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95BB3105704C;
        Tue, 23 Oct 2018 23:58:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/25] iov_iter: Add I/O discard iterator [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Oct 2018 00:58:17 +0100
Message-ID: <154033909786.12041.143666439362405914.stgit@warthog.procyon.org.uk>
In-Reply-To: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk>
References: <154033906284.12041.12908874734066278152.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 23 Oct 2018 23:58:19 +0000 (UTC)
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

 include/linux/uio.h |    7 ++++++
 lib/iov_iter.c      |   55 +++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 3d8f1acc142c..55ce99ddb912 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -26,6 +26,7 @@ enum iter_type {
 	ITER_KVEC = 2,
 	ITER_BVEC = 4,
 	ITER_PIPE = 8,
+	ITER_DISCARD = 16,
 };
 
 struct iov_iter {
@@ -72,6 +73,11 @@ static inline bool iov_iter_is_pipe(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_PIPE;
 }
 
+static inline bool iov_iter_is_discard(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_DISCARD;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->type & (READ | WRITE);
@@ -220,6 +226,7 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_
 			unsigned long nr_segs, size_t count);
 void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode_info *pipe,
 			size_t count);
+void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
 ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c42b928b15ef..7ebccb5c1637 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -83,6 +83,7 @@
 			const struct kvec *kvec;		\
 			struct kvec v;				\
 			iterate_kvec(i, n, v, kvec, skip, (K))	\
+		} else if (unlikely(i->type & ITER_DISCARD)) {	\
 		} else {					\
 			const struct iovec *iov;		\
 			struct iovec v;				\
@@ -114,6 +115,8 @@
 			}					\
 			i->nr_segs -= kvec - i->kvec;		\
 			i->kvec = kvec;				\
+		} else if (unlikely(i->type & ITER_DISCARD)) {	\
+			skip += n;				\
 		} else {					\
 			const struct iovec *iov;		\
 			struct iovec v;				\
@@ -838,7 +841,9 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 		size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
 		kunmap_atomic(kaddr);
 		return wanted;
-	} else if (likely(!iov_iter_is_pipe(i)))
+	} else if (unlikely(iov_iter_is_discard(i)))
+		return bytes;
+	else if (likely(!iov_iter_is_pipe(i)))
 		return copy_page_to_iter_iovec(page, offset, bytes, i);
 	else
 		return copy_page_to_iter_pipe(page, offset, bytes, i);
@@ -850,7 +855,7 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 {
 	if (unlikely(!page_copy_sane(page, offset, bytes)))
 		return 0;
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
 		WARN_ON(1);
 		return 0;
 	}
@@ -910,7 +915,7 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
 		kunmap_atomic(kaddr);
 		return 0;
 	}
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
 		kunmap_atomic(kaddr);
 		WARN_ON(1);
 		return 0;
@@ -978,6 +983,10 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 		pipe_advance(i, size);
 		return;
 	}
+	if (unlikely(iov_iter_is_discard(i))) {
+		i->count -= size;
+		return;
+	}
 	iterate_and_advance(i, size, v, 0, 0, 0)
 }
 EXPORT_SYMBOL(iov_iter_advance);
@@ -1013,6 +1022,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 		pipe_truncate(i);
 		return;
 	}
+	if (unlikely(iov_iter_is_discard(i)))
+		return;
 	if (unroll <= i->iov_offset) {
 		i->iov_offset -= unroll;
 		return;
@@ -1055,6 +1066,8 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 		return i->count;	// it is a silly place, anyway
 	if (i->nr_segs == 1)
 		return i->count;
+	if (unlikely(iov_iter_is_discard(i)))
+		return i->count;
 	else if (iov_iter_is_bvec(i))
 		return min(i->count, i->bvec->bv_len - i->iov_offset);
 	else
@@ -1103,6 +1116,24 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction,
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
+	i->type = ITER_DISCARD | READ;
+	i->count = count;
+	i->iov_offset = 0;
+}
+EXPORT_SYMBOL(iov_iter_discard);
+
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
 	unsigned long res = 0;
@@ -1127,7 +1158,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 	unsigned long res = 0;
 	size_t size = i->count;
 
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
 		WARN_ON(1);
 		return ~0U;
 	}
@@ -1197,6 +1228,9 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 
 	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_get_pages(i, pages, maxsize, maxpages, start);
+	if (unlikely(iov_iter_is_discard(i)))
+		return -EFAULT;
+
 	iterate_all_kinds(i, maxsize, v, ({
 		unsigned long addr = (unsigned long)v.iov_base;
 		size_t len = v.iov_len + (*start = addr & (PAGE_SIZE - 1));
@@ -1274,6 +1308,9 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 
 	if (unlikely(iov_iter_is_pipe(i)))
 		return pipe_get_pages_alloc(i, pages, maxsize, start);
+	if (unlikely(iov_iter_is_discard(i)))
+		return -EFAULT;
+
 	iterate_all_kinds(i, maxsize, v, ({
 		unsigned long addr = (unsigned long)v.iov_base;
 		size_t len = v.iov_len + (*start = addr & (PAGE_SIZE - 1));
@@ -1315,7 +1352,7 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
 		WARN_ON(1);
 		return 0;
 	}
@@ -1357,7 +1394,7 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
 		WARN_ON(1);
 		return false;
 	}
@@ -1402,7 +1439,7 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum,
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
 		WARN_ON(1);	/* for now */
 		return 0;
 	}
@@ -1444,6 +1481,8 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 
 	if (!size)
 		return 0;
+	if (unlikely(iov_iter_is_discard(i)))
+		return 0;
 
 	if (unlikely(iov_iter_is_pipe(i))) {
 		struct pipe_inode_info *pipe = i->pipe;
@@ -1487,6 +1526,8 @@ const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 		WARN_ON(1);
 		return NULL;
 	}
+	if (unlikely(iov_iter_is_discard(new)))
+		return NULL;
 	if (iov_iter_is_bvec(new))
 		return new->bvec = kmemdup(new->bvec,
 				    new->nr_segs * sizeof(struct bio_vec),

