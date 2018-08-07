Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71632C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3CD21570
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bwj5h6LG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3CD21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeHGXfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:35:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41537 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbeHGXfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:35:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so31290pgu.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BYgigRdBSanSiafl9f2cJhj28CjRYh2SZJXlKmlCU5M=;
        b=bwj5h6LGT5ACmPMZYi0LG2N5D3F3SAfB8C3avF/CBbiNS2h591ypLOSakoTAgXKWvx
         +KgSLVleYXJfmoNPYhoNW5ZtD3uU9iNTmljRuHQ4YceMx9t9s5sj7k1Gf13Dev+AhMkp
         RJ4rdVkBDipUY4OISqzdenyjqwZzZ5r2punaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BYgigRdBSanSiafl9f2cJhj28CjRYh2SZJXlKmlCU5M=;
        b=C3ez/Vs4Uc09BTYKNgLr0ysV9sq91KCSq3GbKPiqxWqZ3M1TsIb/HrNIUcSGnDtgQq
         +m398kzvvKE+vU8GnqVYLozQYNvAMGApv1YOyWLwYwiZ3kWVhl9O/Z0l/DjZDvKgVzvi
         Jsfd8L2VzFf5nG635+43eZZbPQZh9pOaqnMCnKDo9b53P7Z4EivEKbuu7508Pc1xwTut
         yAu8NKDCt8RCBIsBWf9Mx19As5eAGOz1GthP7OLJVuVqEJTf86mrbEmqNlPVVFHWUImi
         Z82klr3kZsz929yNoqplxGHiUgaO2pEUdfGr9XeAP3CvCvHmlFukaT+n69A+DT239F48
         b4dg==
X-Gm-Message-State: AOUpUlFRxMa4r0NcZVjbmVIW7NcJVbM2Wxhser8GrLh2dVPtCjdhcJtd
        AOP+aLkkgmK76VE9Q93tYXVs1w==
X-Google-Smtp-Source: AA+uWPzWrOD4jORAMy82cXxo0SdYwj2E6H6kKBNGSN37J9htUZlVJoc9NYofkG3pnVQH2YMRywv3ng==
X-Received: by 2002:a62:864a:: with SMTP id x71-v6mr81675pfd.252.1533676734090;
        Tue, 07 Aug 2018 14:18:54 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id g2-v6sm3688232pfb.79.2018.08.07.14.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 14:18:51 -0700 (PDT)
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
Subject: [PATCH v8 7/9] crypto: qat: Remove VLA usage
Date:   Tue,  7 Aug 2018 14:18:41 -0700
Message-Id: <20180807211843.47586-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180807211843.47586-1-keescook@chromium.org>
References: <20180807211843.47586-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this uses
the new upper bound for the stack buffer. Also adds a sanity check.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/crypto/qat/qat_common/qat_algs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index 1138e41d6805..a28edf7b792f 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -153,8 +153,8 @@ static int qat_alg_do_precomputes(struct icp_qat_hw_auth_algo_blk *hash,
 	struct sha512_state sha512;
 	int block_size = crypto_shash_blocksize(ctx->hash_tfm);
 	int digest_size = crypto_shash_digestsize(ctx->hash_tfm);
-	char ipad[block_size];
-	char opad[block_size];
+	char ipad[MAX_ALGAPI_BLOCKSIZE];
+	char opad[MAX_ALGAPI_BLOCKSIZE];
 	__be32 *hash_state_out;
 	__be64 *hash512_state_out;
 	int i, offset;
@@ -164,6 +164,10 @@ static int qat_alg_do_precomputes(struct icp_qat_hw_auth_algo_blk *hash,
 	shash->tfm = ctx->hash_tfm;
 	shash->flags = 0x0;
 
+	if (WARN_ON(block_size > sizeof(ipad) ||
+		    sizeof(ipad) != sizeof(opad)))
+		return -EINVAL;
+
 	if (auth_keylen > block_size) {
 		int ret = crypto_shash_digest(shash, auth_key,
 					      auth_keylen, ipad);
-- 
2.17.1

