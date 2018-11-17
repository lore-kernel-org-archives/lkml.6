Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8B1C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956792087C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj7HBhSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956792087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbeKQLnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 06:43:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729923AbeKQLne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 06:43:34 -0500
Received: from ebiggers.mtv.corp.google.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05259208E7;
        Sat, 17 Nov 2018 01:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542418129;
        bh=kNfS9XLdM2Clq+vNN6vXsRdWclvH1EDclyX9AJgO6sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nj7HBhShz5H5LLp7RIdiOE9Q1JIxJPLH7SLMCD9Yq3z6g65BbO1z6rJ7WJhkg4Vnd
         swMzSac7ZkK62cA/K+Hz09n2EQdUtQKcis7th5kkrvUmTHJ8RD7B+blj9BWa9a4NTT
         OLU67SfwE4v5YhKO1MDKd8M2IRtdeafCQe+QDEwU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Martin Willi <martin@strongswan.org>
Subject: [PATCH v4 01/14] crypto: chacha20-generic - add HChaCha20 library function
Date:   Fri, 16 Nov 2018 17:26:18 -0800
Message-Id: <20181117012631.23528-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181117012631.23528-1-ebiggers@kernel.org>
References: <20181117012631.23528-1-ebiggers@kernel.org>
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

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Martin Willi <martin@strongswan.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/crypto/chacha20.h |  2 ++
 lib/chacha20.c            | 50 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/include/crypto/chacha20.h b/include/crypto/chacha20.h
index 2d3129442a52..56073814eef0 100644
--- a/include/crypto/chacha20.h
+++ b/include/crypto/chacha20.h
@@ -20,6 +20,8 @@ struct chacha20_ctx {
 };
 
 void chacha20_block(u32 *state, u8 *stream);
+void hchacha20_block(const u32 *in, u32 *out);
+
 void crypto_chacha20_init(u32 *state, struct chacha20_ctx *ctx, u8 *iv);
 int crypto_chacha20_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			   unsigned int keysize);
diff --git a/lib/chacha20.c b/lib/chacha20.c
index d907fec6a9ed..6a484e16171d 100644
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
 
-void chacha20_block(u32 *state, u8 *stream)
+static void chacha20_permute(u32 *x)
 {
-	u32 x[16];
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(x); i++)
-		x[i] = state[i];
-
 	for (i = 0; i < 20; i += 2) {
 		x[0]  += x[4];    x[12] = rol32(x[12] ^ x[0],  16);
 		x[1]  += x[5];    x[13] = rol32(x[13] ^ x[1],  16);
@@ -65,6 +61,25 @@ void chacha20_block(u32 *state, u8 *stream)
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
+void chacha20_block(u32 *state, u8 *stream)
+{
+	u32 x[16];
+	int i;
+
+	memcpy(x, state, 64);
+
+	chacha20_permute(x);
 
 	for (i = 0; i < ARRAY_SIZE(x); i++)
 		put_unaligned_le32(x[i] + state[i], &stream[i * sizeof(u32)]);
@@ -72,3 +87,26 @@ void chacha20_block(u32 *state, u8 *stream)
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
2.19.1.1215.g8438c0b245-goog

