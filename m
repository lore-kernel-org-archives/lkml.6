Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5103CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8C6206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfAIXAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:00:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfAIXAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:00:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23374C05FFE0;
        Wed,  9 Jan 2019 22:59:59 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-32.rdu2.redhat.com [10.10.125.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE19510A1820;
        Wed,  9 Jan 2019 22:59:56 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v3 3/6] x86/static_call: Add out-of-line static call implementation
Date:   Wed,  9 Jan 2019 16:59:38 -0600
Message-Id: <30f0713894a415f13e0f0ea3d40595416db2f6d7.1547073843.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1547073843.git.jpoimboe@redhat.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 09 Jan 2019 22:59:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the x86 out-of-line static call implementation.  For each key, a
permanent trampoline is created which is the destination for all static
calls for the given key.  The trampoline has a direct jump which gets
patched by static_call_update() when the destination function changes.

This relies on the fact that call destinations can be atomically updated
as long as they don't cross cache line boundaries.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/static_call.h | 27 +++++++++++++++++++++
 arch/x86/kernel/Makefile           |  1 +
 arch/x86/kernel/static_call.c      | 38 ++++++++++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S      |  1 +
 include/asm-generic/vmlinux.lds.h  | 15 ++++++++++++
 6 files changed, 83 insertions(+)
 create mode 100644 arch/x86/include/asm/static_call.h
 create mode 100644 arch/x86/kernel/static_call.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6185d4f33296..421097322f1b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -190,6 +190,7 @@ config X86
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
+	select HAVE_STATIC_CALL
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
new file mode 100644
index 000000000000..fab5facade03
--- /dev/null
+++ b/arch/x86/include/asm/static_call.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_STATIC_CALL_H
+#define _ASM_STATIC_CALL_H
+
+#include <asm/asm-offsets.h>
+
+/*
+ * This trampoline is used for out-of-line static calls.  It has a direct jump
+ * which gets patched by static_call_update().
+ *
+ * Trampolines are placed in the .static_call.text section to prevent two-byte
+ * tail calls to the trampoline and two-byte jumps from the trampoline.
+ *
+ * IMPORTANT: The JMP instruction's 4-byte destination must never cross
+ *            cacheline boundaries!  The patching code relies on that to ensure
+ *            atomic updates.
+ */
+#define ARCH_DEFINE_STATIC_CALL_TRAMP(key, func)			\
+	asm(".pushsection .static_call.text, \"ax\"		\n"	\
+	    ".align 8						\n"	\
+	    ".globl " STATIC_CALL_TRAMP_STR(key) "		\n"	\
+	    ".type " STATIC_CALL_TRAMP_STR(key) ", @function	\n"	\
+	    STATIC_CALL_TRAMP_STR(key) ":			\n"	\
+	    "jmp " #func "					\n"	\
+	    ".popsection					\n")
+
+#endif /* _ASM_STATIC_CALL_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 00b7e27bc2b7..f1329a79fd3b 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -63,6 +63,7 @@ obj-y			+= tsc.o tsc_msr.o io_delay.o rtc.o
 obj-y			+= pci-iommu_table.o
 obj-y			+= resource.o
 obj-y			+= irqflags.o
+obj-y			+= static_call.o
 
 obj-y				+= process.o
 obj-y				+= fpu/
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
new file mode 100644
index 000000000000..e6ef53fbce20
--- /dev/null
+++ b/arch/x86/kernel/static_call.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/static_call.h>
+#include <linux/memory.h>
+#include <linux/bug.h>
+#include <asm/text-patching.h>
+#include <asm/nospec-branch.h>
+
+#define CALL_INSN_SIZE 5
+
+void __ref arch_static_call_transform(void *site, void *tramp, void *func)
+{
+	s32 dest_relative;
+	unsigned char opcode;
+	void *(*poker)(void *, const void *, size_t);
+	void *insn = tramp;
+
+	mutex_lock(&text_mutex);
+
+	/*
+	 * For x86-64, a 32-bit cross-modifying write to a call destination is
+	 * safe as long as it's within a cache line.
+	 */
+	opcode = *(unsigned char *)insn;
+	if (opcode != 0xe8 && opcode != 0xe9) {
+		WARN_ONCE(1, "unexpected static call insn opcode 0x%x at %pS",
+			  opcode, insn);
+		goto done;
+	}
+
+	dest_relative = (long)(func) - (long)(insn + CALL_INSN_SIZE);
+
+	poker = early_boot_irqs_disabled ? text_poke_early : text_poke;
+	poker(insn + 1, &dest_relative, sizeof(dest_relative));
+
+done:
+	mutex_unlock(&text_mutex);
+}
+EXPORT_SYMBOL_GPL(arch_static_call_transform);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0d618ee634ac..17470e88ac40 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -128,6 +128,7 @@ SECTIONS
 		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
+		STATIC_CALL_TEXT
 		ALIGN_ENTRY_TEXT_BEGIN
 		ENTRY_TEXT
 		IRQENTRY_TEXT
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3d7a6a9c2370..f2981a0161f2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -320,6 +320,7 @@
 	__start_ro_after_init = .;					\
 	*(.data..ro_after_init)						\
 	JUMP_TABLE_DATA							\
+	STATIC_CALL_SITES						\
 	__end_ro_after_init = .;
 #endif
 
@@ -530,6 +531,10 @@
 		*(.kprobes.text)					\
 		__kprobes_text_end = .;
 
+#define STATIC_CALL_TEXT						\
+		ALIGN_FUNCTION();					\
+		*(.static_call.text)
+
 #define ENTRY_TEXT							\
 		ALIGN_FUNCTION();					\
 		__entry_text_start = .;					\
@@ -725,6 +730,16 @@
 #define BUG_TABLE
 #endif
 
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+#define STATIC_CALL_SITES						\
+	. = ALIGN(8);							\
+	__start_static_call_sites = .;					\
+	KEEP(*(.static_call_sites))					\
+	__stop_static_call_sites = .;
+#else
+#define STATIC_CALL_SITES
+#endif
+
 #ifdef CONFIG_UNWINDER_ORC
 #define ORC_UNWIND_TABLE						\
 	. = ALIGN(4);							\
-- 
2.17.2

