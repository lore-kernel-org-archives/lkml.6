Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3F4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4A82151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v0yoSBaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4A82151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388894AbeKVFqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:46:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730565AbeKVFqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:46:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73B19214DB;
        Wed, 21 Nov 2018 19:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827461;
        bh=NUHeP9I0hQZG/K20FrSpH37GXOnboJlsAGMBM3rG3Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v0yoSBaU8xkKW6ixSUR/bPsm8xB/MmUlxFGwpW+EbCrJRh6+tOnGcC9brBWTGyXMy
         PV806oAXh5oCUdJL7P0gLP/7m0C8qKwvV45n8an3gw1MzrE1XIY4/51ozHOYFf9l0l
         gFE5iIcrM8xLP9ylDoUk17qnN2iJ6Y6pq3p4ru/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "David A. Long" <dave.long@linaro.org>
Subject: [PATCH 4.9 41/59] ARM: spectre-v2: harden branch predictor on context switches
Date:   Wed, 21 Nov 2018 20:06:56 +0100
Message-Id: <20181121183509.876898234@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 06c23f5ffe7ad45b908d0fff604dae08a7e334b9 upstream.

Required manual merge of arch/arm/mm/proc-v7.S.

Harden the branch predictor against Spectre v2 attacks on context
switches for ARMv7 and later CPUs.  We do this by:

Cortex A9, A12, A17, A73, A75: invalidating the BTB.
Cortex A15, Brahma B15: invalidating the instruction cache.

Cortex A57 and Cortex A72 are not addressed in this patch.

Cortex R7 and Cortex R8 are also not addressed as we do not enforce
memory protection on these cores.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Boot-tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: David A. Long <dave.long@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mm/Kconfig          |   19 ++++++
 arch/arm/mm/proc-v7-2level.S |    6 --
 arch/arm/mm/proc-v7.S        |  125 +++++++++++++++++++++++++++++++++----------
 3 files changed, 115 insertions(+), 35 deletions(-)

--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -804,6 +804,25 @@ config CPU_BPREDICT_DISABLE
 config CPU_SPECTRE
 	bool
 
+config HARDEN_BRANCH_PREDICTOR
+	bool "Harden the branch predictor against aliasing attacks" if EXPERT
+	depends on CPU_SPECTRE
+	default y
+	help
+	   Speculation attacks against some high-performance processors rely
+	   on being able to manipulate the branch predictor for a victim
+	   context by executing aliasing branches in the attacker context.
+	   Such attacks can be partially mitigated against by clearing
+	   internal branch predictor state and limiting the prediction
+	   logic in some situations.
+
+	   This config option will take CPU-specific actions to harden
+	   the branch predictor against aliasing attacks and may rely on
+	   specific instruction sequences or control bits being set by
+	   the system firmware.
+
+	   If unsure, say Y.
+
 config TLS_REG_EMUL
 	bool
 	select NEED_KUSER_HELPERS
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -41,11 +41,6 @@
  *	even on Cortex-A8 revisions not affected by 430973.
  *	If IBE is not set, the flush BTAC/BTB won't do anything.
  */
-ENTRY(cpu_ca8_switch_mm)
-#ifdef CONFIG_MMU
-	mov	r2, #0
-	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
-#endif
 ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_MMU
 	mmid	r1, r1				@ get mm->context.id
@@ -66,7 +61,6 @@ ENTRY(cpu_v7_switch_mm)
 #endif
 	bx	lr
 ENDPROC(cpu_v7_switch_mm)
-ENDPROC(cpu_ca8_switch_mm)
 
 /*
  *	cpu_v7_set_pte_ext(ptep, pte)
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -88,6 +88,17 @@ ENTRY(cpu_v7_dcache_clean_area)
 	ret	lr
 ENDPROC(cpu_v7_dcache_clean_area)
 
+ENTRY(cpu_v7_iciallu_switch_mm)
+	mov	r3, #0
+	mcr	p15, 0, r3, c7, c5, 0		@ ICIALLU
+	b	cpu_v7_switch_mm
+ENDPROC(cpu_v7_iciallu_switch_mm)
+ENTRY(cpu_v7_bpiall_switch_mm)
+	mov	r3, #0
+	mcr	p15, 0, r3, c7, c5, 6		@ flush BTAC/BTB
+	b	cpu_v7_switch_mm
+ENDPROC(cpu_v7_bpiall_switch_mm)
+
 	string	cpu_v7_name, "ARMv7 Processor"
 	.align
 
@@ -153,31 +164,6 @@ ENTRY(cpu_v7_do_resume)
 ENDPROC(cpu_v7_do_resume)
 #endif
 
-/*
- * Cortex-A8
- */
-	globl_equ	cpu_ca8_proc_init,	cpu_v7_proc_init
-	globl_equ	cpu_ca8_proc_fin,	cpu_v7_proc_fin
-	globl_equ	cpu_ca8_reset,		cpu_v7_reset
-	globl_equ	cpu_ca8_do_idle,	cpu_v7_do_idle
-	globl_equ	cpu_ca8_dcache_clean_area, cpu_v7_dcache_clean_area
-	globl_equ	cpu_ca8_set_pte_ext,	cpu_v7_set_pte_ext
-	globl_equ	cpu_ca8_suspend_size,	cpu_v7_suspend_size
-#ifdef CONFIG_ARM_CPU_SUSPEND
-	globl_equ	cpu_ca8_do_suspend,	cpu_v7_do_suspend
-	globl_equ	cpu_ca8_do_resume,	cpu_v7_do_resume
-#endif
-
-/*
- * Cortex-A9 processor functions
- */
-	globl_equ	cpu_ca9mp_proc_init,	cpu_v7_proc_init
-	globl_equ	cpu_ca9mp_proc_fin,	cpu_v7_proc_fin
-	globl_equ	cpu_ca9mp_reset,	cpu_v7_reset
-	globl_equ	cpu_ca9mp_do_idle,	cpu_v7_do_idle
-	globl_equ	cpu_ca9mp_dcache_clean_area, cpu_v7_dcache_clean_area
-	globl_equ	cpu_ca9mp_switch_mm,	cpu_v7_switch_mm
-	globl_equ	cpu_ca9mp_set_pte_ext,	cpu_v7_set_pte_ext
 .globl	cpu_ca9mp_suspend_size
 .equ	cpu_ca9mp_suspend_size, cpu_v7_suspend_size + 4 * 2
 #ifdef CONFIG_ARM_CPU_SUSPEND
@@ -543,10 +529,75 @@ __v7_setup_stack:
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions v7, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
+
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	@ generic v7 bpiall on context switch
+	globl_equ	cpu_v7_bpiall_proc_init,	cpu_v7_proc_init
+	globl_equ	cpu_v7_bpiall_proc_fin,		cpu_v7_proc_fin
+	globl_equ	cpu_v7_bpiall_reset,		cpu_v7_reset
+	globl_equ	cpu_v7_bpiall_do_idle,		cpu_v7_do_idle
+	globl_equ	cpu_v7_bpiall_dcache_clean_area, cpu_v7_dcache_clean_area
+	globl_equ	cpu_v7_bpiall_set_pte_ext,	cpu_v7_set_pte_ext
+	globl_equ	cpu_v7_bpiall_suspend_size,	cpu_v7_suspend_size
+#ifdef CONFIG_ARM_CPU_SUSPEND
+	globl_equ	cpu_v7_bpiall_do_suspend,	cpu_v7_do_suspend
+	globl_equ	cpu_v7_bpiall_do_resume,	cpu_v7_do_resume
+#endif
+	define_processor_functions v7_bpiall, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
+
+#define HARDENED_BPIALL_PROCESSOR_FUNCTIONS v7_bpiall_processor_functions
+#else
+#define HARDENED_BPIALL_PROCESSOR_FUNCTIONS v7_processor_functions
+#endif
+
 #ifndef CONFIG_ARM_LPAE
+	@ Cortex-A8 - always needs bpiall switch_mm implementation
+	globl_equ	cpu_ca8_proc_init,	cpu_v7_proc_init
+	globl_equ	cpu_ca8_proc_fin,	cpu_v7_proc_fin
+	globl_equ	cpu_ca8_reset,		cpu_v7_reset
+	globl_equ	cpu_ca8_do_idle,	cpu_v7_do_idle
+	globl_equ	cpu_ca8_dcache_clean_area, cpu_v7_dcache_clean_area
+	globl_equ	cpu_ca8_set_pte_ext,	cpu_v7_set_pte_ext
+	globl_equ	cpu_ca8_switch_mm,	cpu_v7_bpiall_switch_mm
+	globl_equ	cpu_ca8_suspend_size,	cpu_v7_suspend_size
+#ifdef CONFIG_ARM_CPU_SUSPEND
+	globl_equ	cpu_ca8_do_suspend,	cpu_v7_do_suspend
+	globl_equ	cpu_ca8_do_resume,	cpu_v7_do_resume
+#endif
 	define_processor_functions ca8, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
+
+	@ Cortex-A9 - needs more registers preserved across suspend/resume
+	@ and bpiall switch_mm for hardening
+	globl_equ	cpu_ca9mp_proc_init,	cpu_v7_proc_init
+	globl_equ	cpu_ca9mp_proc_fin,	cpu_v7_proc_fin
+	globl_equ	cpu_ca9mp_reset,	cpu_v7_reset
+	globl_equ	cpu_ca9mp_do_idle,	cpu_v7_do_idle
+	globl_equ	cpu_ca9mp_dcache_clean_area, cpu_v7_dcache_clean_area
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	globl_equ	cpu_ca9mp_switch_mm,	cpu_v7_bpiall_switch_mm
+#else
+	globl_equ	cpu_ca9mp_switch_mm,	cpu_v7_switch_mm
+#endif
+	globl_equ	cpu_ca9mp_set_pte_ext,	cpu_v7_set_pte_ext
 	define_processor_functions ca9mp, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 #endif
+
+	@ Cortex-A15 - needs iciallu switch_mm for hardening
+	globl_equ	cpu_ca15_proc_init,	cpu_v7_proc_init
+	globl_equ	cpu_ca15_proc_fin,	cpu_v7_proc_fin
+	globl_equ	cpu_ca15_reset,		cpu_v7_reset
+	globl_equ	cpu_ca15_do_idle,	cpu_v7_do_idle
+	globl_equ	cpu_ca15_dcache_clean_area, cpu_v7_dcache_clean_area
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	globl_equ	cpu_ca15_switch_mm,	cpu_v7_iciallu_switch_mm
+#else
+	globl_equ	cpu_ca15_switch_mm,	cpu_v7_switch_mm
+#endif
+	globl_equ	cpu_ca15_set_pte_ext,	cpu_v7_set_pte_ext
+	globl_equ	cpu_ca15_suspend_size,	cpu_v7_suspend_size
+	globl_equ	cpu_ca15_do_suspend,	cpu_v7_do_suspend
+	globl_equ	cpu_ca15_do_resume,	cpu_v7_do_resume
+	define_processor_functions ca15, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 #ifdef CONFIG_CPU_PJ4B
 	define_processor_functions pj4b, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 #endif
@@ -653,7 +704,7 @@ __v7_ca7mp_proc_info:
 __v7_ca12mp_proc_info:
 	.long	0x410fc0d0
 	.long	0xff0ffff0
-	__v7_proc __v7_ca12mp_proc_info, __v7_ca12mp_setup
+	__v7_proc __v7_ca12mp_proc_info, __v7_ca12mp_setup, proc_fns = HARDENED_BPIALL_PROCESSOR_FUNCTIONS
 	.size	__v7_ca12mp_proc_info, . - __v7_ca12mp_proc_info
 
 	/*
@@ -663,7 +714,7 @@ __v7_ca12mp_proc_info:
 __v7_ca15mp_proc_info:
 	.long	0x410fc0f0
 	.long	0xff0ffff0
-	__v7_proc __v7_ca15mp_proc_info, __v7_ca15mp_setup
+	__v7_proc __v7_ca15mp_proc_info, __v7_ca15mp_setup, proc_fns = ca15_processor_functions
 	.size	__v7_ca15mp_proc_info, . - __v7_ca15mp_proc_info
 
 	/*
@@ -673,7 +724,7 @@ __v7_ca15mp_proc_info:
 __v7_b15mp_proc_info:
 	.long	0x420f00f0
 	.long	0xff0ffff0
-	__v7_proc __v7_b15mp_proc_info, __v7_b15mp_setup
+	__v7_proc __v7_b15mp_proc_info, __v7_b15mp_setup, proc_fns = ca15_processor_functions
 	.size	__v7_b15mp_proc_info, . - __v7_b15mp_proc_info
 
 	/*
@@ -683,9 +734,25 @@ __v7_b15mp_proc_info:
 __v7_ca17mp_proc_info:
 	.long	0x410fc0e0
 	.long	0xff0ffff0
-	__v7_proc __v7_ca17mp_proc_info, __v7_ca17mp_setup
+	__v7_proc __v7_ca17mp_proc_info, __v7_ca17mp_setup, proc_fns = HARDENED_BPIALL_PROCESSOR_FUNCTIONS
 	.size	__v7_ca17mp_proc_info, . - __v7_ca17mp_proc_info
 
+	/* ARM Ltd. Cortex A73 processor */
+	.type	__v7_ca73_proc_info, #object
+__v7_ca73_proc_info:
+	.long	0x410fd090
+	.long	0xff0ffff0
+	__v7_proc __v7_ca73_proc_info, __v7_setup, proc_fns = HARDENED_BPIALL_PROCESSOR_FUNCTIONS
+	.size	__v7_ca73_proc_info, . - __v7_ca73_proc_info
+
+	/* ARM Ltd. Cortex A75 processor */
+	.type	__v7_ca75_proc_info, #object
+__v7_ca75_proc_info:
+	.long	0x410fd0a0
+	.long	0xff0ffff0
+	__v7_proc __v7_ca75_proc_info, __v7_setup, proc_fns = HARDENED_BPIALL_PROCESSOR_FUNCTIONS
+	.size	__v7_ca75_proc_info, . - __v7_ca75_proc_info
+
 	/*
 	 * Qualcomm Inc. Krait processors.
 	 */


