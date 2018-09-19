Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1B2ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F7721508
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aPHTrHMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F7721508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbeISHsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:48:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43670 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730883AbeISHqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:46:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id q19-v6so1077934pgn.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ROtVbEYXO0Dkld82te80QOJw3jccOmR4EUaG6Lwr8OI=;
        b=aPHTrHMwWKXGdR2E/H1C/wj4Uor72+7iP3c78+k8+hL1nQ55tt1DCOdl9wKA2DqVsZ
         tVJxw0f584K8BjVJVKwPPDkLk+OhuJEOJYRK+0kG5iVckl/24Gfu1pSFK5Nif4ByJu42
         /8qV8MrT3qj9QQFDR0zxpRXnCWbM0uZxKFOu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ROtVbEYXO0Dkld82te80QOJw3jccOmR4EUaG6Lwr8OI=;
        b=qRYo8kIOwr/PgB/jDpa1GZgmxkdN5d/9acy3yWv2brBXje9mkL8ZV9bMNE5woQ13xW
         6dYPU/hzSqE7jxs+rOB3EkZaHrGeSwSgJ2VZZq7CIsOdKH7CIajKZWPkGoXKXNzyIrpO
         DuvnJs/SBhmNATL8Y3mEZQLpiGF7OMB8uj+SVTBkvNZk/dErc0+ywQQpbBIhEyOkrYkU
         ZQf33iu3RswRU8ndnMtEwHeyI25jOXGLNjX/gUj1GBuDV7aHygqT3/l+MkmODNQb32uw
         sRKs3j1DJdC9a8yWNGeVoUaAxgXaXQpPQOp7wpo3WPqTtwCaMwa07ggbpM2kARlImxyr
         oEew==
X-Gm-Message-State: APzg51DuzkreXtcG7OYxJlTgVyYdZyAbdQ7hWCR9FWFLsOzdCCQYui8i
        HEJuU8c1uHagddkyKSNNxt2KkQ==
X-Google-Smtp-Source: ANB0VdanV2hPHPefDr0WprjOOk5d1CNZob8JS+8Q5LHnJ0o01nDdQ8lYpiB5QnrnSquIcffhQJJO/Q==
X-Received: by 2002:a63:d90b:: with SMTP id r11-v6mr30428562pgg.315.1537323071718;
        Tue, 18 Sep 2018 19:11:11 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id i5-v6sm33157187pfe.140.2018.09.18.19.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:11:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 06/23] x86/fpu: Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:43 -0700
Message-Id: <20180919021100.3380-7-keescook@chromium.org>
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

Cc: x86@kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/crypto/fpu.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/crypto/fpu.c b/arch/x86/crypto/fpu.c
index 406680476c52..be9b3766f241 100644
--- a/arch/x86/crypto/fpu.c
+++ b/arch/x86/crypto/fpu.c
@@ -20,21 +20,23 @@
 #include <asm/fpu/api.h>
 
 struct crypto_fpu_ctx {
-	struct crypto_skcipher *child;
+	struct crypto_sync_skcipher *child;
 };
 
 static int crypto_fpu_setkey(struct crypto_skcipher *parent, const u8 *key,
 			     unsigned int keylen)
 {
 	struct crypto_fpu_ctx *ctx = crypto_skcipher_ctx(parent);
-	struct crypto_skcipher *child = ctx->child;
+	struct crypto_sync_skcipher *child = ctx->child;
 	int err;
 
-	crypto_skcipher_clear_flags(child, CRYPTO_TFM_REQ_MASK);
-	crypto_skcipher_set_flags(child, crypto_skcipher_get_flags(parent) &
+	crypto_sync_skcipher_clear_flags(child, CRYPTO_TFM_REQ_MASK);
+	crypto_sync_skcipher_set_flags(child,
+				       crypto_skcipher_get_flags(parent) &
 					 CRYPTO_TFM_REQ_MASK);
-	err = crypto_skcipher_setkey(child, key, keylen);
-	crypto_skcipher_set_flags(parent, crypto_skcipher_get_flags(child) &
+	err = crypto_sync_skcipher_setkey(child, key, keylen);
+	crypto_skcipher_set_flags(parent,
+				  crypto_sync_skcipher_get_flags(child) &
 					  CRYPTO_TFM_RES_MASK);
 	return err;
 }
@@ -43,11 +45,11 @@ static int crypto_fpu_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct crypto_fpu_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct crypto_skcipher *child = ctx->child;
-	SKCIPHER_REQUEST_ON_STACK(subreq, child);
+	struct crypto_sync_skcipher *child = ctx->child;
+	SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, child);
 	int err;
 
-	skcipher_request_set_tfm(subreq, child);
+	skcipher_request_set_sync_tfm(subreq, child);
 	skcipher_request_set_callback(subreq, 0, NULL, NULL);
 	skcipher_request_set_crypt(subreq, req->src, req->dst, req->cryptlen,
 				   req->iv);
@@ -64,11 +66,11 @@ static int crypto_fpu_decrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct crypto_fpu_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct crypto_skcipher *child = ctx->child;
-	SKCIPHER_REQUEST_ON_STACK(subreq, child);
+	struct crypto_sync_skcipher *child = ctx->child;
+	SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, child);
 	int err;
 
-	skcipher_request_set_tfm(subreq, child);
+	skcipher_request_set_sync_tfm(subreq, child);
 	skcipher_request_set_callback(subreq, 0, NULL, NULL);
 	skcipher_request_set_crypt(subreq, req->src, req->dst, req->cryptlen,
 				   req->iv);
@@ -93,7 +95,7 @@ static int crypto_fpu_init_tfm(struct crypto_skcipher *tfm)
 	if (IS_ERR(cipher))
 		return PTR_ERR(cipher);
 
-	ctx->child = cipher;
+	ctx->child = (struct crypto_sync_skcipher *)cipher;
 
 	return 0;
 }
@@ -102,7 +104,7 @@ static void crypto_fpu_exit_tfm(struct crypto_skcipher *tfm)
 {
 	struct crypto_fpu_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	crypto_free_skcipher(ctx->child);
+	crypto_free_sync_skcipher(ctx->child);
 }
 
 static void crypto_fpu_free(struct skcipher_instance *inst)
-- 
2.17.1

