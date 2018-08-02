Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C4CC46467
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53846215EB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iJphebjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53846215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbeHBXof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:44:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37725 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732480AbeHBXof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:44:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id a26-v6so2068735pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 14:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NiNDxc68m2WmDTmrjJG1BEXvvndByC2Ak5klnTeYFOY=;
        b=iJphebjYEdmwoEEp0C6Njvbonu9mwIqazoswC2TyhGCD8QVK+1IJi55eJqyogaa4Rg
         9giaKz/RFkkNH5pg02RT6og4DexI/jIi93niIEueBODyRlLsij25Xzo9OcKrbTiR7FWX
         xzJ+vV7xxv9zWGBiaPHgWIASHCh4xO6zGlQVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NiNDxc68m2WmDTmrjJG1BEXvvndByC2Ak5klnTeYFOY=;
        b=lPqhijkvSYPY3uEnrLlQIhtjjL4+cILaJiCyEb+tV1xDgMuzulL7h4CtLmGHw8kL3h
         YX7PV0fUdBSWglP2hC8LCFiI4XR4o9NUwexnerwlORc81QAubkDAyNGAVaBz5sEtr3oJ
         DrvMk4yW1WERFXl2vGzQK3SaITLLQxgk6vO/0wkSfkRLD5EoXspnd39eFU0+gIVy56nV
         1NCIy5Esa8idXZl+2MjQf+nyrhyps/FnBTWXgw65vCTLvJzhwBjCV0filpr1DHyuQ9ub
         xHbrX61k7TtyuM438oLfezGWxdSOczPnXCjrinsMVch/gnj8+4qj0rBD7fyvxOK7XBKN
         mouQ==
X-Gm-Message-State: AOUpUlHtOh4G1cwMqqCXngd7Mn5c5rQkpsiO7x+pKtLT99fEimYbXp50
        vgokFz+9QOw0tzSxiPxU1kIBjA==
X-Google-Smtp-Source: AAOMgpck70/+UIrwsATnOhg4I2SRAomA0RyL/ppIMSTekyo8er4AW4MeIq8JonAtC8eI3NB9l+epig==
X-Received: by 2002:a65:52cc:: with SMTP id z12-v6mr1081121pgp.69.1533246692681;
        Thu, 02 Aug 2018 14:51:32 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id g5-v6sm2567133pgn.73.2018.08.02.14.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 14:51:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Haren Myneni <haren@us.ibm.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] crypto, lz4hc: Implement zbufsize()
Date:   Thu,  2 Aug 2018 14:51:17 -0700
Message-Id: <20180802215118.17752-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802215118.17752-1-keescook@chromium.org>
References: <20180802215118.17752-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the worst-case compression size querying interface for
lz4hc, based on the logic originally used by pstore.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/lz4hc.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/crypto/lz4hc.c b/crypto/lz4hc.c
index 2be14f054daf..cf6f38a1c35b 100644
--- a/crypto/lz4hc.c
+++ b/crypto/lz4hc.c
@@ -118,6 +118,24 @@ static int lz4hc_decompress_crypto(struct crypto_tfm *tfm, const u8 *src,
 	return __lz4hc_decompress_crypto(src, slen, dst, dlen, NULL);
 }
 
+static int __lz4hc_zbufsize_crypto(unsigned int slen, unsigned int *dlen)
+{
+	*dlen = LZ4_compressBound(slen);
+	return 0;
+}
+
+static int lz4hc_szbufsize(struct crypto_scomp *tfm, unsigned int slen,
+			   unsigned int *dlen, void *ctx)
+{
+	return __lz4hc_zbufsize_crypto(slen, dlen);
+}
+
+static int lz4hc_zbufsize_crypto(struct crypto_tfm *tfm, unsigned int slen,
+				 unsigned int *dlen)
+{
+	return __lz4hc_zbufsize_crypto(slen, dlen);
+}
+
 static struct crypto_alg alg_lz4hc = {
 	.cra_name		= "lz4hc",
 	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
@@ -128,7 +146,8 @@ static struct crypto_alg alg_lz4hc = {
 	.cra_exit		= lz4hc_exit,
 	.cra_u			= { .compress = {
 	.coa_compress		= lz4hc_compress_crypto,
-	.coa_decompress		= lz4hc_decompress_crypto } }
+	.coa_decompress		= lz4hc_decompress_crypto,
+	.coa_zbufsize		= lz4hc_zbufsize_crypto } }
 };
 
 static struct scomp_alg scomp = {
@@ -136,6 +155,7 @@ static struct scomp_alg scomp = {
 	.free_ctx		= lz4hc_free_ctx,
 	.compress		= lz4hc_scompress,
 	.decompress		= lz4hc_sdecompress,
+	.zbufsize		= lz4hc_szbufsize,
 	.base			= {
 		.cra_name	= "lz4hc",
 		.cra_driver_name = "lz4hc-scomp",
-- 
2.17.1

