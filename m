Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707C2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3590420989
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLcJOvsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3590420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbeKFItk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:49:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbeKFItO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:49:14 -0500
Received: from ebiggers-linuxstation.kir.corp.google.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A757320882;
        Mon,  5 Nov 2018 23:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541460423;
        bh=UfVOfpNm8KumA3Dquyb1Ebjv7QdPISAdQPzqU9X5I5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLcJOvsZfYUcdcvRuhx1XxV8QeymOvIeZ12oyz281QuN6iZOATsfWcYSNPpGWGzH9
         Hdmx25fmgFFFMtmPYiMZJhaQ6rxbHbnmmnix0ryeTdL9FPDGx0+ozGsHye7QE9yqzb
         BZAXnJYGhs53KQUANxT8ylz6mf8wyTpp0gRbsric=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>
Subject: [RFC PATCH v3 09/15] crypto: arm/chacha - add XChaCha12 support
Date:   Mon,  5 Nov 2018 15:25:20 -0800
Message-Id: <20181105232526.173947-10-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181105232526.173947-1-ebiggers@kernel.org>
References: <20181105232526.173947-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that the 32-bit ARM NEON implementation of ChaCha20 and XChaCha20
has been refactored to support varying the number of rounds, add support
for XChaCha12.  This is identical to XChaCha20 except for the number of
rounds, which is 12 instead of 20.

XChaCha12 is faster than XChaCha20 but has a lower security margin,
though still greater than AES-256's since the best known attacks make it
through only 7 rounds.  See the patch "crypto: chacha - add XChaCha12
support" for more details about why we need XChaCha12 support.

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/crypto/Kconfig            |  2 +-
 arch/arm/crypto/chacha-neon-glue.c | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index 0aa1471f27d2..cc932d9bba56 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -117,7 +117,7 @@ config CRYPTO_CRC32_ARM_CE
 	select CRYPTO_HASH
 
 config CRYPTO_CHACHA20_NEON
-	tristate "NEON accelerated ChaCha20 stream cipher algorithms"
+	tristate "NEON accelerated ChaCha stream cipher algorithms"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_CHACHA20
diff --git a/arch/arm/crypto/chacha-neon-glue.c b/arch/arm/crypto/chacha-neon-glue.c
index 385557d38634..9d6fda81986d 100644
--- a/arch/arm/crypto/chacha-neon-glue.c
+++ b/arch/arm/crypto/chacha-neon-glue.c
@@ -1,5 +1,6 @@
 /*
- * ChaCha20 (RFC7539) and XChaCha20 stream ciphers, NEON accelerated
+ * ARM NEON accelerated ChaCha and XChaCha stream ciphers,
+ * including ChaCha20 (RFC7539)
  *
  * Copyright (C) 2016 Linaro, Ltd. <ard.biesheuvel@linaro.org>
  *
@@ -154,6 +155,22 @@ static struct skcipher_alg algs[] = {
 		.setkey			= crypto_chacha20_setkey,
 		.encrypt		= xchacha_neon,
 		.decrypt		= xchacha_neon,
+	}, {
+		.base.cra_name		= "xchacha12",
+		.base.cra_driver_name	= "xchacha12-neon",
+		.base.cra_priority	= 300,
+		.base.cra_blocksize	= 1,
+		.base.cra_ctxsize	= sizeof(struct chacha_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= CHACHA_KEY_SIZE,
+		.max_keysize		= CHACHA_KEY_SIZE,
+		.ivsize			= XCHACHA_IV_SIZE,
+		.chunksize		= CHACHA_BLOCK_SIZE,
+		.walksize		= 4 * CHACHA_BLOCK_SIZE,
+		.setkey			= crypto_chacha12_setkey,
+		.encrypt		= xchacha_neon,
+		.decrypt		= xchacha_neon,
 	}
 };
 
@@ -180,3 +197,5 @@ MODULE_ALIAS_CRYPTO("chacha20");
 MODULE_ALIAS_CRYPTO("chacha20-neon");
 MODULE_ALIAS_CRYPTO("xchacha20");
 MODULE_ALIAS_CRYPTO("xchacha20-neon");
+MODULE_ALIAS_CRYPTO("xchacha12");
+MODULE_ALIAS_CRYPTO("xchacha12-neon");
-- 
2.19.1.930.g4563a0d9d0-goog

