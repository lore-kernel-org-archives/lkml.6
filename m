Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A22C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E136B2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xv3EXJvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E136B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbeISHzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:55:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41581 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeISHyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:54:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id b12-v6so1867108plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=65XQXoAyD+UTIG+r47sytz0E0OesX27kp0gjZpSVYfU=;
        b=Xv3EXJvGyC37iHum5DKBf3ml2OW+WVlHUuBKT1HIGjj6Ln6iTe1rUalOMIqO05vQmM
         4dTnjltYo3H0iAb7Or43uB0Eh/P9btxkov4dWh9xiSeKHXd60vmjz2Wgb0hgrsQE6l/n
         YBDGqjk2i16Zbl26NjHXLeE7fSElKnpaA/aCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=65XQXoAyD+UTIG+r47sytz0E0OesX27kp0gjZpSVYfU=;
        b=kUM3M/QY/879s4Uvfy+aa4MNsA/LyYxhR/xDrPPS91a6AH79hHldUzrv3xnFKMR/0r
         aCosZELH7OvmKWVfUuXBfhuMD7KYmp7tqVybHoyEYABWU20M44nNUBhcQlp/ItBY8Qz2
         gOuuf/aRFXYbuuUPvfcKd4n9tJMR/MKG7QuTUSDKPqXt7jMU8p5SZx8Gb70BwTtDtFoN
         yY0akZimgXLOKHIM2METtnZaqrpckockeOvB2jTXsRHHAantLGLaqe9iftZRc0a9KArn
         tLDDya86jWl8Vg5Y+6RvtCY10Ny3OTcyOJV7zR+H0KInaCQIl0ZQ4MD5XsonVudL58yM
         JD5A==
X-Gm-Message-State: APzg51Bp0MyGtx3OM8Ui4fsmbI5+U58BFMn30WBD0dWbNjtDxGHETKp3
        Dr1JoAZoRTwZ81iZCG5Lw4Y1OQ==
X-Google-Smtp-Source: ANB0VdaB/BhOOmO5o668mB4XBfuJZChJuLjy2pjxlRb3TNw5dStTNC+vTZqVfFd9LTZjpZnmHYYcKA==
X-Received: by 2002:a17:902:8542:: with SMTP id d2-v6mr32506589plo.285.1537323561408;
        Tue, 18 Sep 2018 19:19:21 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x82-v6sm35632060pfe.129.2018.09.18.19.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:19:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        linux-arm-kernel@axis.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 18/23] crypto: artpec6 - Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:55 -0700
Message-Id: <20180919021100.3380-19-keescook@chromium.org>
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

Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>
Cc: linux-arm-kernel@axis.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/axis/artpec6_crypto.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 7f07a5085e9b..e5a080e87ea8 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -330,7 +330,7 @@ struct artpec6_cryptotfm_context {
 	size_t key_length;
 	u32 key_md;
 	int crypto_type;
-	struct crypto_skcipher *fallback;
+	struct crypto_sync_skcipher *fallback;
 };
 
 struct artpec6_crypto_aead_hw_ctx {
@@ -1199,15 +1199,15 @@ artpec6_crypto_ctr_crypt(struct skcipher_request *req, bool encrypt)
 		pr_debug("counter %x will overflow (nblks %u), falling back\n",
 			 counter, counter + nblks);
 
-		ret = crypto_skcipher_setkey(ctx->fallback, ctx->aes_key,
-					     ctx->key_length);
+		ret = crypto_sync_skcipher_setkey(ctx->fallback, ctx->aes_key,
+						  ctx->key_length);
 		if (ret)
 			return ret;
 
 		{
-			SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
+			SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, ctx->fallback);
 
-			skcipher_request_set_tfm(subreq, ctx->fallback);
+			skcipher_request_set_sync_tfm(subreq, ctx->fallback);
 			skcipher_request_set_callback(subreq, req->base.flags,
 						      NULL, NULL);
 			skcipher_request_set_crypt(subreq, req->src, req->dst,
@@ -1561,10 +1561,9 @@ static int artpec6_crypto_aes_ctr_init(struct crypto_skcipher *tfm)
 {
 	struct artpec6_cryptotfm_context *ctx = crypto_skcipher_ctx(tfm);
 
-	ctx->fallback = crypto_alloc_skcipher(crypto_tfm_alg_name(&tfm->base),
-					      0,
-					      CRYPTO_ALG_ASYNC |
-					      CRYPTO_ALG_NEED_FALLBACK);
+	ctx->fallback =
+		crypto_alloc_sync_skcipher(crypto_tfm_alg_name(&tfm->base),
+					   0, CRYPTO_ALG_NEED_FALLBACK);
 	if (IS_ERR(ctx->fallback))
 		return PTR_ERR(ctx->fallback);
 
@@ -1605,7 +1604,7 @@ static void artpec6_crypto_aes_ctr_exit(struct crypto_skcipher *tfm)
 {
 	struct artpec6_cryptotfm_context *ctx = crypto_skcipher_ctx(tfm);
 
-	crypto_free_skcipher(ctx->fallback);
+	crypto_free_sync_skcipher(ctx->fallback);
 	artpec6_crypto_aes_exit(tfm);
 }
 
-- 
2.17.1

