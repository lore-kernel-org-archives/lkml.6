Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC62FC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E75120661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E75120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeLIWZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:25:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34920 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726451AbeLIVzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:16 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0002ia-PO; Sun, 09 Dec 2018 21:55:12 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0003LD-TK; Sun, 09 Dec 2018 21:55:09 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Liu Chao" <liuchao741@huawei.com>,
        "Eric Biggers" <ebiggers@google.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.526623812@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 100/328] crypto: ablkcipher - fix crash flushing
 dcache in error path
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 318abdfbe708aaaa652c79fb500e9bd60521f9dc upstream.

Like the skcipher_walk and blkcipher_walk cases:

scatterwalk_done() is only meant to be called after a nonzero number of
bytes have been processed, since scatterwalk_pagedone() will flush the
dcache of the *previous* page.  But in the error case of
ablkcipher_walk_done(), e.g. if the input wasn't an integer number of
blocks, scatterwalk_done() was actually called after advancing 0 bytes.
This caused a crash ("BUG: unable to handle kernel paging request")
during '!PageSlab(page)' on architectures like arm and arm64 that define
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE, provided that the input was
page-aligned as in that case walk->offset == 0.

Fix it by reorganizing ablkcipher_walk_done() to skip the
scatterwalk_advance() and scatterwalk_done() if an error has occurred.

Reported-by: Liu Chao <liuchao741@huawei.com>
Fixes: bf06099db18a ("crypto: skcipher - Add ablkcipher_walk interfaces")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 crypto/ablkcipher.c | 57 +++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

--- a/crypto/ablkcipher.c
+++ b/crypto/ablkcipher.c
@@ -72,11 +72,9 @@ static inline u8 *ablkcipher_get_spot(u8
 	return max(start, end_page);
 }
 
-static inline unsigned int ablkcipher_done_slow(struct ablkcipher_walk *walk,
-						unsigned int bsize)
+static inline void ablkcipher_done_slow(struct ablkcipher_walk *walk,
+					unsigned int n)
 {
-	unsigned int n = bsize;
-
 	for (;;) {
 		unsigned int len_this_page = scatterwalk_pagelen(&walk->out);
 
@@ -88,17 +86,13 @@ static inline unsigned int ablkcipher_do
 		n -= len_this_page;
 		scatterwalk_start(&walk->out, scatterwalk_sg_next(walk->out.sg));
 	}
-
-	return bsize;
 }
 
-static inline unsigned int ablkcipher_done_fast(struct ablkcipher_walk *walk,
-						unsigned int n)
+static inline void ablkcipher_done_fast(struct ablkcipher_walk *walk,
+					unsigned int n)
 {
 	scatterwalk_advance(&walk->in, n);
 	scatterwalk_advance(&walk->out, n);
-
-	return n;
 }
 
 static int ablkcipher_walk_next(struct ablkcipher_request *req,
@@ -108,39 +102,40 @@ int ablkcipher_walk_done(struct ablkciph
 			 struct ablkcipher_walk *walk, int err)
 {
 	struct crypto_tfm *tfm = req->base.tfm;
-	unsigned int nbytes = 0;
+	unsigned int n; /* bytes processed */
+	bool more;
 
-	if (likely(err >= 0)) {
-		unsigned int n = walk->nbytes - err;
+	if (unlikely(err < 0))
+		goto finish;
 
-		if (likely(!(walk->flags & ABLKCIPHER_WALK_SLOW)))
-			n = ablkcipher_done_fast(walk, n);
-		else if (WARN_ON(err)) {
+	n = walk->nbytes - err;
+	walk->total -= n;
+	more = (walk->total != 0);
+
+	if (likely(!(walk->flags & ABLKCIPHER_WALK_SLOW))) {
+		ablkcipher_done_fast(walk, n);
+	} else {
+		if (WARN_ON(err)) {
+			/* unexpected case; didn't process all bytes */
 			err = -EINVAL;
-			goto err;
-		} else
-			n = ablkcipher_done_slow(walk, n);
-
-		nbytes = walk->total - n;
-		err = 0;
+			goto finish;
+		}
+		ablkcipher_done_slow(walk, n);
 	}
 
-	scatterwalk_done(&walk->in, 0, nbytes);
-	scatterwalk_done(&walk->out, 1, nbytes);
+	scatterwalk_done(&walk->in, 0, more);
+	scatterwalk_done(&walk->out, 1, more);
 
-err:
-	walk->total = nbytes;
-	walk->nbytes = nbytes;
-
-	if (nbytes) {
+	if (more) {
 		crypto_yield(req->base.flags);
 		return ablkcipher_walk_next(req, walk);
 	}
-
+	err = 0;
+finish:
+	walk->nbytes = 0;
 	if (walk->iv != req->info)
 		memcpy(req->info, walk->iv, tfm->crt_ablkcipher.ivsize);
 	kfree(walk->iv_buffer);
-
 	return err;
 }
 EXPORT_SYMBOL_GPL(ablkcipher_walk_done);

