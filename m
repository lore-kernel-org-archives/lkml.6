Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELtHywcGEg//iMEX1gtDavJbtY2NKZkIOManc1zbD2+VsmgKvcGNxD4a0PBjaD1n++1zLN4E
ARC-Seal: i=1; a=rsa-sha256; t=1520296000; cv=none;
        d=google.com; s=arc-20160816;
        b=zrTXG45NgmhHrKbxpaIfF+OuCOHNLUeSxuSnSsaulk8yopW0zjtnSw43Oixp5E5R9L
         lo/LBZ67znQCNxx0DWxrehC0G3as8vVdNpGpRl6fUBcUET6ggg50368vv7HgE0xj9RWB
         Css26KhxJovrFB+bwaJ8dBLuWric6KyagQNCYUT6Ylq5Fg/IaeBk3XSpWpHgmOO8sC2c
         S+1PAqw0e3QT7ovn10jA98/K8QqBesyCcQCQUqyTjugzTzMoLxDhxmKr31M2/j5mB2FU
         3HrJCtsiASAGUHXWsKjTQpoDNqZt1Kkgh4/6N+YDJgGQjJ9VMByPYpgsNaf0kGgH1sGN
         Ac8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=wGSaqbzeMR7IRsCOyNZK+MM0TBdH3S5swLeEFm1ieV4=;
        b=lqnlnil0kQBhk7u6bL+IYptBZ3sqQcygzC17TqKXSnP8rTTzCT+PpkCTYmcLiaMqmG
         2v0+xMgOGYrlWvi6WevD3kK8y+wmq0T95UUxv7HhY/0yH/X9jJj8bNzYa/1fZhGJc8OA
         6he3atkW85oupSU+XEt7DqHWfLSMg/LmG1Vch82vIz4p0REJdzQBSqnorgwCpIgSWMS8
         BGVhpR6eWr/bpKXVKqazCJHMV/743YrQ3zqngntc+o3KvzvF92tYEaN87i3+KxaF9rdU
         C0t/mxq3oklLpNcveYgi0TF8YFZWkaBrCVe/nAZazSEK0p/oyCTy1MxS0pf2X3R9HzYe
         NQQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=H1QOH1de;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=H1QOH1de;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 43/65] kaiser: load_new_mm_cr3() let SWITCH_USER_CR3 flush user
Date: Mon,  5 Mar 2018 19:25:16 -0500
Message-Id: <20180306002538.1761-44-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145898725652167?=
X-GMAIL-MSGID: =?utf-8?q?1594145898725652167?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

We have many machines (Westmere, Sandybridge, Ivybridge) supporting
PCID but not INVPCID: on these load_new_mm_cr3() simply crashed.

Flushing user context inside load_new_mm_cr3() without the use of
invpcid is difficult: momentarily switch from kernel to user context
and back to do so?  I'm not sure whether that can be safely done at
all, and would risk polluting user context with kernel internals,
and kernel context with stale user externals.

Instead, follow the hint in the comment that was there: change
X86_CR3_PCID_USER_VAR to be a per-cpu variable, then load_new_mm_cr3()
can leave a note in it, for SWITCH_USER_CR3 on return to userspace to
flush user context TLB, instead of default X86_CR3_PCID_USER_NOFLUSH.

Which works well enough that there's no need to do it this way only
when invpcid is unsupported: it's a good alternative to invpcid here.
But there's a couple of inlines in asm/tlbflush.h that need to do the
same trick, so it's best to localize all this per-cpu business in
mm/kaiser.c: moving that part of the initialization from setup_pcid()
to kaiser_setup_pcid(); with kaiser_flush_tlb_on_return_to_user() the
function for noting an X86_CR3_PCID_USER_FLUSH.  And let's keep a
KAISER_SHADOW_PGD_OFFSET in there, to avoid the extra OR on exit.

I did try to make the feature tests in asm/tlbflush.h more consistent
with each other: there seem to be far too many ways of performing such
tests, and I don't have a good grasp of their differences.  At first
I converted them all to be static_cpu_has(): but that proved to be a
mistake, as the comment in __native_flush_tlb_single() hints; so then
I reversed and made them all this_cpu_has().  Probably all gratuitous
change, but that's the way it's working at present.

I am slightly bothered by the way non-per-cpu X86_CR3_PCID_KERN_VAR
gets re-initialized by each cpu (before and after these changes):
no problem when (as usual) all cpus on a machine have the same
features, but in principle incorrect.  However, my experiment
to per-cpu-ify that one did not end well...

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 0731188fc74cc2237975a2b5bedd36e2463ef10b)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/include/asm/tlbflush.h
---
 arch/x86/include/asm/kaiser.h   | 18 ++++++++------
 arch/x86/include/asm/tlbflush.h | 54 ++++++++++++++++++++++++++++++++---------
 arch/x86/kernel/cpu/common.c    | 22 +----------------
 arch/x86/mm/kaiser.c            | 50 +++++++++++++++++++++++++++++++++-----
 arch/x86/mm/tlb.c               | 46 ++++++++++++++---------------------
 5 files changed, 117 insertions(+), 73 deletions(-)

diff --git a/arch/x86/include/asm/kaiser.h b/arch/x86/include/asm/kaiser.h
index 360ff3bc44a9..009bca514c20 100644
--- a/arch/x86/include/asm/kaiser.h
+++ b/arch/x86/include/asm/kaiser.h
@@ -32,13 +32,12 @@ movq \reg, %cr3
 .macro _SWITCH_TO_USER_CR3 reg
 movq %cr3, \reg
 andq $(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), \reg
-/*
- * This can obviously be one instruction by putting the
- * KAISER_SHADOW_PGD_OFFSET bit in the X86_CR3_PCID_USER_VAR.
- * But, just leave it now for simplicity.
- */
-orq  X86_CR3_PCID_USER_VAR, \reg
-orq  $(KAISER_SHADOW_PGD_OFFSET), \reg
+orq  PER_CPU_VAR(X86_CR3_PCID_USER_VAR), \reg
+js   9f
+// FLUSH this time, reset to NOFLUSH for next time
+// But if nopcid?  Consider using 0x80 for user pcid?
+movb $(0x80), PER_CPU_VAR(X86_CR3_PCID_USER_VAR+7)
+9:
 movq \reg, %cr3
 .endm
 
@@ -90,6 +89,11 @@ movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
 */
 DECLARE_PER_CPU_USER_MAPPED(unsigned long, unsafe_stack_register_backup);
 
+extern unsigned long X86_CR3_PCID_KERN_VAR;
+DECLARE_PER_CPU(unsigned long, X86_CR3_PCID_USER_VAR);
+
+extern char __per_cpu_user_mapped_start[], __per_cpu_user_mapped_end[];
+
 /**
  *  kaiser_add_mapping - map a virtual memory part to the shadow (user) mapping
  *  @addr: the start address of the range
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index b558d1996621..ff8c5eb95caf 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -12,6 +12,7 @@ static inline void __invpcid(unsigned long pcid, unsigned long addr,
 			     unsigned long type)
 {
 	struct { u64 d[2]; } desc = { { pcid, addr } };
+
 	/*
 	 * The memory clobber is because the whole point is to invalidate
 	 * stale TLB entries and, especially if we're flushing global
@@ -130,17 +131,42 @@ static inline void cr4_set_bits_and_update_boot(unsigned long mask)
 	cr4_set_bits(mask);
 }
 
+/*
+ * Declare a couple of kaiser interfaces here for convenience,
+ * to avoid the need for asm/kaiser.h in unexpected places.
+ */
+#ifdef CONFIG_KAISER
+extern void kaiser_setup_pcid(void);
+extern void kaiser_flush_tlb_on_return_to_user(void);
+#else
+static inline void kaiser_setup_pcid(void)
+{
+}
+static inline void kaiser_flush_tlb_on_return_to_user(void)
+{
+}
+#endif
+
 static inline void __native_flush_tlb(void)
 {
-	native_write_cr3(native_read_cr3());
+	if (this_cpu_has(X86_FEATURE_INVPCID)) {
+		/*
+		 * Note, this works with CR4.PCIDE=0 or 1.
+		 */
+		invpcid_flush_all_nonglobals();
+		return;
+	}
+
 	/*
-	 * We are no longer using globals with KAISER, so a
-	 * "nonglobals" flush would work too. But, this is more
-	 * conservative.
-	 *
-	 * Note, this works with CR4.PCIDE=0 or 1.
+	 * If current->mm == NULL then we borrow a mm which may change during a
+	 * task switch and therefore we must not be preempted while we write CR3
+	 * back:
 	 */
-	invpcid_flush_all();
+	preempt_disable();
+	if (this_cpu_has(X86_FEATURE_PCID))
+		kaiser_flush_tlb_on_return_to_user();
+	native_write_cr3(native_read_cr3());
+	preempt_enable();
 }
 
 static inline void __native_flush_tlb_global_irq_disabled(void)
@@ -156,9 +182,13 @@ static inline void __native_flush_tlb_global_irq_disabled(void)
 
 static inline void __native_flush_tlb_global(void)
 {
+#ifdef CONFIG_KAISER
+	/* Globals are not used at all */
+	__native_flush_tlb();
+#else
 	unsigned long flags;
 
-	if (static_cpu_has(X86_FEATURE_INVPCID)) {
+	if (this_cpu_has(X86_FEATURE_INVPCID)) {
 		/*
 		 * Using INVPCID is considerably faster than a pair of writes
 		 * to CR4 sandwiched inside an IRQ flag save/restore.
@@ -175,10 +205,9 @@ static inline void __native_flush_tlb_global(void)
 	 * be called from deep inside debugging code.)
 	 */
 	raw_local_irq_save(flags);
-
 	__native_flush_tlb_global_irq_disabled();
-
 	raw_local_irq_restore(flags);
+#endif
 }
 
 static inline void __native_flush_tlb_single(unsigned long addr)
@@ -189,9 +218,12 @@ static inline void __native_flush_tlb_single(unsigned long addr)
 	 *
 	 * The ASIDs used below are hard-coded.  But, we must not
 	 * call invpcid(type=1/2) before CR4.PCIDE=1.  Just call
-	 * invpcid in the case we are called early.
+	 * invlpg in the case we are called early.
 	 */
+
 	if (!this_cpu_has(X86_FEATURE_INVPCID_SINGLE)) {
+		if (this_cpu_has(X86_FEATURE_PCID))
+			kaiser_flush_tlb_on_return_to_user();
 		asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 6fb0d332f440..9e09e190ba92 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -339,32 +339,11 @@ static __always_inline void setup_smap(struct cpuinfo_x86 *c)
 	}
 }
 
-/*
- * These can have bit 63 set, so we can not just use a plain "or"
- * instruction to get their value or'd into CR3.  It would take
- * another register.  So, we use a memory reference to these
- * instead.
- *
- * This is also handy because systems that do not support
- * PCIDs just end up or'ing a 0 into their CR3, which does
- * no harm.
- */
-__aligned(PAGE_SIZE) unsigned long X86_CR3_PCID_KERN_VAR = 0;
-__aligned(PAGE_SIZE) unsigned long X86_CR3_PCID_USER_VAR = 0;
-
 static void setup_pcid(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_PCID)) {
 		if (cpu_has(c, X86_FEATURE_PGE)) {
 			cr4_set_bits(X86_CR4_PCIDE);
-			/*
-			 * These variables are used by the entry/exit
-			 * code to change PCIDs.
-			 */
-#ifdef CONFIG_KAISER
-			X86_CR3_PCID_KERN_VAR = X86_CR3_PCID_KERN_NOFLUSH;
-			X86_CR3_PCID_USER_VAR = X86_CR3_PCID_USER_NOFLUSH;
-#endif
 			/*
 			 * INVPCID has two "groups" of types:
 			 * 1/2: Invalidate an individual address
@@ -390,6 +369,7 @@ static void setup_pcid(struct cpuinfo_x86 *c)
 			clear_cpu_cap(c, X86_FEATURE_PCID);
 		}
 	}
+	kaiser_setup_pcid();
 }
 
 /*
diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index 91968328ccdf..7923190cd123 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -12,12 +12,26 @@
 #include <linux/ftrace.h>
 
 #include <asm/kaiser.h>
+#include <asm/tlbflush.h>	/* to verify its kaiser declarations */
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/desc.h>
+
 #ifdef CONFIG_KAISER
+__visible
+DEFINE_PER_CPU_USER_MAPPED(unsigned long, unsafe_stack_register_backup);
+
+/*
+ * These can have bit 63 set, so we can not just use a plain "or"
+ * instruction to get their value or'd into CR3.  It would take
+ * another register.  So, we use a memory reference to these instead.
+ *
+ * This is also handy because systems that do not support PCIDs
+ * just end up or'ing a 0 into their CR3, which does no harm.
+ */
+__aligned(PAGE_SIZE) unsigned long X86_CR3_PCID_KERN_VAR;
+DEFINE_PER_CPU(unsigned long, X86_CR3_PCID_USER_VAR);
 
-__visible DEFINE_PER_CPU_USER_MAPPED(unsigned long, unsafe_stack_register_backup);
 /*
  * At runtime, the only things we map are some things for CPU
  * hotplug, and stacks for new processes.  No two CPUs will ever
@@ -239,9 +253,6 @@ static void __init kaiser_init_all_pgds(void)
 	WARN_ON(__ret);							\
 } while (0)
 
-extern char __per_cpu_user_mapped_start[], __per_cpu_user_mapped_end[];
-extern unsigned long X86_CR3_PCID_KERN_VAR;
-extern unsigned long X86_CR3_PCID_USER_VAR;
 /*
  * If anything in here fails, we will likely die on one of the
  * first kernel->user transitions and init will die.  But, we
@@ -295,8 +306,6 @@ void __init kaiser_init(void)
 
 	kaiser_add_user_map_early(&X86_CR3_PCID_KERN_VAR, PAGE_SIZE,
 				  __PAGE_KERNEL);
-	kaiser_add_user_map_early(&X86_CR3_PCID_USER_VAR, PAGE_SIZE,
-				  __PAGE_KERNEL);
 }
 
 /* Add a mapping to the shadow mapping, and synchronize the mappings */
@@ -361,4 +370,33 @@ pgd_t kaiser_set_shadow_pgd(pgd_t *pgdp, pgd_t pgd)
 	}
 	return pgd;
 }
+
+void kaiser_setup_pcid(void)
+{
+	unsigned long kern_cr3 = 0;
+	unsigned long user_cr3 = KAISER_SHADOW_PGD_OFFSET;
+
+	if (this_cpu_has(X86_FEATURE_PCID)) {
+		kern_cr3 |= X86_CR3_PCID_KERN_NOFLUSH;
+		user_cr3 |= X86_CR3_PCID_USER_NOFLUSH;
+	}
+	/*
+	 * These variables are used by the entry/exit
+	 * code to change PCID and pgd and TLB flushing.
+	 */
+	X86_CR3_PCID_KERN_VAR = kern_cr3;
+	this_cpu_write(X86_CR3_PCID_USER_VAR, user_cr3);
+}
+
+/*
+ * Make a note that this cpu will need to flush USER tlb on return to user.
+ * Caller checks whether this_cpu_has(X86_FEATURE_PCID) before calling:
+ * if cpu does not, then the NOFLUSH bit will never have been set.
+ */
+void kaiser_flush_tlb_on_return_to_user(void)
+{
+	this_cpu_write(X86_CR3_PCID_USER_VAR,
+			X86_CR3_PCID_USER_FLUSH | KAISER_SHADOW_PGD_OFFSET);
+}
+EXPORT_SYMBOL(kaiser_flush_tlb_on_return_to_user);
 #endif /* CONFIG_KAISER */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 7176496112ff..9c9657f139cd 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -6,13 +6,14 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/cpu.h>
+#include <linux/debugfs.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
 #include <asm/cache.h>
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
-#include <linux/debugfs.h>
+#include <asm/kaiser.h>
 
 /*
  *	TLB flushing, formerly SMP-only
@@ -38,34 +39,23 @@ static void load_new_mm_cr3(pgd_t *pgdir)
 {
 	unsigned long new_mm_cr3 = __pa(pgdir);
 
-	/*
-	 * KAISER, plus PCIDs needs some extra work here.  But,
-	 * if either of features is not present, we need no
-	 * PCIDs here and just do a normal, full TLB flush with
-	 * the write_cr3()
-	 */
-	if (!IS_ENABLED(CONFIG_KAISER) ||
-	    !cpu_feature_enabled(X86_FEATURE_PCID))
-		goto out_set_cr3;
-	/*
-	 * We reuse the same PCID for different tasks, so we must
-	 * flush all the entires for the PCID out when we change
-	 * tasks.
-	 */
-	new_mm_cr3 = X86_CR3_PCID_KERN_FLUSH | __pa(pgdir);
-
-	/*
-	 * The flush from load_cr3() may leave old TLB entries
-	 * for userspace in place.  We must flush that context
-	 * separately.  We can theoretically delay doing this
-	 * until we actually load up the userspace CR3, but
-	 * that's a bit tricky.  We have to have the "need to
-	 * flush userspace PCID" bit per-cpu and check it in the
-	 * exit-to-userspace paths.
-	 */
-	invpcid_flush_single_context(X86_CR3_PCID_ASID_USER);
+#ifdef CONFIG_KAISER
+	if (this_cpu_has(X86_FEATURE_PCID)) {
+		/*
+		 * We reuse the same PCID for different tasks, so we must
+		 * flush all the entries for the PCID out when we change tasks.
+		 * Flush KERN below, flush USER when returning to userspace in
+		 * kaiser's SWITCH_USER_CR3 (_SWITCH_TO_USER_CR3) macro.
+		 *
+		 * invpcid_flush_single_context(X86_CR3_PCID_ASID_USER) could
+		 * do it here, but can only be used if X86_FEATURE_INVPCID is
+		 * available - and many machines support pcid without invpcid.
+		 */
+		new_mm_cr3 |= X86_CR3_PCID_KERN_FLUSH;
+		kaiser_flush_tlb_on_return_to_user();
+	}
+#endif /* CONFIG_KAISER */
 
-out_set_cr3:
 	/*
 	 * Caution: many callers of this function expect
 	 * that load_cr3() is serializing and orders TLB
-- 
2.16.2
