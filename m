Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E550C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F79220874
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 01:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F79220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeKYMln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 07:41:43 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56160 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeKYMln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 07:41:43 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gQjZk-0006AT-CR; Sun, 25 Nov 2018 01:51:11 +0000
Date:   Sun, 25 Nov 2018 01:51:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Slavomir Kaslev <kaslevs@vmware.com>
Cc:     syzbot <syzbot+ce18da013d76d837144d@syzkaller.appspotmail.com>,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        kgraul@linux.ibm.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, stranche@codeaurora.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in csum_and_copy_to_iter
Message-ID: <20181125015104.GE2217@ZenIV.linux.org.uk>
References: <0000000000001ecaa1057b6e4489@google.com>
 <20181124200357.GC2217@ZenIV.linux.org.uk>
 <20181124211918.GA20435@box>
 <20181124214436.GD2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181124214436.GD2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 09:44:36PM +0000, Al Viro wrote:

> No point, IMO - the fix isn't hard and bisect hazard created by the whole thing
> is both mild (spurious WARN() in case that used to fail anyway) _and_ won't
> disappear from reverting, obviously.  I'll post a fix later tonight...

FWIW, I think the following ought to work; it's obviously a pair of commits
(introduction of convenience helper/switch to its use + csum_and_copy_to_iter()
for ITER_PIPE), as well as commit message, etc., but I would really appreciate
if folks gave it a look _and_ a beating.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7ebccb5c1637..621984743268 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -560,6 +560,44 @@ static size_t copy_pipe_to_iter(const void *addr, size_t bytes,
 	return bytes;
 }
 
+static __wsum csum_and_memcpy(void *to, const void *from, size_t len,
+			      __wsum sum, size_t off)
+{
+	__wsum next = csum_partial_copy_nocheck(from, to, len, 0);
+	return csum_block_add(sum, next, off);
+}
+
+static size_t csum_and_copy_to_pipe_iter(const void *addr, size_t bytes,
+				__wsum *csum, struct iov_iter *i)
+{
+	struct pipe_inode_info *pipe = i->pipe;
+	size_t n, r;
+	size_t off = 0;
+	__wsum sum = *csum;
+	int idx;
+
+	if (!sanity(i))
+		return 0;
+
+	bytes = n = push_pipe(i, bytes, &idx, &r);
+	if (unlikely(!n))
+		return 0;
+	for ( ; n; idx = next_idx(idx, pipe), r = 0) {
+		size_t chunk = min_t(size_t, n, PAGE_SIZE - r);
+		char *p = kmap_atomic(pipe->bufs[idx].page);
+		sum = csum_and_memcpy(p + r, addr, chunk, sum, off);
+		kunmap_atomic(p);
+		i->idx = idx;
+		i->iov_offset = r + chunk;
+		n -= chunk;
+		off += chunk;
+		addr += chunk;
+	}
+	i->count -= bytes;
+	*csum = sum;
+	return bytes;
+}
+
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	const char *from = addr;
@@ -1368,17 +1406,15 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 		err ? v.iov_len : 0;
 	}), ({
 		char *p = kmap_atomic(v.bv_page);
-		next = csum_partial_copy_nocheck(p + v.bv_offset,
-						 (to += v.bv_len) - v.bv_len,
-						 v.bv_len, 0);
+		sum = csum_and_memcpy((to += v.bv_len) - v.bv_len,
+				      p + v.bv_offset, v.bv_len,
+				      sum, off);
 		kunmap_atomic(p);
-		sum = csum_block_add(sum, next, off);
 		off += v.bv_len;
 	}),({
-		next = csum_partial_copy_nocheck(v.iov_base,
-						 (to += v.iov_len) - v.iov_len,
-						 v.iov_len, 0);
-		sum = csum_block_add(sum, next, off);
+		sum = csum_and_memcpy((to += v.iov_len) - v.iov_len,
+				      v.iov_base, v.iov_len,
+				      sum, off);
 		off += v.iov_len;
 	})
 	)
@@ -1412,17 +1448,15 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 		0;
 	}), ({
 		char *p = kmap_atomic(v.bv_page);
-		next = csum_partial_copy_nocheck(p + v.bv_offset,
-						 (to += v.bv_len) - v.bv_len,
-						 v.bv_len, 0);
+		sum = csum_and_memcpy((to += v.bv_len) - v.bv_len,
+				      p + v.bv_offset, v.bv_len,
+				      sum, off);
 		kunmap_atomic(p);
-		sum = csum_block_add(sum, next, off);
 		off += v.bv_len;
 	}),({
-		next = csum_partial_copy_nocheck(v.iov_base,
-						 (to += v.iov_len) - v.iov_len,
-						 v.iov_len, 0);
-		sum = csum_block_add(sum, next, off);
+		sum = csum_and_memcpy((to += v.iov_len) - v.iov_len,
+				      v.iov_base, v.iov_len,
+				      sum, off);
 		off += v.iov_len;
 	})
 	)
@@ -1438,8 +1472,12 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum,
 	const char *from = addr;
 	__wsum sum, next;
 	size_t off = 0;
+
+	if (unlikely(iov_iter_is_pipe(i)))
+		return csum_and_copy_to_pipe_iter(addr, bytes, csum, i);
+
 	sum = *csum;
-	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
+	if (unlikely(iov_iter_is_discard(i))) {
 		WARN_ON(1);	/* for now */
 		return 0;
 	}
@@ -1455,17 +1493,15 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum,
 		err ? v.iov_len : 0;
 	}), ({
 		char *p = kmap_atomic(v.bv_page);
-		next = csum_partial_copy_nocheck((from += v.bv_len) - v.bv_len,
-						 p + v.bv_offset,
-						 v.bv_len, 0);
+		sum = csum_and_memcpy(p + v.bv_offset,
+				      (from += v.bv_len) - v.bv_len,
+				      v.bv_len, sum, off);
 		kunmap_atomic(p);
-		sum = csum_block_add(sum, next, off);
 		off += v.bv_len;
 	}),({
-		next = csum_partial_copy_nocheck((from += v.iov_len) - v.iov_len,
-						 v.iov_base,
-						 v.iov_len, 0);
-		sum = csum_block_add(sum, next, off);
+		sum = csum_and_memcpy(v.iov_base,
+				     (from += v.iov_len) - v.iov_len,
+				     v.iov_len, sum, off);
 		off += v.iov_len;
 	})
 	)
