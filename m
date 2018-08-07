Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9517C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAF821570
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fRu17USj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAF821570
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeHGXfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:35:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37417 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeHGXfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:35:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so40058pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WKSfBoqqmwqW/7rTlYhIb2ASSav+oo5lfeHmCUUrk2I=;
        b=fRu17USj+VPtv3LEav9XxzknEFCskBJejbyi2YND9LHOBQC1cXwpSyhPgP+p3zOZgW
         WtBRKFmxTa4aGNJ9jKD7ItSWb6JKRGET9Pj++1oyH52TfO4HmQDANXNaN/gwXx8xahGX
         PWyhfcS99/Lh9FNkIh3SwqPAw+kR0t4yWDhEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WKSfBoqqmwqW/7rTlYhIb2ASSav+oo5lfeHmCUUrk2I=;
        b=ntFUYA1/CFzmd4ZkmSbkYvrnxc490g/d9rhyK0fw+nHerTULHrQjdOrWFFszMFTBAt
         3G3FyXCL06zKxmXirJRBnmf9c4aW0Z/q3ejOl7tSd4TFrLVrxnXtZKZfF/z4JnI9NBkh
         doQsj4uoGMxPCOZXt4wXfDSd/j16BLgmh5XTPIc3bBe5Q1oknqlybxrabpViiaMQM2Ze
         QxB4OFU9NAXdJ7hKFZqdAZSClwdxoWfD1oC6VLFAvQSuC2CHcjmamojkfrUZwtbxMygo
         epjo5K1HZImLMznD/QGEOap8Por2/HVejxTZZ02iPOTgc1WCm4mybfcujORcYVIewsH7
         zVug==
X-Gm-Message-State: AOUpUlGK324b5JalYRwyiv7sbGUKS8Bitd9CMcN3ggQa9Gpmqpmtq+dC
        V0gdw+kt9ZWVfLx5/IuTojf6kQ==
X-Google-Smtp-Source: AA+uWPyHehl2hGoOqA0NWSj3PgQvPdIYNMCpQkqgxVJpWVT0az2tRwqOzKUVxoyM+WRdlZ/GHZmZsw==
X-Received: by 2002:a63:3444:: with SMTP id b65-v6mr74051pga.396.1533676730942;
        Tue, 07 Aug 2018 14:18:50 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s66-v6sm2342549pgc.67.2018.08.07.14.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 14:18:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        qat-linux@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/9] crypto: cbc: Remove VLA usage
Date:   Tue,  7 Aug 2018 14:18:36 -0700
Message-Id: <20180807211843.47586-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180807211843.47586-1-keescook@chromium.org>
References: <20180807211843.47586-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
uses the upper bounds on blocksize. Since this is always a cipher
blocksize, use the existing cipher max blocksize.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/cbc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/crypto/cbc.h b/include/crypto/cbc.h
index f5b8bfc22e6d..3bf28beefa33 100644
--- a/include/crypto/cbc.h
+++ b/include/crypto/cbc.h
@@ -113,7 +113,7 @@ static inline int crypto_cbc_decrypt_inplace(
 	unsigned int bsize = crypto_skcipher_blocksize(tfm);
 	unsigned int nbytes = walk->nbytes;
 	u8 *src = walk->src.virt.addr;
-	u8 last_iv[bsize];
+	u8 last_iv[MAX_CIPHER_BLOCKSIZE];
 
 	/* Start of the last block. */
 	src += nbytes - (nbytes & (bsize - 1)) - bsize;
-- 
2.17.1

