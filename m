Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0BFC43444
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 20:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971DD2171F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544906502;
	bh=10EafHhJD9kymZjXwJbYKMVVaAFCFClnMbHrnsbhPMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o/ViZgExNkkFEFX1yeMZHUQpaSt1ynH3d7TVquaFWLuqXTbTpTUpMuLpkQVbyU5m8
	 flFU6bbepI7RrPZDXMZ5Jh27vZT7qVz1c+KT5YkGGbvcJit6+fkIy36a2s4uBqjlid
	 SZQ6MK/RLtTzkZACSwfH0HpgXhmnIHeTV2P+Cbu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbeLOUll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 15:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbeLOUll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 15:41:41 -0500
Received: from sol.localdomain (c-24-23-142-8.hsd1.ca.comcast.net [24.23.142.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FA292084D;
        Sat, 15 Dec 2018 20:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544906499;
        bh=10EafHhJD9kymZjXwJbYKMVVaAFCFClnMbHrnsbhPMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZyU6+tYy3kGVcrwYdHnvXtM8XFsSb1oFBpjNSsNt6IAnL1TwF1YlE8Q5yI30nhbde
         nYpzU/tAv59gt1+fekjDZjioqT9iBMutEx/eBSe3Xd2Z11A8AqPrRVhk0CSu8I/roT
         5IB1pgtQGfhQtYEejpU4cdMyDw4nRayl53g1xzB4=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     syzkaller-bugs@googlegroups.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: x86/chacha - avoid sleeping under kernel_fpu_begin()
Date:   Sat, 15 Dec 2018 12:40:17 -0800
Message-Id: <20181215204017.7880-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <000000000000fb268d057d13ea55@google.com>
References: <000000000000fb268d057d13ea55@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Passing atomic=true to skcipher_walk_virt() only makes the later
skcipher_walk_done() calls use atomic memory allocations, not
skcipher_walk_virt() itself.  Thus, we have to move it outside of the
preemption-disabled region (kernel_fpu_begin()/kernel_fpu_end()).

(skcipher_walk_virt() only allocates memory for certain layouts of the
input scatterlist, hence why I didn't notice this earlier...)

Reported-by: syzbot+9bf843c33f782d73ae7d@syzkaller.appspotmail.com
Fixes: 4af78261870a ("crypto: x86/chacha20 - add XChaCha20 support")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/chacha_glue.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index 9b1d3fac49433..45c1c41431766 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -127,30 +127,27 @@ static void chacha_dosimd(u32 *state, u8 *dst, const u8 *src,
 	}
 }
 
-static int chacha_simd_stream_xor(struct skcipher_request *req,
+static int chacha_simd_stream_xor(struct skcipher_walk *walk,
 				  struct chacha_ctx *ctx, u8 *iv)
 {
 	u32 *state, state_buf[16 + 2] __aligned(8);
-	struct skcipher_walk walk;
 	int next_yield = 4096; /* bytes until next FPU yield */
-	int err;
+	int err = 0;
 
 	BUILD_BUG_ON(CHACHA_STATE_ALIGN != 16);
 	state = PTR_ALIGN(state_buf + 0, CHACHA_STATE_ALIGN);
 
-	err = skcipher_walk_virt(&walk, req, true);
-
 	crypto_chacha_init(state, ctx, iv);
 
-	while (walk.nbytes > 0) {
-		unsigned int nbytes = walk.nbytes;
+	while (walk->nbytes > 0) {
+		unsigned int nbytes = walk->nbytes;
 
-		if (nbytes < walk.total) {
-			nbytes = round_down(nbytes, walk.stride);
+		if (nbytes < walk->total) {
+			nbytes = round_down(nbytes, walk->stride);
 			next_yield -= nbytes;
 		}
 
-		chacha_dosimd(state, walk.dst.virt.addr, walk.src.virt.addr,
+		chacha_dosimd(state, walk->dst.virt.addr, walk->src.virt.addr,
 			      nbytes, ctx->nrounds);
 
 		if (next_yield <= 0) {
@@ -160,7 +157,7 @@ static int chacha_simd_stream_xor(struct skcipher_request *req,
 			next_yield = 4096;
 		}
 
-		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+		err = skcipher_walk_done(walk, walk->nbytes - nbytes);
 	}
 
 	return err;
@@ -170,13 +167,18 @@ static int chacha_simd(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
 	int err;
 
 	if (req->cryptlen <= CHACHA_BLOCK_SIZE || !irq_fpu_usable())
 		return crypto_chacha_crypt(req);
 
+	err = skcipher_walk_virt(&walk, req, true);
+	if (err)
+		return err;
+
 	kernel_fpu_begin();
-	err = chacha_simd_stream_xor(req, ctx, req->iv);
+	err = chacha_simd_stream_xor(&walk, ctx, req->iv);
 	kernel_fpu_end();
 	return err;
 }
@@ -185,6 +187,7 @@ static int xchacha_simd(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
 	struct chacha_ctx subctx;
 	u32 *state, state_buf[16 + 2] __aligned(8);
 	u8 real_iv[16];
@@ -193,6 +196,10 @@ static int xchacha_simd(struct skcipher_request *req)
 	if (req->cryptlen <= CHACHA_BLOCK_SIZE || !irq_fpu_usable())
 		return crypto_xchacha_crypt(req);
 
+	err = skcipher_walk_virt(&walk, req, true);
+	if (err)
+		return err;
+
 	BUILD_BUG_ON(CHACHA_STATE_ALIGN != 16);
 	state = PTR_ALIGN(state_buf + 0, CHACHA_STATE_ALIGN);
 	crypto_chacha_init(state, ctx, req->iv);
@@ -204,7 +211,7 @@ static int xchacha_simd(struct skcipher_request *req)
 
 	memcpy(&real_iv[0], req->iv + 24, 8);
 	memcpy(&real_iv[8], req->iv + 16, 8);
-	err = chacha_simd_stream_xor(req, &subctx, real_iv);
+	err = chacha_simd_stream_xor(&walk, &subctx, real_iv);
 
 	kernel_fpu_end();
 
-- 
2.19.2

