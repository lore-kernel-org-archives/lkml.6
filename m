Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934550AbeBLNws (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:52:48 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:37262 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934522AbeBLNwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:52:46 -0500
X-Google-Smtp-Source: AH8x2261clWSvnfkqv51BKLFC6x0DyvTDxOJaCHJp/cOPP/KnFjj7IinzSGECoTKSgDtCsa/ZmaBHw==
Date: Mon, 12 Feb 2018 22:52:37 +0900
From: Jinbum Park <jinb.park7@gmail.com>
To: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
        ard.biesheuvel@linaro.org
Subject: [PATCH] crypto: arm/aes-cipher - move S-box to .rodata section
Message-ID: <20180212135237.GA3011@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the AES inverse S-box to the .rodata section
where it is safe from abuse by speculation.

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
---
 arch/arm/crypto/aes-cipher-core.S | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/crypto/aes-cipher-core.S b/arch/arm/crypto/aes-cipher-core.S
index 54b3840..184d6c2 100644
--- a/arch/arm/crypto/aes-cipher-core.S
+++ b/arch/arm/crypto/aes-cipher-core.S
@@ -174,6 +174,16 @@
 	.ltorg
 	.endm
 
+ENTRY(__aes_arm_encrypt)
+	do_crypt	fround, crypto_ft_tab, crypto_ft_tab + 1, 2
+ENDPROC(__aes_arm_encrypt)
+
+	.align		5
+ENTRY(__aes_arm_decrypt)
+	do_crypt	iround, crypto_it_tab, __aes_arm_inverse_sbox, 0
+ENDPROC(__aes_arm_decrypt)
+
+	.section	".rodata", "a"
 	.align		L1_CACHE_SHIFT
 	.type		__aes_arm_inverse_sbox, %object
 __aes_arm_inverse_sbox:
@@ -210,12 +220,3 @@ __aes_arm_inverse_sbox:
 	.byte		0x17, 0x2b, 0x04, 0x7e, 0xba, 0x77, 0xd6, 0x26
 	.byte		0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d
 	.size		__aes_arm_inverse_sbox, . - __aes_arm_inverse_sbox
-
-ENTRY(__aes_arm_encrypt)
-	do_crypt	fround, crypto_ft_tab, crypto_ft_tab + 1, 2
-ENDPROC(__aes_arm_encrypt)
-
-	.align		5
-ENTRY(__aes_arm_decrypt)
-	do_crypt	iround, crypto_it_tab, __aes_arm_inverse_sbox, 0
-ENDPROC(__aes_arm_decrypt)
-- 
1.9.1
