Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7148CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D4321722
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 21:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="YC9WP3Ws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D4321722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeH0BYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 21:24:17 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49546 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0BYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 21:24:17 -0400
Received: from trochilidae.lan (unknown [IPv6:2a02:169:34d6::189])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 058425C06AC;
        Sun, 26 Aug 2018 23:40:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1535319625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=y1zXXisCaEymzDWPrZ7VIPlGx7l+ltKMAKALy3atIZQ=;
        b=YC9WP3Ws6DM9v+FhzxDbDVpYHe0V14iWFdqTHafumFRTXabuVENFQL35fSHwi8d3Hhzo+z
        9TGxSyBRH6NFlFz74TCyLKGTGlS7BIgIzhXH811Zq0iZCiLJaXPMDyuIqIq0WzGL8L9/wa
        7hC0g4bshbFUUKDM2/ntsYN3myte7jg=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ARM: ftrace: remove old mcount support
Date:   Sun, 26 Aug 2018 23:40:22 +0200
Message-Id: <20180826214022.4889-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
raised the minimum GCC version to 4.6. Old mcount is only required for
GCC versions older than 4.4.0. Hence old mcount support can be dropped
too.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Besides cleaning up code it also simplifies changes changes for
clang support, if added...

--
Stefan

 arch/arm/Kconfig.debug         |  5 ---
 arch/arm/include/asm/ftrace.h  |  3 --
 arch/arm/kernel/armksyms.c     |  3 --
 arch/arm/kernel/entry-ftrace.S | 75 ++--------------------------------
 arch/arm/kernel/ftrace.c       | 51 -----------------------
 5 files changed, 4 insertions(+), 133 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 693f84392f1b..da690e2972d6 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -73,11 +73,6 @@ config ARM_UNWIND
 	  the performance is not affected. Currently, this feature
 	  only works with EABI compilers. If unsure say Y.
 
-config OLD_MCOUNT
-	bool
-	depends on FUNCTION_TRACER && FRAME_POINTER
-	default y
-
 config DEBUG_USER
 	bool "Verbose user fault messages"
 	help
diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 9e842ff41768..18b0197f2384 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -16,9 +16,6 @@ extern void __gnu_mcount_nc(void);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 struct dyn_arch_ftrace {
-#ifdef CONFIG_OLD_MCOUNT
-	bool	old_mcount;
-#endif
 };
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 783fbb4de5f9..8fa2dc21d332 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -167,9 +167,6 @@ EXPORT_SYMBOL(_find_next_bit_be);
 #endif
 
 #ifdef CONFIG_FUNCTION_TRACER
-#ifdef CONFIG_OLD_MCOUNT
-EXPORT_SYMBOL(mcount);
-#endif
 EXPORT_SYMBOL(__gnu_mcount_nc);
 #endif
 
diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
index efcd9f25a14b..0be69e551a64 100644
--- a/arch/arm/kernel/entry-ftrace.S
+++ b/arch/arm/kernel/entry-ftrace.S
@@ -15,23 +15,8 @@
  * start of every function.  In mcount, apart from the function's address (in
  * lr), we need to get hold of the function's caller's address.
  *
- * Older GCCs (pre-4.4) inserted a call to a routine called mcount like this:
- *
- *	bl	mcount
- *
- * These versions have the limitation that in order for the mcount routine to
- * be able to determine the function's caller's address, an APCS-style frame
- * pointer (which is set up with something like the code below) is required.
- *
- *	mov     ip, sp
- *	push    {fp, ip, lr, pc}
- *	sub     fp, ip, #4
- *
- * With EABI, these frame pointers are not available unless -mapcs-frame is
- * specified, and if building as Thumb-2, not even then.
- *
- * Newer GCCs (4.4+) solve this problem by introducing a new version of mcount,
- * with call sites like:
+ * Newer GCCs (4.4+) solve this problem by using a version of mcount with call
+ * sites like:
  *
  *	push	{lr}
  *	bl	__gnu_mcount_nc
@@ -46,17 +31,10 @@
  * allows it to be clobbered in subroutines and doesn't use it to hold
  * parameters.)
  *
- * When using dynamic ftrace, we patch out the mcount call by a "mov r0, r0"
- * for the mcount case, and a "pop {lr}" for the __gnu_mcount_nc case (see
- * arch/arm/kernel/ftrace.c).
+ * When using dynamic ftrace, we patch out the mcount call by a "pop {lr}"
+ * instead of the __gnu_mcount_nc call (see arch/arm/kernel/ftrace.c).
  */
 
-#ifndef CONFIG_OLD_MCOUNT
-#if (__GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ < 4))
-#error Ftrace requires CONFIG_FRAME_POINTER=y with GCC older than 4.4.0.
-#endif
-#endif
-
 .macro mcount_adjust_addr rd, rn
 	bic	\rd, \rn, #1		@ clear the Thumb bit if present
 	sub	\rd, \rd, #MCOUNT_INSN_SIZE
@@ -209,51 +187,6 @@ ftrace_graph_call\suffix:
 	mcount_exit
 .endm
 
-#ifdef CONFIG_OLD_MCOUNT
-/*
- * mcount
- */
-
-.macro mcount_enter
-	stmdb	sp!, {r0-r3, lr}
-.endm
-
-.macro mcount_get_lr reg
-	ldr	\reg, [fp, #-4]
-.endm
-
-.macro mcount_exit
-	ldr	lr, [fp, #-4]
-	ldmia	sp!, {r0-r3, pc}
-.endm
-
-ENTRY(mcount)
-#ifdef CONFIG_DYNAMIC_FTRACE
-	stmdb	sp!, {lr}
-	ldr	lr, [fp, #-4]
-	ldmia	sp!, {pc}
-#else
-	__mcount _old
-#endif
-ENDPROC(mcount)
-
-#ifdef CONFIG_DYNAMIC_FTRACE
-ENTRY(ftrace_caller_old)
-	__ftrace_caller _old
-ENDPROC(ftrace_caller_old)
-#endif
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-ENTRY(ftrace_graph_caller_old)
-	__ftrace_graph_caller
-ENDPROC(ftrace_graph_caller_old)
-#endif
-
-.purgem mcount_enter
-.purgem mcount_get_lr
-.purgem mcount_exit
-#endif
-
 /*
  * __gnu_mcount_nc
  */
diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 5617932a83df..0142fcfcc3d3 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -47,30 +47,6 @@ void arch_ftrace_update_code(int command)
 	stop_machine(__ftrace_modify_code, &command, NULL);
 }
 
-#ifdef CONFIG_OLD_MCOUNT
-#define OLD_MCOUNT_ADDR	((unsigned long) mcount)
-#define OLD_FTRACE_ADDR ((unsigned long) ftrace_caller_old)
-
-#define	OLD_NOP		0xe1a00000	/* mov r0, r0 */
-
-static unsigned long ftrace_nop_replace(struct dyn_ftrace *rec)
-{
-	return rec->arch.old_mcount ? OLD_NOP : NOP;
-}
-
-static unsigned long adjust_address(struct dyn_ftrace *rec, unsigned long addr)
-{
-	if (!rec->arch.old_mcount)
-		return addr;
-
-	if (addr == MCOUNT_ADDR)
-		addr = OLD_MCOUNT_ADDR;
-	else if (addr == FTRACE_ADDR)
-		addr = OLD_FTRACE_ADDR;
-
-	return addr;
-}
-#else
 static unsigned long ftrace_nop_replace(struct dyn_ftrace *rec)
 {
 	return NOP;
@@ -80,7 +56,6 @@ static unsigned long adjust_address(struct dyn_ftrace *rec, unsigned long addr)
 {
 	return addr;
 }
-#endif
 
 int ftrace_arch_code_modify_prepare(void)
 {
@@ -150,15 +125,6 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	}
 #endif
 
-#ifdef CONFIG_OLD_MCOUNT
-	if (!ret) {
-		pc = (unsigned long)&ftrace_call_old;
-		new = ftrace_call_replace(pc, (unsigned long)func);
-
-		ret = ftrace_modify_code(pc, 0, new, false);
-	}
-#endif
-
 	return ret;
 }
 
@@ -203,16 +169,6 @@ int ftrace_make_nop(struct module *mod,
 	new = ftrace_nop_replace(rec);
 	ret = ftrace_modify_code(ip, old, new, true);
 
-#ifdef CONFIG_OLD_MCOUNT
-	if (ret == -EINVAL && addr == MCOUNT_ADDR) {
-		rec->arch.old_mcount = true;
-
-		old = ftrace_call_replace(ip, adjust_address(rec, addr));
-		new = ftrace_nop_replace(rec);
-		ret = ftrace_modify_code(ip, old, new, true);
-	}
-#endif
-
 	return ret;
 }
 
@@ -290,13 +246,6 @@ static int ftrace_modify_graph_caller(bool enable)
 #endif
 
 
-#ifdef CONFIG_OLD_MCOUNT
-	if (!ret)
-		ret = __ftrace_modify_caller(&ftrace_graph_call_old,
-					     ftrace_graph_caller_old,
-					     enable);
-#endif
-
 	return ret;
 }
 
-- 
2.18.0

