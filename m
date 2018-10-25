Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458BFECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE9220869
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="es0ZK75X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE9220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeJYWsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbeJYWsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:16 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D43032085A;
        Thu, 25 Oct 2018 14:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476919;
        bh=CIBOZAugqCEte1nJc7quNpkpOjQXgdyjfJLJNtl9xhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=es0ZK75X5ZwMvu+aG+fdYUfwxS3pXa4rMa4PawUBPFxihp/3V2JYSDJ5c+I69YdWz
         Fdk3tpXdJ5nDp8ci1MSOA0BhnZG9SE9IOay5CQhTI0/oOTL99vm8ZQ1UYKqRl5umxR
         BjC1MpXCTubHhDpgjeeGdy0AAEfdbVFdK0PCs8B8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 37/98] ARM: 8677/1: boot/compressed: fix decompressor header layout for v7-M
Date:   Thu, 25 Oct 2018 10:13:22 -0400
Message-Id: <20181025141423.213774-37-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[ Upstream commit 06a4b6d009a1b74a6ec46c5418b46cc53a79fcb8 ]

As reported by Patrice, the header layout of the decompressor is
incorrect when building for v7-M. In this case, the __nop macro
resolves to 'mov r0, r0', which is emitted as a narrow encoding,
resulting in the header data fields to end up at lower offsets than
required.

Given the variety of targets we need to support with the same code,
the startup sequence is a bit of a jumble, and uses instructions
and macros whose encoding widths cannot be specified (badr), or only
exist in a narrow encoding (bx)

So force the use of a wide encoding in __nop, and replace the start
sequence with a simple jump to the label marking the start of code,
preceded by a Thumb2 mode switch if required (using explicit wide
encodings where appropriate). The label itself can be moved to the
start of code [where it belongs] due to the larger range of branch
instructions as compared to adr instructions.

Reported-by: Patrice CHOTARD <patrice.chotard@st.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/compressed/efi-header.S |  4 +---
 arch/arm/boot/compressed/head.S       | 17 ++++++++++-------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/compressed/efi-header.S b/arch/arm/boot/compressed/efi-header.S
index 9d5dc4fda3c1..3f7d1b74c5e0 100644
--- a/arch/arm/boot/compressed/efi-header.S
+++ b/arch/arm/boot/compressed/efi-header.S
@@ -17,14 +17,12 @@
 		@ there.
 		.inst	'M' | ('Z' << 8) | (0x1310 << 16)   @ tstne r0, #0x4d000
 #else
-		mov	r0, r0
+		W(mov)	r0, r0
 #endif
 		.endm
 
 		.macro	__EFI_HEADER
 #ifdef CONFIG_EFI_STUB
-		b	__efi_start
-
 		.set	start_offset, __efi_start - start
 		.org	start + 0x3c
 		@
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index fc6d541549a2..2d7f2bb0d66a 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -130,19 +130,22 @@ start:
 		.rept	7
 		__nop
 		.endr
-   ARM(		mov	r0, r0		)
-   ARM(		b	1f		)
- THUMB(		badr	r12, 1f		)
- THUMB(		bx	r12		)
+#ifndef CONFIG_THUMB2_KERNEL
+		mov	r0, r0
+#else
+ AR_CLASS(	sub	pc, pc, #3	)	@ A/R: switch to Thumb2 mode
+  M_CLASS(	nop.w			)	@ M: already in Thumb2 mode
+		.thumb
+#endif
+		W(b)	1f
 
 		.word	_magic_sig	@ Magic numbers to help the loader
 		.word	_magic_start	@ absolute load/run zImage address
 		.word	_magic_end	@ zImage end address
 		.word	0x04030201	@ endianness flag
 
- THUMB(		.thumb			)
-1:		__EFI_HEADER
-
+		__EFI_HEADER
+1:
  ARM_BE8(	setend	be		)	@ go BE8 if compiled for BE8
  AR_CLASS(	mrs	r9, cpsr	)
 #ifdef CONFIG_ARM_VIRT_EXT
-- 
2.17.1

