Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2E4ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C673F208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GwIxWq+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C673F208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeGQEwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:52:38 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41529 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbeGQEwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:52:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id c21-v6so22759089pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 21:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RbnyDvKBIakheoYpsZY1SkQ8eDkgkUn0mQTm59BWgpI=;
        b=GwIxWq+9kDMhTMqls8iQpDSmzP2X2+gU/q1a5HO50FnTu5Q80vf3yENZsk8qbS9g0f
         JzczJC9fw+Gakksa04KPTQQzZWArtJfbNaJxxSYIRSt58SRluIJvycv5nsjfknW27xSl
         HEqxp2D/lTfuiWJ/1Mcd0EM+H7MOBbZP4bjlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RbnyDvKBIakheoYpsZY1SkQ8eDkgkUn0mQTm59BWgpI=;
        b=e/vDgrXgQFdy4k2cwqXc1rdysM2Ek8MrBMzBO9G0MTL8csXsjAKldTAluGWa1BxAAI
         TFOtZLx/yKHHB1k92DqkJJ7nGzFMrY24BirfswCydbToz/I2Q+gX6vjGMTwaTke0UqwL
         Vi1YfHBbieeRRt/Otp2PgLzAK4NGAFh5VXmIg0PxqK1Ol3gdoXr9tkTDszriSl8uf6nb
         oAJmLWGWOjgtnjr1AL8GoBK3k0fG2zaan3fHiCate/fgTAyiHZdL41V58VR8Xzv650fB
         E15PDVl81mJ5rRLna6mNOIrzGMMder7cvHFXAuBV6F8L0EGmWzSZ0SoIxUAwTzYAZ+ia
         sKYg==
X-Gm-Message-State: AOUpUlGaE8XvVvd7MEvcM3f8ZCTmW/uZrzYycMDUYJf4Fhc8Lz19uWHD
        tNTJbmYAR9rvdeSVMbX/Uvg5Sg==
X-Google-Smtp-Source: AAOMgpdk459t1M4Hk5O9nlt7Rm7c9L2TfCD0sr0Y/6YbpFJsQQ3r9pGk2noPHtc591crI1ZJWQTv+g==
X-Received: by 2002:aa7:83cd:: with SMTP id j13-v6mr17286pfn.236.1531801322964;
        Mon, 16 Jul 2018 21:22:02 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b73-v6sm52052787pfl.152.2018.07.16.21.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:21:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/11] crypto: shash: Remove VLA usage in unaligned hashing
Date:   Mon, 16 Jul 2018 21:21:48 -0700
Message-Id: <20180717042150.37761-10-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717042150.37761-1-keescook@chromium.org>
References: <20180717042150.37761-1-keescook@chromium.org>
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

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/shash.c               | 27 ++++++++++++++++-----------
 include/linux/compiler-gcc.h |  1 -
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/crypto/shash.c b/crypto/shash.c
index ab6902c6dae7..8d4746b14dd5 100644
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
@@ -88,11 +81,17 @@ static int shash_update_unaligned(struct shash_desc *desc, const u8 *data,
 	unsigned long alignmask = crypto_shash_alignmask(tfm);
 	unsigned int unaligned_len = alignmask + 1 -
 				     ((unsigned long)data & alignmask);
-	u8 ubuf[shash_align_buffer_size(unaligned_len, alignmask)]
-		__aligned_largest;
+	/*
+	 * We cannot count on __aligned() working for large values:
+	 * https://patchwork.kernel.org/patch/9507697/
+	 */
+	u8 ubuf[MAX_ALGAPI_ALIGNMASK * 2];
 	u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
 	int err;
 
+	if (WARN_ON(buf + unaligned_len > ubuf + sizeof(ubuf)))
+		return -EINVAL;
+
 	if (unaligned_len > len)
 		unaligned_len = len;
 
@@ -124,11 +123,17 @@ static int shash_final_unaligned(struct shash_desc *desc, u8 *out)
 	unsigned long alignmask = crypto_shash_alignmask(tfm);
 	struct shash_alg *shash = crypto_shash_alg(tfm);
 	unsigned int ds = crypto_shash_digestsize(tfm);
-	u8 ubuf[shash_align_buffer_size(ds, alignmask)]
-		__aligned_largest;
+	/*
+	 * We cannot count on __aligned() working for large values:
+	 * https://patchwork.kernel.org/patch/9507697/
+	 */
+	u8 ubuf[MAX_ALGAPI_ALIGNMASK + SHASH_MAX_DIGESTSIZE];
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

