Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6106FC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D782075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ad1SXRMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D782075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeIGDgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:36:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39010 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbeIGDgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:36:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so6005118pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 15:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wn1xc2a52/YzUXoT89DRQC4Gh3I1xq3VItrgerNYRaI=;
        b=ad1SXRMi+5hbLSEcUC/UXO8Jj0MKw6UIUyqTWifZb+HYi72gUyQ2sXKP7yEGYQ2GK4
         e41qqQQVvgDrvrUoUERmHIbGIxKBuhn4lk84RD1TY7TrAgvr8/x/hVVV7Jg2AcUdY0T9
         uNwOw6ZRp3MCYKyOPNj5tmp5dbBVAFao9NxSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wn1xc2a52/YzUXoT89DRQC4Gh3I1xq3VItrgerNYRaI=;
        b=XT/cgzcU/eMOdyUjnSq78SdHcXoPFRUtveqzpmCC60lMcjaE3GC1moHrOIGAgg0R/5
         FJzrti7qaxGXK8x0qsOivTxblGLi17ZpnnKx8LCCO9Tzrq6rdvgKE63DqPRLJZU/dm5W
         06B8vckk25D2cWe6zogHY9kCxNtpyGzlFqsvDqGSLd7mUNyR5XybbRLd8yBfweujSEaQ
         3dvNs/DRSkJ/nPZcCloqTaL53IeDoxYG4PAKISEmboNStozENQRNUXpan1R9F3UtlDL6
         ZNwjLibv1sBk6pKkR2squR1U5br/FoKNEJezccluxmE82h23IGlxH9Typ6DawPybukRE
         +h+g==
X-Gm-Message-State: APzg51BpCPKCYfAp4hQI5vDQ3v55q3lidGKcUBWs0op05a9RztJo+JTD
        sZ0a8Dp6avinpGV9GuYqeteDsQ==
X-Google-Smtp-Source: ANB0VdZmpC0GjqPnXs1TkQsf/g68wgkpClc0K71bWag0b15DWWZhxZhibMXOAOY9t0F+ZLs+SK9d3g==
X-Received: by 2002:a63:ef10:: with SMTP id u16-v6mr5166270pgh.269.1536274745780;
        Thu, 06 Sep 2018 15:59:05 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id l10-v6sm8963572pfj.179.2018.09.06.15.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 15:59:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/4] crypto: skcipher - Enforce non-ASYNC for on-stack requests
Date:   Thu,  6 Sep 2018 15:58:52 -0700
Message-Id: <20180906225854.40989-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180906225854.40989-1-keescook@chromium.org>
References: <20180906225854.40989-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check at use-time whether an skcipher request is on the stack. If it
is, enforce that it must be backed by a synchronous algorithm, as is
required:

  https://www.redhat.com/archives/dm-devel/2018-January/msg00087.html

Co-developed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/skcipher.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index 6e954d398e0f..3aabd5d098ed 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -19,6 +19,7 @@
 
 /**
  *	struct skcipher_request - Symmetric key cipher request
+ *	@__onstack: 1 if the request was allocated by SKCIPHER_REQUEST_ON_STACK
  *	@cryptlen: Number of bytes to encrypt or decrypt
  *	@iv: Initialisation Vector
  *	@src: Source SG list
@@ -27,6 +28,7 @@
  *	@__ctx: Start of private context data
  */
 struct skcipher_request {
+	unsigned char __onstack;
 	unsigned int cryptlen;
 
 	u8 *iv;
@@ -139,9 +141,12 @@ struct skcipher_alg {
 	struct crypto_alg base;
 };
 
+/*
+ * This must only ever be used with synchronous algorithms.
+ */
 #define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
 	char __##name##_desc[sizeof(struct skcipher_request) + \
-		crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
+		crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR = { 1 }; \
 	struct skcipher_request *name = (void *)__##name##_desc
 
 /**
@@ -437,6 +442,12 @@ static inline struct crypto_skcipher *crypto_skcipher_reqtfm_check(
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 
+	if (req->__onstack) {
+		if (WARN_ON(crypto_skcipher_alg(tfm)->base.cra_flags &
+				CRYPTO_ALG_ASYNC))
+			return ERR_PTR(-EINVAL);
+	}
+
 	if (crypto_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		return ERR_PTR(-ENOKEY);
 
-- 
2.17.1

