Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749AFECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258B8214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iQU8UscC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258B8214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbeISHrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:47:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43217 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730999AbeISHqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:46:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id 38-v6so1859964plc.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kx1QnHesxnHwVj0JBlqIb+29TwWzoMEIZdMibRYpRYI=;
        b=iQU8UscCxmOIiFMdP5x2fdKDlLaVpw6lAn+XjeboyGHTs9LxgemVhMHjr77sHRrOJp
         zdyYqxubwdfyNv3s3h3nu3fx7cZZy+QoLv6W90wBnoqpo1V+tzC4/l7vktYC0FqfGVTC
         fGkQtbAXynbOKtpLjt1pFAI3SN2feeLsfo1cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kx1QnHesxnHwVj0JBlqIb+29TwWzoMEIZdMibRYpRYI=;
        b=EtogyzakM7Apyu6YfCGzdqykcDwdaebh1kUzNwzY/7vbK22BnEssfgq3Cba9Zd/yK8
         GjThMUfCCUvWQN+dC+uLYENCLfXsgcOcil9EeycpywhBgiohBcZ5hBL/+wFNK5uirWH7
         Jx8vkIi9Tpf1CRL0Ql7ADM24OQA0+mgNm2rGFlaFDtlKd4nn+lTbhGhAQWEC3p8ouol2
         8upWC25CZhZ1lkd+nDMYQIGvY+T2ykimuMOL7R6SlHQ49m5XkVFQlROiIavnkoeNY+eK
         m3F4RFrJLoL0H92FZb22eWv+ZmdDdLi+WNbgK0IDBXtd8SlqFqbUnZw0L0/sYRof+kV4
         13+Q==
X-Gm-Message-State: APzg51CTDtEOqoMb6o4cyAQ7Xs9XqCH5CKiKssi0oyTExT+RCQ/0fCNR
        iAQx1oMuiMgsBCwScjkmqZRi0QVZaqM=
X-Google-Smtp-Source: ANB0VdYT2f7vYpCaO4MaT22UZEMLcJme2L+YXkPKEUaVJOjDXsUJUeyuDpO1S05h6j1ahwOt7T5tjQ==
X-Received: by 2002:a17:902:bc43:: with SMTP id t3-v6mr18798253plz.199.1537323080686;
        Tue, 18 Sep 2018 19:11:20 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id f11-v6sm27456041pfa.131.2018.09.18.19.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:11:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 15/23] crypto: cryptd - Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:52 -0700
Message-Id: <20180919021100.3380-16-keescook@chromium.org>
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
 crypto/cryptd.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/crypto/cryptd.c b/crypto/cryptd.c
index addca7bae33f..7118fb5efbaa 100644
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -76,7 +76,7 @@ struct cryptd_blkcipher_request_ctx {
 
 struct cryptd_skcipher_ctx {
 	atomic_t refcnt;
-	struct crypto_skcipher *child;
+	struct crypto_sync_skcipher *child;
 };
 
 struct cryptd_skcipher_request_ctx {
@@ -449,14 +449,16 @@ static int cryptd_skcipher_setkey(struct crypto_skcipher *parent,
 				  const u8 *key, unsigned int keylen)
 {
 	struct cryptd_skcipher_ctx *ctx = crypto_skcipher_ctx(parent);
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
@@ -483,13 +485,13 @@ static void cryptd_skcipher_encrypt(struct crypto_async_request *base,
 	struct cryptd_skcipher_request_ctx *rctx = skcipher_request_ctx(req);
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct cryptd_skcipher_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct crypto_skcipher *child = ctx->child;
-	SKCIPHER_REQUEST_ON_STACK(subreq, child);
+	struct crypto_sync_skcipher *child = ctx->child;
+	SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, child);
 
 	if (unlikely(err == -EINPROGRESS))
 		goto out;
 
-	skcipher_request_set_tfm(subreq, child);
+	skcipher_request_set_sync_tfm(subreq, child);
 	skcipher_request_set_callback(subreq, CRYPTO_TFM_REQ_MAY_SLEEP,
 				      NULL, NULL);
 	skcipher_request_set_crypt(subreq, req->src, req->dst, req->cryptlen,
@@ -511,13 +513,13 @@ static void cryptd_skcipher_decrypt(struct crypto_async_request *base,
 	struct cryptd_skcipher_request_ctx *rctx = skcipher_request_ctx(req);
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct cryptd_skcipher_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct crypto_skcipher *child = ctx->child;
-	SKCIPHER_REQUEST_ON_STACK(subreq, child);
+	struct crypto_sync_skcipher *child = ctx->child;
+	SYNC_SKCIPHER_REQUEST_ON_STACK(subreq, child);
 
 	if (unlikely(err == -EINPROGRESS))
 		goto out;
 
-	skcipher_request_set_tfm(subreq, child);
+	skcipher_request_set_sync_tfm(subreq, child);
 	skcipher_request_set_callback(subreq, CRYPTO_TFM_REQ_MAY_SLEEP,
 				      NULL, NULL);
 	skcipher_request_set_crypt(subreq, req->src, req->dst, req->cryptlen,
@@ -568,7 +570,7 @@ static int cryptd_skcipher_init_tfm(struct crypto_skcipher *tfm)
 	if (IS_ERR(cipher))
 		return PTR_ERR(cipher);
 
-	ctx->child = cipher;
+	ctx->child = (struct crypto_sync_skcipher *)cipher;
 	crypto_skcipher_set_reqsize(
 		tfm, sizeof(struct cryptd_skcipher_request_ctx));
 	return 0;
@@ -578,7 +580,7 @@ static void cryptd_skcipher_exit_tfm(struct crypto_skcipher *tfm)
 {
 	struct cryptd_skcipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	crypto_free_skcipher(ctx->child);
+	crypto_free_sync_skcipher(ctx->child);
 }
 
 static void cryptd_skcipher_free(struct skcipher_instance *inst)
@@ -1243,7 +1245,7 @@ struct crypto_skcipher *cryptd_skcipher_child(struct cryptd_skcipher *tfm)
 {
 	struct cryptd_skcipher_ctx *ctx = crypto_skcipher_ctx(&tfm->base);
 
-	return ctx->child;
+	return &ctx->child->base;
 }
 EXPORT_SYMBOL_GPL(cryptd_skcipher_child);
 
-- 
2.17.1

