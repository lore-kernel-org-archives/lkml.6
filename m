Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4053BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56F3214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O8pCFocv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56F3214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbeISHrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:47:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35266 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730927AbeISHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:46:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2-v6so1871638plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6R0mVhvKUSsGeG0bPrwWPq0HZqtET19tYibHdYTKJoo=;
        b=O8pCFocvtffRHZ/uoRO7aBNC7X+jZOVPyvSd6lewteWZ1LPqWcEDmEpLHd/VhddvUA
         17ZQidvlB9IC8VFZdEry3JsrLEM0T93IpTs6GqL21fk4ig8UIai1B7fsYtoXoJVt9/N7
         ZsbFoYp/QFVtk6B9V8ElhaCZgkNscNBKWDnoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6R0mVhvKUSsGeG0bPrwWPq0HZqtET19tYibHdYTKJoo=;
        b=Be2/GY4LseP0BZkPZiNlUPfwW3/jz7T4aPN1YVzPff1d11KZfkbiU5G08LUh1Ri4mZ
         3a9Vn/KD3fJhpx/N9SEveacXPl0+KOUhOid08Tg049TQUBtb+jrmVQqcxL1DFKCrml0u
         d3blZsXkMTt/qSHcxyPLieUSnSfyJ/zD9/Ux7jjBynPFxxjtUQadSsDX+ngs8n0Op4J0
         3jBf2DNqcgP6rHFcTWlMQu3Ysok4RfuCNJSnpXdrmkrS6PUOb001FelTu0G5WNhkg4Yc
         x9O1seZCpDz0uCJ3D9q2x+rEIX6Yk9hmFO3K6neAtMxvDxHWZZjNy81RD3cK1L5sRjcv
         rXgg==
X-Gm-Message-State: APzg51BPom1vyMx37iakDlKuFmc+Hny46raDB+XU3AMAAb4+vYf5zguD
        Pgybc+qcYTRHw3bfHrvWDIrLpg==
X-Google-Smtp-Source: ANB0Vdb/1NNTY4XmDVNOZnAe5ipfy62vN6Unfn0E81dPWCaTxQXLk6oTdGcpWFDb60+W55v8y89VZA==
X-Received: by 2002:a17:902:a983:: with SMTP id bh3-v6mr31481010plb.245.1537323075219;
        Tue, 18 Sep 2018 19:11:15 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id o3-v6sm21387459pgv.53.2018.09.18.19.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:11:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 09/23] ppp: mppe: Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:46 -0700
Message-Id: <20180919021100.3380-10-keescook@chromium.org>
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

Cc: Paul Mackerras <paulus@samba.org>
Cc: linux-ppp@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ppp/ppp_mppe.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ppp/ppp_mppe.c b/drivers/net/ppp/ppp_mppe.c
index a205750b431b..7ccdc62c6052 100644
--- a/drivers/net/ppp/ppp_mppe.c
+++ b/drivers/net/ppp/ppp_mppe.c
@@ -95,7 +95,7 @@ static inline void sha_pad_init(struct sha_pad *shapad)
  * State for an MPPE (de)compressor.
  */
 struct ppp_mppe_state {
-	struct crypto_skcipher *arc4;
+	struct crypto_sync_skcipher *arc4;
 	struct shash_desc *sha1;
 	unsigned char *sha1_digest;
 	unsigned char master_key[MPPE_MAX_KEY_LEN];
@@ -155,15 +155,15 @@ static void get_new_key_from_sha(struct ppp_mppe_state * state)
 static void mppe_rekey(struct ppp_mppe_state * state, int initial_key)
 {
 	struct scatterlist sg_in[1], sg_out[1];
-	SKCIPHER_REQUEST_ON_STACK(req, state->arc4);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, state->arc4);
 
-	skcipher_request_set_tfm(req, state->arc4);
+	skcipher_request_set_sync_tfm(req, state->arc4);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 
 	get_new_key_from_sha(state);
 	if (!initial_key) {
-		crypto_skcipher_setkey(state->arc4, state->sha1_digest,
-				       state->keylen);
+		crypto_sync_skcipher_setkey(state->arc4, state->sha1_digest,
+					    state->keylen);
 		sg_init_table(sg_in, 1);
 		sg_init_table(sg_out, 1);
 		setup_sg(sg_in, state->sha1_digest, state->keylen);
@@ -181,7 +181,8 @@ static void mppe_rekey(struct ppp_mppe_state * state, int initial_key)
 		state->session_key[1] = 0x26;
 		state->session_key[2] = 0x9e;
 	}
-	crypto_skcipher_setkey(state->arc4, state->session_key, state->keylen);
+	crypto_sync_skcipher_setkey(state->arc4, state->session_key,
+				    state->keylen);
 	skcipher_request_zero(req);
 }
 
@@ -203,7 +204,7 @@ static void *mppe_alloc(unsigned char *options, int optlen)
 		goto out;
 
 
-	state->arc4 = crypto_alloc_skcipher("ecb(arc4)", 0, CRYPTO_ALG_ASYNC);
+	state->arc4 = crypto_alloc_sync_skcipher("ecb(arc4)", 0, 0);
 	if (IS_ERR(state->arc4)) {
 		state->arc4 = NULL;
 		goto out_free;
@@ -250,7 +251,7 @@ static void *mppe_alloc(unsigned char *options, int optlen)
 		crypto_free_shash(state->sha1->tfm);
 		kzfree(state->sha1);
 	}
-	crypto_free_skcipher(state->arc4);
+	crypto_free_sync_skcipher(state->arc4);
 	kfree(state);
 out:
 	return NULL;
@@ -266,7 +267,7 @@ static void mppe_free(void *arg)
 		kfree(state->sha1_digest);
 		crypto_free_shash(state->sha1->tfm);
 		kzfree(state->sha1);
-		crypto_free_skcipher(state->arc4);
+		crypto_free_sync_skcipher(state->arc4);
 		kfree(state);
 	}
 }
@@ -366,7 +367,7 @@ mppe_compress(void *arg, unsigned char *ibuf, unsigned char *obuf,
 	      int isize, int osize)
 {
 	struct ppp_mppe_state *state = (struct ppp_mppe_state *) arg;
-	SKCIPHER_REQUEST_ON_STACK(req, state->arc4);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, state->arc4);
 	int proto;
 	int err;
 	struct scatterlist sg_in[1], sg_out[1];
@@ -426,7 +427,7 @@ mppe_compress(void *arg, unsigned char *ibuf, unsigned char *obuf,
 	setup_sg(sg_in, ibuf, isize);
 	setup_sg(sg_out, obuf, osize);
 
-	skcipher_request_set_tfm(req, state->arc4);
+	skcipher_request_set_sync_tfm(req, state->arc4);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, sg_in, sg_out, isize, NULL);
 	err = crypto_skcipher_encrypt(req);
@@ -480,7 +481,7 @@ mppe_decompress(void *arg, unsigned char *ibuf, int isize, unsigned char *obuf,
 		int osize)
 {
 	struct ppp_mppe_state *state = (struct ppp_mppe_state *) arg;
-	SKCIPHER_REQUEST_ON_STACK(req, state->arc4);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, state->arc4);
 	unsigned ccount;
 	int flushed = MPPE_BITS(ibuf) & MPPE_BIT_FLUSHED;
 	struct scatterlist sg_in[1], sg_out[1];
@@ -615,7 +616,7 @@ mppe_decompress(void *arg, unsigned char *ibuf, int isize, unsigned char *obuf,
 	setup_sg(sg_in, ibuf, 1);
 	setup_sg(sg_out, obuf, 1);
 
-	skcipher_request_set_tfm(req, state->arc4);
+	skcipher_request_set_sync_tfm(req, state->arc4);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, sg_in, sg_out, 1, NULL);
 	if (crypto_skcipher_decrypt(req)) {
-- 
2.17.1

