Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CA1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FC321473
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvvXfKdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FC321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeKZVrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:47:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbeKZVrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:47:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CCA120817;
        Mon, 26 Nov 2018 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229642;
        bh=Nhlnr/c70XOxce2XYko0q1SWawRoIrL/Imyn5HUmqHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvvXfKdtoFPwUq1STbuKVRchiPWN/ZmY1Syu48YGkKV7Qpd5W7KH8paLlSVStRS/U
         sjpmTQeDxsP8o1IrA20TZJJqv2MTbo9XKUgJh5nhdbWriq8WZQgwzbPxshvsC4l4aC
         rb+0xpI4gmAaBJU+NH73Fvc9yrmZWFj0ymowmQwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 17/70] crypto: arm64/sha - avoid non-standard inline asm tricks
Date:   Mon, 26 Nov 2018 11:50:32 +0100
Message-Id: <20181126105048.515352194@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit f4857f4c2ee9aa4e2aacac1a845352b00197fb57 upstream.

Replace the inline asm which exports struct offsets as ELF symbols
with proper const variables exposing the same values. This works
around an issue with Clang which does not interpret the "i" (or "I")
constraints in the same way as GCC.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/crypto/sha1-ce-core.S |    6 ++++--
 arch/arm64/crypto/sha1-ce-glue.c |   11 +++--------
 arch/arm64/crypto/sha2-ce-core.S |    6 ++++--
 arch/arm64/crypto/sha2-ce-glue.c |   13 +++++--------
 4 files changed, 16 insertions(+), 20 deletions(-)

--- a/arch/arm64/crypto/sha1-ce-core.S
+++ b/arch/arm64/crypto/sha1-ce-core.S
@@ -82,7 +82,8 @@ ENTRY(sha1_ce_transform)
 	ldr		dgb, [x0, #16]
 
 	/* load sha1_ce_state::finalize */
-	ldr		w4, [x0, #:lo12:sha1_ce_offsetof_finalize]
+	ldr_l		w4, sha1_ce_offsetof_finalize, x4
+	ldr		w4, [x0, x4]
 
 	/* load input */
 0:	ld1		{v8.4s-v11.4s}, [x1], #64
@@ -132,7 +133,8 @@ CPU_LE(	rev32		v11.16b, v11.16b	)
 	 * the padding is handled by the C code in that case.
 	 */
 	cbz		x4, 3f
-	ldr		x4, [x0, #:lo12:sha1_ce_offsetof_count]
+	ldr_l		w4, sha1_ce_offsetof_count, x4
+	ldr		x4, [x0, x4]
 	movi		v9.2d, #0
 	mov		x8, #0x80000000
 	movi		v10.2d, #0
--- a/arch/arm64/crypto/sha1-ce-glue.c
+++ b/arch/arm64/crypto/sha1-ce-glue.c
@@ -17,9 +17,6 @@
 #include <linux/crypto.h>
 #include <linux/module.h>
 
-#define ASM_EXPORT(sym, val) \
-	asm(".globl " #sym "; .set " #sym ", %0" :: "I"(val));
-
 MODULE_DESCRIPTION("SHA1 secure hash using ARMv8 Crypto Extensions");
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
 MODULE_LICENSE("GPL v2");
@@ -32,6 +29,9 @@ struct sha1_ce_state {
 asmlinkage void sha1_ce_transform(struct sha1_ce_state *sst, u8 const *src,
 				  int blocks);
 
+const u32 sha1_ce_offsetof_count = offsetof(struct sha1_ce_state, sst.count);
+const u32 sha1_ce_offsetof_finalize = offsetof(struct sha1_ce_state, finalize);
+
 static int sha1_ce_update(struct shash_desc *desc, const u8 *data,
 			  unsigned int len)
 {
@@ -52,11 +52,6 @@ static int sha1_ce_finup(struct shash_de
 	struct sha1_ce_state *sctx = shash_desc_ctx(desc);
 	bool finalize = !sctx->sst.count && !(len % SHA1_BLOCK_SIZE);
 
-	ASM_EXPORT(sha1_ce_offsetof_count,
-		   offsetof(struct sha1_ce_state, sst.count));
-	ASM_EXPORT(sha1_ce_offsetof_finalize,
-		   offsetof(struct sha1_ce_state, finalize));
-
 	/*
 	 * Allow the asm code to perform the finalization if there is no
 	 * partial data and the input is a round multiple of the block size.
--- a/arch/arm64/crypto/sha2-ce-core.S
+++ b/arch/arm64/crypto/sha2-ce-core.S
@@ -88,7 +88,8 @@ ENTRY(sha2_ce_transform)
 	ld1		{dgav.4s, dgbv.4s}, [x0]
 
 	/* load sha256_ce_state::finalize */
-	ldr		w4, [x0, #:lo12:sha256_ce_offsetof_finalize]
+	ldr_l		w4, sha256_ce_offsetof_finalize, x4
+	ldr		w4, [x0, x4]
 
 	/* load input */
 0:	ld1		{v16.4s-v19.4s}, [x1], #64
@@ -136,7 +137,8 @@ CPU_LE(	rev32		v19.16b, v19.16b	)
 	 * the padding is handled by the C code in that case.
 	 */
 	cbz		x4, 3f
-	ldr		x4, [x0, #:lo12:sha256_ce_offsetof_count]
+	ldr_l		w4, sha256_ce_offsetof_count, x4
+	ldr		x4, [x0, x4]
 	movi		v17.2d, #0
 	mov		x8, #0x80000000
 	movi		v18.2d, #0
--- a/arch/arm64/crypto/sha2-ce-glue.c
+++ b/arch/arm64/crypto/sha2-ce-glue.c
@@ -17,9 +17,6 @@
 #include <linux/crypto.h>
 #include <linux/module.h>
 
-#define ASM_EXPORT(sym, val) \
-	asm(".globl " #sym "; .set " #sym ", %0" :: "I"(val));
-
 MODULE_DESCRIPTION("SHA-224/SHA-256 secure hash using ARMv8 Crypto Extensions");
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
 MODULE_LICENSE("GPL v2");
@@ -32,6 +29,11 @@ struct sha256_ce_state {
 asmlinkage void sha2_ce_transform(struct sha256_ce_state *sst, u8 const *src,
 				  int blocks);
 
+const u32 sha256_ce_offsetof_count = offsetof(struct sha256_ce_state,
+					      sst.count);
+const u32 sha256_ce_offsetof_finalize = offsetof(struct sha256_ce_state,
+						 finalize);
+
 static int sha256_ce_update(struct shash_desc *desc, const u8 *data,
 			    unsigned int len)
 {
@@ -52,11 +54,6 @@ static int sha256_ce_finup(struct shash_
 	struct sha256_ce_state *sctx = shash_desc_ctx(desc);
 	bool finalize = !sctx->sst.count && !(len % SHA256_BLOCK_SIZE);
 
-	ASM_EXPORT(sha256_ce_offsetof_count,
-		   offsetof(struct sha256_ce_state, sst.count));
-	ASM_EXPORT(sha256_ce_offsetof_finalize,
-		   offsetof(struct sha256_ce_state, finalize));
-
 	/*
 	 * Allow the asm code to perform the finalization if there is no
 	 * partial data and the input is a round multiple of the block size.


