Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCBFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0597520875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i7l2V203"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0597520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388853AbeGXR76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:59:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40412 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388491AbeGXR5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:57:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so3302111pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f6HZhbULuwp1ONQvXFzzLM5M+BCFj7xnBsodxU5HF/8=;
        b=i7l2V203iKO8F/E1rGfCAs1SmGDKSVgLOuC6p+RiEiDgghBwCioOqiOcdEbp1aHC9f
         e6E6bHThzZU1dXEL1sm1DF7zeY93yBoPuosS3Mymf9SAr3A3Djv7LI0z58EkpO4TUuZ6
         YMvIdf+Z7RpBLlMAtFtbpLycMkcbWFlit3mlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f6HZhbULuwp1ONQvXFzzLM5M+BCFj7xnBsodxU5HF/8=;
        b=lZeRbXpLn32zlRvgtbEU4nw2zoRuG7ObbhfqxGbyyXNwx7WOBFwwxn2BXfPQ3k8Ojm
         s86TT/KMIhbSqasOR6Qawlet7yYrx/JheKrbXxQXLC3Hg1rWALXGW46jg583xD6cG6vV
         RWB7TTwtcAQJEHTR53uENfUVqyZiF54zivyEDYBiiC/YYgBaxqn3N/UR2fsBD9O7khwR
         UJ/SZHv7YaX2az44L9aR3WTch1WmZdUwfTn9GnEOvGnJjQ6nMyw0M/oCQp+VgTJRJMnr
         sN6Wx4LqfgdkY68A0R7jx17e1keOXqKvMGgAMzVg+R5LhjkflNNoEoGCAnP3H6IJtYCu
         VhUg==
X-Gm-Message-State: AOUpUlGaOObWFRL2U+0lrdCeUPMjZV18AFj+LmoGHf9/4WPiV37MB9cN
        tTpjSLus3/+AGhjCaizLjqZhiA==
X-Google-Smtp-Source: AAOMgpcRHY0TUWqYeFkhwRK2msJqumUjSrqUTZ6koIWFJUTWdXija+ayMyvvMOlWcFlaoGFkJ+e9Lw==
X-Received: by 2002:a65:57c9:: with SMTP id q9-v6mr17291413pgr.128.1532450985634;
        Tue, 24 Jul 2018 09:49:45 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id l85-v6sm21610692pfk.34.2018.07.24.09.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 09:49:42 -0700 (PDT)
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
Subject: [PATCH v6 03/18] crypto: hash: Remove VLA usage
Date:   Tue, 24 Jul 2018 09:49:21 -0700
Message-Id: <20180724164936.37477-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724164936.37477-1-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
removes the VLAs in SHASH_DESC_ON_STACK (via crypto_shash_descsize())
by using the maximum allowable size (which is now more clearly captured
in a macro), along with a few other cases. Similar limits are turned into
macros as well.

A review of existing sizes shows that SHA512_DIGEST_SIZE (64) is the
largest digest size and that sizeof(struct sha3_state) (360) is the
largest descriptor size. The corresponding maximums are reduced.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/ahash.c        | 4 ++--
 crypto/algif_hash.c   | 2 +-
 crypto/shash.c        | 6 +++---
 include/crypto/hash.h | 6 +++++-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index a64c143165b1..78aaf2158c43 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -550,8 +550,8 @@ static int ahash_prepare_alg(struct ahash_alg *alg)
 {
 	struct crypto_alg *base = &alg->halg.base;
 
-	if (alg->halg.digestsize > PAGE_SIZE / 8 ||
-	    alg->halg.statesize > PAGE_SIZE / 8 ||
+	if (alg->halg.digestsize > HASH_MAX_DIGESTSIZE ||
+	    alg->halg.statesize > HASH_MAX_STATESIZE ||
 	    alg->halg.statesize == 0)
 		return -EINVAL;
 
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index bfcf595fd8f9..d0cde541beb6 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -239,7 +239,7 @@ static int hash_accept(struct socket *sock, struct socket *newsock, int flags,
 	struct alg_sock *ask = alg_sk(sk);
 	struct hash_ctx *ctx = ask->private;
 	struct ahash_request *req = &ctx->req;
-	char state[crypto_ahash_statesize(crypto_ahash_reqtfm(req)) ? : 1];
+	char state[HASH_MAX_STATESIZE];
 	struct sock *sk2;
 	struct alg_sock *ask2;
 	struct hash_ctx *ctx2;
diff --git a/crypto/shash.c b/crypto/shash.c
index 5d732c6bb4b2..86d76b5c626c 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -458,9 +458,9 @@ static int shash_prepare_alg(struct shash_alg *alg)
 {
 	struct crypto_alg *base = &alg->base;
 
-	if (alg->digestsize > PAGE_SIZE / 8 ||
-	    alg->descsize > PAGE_SIZE / 8 ||
-	    alg->statesize > PAGE_SIZE / 8)
+	if (alg->digestsize > HASH_MAX_DIGESTSIZE ||
+	    alg->descsize > HASH_MAX_DESCSIZE ||
+	    alg->statesize > HASH_MAX_STATESIZE)
 		return -EINVAL;
 
 	base->cra_type = &crypto_shash_type;
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 76e432cab75d..21587011ab0f 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -151,9 +151,13 @@ struct shash_desc {
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
+#define HASH_MAX_DIGESTSIZE	 64
+#define HASH_MAX_DESCSIZE	360
+#define HASH_MAX_STATESIZE	512
+
 #define SHASH_DESC_ON_STACK(shash, ctx)				  \
 	char __##shash##_desc[sizeof(struct shash_desc) +	  \
-		crypto_shash_descsize(ctx)] CRYPTO_MINALIGN_ATTR; \
+		HASH_MAX_DESCSIZE] CRYPTO_MINALIGN_ATTR; \
 	struct shash_desc *shash = (struct shash_desc *)__##shash##_desc
 
 /**
-- 
2.17.1

