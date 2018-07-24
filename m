Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1841AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C383E20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KUe+Ljla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C383E20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbeGXSA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:00:26 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46011 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388442AbeGXR5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:57:05 -0400
Received: by mail-pl0-f68.google.com with SMTP id j8-v6so1955675pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4w4IN2J6dONrrlVeO1+L0Kz9qBIwIaC7ttYkBFQeQFw=;
        b=KUe+LjlaQlS1O5ciNkx+mQgwWTRmPZ13UHy/USQfoyc0dAXMTwzk2Xx6qUc7AlF0O2
         QiGXnGLkJwj+BaRXaUO015beIxRmiskoZ3V8mMejwoG8eJCaOM0zKqmuuA0SSSqaghC0
         k1TppukdfSo15YKpxR2HelnJKmM6fpiatM8sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4w4IN2J6dONrrlVeO1+L0Kz9qBIwIaC7ttYkBFQeQFw=;
        b=a/SOifGY3exHRBPGfn0kto88wH7djmPVjmW2o9lfX+jGeqbk63Bf/0/t8xEB/OCUrO
         2OEFSXYXvsz8Kcaj7kScc6q9xGyGx6FUYudttrCM8DeZZDnvWQqSZ8POEM058hyJZAPI
         +dVUI1TYodtxK2isEXtGmlu2LHtC6wOjvESEnEbWw/dAEIfJcuAPUliFfG344gmrjVKJ
         hblE/GVjGjDOVB8zeFRvyXs+D6kXdX8OO1Sozq51qoY/frFowjFVntjIP31qjgMJHHhe
         a5GhC9KlNsxV6ksZAt4/9HkbTmTaBgfOqxJHXUD/RaYxIAwLMXHU/sS5y5jm/jL9Tge7
         8MbQ==
X-Gm-Message-State: AOUpUlErcDslcHNGyimD9CFm1uevRLm+xmu6KaQCRa9gwdLmX3/wQ++G
        wrF+BrnCb9uCwMx0xIWFHZ5XMg==
X-Google-Smtp-Source: AAOMgpc3bGW4E04kHUgFezSeoq8fvmHs03wRkMlKKtoD4yLsHExUpfOH9KDFmVzDOLA8REAbdGIg7g==
X-Received: by 2002:a17:902:4203:: with SMTP id g3-v6mr17515330pld.315.1532450984795;
        Tue, 24 Jul 2018 09:49:44 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id w13-v6sm2179184pgs.89.2018.07.24.09.49.42
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
Subject: [PATCH v6 01/18] crypto: xcbc: Remove VLA usage
Date:   Tue, 24 Jul 2018 09:49:19 -0700
Message-Id: <20180724164936.37477-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724164936.37477-1-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this uses
the maximum blocksize and adds a sanity check. For xcbc, the blocksize
must always be 16, so use that, since it's already being enforced during
instantiation.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/xcbc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/crypto/xcbc.c b/crypto/xcbc.c
index 25c75af50d3f..c055f57fab11 100644
--- a/crypto/xcbc.c
+++ b/crypto/xcbc.c
@@ -57,15 +57,17 @@ struct xcbc_desc_ctx {
 	u8 ctx[];
 };
 
+#define XCBC_BLOCKSIZE	16
+
 static int crypto_xcbc_digest_setkey(struct crypto_shash *parent,
 				     const u8 *inkey, unsigned int keylen)
 {
 	unsigned long alignmask = crypto_shash_alignmask(parent);
 	struct xcbc_tfm_ctx *ctx = crypto_shash_ctx(parent);
-	int bs = crypto_shash_blocksize(parent);
 	u8 *consts = PTR_ALIGN(&ctx->ctx[0], alignmask + 1);
 	int err = 0;
-	u8 key1[bs];
+	u8 key1[XCBC_BLOCKSIZE];
+	int bs = sizeof(key1);
 
 	if ((err = crypto_cipher_setkey(ctx->child, inkey, keylen)))
 		return err;
@@ -212,7 +214,7 @@ static int xcbc_create(struct crypto_template *tmpl, struct rtattr **tb)
 		return PTR_ERR(alg);
 
 	switch(alg->cra_blocksize) {
-	case 16:
+	case XCBC_BLOCKSIZE:
 		break;
 	default:
 		goto out_put_alg;
-- 
2.17.1

