Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBE9C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BEC21946
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bPGffoD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BEC21946
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeHGXfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:35:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42211 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeHGXfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:35:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so29223pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ok95ycGnZuw2CZpO4KgRNxj4QX0cXIlEQlrBt5ewdsw=;
        b=bPGffoD9rbJL4c/louH8PZgWEcj/0pFdULql4VoF1ESdHWJ0mlucjTp5yC2COebNDK
         K0cIuZI1yfNerOQBMAyliPuUXBfO03mNJgyfikZ6OG7MX0fc/OoZhSKN2FL5TnncfaO0
         EQmxRPU5OCO0/O6NkGwo3TkraTUFsnoxT7I0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ok95ycGnZuw2CZpO4KgRNxj4QX0cXIlEQlrBt5ewdsw=;
        b=HnQJLjhxPs2IiF2opT249ojjr/kke3oq4y2NkarUvIwNZ0im1/6BtIDgJ+2lYl2HgH
         AAaureZp2oWt54YByh/jt01Nvl0nuK9G34bc4JPQN0BjGajNNQTpuoNQ56Lzd2Ka3/x/
         0XUo96SmQyM2XJB8DTANDKSF92jDLsl8LNj4ztuW3EQrpyK0WEXR/faZj7SdE/fLMEHN
         d8iPPjo43L53CKPJv3SVw+zpYmQ6umyP2XPyRbElXFFKV8+Um9uZFvqUmtQfwN0Wwb9o
         AbgdvQzY/rZkatk3jyDtFECnZuP2moiVHh4jWcO3KCeUtv4sAqBxcGRocWu6fI+PoaAf
         CuSw==
X-Gm-Message-State: AOUpUlHGcVX8AVvnLi1JKDw6Z4PYz9sOgTlVFXAcE315euss1HYkePR6
        fCFi4RXNHnmko86B2Vv9ihE3pQ==
X-Google-Smtp-Source: AA+uWPwOtqnylJHlmzaePG/v0QzJf95yXCNri2Pa1z72+V7yLUjW5xDl+aWaiF/nzsHsG6cm8l9OFQ==
X-Received: by 2002:a63:c80e:: with SMTP id z14-v6mr66638pgg.77.1533676735935;
        Tue, 07 Aug 2018 14:18:55 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c88-v6sm3519007pfe.132.2018.08.07.14.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 14:18:51 -0700 (PDT)
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
Subject: [PATCH v8 8/9] crypto: shash: Remove VLA usage in unaligned hashing
Date:   Tue,  7 Aug 2018 14:18:42 -0700
Message-Id: <20180807211843.47586-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180807211843.47586-1-keescook@chromium.org>
References: <20180807211843.47586-1-keescook@chromium.org>
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
index 86d76b5c626c..d21f04d70dce 100644
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
+	u8 ubuf[MAX_ALGAPI_ALIGNMASK + HASH_MAX_DIGESTSIZE];
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

