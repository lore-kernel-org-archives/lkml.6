Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6FDECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B53214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gVZZ+na1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B53214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbeISHqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:46:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33482 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730983AbeISHqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:46:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id s7-v6so1951470pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2qfRxJpua4aeq0G3/0ZgD5G+YtDBNQl7hzf7l+aYl6c=;
        b=gVZZ+na1p6a96r3OUGbK1/uYrj42+tQQOkVkh8xhyCZvD1eYL5qHs0qeGE7UThAcbp
         CFCF4BJonm9RSS3zgOkF8zPcmygPd02FOHcKLJKfCtex2s1MJf+fQsmKbL/YYiKI7xnl
         GXLC/wDwiVD+gzVv6+7vs1+5uVJjsjfZFiCgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2qfRxJpua4aeq0G3/0ZgD5G+YtDBNQl7hzf7l+aYl6c=;
        b=FPXcihiJBTFgnf0Ghz6PGPW2AK0wrdXCOOgyTNXkTSntke3n67VFK+uJ3Ds2cwXC7L
         EwTl63vsLYl92VAAG0X2kk8eC9h4MwMMKHQNXbU/nT4/STRfOCbO5SQOX7/De9plvzR8
         SCmIcT7kODnPCGPB1q1azAygpiNXzbyvuAkK4MzQ8ATcSJivGjJU20JPOOf5EVxT8057
         sv1kzMhYSoP+I8n1udpShPquZMELb8c4M+YBg6ooRXp6JyUUB/uI4hgomEzmcRjW6KSd
         Kow+Wn61EYQpo1656VU6g9Y5otFXVT3oAss0gqBlu1fB+Bp/jOGlYFbqseUKITaZYeRe
         vvpg==
X-Gm-Message-State: APzg51C5xwUgQxZq/IL4TOdjJrZWeINMGj6mYB34NVIhXpPdfJbbj7fB
        FtU0d5g3n8Z6QN7P8EzuWiLnZQ==
X-Google-Smtp-Source: ANB0Vdarif3gFOtHEDFxr0mRbO/yD/7QQmomdH8M7LfMMW4CYuU3D9ry8Ux/FyQgPQgd02EFoOev1A==
X-Received: by 2002:a62:ad9:: with SMTP id 86-v6mr33528849pfk.57.1537323079781;
        Tue, 18 Sep 2018 19:11:19 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q80-v6sm28324577pfd.15.2018.09.18.19.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:11:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 13/23] crypto: vmx - Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:50 -0700
Message-Id: <20180919021100.3380-14-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919021100.3380-1-keescook@chromium.org>
References: <20180919021100.3380-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
replaces struct crypto_skcipher and SKCIPHER_REQUEST_ON_STACK() usage
with struct crypto_sync_skcipher and SYNC_SKCIPHER_REQUEST_ON_STACK(),
which uses a fixed stack size.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>
Cc: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/vmx/aes_cbc.c | 22 +++++++++++-----------
 drivers/crypto/vmx/aes_ctr.c | 18 +++++++++---------
 drivers/crypto/vmx/aes_xts.c | 18 +++++++++---------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/crypto/vmx/aes_cbc.c b/drivers/crypto/vmx/aes_cbc.c
index b71895871be3..c5c5ff82b52e 100644
--- a/drivers/crypto/vmx/aes_cbc.c
+++ b/drivers/crypto/vmx/aes_cbc.c
@@ -32,7 +32,7 @@
 #include "aesp8-ppc.h"
 
 struct p8_aes_cbc_ctx {
-	struct crypto_skcipher *fallback;
+	struct crypto_sync_skcipher *fallback;
 	struct aes_key enc_key;
 	struct aes_key dec_key;
 };
@@ -40,11 +40,11 @@ struct p8_aes_cbc_ctx {
 static int p8_aes_cbc_init(struct crypto_tfm *tfm)
 {
 	const char *alg = crypto_tfm_alg_name(tfm);
-	struct crypto_skcipher *fallback;
+	struct crypto_sync_skcipher *fallback;
 	struct p8_aes_cbc_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	fallback = crypto_alloc_skcipher(alg, 0,
-			CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK);
+	fallback = crypto_alloc_sync_skcipher(alg, 0,
+					      CRYPTO_ALG_NEED_FALLBACK);
 
 	if (IS_ERR(fallback)) {
 		printk(KERN_ERR
@@ -53,7 +53,7 @@ static int p8_aes_cbc_init(struct crypto_tfm *tfm)
 		return PTR_ERR(fallback);
 	}
 
-	crypto_skcipher_set_flags(
+	crypto_sync_skcipher_set_flags(
 		fallback,
 		crypto_skcipher_get_flags((struct crypto_skcipher *)tfm));
 	ctx->fallback = fallback;
@@ -66,7 +66,7 @@ static void p8_aes_cbc_exit(struct crypto_tfm *tfm)
 	struct p8_aes_cbc_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	if (ctx->fallback) {
-		crypto_free_skcipher(ctx->fallback);
+		crypto_free_sync_skcipher(ctx->fallback);
 		ctx->fallback = NULL;
 	}
 }
@@ -86,7 +86,7 @@ static int p8_aes_cbc_setkey(struct crypto_tfm *tfm, const u8 *key,
 	pagefault_enable();
 	preempt_enable();
 
-	ret += crypto_skcipher_setkey(ctx->fallback, key, keylen);
+	ret += crypto_sync_skcipher_setkey(ctx->fallback, key, keylen);
 	return ret;
 }
 
@@ -100,8 +100,8 @@ static int p8_aes_cbc_encrypt(struct blkcipher_desc *desc,
 		crypto_tfm_ctx(crypto_blkcipher_tfm(desc->tfm));
 
 	if (in_interrupt()) {
-		SKCIPHER_REQUEST_ON_STACK(req, ctx->fallback);
-		skcipher_request_set_tfm(req, ctx->fallback);
+		SYNC_SKCIPHER_REQUEST_ON_STACK(req, ctx->fallback);
+		skcipher_request_set_sync_tfm(req, ctx->fallback);
 		skcipher_request_set_callback(req, desc->flags, NULL, NULL);
 		skcipher_request_set_crypt(req, src, dst, nbytes, desc->info);
 		ret = crypto_skcipher_encrypt(req);
@@ -139,8 +139,8 @@ static int p8_aes_cbc_decrypt(struct blkcipher_desc *desc,
 		crypto_tfm_ctx(crypto_blkcipher_tfm(desc->tfm));
 
 	if (in_interrupt()) {
-		SKCIPHER_REQUEST_ON_STACK(req, ctx->fallback);
-		skcipher_request_set_tfm(req, ctx->fallback);
+		SYNC_SKCIPHER_REQUEST_ON_STACK(req, ctx->fallback);
+		skcipher_request_set_sync_tfm(req, ctx->fallback);
 		skcipher_request_set_callback(req, desc->flags, NULL, NULL);
 		skcipher_request_set_crypt(req, src, dst, nbytes, desc->info);
 		ret = crypto_skcipher_decrypt(req);
diff --git a/drivers/crypto/vmx/aes_ctr.c b/drivers/crypto/vmx/aes_ctr.c
index cd777c75291d..8a2fe092cb8e 100644
--- a/drivers/crypto/vmx/aes_ctr.c
+++ b/drivers/crypto/vmx/aes_ctr.c
@@ -32,18 +32,18 @@
 #include "aesp8-ppc.h"
 
 struct p8_aes_ctr_ctx {
-	struct crypto_skcipher *fallback;
+	struct crypto_sync_skcipher *fallback;
 	struct aes_key enc_key;
 };
 
 static int p8_aes_ctr_init(struct crypto_tfm *tfm)
 {
 	const char *alg = crypto_tfm_alg_name(tfm);
-	struct crypto_skcipher *fallback;
+	struct crypto_sync_skcipher *fallback;
 	struct p8_aes_ctr_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	fallback = crypto_alloc_skcipher(alg, 0,
-			CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK);
+	fallback = crypto_alloc_sync_skcipher(alg, 0,
+					      CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(fallback)) {
 		printk(KERN_ERR
 		       "Failed to allocate transformation for '%s': %ld\n",
@@ -51,7 +51,7 @@ static int p8_aes_ctr_init(struct crypto_tfm *tfm)
 		return PTR_ERR(fallback);
 	}
 
-	crypto_skcipher_set_flags(
+	crypto_sync_skcipher_set_flags(
 		fallback,
 		crypto_skcipher_get_flags((struct crypto_skcipher *)tfm));
 	ctx->fallback = fallback;
@@ -64,7 +64,7 @@ static void p8_aes_ctr_exit(struct crypto_tfm *tfm)
 	struct p8_aes_ctr_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	if (ctx->fallback) {
-		crypto_free_skcipher(ctx->fallback);
+		crypto_free_sync_skcipher(ctx->fallback);
 		ctx->fallback = NULL;
 	}
 }
@@ -83,7 +83,7 @@ static int p8_aes_ctr_setkey(struct crypto_tfm *tfm, const u8 *key,
 	pagefault_enable();
 	preempt_enable();
 
-	ret += crypto_skcipher_setkey(ctx->fallback, key, keylen);
+	ret += crypto_sync_skcipher_setkey(ctx->fallback, key, keylen);
 	return ret;
 }
 
@@ -119,8 +119,8 @@ static int p8_aes_ctr_crypt(struct blkcipher_desc *desc,
 		crypto_tfm_ctx(crypto_blkcipher_tfm(desc->tfm));
 
 	if (in_interrupt()) {
-		SKCIPHER_REQUEST_ON_STACK(req, ctx->fallback);
-		skcipher_request_set_tfm(req, ctx->fallback);
+		SYNC_SKCIPHER_REQUEST_ON_STACK(req, ctx->fallback);
+		skcipher_request_set_sync_tfm(req, ctx->fallback);
 		skcipher_request_set_callback(req, desc->flags, NULL, NULL);
 		skcipher_request_set_crypt(req, src, dst, nbytes, desc->info);
 		ret = crypto_skcipher_encrypt(req);
diff --git a/drivers/crypto/vmx/aes_xts.c b/drivers/crypto/vmx/aes_xts.c
index e9954a7d4694..ecd64e5cc5bb 100644
--- a/drivers/crypto/vmx/aes_xts.c
+++ b/drivers/crypto/vmx/aes_xts.c
@@ -33,7 +33,7 @@
 #include "aesp8-ppc.h"
 
 struct p8_aes_xts_ctx {
-	struct crypto_skcipher *fallback;
+	struct crypto_sync_skcipher *fallback;
 	struct aes_key enc_key;
 	struct aes_key dec_key;
 	struct aes_key tweak_key;
@@ -42,11 +42,11 @@ struct p8_aes_xts_ctx {
 static int p8_aes_xts_init(struct crypto_tfm *tfm)
 {
 	const char *alg = crypto_tfm_alg_name(tfm);
-	struct crypto_skcipher *fallback;
+	struct crypto_sync_skcipher *fallback;
 	struct p8_aes_xts_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	fallback = crypto_alloc_skcipher(alg, 0,
-			CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK);
+	fallback = crypto_alloc_sync_skcipher(alg, 0,
+					      CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(fallback)) {
 		printk(KERN_ERR
 			"Failed to allocate transformation for '%s': %ld\n",
@@ -54,7 +54,7 @@ static int p8_aes_xts_init(struct crypto_tfm *tfm)
 		return PTR_ERR(fallback);
 	}
 
-	crypto_skcipher_set_flags(
+	crypto_sync_skcipher_set_flags(
 		fallback,
 		crypto_skcipher_get_flags((struct crypto_skcipher *)tfm));
 	ctx->fallback = fallback;
@@ -67,7 +67,7 @@ static void p8_aes_xts_exit(struct crypto_tfm *tfm)
 	struct p8_aes_xts_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	if (ctx->fallback) {
-		crypto_free_skcipher(ctx->fallback);
+		crypto_free_sync_skcipher(ctx->fallback);
 		ctx->fallback = NULL;
 	}
 }
@@ -92,7 +92,7 @@ static int p8_aes_xts_setkey(struct crypto_tfm *tfm, const u8 *key,
 	pagefault_enable();
 	preempt_enable();
 
-	ret += crypto_skcipher_setkey(ctx->fallback, key, keylen);
+	ret += crypto_sync_skcipher_setkey(ctx->fallback, key, keylen);
 	return ret;
 }
 
@@ -109,8 +109,8 @@ static int p8_aes_xts_crypt(struct blkcipher_desc *desc,
 		crypto_tfm_ctx(crypto_blkcipher_tfm(desc->tfm));
 
 	if (in_interrupt()) {
-		SKCIPHER_REQUEST_ON_STACK(req, ctx->fallback);
-		skcipher_request_set_tfm(req, ctx->fallback);
+		SYNC_SKCIPHER_REQUEST_ON_STACK(req, ctx->fallback);
+		skcipher_request_set_sync_tfm(req, ctx->fallback);
 		skcipher_request_set_callback(req, desc->flags, NULL, NULL);
 		skcipher_request_set_crypt(req, src, dst, nbytes, desc->info);
 		ret = enc? crypto_skcipher_encrypt(req) : crypto_skcipher_decrypt(req);
-- 
2.17.1

