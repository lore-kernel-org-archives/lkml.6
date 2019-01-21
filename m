Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7729DC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4809720989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078457;
	bh=HulYPTH4inzvGZLBH/+5kwxtLNIM4dSrBDB6C613tnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ttkv7XiMPnyFxWWtYLvtL5n0TfD1LCPfJGDpftZWVwvyxwtBkydXgsinRvF6dOv2T
	 0uJ6FZY5XXxflHTpM+ka4o9V2U+q72XgFobtD1yfNhVwl5ALIUalE1PTETHdjbQe9A
	 e/rwOXI1REcxXWR0/LatgMMy8iLwQuzgIBDUOMRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfAUNrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729633AbfAUNre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:47:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00C5020861;
        Mon, 21 Jan 2019 13:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078453;
        bh=HulYPTH4inzvGZLBH/+5kwxtLNIM4dSrBDB6C613tnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f+fUYmDeI0jG8YWlE/Z5MUp4KfkCUu57dFjf/nZUyvw8EajZiF+i05993Ce/OetCR
         VvcYjMu+f086TODwpQsid69F7LJoKpojt7jTJm7gLpkjwtsHHwqteWmQUd1c4Bt7WZ
         93GGavMbU2rkEvFe06VdZm8qHQIqJUvnDpTvS738=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.20 036/111] crypto: bcm - convert to use crypto_authenc_extractkeys()
Date:   Mon, 21 Jan 2019 14:42:30 +0100
Message-Id: <20190121122459.861924762@linuxfoundation.org>
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

commit ab57b33525c3221afaebd391458fa0cbcd56903d upstream.

Convert the bcm crypto driver to use crypto_authenc_extractkeys() so
that it picks up the fix for broken validation of rtattr::rta_len.

This also fixes the DES weak key check to actually be done on the right
key. (It was checking the authentication key, not the encryption key...)

Fixes: 9d12ba86f818 ("crypto: brcm - Add Broadcom SPU driver")
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/Kconfig      |    1 +
 drivers/crypto/bcm/cipher.c |   44 +++++++++++++-------------------------------
 2 files changed, 14 insertions(+), 31 deletions(-)

--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -692,6 +692,7 @@ config CRYPTO_DEV_BCM_SPU
 	depends on ARCH_BCM_IPROC
 	depends on MAILBOX
 	default m
+	select CRYPTO_AUTHENC
 	select CRYPTO_DES
 	select CRYPTO_MD5
 	select CRYPTO_SHA1
--- a/drivers/crypto/bcm/cipher.c
+++ b/drivers/crypto/bcm/cipher.c
@@ -2845,44 +2845,28 @@ static int aead_authenc_setkey(struct cr
 	struct spu_hw *spu = &iproc_priv.spu;
 	struct iproc_ctx_s *ctx = crypto_aead_ctx(cipher);
 	struct crypto_tfm *tfm = crypto_aead_tfm(cipher);
-	struct rtattr *rta = (void *)key;
-	struct crypto_authenc_key_param *param;
-	const u8 *origkey = key;
-	const unsigned int origkeylen = keylen;
-
-	int ret = 0;
+	struct crypto_authenc_keys keys;
+	int ret;
 
 	flow_log("%s() aead:%p key:%p keylen:%u\n", __func__, cipher, key,
 		 keylen);
 	flow_dump("  key: ", key, keylen);
 
-	if (!RTA_OK(rta, keylen))
-		goto badkey;
-	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
+	ret = crypto_authenc_extractkeys(&keys, key, keylen);
+	if (ret)
 		goto badkey;
-	if (RTA_PAYLOAD(rta) < sizeof(*param))
-		goto badkey;
-
-	param = RTA_DATA(rta);
-	ctx->enckeylen = be32_to_cpu(param->enckeylen);
 
-	key += RTA_ALIGN(rta->rta_len);
-	keylen -= RTA_ALIGN(rta->rta_len);
-
-	if (keylen < ctx->enckeylen)
-		goto badkey;
-	if (ctx->enckeylen > MAX_KEY_SIZE)
+	if (keys.enckeylen > MAX_KEY_SIZE ||
+	    keys.authkeylen > MAX_KEY_SIZE)
 		goto badkey;
 
-	ctx->authkeylen = keylen - ctx->enckeylen;
-
-	if (ctx->authkeylen > MAX_KEY_SIZE)
-		goto badkey;
+	ctx->enckeylen = keys.enckeylen;
+	ctx->authkeylen = keys.authkeylen;
 
-	memcpy(ctx->enckey, key + ctx->authkeylen, ctx->enckeylen);
+	memcpy(ctx->enckey, keys.enckey, keys.enckeylen);
 	/* May end up padding auth key. So make sure it's zeroed. */
 	memset(ctx->authkey, 0, sizeof(ctx->authkey));
-	memcpy(ctx->authkey, key, ctx->authkeylen);
+	memcpy(ctx->authkey, keys.authkey, keys.authkeylen);
 
 	switch (ctx->alg->cipher_info.alg) {
 	case CIPHER_ALG_DES:
@@ -2890,7 +2874,7 @@ static int aead_authenc_setkey(struct cr
 			u32 tmp[DES_EXPKEY_WORDS];
 			u32 flags = CRYPTO_TFM_RES_WEAK_KEY;
 
-			if (des_ekey(tmp, key) == 0) {
+			if (des_ekey(tmp, keys.enckey) == 0) {
 				if (crypto_aead_get_flags(cipher) &
 				    CRYPTO_TFM_REQ_WEAK_KEY) {
 					crypto_aead_set_flags(cipher, flags);
@@ -2905,7 +2889,7 @@ static int aead_authenc_setkey(struct cr
 		break;
 	case CIPHER_ALG_3DES:
 		if (ctx->enckeylen == (DES_KEY_SIZE * 3)) {
-			const u32 *K = (const u32 *)key;
+			const u32 *K = (const u32 *)keys.enckey;
 			u32 flags = CRYPTO_TFM_RES_BAD_KEY_SCHED;
 
 			if (!((K[0] ^ K[2]) | (K[1] ^ K[3])) ||
@@ -2956,9 +2940,7 @@ static int aead_authenc_setkey(struct cr
 		ctx->fallback_cipher->base.crt_flags &= ~CRYPTO_TFM_REQ_MASK;
 		ctx->fallback_cipher->base.crt_flags |=
 		    tfm->crt_flags & CRYPTO_TFM_REQ_MASK;
-		ret =
-		    crypto_aead_setkey(ctx->fallback_cipher, origkey,
-				       origkeylen);
+		ret = crypto_aead_setkey(ctx->fallback_cipher, key, keylen);
 		if (ret) {
 			flow_log("  fallback setkey() returned:%d\n", ret);
 			tfm->crt_flags &= ~CRYPTO_TFM_RES_MASK;


