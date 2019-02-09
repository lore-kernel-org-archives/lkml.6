Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E79AC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF927218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Qfhq26PO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfBIXJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 18:09:20 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:59118 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfBIXJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 18:09:17 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id AF0715C253C;
        Sun, 10 Feb 2019 00:09:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1549753754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZIgtMFv0wRhQi5yztbI7/tU+V/Gp0KyNMz1SKbWLyE=;
        b=Qfhq26POREf6tO9daoXE2W1NV3qqk4Nlu6941Gm4j4Qf/10KKBqsKw9QSI0VIx7e3sqYYF
        WbILmBSuFKLWYSe6fl290cDQNGixll0rRDOW2LFSrIIswwF5mAAxKUSMzEvFEGP7XJVZ0E
        s8Ns1oFT2xVF7sjkSYGVOC3WOSyW0JI=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     ndesaulniers@google.com, natechancellor@gmail.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, nicolas.pitre@linaro.org,
        thierry.reding@gmail.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 2/5] ARM: use unified assembler in headers
Date:   Sun, 10 Feb 2019 00:08:59 +0100
Message-Id: <ec66f5e3424ba4a29dc61c00519c54e6abbf2609.1549753425.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1549753425.git.stefan@agner.ch>
References: <cover.1549753425.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use unified assembler syntax (UAL) in headers. Divided syntax is
considered deprecated. This will also allow to build the kernel
using LLVM's integrated assembler.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes in v2:
- Remove excessive null tokens
- Move t token before conditional token

 arch/arm/include/asm/assembler.h | 12 ++++++------
 arch/arm/include/asm/vfpmacros.h |  8 ++++----
 arch/arm/lib/bitops.h            |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 28a48e0d4cca..b59921a560da 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -376,9 +376,9 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	.macro	usraccoff, instr, reg, ptr, inc, off, cond, abort, t=TUSER()
 9999:
 	.if	\inc == 1
-	\instr\cond\()b\()\t\().w \reg, [\ptr, #\off]
+	\instr\()b\t\cond\().w \reg, [\ptr, #\off]
 	.elseif	\inc == 4
-	\instr\cond\()\t\().w \reg, [\ptr, #\off]
+	\instr\t\cond\().w \reg, [\ptr, #\off]
 	.else
 	.error	"Unsupported inc macro argument"
 	.endif
@@ -417,9 +417,9 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	.rept	\rept
 9999:
 	.if	\inc == 1
-	\instr\cond\()b\()\t \reg, [\ptr], #\inc
+	\instr\()b\t\cond \reg, [\ptr], #\inc
 	.elseif	\inc == 4
-	\instr\cond\()\t \reg, [\ptr], #\inc
+	\instr\t\cond \reg, [\ptr], #\inc
 	.else
 	.error	"Unsupported inc macro argument"
 	.endif
@@ -460,7 +460,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	.macro check_uaccess, addr:req, size:req, limit:req, tmp:req, bad:req
 #ifndef CONFIG_CPU_USE_DOMAINS
 	adds	\tmp, \addr, #\size - 1
-	sbcccs	\tmp, \tmp, \limit
+	sbcscc	\tmp, \tmp, \limit
 	bcs	\bad
 #ifdef CONFIG_CPU_SPECTRE
 	movcs	\addr, #0
@@ -474,7 +474,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	sub	\tmp, \limit, #1
 	subs	\tmp, \tmp, \addr	@ tmp = limit - 1 - addr
 	addhs	\tmp, \tmp, #1		@ if (tmp >= 0) {
-	subhss	\tmp, \tmp, \size	@ tmp = limit - (addr + size) }
+	subshs	\tmp, \tmp, \size	@ tmp = limit - (addr + size) }
 	movlo	\addr, #0		@ if (tmp < 0) addr = NULL
 	csdb
 #endif
diff --git a/arch/arm/include/asm/vfpmacros.h b/arch/arm/include/asm/vfpmacros.h
index ef5dfedacd8d..628c336e8e3b 100644
--- a/arch/arm/include/asm/vfpmacros.h
+++ b/arch/arm/include/asm/vfpmacros.h
@@ -29,13 +29,13 @@
 	ldr	\tmp, =elf_hwcap		    @ may not have MVFR regs
 	ldr	\tmp, [\tmp, #0]
 	tst	\tmp, #HWCAP_VFPD32
-	ldcnel	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d16-d31}
+	ldclne	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d16-d31}
 	addeq	\base, \base, #32*4		    @ step over unused register space
 #else
 	VFPFMRX	\tmp, MVFR0			    @ Media and VFP Feature Register 0
 	and	\tmp, \tmp, #MVFR0_A_SIMD_MASK	    @ A_SIMD field
 	cmp	\tmp, #2			    @ 32 x 64bit registers?
-	ldceql	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d16-d31}
+	ldcleq	p11, cr0, [\base],#32*4		    @ FLDMIAD \base!, {d16-d31}
 	addne	\base, \base, #32*4		    @ step over unused register space
 #endif
 #endif
@@ -53,13 +53,13 @@
 	ldr	\tmp, =elf_hwcap		    @ may not have MVFR regs
 	ldr	\tmp, [\tmp, #0]
 	tst	\tmp, #HWCAP_VFPD32
-	stcnel	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d16-d31}
+	stclne	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d16-d31}
 	addeq	\base, \base, #32*4		    @ step over unused register space
 #else
 	VFPFMRX	\tmp, MVFR0			    @ Media and VFP Feature Register 0
 	and	\tmp, \tmp, #MVFR0_A_SIMD_MASK	    @ A_SIMD field
 	cmp	\tmp, #2			    @ 32 x 64bit registers?
-	stceql	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d16-d31}
+	stcleq	p11, cr0, [\base],#32*4		    @ FSTMIAD \base!, {d16-d31}
 	addne	\base, \base, #32*4		    @ step over unused register space
 #endif
 #endif
diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index 93cddab73072..95bd35991288 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -7,7 +7,7 @@
 ENTRY(	\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
-	strneb	r1, [ip]		@ assert word-aligned
+	strbne	r1, [ip]		@ assert word-aligned
 	mov	r2, #1
 	and	r3, r0, #31		@ Get bit offset
 	mov	r0, r0, lsr #5
@@ -32,7 +32,7 @@ ENDPROC(\name		)
 ENTRY(	\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
-	strneb	r1, [ip]		@ assert word-aligned
+	strbne	r1, [ip]		@ assert word-aligned
 	mov	r2, #1
 	and	r3, r0, #31		@ Get bit offset
 	mov	r0, r0, lsr #5
@@ -62,7 +62,7 @@ ENDPROC(\name		)
 ENTRY(	\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
-	strneb	r1, [ip]		@ assert word-aligned
+	strbne	r1, [ip]		@ assert word-aligned
 	and	r2, r0, #31
 	mov	r0, r0, lsr #5
 	mov	r3, #1
@@ -89,7 +89,7 @@ ENDPROC(\name		)
 ENTRY(	\name		)
 UNWIND(	.fnstart	)
 	ands	ip, r1, #3
-	strneb	r1, [ip]		@ assert word-aligned
+	strbne	r1, [ip]		@ assert word-aligned
 	and	r3, r0, #31
 	mov	r0, r0, lsr #5
 	save_and_disable_irqs ip
-- 
2.20.1

