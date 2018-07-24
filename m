Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B36ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552A42089E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jQ5y83FY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552A42089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388647AbeGXR5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:57:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43359 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388598AbeGXR5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:57:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id v13-v6so3294519pgr.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ok95ycGnZuw2CZpO4KgRNxj4QX0cXIlEQlrBt5ewdsw=;
        b=jQ5y83FYcXRBUM77JJA0nyUNgrejZPE5lJ0JT0iizxWJfPIBVNOrdtpeO7rT+b2lsv
         +bjOyNg4sn32L5cfKvZIdvHZhJj8DFiyCgt6UyipV5eZBsz7wNOkN0Bulbb9Gj/WzKGr
         ZuhcetVCR/7gfa6Kfm6K+hpLj/2AObwWbUbIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ok95ycGnZuw2CZpO4KgRNxj4QX0cXIlEQlrBt5ewdsw=;
        b=kbQjKenFmxQFby2cCAWv7rrb5rk0opB5hZ0VTRsZpt01hQar8ylBS6D3DSjRgo4wTi
         fRijJqnasEkBLWFj2CJHO6R/FP/S1YGVxqTHHZY5AmpuX/q8LECpjMujm/NTQNL5yvsq
         DpdlLjGwmBj+jGyWooKbRnuTlc7Xu0CdY6cN2T/631XEPD3d0B/CEY/hW1e6HQ4ETAVS
         l08lfnuxJ3wH8opDppgtYcTZG8n1ycEptPHaibE0eS/+P7OxGbiOpry2QGTliM9mx6x5
         KjLiWn31oOez0z42GcTFqZ2A3HsdL0fttzZ4GLvwBMFarB3yagenDipRhkIf+wZ80ja7
         +tDg==
X-Gm-Message-State: AOUpUlFZdNUpcKQkB5AkxnN1pqH5aeaQqqSyyn9bXZQNpiqELO8kADGr
        U4sGtC9eIyG96CVw0izM8LYBUg==
X-Google-Smtp-Source: AAOMgpc6VqDh6VDKEj14IbS01oeHnKpI3OsjZNoP+Pml6OkQrZbvFlPFHd08eIo2+U87sWqzc4srfA==
X-Received: by 2002:a65:4384:: with SMTP id m4-v6mr5659689pgp.265.1532450992012;
        Tue, 24 Jul 2018 09:49:52 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x65-v6sm6984082pfk.140.2018.07.24.09.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 09:49:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Will Deacon <will.deacon@arm.com>, dm-devel@redhat.com,
        linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        qat-linux@intel.com, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-afs@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/18] crypto: shash: Remove VLA usage in unaligned hashing
Date:   Tue, 24 Jul 2018 09:49:25 -0700
Message-Id: <20180724164936.37477-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724164936.37477-1-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
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

