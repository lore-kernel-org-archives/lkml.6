Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3F9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C70221473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C70221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbeHPVoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:44:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729414AbeHPVoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:44:22 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9F480CC4;
        Thu, 16 Aug 2018 18:44:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Chao <liuchao741@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 11/15] crypto: ablkcipher - fix crash flushing dcache in error path
Date:   Thu, 16 Aug 2018 20:42:04 +0200
Message-Id: <20180816171627.110494176@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171625.340082081@linuxfoundation.org>
References: <20180816171625.340082081@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org> # v2.6.35+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/ablkcipher.c |   57 +++++++++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

--- a/crypto/ablkcipher.c
+++ b/crypto/ablkcipher.c
@@ -70,11 +70,9 @@ static inline u8 *ablkcipher_get_spot(u8
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
 
@@ -86,17 +84,13 @@ static inline unsigned int ablkcipher_do
 		n -= len_this_page;
 		scatterwalk_start(&walk->out, sg_next(walk->out.sg));
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
@@ -106,39 +100,40 @@ int ablkcipher_walk_done(struct ablkciph
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


