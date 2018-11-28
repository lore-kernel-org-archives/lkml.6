Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F180C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB162086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg/ScfA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB162086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeK1Rr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:47:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbeK1Rr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:47:56 -0500
Received: from sol.localdomain (c-24-23-142-8.hsd1.ca.comcast.net [24.23.142.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5DED21104;
        Wed, 28 Nov 2018 06:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543387641;
        bh=T5Gs/Ch/S/z8TMHiu7ATx8GrwcxUtW2aOGe2ccyXPpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qg/ScfA8eJrz+zV4qV+eNrMSilUUmyVlfI/cMeQzlPmOcJt+r6/V11owRcKVhV5e4
         EnNKb6vWKo7WG3/DOXYt396DkPosCPDyXxbHaUYaqdkFcc3K/n2n5La8j47ZyHbkxL
         e4Xpv6EfGM23YQ3R8UbnfeNg+I06YOEQg5BoAYV0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Paul Crowley <paulcrowley@google.com>,
        Martin Willi <martin@strongswan.org>,
        Milan Broz <gmazyland@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] crypto: x86/chacha - add XChaCha12 support
Date:   Tue, 27 Nov 2018 22:44:45 -0800
Message-Id: <20181128064445.3813-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181128064445.3813-1-ebiggers@kernel.org>
References: <20181128064445.3813-1-ebiggers@kernel.org>
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
index c643993a29c9f..1aa43cdd5f7cb 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -186,6 +186,21 @@ static struct skcipher_alg algs[] = {
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
 
@@ -217,3 +232,5 @@ MODULE_ALIAS_CRYPTO("chacha20");
 MODULE_ALIAS_CRYPTO("chacha20-simd");
 MODULE_ALIAS_CRYPTO("xchacha20");
 MODULE_ALIAS_CRYPTO("xchacha20-simd");
+MODULE_ALIAS_CRYPTO("xchacha12");
+MODULE_ALIAS_CRYPTO("xchacha12-simd");
diff --git a/crypto/Kconfig b/crypto/Kconfig
index ecfc10a3e9f3e..a3ee51a711447 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1473,8 +1473,8 @@ config CRYPTO_CHACHA20_X86_64
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_CHACHA20
 	help
-	  SSSE3 and AVX2 optimized implementations of the ChaCha20 and XChaCha20
-	  stream ciphers.
+	  SSSE3 and AVX2 optimized implementations of the ChaCha20, XChaCha20,
+	  and XChaCha12 stream ciphers.
 
 config CRYPTO_SEED
 	tristate "SEED cipher algorithm"
-- 
2.19.2

