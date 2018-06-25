Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7402EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9B626157
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fr1CduVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9B626157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755708AbeFYVLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:11:42 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41519 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754766AbeFYVKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:10:48 -0400
Received: by mail-pg0-f66.google.com with SMTP id l65-v6so6605829pgl.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PbwSt8IMbUmiAnJPK0uuLHHvB9/qjp0V2xYcxgegYD4=;
        b=fr1CduVB1/5v34K7SXFRFl6hAA7+DVm9T9LIogF23zAtTG8UycUcMgyFrngt2RxvTG
         y2jf0UStdogBGrCfnVMBFs/Z3beLSja8yXnIP4yybArIQITX0uTsHmMHGxvHKeePOKrm
         WFWe2xq2vruI4yXXAAkLgvPplNEn6AdKv/aNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PbwSt8IMbUmiAnJPK0uuLHHvB9/qjp0V2xYcxgegYD4=;
        b=hab6IZOurhz+WNfdazlFKToDtNzN89rQjRILKeUsbTKtVRImo/xMYI2lzNZ6B2jcKv
         t6/stER7pN01eVRJNWrO9RG1IKRWm+pOrPmHs34wPLTVmfTsAa4VXYNIMqJlrylfnACg
         6sf7LyaWh8al3pa1ym2RDJOgJdYnAEWSHd36gJgF2hJkIH7uQKnKKG50Kjzz6n8p4V36
         FjPXQMFT38lpi6OKm8IHFySucolLUIw0PriOglx3G50x/mzktRMxCjnF6jtBssruDYhT
         IQF1KZKBr6iOwkg2QAz2ByBHd7x4ErdhBfoD3y04ifweSo5W9VE3N3jFfQAxx7FAb5rX
         GFDg==
X-Gm-Message-State: APt69E0AH/zG0ChB8FjRpoPCdYsrax5oTlAImg2QwWj1ioMLc1afeJq0
        HQpV0LG0TDDIjfWtVNGQtAeR1Q==
X-Google-Smtp-Source: ADUXVKIbl8p2B4qPAzrO4KEvhKjTIYF6iVPudD4v5zCedSeguJ4Pt9x4EKPN8yiOa+CKRu/5awxvAQ==
X-Received: by 2002:a62:6406:: with SMTP id y6-v6mr14571609pfb.204.1529961047692;
        Mon, 25 Jun 2018 14:10:47 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c12-v6sm22800661pfi.177.2018.06.25.14.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 14:10:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] crypto: shash: Remove VLA usage in unaligned hashing
Date:   Mon, 25 Jun 2018 14:10:24 -0700
Message-Id: <20180625211026.15819-10-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625211026.15819-1-keescook@chromium.org>
References: <20180625211026.15819-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this uses
the newly defined max alignment to perform unaligned hashing to avoid
VLAs, and drops the helper function while adding sanity checks on the
resulting buffer sizes. Additionally, the __aligned_largest macro is
removed since this helper was the only user.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/shash.c               | 19 ++++++++-----------
 include/linux/compiler-gcc.h |  1 -
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/crypto/shash.c b/crypto/shash.c
index ab6902c6dae7..8081c5e03770 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -73,13 +73,6 @@ int crypto_shash_setkey(struct crypto_shash *tfm, const u8 *key,
 }
 EXPORT_SYMBOL_GPL(crypto_shash_setkey);
 
-static inline unsigned int shash_align_buffer_size(unsigned len,
-						   unsigned long mask)
-{
-	typedef u8 __aligned_largest u8_aligned;
-	return len + (mask & ~(__alignof__(u8_aligned) - 1));
-}
-
 static int shash_update_unaligned(struct shash_desc *desc, const u8 *data,
 				  unsigned int len)
 {
@@ -88,11 +81,13 @@ static int shash_update_unaligned(struct shash_desc *desc, const u8 *data,
 	unsigned long alignmask = crypto_shash_alignmask(tfm);
 	unsigned int unaligned_len = alignmask + 1 -
 				     ((unsigned long)data & alignmask);
-	u8 ubuf[shash_align_buffer_size(unaligned_len, alignmask)]
-		__aligned_largest;
+	u8 ubuf[MAX_ALGAPI_ALIGNMASK + 1];
 	u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
 	int err;
 
+	if (WARN_ON(buf + unaligned_len > ubuf + sizeof(ubuf)))
+		return -EINVAL;
+
 	if (unaligned_len > len)
 		unaligned_len = len;
 
@@ -124,11 +119,13 @@ static int shash_final_unaligned(struct shash_desc *desc, u8 *out)
 	unsigned long alignmask = crypto_shash_alignmask(tfm);
 	struct shash_alg *shash = crypto_shash_alg(tfm);
 	unsigned int ds = crypto_shash_digestsize(tfm);
-	u8 ubuf[shash_align_buffer_size(ds, alignmask)]
-		__aligned_largest;
+	u8 ubuf[SHASH_MAX_DIGESTSIZE];
 	u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
 	int err;
 
+	if (WARN_ON(buf + ds > ubuf + sizeof(ubuf)))
+		return -EINVAL;
+
 	err = shash->final(desc, buf);
 	if (err)
 		goto out;
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index f1a7492a5cc8..1f1cdef36a82 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -125,7 +125,6 @@
  */
 #define __pure			__attribute__((pure))
 #define __aligned(x)		__attribute__((aligned(x)))
-#define __aligned_largest	__attribute__((aligned))
 #define __printf(a, b)		__attribute__((format(printf, a, b)))
 #define __scanf(a, b)		__attribute__((format(scanf, a, b)))
 #define __attribute_const__	__attribute__((__const__))
-- 
2.17.1

