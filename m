Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E935C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083F72082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083F72082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeJDVA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:00:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36281 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbeJDU7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:59:34 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g84GQ-0002ic-IK; Thu, 04 Oct 2018 16:06:02 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 04/11] x86/fpu: eager switch PKRU state
Date:   Thu,  4 Oct 2018 16:05:40 +0200
Message-Id: <20181004140547.13014-5-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004140547.13014-1-bigeasy@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@surriel.com>

While most of a task's FPU state is only needed in user space,
the protection keys need to be in place immediately after a
context switch.

The reason is that any accesses to userspace memory while running
in kernel mode also need to abide by the memory permissions
specified in the protection keys.

The "eager switch" is a preparation for loading the FPU state on return
to userland. Instead of decoupling PKRU state from xstate I update PKRU
within xstate on write operations by the kernel.

Signed-off-by: Rik van Riel <riel@surriel.com>
[bigeasy: save pkru to xstate, no cache]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 20 +++++++++++++++----
 arch/x86/include/asm/fpu/xstate.h   |  2 ++
 arch/x86/include/asm/pgtable.h      |  6 +-----
 arch/x86/include/asm/pkeys.h        |  2 +-
 arch/x86/kernel/fpu/core.c          |  2 +-
 arch/x86/mm/pkeys.c                 | 31 ++++++++++++++++++++++-------
 include/linux/pkeys.h               |  2 +-
 7 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 16c4077ffc945..956d967ca824a 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -570,11 +570,23 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  */
 static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 {
-	bool preload = static_cpu_has(X86_FEATURE_FPU) &&
-		       new_fpu->initialized;
+	bool load_fpu;
 
-	if (preload)
-		__fpregs_load_activate(new_fpu, cpu);
+	load_fpu = static_cpu_has(X86_FEATURE_FPU) && new_fpu->initialized;
+	if (!load_fpu)
+		return;
+
+	__fpregs_load_activate(new_fpu, cpu);
+
+#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+	if (static_cpu_has(X86_FEATURE_OSPKE)) {
+		struct pkru_state *pk;
+
+		pk = __raw_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
+		if (pk->pkru != __read_pkru())
+			__write_pkru(pk->pkru);
+	}
+#endif
 }
 
 /*
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 48581988d78c7..82227e222ca35 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <asm/processor.h>
 #include <linux/uaccess.h>
+#include <asm/user.h>
 
 /* Bit 63 of XCR0 is reserved for future expansion */
 #define XFEATURE_MASK_EXTEND	(~(XFEATURE_MASK_FPSSE | (1ULL << 63)))
@@ -47,6 +48,7 @@ extern void __init update_regset_xstate_info(unsigned int size,
 
 void fpu__xstate_clear_all_cpu_caps(void);
 void *get_xsave_addr(struct xregs_state *xsave, int xstate);
+void *__raw_xsave_addr(struct xregs_state *xsave, int feature_nr);
 const void *get_xsave_field_ptr(int xstate_field);
 int using_compacted_format(void);
 int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 690c0307afed0..80be15ba656f6 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -132,11 +132,7 @@ static inline u32 read_pkru(void)
 	return 0;
 }
 
-static inline void write_pkru(u32 pkru)
-{
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		__write_pkru(pkru);
-}
+void write_pkru(u32 pkru);
 
 static inline int pte_young(pte_t pte)
 {
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 19b137f1b3beb..b184f916319e5 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -119,7 +119,7 @@ extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
 extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
-extern void copy_init_pkru_to_fpregs(void);
+extern void pkru_set_init_value(void);
 
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 2ea85b32421a0..72cd2e2a07194 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -373,7 +373,7 @@ static inline void copy_init_fpstate_to_fpregs(void)
 		copy_kernel_to_fregs(&init_fpstate.fsave);
 
 	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		copy_init_pkru_to_fpregs();
+		pkru_set_init_value();
 }
 
 /*
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 6e98e0a7c9231..4409ada551c5e 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -18,6 +18,7 @@
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
 #include <asm/mmu_context.h>            /* vma_pkey()                   */
+#include <asm/fpu/xstate.h>
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
@@ -123,6 +124,24 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot, int pkey
 	return vma_pkey(vma);
 }
 
+void write_pkru(u32 pkru)
+{
+	struct pkru_state *pk;
+
+	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+		return;
+
+	pk = __raw_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
+	/*
+	 * Update the PKRU value in cstate and then in the CPU. A context
+	 * switch between those two operation would load the new value from the
+	 * updated xstate and then we would write (the same value) to the CPU.
+	 */
+	pk->pkru = pkru;
+	__write_pkru(pkru);
+
+}
+
 #define PKRU_AD_KEY(pkey)	(PKRU_AD_BIT << ((pkey) * PKRU_BITS_PER_PKEY))
 
 /*
@@ -143,20 +162,18 @@ u32 init_pkru_value = PKRU_AD_KEY( 1) | PKRU_AD_KEY( 2) | PKRU_AD_KEY( 3) |
  * we know the FPU regstiers are safe for use and we can use PKRU
  * directly.
  */
-void copy_init_pkru_to_fpregs(void)
+void pkru_set_init_value(void)
 {
 	u32 init_pkru_value_snapshot = READ_ONCE(init_pkru_value);
+
 	/*
 	 * Any write to PKRU takes it out of the XSAVE 'init
 	 * state' which increases context switch cost.  Avoid
-	 * writing 0 when PKRU was already 0.
+	 * writing then same value which is already written.
 	 */
-	if (!init_pkru_value_snapshot && !read_pkru())
+	if (init_pkru_value_snapshot == read_pkru())
 		return;
-	/*
-	 * Override the PKRU state that came from 'init_fpstate'
-	 * with the baseline from the process.
-	 */
+
 	write_pkru(init_pkru_value_snapshot);
 }
 
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 2955ba9760489..9a9efecc1388f 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -44,7 +44,7 @@ static inline bool arch_pkeys_enabled(void)
 	return false;
 }
 
-static inline void copy_init_pkru_to_fpregs(void)
+static inline void pkru_set_init_value(void)
 {
 }
 
-- 
2.19.0

