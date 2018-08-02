Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792D4C46463
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE5121566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OUwCsFvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE5121566
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbeHBXo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:44:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40343 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732269AbeHBXo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:44:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so1827026pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 14:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xX8Ai0CHD323Ung1PVFnA7i5JYEXoboRuof1GqX9NxQ=;
        b=OUwCsFvJs7lyrKUoT2JFhrRr6aUKhm3/fb20/JH/4v8aQ9Rw4f+y18lihflvKTP2de
         lzPQdAJwk6QhIpSMlj/GBYMZtsOeVvR2bCcR7yBnPRVJrJuPOyrD7aDJSlqhhnlQ5E9Z
         FXAaffazGas8bfVugOO94xM9wNBEGPhvS+h24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xX8Ai0CHD323Ung1PVFnA7i5JYEXoboRuof1GqX9NxQ=;
        b=Do+YDdazf8NFOEB4jEaN+IugKk5NHj1XFRb78doP6NrAbTRAEXL4zGK8WkmPMg4gMm
         sP8a0drVyDh2nla/hZ9dB8EkgqWoIGULXedbk6ASbmJbZp5tziaxQbyb6ioQMmMYYkMN
         fUKs3s5HGOvwVK6Fi+Ud4gUELD5Kx39M65jwfH2gY/M4KBuFmFz6sWqKgnuB6/jCPpRE
         ZfQYgMFnfqIhHAmfHF4aYuvkwmX+J/YvCysS2LbAFKOHROlfjP0A1dW8sG+of70gh6qC
         LKLhag+rWLdFrijLRtkqXM4o54jtAN7z3FNEa6Ei3YGVPGHK+E74xNkMfTyaPu8ZQR68
         Mfag==
X-Gm-Message-State: AOUpUlFRVbbxevEYyWV8MicGIV8AYhKMpXQguvOGq70CFHeQ5Q7jrjuk
        JMWkiLTJ+nVcnz6cHqYv2Q0qOA==
X-Google-Smtp-Source: AAOMgpfh9cahqB5jK5MliTtao3XgTlAQBf5o6Z03GjDcekimYey36acShN8Qh+ZhcOCQYpuqr4bD5A==
X-Received: by 2002:a63:ce43:: with SMTP id r3-v6mr1059807pgi.439.1533246685697;
        Thu, 02 Aug 2018 14:51:25 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d191-v6sm4534042pfg.172.2018.08.02.14.51.22
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
Subject: [PATCH 2/9] crypto, 842: implement zbufsize()
Date:   Thu,  2 Aug 2018 14:51:11 -0700
Message-Id: <20180802215118.17752-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802215118.17752-1-keescook@chromium.org>
References: <20180802215118.17752-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the worst-case compression size querying interface for
842, based on the logic originally used by pstore.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/842.c          | 17 ++++++++++++++++-
 include/linux/sw842.h |  9 +++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/crypto/842.c b/crypto/842.c
index bc26dc942821..c6d9ad6512f8 100644
--- a/crypto/842.c
+++ b/crypto/842.c
@@ -101,6 +101,19 @@ static int crypto842_sdecompress(struct crypto_scomp *tfm,
 	return sw842_decompress(src, slen, dst, dlen);
 }
 
+static int crypto842_zbufsize(struct crypto_tfm *tfm,
+			      unsigned int slen, unsigned int *dlen)
+{
+	return sw842_zbufsize(slen, dlen);
+}
+
+static int crypto842_szbufsize(struct crypto_scomp *tfm,
+			       unsigned int slen, unsigned int *dlen,
+			       void *ctx)
+{
+	return sw842_zbufsize(slen, dlen);
+}
+
 static struct crypto_alg alg = {
 	.cra_name		= "842",
 	.cra_driver_name	= "842-generic",
@@ -112,7 +125,8 @@ static struct crypto_alg alg = {
 	.cra_exit		= crypto842_exit,
 	.cra_u			= { .compress = {
 	.coa_compress		= crypto842_compress,
-	.coa_decompress		= crypto842_decompress } }
+	.coa_decompress		= crypto842_decompress,
+	.coa_zbufsize		= crypto842_zbufsize } }
 };
 
 static struct scomp_alg scomp = {
@@ -120,6 +134,7 @@ static struct scomp_alg scomp = {
 	.free_ctx		= crypto842_free_ctx,
 	.compress		= crypto842_scompress,
 	.decompress		= crypto842_sdecompress,
+	.zbufsize		= crypto842_szbufsize,
 	.base			= {
 		.cra_name	= "842",
 		.cra_driver_name = "842-scomp",
diff --git a/include/linux/sw842.h b/include/linux/sw842.h
index 3e29f5dcc62b..9760554beb26 100644
--- a/include/linux/sw842.h
+++ b/include/linux/sw842.h
@@ -10,4 +10,13 @@ int sw842_compress(const u8 *src, unsigned int srclen,
 int sw842_decompress(const u8 *src, unsigned int srclen,
 		     u8 *dst, unsigned int *destlen);
 
+static inline int sw842_zbufsize(unsigned int srclen,
+				 unsigned int *destlen)
+{
+	/* Worst case is uncompressed sized. */
+	*destlen = srclen;
+
+	return 0;
+}
+
 #endif
-- 
2.17.1

