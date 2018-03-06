Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELuIsyrFH//qgYwYVNLvYedE5vNYX6u+CuS5XR7hfF3o2mBZinFapKMEjwli7zcl2fRPkVq8
ARC-Seal: i=1; a=rsa-sha256; t=1520296005; cv=none;
        d=google.com; s=arc-20160816;
        b=fgkIqtpxaJ0Wa07CAzMH9HkGNiD1DBmnM9ilAc0dCgaD33PDaJr7kY5uAfG9IeIoI9
         DpOhAu1UHY17RkhF//AakoAB4ucelEB80Nm/KJIq8xEiQzDTjx91sHLqmOGGYbhDRec1
         fBCxEU2q3yCRfRdO0oaSyY4lBtihwSw3KGHbom9WuQ4l0JEfEUjj+9lIqoQ/EdUtUy4P
         VosNoWtJNh2iYE1dsYil6Sren783udrAgE/A2SaU+Uc9v/xPiqS2efBgbG3snlNRDpPg
         vwK2+IrCdGjd3n0wZjfg4OcbqW9Ofnscr28Geun0q8tT1GSORQTdrFOBg60h9nX5nVMA
         +mVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=PdEdJclvzIJd2bEMa4Z4C/yUAzNmxXuTustk81cMbJ8=;
        b=TbMSnu91JXcqphH1n3+7lNSxNImsxkqjrGBPoklMb/ZVpOaNyD8F60KoW75F+UwDJc
         akmfbU7vzjxhb2sFLd2GycoNU6j/r80puO3/St2igohfbg8o82PmJ+aqaxJ53ljmVLEu
         ZUWaKnr6973iWj1u4D9DNmWKQ3QN3HE5cebOdr1DwgqARir/IFRt7mhTBEmqUcdhq/NY
         zNScnc1lGfmZpgKS1WjVL9eE1UMRTO8Ktwi89oo3SOdteE+DzeOiahBgBaOTTGOf7FCR
         n1+6+dGYrh20n2QQ/7B+8p8bd7WYJxFwEetoyD4iWhReIuHfDpbzEfbbkejjPsp0Ao/8
         BeFA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=lSA7bkFv;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=lSA7bkFv;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 49/65] kaiser: add "nokaiser" boot option, using ALTERNATIVE
Date: Mon,  5 Mar 2018 19:25:22 -0500
Message-Id: <20180306002538.1761-50-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145904753334673?=
X-GMAIL-MSGID: =?utf-8?q?1594145904902651716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Added "nokaiser" boot option: an early param like "noinvpcid".
Most places now check int kaiser_enabled (#defined 0 when not
CONFIG_KAISER) instead of #ifdef CONFIG_KAISER; but entry_64.S
and entry_64_compat.S are using the ALTERNATIVE technique, which
patches in the preferred instructions at runtime.  That technique
is tied to x86 cpu features, so X86_FEATURE_KAISER is fabricated.

Prior to "nokaiser", Kaiser #defined _PAGE_GLOBAL 0: revert that,
but be careful with both _PAGE_GLOBAL and CR4.PGE: setting them when
nokaiser like when !CONFIG_KAISER, but not setting either when kaiser -
neither matters on its own, but it's hard to be sure that _PAGE_GLOBAL
won't get set in some obscure corner, or something add PGE into CR4.
By omitting _PAGE_GLOBAL from __supported_pte_mask when kaiser_enabled,
all page table setup which uses pte_pfn() masks it out of the ptes.

It's slightly shameful that the same declaration versus definition of
kaiser_enabled appears in not one, not two, but in three header files
(asm/kaiser.h, asm/pgtable.h, asm/tlbflush.h).  I felt safer that way,
than with #including any of those in any of the others; and did not
feel it worth an asm/kaiser_enabled.h - kernel/cpu/common.c includes
them all, so we shall hear about it if they get out of synch.

Cleanups while in the area: removed the silly #ifdef CONFIG_KAISER
from kaiser.c; removed the unused native_get_normal_pgd(); removed
the spurious reg clutter from SWITCH_*_CR3 macro stubs; corrected some
comments.  But more interestingly, set CR4.PSE in secondary_startup_64:
the manual is clear that it does not matter whether it's 0 or 1 when
4-level-pts are enabled, but I was distracted to find cr4 different on
BSP and auxiliaries - BSP alone was adding PSE, in probe_page_size_mask().

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit e345dcc9481543edf4a0a5df4c4c2f9597b0a997)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/entry/entry_64.S (not in this tree)
	arch/x86/kernel/entry_64.S (patched instead of that)
---
 Documentation/kernel-parameters.txt  |  2 ++
 arch/x86/include/asm/cpufeature.h    |  3 +++
 arch/x86/include/asm/kaiser.h        | 27 ++++++++++++++++++-------
 arch/x86/include/asm/pgtable.h       | 20 ++++++++++++------
 arch/x86/include/asm/pgtable_64.h    | 13 ++++--------
 arch/x86/include/asm/pgtable_types.h |  4 ----
 arch/x86/include/asm/tlbflush.h      | 39 +++++++++++++++++++++++-------------
 arch/x86/kernel/cpu/common.c         | 28 +++++++++++++++++++++++++-
 arch/x86/kernel/entry_64.S           | 15 +++++++-------
 arch/x86/kernel/espfix_64.c          |  3 ++-
 arch/x86/kernel/head_64.S            |  4 ++--
 arch/x86/mm/init.c                   |  2 +-
 arch/x86/mm/init_64.c                | 10 +++++++++
 arch/x86/mm/kaiser.c                 | 26 ++++++++++++++++++++----
 arch/x86/mm/pgtable.c                |  8 ++------
 arch/x86/mm/tlb.c                    |  4 +---
 16 files changed, 143 insertions(+), 65 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 97bc24101896..2d75f55419e0 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2439,6 +2439,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 	nojitter	[IA-64] Disables jitter checking for ITC timers.
 
+	nokaiser	[X86-64] Disable KAISER isolation of kernel from user.
+
 	no-kvmclock	[X86,KVM] Disable paravirtualized KVM clock driver
 
 	no-kvmapf	[X86,KVM] Disable paravirtualized asynchronous page
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 80a2b9487b29..b62f5b1a4361 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -198,6 +198,9 @@
 #define X86_FEATURE_HWP_PKG_REQ ( 7*32+14) /* Intel HWP_PKG_REQ */
 #define X86_FEATURE_INTEL_PT	( 7*32+15) /* Intel Processor Trace */
 
+/* Because the ALTERNATIVE scheme is for members of the X86_FEATURE club... */
+#define X86_FEATURE_KAISER	( 7*32+31) /* CONFIG_KAISER w/o nokaiser */
+
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW  ( 8*32+ 0) /* Intel TPR Shadow */
 #define X86_FEATURE_VNMI        ( 8*32+ 1) /* Intel Virtual NMI */
diff --git a/arch/x86/include/asm/kaiser.h b/arch/x86/include/asm/kaiser.h
index 3dc5f4c39b3e..96643a9c194c 100644
--- a/arch/x86/include/asm/kaiser.h
+++ b/arch/x86/include/asm/kaiser.h
@@ -46,28 +46,33 @@ movq \reg, %cr3
 .endm
 
 .macro SWITCH_KERNEL_CR3
-pushq %rax
+ALTERNATIVE "jmp 8f", "pushq %rax", X86_FEATURE_KAISER
 _SWITCH_TO_KERNEL_CR3 %rax
 popq %rax
+8:
 .endm
 
 .macro SWITCH_USER_CR3
-pushq %rax
+ALTERNATIVE "jmp 8f", "pushq %rax", X86_FEATURE_KAISER
 _SWITCH_TO_USER_CR3 %rax %al
 popq %rax
+8:
 .endm
 
 .macro SWITCH_KERNEL_CR3_NO_STACK
-movq %rax, PER_CPU_VAR(unsafe_stack_register_backup)
+ALTERNATIVE "jmp 8f", \
+	__stringify(movq %rax, PER_CPU_VAR(unsafe_stack_register_backup)), \
+	X86_FEATURE_KAISER
 _SWITCH_TO_KERNEL_CR3 %rax
 movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
+8:
 .endm
 
 #else /* CONFIG_KAISER */
 
-.macro SWITCH_KERNEL_CR3 reg
+.macro SWITCH_KERNEL_CR3
 .endm
-.macro SWITCH_USER_CR3 reg regb
+.macro SWITCH_USER_CR3
 .endm
 .macro SWITCH_KERNEL_CR3_NO_STACK
 .endm
@@ -90,6 +95,16 @@ DECLARE_PER_CPU(unsigned long, x86_cr3_pcid_user);
 
 extern char __per_cpu_user_mapped_start[], __per_cpu_user_mapped_end[];
 
+extern int kaiser_enabled;
+#else
+#define kaiser_enabled	0
+#endif /* CONFIG_KAISER */
+
+/*
+ * Kaiser function prototypes are needed even when CONFIG_KAISER is not set,
+ * so as to build with tests on kaiser_enabled instead of #ifdefs.
+ */
+
 /**
  *  kaiser_add_mapping - map a virtual memory part to the shadow (user) mapping
  *  @addr: the start address of the range
@@ -119,8 +134,6 @@ extern void kaiser_remove_mapping(unsigned long start, unsigned long size);
  */
 extern void kaiser_init(void);
 
-#endif /* CONFIG_KAISER */
-
 #endif /* __ASSEMBLY */
 
 #endif /* _ASM_X86_KAISER_H */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 34e5177bd7b3..af9713487b36 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -18,6 +18,12 @@
 #ifndef __ASSEMBLY__
 #include <asm/x86_init.h>
 
+#ifdef CONFIG_KAISER
+extern int kaiser_enabled;
+#else
+#define kaiser_enabled 0
+#endif
+
 void ptdump_walk_pgd_level(struct seq_file *m, pgd_t *pgd);
 
 /*
@@ -633,7 +639,7 @@ static inline int pgd_bad(pgd_t pgd)
 	 * page table by accident; it will fault on the first
 	 * instruction it tries to run.  See native_set_pgd().
 	 */
-	if (IS_ENABLED(CONFIG_KAISER))
+	if (kaiser_enabled)
 		ignore_flags |= _PAGE_NX;
 
 	return (pgd_flags(pgd) & ~ignore_flags) != _KERNPG_TABLE;
@@ -838,12 +844,14 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
  */
 static inline void clone_pgd_range(pgd_t *dst, pgd_t *src, int count)
 {
-       memcpy(dst, src, count * sizeof(pgd_t));
+	memcpy(dst, src, count * sizeof(pgd_t));
 #ifdef CONFIG_KAISER
-	/* Clone the shadow pgd part as well */
-	memcpy(native_get_shadow_pgd(dst),
-	       native_get_shadow_pgd(src),
-	       count * sizeof(pgd_t));
+	if (kaiser_enabled) {
+		/* Clone the shadow pgd part as well */
+		memcpy(native_get_shadow_pgd(dst),
+			native_get_shadow_pgd(src),
+			count * sizeof(pgd_t));
+	}
 #endif
 }
 
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 8629be9e6649..233d19c9f22e 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -111,13 +111,12 @@ extern pgd_t kaiser_set_shadow_pgd(pgd_t *pgdp, pgd_t pgd);
 
 static inline pgd_t *native_get_shadow_pgd(pgd_t *pgdp)
 {
+#ifdef CONFIG_DEBUG_VM
+	/* linux/mmdebug.h may not have been included at this point */
+	BUG_ON(!kaiser_enabled);
+#endif
 	return (pgd_t *)((unsigned long)pgdp | (unsigned long)PAGE_SIZE);
 }
-
-static inline pgd_t *native_get_normal_pgd(pgd_t *pgdp)
-{
-	return (pgd_t *)((unsigned long)pgdp & ~(unsigned long)PAGE_SIZE);
-}
 #else
 static inline pgd_t kaiser_set_shadow_pgd(pgd_t *pgdp, pgd_t pgd)
 {
@@ -128,10 +127,6 @@ static inline pgd_t *native_get_shadow_pgd(pgd_t *pgdp)
 	BUILD_BUG_ON(1);
 	return NULL;
 }
-static inline pgd_t *native_get_normal_pgd(pgd_t *pgdp)
-{
-	return pgdp;
-}
 #endif /* CONFIG_KAISER */
 
 static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 93554f37df99..d5b89550fb53 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -39,11 +39,7 @@
 #define _PAGE_ACCESSED	(_AT(pteval_t, 1) << _PAGE_BIT_ACCESSED)
 #define _PAGE_DIRTY	(_AT(pteval_t, 1) << _PAGE_BIT_DIRTY)
 #define _PAGE_PSE	(_AT(pteval_t, 1) << _PAGE_BIT_PSE)
-#ifdef CONFIG_KAISER
-#define _PAGE_GLOBAL	(_AT(pteval_t, 0))
-#else
 #define _PAGE_GLOBAL	(_AT(pteval_t, 1) << _PAGE_BIT_GLOBAL)
-#endif
 #define _PAGE_SOFTW1	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW1)
 #define _PAGE_SOFTW2	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW2)
 #define _PAGE_PAT	(_AT(pteval_t, 1) << _PAGE_BIT_PAT)
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index ff8c5eb95caf..b376095a1fd9 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -136,9 +136,11 @@ static inline void cr4_set_bits_and_update_boot(unsigned long mask)
  * to avoid the need for asm/kaiser.h in unexpected places.
  */
 #ifdef CONFIG_KAISER
+extern int kaiser_enabled;
 extern void kaiser_setup_pcid(void);
 extern void kaiser_flush_tlb_on_return_to_user(void);
 #else
+#define kaiser_enabled 0
 static inline void kaiser_setup_pcid(void)
 {
 }
@@ -163,7 +165,7 @@ static inline void __native_flush_tlb(void)
 	 * back:
 	 */
 	preempt_disable();
-	if (this_cpu_has(X86_FEATURE_PCID))
+	if (kaiser_enabled && this_cpu_has(X86_FEATURE_PCID))
 		kaiser_flush_tlb_on_return_to_user();
 	native_write_cr3(native_read_cr3());
 	preempt_enable();
@@ -174,20 +176,30 @@ static inline void __native_flush_tlb_global_irq_disabled(void)
 	unsigned long cr4;
 
 	cr4 = this_cpu_read(cpu_tlbstate.cr4);
-	/* clear PGE */
-	native_write_cr4(cr4 & ~X86_CR4_PGE);
-	/* write old PGE again and flush TLBs */
-	native_write_cr4(cr4);
+	if (cr4 & X86_CR4_PGE) {
+		/* clear PGE and flush TLB of all entries */
+		native_write_cr4(cr4 & ~X86_CR4_PGE);
+		/* restore PGE as it was before */
+		native_write_cr4(cr4);
+	} else {
+		/*
+		 * x86_64 microcode update comes this way when CR4.PGE is not
+		 * enabled, and it's safer for all callers to allow this case.
+		 */
+		native_write_cr3(native_read_cr3());
+	}
 }
 
 static inline void __native_flush_tlb_global(void)
 {
-#ifdef CONFIG_KAISER
-	/* Globals are not used at all */
-	__native_flush_tlb();
-#else
 	unsigned long flags;
 
+	if (kaiser_enabled) {
+		/* Globals are not used at all */
+		__native_flush_tlb();
+		return;
+	}
+
 	if (this_cpu_has(X86_FEATURE_INVPCID)) {
 		/*
 		 * Using INVPCID is considerably faster than a pair of writes
@@ -207,7 +219,6 @@ static inline void __native_flush_tlb_global(void)
 	raw_local_irq_save(flags);
 	__native_flush_tlb_global_irq_disabled();
 	raw_local_irq_restore(flags);
-#endif
 }
 
 static inline void __native_flush_tlb_single(unsigned long addr)
@@ -222,7 +233,7 @@ static inline void __native_flush_tlb_single(unsigned long addr)
 	 */
 
 	if (!this_cpu_has(X86_FEATURE_INVPCID_SINGLE)) {
-		if (this_cpu_has(X86_FEATURE_PCID))
+		if (kaiser_enabled && this_cpu_has(X86_FEATURE_PCID))
 			kaiser_flush_tlb_on_return_to_user();
 		asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
 		return;
@@ -237,9 +248,9 @@ static inline void __native_flush_tlb_single(unsigned long addr)
 	 * Make sure to do only a single invpcid when KAISER is
 	 * disabled and we have only a single ASID.
 	 */
-	if (X86_CR3_PCID_ASID_KERN != X86_CR3_PCID_ASID_USER)
-		invpcid_flush_one(X86_CR3_PCID_ASID_KERN, addr);
-	invpcid_flush_one(X86_CR3_PCID_ASID_USER, addr);
+	if (kaiser_enabled)
+		invpcid_flush_one(X86_CR3_PCID_ASID_USER, addr);
+	invpcid_flush_one(X86_CR3_PCID_ASID_KERN, addr);
 }
 
 static inline void __flush_tlb_all(void)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9e09e190ba92..4404a78bdc0a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -188,6 +188,20 @@ static int __init x86_pcid_setup(char *s)
 	return 1;
 }
 __setup("nopcid", x86_pcid_setup);
+
+static int __init x86_nokaiser_setup(char *s)
+{
+	/* nokaiser doesn't accept parameters */
+	if (s)
+		return -EINVAL;
+#ifdef CONFIG_KAISER
+	kaiser_enabled = 0;
+	setup_clear_cpu_cap(X86_FEATURE_KAISER);
+	pr_info("nokaiser: KAISER feature disabled\n");
+#endif
+	return 0;
+}
+early_param("nokaiser", x86_nokaiser_setup);
 #endif
 
 static int __init x86_noinvpcid_setup(char *s)
@@ -342,7 +356,7 @@ static __always_inline void setup_smap(struct cpuinfo_x86 *c)
 static void setup_pcid(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_PCID)) {
-		if (cpu_has(c, X86_FEATURE_PGE)) {
+		if (cpu_has(c, X86_FEATURE_PGE) || kaiser_enabled) {
 			cr4_set_bits(X86_CR4_PCIDE);
 			/*
 			 * INVPCID has two "groups" of types:
@@ -762,6 +776,10 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_power = cpuid_edx(0x80000007);
 
 	init_scattered_cpuid_features(c);
+#ifdef CONFIG_KAISER
+	if (kaiser_enabled)
+		set_cpu_cap(c, X86_FEATURE_KAISER);
+#endif
 }
 
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
@@ -1425,6 +1443,14 @@ void cpu_init(void)
 	 * try to read it.
 	 */
 	cr4_init_shadow();
+	if (!kaiser_enabled) {
+		/*
+		 * secondary_startup_64() deferred setting PGE in cr4:
+		 * probe_page_size_mask() sets it on the boot cpu,
+		 * but it needs to be set on each secondary cpu.
+		 */
+		cr4_set_bits(X86_CR4_PGE);
+	}
 
 	/*
 	 * Load microcode on this cpu if a valid microcode is available.
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 3973c43903f5..71189e3d1073 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1327,7 +1327,7 @@ ENTRY(paranoid_entry)
 	 * unconditionally, but we need to find out whether the reverse
 	 * should be done on return (conveyed to paranoid_exit in %ebx).
 	 */
-	movq	%cr3, %rax
+	ALTERNATIVE "jmp 2f", "movq %cr3, %rax", X86_FEATURE_KAISER
 	testl	$KAISER_SHADOW_PGD_OFFSET, %eax
 	jz	2f
 	orl	$2, %ebx
@@ -1360,6 +1360,7 @@ ENTRY(paranoid_exit)
 	TRACE_IRQS_OFF_DEBUG
 	TRACE_IRQS_IRETQ_DEBUG
 #ifdef CONFIG_KAISER
+	/* No ALTERNATIVE for X86_FEATURE_KAISER: paranoid_entry sets %ebx */
 	testl   $2, %ebx			/* SWITCH_USER_CR3 needed? */
 	jz      paranoid_exit_no_switch
 	SWITCH_USER_CR3
@@ -1565,13 +1566,14 @@ ENTRY(nmi)
 #ifdef CONFIG_KAISER
 	/* Unconditionally use kernel CR3 for do_nmi() */
 	/* %rax is saved above, so OK to clobber here */
-	movq	%cr3, %rax
+	ALTERNATIVE "jmp 2f", "movq %cr3, %rax", X86_FEATURE_KAISER
 	/* If PCID enabled, NOFLUSH now and NOFLUSH on return */
 	orq	x86_cr3_pcid_noflush, %rax
 	pushq	%rax
 	/* mask off "user" bit of pgd address and 12 PCID bits: */
 	andq	$(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), %rax
 	movq	%rax, %cr3
+2:
 #endif
 	call	do_nmi
 #ifdef CONFIG_KAISER
@@ -1580,8 +1582,7 @@ ENTRY(nmi)
 	 * kernel code that needs user CR3, but do we ever return
 	 * to "user mode" where we need the kernel CR3?
 	 */
-	popq	%rax
-	mov	%rax, %cr3
+	ALTERNATIVE "", "popq %rax; movq %rax, %cr3", X86_FEATURE_KAISER
 #endif
 	/*
 	 * Return back to user mode.  We must *not* do the normal exit
@@ -1804,13 +1805,14 @@ end_repeat_nmi:
 #ifdef CONFIG_KAISER
 	/* Unconditionally use kernel CR3 for do_nmi() */
 	/* %rax is saved above, so OK to clobber here */
-	movq	%cr3, %rax
+	ALTERNATIVE "jmp 2f", "movq %cr3, %rax", X86_FEATURE_KAISER
 	/* If PCID enabled, NOFLUSH now and NOFLUSH on return */
 	orq	x86_cr3_pcid_noflush, %rax
 	pushq	%rax
 	/* mask off "user" bit of pgd address and 12 PCID bits: */
 	andq	$(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), %rax
 	movq	%rax, %cr3
+2:
 #endif
 	DEFAULT_FRAME 0				/* XXX: Do we need this? */
 
@@ -1822,8 +1824,7 @@ end_repeat_nmi:
 	 * kernel code that needs user CR3, like just just before
 	 * a sysret.
 	 */
-	popq	%rax
-	mov	%rax, %cr3
+	ALTERNATIVE "", "popq %rax; movq %rax, %cr3", X86_FEATURE_KAISER
 #endif
 
 	testl %ebx,%ebx				/* swapgs needed? */
diff --git a/arch/x86/kernel/espfix_64.c b/arch/x86/kernel/espfix_64.c
index a48fad060fe9..aef263b0577d 100644
--- a/arch/x86/kernel/espfix_64.c
+++ b/arch/x86/kernel/espfix_64.c
@@ -132,9 +132,10 @@ void __init init_espfix_bsp(void)
 	 * area to ensure it is mapped into the shadow user page
 	 * tables.
 	 */
-	if (IS_ENABLED(CONFIG_KAISER))
+	if (kaiser_enabled) {
 		set_pgd(native_get_shadow_pgd(pgd_p),
 			__pgd(_KERNPG_TABLE | __pa((pud_t *)espfix_pud_page)));
+	}
 
 	/* Randomize the locations */
 	init_espfix_random();
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 73e7f8e90fac..0d89f538efb6 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -183,8 +183,8 @@ ENTRY(secondary_startup_64)
 	movq	$(init_level4_pgt - __START_KERNEL_map), %rax
 1:
 
-	/* Enable PAE mode and PGE */
-	movl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
+	/* Enable PAE and PSE, but defer PGE until kaiser_enabled is decided */
+	movl	$(X86_CR4_PAE | X86_CR4_PSE), %ecx
 	movq	%rcx, %cr4
 
 	/* Setup early boot stage 4 level pagetables. */
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 0a06e5a14278..785bd0347d13 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -162,7 +162,7 @@ static void __init probe_page_size_mask(void)
 		cr4_set_bits_and_update_boot(X86_CR4_PSE);
 
 	/* Enable PGE if available */
-	if (cpu_has_pge) {
+	if (cpu_has_pge && !kaiser_enabled) {
 		cr4_set_bits_and_update_boot(X86_CR4_PGE);
 		__supported_pte_mask |= _PAGE_GLOBAL;
 	} else
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index f9977a7a9444..a97d3cd16354 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -395,6 +395,16 @@ void __init cleanup_highmap(void)
 			continue;
 		if (vaddr < (unsigned long) _text || vaddr > end)
 			set_pmd(pmd, __pmd(0));
+		else if (kaiser_enabled) {
+			/*
+			 * level2_kernel_pgt is initialized with _PAGE_GLOBAL:
+			 * clear that now.  This is not important, so long as
+			 * CR4.PGE remains clear, but it removes an anomaly.
+			 * Physical mapping setup below avoids _PAGE_GLOBAL
+			 * by use of massage_pgprot() inside pfn_pte() etc.
+			 */
+			set_pmd(pmd, pmd_clear_flags(*pmd, _PAGE_GLOBAL));
+		}
 	}
 }
 
diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index f6e85067d58e..bfd48347eaac 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -17,7 +17,9 @@
 #include <asm/pgalloc.h>
 #include <asm/desc.h>
 
-#ifdef CONFIG_KAISER
+int kaiser_enabled __read_mostly = 1;
+EXPORT_SYMBOL(kaiser_enabled);	/* for inlined TLB flush functions */
+
 __visible
 DEFINE_PER_CPU_USER_MAPPED(unsigned long, unsafe_stack_register_backup);
 
@@ -168,8 +170,8 @@ static pte_t *kaiser_pagetable_walk(unsigned long address, bool is_atomic)
 	return pte_offset_kernel(pmd, address);
 }
 
-int kaiser_add_user_map(const void *__start_addr, unsigned long size,
-			unsigned long flags)
+static int kaiser_add_user_map(const void *__start_addr, unsigned long size,
+			       unsigned long flags)
 {
 	int ret = 0;
 	pte_t *pte;
@@ -178,6 +180,15 @@ int kaiser_add_user_map(const void *__start_addr, unsigned long size,
 	unsigned long end_addr = PAGE_ALIGN(start_addr + size);
 	unsigned long target_address;
 
+	/*
+	 * It is convenient for callers to pass in __PAGE_KERNEL etc,
+	 * and there is no actual harm from setting _PAGE_GLOBAL, so
+	 * long as CR4.PGE is not set.  But it is nonetheless troubling
+	 * to see Kaiser itself setting _PAGE_GLOBAL (now that "nokaiser"
+	 * requires that not to be #defined to 0): so mask it off here.
+	 */
+	flags &= ~_PAGE_GLOBAL;
+
 	for (; address < end_addr; address += PAGE_SIZE) {
 		target_address = get_pa_from_mapping(address);
 		if (target_address == -1) {
@@ -264,6 +275,8 @@ void __init kaiser_init(void)
 {
 	int cpu;
 
+	if (!kaiser_enabled)
+		return;
 	kaiser_init_all_pgds();
 
 	for_each_possible_cpu(cpu) {
@@ -312,6 +325,8 @@ void __init kaiser_init(void)
 /* Add a mapping to the shadow mapping, and synchronize the mappings */
 int kaiser_add_mapping(unsigned long addr, unsigned long size, unsigned long flags)
 {
+	if (!kaiser_enabled)
+		return 0;
 	return kaiser_add_user_map((const void *)addr, size, flags);
 }
 
@@ -323,6 +338,8 @@ void kaiser_remove_mapping(unsigned long start, unsigned long size)
 	unsigned long addr, next;
 	pgd_t *pgd;
 
+	if (!kaiser_enabled)
+		return;
 	pgd = native_get_shadow_pgd(pgd_offset_k(start));
 	for (addr = start; addr < end; pgd++, addr = next) {
 		next = pgd_addr_end(addr, end);
@@ -344,6 +361,8 @@ static inline bool is_userspace_pgd(pgd_t *pgdp)
 
 pgd_t kaiser_set_shadow_pgd(pgd_t *pgdp, pgd_t pgd)
 {
+	if (!kaiser_enabled)
+		return pgd;
 	/*
 	 * Do we need to also populate the shadow pgd?  Check _PAGE_USER to
 	 * skip cases like kexec and EFI which make temporary low mappings.
@@ -400,4 +419,3 @@ void kaiser_flush_tlb_on_return_to_user(void)
 			X86_CR3_PCID_USER_FLUSH | KAISER_SHADOW_PGD_OFFSET);
 }
 EXPORT_SYMBOL(kaiser_flush_tlb_on_return_to_user);
-#endif /* CONFIG_KAISER */
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 20b8438f35c0..1cec796635d7 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -341,16 +341,12 @@ static inline void _pgd_free(pgd_t *pgd)
 }
 #else
 
-#ifdef CONFIG_KAISER
 /*
- * Instead of one pmd, we aquire two pmds.  Being order-1, it is
+ * Instead of one pgd, Kaiser acquires two pgds.  Being order-1, it is
  * both 8k in size and 8k-aligned.  That lets us just flip bit 12
  * in a pointer to swap between the two 4k halves.
  */
-#define PGD_ALLOCATION_ORDER 1
-#else
-#define PGD_ALLOCATION_ORDER 0
-#endif
+#define PGD_ALLOCATION_ORDER	kaiser_enabled
 
 static inline pgd_t *_pgd_alloc(void)
 {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 749e2134bd7a..5539d613c263 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -39,8 +39,7 @@ static void load_new_mm_cr3(pgd_t *pgdir)
 {
 	unsigned long new_mm_cr3 = __pa(pgdir);
 
-#ifdef CONFIG_KAISER
-	if (this_cpu_has(X86_FEATURE_PCID)) {
+	if (kaiser_enabled && this_cpu_has(X86_FEATURE_PCID)) {
 		/*
 		 * We reuse the same PCID for different tasks, so we must
 		 * flush all the entries for the PCID out when we change tasks.
@@ -57,7 +56,6 @@ static void load_new_mm_cr3(pgd_t *pgdir)
 		new_mm_cr3 |= X86_CR3_PCID_KERN_FLUSH;
 		kaiser_flush_tlb_on_return_to_user();
 	}
-#endif /* CONFIG_KAISER */
 
 	/*
 	 * Caution: many callers of this function expect
-- 
2.16.2
