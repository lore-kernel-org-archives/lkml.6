Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D97C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EA02150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nWedSD77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EA02150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbeISHqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:46:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43218 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730983AbeISHqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:46:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id 38-v6so1859978plc.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I2hcMVXGV7OApvUgHaXTiO8YqbUDBC+hO91hCX/pOYw=;
        b=nWedSD77PbdXbq43SjIv5rQuXu9+93dyqtUH6/E2RiyVzFTAl5iKUDKx1d9d3f9k//
         EBs2+ESdGv6yui/pPVlJgbM/SkmdHhO3D6FDV1AMgjFOFAzXxA0eAD7sDEjn6h0oz4/E
         NGqZ/BxSS0uf6ybrKUXv9YHbY/3fiWBNLutSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I2hcMVXGV7OApvUgHaXTiO8YqbUDBC+hO91hCX/pOYw=;
        b=qMZahuk6jPPmrvzRj16thX8zAmuY94k2EBnUwQkCfS4dM+w+/7aSh1VucGcq8zqHm8
         tEsfYJi44Ca64+N09gs7AGXv1dQ/BQIapYxr3enitKd9IqCmFVRsqTnblsbXSjFTYypx
         zer7zxRY9x0bdhnfn0LRJxSKHftQZpqKIA1L9pFKrelq+ySh/Qw3julFcbb4GMiV7jdL
         mCvZKcxews37bO4KR6bPfa/XIikx/WBF/9BY/nsauGK3CW+MThKVhmLNSAEOeMpHlcCP
         0kDymFD1duhRIQEeSbeQYEfb9u2KdRgvGMnQXZosQvhSG2YfFRVYxB4D+mH44/wrJt5L
         2GiQ==
X-Gm-Message-State: APzg51A+G8MINDfFVGn5iYNrMeZhUYIO3cLRda8FejnULEwQgfpeXgcz
        C9hKvhnL3CrXze4NxyJ9yKwEewJtpQI=
X-Google-Smtp-Source: ANB0VdakeZpqA62pIHcjWLmODfeSDbBHnDvggQr5UvRBkeFM5mt43H+cjzIv9vb1GM7ykyOWylVM0w==
X-Received: by 2002:a17:902:e20b:: with SMTP id ce11-v6mr32383730plb.136.1537323081652;
        Tue, 18 Sep 2018 19:11:21 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id f62-v6sm27169215pfg.74.2018.09.18.19.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:11:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 16/23] crypto: sahara - Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:53 -0700
Message-Id: <20180919021100.3380-17-keescook@chromium.org>
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

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/sahara.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
index e7540a5b8197..bbf166a97ad3 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -149,7 +149,7 @@ struct sahara_ctx {
 	/* AES-specific context */
 	int keylen;
 	u8 key[AES_KEYSIZE_128];
-	struct crypto_skcipher *fallback;
+	struct crypto_sync_skcipher *fallback;
 };
 
 struct sahara_aes_reqctx {
@@ -621,14 +621,14 @@ static int sahara_aes_setkey(struct crypto_ablkcipher *tfm, const u8 *key,
 	/*
 	 * The requested key size is not supported by HW, do a fallback.
 	 */
-	crypto_skcipher_clear_flags(ctx->fallback, CRYPTO_TFM_REQ_MASK);
-	crypto_skcipher_set_flags(ctx->fallback, tfm->base.crt_flags &
+	crypto_sync_skcipher_clear_flags(ctx->fallback, CRYPTO_TFM_REQ_MASK);
+	crypto_sync_skcipher_set_flags(ctx->fallback, tfm->base.crt_flags &
 						 CRYPTO_TFM_REQ_MASK);
 
-	ret = crypto_skcipher_setkey(ctx->fallback, key, keylen);
+	ret = crypto_sync_skcipher_setkey(ctx->fallback, key, keylen);
 
 	tfm->base.crt_flags &= ~CRYPTO_TFM_RES_MASK;
-	tfm->base.crt_flags |= crypto_skcipher_get_flags(ctx->fallback) &
+	tfm->base.crt_flags |= crypto_sync_skcipher_get_flags(ctx->fallback) &
 			       CRYPTO_TFM_RES_MASK;
 	return ret;
 }
@@ -666,9 +666,9 @@ static int sahara_aes_ecb_encrypt(struct ablkcipher_request *req)
 	int err;
 
 	if (unlikely(ctx->keylen != AES_KEYSIZE_128)) {
-		SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
+		SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
 
-		skcipher_request_set_tfm(subreq, ctx->fallback);
+		skcipher_request_set_sync_tfm(subreq, ctx->fallback);
 		skcipher_request_set_callback(subreq, req->base.flags,
 					      NULL, NULL);
 		skcipher_request_set_crypt(subreq, req->src, req->dst,
@@ -688,9 +688,9 @@ static int sahara_aes_ecb_decrypt(struct ablkcipher_request *req)
 	int err;
 
 	if (unlikely(ctx->keylen != AES_KEYSIZE_128)) {
-		SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
+		SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
 
-		skcipher_request_set_tfm(subreq, ctx->fallback);
+		skcipher_request_set_sync_tfm(subreq, ctx->fallback);
 		skcipher_request_set_callback(subreq, req->base.flags,
 					      NULL, NULL);
 		skcipher_request_set_crypt(subreq, req->src, req->dst,
@@ -710,9 +710,9 @@ static int sahara_aes_cbc_encrypt(struct ablkcipher_request *req)
 	int err;
 
 	if (unlikely(ctx->keylen != AES_KEYSIZE_128)) {
-		SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
+		SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
 
-		skcipher_request_set_tfm(subreq, ctx->fallback);
+		skcipher_request_set_sync_tfm(subreq, ctx->fallback);
 		skcipher_request_set_callback(subreq, req->base.flags,
 					      NULL, NULL);
 		skcipher_request_set_crypt(subreq, req->src, req->dst,
@@ -732,9 +732,9 @@ static int sahara_aes_cbc_decrypt(struct ablkcipher_request *req)
 	int err;
 
 	if (unlikely(ctx->keylen != AES_KEYSIZE_128)) {
-		SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
+		SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
 
-		skcipher_request_set_tfm(subreq, ctx->fallback);
+		skcipher_request_set_sync_tfm(subreq, ctx->fallback);
 		skcipher_request_set_callback(subreq, req->base.flags,
 					      NULL, NULL);
 		skcipher_request_set_crypt(subreq, req->src, req->dst,
@@ -752,8 +752,7 @@ static int sahara_aes_cra_init(struct crypto_tfm *tfm)
 	const char *name = crypto_tfm_alg_name(tfm);
 	struct sahara_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	ctx->fallback = crypto_alloc_skcipher(name, 0,
-					      CRYPTO_ALG_ASYNC |
+	ctx->fallback = crypto_alloc_sync_skcipher(name, 0,
 					      CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(ctx->fallback)) {
 		pr_err("Error allocating fallback algo %s\n", name);
@@ -769,7 +768,7 @@ static void sahara_aes_cra_exit(struct crypto_tfm *tfm)
 {
 	struct sahara_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	crypto_free_skcipher(ctx->fallback);
+	crypto_free_sync_skcipher(ctx->fallback);
 }
 
 static u32 sahara_sha_init_hdr(struct sahara_dev *dev,
-- 
2.17.1

