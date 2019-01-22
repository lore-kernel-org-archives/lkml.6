Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A02AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E0020870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfAVNbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:31:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33483 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfAVNbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:31:50 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MDVY5d2962327
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 05:31:34 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MDVYbI2962324;
        Tue, 22 Jan 2019 05:31:34 -0800
Date:   Tue, 22 Jan 2019 05:31:34 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-bae54dc4f353653bbd3e3081754adad05da1d4dd@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, bp@suse.de, mingo@redhat.com,
        bigeasy@linutronix.de, hpa@zytor.com
Reply-To: bp@suse.de, hpa@zytor.com, mingo@redhat.com,
          bigeasy@linutronix.de, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, luto@kernel.org
In-Reply-To: <20190117232408.GH5023@zn.tnic>
References: <20190117232408.GH5023@zn.tnic>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Get rid of CONFIG_AS_FXSAVEQ
Git-Commit-ID: bae54dc4f353653bbd3e3081754adad05da1d4dd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bae54dc4f353653bbd3e3081754adad05da1d4dd
Gitweb:     https://git.kernel.org/tip/bae54dc4f353653bbd3e3081754adad05da1d4dd
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 18 Jan 2019 00:05:40 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 22 Jan 2019 14:16:39 +0100

x86/fpu: Get rid of CONFIG_AS_FXSAVEQ

This was a "workaround" to probe for binutils which could generate
FXSAVEQ, apparently gas with min version 2.16. In the meantime, minimal
required gas version is 2.20 so all those workarounds for older binutils
can be dropped.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20190117232408.GH5023@zn.tnic
---
 arch/x86/Makefile                   |  1 -
 arch/x86/include/asm/fpu/internal.h | 50 +++++--------------------------------
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
