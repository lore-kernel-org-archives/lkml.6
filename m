Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA94C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0915920661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0915920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeLIVzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:55:38 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34918 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726453AbeLIVzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:16 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0002io-Ec; Sun, 09 Dec 2018 21:55:12 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0003L8-RO; Sun, 09 Dec 2018 21:55:09 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Eric Biggers" <ebiggers@google.com>,
        "Liu Chao" <liuchao741@huawei.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.523442771@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 099/328] crypto: blkcipher - fix crash flushing
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

commit 0868def3e4100591e7a1fdbf3eed1439cc8f7ca3 upstream.

Like the skcipher_walk case:

scatterwalk_done() is only meant to be called after a nonzero number of
bytes have been processed, since scatterwalk_pagedone() will flush the
dcache of the *previous* page.  But in the error case of
blkcipher_walk_done(), e.g. if the input wasn't an integer number of
blocks, scatterwalk_done() was actually called after advancing 0 bytes.
This caused a crash ("BUG: unable to handle kernel paging request")
during '!PageSlab(page)' on architectures like arm and arm64 that define
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE, provided that the input was
page-aligned as in that case walk->offset == 0.

Fix it by reorganizing blkcipher_walk_done() to skip the
scatterwalk_advance() and scatterwalk_done() if an error has occurred.

This bug was found by syzkaller fuzzing.

Reproducer, assuming ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE:

	#include <linux/if_alg.h>
	#include <sys/socket.h>
	#include <unistd.h>

	int main()
	{
		struct sockaddr_alg addr = {
			.salg_type = "skcipher",
			.salg_name = "ecb(aes-generic)",
		};
		char buffer[4096] __attribute__((aligned(4096))) = { 0 };
		int fd;

		fd = socket(AF_ALG, SOCK_SEQPACKET, 0);
		bind(fd, (void *)&addr, sizeof(addr));
		setsockopt(fd, SOL_ALG, ALG_SET_KEY, buffer, 16);
		fd = accept(fd, NULL, NULL);
		write(fd, buffer, 15);
		read(fd, buffer, 15);
	}

Reported-by: Liu Chao <liuchao741@huawei.com>
Fixes: 5cde0af2a982 ("[CRYPTO] cipher: Added block cipher type")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 crypto/blkcipher.c | 54 ++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

--- a/crypto/blkcipher.c
+++ b/crypto/blkcipher.c
@@ -70,19 +70,18 @@ static inline u8 *blkcipher_get_spot(u8
 	return max(start, end_page);
 }
 
-static inline unsigned int blkcipher_done_slow(struct blkcipher_walk *walk,
-					       unsigned int bsize)
+static inline void blkcipher_done_slow(struct blkcipher_walk *walk,
+				       unsigned int bsize)
 {
 	u8 *addr;
 
 	addr = (u8 *)ALIGN((unsigned long)walk->buffer, walk->alignmask + 1);
 	addr = blkcipher_get_spot(addr, bsize);
 	scatterwalk_copychunks(addr, &walk->out, bsize, 1);
-	return bsize;
 }
 
-static inline unsigned int blkcipher_done_fast(struct blkcipher_walk *walk,
-					       unsigned int n)
+static inline void blkcipher_done_fast(struct blkcipher_walk *walk,
+				       unsigned int n)
 {
 	if (walk->flags & BLKCIPHER_WALK_COPY) {
 		blkcipher_map_dst(walk);
@@ -96,49 +95,48 @@ static inline unsigned int blkcipher_don
 
 	scatterwalk_advance(&walk->in, n);
 	scatterwalk_advance(&walk->out, n);
-
-	return n;
 }
 
 int blkcipher_walk_done(struct blkcipher_desc *desc,
 			struct blkcipher_walk *walk, int err)
 {
-	unsigned int nbytes = 0;
+	unsigned int n; /* bytes processed */
+	bool more;
 
-	if (likely(err >= 0)) {
-		unsigned int n = walk->nbytes - err;
+	if (unlikely(err < 0))
+		goto finish;
 
-		if (likely(!(walk->flags & BLKCIPHER_WALK_SLOW)))
-			n = blkcipher_done_fast(walk, n);
-		else if (WARN_ON(err)) {
+	n = walk->nbytes - err;
+	walk->total -= n;
+	more = (walk->total != 0);
+
+	if (likely(!(walk->flags & BLKCIPHER_WALK_SLOW))) {
+		blkcipher_done_fast(walk, n);
+	} else {
+		if (WARN_ON(err)) {
+			/* unexpected case; didn't process all bytes */
 			err = -EINVAL;
-			goto err;
-		} else
-			n = blkcipher_done_slow(walk, n);
-
-		nbytes = walk->total - n;
-		err = 0;
+			goto finish;
+		}
+		blkcipher_done_slow(walk, n);
 	}
 
-	scatterwalk_done(&walk->in, 0, nbytes);
-	scatterwalk_done(&walk->out, 1, nbytes);
-
-err:
-	walk->total = nbytes;
-	walk->nbytes = nbytes;
+	scatterwalk_done(&walk->in, 0, more);
+	scatterwalk_done(&walk->out, 1, more);
 
-	if (nbytes) {
+	if (more) {
 		crypto_yield(desc->flags);
 		return blkcipher_walk_next(desc, walk);
 	}
-
+	err = 0;
+finish:
+	walk->nbytes = 0;
 	if (walk->iv != desc->info)
 		memcpy(desc->info, walk->iv, walk->ivsize);
 	if (walk->buffer != walk->page)
 		kfree(walk->buffer);
 	if (walk->page)
 		free_page((unsigned long)walk->page);
-
 	return err;
 }
 EXPORT_SYMBOL_GPL(blkcipher_walk_done);

