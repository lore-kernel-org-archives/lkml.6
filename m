Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E1CC64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445CF20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEFhbF6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445CF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeK3KLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:11:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbeK3KKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:10:35 -0500
Received: from ebiggers.mtv.corp.google.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 938242147D;
        Thu, 29 Nov 2018 23:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543532607;
        bh=nBC9OVb3aNTteHpgQGScNZRTgOQT0CvFyx0FsakJaAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XEFhbF6NuTyY8Si1Wl/P81ibnipLPIEfJHluVBjbnHd5UadlIJkY5xLNSkqzWyeim
         cXq7NsVzz5AtqX0XFOgMrYm9SjWpepUcDI9Y70vvBsWnnUT22q3/XXyDlA8WwmCF2k
         iH5FfAyhFjJQip/O5UvoXBc1VsDXSc3KDYB9N8KI=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Paul Crowley <paulcrowley@google.com>,
        Martin Willi <martin@strongswan.org>,
        Milan Broz <gmazyland@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] crypto: x86/chacha - add XChaCha12 support
Date:   Thu, 29 Nov 2018 15:02:17 -0800
Message-Id: <20181129230217.158038-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181129230217.158038-1-ebiggers@kernel.org>
References: <20181129230217.158038-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that the x86_64 SIMD implementations of ChaCha20 and XChaCha20 have
been refactored to support varying the number of rounds, add support for
XChaCha12.  This is identical to XChaCha20 except for the number of
rounds, which is 12 instead of 20.  This can be used by Adiantum.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/chacha_glue.c | 17 +++++++++++++++++
 crypto/Kconfig                |  4 ++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index 83cfb450b816..3db775852205 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -225,6 +225,21 @@ static struct skcipher_alg algs[] = {
 		.setkey			= crypto_chacha20_setkey,
 		.encrypt		= xchacha_simd,
 		.decrypt		= xchacha_simd,
+	}, {
+		.base.cra_name		= "xchacha12",
+		.base.cra_driver_name	= "xchacha12-simd",
+		.base.cra_priority	= 300,
+		.base.cra_blocksize	= 1,
+		.base.cra_ctxsize	= sizeof(struct chacha_ctx),
+		.base.cra_module	= THIS_MODULE,
+
+		.min_keysize		= CHACHA_KEY_SIZE,
+		.max_keysize		= CHACHA_KEY_SIZE,
+		.ivsize			= XCHACHA_IV_SIZE,
+		.chunksize		= CHACHA_BLOCK_SIZE,
+		.setkey			= crypto_chacha12_setkey,
+		.encrypt		= xchacha_simd,
+		.decrypt		= xchacha_simd,
 	},
 };
 
@@ -261,3 +276,5 @@ MODULE_ALIAS_CRYPTO("chacha20");
 MODULE_ALIAS_CRYPTO("chacha20-simd");
 MODULE_ALIAS_CRYPTO("xchacha20");
 MODULE_ALIAS_CRYPTO("xchacha20-simd");
+MODULE_ALIAS_CRYPTO("xchacha12");
+MODULE_ALIAS_CRYPTO("xchacha12-simd");
diff --git a/crypto/Kconfig b/crypto/Kconfig
index df466771e9bf..29865c599b04 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1473,8 +1473,8 @@ config CRYPTO_CHACHA20_X86_64
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_CHACHA20
 	help
-	  SSSE3, AVX2, and AVX-512VL optimized implementations of the ChaCha20
-	  and XChaCha20 stream ciphers.
+	  SSSE3, AVX2, and AVX-512VL optimized implementations of the ChaCha20,
+	  XChaCha20, and XChaCha12 stream ciphers.
 
 config CRYPTO_SEED
 	tristate "SEED cipher algorithm"
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

