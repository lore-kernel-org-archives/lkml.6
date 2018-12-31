Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E92C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CDE21019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeLaHVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 02:21:02 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:41029 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbeLaHU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 02:20:57 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Sun, 30 Dec 2018 23:20:33 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 8CF9E40B12;
        Sun, 30 Dec 2018 23:20:35 -0800 (PST)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>
CC:     "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Nadav Amit <namit@vmware.com>
Subject: [RFC v2 1/6] x86: introduce kernel restartable sequence
Date:   Sun, 30 Dec 2018 23:21:07 -0800
Message-ID: <20181231072112.21051-2-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181231072112.21051-1-namit@vmware.com>
References: <20181231072112.21051-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is sometimes beneficial to have a restartable sequence - very few
instructions which if they are preempted jump to a predefined point.

To provide such functionality on x86-64, we use an empty REX-prefix
(opcode 0x40) as an indication for instruction in such a sequence. Before
calling the schedule IRQ routine, if the "magic" prefix is found, we
call a routine to adjust the instruction pointer.  It is expected that
this opcode is not in common use.

The following patch will make use of this function. Since there are no
other users (yet?), the patch does not bother to create a general
infrastructure and API that others can use for such sequences. Yet, it
should not be hard to make such extension later.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/entry/entry_64.S            | 16 ++++++++++++++--
 arch/x86/include/asm/nospec-branch.h | 12 ++++++++++++
 arch/x86/kernel/traps.c              |  7 +++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f0efdb7b629..e144ff8b914f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -644,12 +644,24 @@ retint_kernel:
 	/* Interrupts are off */
 	/* Check if we need preemption */
 	btl	$9, EFLAGS(%rsp)		/* were interrupts off? */
-	jnc	1f
+	jnc	2f
 0:	cmpl	$0, PER_CPU_VAR(__preempt_count)
+	jnz	2f
+
+	/*
+	 * Allow to use restartable code sections in the kernel. Consider an
+	 * instruction with the first byte having REX prefix without any bits
+	 * set as an indication for an instruction in such a section.
+	 */
+	movq    RIP(%rsp), %rax
+	cmpb    $KERNEL_RESTARTABLE_PREFIX, (%rax)
 	jnz	1f
+	mov	%rsp, %rdi
+	call	restart_kernel_rseq
+1:
 	call	preempt_schedule_irq
 	jmp	0b
-1:
+2:
 #endif
 	/*
 	 * The iretq could re-enable interrupts:
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index dad12b767ba0..be4713ef0940 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -54,6 +54,12 @@
 	jnz	771b;				\
 	add	$(BITS_PER_LONG/8) * nr, sp;
 
+/*
+ * An empty REX-prefix is an indication that this instruction is part of kernel
+ * restartable sequence.
+ */
+#define KERNEL_RESTARTABLE_PREFIX		(0x40)
+
 #ifdef __ASSEMBLY__
 
 /*
@@ -150,6 +156,12 @@
 #endif
 .endm
 
+.macro restartable_seq_prefix
+#ifdef CONFIG_PREEMPT
+	.byte	KERNEL_RESTARTABLE_PREFIX
+#endif
+.endm
+
 #else /* __ASSEMBLY__ */
 
 #define ANNOTATE_NOSPEC_ALTERNATIVE				\
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 85cccadb9a65..b1e855bad5ac 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -59,6 +59,7 @@
 #include <asm/fpu/xstate.h>
 #include <asm/vm86.h>
 #include <asm/umip.h>
+#include <asm/nospec-branch.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -186,6 +187,12 @@ int fixup_bug(struct pt_regs *regs, int trapnr)
 	return 0;
 }
 
+asmlinkage __visible void restart_kernel_rseq(struct pt_regs *regs)
+{
+	if (user_mode(regs) || *(u8 *)regs->ip != KERNEL_RESTARTABLE_PREFIX)
+		return;
+}
+
 static nokprobe_inline int
 do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
 		  struct pt_regs *regs,	long error_code)
-- 
2.17.1

