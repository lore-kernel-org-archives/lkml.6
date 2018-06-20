Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B118C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C4D208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gxvzCcJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C4D208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932403AbeFTTGe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:06:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39996 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754743AbeFTTE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:04:27 -0400
Received: by mail-pl0-f68.google.com with SMTP id t12-v6so275706plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W0im0N6bmEOYL9VVjoDo+sS382aFUcJ6FzTFQ/Uoino=;
        b=gxvzCcJnct0yKUzvsKvLGQkCtiN5VpubhNKF2EDU5EHRNlDaDnYYb5J4wKhuNRfNvG
         hBCFLQhrcPu01i6Pg1/ErWe4ZH5EuLktltoyH9n+s628U0bNXh0sV2Wna1244AccnOmq
         6loO/HuyRSJNOsblnw5mWU5IZWRolFl18/69c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W0im0N6bmEOYL9VVjoDo+sS382aFUcJ6FzTFQ/Uoino=;
        b=kYRlkNz8AkWgZo1677ycaHOSa/OSYXfCFAr/VqzakvAGl6DCDjC7UKbR5Wszri5E4p
         pJYykARZJCXQjiVhlJ+mNQdtIDcOlfYZIoy2952DAq179EEuuQ8RgE4LI2n4ABgS/Dwt
         wx96LWvWfMPAa7fSvaAeBRXxY6XAkZyxltNVsQu7eeyiOlODiTeqTtnKLX5qq87mnw2W
         KXnH+RsYWVhIAu4MPSic8nSr7b0f6EKk06keZVsTmMJ+gYYgdwe0Ca9fbFmya4mVOSne
         kp5NEVfWNLW+L2jg7Vll+UXpq554WSbCSblxZLZIjVMLseGk9OHxgyx0Be/EQ5Qf4qhf
         b24g==
X-Gm-Message-State: APt69E1vE7onM4RiDic5mi2ifRT8xO45skAHmnJrG2fYWDPRpTx4Pgvs
        ByWC/AHZS8r4rfvwgudWSAay5Q==
X-Google-Smtp-Source: ADUXVKKhS5uzezvWZsJBD0PY2NqWfKItKvo0ZTTsOpoGtbEooTak21GexUthUamkKL9T0UgW/ipF8Q==
X-Received: by 2002:a17:902:981:: with SMTP id 1-v6mr25280462pln.11.1529521467245;
        Wed, 20 Jun 2018 12:04:27 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d22-v6sm7532376pfk.126.2018.06.20.12.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:04:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] crypto: shash: Remove VLA usage in unaligned hashing
Date:   Wed, 20 Jun 2018 12:04:06 -0700
Message-Id: <20180620190408.45104-10-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620190408.45104-1-keescook@chromium.org>
References: <20180620190408.45104-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this uses
the newly defined max alignment to perform unaligned hashing to avoid
VLAs, and drops the helper function while adding sanity checks on the
resulting buffer sizes.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 crypto/shash.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/crypto/shash.c b/crypto/shash.c
index ab6902c6dae7..1bb58209330a 100644
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
@@ -88,11 +81,14 @@ static int shash_update_unaligned(struct shash_desc *desc, const u8 *data,
 	unsigned long alignmask = crypto_shash_alignmask(tfm);
 	unsigned int unaligned_len = alignmask + 1 -
 				     ((unsigned long)data & alignmask);
-	u8 ubuf[shash_align_buffer_size(unaligned_len, alignmask)]
-		__aligned_largest;
+	u8 ubuf[CRYPTO_ALG_MAX_ALIGNMASK]
+		__aligned(CRYPTO_ALG_MAX_ALIGNMASK + 1);
 	u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
 	int err;
 
+	if (WARN_ON(buf + unaligned_len > ubuf + sizeof(ubuf)))
+		return -EINVAL;
+
 	if (unaligned_len > len)
 		unaligned_len = len;
 
@@ -124,11 +120,14 @@ static int shash_final_unaligned(struct shash_desc *desc, u8 *out)
 	unsigned long alignmask = crypto_shash_alignmask(tfm);
 	struct shash_alg *shash = crypto_shash_alg(tfm);
 	unsigned int ds = crypto_shash_digestsize(tfm);
-	u8 ubuf[shash_align_buffer_size(ds, alignmask)]
-		__aligned_largest;
+	u8 ubuf[SHASH_MAX_DIGESTSIZE]
+		__aligned(CRYPTO_ALG_MAX_ALIGNMASK + 1);
 	u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
 	int err;
 
+	if (WARN_ON(buf + ds > ubuf + sizeof(ubuf)))
+		return -EINVAL;
+
 	err = shash->final(desc, buf);
 	if (err)
 		goto out;
-- 
2.17.1

