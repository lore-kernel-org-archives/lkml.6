Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6B8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430BB2156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430BB2156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeI0NWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:22:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64310 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbeI0NWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:22:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42LQnc3zpzz9ttKm;
        Thu, 27 Sep 2018 09:05:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id pRDEC95zDCZf; Thu, 27 Sep 2018 09:05:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42LQnc3WlFz9ttFb;
        Thu, 27 Sep 2018 09:05:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E9CC8B874;
        Thu, 27 Sep 2018 09:05:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kU-AmKWDEEI6; Thu, 27 Sep 2018 09:05:56 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 11A078B75A;
        Thu, 27 Sep 2018 09:05:56 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E00FD6F1AA; Thu, 27 Sep 2018 07:05:55 +0000 (UTC)
Message-Id: <6e570d7ded4f53ef8362cab8a54ef729454429b4.1537987713.git.christophe.leroy@c-s.fr>
In-Reply-To: <8e81b0647fea15e533a73ad4e9063c059fdfc6df.1537987712.git.christophe.leroy@c-s.fr>
References: <8e81b0647fea15e533a73ad4e9063c059fdfc6df.1537987712.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 2/2] powerpc/64: add stack protector support
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 27 Sep 2018 07:05:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PPC64, as register r13 points to the paca_struct at all time,
this patch adds a copy of the canary there, which is copied at
task_switch.
That new canary is then used by using the following GCC options:
-mstack-protector-guard=tls
-mstack-protector-guard-reg=r13
-mstack-protector-guard-offset=offsetof(struct paca_struct, canary))

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                      | 2 +-
 arch/powerpc/Makefile                     | 8 ++++++++
 arch/powerpc/include/asm/paca.h           | 3 +++
 arch/powerpc/include/asm/stackprotector.h | 4 ++++
 arch/powerpc/kernel/asm-offsets.c         | 3 +++
 arch/powerpc/kernel/entry_64.S            | 4 ++++
 6 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3bcb05929931..602eea723624 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -180,7 +180,7 @@ config PPC
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_CBPF_JIT			if !PPC64
-	select HAVE_STACKPROTECTOR		if $(cc-option,-mstack-protector-guard=tls) && PPC32
+	select HAVE_STACKPROTECTOR		if $(cc-option,-mstack-protector-guard=tls)
 	select HAVE_CONTEXT_TRACKING		if PPC64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_STACKOVERFLOW
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 45b8eb4d8fe7..81552c7b46eb 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -113,7 +113,11 @@ KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
 endif
 
 cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard=tls
+ifdef CONFIG_PPC64
+cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-reg=r13
+else
 cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-reg=r2
+endif
 
 LDFLAGS_vmlinux-y := -Bstatic
 LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
@@ -411,8 +415,12 @@ ifdef CONFIG_STACKPROTECTOR
 prepare: stack_protector_prepare
 
 stack_protector_prepare: prepare0
+ifdef CONFIG_PPC64
+	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "PACA_CANARY") print $$3;}' include/generated/asm-offsets.h))
+else
 	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TASK_CANARY") print $$3;}' include/generated/asm-offsets.h))
 endif
+endif
 
 # Use the file '.tmp_gas_check' for binutils tests, as gas won't output
 # to stdout and these checks are run even on install targets.
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 6d6b3706232c..98d883e58945 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -246,6 +246,9 @@ struct paca_struct {
 	struct slb_entry *mce_faulty_slbs;
 	u16 slb_save_cache_ptr;
 #endif /* CONFIG_PPC_BOOK3S_64 */
+#ifdef CONFIG_STACKPROTECTOR
+	unsigned long canary;
+#endif
 } ____cacheline_aligned;
 
 extern struct paca_struct **paca_ptrs;
diff --git a/arch/powerpc/include/asm/stackprotector.h b/arch/powerpc/include/asm/stackprotector.h
index d05d969c98c2..1c8460e23583 100644
--- a/arch/powerpc/include/asm/stackprotector.h
+++ b/arch/powerpc/include/asm/stackprotector.h
@@ -11,6 +11,7 @@
 #include <linux/version.h>
 #include <asm/reg.h>
 #include <asm/current.h>
+#include <asm/paca.h>
 
 /*
  * Initialize the stackprotector canary value.
@@ -29,6 +30,9 @@ static __always_inline void boot_init_stack_canary(void)
 	canary &= CANARY_MASK;
 
 	current->stack_canary = canary;
+#ifdef CONFIG_PPC64
+	get_paca()->canary = canary;
+#endif
 }
 
 #endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index a992f7a53cf3..773dee55b3f6 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -81,6 +81,9 @@ int main(void)
 	OFFSET(MM, task_struct, mm);
 #ifdef CONFIG_STACKPROTECTOR
 	OFFSET(TASK_CANARY, task_struct, stack_canary);
+#ifdef CONFIG_PPC64
+	OFFSET(PACA_CANARY, paca_struct, canary);
+#endif
 #endif
 	OFFSET(MMCONTEXTID, mm_struct, context.id);
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 77a888bfcb53..573fa879d785 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -624,6 +624,10 @@ _GLOBAL(_switch)
 
 	addi	r6,r4,-THREAD	/* Convert THREAD to 'current' */
 	std	r6,PACACURRENT(r13)	/* Set new 'current' */
+#if defined(CONFIG_STACKPROTECTOR)
+	ld	r6, TASK_CANARY(r6)
+	std	r6, PACA_CANARY(r13)
+#endif
 
 	ld	r8,KSP(r4)	/* new stack pointer */
 #ifdef CONFIG_PPC_BOOK3S_64
-- 
2.13.3

