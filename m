Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426091AbeBOQgU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:36:20 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:37394 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1424024AbeBOQgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:36:16 -0500
From: Nadav Amit <namit@vmware.com>
To: Ingo Molnar <mingo@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        Nadav Amit <nadav.amit@gmail.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH RFC v2 1/6] x86: Skip PTI when disable indication is set
Date: Thu, 15 Feb 2018 08:35:57 -0800
Message-ID: <20180215163602.61162-2-namit@vmware.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180215163602.61162-1-namit@vmware.com>
References: <20180215163602.61162-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If PTI is disabled, we do not want to switch page-tables. On entry to
the kernel, this is done based on CR3 value. On return, do it according
to per core indication.

To be on the safe side, avoid speculative skipping of page-tables
switching when returning the userspace. This can be avoided if the CPU
cannot execute speculatively code without the proper permissions. When
switching to the kernel page-tables, this is anyhow not an issue: if PTI
is enabled and page-tables were not switched, the kernel part of the
user page-tables would not be set.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/entry/calling.h        | 33 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/tlbflush.h | 17 +++++++++++++++--
 arch/x86/kernel/asm-offsets.c   |  1 +
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 3f48f695d5e6..5e9895f44d11 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -216,7 +216,14 @@ For 32-bit we have the following conventions - kernel is built with
 
 .macro SWITCH_TO_KERNEL_CR3 scratch_reg:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
+
+	/*
+	 * Do not switch on compatibility mode.
+	 */
 	mov	%cr3, \scratch_reg
+	testq	$PTI_USER_PGTABLE_MASK, \scratch_reg
+	jz	.Lend_\@
+
 	ADJUST_KERNEL_CR3 \scratch_reg
 	mov	\scratch_reg, %cr3
 .Lend_\@:
@@ -225,8 +232,20 @@ For 32-bit we have the following conventions - kernel is built with
 #define THIS_CPU_user_pcid_flush_mask   \
 	PER_CPU_VAR(cpu_tlbstate) + TLB_STATE_user_pcid_flush_mask
 
+#define THIS_CPU_pti_disable \
+	PER_CPU_VAR(cpu_tlbstate) + TLB_STATE_pti_disable
+
 .macro SWITCH_TO_USER_CR3_NOSTACK scratch_reg:req scratch_reg2:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
+
+	/*
+	 * Do not switch on compatibility mode. If there is no need for a
+	 * flush, run lfence to avoid speculative execution returning to user
+	 * with the wrong CR3.
+	 */
+	cmpw    $(0), THIS_CPU_pti_disable
+	jnz     .Lno_spec_\@
+
 	mov	%cr3, \scratch_reg
 
 	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
@@ -244,6 +263,10 @@ For 32-bit we have the following conventions - kernel is built with
 	movq	\scratch_reg2, \scratch_reg
 	jmp	.Lwrcr3_pcid_\@
 
+.Lno_spec_\@:
+	lfence
+	jmp	.Lend_\@
+
 .Lnoflush_\@:
 	movq	\scratch_reg2, \scratch_reg
 	SET_NOFLUSH_BIT \scratch_reg
@@ -288,6 +311,12 @@ For 32-bit we have the following conventions - kernel is built with
 
 	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
 
+	/*
+	 * Do not restore if PTI is disabled.
+	 */
+	cmpw    $(0), THIS_CPU_pti_disable
+	jnz     .Lno_spec_\@
+
 	/*
 	 * KERNEL pages can always resume with NOFLUSH as we do
 	 * explicit flushes.
@@ -307,6 +336,10 @@ For 32-bit we have the following conventions - kernel is built with
 	btr	\scratch_reg, THIS_CPU_user_pcid_flush_mask
 	jmp	.Lwrcr3_\@
 
+.Lno_spec_\@:
+	lfence
+	jmp	.Lend_\@
+
 .Lnoflush_\@:
 	SET_NOFLUSH_BIT \save_reg
 
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index d33e4a26dc7e..cf91a484bb41 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -216,6 +216,12 @@ struct tlb_state {
 	 */
 	unsigned long cr4;
 
+	/*
+	 * Cached value of mm.pti_enable to simplify and speed up kernel entry
+	 * code.
+	 */
+	unsigned short pti_disable;
+
 	/*
 	 * This is a list of all contexts that might exist in the TLB.
 	 * There is one per ASID that we use, and the ASID (what the
@@ -298,6 +304,12 @@ static inline void invalidate_other_asid(void)
 	this_cpu_write(cpu_tlbstate.invalidate_other, true);
 }
 
+/* Return whether page-table isolation is disabled on this CPU */
+static inline unsigned short cpu_pti_disable(void)
+{
+	return this_cpu_read(cpu_tlbstate.pti_disable);
+}
+
 /*
  * Save some of cr4 feature set we're using (e.g.  Pentium 4MB
  * enable and PPro Global page enable), so that any CPU's that boot
@@ -355,7 +367,8 @@ static inline void __native_flush_tlb(void)
 	 */
 	WARN_ON_ONCE(preemptible());
 
-	invalidate_user_asid(this_cpu_read(cpu_tlbstate.loaded_mm_asid));
+	if (!cpu_pti_disable())
+		invalidate_user_asid(this_cpu_read(cpu_tlbstate.loaded_mm_asid));
 
 	/* If current->mm == NULL then the read_cr3() "borrows" an mm */
 	native_write_cr3(__native_read_cr3());
@@ -404,7 +417,7 @@ static inline void __native_flush_tlb_single(unsigned long addr)
 
 	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
 
-	if (!static_cpu_has(X86_FEATURE_PTI))
+	if (!static_cpu_has(X86_FEATURE_PTI) || cpu_pti_disable())
 		return;
 
 	/*
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 76417a9aab73..435bb5cdfd66 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -97,6 +97,7 @@ void common(void) {
 
 	/* TLB state for the entry code */
 	OFFSET(TLB_STATE_user_pcid_flush_mask, tlb_state, user_pcid_flush_mask);
+	OFFSET(TLB_STATE_pti_disable, tlb_state, pti_disable);
 
 	/* Layout info for cpu_entry_area */
 	OFFSET(CPU_ENTRY_AREA_tss, cpu_entry_area, tss);
-- 
2.14.1
