Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5322FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075D3214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075D3214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbeISQwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:52:14 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10459 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731280AbeISQwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:52:12 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42FchP0CYwz9ttG0;
        Wed, 19 Sep 2018 13:14:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3A69qSyvV8oB; Wed, 19 Sep 2018 13:14:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42FchN6pb6z9ttC2;
        Wed, 19 Sep 2018 13:14:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A7718B831;
        Wed, 19 Sep 2018 13:14:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mGMWqjOgV1sq; Wed, 19 Sep 2018 13:14:45 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3554E8B776;
        Wed, 19 Sep 2018 13:14:45 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2C39F709B6; Wed, 19 Sep 2018 11:14:45 +0000 (UTC)
Message-Id: <ef8fcc7933d56db6f5f7251cb982ca7131f7408d.1537355312.git.christophe.leroy@c-s.fr>
In-Reply-To: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr>
References: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/2] powerpc/32: add stack protector support
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 19 Sep 2018 11:14:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This functionality was tentatively added in the past
(commit 6533b7c16ee5 ("powerpc: Initial stack protector
(-fstack-protector) support")) but had to be reverted
(commit f2574030b0e3 ("powerpc: Revert the initial stack
protector support") because of GCC implementing it differently
whether it had been built with libc support or not.

Now, GCC offers the possibility to manually set the
stack-protector mode (global or tls) regardless of libc support.

This time, the patch selects HAVE_STACKPROTECTOR only if
-mstack-protector-guard=global is supported by GCC.

On PPC32, as register r2 points to current task_struct at
all time, the stack_canary located inside task_struct can be
used directly by using the following GCC options:
-mstack-protector-guard=tls
-mstack-protector-guard-reg=r2
-mstack-protector-guard-offset=4
	(= offsetof(struct task_struct, stack_canary))

 $ echo CORRUPT_STACK > /sys/kernel/debug/provoke-crash/DIRECT
[  134.943666] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: lkdtm_CORRUPT_STACK+0x64/0x64
[  134.943666]
[  134.955414] CPU: 0 PID: 283 Comm: sh Not tainted 4.18.0-s3k-dev-12143-ga3272be41209 #835
[  134.963380] Call Trace:
[  134.965860] [c6615d60] [c001f76c] panic+0x118/0x260 (unreliable)
[  134.971775] [c6615dc0] [c001f654] panic+0x0/0x260
[  134.976435] [c6615dd0] [c032c368] lkdtm_CORRUPT_STACK_STRONG+0x0/0x64
[  134.982769] [c6615e00] [ffffffff] 0xffffffff

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                      |  1 +
 arch/powerpc/Makefile                     |  4 ++++
 arch/powerpc/include/asm/stackprotector.h | 38 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile              |  4 ++++
 4 files changed, 47 insertions(+)
 create mode 100644 arch/powerpc/include/asm/stackprotector.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a80669209155..538bb6e2fd70 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -180,6 +180,7 @@ config PPC
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_CBPF_JIT			if !PPC64
+	select HAVE_STACKPROTECTOR		if PPC32 && $(cc-option,-mstack-protector-guard=tls)
 	select HAVE_CONTEXT_TRACKING		if PPC64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_STACKOVERFLOW
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 11a1acba164a..1108981292e9 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -112,6 +112,10 @@ KBUILD_LDFLAGS	+= -m elf$(BITS)$(LDEMULATION)
 KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
 endif
 
+cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard=tls
+cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-reg=r2
+cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-offset=4
+
 LDFLAGS_vmlinux-y := -Bstatic
 LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
 LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
diff --git a/arch/powerpc/include/asm/stackprotector.h b/arch/powerpc/include/asm/stackprotector.h
new file mode 100644
index 000000000000..4fdecbdd78e7
--- /dev/null
+++ b/arch/powerpc/include/asm/stackprotector.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * GCC stack protector support.
+ *
+ */
+
+#ifndef _ASM_STACKPROTECTOR_H
+#define _ASM_STACKPROTECTOR_H
+
+#include <linux/random.h>
+#include <linux/version.h>
+#include <asm/reg.h>
+
+/*
+ * Initialize the stackprotector canary value.
+ *
+ * NOTE: this must only be called from functions that never return,
+ * and it must always be inlined.
+ */
+static __always_inline void boot_init_stack_canary(void)
+{
+	unsigned long canary;
+
+	/*
+	 * The stack_canary must be located at the offset given to
+	 * -mstack-protector-guard-offset in the Makefile
+	 */
+	BUILD_BUG_ON(offsetof(struct task_struct, stack_canary) != sizeof(long));
+
+	/* Try to get a semi random initial value. */
+	get_random_bytes(&canary, sizeof(canary));
+	canary ^= mftb();
+	canary ^= LINUX_VERSION_CODE;
+
+	current->stack_canary = canary;
+}
+
+#endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 3b66f2c19c84..0556a7243d2a 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -20,6 +20,10 @@ CFLAGS_prom_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_btext.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_prom.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 
+# -fstack-protector triggers protection checks in this code,
+# but it is being used too early to link to meaningful stack_chk logic.
+CFLAGS_prom_init.o += $(call cc-option, -fno-stack-protector)
+
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
 CFLAGS_REMOVE_cputable.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
-- 
2.13.3

