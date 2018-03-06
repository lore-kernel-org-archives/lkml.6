Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELun+ayc8zhkx8PA9NAUD/cv/Hhwh4C8/Ev69w0CYLpvI0vPoiG4OYydnS3VmKvH0UENOBzI
ARC-Seal: i=1; a=rsa-sha256; t=1520295999; cv=none;
        d=google.com; s=arc-20160816;
        b=QDT737yGUgdO0h7VUDXJiiGGUN8J7yVL1hVKeQmCnlgFh9kPIrlJzZYyBbVD7dJHQw
         B/zkOPgEcKKUj8cj9ukzUZr4hZNSnywBJIMwdV5sL+3s6Ha662hhkNtYe8S+xzskXTfT
         5VhvBXzjYCR7JbvWJEwVkh45aaejFGwLHN8NDSLY8lzTwhNKpG4vDBYN14Pd5ZU5E6Dj
         ZVeTbIhytw/hiq7bsA0srFeIf6sIySf5MX/z5Zmcy4vSg2g6IFi32e6iH6H4xHtr/rqH
         CDXG1EJnIhFbVxFE7yvuGQQ/k2lWjY8gy2oFBagXI8lxDoTVz/HvcmbllvjcDLN1hzQy
         dw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=miKudcJsOFUcuBNsFt0BiUZgcrfFIjlJ98w9mhT8j6s=;
        b=wztNPRQvTaImXUEZnm1L/gNNHF2Ya7AlrrveJW+2tqJc1E79ixf19AumDmmQT+T9BK
         +KG84NP5aylNzdAavHq/kkZHXLtwthJli2Ae4+bfDMLN/AFDQ0ZFMNMAencCU1QdSjFI
         dseZW971t4CnUjAjsfpN5WY/05gR6tsg7JlX9hufdptg4z4M0dERs0fi2J9j8+P+m/wq
         m18GDBZiRtuDk0jP8/6PU1GhwcjxdsvfkppB4LRNkTjdqWiq8zz6HG+S0VhTr8XJCvZl
         z3fUp9rbmXqqznrW5VIPmRIoP114CA1OohfOfwb4597yWtCyp58tI/d/tcL5aRz2YsRV
         qd7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Qb3GppGP;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Qb3GppGP;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 42/65] kaiser: enhanced by kernel and user PCIDs
Date: Mon,  5 Mar 2018 19:25:15 -0500
Message-Id: <20180306002538.1761-43-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145898310750873?=
X-GMAIL-MSGID: =?utf-8?q?1594145898310750873?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dave Hansen <dave.hansen@linux.intel.com>

Merged performance improvements to Kaiser, using distinct kernel
and user Process Context Identifiers to minimize the TLB flushing.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit eb82151d0b1df53d1ad8d060ecd554ca12eb552a)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/entry/entry_64.S (not in this tree)
	arch/x86/kernel/entry_64.S (patched instead of that)
	arch/x86/entry/entry_64_compat.S (not in this tree)
	arch/x86/ia32/ia32entry.S (patched instead of that)
	arch/x86/include/asm/tlbflush.h
---
 arch/x86/ia32/ia32entry.S                   |  1 +
 arch/x86/include/asm/cpufeature.h           |  1 +
 arch/x86/include/asm/kaiser.h               | 15 ++++++++--
 arch/x86/include/asm/pgtable_types.h        | 26 ++++++++++++++++
 arch/x86/include/asm/tlbflush.h             | 37 +++++++++++++++++++++--
 arch/x86/include/uapi/asm/processor-flags.h |  3 +-
 arch/x86/kernel/cpu/common.c                | 34 +++++++++++++++++++++
 arch/x86/kernel/entry_64.S                  | 10 +++++--
 arch/x86/kvm/x86.c                          |  3 +-
 arch/x86/mm/kaiser.c                        |  7 +++++
 arch/x86/mm/tlb.c                           | 46 +++++++++++++++++++++++++++--
 11 files changed, 172 insertions(+), 11 deletions(-)

diff --git a/arch/x86/ia32/ia32entry.S b/arch/x86/ia32/ia32entry.S
index 665e2c7887fe..070470d161f6 100644
--- a/arch/x86/ia32/ia32entry.S
+++ b/arch/x86/ia32/ia32entry.S
@@ -15,6 +15,7 @@
 #include <asm/irqflags.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
+#include <asm/pgtable_types.h>
 #include <asm/kaiser.h>
 #include <linux/linkage.h>
 #include <linux/err.h>
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 3d6606fb97d0..80a2b9487b29 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -185,6 +185,7 @@
 #define X86_FEATURE_ARAT	( 7*32+ 1) /* Always Running APIC Timer */
 #define X86_FEATURE_CPB		( 7*32+ 2) /* AMD Core Performance Boost */
 #define X86_FEATURE_EPB		( 7*32+ 3) /* IA32_ENERGY_PERF_BIAS support */
+#define X86_FEATURE_INVPCID_SINGLE ( 7*32+ 4) /* Effectively INVPCID && CR4.PCIDE=1 */
 #define X86_FEATURE_PLN		( 7*32+ 5) /* Intel Power Limit Notification */
 #define X86_FEATURE_PTS		( 7*32+ 6) /* Intel Package Thermal Status */
 #define X86_FEATURE_DTHERM	( 7*32+ 7) /* Digital Thermal Sensor */
diff --git a/arch/x86/include/asm/kaiser.h b/arch/x86/include/asm/kaiser.h
index e0fc45e77aee..360ff3bc44a9 100644
--- a/arch/x86/include/asm/kaiser.h
+++ b/arch/x86/include/asm/kaiser.h
@@ -1,5 +1,8 @@
 #ifndef _ASM_X86_KAISER_H
 #define _ASM_X86_KAISER_H
+
+#include <uapi/asm/processor-flags.h> /* For PCID constants */
+
 /*
  * This file includes the definitions for the KAISER feature.
  * KAISER is a counter measure against x86_64 side channel attacks on
@@ -21,13 +24,21 @@
 
 .macro _SWITCH_TO_KERNEL_CR3 reg
 movq %cr3, \reg
-andq $(~KAISER_SHADOW_PGD_OFFSET), \reg
+andq $(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), \reg
+orq  X86_CR3_PCID_KERN_VAR, \reg
 movq \reg, %cr3
 .endm
 
 .macro _SWITCH_TO_USER_CR3 reg
 movq %cr3, \reg
-orq $(KAISER_SHADOW_PGD_OFFSET), \reg
+andq $(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), \reg
+/*
+ * This can obviously be one instruction by putting the
+ * KAISER_SHADOW_PGD_OFFSET bit in the X86_CR3_PCID_USER_VAR.
+ * But, just leave it now for simplicity.
+ */
+orq  X86_CR3_PCID_USER_VAR, \reg
+orq  $(KAISER_SHADOW_PGD_OFFSET), \reg
 movq \reg, %cr3
 .endm
 
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 7a5fc4410c00..b3c77e6529c2 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -106,6 +106,32 @@
 			 _PAGE_SOFT_DIRTY)
 #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
 
+/* The ASID is the lower 12 bits of CR3 */
+#define X86_CR3_PCID_ASID_MASK  (_AC((1<<12)-1,UL))
+
+/* Mask for all the PCID-related bits in CR3: */
+#define X86_CR3_PCID_MASK       (X86_CR3_PCID_NOFLUSH | X86_CR3_PCID_ASID_MASK)
+#if defined(CONFIG_KAISER) && defined(CONFIG_X86_64)
+#define X86_CR3_PCID_ASID_KERN  (_AC(0x4,UL))
+#define X86_CR3_PCID_ASID_USER  (_AC(0x6,UL))
+
+#define X86_CR3_PCID_KERN_FLUSH		(X86_CR3_PCID_ASID_KERN)
+#define X86_CR3_PCID_USER_FLUSH		(X86_CR3_PCID_ASID_USER)
+#define X86_CR3_PCID_KERN_NOFLUSH	(X86_CR3_PCID_NOFLUSH | X86_CR3_PCID_ASID_KERN)
+#define X86_CR3_PCID_USER_NOFLUSH	(X86_CR3_PCID_NOFLUSH | X86_CR3_PCID_ASID_USER)
+#else
+#define X86_CR3_PCID_ASID_KERN  (_AC(0x0,UL))
+#define X86_CR3_PCID_ASID_USER  (_AC(0x0,UL))
+/*
+ * PCIDs are unsupported on 32-bit and none of these bits can be
+ * set in CR3:
+ */
+#define X86_CR3_PCID_KERN_FLUSH		(0)
+#define X86_CR3_PCID_USER_FLUSH		(0)
+#define X86_CR3_PCID_KERN_NOFLUSH	(0)
+#define X86_CR3_PCID_USER_NOFLUSH	(0)
+#endif
+
 /*
  * The cache modes defined here are used to translate between pure SW usage
  * and the HW defined cache mode bits and/or PAT entries.
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 09a70d8d293e..b558d1996621 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -12,7 +12,6 @@ static inline void __invpcid(unsigned long pcid, unsigned long addr,
 			     unsigned long type)
 {
 	struct { u64 d[2]; } desc = { { pcid, addr } };
-
 	/*
 	 * The memory clobber is because the whole point is to invalidate
 	 * stale TLB entries and, especially if we're flushing global
@@ -134,6 +133,14 @@ static inline void cr4_set_bits_and_update_boot(unsigned long mask)
 static inline void __native_flush_tlb(void)
 {
 	native_write_cr3(native_read_cr3());
+	/*
+	 * We are no longer using globals with KAISER, so a
+	 * "nonglobals" flush would work too. But, this is more
+	 * conservative.
+	 *
+	 * Note, this works with CR4.PCIDE=0 or 1.
+	 */
+	invpcid_flush_all();
 }
 
 static inline void __native_flush_tlb_global_irq_disabled(void)
@@ -155,6 +162,8 @@ static inline void __native_flush_tlb_global(void)
 		/*
 		 * Using INVPCID is considerably faster than a pair of writes
 		 * to CR4 sandwiched inside an IRQ flag save/restore.
+		 *
+	 	 * Note, this works with CR4.PCIDE=0 or 1.
 		 */
 		invpcid_flush_all();
 		return;
@@ -174,7 +183,31 @@ static inline void __native_flush_tlb_global(void)
 
 static inline void __native_flush_tlb_single(unsigned long addr)
 {
-	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
+	/*
+	 * SIMICS #GP's if you run INVPCID with type 2/3
+	 * and X86_CR4_PCIDE clear.  Shame!
+	 *
+	 * The ASIDs used below are hard-coded.  But, we must not
+	 * call invpcid(type=1/2) before CR4.PCIDE=1.  Just call
+	 * invpcid in the case we are called early.
+	 */
+	if (!this_cpu_has(X86_FEATURE_INVPCID_SINGLE)) {
+		asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
+		return;
+	}
+	/* Flush the address out of both PCIDs. */
+	/*
+	 * An optimization here might be to determine addresses
+	 * that are only kernel-mapped and only flush the kernel
+	 * ASID.  But, userspace flushes are probably much more
+	 * important performance-wise.
+	 *
+	 * Make sure to do only a single invpcid when KAISER is
+	 * disabled and we have only a single ASID.
+	 */
+	if (X86_CR3_PCID_ASID_KERN != X86_CR3_PCID_ASID_USER)
+		invpcid_flush_one(X86_CR3_PCID_ASID_KERN, addr);
+	invpcid_flush_one(X86_CR3_PCID_ASID_USER, addr);
 }
 
 static inline void __flush_tlb_all(void)
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index 180a0c3c224d..bd4513b7b877 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -79,7 +79,8 @@
 #define X86_CR3_PWT		_BITUL(X86_CR3_PWT_BIT)
 #define X86_CR3_PCD_BIT		4 /* Page Cache Disable */
 #define X86_CR3_PCD		_BITUL(X86_CR3_PCD_BIT)
-#define X86_CR3_PCID_MASK	_AC(0x00000fff,UL) /* PCID Mask */
+#define X86_CR3_PCID_NOFLUSH_BIT 63 /* Preserve old PCID */
+#define X86_CR3_PCID_NOFLUSH    _BITULL(X86_CR3_PCID_NOFLUSH_BIT)
 
 /*
  * Intel CPU features in CR4
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 47194fac7eb7..6fb0d332f440 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -339,11 +339,45 @@ static __always_inline void setup_smap(struct cpuinfo_x86 *c)
 	}
 }
 
+/*
+ * These can have bit 63 set, so we can not just use a plain "or"
+ * instruction to get their value or'd into CR3.  It would take
+ * another register.  So, we use a memory reference to these
+ * instead.
+ *
+ * This is also handy because systems that do not support
+ * PCIDs just end up or'ing a 0 into their CR3, which does
+ * no harm.
+ */
+__aligned(PAGE_SIZE) unsigned long X86_CR3_PCID_KERN_VAR = 0;
+__aligned(PAGE_SIZE) unsigned long X86_CR3_PCID_USER_VAR = 0;
+
 static void setup_pcid(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_PCID)) {
 		if (cpu_has(c, X86_FEATURE_PGE)) {
 			cr4_set_bits(X86_CR4_PCIDE);
+			/*
+			 * These variables are used by the entry/exit
+			 * code to change PCIDs.
+			 */
+#ifdef CONFIG_KAISER
+			X86_CR3_PCID_KERN_VAR = X86_CR3_PCID_KERN_NOFLUSH;
+			X86_CR3_PCID_USER_VAR = X86_CR3_PCID_USER_NOFLUSH;
+#endif
+			/*
+			 * INVPCID has two "groups" of types:
+			 * 1/2: Invalidate an individual address
+			 * 3/4: Invalidate all contexts
+			 *
+			 * 1/2 take a PCID, but 3/4 do not.  So, 3/4
+			 * ignore the PCID argument in the descriptor.
+			 * But, we have to be careful not to call 1/2
+			 * with an actual non-zero PCID in them before
+			 * we do the above cr4_set_bits().
+			 */
+			if (cpu_has(c, X86_FEATURE_INVPCID))
+				set_cpu_cap(c, X86_FEATURE_INVPCID_SINGLE);
 		} else {
 			/*
 			 * flush_tlb_all(), as currently implemented, won't
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index d2b2372e01c6..0f7bba928264 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1541,7 +1541,10 @@ ENTRY(nmi)
 	/* %rax is saved above, so OK to clobber here */
 	movq	%cr3, %rax
 	pushq	%rax
-	andq	$(~KAISER_SHADOW_PGD_OFFSET), %rax
+	/* mask off "user" bit of pgd address and 12 PCID bits: */
+	andq	$(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), %rax
+	/* Add back kernel PCID and "no flush" bit */
+	orq	X86_CR3_PCID_KERN_VAR, %rax
 	movq	%rax, %cr3
 #endif
 	call	do_nmi
@@ -1777,7 +1780,10 @@ end_repeat_nmi:
 	/* %rax is saved above, so OK to clobber here */
 	movq	%cr3, %rax
 	pushq	%rax
-	andq	$(~KAISER_SHADOW_PGD_OFFSET), %rax
+	/* mask off "user" bit of pgd address and 12 PCID bits: */
+	andq	$(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), %rax
+	/* Add back kernel PCID and "no flush" bit */
+	orq	X86_CR3_PCID_KERN_VAR, %rax
 	movq	%rax, %cr3
 #endif
 	DEFAULT_FRAME 0				/* XXX: Do we need this? */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e4e7d45fd551..153afbb6c080 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -733,7 +733,8 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 			return 1;
 
 		/* PCID can not be enabled when cr3[11:0]!=000H or EFER.LMA=0 */
-		if ((kvm_read_cr3(vcpu) & X86_CR3_PCID_MASK) || !is_long_mode(vcpu))
+		if ((kvm_read_cr3(vcpu) & X86_CR3_PCID_ASID_MASK) ||
+		    !is_long_mode(vcpu))
 			return 1;
 	}
 
diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index 50d650799f39..91968328ccdf 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -240,6 +240,8 @@ static void __init kaiser_init_all_pgds(void)
 } while (0)
 
 extern char __per_cpu_user_mapped_start[], __per_cpu_user_mapped_end[];
+extern unsigned long X86_CR3_PCID_KERN_VAR;
+extern unsigned long X86_CR3_PCID_USER_VAR;
 /*
  * If anything in here fails, we will likely die on one of the
  * first kernel->user transitions and init will die.  But, we
@@ -290,6 +292,11 @@ void __init kaiser_init(void)
 	kaiser_add_user_map_early(&debug_idt_table,
 				  sizeof(gate_desc) * NR_VECTORS,
 				  __PAGE_KERNEL);
+
+	kaiser_add_user_map_early(&X86_CR3_PCID_KERN_VAR, PAGE_SIZE,
+				  __PAGE_KERNEL);
+	kaiser_add_user_map_early(&X86_CR3_PCID_USER_VAR, PAGE_SIZE,
+				  __PAGE_KERNEL);
 }
 
 /* Add a mapping to the shadow mapping, and synchronize the mappings */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 95624d903c0e..7176496112ff 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -34,6 +34,46 @@ struct flush_tlb_info {
 	unsigned long flush_end;
 };
 
+static void load_new_mm_cr3(pgd_t *pgdir)
+{
+	unsigned long new_mm_cr3 = __pa(pgdir);
+
+	/*
+	 * KAISER, plus PCIDs needs some extra work here.  But,
+	 * if either of features is not present, we need no
+	 * PCIDs here and just do a normal, full TLB flush with
+	 * the write_cr3()
+	 */
+	if (!IS_ENABLED(CONFIG_KAISER) ||
+	    !cpu_feature_enabled(X86_FEATURE_PCID))
+		goto out_set_cr3;
+	/*
+	 * We reuse the same PCID for different tasks, so we must
+	 * flush all the entires for the PCID out when we change
+	 * tasks.
+	 */
+	new_mm_cr3 = X86_CR3_PCID_KERN_FLUSH | __pa(pgdir);
+
+	/*
+	 * The flush from load_cr3() may leave old TLB entries
+	 * for userspace in place.  We must flush that context
+	 * separately.  We can theoretically delay doing this
+	 * until we actually load up the userspace CR3, but
+	 * that's a bit tricky.  We have to have the "need to
+	 * flush userspace PCID" bit per-cpu and check it in the
+	 * exit-to-userspace paths.
+	 */
+	invpcid_flush_single_context(X86_CR3_PCID_ASID_USER);
+
+out_set_cr3:
+	/*
+	 * Caution: many callers of this function expect
+	 * that load_cr3() is serializing and orders TLB
+	 * fills with respect to the mm_cpumask writes.
+	 */
+	write_cr3(new_mm_cr3);
+}
+
 /*
  * We cannot call mmdrop() because we are in interrupt context,
  * instead update mm->cpu_vm_mask.
@@ -45,7 +85,7 @@ void leave_mm(int cpu)
 		BUG();
 	if (cpumask_test_cpu(cpu, mm_cpumask(active_mm))) {
 		cpumask_clear_cpu(cpu, mm_cpumask(active_mm));
-		load_cr3(swapper_pg_dir);
+		load_new_mm_cr3(swapper_pg_dir);
 		/*
 		 * This gets called in the idle path where RCU
 		 * functions differently.  Tracing normally
@@ -105,7 +145,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * ordering guarantee we need.
 		 *
 		 */
-		load_cr3(next->pgd);
+		load_new_mm_cr3(next->pgd);
 
 		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
 
@@ -150,7 +190,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			 * As above, load_cr3() is serializing and orders TLB
 			 * fills with respect to the mm_cpumask write.
 			 */
-			load_cr3(next->pgd);
+			load_new_mm_cr3(next->pgd);
 			trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
 			load_mm_cr4(next);
 			load_mm_ldt(next);
-- 
2.16.2
