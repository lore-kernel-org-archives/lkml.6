Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1662EC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C448221A74
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXT719cC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C448221A74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbeHGAqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730888AbeHGAqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:46:11 -0400
Received: from ebiggers-linuxstation.kir.corp.google.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7CA221A60;
        Mon,  6 Aug 2018 22:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533594898;
        bh=ptypddly68/mtHqA6v40Ih3M31L4+1CcEXAXZZcxVnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXT719cCSAbwUGAv0lSoPy+Q8J5cK9Ab77ULuzcu0O24m96cXC9ROZOt4v/h8cSqo
         OiWRc35V+Zvv2utpKlL/DRs9kbgkr1us0pIu0s8Wm/CABahqUdo7HPB/hJ9OQxgfkS
         GMsWwiFIXGgSooEqhkcC3MHRTHHTXTAOuFuBiqQk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Eric Biggers <ebiggers@google.com>
Subject: [RFC PATCH 1/9] crypto: chacha20-generic - add HChaCha20 library function
Date:   Mon,  6 Aug 2018 15:32:52 -0700
Message-Id: <20180806223300.113891-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180806223300.113891-1-ebiggers@kernel.org>
References: <20180806223300.113891-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Refactor the unkeyed permutation part of chacha20_block() into its own
function, then add hchacha20_block() which is the ChaCha equivalent of
HSalsa20 and is an intermediate step towards XChaCha20 (see
https://cr.yp.to/snuffle/xsalsa-20081128.pdf).  HChaCha20 skips the
final addition of the initial state, and outputs only certain words of
the state.  It should not be used for streaming directly.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/crypto/chacha20.h |  2 ++
 lib/chacha20.c            | 52 +++++++++++++++++++++++++++++++++------
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/include/crypto/chacha20.h b/include/crypto/chacha20.h
index b83d66073db0..f00052137942 100644
--- a/include/crypto/chacha20.h
+++ b/include/crypto/chacha20.h
@@ -20,6 +20,8 @@ struct chacha20_ctx {
 };
 
 void chacha20_block(u32 *state, u32 *stream);
+void hchacha20_block(const u32 *in, u32 *out);
+
 void crypto_chacha20_init(u32 *state, struct chacha20_ctx *ctx, u8 *iv);
 int crypto_chacha20_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			   unsigned int keysize);
diff --git a/lib/chacha20.c b/lib/chacha20.c
index c1cc50fb68c9..13a0bdcb1604 100644
--- a/lib/chacha20.c
+++ b/lib/chacha20.c
@@ -1,5 +1,5 @@
 /*
- * ChaCha20 256-bit cipher algorithm, RFC7539
+ * The "hash function" used as the core of the ChaCha20 stream cipher (RFC7539)
  *
  * Copyright (C) 2015 Martin Willi
  *
@@ -16,14 +16,10 @@
 #include <asm/unaligned.h>
 #include <crypto/chacha20.h>
 
-void chacha20_block(u32 *state, u32 *stream)
+static void chacha20_permute(u32 *x)
 {
-	u32 x[16], *out = stream;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(x); i++)
-		x[i] = state[i];
-
 	for (i = 0; i < 20; i += 2) {
 		x[0]  += x[4];    x[12] = rol32(x[12] ^ x[0],  16);
 		x[1]  += x[5];    x[13] = rol32(x[13] ^ x[1],  16);
@@ -65,10 +61,52 @@ void chacha20_block(u32 *state, u32 *stream)
 		x[8]  += x[13];   x[7]  = rol32(x[7]  ^ x[8],   7);
 		x[9]  += x[14];   x[4]  = rol32(x[4]  ^ x[9],   7);
 	}
+}
+
+/**
+ * chacha20_block - generate one keystream block and increment block counter
+ * @state: input state matrix (16 32-bit words)
+ * @stream: output keystream block (64 bytes)
+ *
+ * This is the ChaCha20 core, a function from 64-byte strings to 64-byte
+ * strings.  The caller has already converted the endianness of the input.  This
+ * function also handles incrementing the block counter in the input matrix.
+ */
+void chacha20_block(u32 *state, u32 *stream)
+{
+	u32 x[16];
+	int i;
+
+	memcpy(x, state, 64);
+
+	chacha20_permute(x);
 
 	for (i = 0; i < ARRAY_SIZE(x); i++)
-		out[i] = cpu_to_le32(x[i] + state[i]);
+		stream[i] = cpu_to_le32(x[i] + state[i]);
 
 	state[12]++;
 }
 EXPORT_SYMBOL(chacha20_block);
+
+/**
+ * hchacha20_block - abbreviated ChaCha20 core, for XChaCha20
+ * @in: input state matrix (16 32-bit words)
+ * @out: output (8 32-bit words)
+ *
+ * HChaCha20 is the ChaCha equivalent of HSalsa20 and is an intermediate step
+ * towards XChaCha20 (see https://cr.yp.to/snuffle/xsalsa-20081128.pdf).
+ * HChaCha20 skips the final addition of the initial state, and outputs only
+ * certain words of the state.  It should not be used for streaming directly.
+ */
+void hchacha20_block(const u32 *in, u32 *out)
+{
+	u32 x[16];
+
+	memcpy(x, in, 64);
+
+	chacha20_permute(x);
+
+	memcpy(&out[0], &x[0], 16);
+	memcpy(&out[4], &x[12], 16);
+}
+EXPORT_SYMBOL(hchacha20_block);
-- 
2.18.0.597.ga71716f1ad-goog

