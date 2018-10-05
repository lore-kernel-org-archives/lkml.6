Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B91C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927D72098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8esmuRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927D72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeJEPLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:11:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50676 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbeJEPL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:11:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id s12-v6so991527wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J4kMEdjdjyVuuZO5lYFdItsW+zGD6WfP39sVuKslDsg=;
        b=e8esmuRCIp6ko/JwvDO3kBBIs0dTMMN1wtG2whhv2f4XMHEle3rjYH89bQUST5qiFq
         y01wiSYV80GPMjl+jFCfCvbACNJysosMxzXmakYDLal79M0Jvjtc315CNojt1VlrX3wv
         1kEIFKnSbXS0TIqiC1s6eOzAaXSjfGUTetKb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J4kMEdjdjyVuuZO5lYFdItsW+zGD6WfP39sVuKslDsg=;
        b=lTI/acK2eCmEjFOCsrki+PHgktjyu70/3q4G9qWd3vNh6dVRCVjuWODnI/S3BU6qyP
         4o0vmRTThBsupRK2wtpxCKrjYOoclEX1T364qPYTxfARmw9q5h3jOiCKGNuBQBN2hOuf
         F++V27y/J9vxI2Pa2CcGfgQ7zerOf1vJx2VL/Y4rMeOT/ZRqBTSa7PW6AEmkflGbbAR7
         jGlArXKmP2D8p+fMLrjZKgj1LczlDbVg/DpGzav0h/kqEmC4JWltBCgGJnicHk/xrqVb
         U8S2xBI8h4V9bXEX7KiUZPsPjJafn8LeEUhxKaWLgaUsgowQrQGddcq7+PYU/QOdVfar
         6OGw==
X-Gm-Message-State: ABuFfog6hk7ZaopCKKE6FjWMAcbW9QL7oB/b0KQq7Sk+h3P8iY7P3zSU
        7RpKz9PHElRLvrvB70OIDZtmBNMlO14=
X-Google-Smtp-Source: ACcGV61Ibe9AAfd/NquSGQgeZdTsN3JKQyq9DGyJgyEhxqZ5dP7RSW7Wle9DnyJkVviljI3UE2oc5w==
X-Received: by 2002:a1c:14d1:: with SMTP id 200-v6mr7368323wmu.106.1538727231291;
        Fri, 05 Oct 2018 01:13:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
        by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 01:13:50 -0700 (PDT)
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
Subject: [RFC PATCH 8/9] crypto: crc-t10dif/powerpc - move PMULL based code into core library
Date:   Fri,  5 Oct 2018 10:13:32 +0200
Message-Id: <20181005081333.15018-9-ard.biesheuvel@linaro.org>
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
 arch/powerpc/crypto/crct10dif-vpmsum_glue.c | 55 +++-----------------
 1 file changed, 6 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/crypto/crct10dif-vpmsum_glue.c b/arch/powerpc/crypto/crct10dif-vpmsum_glue.c
index 02ea277863d1..a4db7ecc0ccc 100644
--- a/arch/powerpc/crypto/crct10dif-vpmsum_glue.c
+++ b/arch/powerpc/crypto/crct10dif-vpmsum_glue.c
@@ -11,8 +11,8 @@
  */
 
 #include <linux/crc-t10dif.h>
-#include <crypto/internal/hash.h>
 #include <linux/init.h>
+#include <linux/ffp.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -63,59 +63,18 @@ static u16 crct10dif_vpmsum(u16 crci, unsigned char const *p, size_t len)
 	return crc & 0xffff;
 }
 
-static int crct10dif_vpmsum_init(struct shash_desc *desc)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*crc = 0;
-	return 0;
-}
-
-static int crct10dif_vpmsum_update(struct shash_desc *desc, const u8 *data,
-			    unsigned int length)
-{
-	u16 *crc = shash_desc_ctx(desc);
-
-	*crc = crct10dif_vpmsum(*crc, data, length);
-
-	return 0;
-}
-
-
-static int crct10dif_vpmsum_final(struct shash_desc *desc, u8 *out)
-{
-	u16 *crcp = shash_desc_ctx(desc);
-
-	*(u16 *)out = *crcp;
-	return 0;
-}
-
-static struct shash_alg alg = {
-	.init		= crct10dif_vpmsum_init,
-	.update		= crct10dif_vpmsum_update,
-	.final		= crct10dif_vpmsum_final,
-	.descsize	= CRC_T10DIF_DIGEST_SIZE,
-	.digestsize	= CRC_T10DIF_DIGEST_SIZE,
-	.base		= {
-		.cra_name		= "crct10dif",
-		.cra_driver_name	= "crct10dif-vpmsum",
-		.cra_priority		= 200,
-		.cra_blocksize		= CRC_T10DIF_BLOCK_SIZE,
-		.cra_module		= THIS_MODULE,
-	}
-};
-
 static int __init crct10dif_vpmsum_mod_init(void)
 {
-	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
-		return -ENODEV;
+	SET_FFP(crc_t10dif_update_arch, crct10dif_vpmsum);
 
-	return crypto_register_shash(&alg);
+	return 0;
 }
 
 static void __exit crct10dif_vpmsum_mod_fini(void)
 {
-	crypto_unregister_shash(&alg);
+	RESET_FFP(crc_t10dif_update_arch);
+	/* wait for all users to switch back to the old version */
+	synchronize_rcu();
 }
 
 module_cpu_feature_match(PPC_MODULE_FEATURE_VEC_CRYPTO, crct10dif_vpmsum_mod_init);
@@ -124,5 +83,3 @@ module_exit(crct10dif_vpmsum_mod_fini);
 MODULE_AUTHOR("Daniel Axtens <dja@axtens.net>");
 MODULE_DESCRIPTION("CRCT10DIF using vector polynomial multiply-sum instructions");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_CRYPTO("crct10dif");
-MODULE_ALIAS_CRYPTO("crct10dif-vpmsum");
-- 
2.11.0

