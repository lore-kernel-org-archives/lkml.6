Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950F5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F34120863
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gt9amS7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F34120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeGPEal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:30:41 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34260 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeGPEal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:30:41 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so762027plo.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 21:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=94OCNqqWugzVJxpST/Zwo8uHdsOb7WyL9gCTjJDlFfs=;
        b=gt9amS7RhFi/cb2E2p3iQtMSxWndiJofMFYkNzLMmaWV1iBCWPpMgcay6Nq9/+vIKS
         V03PoWdvFYaoy5caMBCXgG5pwnVao+McMPsGmaziKdZVVoAdRWZ0RUw7kwireUO6ZNXw
         Dtgn5mQXaDRxsUPemOL8gp5NtdB/+o2WwSb+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=94OCNqqWugzVJxpST/Zwo8uHdsOb7WyL9gCTjJDlFfs=;
        b=aEqq8ZeNJ9YBj1BYW6qkDsM6pxy4H6km9zkDtEJKbroy4tj3dwT/8N7nDcPvHQc5b8
         1I3JZYXK52YEP+KIAetzrpGSSgnNzcsINbEsxVj2GnHya8c7ACwITzTzHGio7vbd8XvM
         neDDFK6g76hvmdDmZ0OA81yHkrG2jLGmh8EO0mcSHLjYp5q14w0slza9lB1F/y/rnZcb
         aCmlZDPmqUFJxSXFzOft+7BJWooAPBOaV6JMlXA4qigpoqwhJTAI2KLxczgByxI+BG9y
         wRbqRp8nWCthrdh6nd0KnWotZizKU769J7yEDVM/hPfnZPaRVTEtTwt4SkOzUzatQ/Mg
         p2fA==
X-Gm-Message-State: AOUpUlHnWiIC9DXNqiILLkIYEKKzKqW4w3BpzSZnmK0hhkzn7zIYv7eG
        gm51segbA+xBMPqlfve7pxxv0Q==
X-Google-Smtp-Source: AAOMgpcubOW5XZ5LY8Yl52Jl08E1aP+cuUkaY6YJ6KTtrMc7d3Eb9BHAyyCriCyuBdS0uaDwTiPqEQ==
X-Received: by 2002:a17:902:e209:: with SMTP id ce9-v6mr15015180plb.233.1531713918544;
        Sun, 15 Jul 2018 21:05:18 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x87-v6sm48308410pfa.143.2018.07.15.21.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 21:05:17 -0700 (PDT)
Date:   Sun, 15 Jul 2018 21:05:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ppp: mppe: Remove VLA usage
Message-ID: <20180716040516.GA32783@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
removes the discouraged use of AHASH_REQUEST_ON_STACK (and associated
VLA) by switching to shash directly and keeping the associated descriptor
allocated with the regular state on the heap.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ppp/ppp_mppe.c | 57 +++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ppp/ppp_mppe.c b/drivers/net/ppp/ppp_mppe.c
index 6c7fd98cb00a..5b4b81027a75 100644
--- a/drivers/net/ppp/ppp_mppe.c
+++ b/drivers/net/ppp/ppp_mppe.c
@@ -96,7 +96,7 @@ static inline void sha_pad_init(struct sha_pad *shapad)
  */
 struct ppp_mppe_state {
 	struct crypto_skcipher *arc4;
-	struct crypto_ahash *sha1;
+	struct shash_desc *sha1;
 	unsigned char *sha1_digest;
 	unsigned char master_key[MPPE_MAX_KEY_LEN];
 	unsigned char session_key[MPPE_MAX_KEY_LEN];
@@ -136,25 +136,16 @@ struct ppp_mppe_state {
  */
 static void get_new_key_from_sha(struct ppp_mppe_state * state)
 {
-	AHASH_REQUEST_ON_STACK(req, state->sha1);
-	struct scatterlist sg[4];
-	unsigned int nbytes;
-
-	sg_init_table(sg, 4);
-
-	nbytes = setup_sg(&sg[0], state->master_key, state->keylen);
-	nbytes += setup_sg(&sg[1], sha_pad->sha_pad1,
-			   sizeof(sha_pad->sha_pad1));
-	nbytes += setup_sg(&sg[2], state->session_key, state->keylen);
-	nbytes += setup_sg(&sg[3], sha_pad->sha_pad2,
-			   sizeof(sha_pad->sha_pad2));
-
-	ahash_request_set_tfm(req, state->sha1);
-	ahash_request_set_callback(req, 0, NULL, NULL);
-	ahash_request_set_crypt(req, sg, state->sha1_digest, nbytes);
-
-	crypto_ahash_digest(req);
-	ahash_request_zero(req);
+	crypto_shash_init(state->sha1);
+	crypto_shash_update(state->sha1, state->master_key,
+			    state->keylen);
+	crypto_shash_update(state->sha1, sha_pad->sha_pad1,
+			    sizeof(sha_pad->sha_pad1));
+	crypto_shash_update(state->sha1, state->session_key,
+			    state->keylen);
+	crypto_shash_update(state->sha1, sha_pad->sha_pad2,
+			    sizeof(sha_pad->sha_pad2));
+	crypto_shash_final(state->sha1, state->sha1_digest);
 }
 
 /*
@@ -200,6 +191,7 @@ static void mppe_rekey(struct ppp_mppe_state * state, int initial_key)
 static void *mppe_alloc(unsigned char *options, int optlen)
 {
 	struct ppp_mppe_state *state;
+	struct crypto_shash *shash;
 	unsigned int digestsize;
 
 	if (optlen != CILEN_MPPE + sizeof(state->master_key) ||
@@ -217,13 +209,21 @@ static void *mppe_alloc(unsigned char *options, int optlen)
 		goto out_free;
 	}
 
-	state->sha1 = crypto_alloc_ahash("sha1", 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(state->sha1)) {
-		state->sha1 = NULL;
+	shash = crypto_alloc_shash("sha1", 0, 0);
+	if (IS_ERR(shash))
+		goto out_free;
+
+	state->sha1 = kmalloc(sizeof(*state->sha1) +
+				     crypto_shash_descsize(shash),
+			      GFP_KERNEL);
+	if (!state->sha1) {
+		crypto_free_shash(shash);
 		goto out_free;
 	}
+	state->sha1->tfm = shash;
+	state->sha1->flags = 0;
 
-	digestsize = crypto_ahash_digestsize(state->sha1);
+	digestsize = crypto_shash_digestsize(shash);
 	if (digestsize < MPPE_MAX_KEY_LEN)
 		goto out_free;
 
@@ -246,7 +246,11 @@ static void *mppe_alloc(unsigned char *options, int optlen)
 
 out_free:
 	kfree(state->sha1_digest);
-	crypto_free_ahash(state->sha1);
+	if (state->sha1) {
+		if (state->sha1->tfm)
+			crypto_free_shash(state->sha1->tfm);
+		kzfree(state->sha1);
+	}
 	crypto_free_skcipher(state->arc4);
 	kfree(state);
 out:
@@ -261,7 +265,8 @@ static void mppe_free(void *arg)
 	struct ppp_mppe_state *state = (struct ppp_mppe_state *) arg;
 	if (state) {
 		kfree(state->sha1_digest);
-		crypto_free_ahash(state->sha1);
+		crypto_free_shash(state->sha1->tfm);
+		kzfree(state->sha1);
 		crypto_free_skcipher(state->arc4);
 		kfree(state);
 	}
-- 
2.17.1


-- 
Kees Cook
Pixel Security
