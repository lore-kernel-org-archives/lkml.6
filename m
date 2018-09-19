Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE009ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F61F214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N8M0ZGQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F61F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbeISHqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:46:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45412 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730905AbeISHql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:46:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so1897378pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AEAcoMGIsRFw3HkHQ8e0m7OE5b3TEmxIotDoO7+No/8=;
        b=N8M0ZGQT3rCZpc1OoPovmvArnrFwprTe9JNn6ycx5Cw8pVb3cFHqq4p4E+HyrgQEbh
         S7pnMd9Kj8/2Hh0+fj0KVndCOL2DVg/B720g+z6jkcqWlXCov3vJ4IWRMP0SDODuls70
         b5eNOmvWHisjFQsxvXuzwQTuu4RY9M1MeZNec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AEAcoMGIsRFw3HkHQ8e0m7OE5b3TEmxIotDoO7+No/8=;
        b=QbWv1bE9ZZHKmQULcUkMpZFVmnhnAPj/T5zva0ipoo/UEJPBZRWx8gL5QN97w/MYsZ
         BkFWZJSOTKyrTideGIyTeoLZf+UT1MvfJSeJeg0bdrmmNWc0CsrnFdLhc8wGMZmMtKRP
         sPV8ZDtOhwl8im4mAI8jUctFWc+su58KHZQ8QbfPspxSGGdcHiBKEKEMC1leqdrm7KcP
         o41ExLkrGZLbvsOlClF/Eg/RC7/nqEwhYekwleCLoPV6T/FVSdDhlKb+Ow85QkT29nal
         ovwst1YFLr0QZFwZdBY7Jtg/qQCEDSEETGKfi+yPFTvlCHhyf7/HYE/VSx3EI6vrgkvH
         p2Pg==
X-Gm-Message-State: APzg51DyGBDu6lf5fuz5W4UB1ZtB4+r7zgfVbslM/MwZitwrS6XQ80k0
        qKThYMc4T/jnsHHBph8UHrKFlw==
X-Google-Smtp-Source: ANB0VdYA+0hYiNYMdb41d/qf3UBxV53/m+6dISiJ/SN9OXRzpB5arDd1EyJoaGQKVd9ySrRHp9PaUA==
X-Received: by 2002:a62:4bc6:: with SMTP id d67-v6mr33557881pfj.175.1537323073476;
        Tue, 18 Sep 2018 19:11:13 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z11-v6sm26301540pff.162.2018.09.18.19.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:11:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 05/23] s390/crypto: Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:42 -0700
Message-Id: <20180919021100.3380-6-keescook@chromium.org>
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

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/crypto/aes_s390.c | 48 ++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index c54cb26eb7f5..812d9498d97b 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -44,7 +44,7 @@ struct s390_aes_ctx {
 	int key_len;
 	unsigned long fc;
 	union {
-		struct crypto_skcipher *blk;
+		struct crypto_sync_skcipher *blk;
 		struct crypto_cipher *cip;
 	} fallback;
 };
@@ -54,7 +54,7 @@ struct s390_xts_ctx {
 	u8 pcc_key[32];
 	int key_len;
 	unsigned long fc;
-	struct crypto_skcipher *fallback;
+	struct crypto_sync_skcipher *fallback;
 };
 
 struct gcm_sg_walk {
@@ -184,14 +184,15 @@ static int setkey_fallback_blk(struct crypto_tfm *tfm, const u8 *key,
 	struct s390_aes_ctx *sctx = crypto_tfm_ctx(tfm);
 	unsigned int ret;
 
-	crypto_skcipher_clear_flags(sctx->fallback.blk, CRYPTO_TFM_REQ_MASK);
-	crypto_skcipher_set_flags(sctx->fallback.blk, tfm->crt_flags &
+	crypto_sync_skcipher_clear_flags(sctx->fallback.blk,
+					 CRYPTO_TFM_REQ_MASK);
+	crypto_sync_skcipher_set_flags(sctx->fallback.blk, tfm->crt_flags &
 						      CRYPTO_TFM_REQ_MASK);
 
-	ret = crypto_skcipher_setkey(sctx->fallback.blk, key, len);
+	ret = crypto_sync_skcipher_setkey(sctx->fallback.blk, key, len);
 
 	tfm->crt_flags &= ~CRYPTO_TFM_RES_MASK;
-	tfm->crt_flags |= crypto_skcipher_get_flags(sctx->fallback.blk) &
+	tfm->crt_flags |= crypto_sync_skcipher_get_flags(sctx->fallback.blk) &
 			  CRYPTO_TFM_RES_MASK;
 
 	return ret;
@@ -204,9 +205,9 @@ static int fallback_blk_dec(struct blkcipher_desc *desc,
 	unsigned int ret;
 	struct crypto_blkcipher *tfm = desc->tfm;
 	struct s390_aes_ctx *sctx = crypto_blkcipher_ctx(tfm);
-	SKCIPHER_REQUEST_ON_STACK(req, sctx->fallback.blk);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, sctx->fallback.blk);
 
-	skcipher_request_set_tfm(req, sctx->fallback.blk);
+	skcipher_request_set_sync_tfm(req, sctx->fallback.blk);
 	skcipher_request_set_callback(req, desc->flags, NULL, NULL);
 	skcipher_request_set_crypt(req, src, dst, nbytes, desc->info);
 
@@ -223,9 +224,9 @@ static int fallback_blk_enc(struct blkcipher_desc *desc,
 	unsigned int ret;
 	struct crypto_blkcipher *tfm = desc->tfm;
 	struct s390_aes_ctx *sctx = crypto_blkcipher_ctx(tfm);
-	SKCIPHER_REQUEST_ON_STACK(req, sctx->fallback.blk);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, sctx->fallback.blk);
 
-	skcipher_request_set_tfm(req, sctx->fallback.blk);
+	skcipher_request_set_sync_tfm(req, sctx->fallback.blk);
 	skcipher_request_set_callback(req, desc->flags, NULL, NULL);
 	skcipher_request_set_crypt(req, src, dst, nbytes, desc->info);
 
@@ -306,8 +307,7 @@ static int fallback_init_blk(struct crypto_tfm *tfm)
 	const char *name = tfm->__crt_alg->cra_name;
 	struct s390_aes_ctx *sctx = crypto_tfm_ctx(tfm);
 
-	sctx->fallback.blk = crypto_alloc_skcipher(name, 0,
-						   CRYPTO_ALG_ASYNC |
+	sctx->fallback.blk = crypto_alloc_sync_skcipher(name, 0,
 						   CRYPTO_ALG_NEED_FALLBACK);
 
 	if (IS_ERR(sctx->fallback.blk)) {
@@ -323,7 +323,7 @@ static void fallback_exit_blk(struct crypto_tfm *tfm)
 {
 	struct s390_aes_ctx *sctx = crypto_tfm_ctx(tfm);
 
-	crypto_free_skcipher(sctx->fallback.blk);
+	crypto_free_sync_skcipher(sctx->fallback.blk);
 }
 
 static struct crypto_alg ecb_aes_alg = {
@@ -453,14 +453,15 @@ static int xts_fallback_setkey(struct crypto_tfm *tfm, const u8 *key,
 	struct s390_xts_ctx *xts_ctx = crypto_tfm_ctx(tfm);
 	unsigned int ret;
 
-	crypto_skcipher_clear_flags(xts_ctx->fallback, CRYPTO_TFM_REQ_MASK);
-	crypto_skcipher_set_flags(xts_ctx->fallback, tfm->crt_flags &
+	crypto_sync_skcipher_clear_flags(xts_ctx->fallback,
+					 CRYPTO_TFM_REQ_MASK);
+	crypto_sync_skcipher_set_flags(xts_ctx->fallback, tfm->crt_flags &
 						     CRYPTO_TFM_REQ_MASK);
 
-	ret = crypto_skcipher_setkey(xts_ctx->fallback, key, len);
+	ret = crypto_sync_skcipher_setkey(xts_ctx->fallback, key, len);
 
 	tfm->crt_flags &= ~CRYPTO_TFM_RES_MASK;
-	tfm->crt_flags |= crypto_skcipher_get_flags(xts_ctx->fallback) &
+	tfm->crt_flags |= crypto_sync_skcipher_get_flags(xts_ctx->fallback) &
 			  CRYPTO_TFM_RES_MASK;
 
 	return ret;
@@ -472,10 +473,10 @@ static int xts_fallback_decrypt(struct blkcipher_desc *desc,
 {
 	struct crypto_blkcipher *tfm = desc->tfm;
 	struct s390_xts_ctx *xts_ctx = crypto_blkcipher_ctx(tfm);
-	SKCIPHER_REQUEST_ON_STACK(req, xts_ctx->fallback);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, xts_ctx->fallback);
 	unsigned int ret;
 
-	skcipher_request_set_tfm(req, xts_ctx->fallback);
+	skcipher_request_set_sync_tfm(req, xts_ctx->fallback);
 	skcipher_request_set_callback(req, desc->flags, NULL, NULL);
 	skcipher_request_set_crypt(req, src, dst, nbytes, desc->info);
 
@@ -491,10 +492,10 @@ static int xts_fallback_encrypt(struct blkcipher_desc *desc,
 {
 	struct crypto_blkcipher *tfm = desc->tfm;
 	struct s390_xts_ctx *xts_ctx = crypto_blkcipher_ctx(tfm);
-	SKCIPHER_REQUEST_ON_STACK(req, xts_ctx->fallback);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, xts_ctx->fallback);
 	unsigned int ret;
 
-	skcipher_request_set_tfm(req, xts_ctx->fallback);
+	skcipher_request_set_sync_tfm(req, xts_ctx->fallback);
 	skcipher_request_set_callback(req, desc->flags, NULL, NULL);
 	skcipher_request_set_crypt(req, src, dst, nbytes, desc->info);
 
@@ -611,8 +612,7 @@ static int xts_fallback_init(struct crypto_tfm *tfm)
 	const char *name = tfm->__crt_alg->cra_name;
 	struct s390_xts_ctx *xts_ctx = crypto_tfm_ctx(tfm);
 
-	xts_ctx->fallback = crypto_alloc_skcipher(name, 0,
-						  CRYPTO_ALG_ASYNC |
+	xts_ctx->fallback = crypto_alloc_sync_skcipher(name, 0,
 						  CRYPTO_ALG_NEED_FALLBACK);
 
 	if (IS_ERR(xts_ctx->fallback)) {
@@ -627,7 +627,7 @@ static void xts_fallback_exit(struct crypto_tfm *tfm)
 {
 	struct s390_xts_ctx *xts_ctx = crypto_tfm_ctx(tfm);
 
-	crypto_free_skcipher(xts_ctx->fallback);
+	crypto_free_sync_skcipher(xts_ctx->fallback);
 }
 
 static struct crypto_alg xts_aes_alg = {
-- 
2.17.1

