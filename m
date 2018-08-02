Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01978C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF8C21566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dbb5FjxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF8C21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbeHBXof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:44:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33835 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732422AbeHBXoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:44:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so2075771pfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 14:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u0K6USUpuBoWt0Lp8iIXbpSRCTtHn6HWYBuJRPD69PY=;
        b=Dbb5FjxO76fCk4otdxWbsOt6BuBSYXFIDrHYvnRkwYKLLWLnG4rgc9d+PmDfGUXuTc
         ZYur4VOS4cEcLvK/dTbz7hLk/FcueevvM5AAald4FdPqEGdAAZkcNTt1zDWMElJpFF87
         WGB1wH+y2YdlnfDS/S9W9/BNZteWRqLXBBpQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u0K6USUpuBoWt0Lp8iIXbpSRCTtHn6HWYBuJRPD69PY=;
        b=VxwtExMmZoaBZagW4yWAeTNKs7Ee6GnqQuqCu+PPotZLxrHpOhH2ZFlOupyw2uzAAi
         vMwnJsoSHY1+RR36REa6Qqs3lYWnSrNBZLx1fH5y4rqkkK42QZ92c2imePHKZX3aLubI
         3s6xV+fvw2afVjh1jKdMsrXX6+TmcwreFyKBHtwXtY0MTGv9hZNujeKJi6GepEEmOlDn
         G6KZcgX19qf88423BlE9TvK3MQ4KHA64YD+1hSrPbmM8ootwsazZZBPJuYgtLtgYJGgc
         zZirqh5z9QGaApuq8B7yjwUUGryPFUOpSE/FoMRdowvpQRb4pDjnZHV1v7jA98ySMefd
         aX4w==
X-Gm-Message-State: AOUpUlFbhT1x4hN+qC20OVtxkibVtr56fQWMvSJfOrdl9MaftFYExejp
        CMLYo7kldPTqqwPwJ+cP/zIgLw==
X-Google-Smtp-Source: AAOMgpfyo2nWKbt55OkcwHDhF+wlboqMRDFD9QQFiwUmWr+C1VbW8Mp78NpkSFn3awyDf0Jqg31ULQ==
X-Received: by 2002:a63:90c8:: with SMTP id a191-v6mr1086792pge.173.1533246691573;
        Thu, 02 Aug 2018 14:51:31 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 1-v6sm6599171pfk.134.2018.08.02.14.51.25
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
Subject: [PATCH 6/9] crypto, zstd: Implement zbufsize()
Date:   Thu,  2 Aug 2018 14:51:15 -0700
Message-Id: <20180802215118.17752-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802215118.17752-1-keescook@chromium.org>
References: <20180802215118.17752-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the worst-case compression size querying interface for
zstd, based on the logic originally used by pstore.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/zstd.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/crypto/zstd.c b/crypto/zstd.c
index 9a76b3ed8b8b..ce8efd40f27f 100644
--- a/crypto/zstd.c
+++ b/crypto/zstd.c
@@ -212,6 +212,24 @@ static int zstd_sdecompress(struct crypto_scomp *tfm, const u8 *src,
 	return __zstd_decompress(src, slen, dst, dlen, ctx);
 }
 
+static int __zstd_zbufsize(unsigned int slen, unsigned int *dlen)
+{
+	*dlen = ZSTD_compressBound(slen);
+	return 0;
+}
+
+static int zstd_zbufsize(struct crypto_tfm *tfm, unsigned int slen,
+			 unsigned int *dlen)
+{
+	return __zstd_zbufsize(slen, dlen);
+}
+
+static int zstd_szbufsize(struct crypto_scomp *tfm, unsigned int slen,
+			  unsigned int *dlen, void *ctx)
+{
+	return __zstd_zbufsize(slen, dlen);
+}
+
 static struct crypto_alg alg = {
 	.cra_name		= "zstd",
 	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
@@ -221,7 +239,8 @@ static struct crypto_alg alg = {
 	.cra_exit		= zstd_exit,
 	.cra_u			= { .compress = {
 	.coa_compress		= zstd_compress,
-	.coa_decompress		= zstd_decompress } }
+	.coa_decompress		= zstd_decompress,
+	.coa_zbufsize		= zstd_zbufsize } }
 };
 
 static struct scomp_alg scomp = {
@@ -229,6 +248,7 @@ static struct scomp_alg scomp = {
 	.free_ctx		= zstd_free_ctx,
 	.compress		= zstd_scompress,
 	.decompress		= zstd_sdecompress,
+	.zbufsize		= zstd_szbufsize,
 	.base			= {
 		.cra_name	= "zstd",
 		.cra_driver_name = "zstd-scomp",
-- 
2.17.1

