Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B512FC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8001220879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080450;
	bh=kz5HtQG//glOUViits9s55TLR0bBMYf3Zw+ZcpsZ3Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FXx6Kb3j70192u74wsY0dX9blrRzVhEaUxpq/V73kC1qP5SH6Gq2NJBTCN3vZl+cY
	 aLXU5wSy7g9CmM5tN6+DtziAdWyptdCGBHMEaguUW7gulGjtlf67M2r7vV6YFPjtDb
	 rv1nm6XmckjHPrItJc+dIWhZdsbgGpEfm9TtCYK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfAUNre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:47:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbfAUNrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:47:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E28320870;
        Mon, 21 Jan 2019 13:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078450;
        bh=kz5HtQG//glOUViits9s55TLR0bBMYf3Zw+ZcpsZ3Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UK2O8SkNDFnSc93Q/RUB8jP83YYPNdXNgTdQEdjeh9T+waj0BcvyzIgMHSvJNDkCm
         SWelIx3i42S2u44CzfeG5jrncSgjgwa1rMwgCL4niH3o2j3eSRLdDJC/vfHKbcNg9l
         sii89Z/qfqbd+daZPfQ1ELiud4w9ntQFwnR7QlwY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.20 035/111] crypto: ccree - convert to use crypto_authenc_extractkeys()
Date:   Mon, 21 Jan 2019 14:42:29 +0100
Message-Id: <20190121122459.763343197@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit dc95b5350a8f07d73d6bde3a79ef87289698451d upstream.

Convert the ccree crypto driver to use crypto_authenc_extractkeys() so
that it picks up the fix for broken validation of rtattr::rta_len.

Fixes: ff27e85a85bb ("crypto: ccree - add AEAD support")
Cc: <stable@vger.kernel.org> # v4.17+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_aead.c |   40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

--- a/drivers/crypto/ccree/cc_aead.c
+++ b/drivers/crypto/ccree/cc_aead.c
@@ -540,13 +540,12 @@ static int cc_aead_setkey(struct crypto_
 			  unsigned int keylen)
 {
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct rtattr *rta = (struct rtattr *)key;
 	struct cc_crypto_req cc_req = {};
-	struct crypto_authenc_key_param *param;
 	struct cc_hw_desc desc[MAX_AEAD_SETKEY_SEQ];
-	int rc = -EINVAL;
 	unsigned int seq_len = 0;
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
+	const u8 *enckey, *authkey;
+	int rc;
 
 	dev_dbg(dev, "Setting key in context @%p for %s. key=%p keylen=%u\n",
 		ctx, crypto_tfm_alg_name(crypto_aead_tfm(tfm)), key, keylen);
@@ -554,35 +553,33 @@ static int cc_aead_setkey(struct crypto_
 	/* STAT_PHASE_0: Init and sanity checks */
 
 	if (ctx->auth_mode != DRV_HASH_NULL) { /* authenc() alg. */
-		if (!RTA_OK(rta, keylen))
-			goto badkey;
-		if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
-			goto badkey;
-		if (RTA_PAYLOAD(rta) < sizeof(*param))
-			goto badkey;
-		param = RTA_DATA(rta);
-		ctx->enc_keylen = be32_to_cpu(param->enckeylen);
-		key += RTA_ALIGN(rta->rta_len);
-		keylen -= RTA_ALIGN(rta->rta_len);
-		if (keylen < ctx->enc_keylen)
+		struct crypto_authenc_keys keys;
+
+		rc = crypto_authenc_extractkeys(&keys, key, keylen);
+		if (rc)
 			goto badkey;
-		ctx->auth_keylen = keylen - ctx->enc_keylen;
+		enckey = keys.enckey;
+		authkey = keys.authkey;
+		ctx->enc_keylen = keys.enckeylen;
+		ctx->auth_keylen = keys.authkeylen;
 
 		if (ctx->cipher_mode == DRV_CIPHER_CTR) {
 			/* the nonce is stored in bytes at end of key */
+			rc = -EINVAL;
 			if (ctx->enc_keylen <
 			    (AES_MIN_KEY_SIZE + CTR_RFC3686_NONCE_SIZE))
 				goto badkey;
 			/* Copy nonce from last 4 bytes in CTR key to
 			 *  first 4 bytes in CTR IV
 			 */
-			memcpy(ctx->ctr_nonce, key + ctx->auth_keylen +
-			       ctx->enc_keylen - CTR_RFC3686_NONCE_SIZE,
-			       CTR_RFC3686_NONCE_SIZE);
+			memcpy(ctx->ctr_nonce, enckey + ctx->enc_keylen -
+			       CTR_RFC3686_NONCE_SIZE, CTR_RFC3686_NONCE_SIZE);
 			/* Set CTR key size */
 			ctx->enc_keylen -= CTR_RFC3686_NONCE_SIZE;
 		}
 	} else { /* non-authenc - has just one key */
+		enckey = key;
+		authkey = NULL;
 		ctx->enc_keylen = keylen;
 		ctx->auth_keylen = 0;
 	}
@@ -594,13 +591,14 @@ static int cc_aead_setkey(struct crypto_
 	/* STAT_PHASE_1: Copy key to ctx */
 
 	/* Get key material */
-	memcpy(ctx->enckey, key + ctx->auth_keylen, ctx->enc_keylen);
+	memcpy(ctx->enckey, enckey, ctx->enc_keylen);
 	if (ctx->enc_keylen == 24)
 		memset(ctx->enckey + 24, 0, CC_AES_KEY_SIZE_MAX - 24);
 	if (ctx->auth_mode == DRV_HASH_XCBC_MAC) {
-		memcpy(ctx->auth_state.xcbc.xcbc_keys, key, ctx->auth_keylen);
+		memcpy(ctx->auth_state.xcbc.xcbc_keys, authkey,
+		       ctx->auth_keylen);
 	} else if (ctx->auth_mode != DRV_HASH_NULL) { /* HMAC */
-		rc = cc_get_plain_hmac_key(tfm, key, ctx->auth_keylen);
+		rc = cc_get_plain_hmac_key(tfm, authkey, ctx->auth_keylen);
 		if (rc)
 			goto badkey;
 	}


