Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8E1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87212086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUYZQCQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87212086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeJKFIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:08:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53808 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeJKFIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 01:08:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id y11-v6so6955605wma.3;
        Wed, 10 Oct 2018 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6pQ3DTChOHInteuP9N63ESQ5wffW2zBaffm7xBbNz8=;
        b=CUYZQCQqk0FFOGHa4PoVfy0+Pa/FrbnIMY21rQffrjIO3yGzdB2vrnIj2lGDPTX6Zm
         gcewoVjANCJvuwCWHNjRB/8sd8HwvJ840/FgVAM3jJgHXfNcpZthkVryBW2zxnZZc6Hd
         kres3zBrziHprF7Oy6HI/FDLgn0QFXQPRB9Ij6thgkQpGB1Q0qxN/N2aOGLI6zSIPkY8
         7x2NWdgOJJLcI4IH2rhNlRr8PS4xAWS7NJZMw1z6KnDnE5O37OtSMGeHnIsJeB3oD1kI
         KtLu+fFoP34DrlCR2NJErTgZpELoa/SZMV50XDrpT2mNmnEhuIFXOG0MFbAMAQIorYzu
         KP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6pQ3DTChOHInteuP9N63ESQ5wffW2zBaffm7xBbNz8=;
        b=cBhBHqvvlieedTvcnRSgLPGp+nZ0xqAXVqnbguiUNLsCJ+0jsJ25IYN7PnuZpIf7VO
         WXnD8u/FMTawEWk6QiJ7jSyexoznlfHvgoMHUlF4huwquJDmglOoD+2Xyf4CwCMLyvNb
         EM26V8cC0cqFKoW6DmRkkHC2z6HK2bGgUXrd+1hSU+Gxl0nDLgQ4uEkDZ2913/Fzr9WV
         mTsuxL7vHyQDaxBUNH5GbyBCgHqlvfsDJImq9cI0atZ9pcy32o/PFoIVrcEwRGA8mJv8
         GeAAbn2sHs0IIhrqn2/wWGP/7q1/klKTuHKHlIIFq0NVKQyeimsfip16aC9qbeNxIPWt
         Yy+Q==
X-Gm-Message-State: ABuFfog/HQdNCgORodrgYlneEjn8vxYZU3KHp3rOoiJMCT55ymQywMGV
        KTx+nJ6Q6n0bI1QPgJmRNEI=
X-Google-Smtp-Source: ACcGV610B4YQGi1Yp9CUu21YgTCMPt5qh0v6ejAZ0QvKlx7FefOh8kn6UJciimChItVX2u+6BQ3+BQ==
X-Received: by 2002:a1c:710:: with SMTP id 16-v6mr2312785wmh.22.1539207887686;
        Wed, 10 Oct 2018 14:44:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id v1-v6sm21563515wrd.24.2018.10.10.14.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 14:44:46 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] crypto: ccree - avoid implicit enum conversion
Date:   Wed, 10 Oct 2018 14:40:07 -0700
Message-Id: <20181010214006.21304-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another
and this happens in several locations in this driver, ultimately related
to the set_cipher_{mode,config0} functions. set_cipher_mode expects a mode
of type drv_cipher_mode and set_cipher_config0 expects a mode of type
drv_crypto_direction.

drivers/crypto/ccree/cc_ivgen.c:58:35: warning: implicit conversion from
enumeration type 'enum cc_desc_direction' to different enumeration type
'enum drv_crypto_direction' [-Wenum-conversion]
        set_cipher_config0(&iv_seq[idx], DESC_DIRECTION_ENCRYPT_ENCRYPT);

drivers/crypto/ccree/cc_hash.c:99:28: warning: implicit conversion from
enumeration type 'enum cc_hash_conf_pad' to different enumeration type
'enum drv_crypto_direction' [-Wenum-conversion]
                set_cipher_config0(desc, HASH_DIGEST_RESULT_LITTLE_ENDIAN);

drivers/crypto/ccree/cc_aead.c:1643:30: warning: implicit conversion
from enumeration type 'enum drv_hash_hw_mode' to different enumeration
type 'enum drv_cipher_mode' [-Wenum-conversion]
        set_cipher_mode(&desc[idx], DRV_HASH_HW_GHASH);

Since this fundamentally isn't a problem because these values just
represent simple integers for a shift operation, make it clear to Clang
that this is okay by making the mode parameter in both functions an int.

Link: https://github.com/ClangBuiltLinux/linux/issues/46
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Alternatively:

1. The uses of DESC_DIRECTION_ENCRYPT_ENCRYPT could be replaced with
   DRV_CRYPTO_DIRECTION_ENCRYPT since they are the same value.

2. An enum of value 2 could be added to drv_crypto_direction which is
   what HASH_DIGEST_RESULT_LITTLE_ENDIAN is equal to (not sure what that
   should be named).

3. DRV_HASH_HW_GHASH could be removed and replaced with DRV_CIPHER_OFB
   since they are the same value.

This patch seems to make the most sense to me given that the enums are
just functioning as integers but I'm willing to fix this however the
maintainers want.

 drivers/crypto/ccree/cc_hw_queue_defs.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/ccree/cc_hw_queue_defs.h b/drivers/crypto/ccree/cc_hw_queue_defs.h
index a091ae57f902..45985b955d2c 100644
--- a/drivers/crypto/ccree/cc_hw_queue_defs.h
+++ b/drivers/crypto/ccree/cc_hw_queue_defs.h
@@ -449,8 +449,7 @@ static inline void set_flow_mode(struct cc_hw_desc *pdesc,
  * @pdesc: pointer HW descriptor struct
  * @mode:  Any one of the modes defined in [CC7x-DESC]
  */
-static inline void set_cipher_mode(struct cc_hw_desc *pdesc,
-				   enum drv_cipher_mode mode)
+static inline void set_cipher_mode(struct cc_hw_desc *pdesc, int mode)
 {
 	pdesc->word[4] |= FIELD_PREP(WORD4_CIPHER_MODE, mode);
 }
@@ -461,8 +460,7 @@ static inline void set_cipher_mode(struct cc_hw_desc *pdesc,
  * @pdesc: pointer HW descriptor struct
  * @mode: Any one of the modes defined in [CC7x-DESC]
  */
-static inline void set_cipher_config0(struct cc_hw_desc *pdesc,
-				      enum drv_crypto_direction mode)
+static inline void set_cipher_config0(struct cc_hw_desc *pdesc, int mode)
 {
 	pdesc->word[4] |= FIELD_PREP(WORD4_CIPHER_CONF0, mode);
 }
-- 
2.19.1

