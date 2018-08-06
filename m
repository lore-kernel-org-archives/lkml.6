Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA73FC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E4721A0B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E4721A0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbeHFPZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:25:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729714AbeHFPZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:25:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 453D07C6A9;
        Mon,  6 Aug 2018 13:16:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EB731C4C3;
        Mon,  6 Aug 2018 13:16:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/10] iov_iter: Renumber the ITER_* constants in uio.h
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew@wil.cx
Date:   Mon, 06 Aug 2018 14:16:52 +0100
Message-ID: <153356141193.1195.857800682411976761.stgit@warthog.procyon.org.uk>
In-Reply-To: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
References: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 06 Aug 2018 13:16:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 06 Aug 2018 13:16:53 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renumber the ITER_* constants in uio.h to be contiguous to make comparing
them more efficient in a switch-statement.

Signed-off-by: David Howells <dhowelsl@redhat.com>
---

 include/linux/uio.h |    8 +++---
 lib/iov_iter.c      |   69 +++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 48e7fa36f923..d5f8755bf778 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -22,10 +22,10 @@ struct kvec {
 };
 
 enum iter_type {
-	ITER_IOVEC = 0,
-	ITER_KVEC = 2,
-	ITER_BVEC = 4,
-	ITER_PIPE = 8,
+	ITER_IOVEC,
+	ITER_KVEC,
+	ITER_BVEC,
+	ITER_PIPE,
 };
 
 struct iov_iter {
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index bd828591afb0..f30ecd263d6e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -75,18 +75,28 @@
 #define iterate_all_kinds(i, n, v, I, B, K) {			\
 	if (likely(n)) {					\
 		size_t skip = i->iov_offset;			\
-		if (unlikely(i->iter_type & ITER_BVEC)) {	\
+		switch (iov_iter_type(i)) {			\
+		case ITER_BVEC: {				\
 			struct bio_vec v;			\
 			struct bvec_iter __bi;			\
-			iterate_bvec(i, n, v, __bi, skip, (B))	\
-		} else if (unlikely(i->iter_type & ITER_KVEC)) { \
+			iterate_bvec(i, n, v, __bi, skip, (B));	\
+			break;					\
+		}						\
+		case ITER_KVEC: {				\
 			const struct kvec *kvec;		\
 			struct kvec v;				\
-			iterate_kvec(i, n, v, kvec, skip, (K))	\
-		} else {					\
+			iterate_kvec(i, n, v, kvec, skip, (K));	\
+			break;					\
+		}						\
+		case ITER_PIPE: {				\
+			break;					\
+		}						\
+		case ITER_IOVEC: {				\
 			const struct iovec *iov;		\
 			struct iovec v;				\
-			iterate_iovec(i, n, v, iov, skip, (I))	\
+			iterate_iovec(i, n, v, iov, skip, (I));	\
+			break;					\
+		}						\
 		}						\
 	}							\
 }
@@ -96,7 +106,8 @@
 		n = i->count;					\
 	if (i->count) {						\
 		size_t skip = i->iov_offset;			\
-		if (unlikely(i->iter_type & ITER_BVEC)) {		\
+		switch (iov_iter_type(i)) {			\
+		case ITER_BVEC: {				\
 			const struct bio_vec *bvec = i->bvec;	\
 			struct bio_vec v;			\
 			struct bvec_iter __bi;			\
@@ -104,7 +115,9 @@
 			i->bvec = __bvec_iter_bvec(i->bvec, __bi);	\
 			i->nr_segs -= i->bvec - bvec;		\
 			skip = __bi.bi_bvec_done;		\
-		} else if (unlikely(i->iter_type & ITER_KVEC)) {	\
+			break;					\
+		}						\
+		case ITER_KVEC: {				\
 			const struct kvec *kvec;		\
 			struct kvec v;				\
 			iterate_kvec(i, n, v, kvec, skip, (K))	\
@@ -114,7 +127,9 @@
 			}					\
 			i->nr_segs -= kvec - i->kvec;		\
 			i->kvec = kvec;				\
-		} else {					\
+			break;					\
+		}						\
+		case ITER_IOVEC: {				\
 			const struct iovec *iov;		\
 			struct iovec v;				\
 			iterate_iovec(i, n, v, iov, skip, (I))	\
@@ -124,6 +139,11 @@
 			}					\
 			i->nr_segs -= iov - i->iov;		\
 			i->iov = iov;				\
+			break;					\
+		}						\
+		case ITER_PIPE: {				\
+			break;					\
+		}						\
 		}						\
 		i->count -= n;					\
 		i->iov_offset = skip;				\
@@ -873,6 +893,7 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 	case ITER_IOVEC:
 		return copy_page_from_iter_iovec(page, offset, bytes, i);
 	}
+
 	WARN_ON(1);
 	return 0;
 }
@@ -988,11 +1009,17 @@ static void pipe_advance(struct iov_iter *i, size_t size)
 
 void iov_iter_advance(struct iov_iter *i, size_t size)
 {
-	if (unlikely(iov_iter_is_pipe(i))) {
+	switch (iov_iter_type(i)) {
+	case ITER_PIPE:
 		pipe_advance(i, size);
 		return;
+	case ITER_IOVEC:
+	case ITER_KVEC:
+	case ITER_BVEC:
+		iterate_and_advance(i, size, v, 0, 0, 0);
+		return;
 	}
-	iterate_and_advance(i, size, v, 0, 0, 0)
+	BUG();
 }
 EXPORT_SYMBOL(iov_iter_advance);
 
@@ -1223,8 +1250,16 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 	if (maxsize > i->count)
 		maxsize = i->count;
 
-	if (unlikely(iov_iter_is_pipe(i)))
+	switch (iov_iter_type(i)) {
+	case ITER_PIPE:
 		return pipe_get_pages(i, pages, maxsize, maxpages, start);
+	case ITER_KVEC:
+		return -EFAULT;
+	case ITER_IOVEC:
+	case ITER_BVEC:
+		break;
+	}
+
 	iterate_all_kinds(i, maxsize, v, ({
 		unsigned long addr = (unsigned long)v.iov_base;
 		size_t len = v.iov_len + (*start = addr & (PAGE_SIZE - 1));
@@ -1300,8 +1335,16 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 	if (maxsize > i->count)
 		maxsize = i->count;
 
-	if (unlikely(iov_iter_is_pipe(i)))
+	switch (iov_iter_type(i)) {
+	case ITER_PIPE:
 		return pipe_get_pages_alloc(i, pages, maxsize, start);
+	case ITER_KVEC:
+		return -EFAULT;
+	case ITER_IOVEC:
+	case ITER_BVEC:
+		break;
+	}
+
 	iterate_all_kinds(i, maxsize, v, ({
 		unsigned long addr = (unsigned long)v.iov_base;
 		size_t len = v.iov_len + (*start = addr & (PAGE_SIZE - 1));

