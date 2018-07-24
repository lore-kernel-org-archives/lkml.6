Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B351ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D64A20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S92o1ZFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D64A20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388781AbeGXR7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:59:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39465 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388619AbeGXR5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:57:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so982195pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EgkhKZ/Kq1WYLP+KKm550fKJfIA30Q04zx67UHx5CVw=;
        b=S92o1ZFwaZ2aylf4k1VTGxvWM7JZPhGcyXrz7iZHR94z/kaZL0L6kH2rRGVWrH6iju
         eUpSLl/7EISqe9730FeeGBGn7J6lWJa1DO2CrW7zgkLsAF3YR1X8Wk74laRSb+Zs4zvj
         SYx8wnid83S/p8ReZrV3kGlfr/ZxMOFmYYKnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EgkhKZ/Kq1WYLP+KKm550fKJfIA30Q04zx67UHx5CVw=;
        b=kquDSHK/MMZHBKVNRQTruaOd5xMeHckfEZ9uBfu0udKY082tATeua0bgwG+I6wBLIG
         2Hyi3X8YzfmLfbOXD9rG/LzSvemFo3rpz3ZMC7GMIJI4LjqlUaegtiM0q5S2SgWhv5g3
         XUZ2y9iwU+pc3QpYg2wK7jb2ErdjcizgGu4vVMJqqb2906vTiXkUPKV39Dwe28JKQ2wp
         IZ8sDpLoSXwCeKkMbQ75cGhEFtbJuZm8ZHyNU8xs492rMeDU/23jO1BIVLO+5P3tu/GQ
         6YFVviLeagQw2zvlQMmhK07vE7UUTQZ0DmeHASKDmd+qd+vIqmHirNltHavzI/8Mb8kr
         8P7Q==
X-Gm-Message-State: AOUpUlGbKjsgwn2PjQpIkYx9ReX+bo6ehtm1bZyn+6CnMAMjvDoJBIPI
        i0O0DHpN9IZrBlk3QXrPDUe1ew==
X-Google-Smtp-Source: AAOMgpflp49N0AC5xiB8mpCD9AbiIwFcdTzaeSIcKVrYl9oEty5XsAmRJYRzowpikmxDTVIEKkvfJg==
X-Received: by 2002:a62:9d14:: with SMTP id i20-v6mr18485201pfd.3.1532450992941;
        Tue, 24 Jul 2018 09:49:52 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a15-v6sm19835983pfe.32.2018.07.24.09.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 09:49:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Will Deacon <will.deacon@arm.com>, dm-devel@redhat.com,
        linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        qat-linux@intel.com, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-afs@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/18] ppp: mppe: Remove VLA usage
Date:   Tue, 24 Jul 2018 09:49:27 -0700
Message-Id: <20180724164936.37477-10-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724164936.37477-1-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ppp/ppp_mppe.c | 56 ++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ppp/ppp_mppe.c b/drivers/net/ppp/ppp_mppe.c
index 6c7fd98cb00a..a205750b431b 100644
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
 
@@ -246,7 +246,10 @@ static void *mppe_alloc(unsigned char *options, int optlen)
 
 out_free:
 	kfree(state->sha1_digest);
-	crypto_free_ahash(state->sha1);
+	if (state->sha1) {
+		crypto_free_shash(state->sha1->tfm);
+		kzfree(state->sha1);
+	}
 	crypto_free_skcipher(state->arc4);
 	kfree(state);
 out:
@@ -261,7 +264,8 @@ static void mppe_free(void *arg)
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

