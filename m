Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57841ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0805C20873
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IuGNlpMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0805C20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeGPEYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:24:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33662 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeGPEYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:24:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so6943368pgv.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 20:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=221LB3j7Z9rFKSLQg3Me3x/PTbZKCxUmapr66rJJu7I=;
        b=IuGNlpMJUBQkCMrz/0AIJACPK6tBz8DLDRsGL/q22w4ndFVNAIIuJH/osgwizAp6ja
         L0B5kklVBHZ0XuERPlRNB0hTlU5OFZopynsAamFXQ6YRFj5781nRuC1ajCaK0YNDCJmz
         +vQdshKFlNdycQ5jDCPRLUdlu8spijIf1ZxvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=221LB3j7Z9rFKSLQg3Me3x/PTbZKCxUmapr66rJJu7I=;
        b=GI/MYTuX6NoxiFuWkRSRoHK7/9YItn8jn3PLrXA5XKCB8ZrDvEodQhMSHoxEFqqVxI
         8CNep1eFyK423SzwhFIzQnss3RjHcbLYS9xKFt5sdeFsJBT1OsshTAovXknZQPCqD7/n
         x8nbGovA0B7bxJFDm6lE5mahaJg//g13SmEyGIC1rQE1366h1HJ+dFUaUQ2Xt2iIg/gM
         hskUZnb3T4h2fH3gpZu7AruxZchCIi7uFrhrh7vlm97ZSVFsS426Xy9c9mb7bNvJaX9W
         wvm4L7japOpZ/YAEOhvMh0yv9s/CPPPq7iZzV4+CLW0lQi8DV+7To+WsIgDJx34fpcvt
         vsCA==
X-Gm-Message-State: AOUpUlHeBlfOofYvH3QQfcuwySGzgCrfuZiAlxFrRAoNFsDNUQrxJ3CQ
        AZPuZYrF019ExMttyq36TZc/zg==
X-Google-Smtp-Source: AAOMgpeuTTvrSN4tWz1Lg4J0FPQJ2jzilD422+wXvG2KD7qTGMrG2cngI3pDrglmjjfC6+8UBH8Zxw==
X-Received: by 2002:a62:43c8:: with SMTP id l69-v6mr16632031pfi.196.1531713554379;
        Sun, 15 Jul 2018 20:59:14 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d18-v6sm8308369pgo.74.2018.07.15.20.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 20:59:13 -0700 (PDT)
Date:   Sun, 15 Jul 2018 20:59:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] dm crypt: Convert essiv from ahash to shash
Message-ID: <20180716035912.GA32261@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparing to remove all stack VLA usage from the kernel[1], this
removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
to direct shash. The stack allocation will be made a fixed size in a
later patch to the crypto subsystem.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-crypt.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index b61b069c33af..c4c922990090 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -99,7 +99,7 @@ struct crypt_iv_operations {
 };
 
 struct iv_essiv_private {
-	struct crypto_ahash *hash_tfm;
+	struct crypto_shash *hash_tfm;
 	u8 *salt;
 };
 
@@ -327,25 +327,22 @@ static int crypt_iv_plain64be_gen(struct crypt_config *cc, u8 *iv,
 static int crypt_iv_essiv_init(struct crypt_config *cc)
 {
 	struct iv_essiv_private *essiv = &cc->iv_gen_private.essiv;
-	AHASH_REQUEST_ON_STACK(req, essiv->hash_tfm);
-	struct scatterlist sg;
+	SHASH_DESC_ON_STACK(desc, essiv->hash_tfm);
 	struct crypto_cipher *essiv_tfm;
 	int err;
 
-	sg_init_one(&sg, cc->key, cc->key_size);
-	ahash_request_set_tfm(req, essiv->hash_tfm);
-	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
-	ahash_request_set_crypt(req, &sg, essiv->salt, cc->key_size);
+	desc->tfm = essiv->hash_tfm;
+	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
 
-	err = crypto_ahash_digest(req);
-	ahash_request_zero(req);
+	err = crypto_shash_digest(desc, cc->key, cc->key_size, essiv->salt);
+	shash_desc_zero(desc);
 	if (err)
 		return err;
 
 	essiv_tfm = cc->iv_private;
 
 	err = crypto_cipher_setkey(essiv_tfm, essiv->salt,
-			    crypto_ahash_digestsize(essiv->hash_tfm));
+			    crypto_shash_digestsize(essiv->hash_tfm));
 	if (err)
 		return err;
 
@@ -356,7 +353,7 @@ static int crypt_iv_essiv_init(struct crypt_config *cc)
 static int crypt_iv_essiv_wipe(struct crypt_config *cc)
 {
 	struct iv_essiv_private *essiv = &cc->iv_gen_private.essiv;
-	unsigned salt_size = crypto_ahash_digestsize(essiv->hash_tfm);
+	unsigned salt_size = crypto_shash_digestsize(essiv->hash_tfm);
 	struct crypto_cipher *essiv_tfm;
 	int r, err = 0;
 
@@ -408,7 +405,7 @@ static void crypt_iv_essiv_dtr(struct crypt_config *cc)
 	struct crypto_cipher *essiv_tfm;
 	struct iv_essiv_private *essiv = &cc->iv_gen_private.essiv;
 
-	crypto_free_ahash(essiv->hash_tfm);
+	crypto_free_shash(essiv->hash_tfm);
 	essiv->hash_tfm = NULL;
 
 	kzfree(essiv->salt);
@@ -426,7 +423,7 @@ static int crypt_iv_essiv_ctr(struct crypt_config *cc, struct dm_target *ti,
 			      const char *opts)
 {
 	struct crypto_cipher *essiv_tfm = NULL;
-	struct crypto_ahash *hash_tfm = NULL;
+	struct crypto_shash *hash_tfm = NULL;
 	u8 *salt = NULL;
 	int err;
 
@@ -436,14 +433,14 @@ static int crypt_iv_essiv_ctr(struct crypt_config *cc, struct dm_target *ti,
 	}
 
 	/* Allocate hash algorithm */
-	hash_tfm = crypto_alloc_ahash(opts, 0, CRYPTO_ALG_ASYNC);
+	hash_tfm = crypto_alloc_shash(opts, 0, 0);
 	if (IS_ERR(hash_tfm)) {
 		ti->error = "Error initializing ESSIV hash";
 		err = PTR_ERR(hash_tfm);
 		goto bad;
 	}
 
-	salt = kzalloc(crypto_ahash_digestsize(hash_tfm), GFP_KERNEL);
+	salt = kzalloc(crypto_shash_digestsize(hash_tfm), GFP_KERNEL);
 	if (!salt) {
 		ti->error = "Error kmallocing salt storage in ESSIV";
 		err = -ENOMEM;
@@ -454,7 +451,7 @@ static int crypt_iv_essiv_ctr(struct crypt_config *cc, struct dm_target *ti,
 	cc->iv_gen_private.essiv.hash_tfm = hash_tfm;
 
 	essiv_tfm = alloc_essiv_cipher(cc, ti, salt,
-				       crypto_ahash_digestsize(hash_tfm));
+				       crypto_shash_digestsize(hash_tfm));
 	if (IS_ERR(essiv_tfm)) {
 		crypt_iv_essiv_dtr(cc);
 		return PTR_ERR(essiv_tfm);
@@ -465,7 +462,7 @@ static int crypt_iv_essiv_ctr(struct crypt_config *cc, struct dm_target *ti,
 
 bad:
 	if (hash_tfm && !IS_ERR(hash_tfm))
-		crypto_free_ahash(hash_tfm);
+		crypto_free_shash(hash_tfm);
 	kfree(salt);
 	return err;
 }
-- 
2.17.1


-- 
Kees Cook
Pixel Security
