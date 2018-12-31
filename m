Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4C8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036112133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546270522;
	bh=kU5YRStiq4pbT7LY2tRK1gQkAqE107/T6h3MkjiX8yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UDDQjNUk/2hn4QdCarIa75YMLLQYePrIjYipgEma3sxc+GveHhdfbpvf8fCYVj7ls
	 3K/Te4RGyPsPI9IEfURVdeo7yFUClhEZPttMbyudEn0p6bQWPmUuSy9AjJh1sLCuQ0
	 5+ZwXGspqV/VPW9jhuj+mFZaqyWke4F5LdwtQ38E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeLaPfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:35:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeLaPfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 10:35:20 -0500
Received: from localhost.localdomain (unknown [183.128.55.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91DEE2133F;
        Mon, 31 Dec 2018 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546270519;
        bh=kU5YRStiq4pbT7LY2tRK1gQkAqE107/T6h3MkjiX8yQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzqTih5FQu0ej3YKSiFDj1s6UEYTUiQvcWQHcseYtUfdtvw1ZfR+Q/EzthOc1tbb+
         Avs8Nu2n37qiGLeHAlupPXu81ZwZqMW8gwFo7/TCSpeVTCo/HLe8a1uCn/1iHUyTNC
         8edoBmrv256r484Crcf4kt6Jtz7PcQZ+AfzgrEv0=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     guoren@kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 12/14] csky: ftrace call graph supported.
Date:   Mon, 31 Dec 2018 23:33:03 +0800
Message-Id: <1546270384-4590-11-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

With csky-gcc -pg -mbacktrace, ftrace call graph supported.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/Kconfig              |   1 +
 arch/csky/abiv2/mcount.S       | 116 ++++++++++++++++++++++++++++++++++++++---
 arch/csky/include/asm/ftrace.h |   6 ++-
 arch/csky/kernel/ftrace.c      |  48 +++++++++++++----
 4 files changed, 151 insertions(+), 20 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 0b9a290..6e81477 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -30,6 +30,7 @@ config CSKY
 	select GENERIC_SMP_IDLE_THREAD
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_FUNCTION_TRACER
+	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
diff --git a/arch/csky/abiv2/mcount.S b/arch/csky/abiv2/mcount.S
index 73377d5..c633379 100644
--- a/arch/csky/abiv2/mcount.S
+++ b/arch/csky/abiv2/mcount.S
@@ -2,23 +2,123 @@
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
 #include <linux/linkage.h>
+#include <asm/ftrace.h>
 
-ENTRY (_mcount)
-	subi	sp, 20
+/*
+ * csky-gcc with -pg will put the following asm after prologue:
+ *      push	r15
+ *      jsri	_mcount
+ *
+ * stack layout after mcount_enter in _mcount():
+ *
+ * current sp => 0:+-------+
+ *                 | a0-a3 | -> must save all argument regs
+ *             +16:+-------+
+ *                 | lr    | -> _mcount lr (instrumente function's pc)
+ *             +20:+-------+
+ *                 | fp=r8 | -> instrumented function fp
+ *             +24:+-------+
+ *                 | plr   | -> instrumented function lr (parent's pc)
+ *                 +-------+
+ */
+
+.macro mcount_enter
+	subi	sp, 24
 	stw	a0, (sp, 0)
 	stw	a1, (sp, 4)
 	stw	a2, (sp, 8)
 	stw	a3, (sp, 12)
 	stw	lr, (sp, 16)
-	mov	a1, lr
-	ldw	a0, (sp, 20)
-	jsri    csky_mcount
+	stw	r8, (sp, 20)
+.endm
+
+.macro mcount_exit
 	ldw	a0, (sp, 0)
 	ldw	a1, (sp, 4)
 	ldw	a2, (sp, 8)
 	ldw	a3, (sp, 12)
 	ldw	t1, (sp, 16)
-	ldw	lr, (sp, 20)
-	addi	sp, 24
+	ldw	r8, (sp, 20)
+	ldw	lr, (sp, 24)
+	addi	sp, 28
 	jmp	t1
-END (_mcount)
+.endm
+
+.macro save_return_regs
+	subi	sp, 16
+	stw	a0, (sp, 0)
+	stw	a1, (sp, 4)
+	stw	a2, (sp, 8)
+	stw	a3, (sp, 12)
+.endm
+
+.macro restore_return_regs
+	mov	lr, a0
+	ldw	a0, (sp, 0)
+	ldw	a1, (sp, 4)
+	ldw	a2, (sp, 8)
+	ldw	a3, (sp, 12)
+	addi	sp, 16
+.endm
+
+ENTRY(ftrace_stub)
+	jmp	lr
+END(ftrace_stub)
+
+ENTRY(_mcount)
+	mcount_enter
+
+	/* r26 is link register, only used with jsri translation */
+	lrw	r26, ftrace_trace_function
+	ldw	r26, (r26, 0)
+	lrw	a1, ftrace_stub
+	cmpne	r26, a1
+	bf	skip_ftrace
+
+	mov	a0, lr
+	subi	a0, MCOUNT_INSN_SIZE
+	ldw	a1, (sp, 24)
+
+	jsr	r26
+
+#ifndef CONFIG_FUNCTION_GRAPH_TRACER
+skip_ftrace:
+	mcount_exit
+#else
+skip_ftrace:
+	lrw	a0, ftrace_graph_return
+	ldw	a0, (a0, 0)
+	lrw	a1, ftrace_stub
+	cmpne	a0, a1
+	bt	ftrace_graph_caller
+
+	lrw	a0, ftrace_graph_entry
+	ldw	a0, (a0, 0)
+	lrw	a1, ftrace_graph_entry_stub
+	cmpne	a0, a1
+	bt	ftrace_graph_caller
+
+	mcount_exit
+#endif
+END(_mcount)
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+ENTRY(ftrace_graph_caller)
+	mov	a0, sp
+	addi	a0, 24
+	ldw	a1, (sp, 16)
+	subi	a1, MCOUNT_INSN_SIZE
+	mov	a2, r8
+	lrw	r26, prepare_ftrace_return
+	jsr	r26
+	mcount_exit
+END(ftrace_graph_caller)
+
+ENTRY(return_to_handler)
+	save_return_regs
+	mov	a0, r8
+	jsri	ftrace_return_to_handler
+	restore_return_regs
+	jmp	lr
+END(return_to_handler)
+#endif
diff --git a/arch/csky/include/asm/ftrace.h b/arch/csky/include/asm/ftrace.h
index 1d22a17..7547c45 100644
--- a/arch/csky/include/asm/ftrace.h
+++ b/arch/csky/include/asm/ftrace.h
@@ -4,6 +4,10 @@
 #ifndef __ASM_CSKY_FTRACE_H
 #define __ASM_CSKY_FTRACE_H
 
-extern void _mcount(unsigned long from_pc);
+#define MCOUNT_INSN_SIZE 4
+
+#define HAVE_FUNCTION_GRAPH_FP_TEST
+
+#define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 
 #endif /* __ASM_CSKY_FTRACE_H */
diff --git a/arch/csky/kernel/ftrace.c b/arch/csky/kernel/ftrace.c
index ad054f719..274c431 100644
--- a/arch/csky/kernel/ftrace.c
+++ b/arch/csky/kernel/ftrace.c
@@ -4,21 +4,47 @@
 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
 
-extern void (*ftrace_trace_function)(unsigned long, unsigned long,
-				     struct ftrace_ops*, struct pt_regs*);
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
+			   unsigned long frame_pointer)
+{
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	unsigned long old;
 
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
 
-noinline void __naked ftrace_stub(unsigned long ip, unsigned long parent_ip,
-				  struct ftrace_ops *op, struct pt_regs *regs)
-{
-	asm volatile ("\n");
-}
+	old = *parent;
 
-noinline void csky_mcount(unsigned long from_pc, unsigned long self_pc)
-{
-	if (ftrace_trace_function != ftrace_stub)
-		ftrace_trace_function(self_pc, from_pc, NULL, NULL);
+	if (!function_graph_enter(old, self_addr,
+			*(unsigned long *)frame_pointer, parent)) {
+		/*
+		 * For csky-gcc function has sub-call:
+		 * subi	sp,	sp, 8
+		 * stw	r8,	(sp, 0)
+		 * mov	r8,	sp
+		 * st.w r15,	(sp, 0x4)
+		 * push	r15
+		 * jl	_mcount
+		 * We only need set *parent for resume
+		 *
+		 * For csky-gcc function has no sub-call:
+		 * subi	sp,	sp, 4
+		 * stw	r8,	(sp, 0)
+		 * mov	r8,	sp
+		 * push	r15
+		 * jl	_mcount
+		 * We need set *parent and *(frame_pointer + 4) for resume,
+		 * because lr is resumed twice.
+		 */
+		*parent = return_hooker;
+		frame_pointer += 4;
+		if (*(unsigned long *)frame_pointer == old)
+			*(unsigned long *)frame_pointer = return_hooker;
+	}
 }
+#endif
 
 /* _mcount is defined in abi's mcount.S */
+extern void _mcount(void);
 EXPORT_SYMBOL(_mcount);
-- 
2.7.4

