Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13B5C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A915D21566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CCU9pHft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A915D21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbeHBXod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:44:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41801 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732422AbeHBXod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:44:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so1826049pgu.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 14:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oQJchiXfeqiQrM/C931jBAd/YxZ0lE/efF7CVn2bnm4=;
        b=CCU9pHftQkCNF95e92x8SfRujbgehO5yJJIk7g8u26K90TNWHOE3EKiSgRflpgl8Ih
         KJovu1J/ErExmPzmTtdQ38AkJtG+D6eJEbBeaw6xclLRrSJkYL1TKFmchVOYQPdAzTyW
         o6TJ2Z+YiXbcOBz5w7Trf6OmKroE5hf7ttHOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oQJchiXfeqiQrM/C931jBAd/YxZ0lE/efF7CVn2bnm4=;
        b=E4ZqvfBu4B3b9/irINl49rPpY3MajN4wvAyW3rxwCC2QAdWU0WZ71eFi/1dGs93Yk2
         iEbd9oNInq1KSzTXC1jE7lXl4gaDVwS0GHRDvDm7yut7Js/XNtAI7aW1yQfvrmdnM+YP
         +7ZSHnrwNjwEArfyulFw70di9ik3BUNRkGGm2gDipVgFnPv/0T+k8XMSdhP9lfJm1Xoh
         //3VcLLw6x4wtJy8lboXdvqiWP9GT/AWZe2PJwA2zhyCZCpvhn8WBfqf50YoqbHPxQNZ
         qCfUsXEIoAA5xgmI0NUauQcF1ajW1IaxQrfzCxexsMwZiW7VyAlcMUGy07VgDceNad8q
         40Kg==
X-Gm-Message-State: AOUpUlEUVH7vNF6k84a/3nyk4YazHtnRWyYQ+zPZK8m32uAb16cIXVOo
        ogfgImvkc+mgSUqu6N4ANb5+Kg==
X-Google-Smtp-Source: AAOMgpeVYDPLzfWtrHZbKjCu23dA8gP32f9xlnujN6A+8bJPHu0oFmI15ee+QZn2c8kRsD2cMMic/A==
X-Received: by 2002:a63:7412:: with SMTP id p18-v6mr1019188pgc.395.1533246689879;
        Thu, 02 Aug 2018 14:51:29 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id w81-v6sm5546518pfk.92.2018.08.02.14.51.25
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
Subject: [PATCH 5/9] crypto, deflate: Implement zbufsize()
Date:   Thu,  2 Aug 2018 14:51:14 -0700
Message-Id: <20180802215118.17752-6-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802215118.17752-1-keescook@chromium.org>
References: <20180802215118.17752-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the worst-case compression size querying interface for
deflate, based on the logic originally used by pstore.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/deflate.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/crypto/deflate.c b/crypto/deflate.c
index 94ec3b36a8e8..2665af8d49b4 100644
--- a/crypto/deflate.c
+++ b/crypto/deflate.c
@@ -277,6 +277,47 @@ static int deflate_sdecompress(struct crypto_scomp *tfm, const u8 *src,
 	return __deflate_decompress(src, slen, dst, dlen, ctx);
 }
 
+static int __deflate_zbufsize(unsigned int slen, unsigned int *dlen)
+{
+	size_t size = slen;
+	size_t cmpr;
+
+	/* Estimated ranges */
+	switch (size) {
+	case 1000 ... 2000:
+		cmpr = 56;
+		break;
+	case 2001 ... 3000:
+		cmpr = 54;
+		break;
+	case 3001 ... 3999:
+		cmpr = 52;
+		break;
+	case 4000 ... 10000:
+		cmpr = 45;
+		break;
+	default:
+		cmpr = 60;
+		break;
+	}
+
+	*dlen = (size * 100) / cmpr;
+
+	return 0;
+}
+
+static int deflate_zbufsize(struct crypto_tfm *tfm, unsigned int slen,
+			    unsigned int *dlen)
+{
+	return __deflate_zbufsize(slen, dlen);
+}
+
+static int deflate_szbufsize(struct crypto_scomp *tfm, unsigned int slen,
+			     unsigned int *dlen, void *ctx)
+{
+	return __deflate_zbufsize(slen, dlen);
+}
+
 static struct crypto_alg alg = {
 	.cra_name		= "deflate",
 	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
@@ -285,8 +326,9 @@ static struct crypto_alg alg = {
 	.cra_init		= deflate_init,
 	.cra_exit		= deflate_exit,
 	.cra_u			= { .compress = {
-	.coa_compress 		= deflate_compress,
-	.coa_decompress  	= deflate_decompress } }
+	.coa_compress		= deflate_compress,
+	.coa_decompress		= deflate_decompress,
+	.coa_zbufsize		= deflate_zbufsize } }
 };
 
 static struct scomp_alg scomp[] = { {
@@ -294,6 +336,7 @@ static struct scomp_alg scomp[] = { {
 	.free_ctx		= deflate_free_ctx,
 	.compress		= deflate_scompress,
 	.decompress		= deflate_sdecompress,
+	.zbufsize		= deflate_szbufsize,
 	.base			= {
 		.cra_name	= "deflate",
 		.cra_driver_name = "deflate-scomp",
@@ -304,6 +347,7 @@ static struct scomp_alg scomp[] = { {
 	.free_ctx		= deflate_free_ctx,
 	.compress		= deflate_scompress,
 	.decompress		= deflate_sdecompress,
+	.zbufsize		= deflate_szbufsize,
 	.base			= {
 		.cra_name	= "zlib-deflate",
 		.cra_driver_name = "zlib-deflate-scomp",
-- 
2.17.1

