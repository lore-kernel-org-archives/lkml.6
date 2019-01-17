Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1429C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F1C20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="OcEeJ7w8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfAQXYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:24:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51266 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfAQXYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:24:15 -0500
Received: from zn.tnic (p200300EC2BCAA90039C8CE17CD8BEE66.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:a900:39c8:ce17:cd8b:ee66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1722D1EC0A34;
        Fri, 18 Jan 2019 00:24:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547767454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=6WecO7MilSYOMqnStGMajXViVChh4Gk4c39JkP98XPs=;
        b=OcEeJ7w8UiExKnsXyp5gL5VVTGKBODlVj/M5OilSGdDbranEh1sQRQqmgt9yK3ZwHBs9MG
        i4rJJAysHzlb/W3bJ0HA400CR3fbZpJ+rnAURqW7tj6oGc4YljNBARvkqukjVuKQYypnhr
        snODyRLGL7dbBcejdesewFU8tcg0KQA=
Date:   Fri, 18 Jan 2019 00:24:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/fpu: Get rid of CONFIG_AS_FXSAVEQ
Message-ID: <20190117232408.GH5023@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One more cleanup resulting from me staring at bigeasy's FPU patchset.
I've tested building this in an old debian guest which has binutils 2.22
and gcc 4.6, the last being the oldest gcc we support.

echo "fxsaveq (%rax)" | gcc -c -x assembler -o /tmp/t.o -

with gas 2.20 works too, 2.20 being the minimum binutils version we require in
Documentation/process/changes.rst

--
From: Borislav Petkov <bp@suse.de>

This was a "workaround" to probe for binutils which could generate
FXSAVEQ, apparently gas with min version 2.16. In the meantime, minimal
required gas version is 2.20 so all those workarounds for older binutils
can be dropped.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/Makefile                   |  1 -
 arch/x86/include/asm/fpu/internal.h | 50 ++++-------------------------
 2 files changed, 6 insertions(+), 45 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 9c5a67d1b9c1..76bc4dc03d5e 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -187,7 +187,6 @@ cfi-sigframe := $(call as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,
 cfi-sections := $(call as-instr,.cfi_sections .debug_frame,-DCONFIG_AS_CFI_SECTIONS=1)
 
 # does binutils support specific instructions?
-asinstr := $(call as-instr,fxsaveq (%rax),-DCONFIG_AS_FXSAVEQ=1)
 asinstr += $(call as-instr,pshufb %xmm0$(comma)%xmm0,-DCONFIG_AS_SSSE3=1)
 avx_instr := $(call as-instr,vxorps %ymm0$(comma)%ymm1$(comma)%ymm2,-DCONFIG_AS_AVX=1)
 avx2_instr :=$(call as-instr,vpbroadcastb %xmm0$(comma)%ymm1,-DCONFIG_AS_AVX2=1)
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index fa2c93cb42a2..5d536e3dcc6d 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -137,37 +137,25 @@ static inline int copy_fxregs_to_user(struct fxregs_state __user *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return user_insn(fxsave %[fx], [fx] "=m" (*fx), "m" (*fx));
-	else if (IS_ENABLED(CONFIG_AS_FXSAVEQ))
+	else
 		return user_insn(fxsaveq %[fx], [fx] "=m" (*fx), "m" (*fx));
 
-	/* See comment in copy_fxregs_to_kernel() below. */
-	return user_insn(rex64/fxsave (%[fx]), "=m" (*fx), [fx] "R" (fx));
 }
 
 static inline void copy_kernel_to_fxregs(struct fxregs_state *fx)
 {
-	if (IS_ENABLED(CONFIG_X86_32)) {
+	if (IS_ENABLED(CONFIG_X86_32))
 		kernel_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
-	} else {
-		if (IS_ENABLED(CONFIG_AS_FXSAVEQ)) {
-			kernel_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
-		} else {
-			/* See comment in copy_fxregs_to_kernel() below. */
-			kernel_insn(rex64/fxrstor (%[fx]), "=m" (*fx), [fx] "R" (fx), "m" (*fx));
-		}
-	}
+	else
+		kernel_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
 static inline int copy_user_to_fxregs(struct fxregs_state __user *fx)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		return user_insn(fxrstor %[fx], "=m" (*fx), [fx] "m" (*fx));
-	else if (IS_ENABLED(CONFIG_AS_FXSAVEQ))
+	else
 		return user_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
-
-	/* See comment in copy_fxregs_to_kernel() below. */
-	return user_insn(rex64/fxrstor (%[fx]), "=m" (*fx), [fx] "R" (fx),
-			  "m" (*fx));
 }
 
 static inline void copy_kernel_to_fregs(struct fregs_state *fx)
@@ -184,34 +172,8 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
 {
 	if (IS_ENABLED(CONFIG_X86_32))
 		asm volatile( "fxsave %[fx]" : [fx] "=m" (fpu->state.fxsave));
-	else if (IS_ENABLED(CONFIG_AS_FXSAVEQ))
+	else
 		asm volatile("fxsaveq %[fx]" : [fx] "=m" (fpu->state.fxsave));
-	else {
-		/* Using "rex64; fxsave %0" is broken because, if the memory
-		 * operand uses any extended registers for addressing, a second
-		 * REX prefix will be generated (to the assembler, rex64
-		 * followed by semicolon is a separate instruction), and hence
-		 * the 64-bitness is lost.
-		 *
-		 * Using "fxsaveq %0" would be the ideal choice, but is only
-		 * supported starting with gas 2.16.
-		 *
-		 * Using, as a workaround, the properly prefixed form below
-		 * isn't accepted by any binutils version so far released,
-		 * complaining that the same type of prefix is used twice if
-		 * an extended register is needed for addressing (fix submitted
-		 * to mainline 2005-11-21).
-		 *
-		 *  asm volatile("rex64/fxsave %0" : "=m" (fpu->state.fxsave));
-		 *
-		 * This, however, we can work around by forcing the compiler to
-		 * select an addressing mode that doesn't require extended
-		 * registers.
-		 */
-		asm volatile( "rex64/fxsave (%[fx])"
-			     : "=m" (fpu->state.fxsave)
-			     : [fx] "R" (&fpu->state.fxsave));
-	}
 }
 
 /* These macros all use (%edi)/(%rdi) as the single memory argument. */
-- 
2.19.1

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
