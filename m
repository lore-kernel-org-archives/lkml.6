Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973B6C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A2F27984
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XKfvoyZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A2F27984
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936413AbeF2A3O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:29:14 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37497 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936385AbeF2A27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:28:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id h20-v6so1430900pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fHJ31xQtlmU2MtMHhkbeF265YqnrBtk4t2dT6Xk9FeQ=;
        b=XKfvoyZtaa/u5budf9ENKoKAnTVAm4f9zMKXi1IQJixkhpsgd643PqK3MZjr1yzwAW
         23Hc6waCp+zVJ1soIXn3mHatWtNnEaB8W+HA0yQGFgNIsFHOmzQUy2bRpmDB/K+6QeUE
         lK77B5+8aI5aXp/nonIgHyW3IzCPT4KZsEKCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fHJ31xQtlmU2MtMHhkbeF265YqnrBtk4t2dT6Xk9FeQ=;
        b=qWSVtfmUUtTCljXhsEkdS/v3+7jS8vJzyWa+e8qdWrwDcdpEw/oQok+JhfsC1/ABm7
         mohQfTed41T4+GBAJa+VlX0Kth5/wjXI80a1JZwxbBLAO4sgIDYQHmEhxscnrqMzUW6E
         rlAV8pWpEgUoB6eatMT2d/ANdK0U5bO3bzrazqqqZuf+EOA+g/lvY1mzqaWbPBevmH/w
         EaS0AxS72oNs3rW0fulMbGvzTs1gA6H95pvKhl7UIWhUjBmcwcChB/JJCLfSrqcWj4jL
         INiR5vqVvv4evuonHAqqtK6Uop0rId6dk+mvV6PQsW+1sXf3l09MZtDfbVOxm6hwqXaa
         iH/w==
X-Gm-Message-State: APt69E2W/U6sdast88WV+0mM1Dz1yINxZrwhdI8bfDT4hbyWzfYnwzRG
        +hE77VPCI9tAImXeuClLB3LoXpt1usc=
X-Google-Smtp-Source: ADUXVKKm2AEKwX0zhtsa5lBKJiVvMIJW1EIijkJf/JFv2+vAuUTYzJT7hL2ULFo6aZSiUTSPr7O5hw==
X-Received: by 2002:a65:6148:: with SMTP id o8-v6mr10407201pgv.93.1530232138800;
        Thu, 28 Jun 2018 17:28:58 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p127-v6sm10246871pfb.28.2018.06.28.17.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 17:28:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] crypto: shash: Remove VLA usage in unaligned hashing
Date:   Thu, 28 Jun 2018 17:28:43 -0700
Message-Id: <20180629002843.31095-10-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629002843.31095-1-keescook@chromium.org>
References: <20180629002843.31095-1-keescook@chromium.org>
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

