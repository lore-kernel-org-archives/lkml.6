Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B1CC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E56D215F1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g5V/+UNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E56D215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeHGXfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:35:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38493 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHGXfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:35:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3-v6so38229pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4w4IN2J6dONrrlVeO1+L0Kz9qBIwIaC7ttYkBFQeQFw=;
        b=g5V/+UNGYEfT8p5zd7CvV11zi8FsLPtOPGoByy0g0pK9yXQXBq6BBwKQ/BitwRJ/Kx
         NtQyPpWFPVCZBQdL7upAG2e+jOOdzhKhQwj54mO+9G0XvrNxFqqH0kwxOL6a8PeBgRhp
         hRdbvwuLOmZJGN1L98PblisEO6fQtcOtYkGdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4w4IN2J6dONrrlVeO1+L0Kz9qBIwIaC7ttYkBFQeQFw=;
        b=G7Q5TQtaiiwmCDBuuHz7Rh9pOp79ytyWjNS47RkpDXOfdBe4V/V1nc87O3JachZdSe
         PDpH9oOzg0CljZyTDTsZr1FLXVJnj70rD83LfTrjCaqN0xU+ZqzX+H80KRXoU4qYjQrP
         fjIBDMxFiN6FinD2M0v2ByN2raXZ8DnUA2UIUp7W2H8K3rw4jSIpdgTtBa1Z8mg9S5Vw
         qQbdvSbY39xe5dlY+CiD5KE1LQrFiFuTFSaNOsdSNR8ybVhLvYSZnyI/BX+S+J+61POC
         u9UEElHGdREW4/ps+SMyBBMhK08OueWGSOawPvQNsFjeu6X6nlRPXz+IxeBbmerBLoFo
         UaAg==
X-Gm-Message-State: AOUpUlEXwpwLMvzrQTEsoPgLRvC26ju1Vlv+8jznavv0SitvdspU54s3
        6Qm8UOVe6uo0j56gdYmY10HFiA==
X-Google-Smtp-Source: AA+uWPweDT2px86p8FFXqoIHaMyvhT4hpp8xN9sY+uAYcGDk96DSBalzVK9wUIRp5OZbYyOZWY1KbA==
X-Received: by 2002:a62:c00c:: with SMTP id x12-v6mr86359pff.216.1533676730040;
        Tue, 07 Aug 2018 14:18:50 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id o3-v6sm2262323pgp.3.2018.08.07.14.18.45
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
Subject: [PATCH v8 1/9] crypto: xcbc: Remove VLA usage
Date:   Tue,  7 Aug 2018 14:18:35 -0700
Message-Id: <20180807211843.47586-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180807211843.47586-1-keescook@chromium.org>
References: <20180807211843.47586-1-keescook@chromium.org>
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

