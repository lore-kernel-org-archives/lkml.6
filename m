Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC849C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80652213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="de+kc9fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80652213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeJEPLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:11:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52838 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbeJEPLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:11:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so986022wmw.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BPVA95HGlQkQ8R4OJEDdFwk26jpvhoTlnJX6hJlBlqw=;
        b=de+kc9fsZ4BjBKbbhzZrYUMq4lHYmA2vJFroD9TaHnog+QwlRkYWgz+hr1/fdeK2OC
         IyauWZM3k2PDGmd0msOw0d3zhlUGxbRNkeYk0lR3xcdIIZuvqGI85mWFDFE6IkdE4zfj
         NpLaGFTYQMdPLGYkiqxBV67e30UPsXDrw4d4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BPVA95HGlQkQ8R4OJEDdFwk26jpvhoTlnJX6hJlBlqw=;
        b=KV6RdefJhlVokYUxOfUyo71DzANRGw7rByiq+LMXzQqI+DOEsiGM0/UtmZxOs+2Cwj
         dxAVIL7lRuEc3LfNLMd0lyrgz2nr5Wjcb8HP2VW8sC3FXqJy0+oQtv2DddsVnUoQe0tk
         wesG/3JpXf8IltIjZ4KG7m3DxyEofwvUzFreKNkfqYaDeRYLTPKO1oyEgYjSCm98vJYR
         mIe9RFrU3+WSgkZkqHMyL9wXl0k+B6fV9zPISayRhEO095DJZeFAUYo8wqTRA1ahZJWk
         lVyTX7WZ30u5LD0o7neuNDHT/gq2Z3BcNTGerEIppaA7voIeie21C8Vn3DarnRQhtFgJ
         Uilw==
X-Gm-Message-State: ABuFfoix6WqBHvs6HIVE1SnUaYruECpQt5Al5bu2oQlqXijS1FAaUrK5
        PuHsjOxTMkqJChyyFZaHzBm9x36bLYk=
X-Google-Smtp-Source: ACcGV60xeceEtoHxfm1bbZfKafUhAMdCLJMw2SQJGQ5J07UpIu3go71Nyk67nKveVB8EbZmX6TsamQ==
X-Received: by 2002:a1c:af07:: with SMTP id y7-v6mr7208461wme.12.1538727226568;
        Fri, 05 Oct 2018 01:13:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
        by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:13:45 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 5/9] crypto: crc-t10dif/arm64 - move PMULL based code into core library
Date:   Fri,  5 Oct 2018 10:13:29 +0200
Message-Id: <20181005081333.15018-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PMULL based routines out of the crypto API into the core
CRC-T10DIF library.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/crct10dif-ce-glue.c | 61 +++++---------------
 1 file changed, 14 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/crypto/crct10dif-ce-glue.c b/arch/arm64/crypto/crct10dif-ce-glue.c
index b461d62023f2..c67db86aba2c 100644
--- a/arch/arm64/crypto/crct10dif-ce-glue.c
+++ b/arch/arm64/crypto/crct10dif-ce-glue.c
@@ -10,13 +10,12 @@
 
 #include <linux/cpufeature.h>
 #include <linux/crc-t10dif.h>
+#include <linux/ffp.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
 
-#include <crypto/internal/hash.h>
-
 #include <asm/neon.h>
 #include <asm/simd.h>
 
@@ -25,27 +24,17 @@
 asmlinkage u16 crc_t10dif_pmull_p64(u16 init_crc, const u8 buf[], u64 len);
 asmlinkage u16 crc_t10dif_pmull_p8(u16 init_crc, const u8 buf[], u64 len);
 
-static u16 (*crc_t10dif_pmull)(u16 init_crc, const u8 buf[], u64 len);
-
-static int crct10dif_init(struct shash_desc *desc)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*crc = 0;
-	return 0;
-}
+DEFINE_FFP(crc_t10dif_pmull, crc_t10dif_pmull_p8);
 
-static int crct10dif_update(struct shash_desc *desc, const u8 *data,
-			    unsigned int length)
+static __u16 crct10dif_update_arm64(u16 crc, const u8 *data, unsigned int length)
 {
-	u16 *crc = shash_desc_ctx(desc);
 	unsigned int l;
 
 	if (unlikely((u64)data % CRC_T10DIF_PMULL_CHUNK_SIZE)) {
 		l = min_t(u32, length, CRC_T10DIF_PMULL_CHUNK_SIZE -
 			  ((u64)data % CRC_T10DIF_PMULL_CHUNK_SIZE));
 
-		*crc = crc_t10dif_generic(*crc, data, l);
+		crc = crc_t10dif_generic(crc, data, l);
 
 		length -= l;
 		data += l;
@@ -54,51 +43,31 @@ static int crct10dif_update(struct shash_desc *desc, const u8 *data,
 	if (length > 0) {
 		if (may_use_simd()) {
 			kernel_neon_begin();
-			*crc = crc_t10dif_pmull(*crc, data, length);
+			crc = crc_t10dif_pmull(crc, data, length);
 			kernel_neon_end();
 		} else {
-			*crc = crc_t10dif_generic(*crc, data, length);
+			crc = crc_t10dif_generic(crc, data, length);
 		}
 	}
 
-	return 0;
-}
-
-static int crct10dif_final(struct shash_desc *desc, u8 *out)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*(u16 *)out = *crc;
-	return 0;
+	return crc;
 }
 
-static struct shash_alg crc_t10dif_alg = {
-	.digestsize		= CRC_T10DIF_DIGEST_SIZE,
-	.init			= crct10dif_init,
-	.update			= crct10dif_update,
-	.final			= crct10dif_final,
-	.descsize		= CRC_T10DIF_DIGEST_SIZE,
-
-	.base.cra_name		= "crct10dif",
-	.base.cra_driver_name	= "crct10dif-arm64-ce",
-	.base.cra_priority	= 200,
-	.base.cra_blocksize	= CRC_T10DIF_BLOCK_SIZE,
-	.base.cra_module	= THIS_MODULE,
-};
-
 static int __init crc_t10dif_mod_init(void)
 {
 	if (elf_hwcap & HWCAP_PMULL)
-		crc_t10dif_pmull = crc_t10dif_pmull_p64;
-	else
-		crc_t10dif_pmull = crc_t10dif_pmull_p8;
+		SET_FFP(crc_t10dif_pmull, crc_t10dif_pmull_p64);
 
-	return crypto_register_shash(&crc_t10dif_alg);
+	SET_FFP(crc_t10dif_update_arch, crct10dif_update_arm64);
+
+	return 0;
 }
 
 static void __exit crc_t10dif_mod_exit(void)
 {
-	crypto_unregister_shash(&crc_t10dif_alg);
+	RESET_FFP(crc_t10dif_update_arch);
+	/* wait for all users to switch back to the old version */
+	synchronize_rcu();
 }
 
 module_cpu_feature_match(ASIMD, crc_t10dif_mod_init);
@@ -106,5 +75,3 @@ module_exit(crc_t10dif_mod_exit);
 
 MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS_CRYPTO("crct10dif");
-MODULE_ALIAS_CRYPTO("crct10dif-arm64-ce");
-- 
2.11.0

