Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A7DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3AE2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GjDA8xNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3AE2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeIGDhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:37:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44944 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeIGDgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:36:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so5984952pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J0G2Sx5hOKWq7psD4bTWlVfsrIiRfpFq057sVXNCifs=;
        b=GjDA8xNVXsZrNpIfV9oXjhaeLfPK6jjhTs0b8gPIiuk8PT2k2SniQfrMgTvBQn8xAK
         UTD+ujqsvkff6p+rWV9KgoXU4lhSz4i4fa9CjMWssKMVraSHJoAx92pjwIQAtwTEOhzi
         jAIwr3lFdn08CWSiEUfoJrhyRsUWdhT3El2mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J0G2Sx5hOKWq7psD4bTWlVfsrIiRfpFq057sVXNCifs=;
        b=sd9u/vTUgQP4YlqzyvXypYrEh5sum7/zTAdi6s4EwlNt23YxkvPIRtR+VPXq1DFW0o
         YFKYFt7Tdj/jKjBHdziP7mufxFVudJjt5xzbT5yajQ1I+2YBdqlt88/5roC5zfCabdxN
         /NBl1Zk3Hv2YGAlclchgnux2L7kxkwoVumKnl6T0XCVb0T8Frb9JuCCYHHZL9jVDYvZP
         oH7QdCBx8aB3rd3cK9fWdJVc8OvRmGsxTlZfGWwX7foC1gE5U43QV9NJXPBIzk80bImO
         uTP6+kzl34kcE73UeJky/B+IjolvCnARmLObWd7rT3pqFjenJ4plaeaZk+CKeqbulhpl
         b6iQ==
X-Gm-Message-State: APzg51AJ7ghnxIyHVxWQIa1L4uwUz526FEVmtwwkt6WsK8mXdbugmLGH
        6b7nEIb7uau3uDkgYvEX1yOuTg==
X-Google-Smtp-Source: ANB0VdYbCvFB1nkMmwQhASRHb+MkF34upfkOQqjT6t0RWpXujZd0U1xvwwCMI6ypbfArp60hVrpjFg==
X-Received: by 2002:a63:2605:: with SMTP id m5-v6mr5004148pgm.225.1536274744595;
        Thu, 06 Sep 2018 15:59:04 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id w12-v6sm8657686pfd.110.2018.09.06.15.59.01
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
Subject: [PATCH v2 1/4] crypto: skcipher - Consolidate encrypt/decrypt sanity check
Date:   Thu,  6 Sep 2018 15:58:51 -0700
Message-Id: <20180906225854.40989-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180906225854.40989-1-keescook@chromium.org>
References: <20180906225854.40989-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to adding additional sanity checks before running an
skcipher request, this consolidates the open-coded checks into a single
function. Instead of passing both req and tfm into the new check this
just returns the tfm on success and an ERR_PTR on failure, keeping things
as clean as possible.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/skcipher.h | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index 2f327f090c3e..6e954d398e0f 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -422,6 +422,27 @@ static inline struct crypto_skcipher *crypto_skcipher_reqtfm(
 	return __crypto_skcipher_cast(req->base.tfm);
 }
 
+/**
+ * crypto_skcipher_reqtfm_check() - obtain and check cipher handle from request
+ * @req: skcipher_request out of which the cipher handle is to be obtained
+ *
+ * Return the crypto_skcipher handle when furnishing an skcipher_request
+ * data structure. Check for error conditions that would make it unusable
+ * for an encrypt/decrypt call.
+ *
+ * Return: crypto_skcipher handle, or ERR_PTR on error.
+ */
+static inline struct crypto_skcipher *crypto_skcipher_reqtfm_check(
+	struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+
+	if (crypto_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return ERR_PTR(-ENOKEY);
+
+	return tfm;
+}
+
 /**
  * crypto_skcipher_encrypt() - encrypt plaintext
  * @req: reference to the skcipher_request handle that holds all information
@@ -435,10 +456,10 @@ static inline struct crypto_skcipher *crypto_skcipher_reqtfm(
  */
 static inline int crypto_skcipher_encrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm_check(req);
 
-	if (crypto_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
-		return -ENOKEY;
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
 
 	return tfm->encrypt(req);
 }
@@ -456,10 +477,10 @@ static inline int crypto_skcipher_encrypt(struct skcipher_request *req)
  */
 static inline int crypto_skcipher_decrypt(struct skcipher_request *req)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm_check(req);
 
-	if (crypto_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
-		return -ENOKEY;
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
 
 	return tfm->decrypt(req);
 }
-- 
2.17.1

