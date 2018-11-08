Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008E6ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C337420818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C337420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeKIGzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:55:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbeKIGzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:55:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF969300286E;
        Thu,  8 Nov 2018 21:18:02 +0000 (UTC)
Received: from treble.redhat.com (ovpn-124-61.rdu2.redhat.com [10.10.124.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56E8D6871F;
        Thu,  8 Nov 2018 21:18:01 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>
Subject: [RFC PATCH 2/3] x86/static_call: Add x86 unoptimized static call implementation
Date:   Thu,  8 Nov 2018 15:15:52 -0600
Message-Id: <606e3af9f66b1d27f7a9885d9d6171b2585c2fe4.1541711457.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1541711457.git.jpoimboe@redhat.com>
References: <cover.1541711457.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 08 Nov 2018 21:18:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the x86 unoptimized static call implementation.  For each key, it
creates a permanent trampoline which is the destination for all static
calls for the given key.  The trampoline has a direct jump which gets
patched by static_call_update() when the destination changes.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/static_call.h | 18 +++++++++++
 arch/x86/kernel/Makefile           |  1 +
 arch/x86/kernel/static_call.c      | 51 ++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)
 create mode 100644 arch/x86/include/asm/static_call.h
 create mode 100644 arch/x86/kernel/static_call.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b5286ad2a982..9a83c3edd839 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -189,6 +189,7 @@ config X86
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
+	select HAVE_STATIC_CALL_UNOPTIMIZED
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
new file mode 100644
index 000000000000..de6b032cf809
--- /dev/null
+++ b/arch/x86/include/asm/static_call.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_STATIC_CALL_H
+#define _ASM_STATIC_CALL_H
+
+/*
+ * This is a permanent trampoline which is the destination for all static calls
+ * for the given key.  The direct jump gets patched by static_call_update().
+ */
+#define ARCH_STATIC_CALL_TRAMP(key, func)				\
+	asm(".pushsection .text, \"ax\"				\n"	\
+	    ".align 4						\n"	\
+	    ".globl " STATIC_CALL_TRAMP_STR(key) "		\n"	\
+	    ".type " STATIC_CALL_TRAMP_STR(key) ", @function	\n"	\
+	    STATIC_CALL_TRAMP_STR(key) ":			\n"	\
+	    "jmp " #func "					\n"	\
+	    ".popsection					\n")
+
+#endif /* _ASM_STATIC_CALL_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8824d01c0c35..82acc8a28429 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -62,6 +62,7 @@ obj-y			+= tsc.o tsc_msr.o io_delay.o rtc.o
 obj-y			+= pci-iommu_table.o
 obj-y			+= resource.o
 obj-y			+= irqflags.o
+obj-y			+= static_call.o
 
 obj-y				+= process.o
 obj-y				+= fpu/
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
new file mode 100644
index 000000000000..47ddc655ccda
--- /dev/null
+++ b/arch/x86/kernel/static_call.c
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/static_call.h>
+#include <linux/memory.h>
+#include <linux/bug.h>
+#include <asm/text-patching.h>
+#include <asm/nospec-branch.h>
+
+#define CALL_INSN_SIZE 5
+
+void static_call_bp_handler(void);
+void *bp_handler_dest;
+
+asm(".pushsection .text, \"ax\"						\n"
+    ".globl static_call_bp_handler					\n"
+    ".type static_call_bp_handler, @function				\n"
+    "static_call_bp_handler:						\n"
+    "ANNOTATE_RETPOLINE_SAFE						\n"
+    "jmp *bp_handler_dest						\n"
+    ".popsection							\n");
+
+void arch_static_call_transform(unsigned long insn, void *dest)
+{
+	s32 dest_relative;
+	unsigned char insn_opcode;
+	unsigned char opcodes[CALL_INSN_SIZE];
+
+	mutex_lock(&text_mutex);
+
+	insn_opcode = *(unsigned char *)insn;
+	if (insn_opcode != 0xe8 && insn_opcode != 0xe9) {
+		WARN_ONCE(1, "unexpected static call insn opcode 0x%x at %pS",
+			  insn_opcode, (void *)insn);
+		goto done;
+	}
+
+	dest_relative = (long)(dest) - (long)(insn + CALL_INSN_SIZE);
+
+	opcodes[0] = insn_opcode;
+	memcpy(&opcodes[1], &dest_relative, CALL_INSN_SIZE - 1);
+
+	/* Set up the variable for the breakpoint handler: */
+	bp_handler_dest = dest;
+
+	/* Patch the call site: */
+	text_poke_bp((void *)insn, opcodes, CALL_INSN_SIZE,
+		     static_call_bp_handler);
+
+done:
+	mutex_unlock(&text_mutex);
+}
+EXPORT_SYMBOL_GPL(arch_static_call_transform);
-- 
2.17.2

