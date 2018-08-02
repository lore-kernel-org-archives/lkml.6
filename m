Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C709DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCAE21566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eTF81MNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCAE21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbeHBXob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:44:31 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37468 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732368AbeHBXob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:44:31 -0400
Received: by mail-pl0-f66.google.com with SMTP id d5-v6so1623523pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HPRjc8KT+S3tMvGTg5pODySyTQYzH5IkMOn9cZQQI7Y=;
        b=eTF81MNoYgzo1lwsLNnM8n+wwaWcprxChLJyKkzzz/9Wnbwu4TbIKA6z6M22hvfXVk
         +tduSpiWjQFpXC8sMUhZX5qf49zf3QFcKPv+WclxWvjNQVm+cBQngUY2BK5jA2gl9gDx
         7yh1zJh6bgqmsfB7PzEnvJ2Kg+MPs9OFwqmjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HPRjc8KT+S3tMvGTg5pODySyTQYzH5IkMOn9cZQQI7Y=;
        b=etQBIn1O1i82/y5jYxi1t6hKIA7cHDu+SwPCsovIfRd9+hZAijp6plAEghSTjiYzoJ
         u5e1WQD+oFvR96HcEivaKindB9/gxrSHby+30D6MHS4j2m8KSeI1mu2MQJV25aeKRoYT
         escLYmbXHBlS7BYP/KY4y37OF/Cyc/Io5y5u/k49XHz9kO2RPXzLEeOnvxv8xmaY5+Ym
         aq0hHYPRQxPlawEaGSjSTT44FDZPXejxvYFsUyuQ7/imS5Az9znzhyAUvgZ8xZ+xk/YC
         YC36VlcgtsmlErhq6pDsOJw8OQgTIscNLu49zpZCxtot74S/oFgodK5fuH2xCCH238CR
         dPcw==
X-Gm-Message-State: AOUpUlHpBzM/0LeloJcC+iWNWSKga+4S60lqcmf889lm9kkhAE8qtqK0
        eiM3TzynANZsNcw4jzTm7zCOEw==
X-Google-Smtp-Source: AAOMgpe3Opy5bOdcDJd4RKWEJUynrNQCIjhTS4+jObPKHg/IjCpSO7W/v/yrZg9dD7faDdB9mVxfyQ==
X-Received: by 2002:a17:902:1703:: with SMTP id i3-v6mr983528pli.263.1533246688360;
        Thu, 02 Aug 2018 14:51:28 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 22-v6sm5129451pfl.126.2018.08.02.14.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 14:51:23 -0700 (PDT)
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
Subject: [PATCH 4/9] crypto, lzo: Implement zbufsize()
Date:   Thu,  2 Aug 2018 14:51:13 -0700
Message-Id: <20180802215118.17752-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802215118.17752-1-keescook@chromium.org>
References: <20180802215118.17752-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the worst-case compression size querying interface for
lzo, based on the logic originally used by pstore.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/lzo.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/crypto/lzo.c b/crypto/lzo.c
index 218567d717d6..ea18f62c5247 100644
--- a/crypto/lzo.c
+++ b/crypto/lzo.c
@@ -120,6 +120,24 @@ static int lzo_sdecompress(struct crypto_scomp *tfm, const u8 *src,
 	return __lzo_decompress(src, slen, dst, dlen);
 }
 
+static int __lzo_zbufsize(unsigned int slen, unsigned int *dlen)
+{
+	*dlen = lzo1x_worst_compress(slen);
+	return 0;
+}
+
+static int lzo_zbufsize(struct crypto_tfm *tfm, unsigned int slen,
+			unsigned int *dlen)
+{
+	return __lzo_zbufsize(slen, dlen);
+}
+
+static int lzo_szbufsize(struct crypto_scomp *tfm, unsigned int slen,
+			 unsigned int *dlen, void *ctx)
+{
+	return __lzo_zbufsize(slen, dlen);
+}
+
 static struct crypto_alg alg = {
 	.cra_name		= "lzo",
 	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
@@ -129,7 +147,8 @@ static struct crypto_alg alg = {
 	.cra_exit		= lzo_exit,
 	.cra_u			= { .compress = {
 	.coa_compress		= lzo_compress,
-	.coa_decompress		= lzo_decompress } }
+	.coa_decompress		= lzo_decompress,
+	.coa_zbufsize		= lzo_zbufsize } }
 };
 
 static struct scomp_alg scomp = {
@@ -137,6 +156,7 @@ static struct scomp_alg scomp = {
 	.free_ctx		= lzo_free_ctx,
 	.compress		= lzo_scompress,
 	.decompress		= lzo_sdecompress,
+	.zbufsize		= lzo_szbufsize,
 	.base			= {
 		.cra_name	= "lzo",
 		.cra_driver_name = "lzo-scomp",
-- 
2.17.1

