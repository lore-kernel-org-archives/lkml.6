Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9C1ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9285214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VRG0Tin3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9285214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbeISHqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:46:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41789 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730826AbeISHqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:46:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id s15-v6so1938111pgv.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jrF8nV3VTb4xUBtXcPPmVV0+A80GarPW4EVJzK2YYBE=;
        b=VRG0Tin3A6hlvBN9P8akr2iyKytS49u9Tmznt5hGIQNbuUQ4t+SjlrcHsDm+FhHFA6
         l25wGI3JlIjfWLkNBd3iVW+eLt3eh/bAuMQu/T0aPpVOWNmLljxMAkVmsFSB+ew/+/Yh
         j6xdIhfEU8svuGdr3BEmILorJGSHP45hwihj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jrF8nV3VTb4xUBtXcPPmVV0+A80GarPW4EVJzK2YYBE=;
        b=EuEj3QRTAN1NpNFlAZCxK85E1Q7Fpq6DUqpFNlSwW86A2INeNjge0cylPg99ITzPnM
         EF57OCWETPBXvTHj6wRZUh86gR+z5rew7sgLLiad/EIGkl+VUuUSJgWGbQqZFn8ekTGG
         Y8v5lncYf4CE8RQrzUuHq4XcYvogeJORkuvo+GBh+VULzw1smY3Ys0uUgOhICpROYdek
         C3qvRsEHjxRJzWfYboRmmaPoqVepcjVzBQUXr6LoNhTqXHVwKJhpXinnXU4IlWSzTZnl
         dfE+STcfjPPRkhePzndNqr64p2pIl0HzoM3h4KssH2GJBDco5JK3+hnpcqjqibfnYcuZ
         /QcA==
X-Gm-Message-State: APzg51BMsh+zYabZaUZBB35bA2j7mTQGdTfeyIPeHALfEiUHdFc59vXD
        vbCWWtPXEwhQND00YP79M7/nqA==
X-Google-Smtp-Source: ANB0VdYJSFlprsXPRzu8VXhLB1BbQ1LC3NBLBEL+ZpH0PdHzaRPy0OWsdSHZwA3qv950xxR6zyyjxA==
X-Received: by 2002:a63:4c54:: with SMTP id m20-v6mr27644198pgl.292.1537323068385;
        Tue, 18 Sep 2018 19:11:08 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a15-v6sm31214326pfe.32.2018.09.18.19.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:11:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH crypto-next 04/23] mac802154: Remove VLA usage of skcipher
Date:   Tue, 18 Sep 2018 19:10:41 -0700
Message-Id: <20180919021100.3380-5-keescook@chromium.org>
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

Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/mac802154/llsec.c | 16 ++++++++--------
 net/mac802154/llsec.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 2fb703d70803..7e29f88dbf6a 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -146,18 +146,18 @@ llsec_key_alloc(const struct ieee802154_llsec_key *template)
 			goto err_tfm;
 	}
 
-	key->tfm0 = crypto_alloc_skcipher("ctr(aes)", 0, CRYPTO_ALG_ASYNC);
+	key->tfm0 = crypto_alloc_sync_skcipher("ctr(aes)", 0, 0);
 	if (IS_ERR(key->tfm0))
 		goto err_tfm;
 
-	if (crypto_skcipher_setkey(key->tfm0, template->key,
+	if (crypto_sync_skcipher_setkey(key->tfm0, template->key,
 				   IEEE802154_LLSEC_KEY_SIZE))
 		goto err_tfm0;
 
 	return key;
 
 err_tfm0:
-	crypto_free_skcipher(key->tfm0);
+	crypto_free_sync_skcipher(key->tfm0);
 err_tfm:
 	for (i = 0; i < ARRAY_SIZE(key->tfm); i++)
 		if (key->tfm[i])
@@ -177,7 +177,7 @@ static void llsec_key_release(struct kref *ref)
 	for (i = 0; i < ARRAY_SIZE(key->tfm); i++)
 		crypto_free_aead(key->tfm[i]);
 
-	crypto_free_skcipher(key->tfm0);
+	crypto_free_sync_skcipher(key->tfm0);
 	kzfree(key);
 }
 
@@ -622,7 +622,7 @@ llsec_do_encrypt_unauth(struct sk_buff *skb, const struct mac802154_llsec *sec,
 {
 	u8 iv[16];
 	struct scatterlist src;
-	SKCIPHER_REQUEST_ON_STACK(req, key->tfm0);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, key->tfm0);
 	int err, datalen;
 	unsigned char *data;
 
@@ -632,7 +632,7 @@ llsec_do_encrypt_unauth(struct sk_buff *skb, const struct mac802154_llsec *sec,
 	datalen = skb_tail_pointer(skb) - data;
 	sg_init_one(&src, data, datalen);
 
-	skcipher_request_set_tfm(req, key->tfm0);
+	skcipher_request_set_sync_tfm(req, key->tfm0);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, &src, &src, datalen, iv);
 	err = crypto_skcipher_encrypt(req);
@@ -840,7 +840,7 @@ llsec_do_decrypt_unauth(struct sk_buff *skb, const struct mac802154_llsec *sec,
 	unsigned char *data;
 	int datalen;
 	struct scatterlist src;
-	SKCIPHER_REQUEST_ON_STACK(req, key->tfm0);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, key->tfm0);
 	int err;
 
 	llsec_geniv(iv, dev_addr, &hdr->sec);
@@ -849,7 +849,7 @@ llsec_do_decrypt_unauth(struct sk_buff *skb, const struct mac802154_llsec *sec,
 
 	sg_init_one(&src, data, datalen);
 
-	skcipher_request_set_tfm(req, key->tfm0);
+	skcipher_request_set_sync_tfm(req, key->tfm0);
 	skcipher_request_set_callback(req, 0, NULL, NULL);
 	skcipher_request_set_crypt(req, &src, &src, datalen, iv);
 
diff --git a/net/mac802154/llsec.h b/net/mac802154/llsec.h
index 6f3b658e3279..8be46d74dc39 100644
--- a/net/mac802154/llsec.h
+++ b/net/mac802154/llsec.h
@@ -29,7 +29,7 @@ struct mac802154_llsec_key {
 
 	/* one tfm for each authsize (4/8/16) */
 	struct crypto_aead *tfm[3];
-	struct crypto_skcipher *tfm0;
+	struct crypto_sync_skcipher *tfm0;
 
 	struct kref ref;
 };
-- 
2.17.1

