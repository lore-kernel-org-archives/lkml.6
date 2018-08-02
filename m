Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78A8C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7346221531
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MJPtM5Dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7346221531
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732155AbeHCApR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:45:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45219 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbeHCApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:45:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id f1-v6so1876625pgq.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 15:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4w4IN2J6dONrrlVeO1+L0Kz9qBIwIaC7ttYkBFQeQFw=;
        b=MJPtM5DrXi71NqaWEQYItiJlS3TD+nNAyTVAZSz56FSXdi41JPXEIZCHRfaKPO4EGa
         r9bnOJ8j0gTaHlb1zSUOXZYTYqTmHxwiIH5BGkUWd3Jcc5cQZ/Yq23cOPaClZMMODbr/
         CojOQODYnJ/R98Ahr+wnJbTn5SrM8+olatYVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4w4IN2J6dONrrlVeO1+L0Kz9qBIwIaC7ttYkBFQeQFw=;
        b=lgdM2jTuSpXJc1nfbJo+h/YEYPvMPrx/c0oxaWX6yOjPYdUmH+zbnHA35MDgok2WYy
         saXnS5si8o2laZggDp/KrBg5ag7NLDBH355ZqT31rlfMadwfgpKegdUACgwa7ugjttZX
         BwbZomOmtKLGaLJGzMOQTKC88thswg+5hnbT+tDdIsYVLBsznPqtfbzssdUBHWemGNdw
         atEAKgtv+BYyvId3T8IcO41QzNQmhQWS+GtDVP/tKttuPldCXdACWcGpkwuWw7jAfWjc
         TCHHEc0h3jKuz/y2kWVS/XalVUH2bJtIOXEtdEU+vawXXMHthNVu5gPAznZHISMH3RrW
         YA4Q==
X-Gm-Message-State: AOUpUlEqUNh/ZjZFUKWOiRHsadKZHXb0hzOQaf8cUlmBMFCm9deYK1Iz
        lQKDvRjEcMmAJfW+sJgb6Cl/4w==
X-Google-Smtp-Source: AAOMgpfS7uWJ2m2fnCd3q5O44WlAj38sQsrNquS+SSvsE+4QOZ9ZAOZxHfW/J5fqtyqnrkchc4RsdA==
X-Received: by 2002:a62:cac5:: with SMTP id y66-v6mr1437334pfk.187.1533250319247;
        Thu, 02 Aug 2018 15:51:59 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 5-v6sm4465319pgc.86.2018.08.02.15.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 15:51:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/9] crypto: xcbc: Remove VLA usage
Date:   Thu,  2 Aug 2018 15:51:44 -0700
Message-Id: <20180802225152.19194-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802225152.19194-1-keescook@chromium.org>
References: <20180802225152.19194-1-keescook@chromium.org>
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

