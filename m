Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD3FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8925C21479
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8925C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeHPVsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:48:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57534 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbeHPVsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:48:37 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CE4E5CC4;
        Thu, 16 Aug 2018 18:48:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Chao <liuchao741@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.18 19/22] crypto: skcipher - fix crash flushing dcache in error path
Date:   Thu, 16 Aug 2018 20:45:35 +0200
Message-Id: <20180816171557.276575659@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171556.502583508@linuxfoundation.org>
References: <20180816171556.502583508@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 8088d3dd4d7c6933a65aa169393b5d88d8065672 upstream.

scatterwalk_done() is only meant to be called after a nonzero number of
bytes have been processed, since scatterwalk_pagedone() will flush the
dcache of the *previous* page.  But in the error case of
skcipher_walk_done(), e.g. if the input wasn't an integer number of
blocks, scatterwalk_done() was actually called after advancing 0 bytes.
This caused a crash ("BUG: unable to handle kernel paging request")
during '!PageSlab(page)' on architectures like arm and arm64 that define
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE, provided that the input was
page-aligned as in that case walk->offset == 0.

Fix it by reorganizing skcipher_walk_done() to skip the
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
			.salg_name = "cbc(aes-generic)",
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
Fixes: b286d8b1a690 ("crypto: skcipher - Add skcipher walk interface")
Cc: <stable@vger.kernel.org> # v4.10+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/skcipher.c |   49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

--- a/crypto/skcipher.c
+++ b/crypto/skcipher.c
@@ -95,7 +95,7 @@ static inline u8 *skcipher_get_spot(u8 *
 	return max(start, end_page);
 }
 
-static int skcipher_done_slow(struct skcipher_walk *walk, unsigned int bsize)
+static void skcipher_done_slow(struct skcipher_walk *walk, unsigned int bsize)
 {
 	u8 *addr;
 
@@ -103,23 +103,24 @@ static int skcipher_done_slow(struct skc
 	addr = skcipher_get_spot(addr, bsize);
 	scatterwalk_copychunks(addr, &walk->out, bsize,
 			       (walk->flags & SKCIPHER_WALK_PHYS) ? 2 : 1);
-	return 0;
 }
 
 int skcipher_walk_done(struct skcipher_walk *walk, int err)
 {
-	unsigned int n = walk->nbytes - err;
-	unsigned int nbytes;
+	unsigned int n; /* bytes processed */
+	bool more;
 
-	nbytes = walk->total - n;
+	if (unlikely(err < 0))
+		goto finish;
 
-	if (unlikely(err < 0)) {
-		nbytes = 0;
-		n = 0;
-	} else if (likely(!(walk->flags & (SKCIPHER_WALK_PHYS |
-					   SKCIPHER_WALK_SLOW |
-					   SKCIPHER_WALK_COPY |
-					   SKCIPHER_WALK_DIFF)))) {
+	n = walk->nbytes - err;
+	walk->total -= n;
+	more = (walk->total != 0);
+
+	if (likely(!(walk->flags & (SKCIPHER_WALK_PHYS |
+				    SKCIPHER_WALK_SLOW |
+				    SKCIPHER_WALK_COPY |
+				    SKCIPHER_WALK_DIFF)))) {
 unmap_src:
 		skcipher_unmap_src(walk);
 	} else if (walk->flags & SKCIPHER_WALK_DIFF) {
@@ -131,28 +132,28 @@ unmap_src:
 		skcipher_unmap_dst(walk);
 	} else if (unlikely(walk->flags & SKCIPHER_WALK_SLOW)) {
 		if (WARN_ON(err)) {
+			/* unexpected case; didn't process all bytes */
 			err = -EINVAL;
-			nbytes = 0;
-		} else
-			n = skcipher_done_slow(walk, n);
+			goto finish;
+		}
+		skcipher_done_slow(walk, n);
+		goto already_advanced;
 	}
 
-	if (err > 0)
-		err = 0;
-
-	walk->total = nbytes;
-	walk->nbytes = nbytes;
-
 	scatterwalk_advance(&walk->in, n);
 	scatterwalk_advance(&walk->out, n);
-	scatterwalk_done(&walk->in, 0, nbytes);
-	scatterwalk_done(&walk->out, 1, nbytes);
+already_advanced:
+	scatterwalk_done(&walk->in, 0, more);
+	scatterwalk_done(&walk->out, 1, more);
 
-	if (nbytes) {
+	if (more) {
 		crypto_yield(walk->flags & SKCIPHER_WALK_SLEEP ?
 			     CRYPTO_TFM_REQ_MAY_SLEEP : 0);
 		return skcipher_walk_next(walk);
 	}
+	err = 0;
+finish:
+	walk->nbytes = 0;
 
 	/* Short-circuit for the common/fast path. */
 	if (!((unsigned long)walk->buffer | (unsigned long)walk->page))


