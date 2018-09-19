Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19024C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BC22146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eVFOScn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BC22146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbeISHyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:54:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32973 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbeISHyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:54:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id s7-v6so1960472pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bwpHaNlRdidXYTSo5B9BGO/P76H7RxTgLjp5X7q/NJw=;
        b=eVFOScn1P73qT/paJvfd9cUG9+vTYBA285PcZQ1jbgTyZVZA8p1UxdXs0uXk8st4yM
         Vn7MMWK5OzrVfrHfv/hU4eJ0rKisZKM5pfu2ZUs0RPkP6egvz3kfQUmU1j3PqAAW2M7Z
         orWRqQyOSItFpWSIUW9F/RcfzPx6WU2QvYmJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bwpHaNlRdidXYTSo5B9BGO/P76H7RxTgLjp5X7q/NJw=;
        b=lD1bR6lsl9jU/HNw2C/WU6s7fFppRYuMm8VSXxYtiaGuI4oUmy4Z6iwNr1+E6bb1CH
         hOPTWJcRFzk5xHz/Iz/wiezOuAGBjmLq8YhJFHHxy3jUGVC/KzZ4Y8DXWVRJskHNrpDs
         5uxCmiMjW5tpIAmJWEnQPwLf/ORePw6AWAVKNLMNgDu3YOKYM6tDOIz1UQ59T9ODJL8E
         XLhQbSZExtT+rB8ByYfCkOGtT1CYttjLCN14qr+sWruWUDgigQjkRvU3DSDbaEFLIhQR
         h/ZCLa0Ho57qOQNz5XckeKIYEZK9EBH6cdXptRGBuBBckGsf7Xb7CkFrrYM0fs0hhHrk
         5hSA==
X-Gm-Message-State: APzg51Bvz24XfehtntD4t/eMmZC2C/RCx4hXN7ctTtBUfxf0Dlhfer5o
        kln+rEVtFwIHZcNSBBEAqLQdvQ==
X-Google-Smtp-Source: ANB0VdZLxVEmbuy0wn/Y5oCh7SBNZnvgS1bkOOP37xIGXWzYQtEWqu0Oa8oxWyuSc7vmonV3Pya12g==
X-Received: by 2002:a63:5204:: with SMTP id g4-v6mr29970572pgb.274.1537323560594;
        Tue, 18 Sep 2018 19:19:20 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id f75-v6sm35679362pfk.85.2018.09.18.19.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:19:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 17/23] crypto: qce - Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:54 -0700
Message-Id: <20180919021100.3380-18-keescook@chromium.org>
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

Cc: Himanshu Jha <himanshujha199640@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/qce/ablkcipher.c | 13 ++++++-------
 drivers/crypto/qce/cipher.h     |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/qce/ablkcipher.c b/drivers/crypto/qce/ablkcipher.c
index ea4d96bf47e8..585e1cab9ae3 100644
--- a/drivers/crypto/qce/ablkcipher.c
+++ b/drivers/crypto/qce/ablkcipher.c
@@ -189,7 +189,7 @@ static int qce_ablkcipher_setkey(struct crypto_ablkcipher *ablk, const u8 *key,
 	memcpy(ctx->enc_key, key, keylen);
 	return 0;
 fallback:
-	ret = crypto_skcipher_setkey(ctx->fallback, key, keylen);
+	ret = crypto_sync_skcipher_setkey(ctx->fallback, key, keylen);
 	if (!ret)
 		ctx->enc_keylen = keylen;
 	return ret;
@@ -212,9 +212,9 @@ static int qce_ablkcipher_crypt(struct ablkcipher_request *req, int encrypt)
 
 	if (IS_AES(rctx->flags) && ctx->enc_keylen != AES_KEYSIZE_128 &&
 	    ctx->enc_keylen != AES_KEYSIZE_256) {
-		SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
+		SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
 
-		skcipher_request_set_tfm(subreq, ctx->fallback);
+		skcipher_request_set_sync_tfm(subreq, ctx->fallback);
 		skcipher_request_set_callback(subreq, req->base.flags,
 					      NULL, NULL);
 		skcipher_request_set_crypt(subreq, req->src, req->dst,
@@ -245,9 +245,8 @@ static int qce_ablkcipher_init(struct crypto_tfm *tfm)
 	memset(ctx, 0, sizeof(*ctx));
 	tfm->crt_ablkcipher.reqsize = sizeof(struct qce_cipher_reqctx);
 
-	ctx->fallback = crypto_alloc_skcipher(crypto_tfm_alg_name(tfm), 0,
-					      CRYPTO_ALG_ASYNC |
-					      CRYPTO_ALG_NEED_FALLBACK);
+	ctx->fallback = crypto_alloc_sync_skcipher(crypto_tfm_alg_name(tfm),
+						   0, CRYPTO_ALG_NEED_FALLBACK);
 	return PTR_ERR_OR_ZERO(ctx->fallback);
 }
 
@@ -255,7 +254,7 @@ static void qce_ablkcipher_exit(struct crypto_tfm *tfm)
 {
 	struct qce_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	crypto_free_skcipher(ctx->fallback);
+	crypto_free_sync_skcipher(ctx->fallback);
 }
 
 struct qce_ablkcipher_def {
diff --git a/drivers/crypto/qce/cipher.h b/drivers/crypto/qce/cipher.h
index 2b0278bb6e92..ee055bfe98a0 100644
--- a/drivers/crypto/qce/cipher.h
+++ b/drivers/crypto/qce/cipher.h
@@ -22,7 +22,7 @@
 struct qce_cipher_ctx {
 	u8 enc_key[QCE_MAX_KEY_SIZE];
 	unsigned int enc_keylen;
-	struct crypto_skcipher *fallback;
+	struct crypto_sync_skcipher *fallback;
 };
 
 /**
-- 
2.17.1

