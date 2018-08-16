Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAB9C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C062147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C062147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeHPVm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:42:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56048 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbeHPVmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:42:25 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6B6DFCB7;
        Thu, 16 Aug 2018 18:42:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Chao <liuchao741@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 3.18 13/15] crypto: blkcipher - fix crash flushing dcache in error path
Date:   Thu, 16 Aug 2018 20:41:50 +0200
Message-Id: <20180816171634.055296313@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171633.546734046@linuxfoundation.org>
References: <20180816171633.546734046@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org> # v2.6.19+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/blkcipher.c |   54 +++++++++++++++++++++++++----------------------------
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


