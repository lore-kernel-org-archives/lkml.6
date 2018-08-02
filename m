Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD87C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA872159F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P6LB+vxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA872159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeHBXo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:44:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41580 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731070AbeHBXo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:44:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id y10-v6so2063364pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 14:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4IeB5RudLojmcqsM5aWtIarfYxOSvqZFxbzNfxpLrPA=;
        b=P6LB+vxjUgvuKs7Dac2UEiqHtGIFVDSQQA6Zu5Ijsc3fC6f4QDKz9jBqoCHwGx5G02
         5GW839forCJ+d/3LlH0BWMsP5f5gn00608hPG8nP2UO9o8TA9nfLqy70fTqLi2BizE2M
         bXcTIaE8zmjFhEVLtu/j3Dh2FiqVddrukQlWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4IeB5RudLojmcqsM5aWtIarfYxOSvqZFxbzNfxpLrPA=;
        b=RKn567gUM2PMPWyuS5GfhxSXFH0vHCBrbw5yEDYSLjSYGIP/H0lnS6tTXPXO75xveu
         ixxSeb+bHUE3mN7ypv7b0ioNEXHS8n0Tfpmbb5l/CD08PB6kMvd4rnWJVs9ZQ39ks1tQ
         ufLyC6lCECQ3DmsnZgbxYoLEEcylhzqpb4X68QcZQliaOkn2k0UZHumvvrUbmk0yZKo5
         iqPlKh1lSlUZtFlwPEg4dsFzv0/2FnTZByf17twoPupU4Hv1nlptCInBwu5XcQC6Fc0y
         RaQ0oxV1HqZ5kEr1MS1HVm1MOAJjXAzsxSajbeyiyEJa1/QfXhLp6rVRmSmCCt3vwZia
         Rojw==
X-Gm-Message-State: AOUpUlHYWoW47Z97JvryOcLNd4msuy13iNkntdnG+Fag/xmcizzgwWyX
        EDPXI+Psz+VWWGGTQD1BvwADaA==
X-Google-Smtp-Source: AAOMgpflYt0nYuPF+0HLVgNIydMlXkG7Cn7o5nEUBtTmqR9OrCbNTGrXrRLTe9f8r4L48y2SaWR26g==
X-Received: by 2002:a62:d34a:: with SMTP id q71-v6mr1278749pfg.17.1533246684829;
        Thu, 02 Aug 2018 14:51:24 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a191-v6sm4866503pge.45.2018.08.02.14.51.22
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
Subject: [PATCH 3/9] crypto, null: Implement zbufsize()
Date:   Thu,  2 Aug 2018 14:51:12 -0700
Message-Id: <20180802215118.17752-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802215118.17752-1-keescook@chromium.org>
References: <20180802215118.17752-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the worst-case compression size querying interface for
the "null" compression implementation (i.e. no change in size).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/crypto_null.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/crypto/crypto_null.c b/crypto/crypto_null.c
index 20ff2c746e0b..d1b6107f8443 100644
--- a/crypto/crypto_null.c
+++ b/crypto/crypto_null.c
@@ -39,6 +39,13 @@ static int null_compress(struct crypto_tfm *tfm, const u8 *src,
 	return 0;
 }
 
+static int null_zbufsize(struct crypto_tfm *tfm, unsigned int slen,
+			 unsigned int *dlen)
+{
+	*dlen = slen;
+	return 0;
+}
+
 static int null_init(struct shash_desc *desc)
 {
 	return 0;
@@ -146,7 +153,8 @@ static struct crypto_alg null_algs[3] = { {
 	.cra_module		=	THIS_MODULE,
 	.cra_u			=	{ .compress = {
 	.coa_compress		=	null_compress,
-	.coa_decompress		=	null_compress } }
+	.coa_decompress		=	null_compress,
+	.coa_zbufsize		=	null_zbufsize } }
 } };
 
 MODULE_ALIAS_CRYPTO("compress_null");
-- 
2.17.1

