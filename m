Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709B0C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1038A20865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1038A20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeIISDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 14:03:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37962 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeIISDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 14:03:39 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyzXG-0007wE-7X; Sun, 09 Sep 2018 15:13:54 +0200
Date:   Sun, 9 Sep 2018 15:13:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86 fixes for 4.19
Message-ID: <alpine.DEB.2.21.1809091513220.1402@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A set of fixes for x86:

 - Prevent multiplication result truncation on 32bit. Introduced with the
   early timestamp reworrk.

 - Ensure microcode revision storage to be consistent under all
   circumstances

 - Prevent write tearing of PTEs

 - Prevent confusion of user and kernel reegisters when dumping fatal
   signals verbosely

 - Make an error return value in a failure path of the vector allocation
   negative. Returning EINVAL might the caller assume success and causes
   further wreckage.

 - A trivial kernel doc warning fix

Thanks,

	tglx

------------------>
Chuanhua Lei (1):
      x86/tsc: Prevent result truncation on 32bit

Filippo Sironi (1):
      x86/microcode: Update the new microcode revision unconditionally

Jann Horn (1):
      x86/process: Don't mix user/kernel regs in 64bit __show_regs()

Nadav Amit (1):
      x86/mm: Use WRITE_ONCE() when setting PTEs

Prarit Bhargava (1):
      x86/microcode: Make sure boot_cpu_data.microcode is up-to-date

Randy Dunlap (1):
      x86: Fix kernel-doc atomic.h warnings

Thomas Gleixner (1):
      x86/apic/vector: Make error return value negative


 arch/x86/include/asm/atomic.h         | 12 ++++++------
 arch/x86/include/asm/atomic64_32.h    |  8 ++++----
 arch/x86/include/asm/atomic64_64.h    | 12 ++++++------
 arch/x86/include/asm/kdebug.h         | 12 +++++++++++-
 arch/x86/include/asm/pgtable.h        |  2 +-
 arch/x86/include/asm/pgtable_64.h     | 20 ++++++++++----------
 arch/x86/kernel/apic/vector.c         |  2 +-
 arch/x86/kernel/cpu/microcode/amd.c   | 24 ++++++++++++++++--------
 arch/x86/kernel/cpu/microcode/intel.c | 17 ++++++++++++-----
 arch/x86/kernel/dumpstack.c           | 11 +++--------
 arch/x86/kernel/process_32.c          |  4 ++--
 arch/x86/kernel/process_64.c          | 12 ++++++++++--
 arch/x86/kernel/tsc.c                 |  2 +-
 arch/x86/mm/pgtable.c                 |  8 ++++----
 14 files changed, 87 insertions(+), 59 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index b143717b92b3..ce84388e540c 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -80,11 +80,11 @@ static __always_inline void arch_atomic_sub(int i, atomic_t *v)
  * true if the result is zero, or false for all
  * other cases.
  */
-#define arch_atomic_sub_and_test arch_atomic_sub_and_test
 static __always_inline bool arch_atomic_sub_and_test(int i, atomic_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "subl", v->counter, "er", i, "%0", e);
 }
+#define arch_atomic_sub_and_test arch_atomic_sub_and_test
 
 /**
  * arch_atomic_inc - increment atomic variable
@@ -92,12 +92,12 @@ static __always_inline bool arch_atomic_sub_and_test(int i, atomic_t *v)
  *
  * Atomically increments @v by 1.
  */
-#define arch_atomic_inc arch_atomic_inc
 static __always_inline void arch_atomic_inc(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "incl %0"
 		     : "+m" (v->counter));
 }
+#define arch_atomic_inc arch_atomic_inc
 
 /**
  * arch_atomic_dec - decrement atomic variable
@@ -105,12 +105,12 @@ static __always_inline void arch_atomic_inc(atomic_t *v)
  *
  * Atomically decrements @v by 1.
  */
-#define arch_atomic_dec arch_atomic_dec
 static __always_inline void arch_atomic_dec(atomic_t *v)
 {
 	asm volatile(LOCK_PREFIX "decl %0"
 		     : "+m" (v->counter));
 }
+#define arch_atomic_dec arch_atomic_dec
 
 /**
  * arch_atomic_dec_and_test - decrement and test
@@ -120,11 +120,11 @@ static __always_inline void arch_atomic_dec(atomic_t *v)
  * returns true if the result is 0, or false for all other
  * cases.
  */
-#define arch_atomic_dec_and_test arch_atomic_dec_and_test
 static __always_inline bool arch_atomic_dec_and_test(atomic_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "decl", v->counter, "%0", e);
 }
+#define arch_atomic_dec_and_test arch_atomic_dec_and_test
 
 /**
  * arch_atomic_inc_and_test - increment and test
@@ -134,11 +134,11 @@ static __always_inline bool arch_atomic_dec_and_test(atomic_t *v)
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-#define arch_atomic_inc_and_test arch_atomic_inc_and_test
 static __always_inline bool arch_atomic_inc_and_test(atomic_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "incl", v->counter, "%0", e);
 }
+#define arch_atomic_inc_and_test arch_atomic_inc_and_test
 
 /**
  * arch_atomic_add_negative - add and test if negative
@@ -149,11 +149,11 @@ static __always_inline bool arch_atomic_inc_and_test(atomic_t *v)
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-#define arch_atomic_add_negative arch_atomic_add_negative
 static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "addl", v->counter, "er", i, "%0", s);
 }
+#define arch_atomic_add_negative arch_atomic_add_negative
 
 /**
  * arch_atomic_add_return - add integer and return
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index ef959f02d070..6a5b0ec460da 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -205,12 +205,12 @@ static inline long long arch_atomic64_sub(long long i, atomic64_t *v)
  *
  * Atomically increments @v by 1.
  */
-#define arch_atomic64_inc arch_atomic64_inc
 static inline void arch_atomic64_inc(atomic64_t *v)
 {
 	__alternative_atomic64(inc, inc_return, /* no output */,
 			       "S" (v) : "memory", "eax", "ecx", "edx");
 }
+#define arch_atomic64_inc arch_atomic64_inc
 
 /**
  * arch_atomic64_dec - decrement atomic64 variable
@@ -218,12 +218,12 @@ static inline void arch_atomic64_inc(atomic64_t *v)
  *
  * Atomically decrements @v by 1.
  */
-#define arch_atomic64_dec arch_atomic64_dec
 static inline void arch_atomic64_dec(atomic64_t *v)
 {
 	__alternative_atomic64(dec, dec_return, /* no output */,
 			       "S" (v) : "memory", "eax", "ecx", "edx");
 }
+#define arch_atomic64_dec arch_atomic64_dec
 
 /**
  * arch_atomic64_add_unless - add unless the number is a given value
@@ -245,7 +245,6 @@ static inline int arch_atomic64_add_unless(atomic64_t *v, long long a,
 	return (int)a;
 }
 
-#define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
 static inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 {
 	int r;
@@ -253,8 +252,8 @@ static inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 			     "S" (v) : "ecx", "edx", "memory");
 	return r;
 }
+#define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
 
-#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 static inline long long arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	long long r;
@@ -262,6 +261,7 @@ static inline long long arch_atomic64_dec_if_positive(atomic64_t *v)
 			     "S" (v) : "ecx", "memory");
 	return r;
 }
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 
 #undef alternative_atomic64
 #undef __alternative_atomic64
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 4343d9b4f30e..5f851d92eecd 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -71,11 +71,11 @@ static inline void arch_atomic64_sub(long i, atomic64_t *v)
  * true if the result is zero, or false for all
  * other cases.
  */
-#define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
 static inline bool arch_atomic64_sub_and_test(long i, atomic64_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "subq", v->counter, "er", i, "%0", e);
 }
+#define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
 
 /**
  * arch_atomic64_inc - increment atomic64 variable
@@ -83,13 +83,13 @@ static inline bool arch_atomic64_sub_and_test(long i, atomic64_t *v)
  *
  * Atomically increments @v by 1.
  */
-#define arch_atomic64_inc arch_atomic64_inc
 static __always_inline void arch_atomic64_inc(atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "incq %0"
 		     : "=m" (v->counter)
 		     : "m" (v->counter));
 }
+#define arch_atomic64_inc arch_atomic64_inc
 
 /**
  * arch_atomic64_dec - decrement atomic64 variable
@@ -97,13 +97,13 @@ static __always_inline void arch_atomic64_inc(atomic64_t *v)
  *
  * Atomically decrements @v by 1.
  */
-#define arch_atomic64_dec arch_atomic64_dec
 static __always_inline void arch_atomic64_dec(atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "decq %0"
 		     : "=m" (v->counter)
 		     : "m" (v->counter));
 }
+#define arch_atomic64_dec arch_atomic64_dec
 
 /**
  * arch_atomic64_dec_and_test - decrement and test
@@ -113,11 +113,11 @@ static __always_inline void arch_atomic64_dec(atomic64_t *v)
  * returns true if the result is 0, or false for all other
  * cases.
  */
-#define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
 static inline bool arch_atomic64_dec_and_test(atomic64_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "decq", v->counter, "%0", e);
 }
+#define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
 
 /**
  * arch_atomic64_inc_and_test - increment and test
@@ -127,11 +127,11 @@ static inline bool arch_atomic64_dec_and_test(atomic64_t *v)
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-#define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
 static inline bool arch_atomic64_inc_and_test(atomic64_t *v)
 {
 	GEN_UNARY_RMWcc(LOCK_PREFIX "incq", v->counter, "%0", e);
 }
+#define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
 
 /**
  * arch_atomic64_add_negative - add and test if negative
@@ -142,11 +142,11 @@ static inline bool arch_atomic64_inc_and_test(atomic64_t *v)
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-#define arch_atomic64_add_negative arch_atomic64_add_negative
 static inline bool arch_atomic64_add_negative(long i, atomic64_t *v)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX "addq", v->counter, "er", i, "%0", s);
 }
+#define arch_atomic64_add_negative arch_atomic64_add_negative
 
 /**
  * arch_atomic64_add_return - add and return
diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
index 395c9631e000..75f1e35e7c15 100644
--- a/arch/x86/include/asm/kdebug.h
+++ b/arch/x86/include/asm/kdebug.h
@@ -22,10 +22,20 @@ enum die_val {
 	DIE_NMIUNKNOWN,
 };
 
+enum show_regs_mode {
+	SHOW_REGS_SHORT,
+	/*
+	 * For when userspace crashed, but we don't think it's our fault, and
+	 * therefore don't print kernel registers.
+	 */
+	SHOW_REGS_USER,
+	SHOW_REGS_ALL
+};
+
 extern void die(const char *, struct pt_regs *,long);
 extern int __must_check __die(const char *, struct pt_regs *, long);
 extern void show_stack_regs(struct pt_regs *regs);
-extern void __show_regs(struct pt_regs *regs, int all);
+extern void __show_regs(struct pt_regs *regs, enum show_regs_mode);
 extern void show_iret_regs(struct pt_regs *regs);
 extern unsigned long oops_begin(void);
 extern void oops_end(unsigned long, struct pt_regs *, int signr);
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e4ffa565a69f..690c0307afed 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1195,7 +1195,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 		return xchg(pmdp, pmd);
 	} else {
 		pmd_t old = *pmdp;
-		*pmdp = pmd;
+		WRITE_ONCE(*pmdp, pmd);
 		return old;
 	}
 }
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index f773d5e6c8cc..ce2b59047cb8 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -55,15 +55,15 @@ struct mm_struct;
 void set_pte_vaddr_p4d(p4d_t *p4d_page, unsigned long vaddr, pte_t new_pte);
 void set_pte_vaddr_pud(pud_t *pud_page, unsigned long vaddr, pte_t new_pte);
 
-static inline void native_pte_clear(struct mm_struct *mm, unsigned long addr,
-				    pte_t *ptep)
+static inline void native_set_pte(pte_t *ptep, pte_t pte)
 {
-	*ptep = native_make_pte(0);
+	WRITE_ONCE(*ptep, pte);
 }
 
-static inline void native_set_pte(pte_t *ptep, pte_t pte)
+static inline void native_pte_clear(struct mm_struct *mm, unsigned long addr,
+				    pte_t *ptep)
 {
-	*ptep = pte;
+	native_set_pte(ptep, native_make_pte(0));
 }
 
 static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
@@ -73,7 +73,7 @@ static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
 
 static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
-	*pmdp = pmd;
+	WRITE_ONCE(*pmdp, pmd);
 }
 
 static inline void native_pmd_clear(pmd_t *pmd)
@@ -109,7 +109,7 @@ static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
 
 static inline void native_set_pud(pud_t *pudp, pud_t pud)
 {
-	*pudp = pud;
+	WRITE_ONCE(*pudp, pud);
 }
 
 static inline void native_pud_clear(pud_t *pud)
@@ -137,13 +137,13 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 	pgd_t pgd;
 
 	if (pgtable_l5_enabled() || !IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION)) {
-		*p4dp = p4d;
+		WRITE_ONCE(*p4dp, p4d);
 		return;
 	}
 
 	pgd = native_make_pgd(native_p4d_val(p4d));
 	pgd = pti_set_user_pgtbl((pgd_t *)p4dp, pgd);
-	*p4dp = native_make_p4d(native_pgd_val(pgd));
+	WRITE_ONCE(*p4dp, native_make_p4d(native_pgd_val(pgd)));
 }
 
 static inline void native_p4d_clear(p4d_t *p4d)
@@ -153,7 +153,7 @@ static inline void native_p4d_clear(p4d_t *p4d)
 
 static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	*pgdp = pti_set_user_pgtbl(pgdp, pgd);
+	WRITE_ONCE(*pgdp, pti_set_user_pgtbl(pgdp, pgd));
 }
 
 static inline void native_pgd_clear(pgd_t *pgd)
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 9f148e3d45b4..7654febd5102 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -413,7 +413,7 @@ static int activate_managed(struct irq_data *irqd)
 	if (WARN_ON_ONCE(cpumask_empty(vector_searchmask))) {
 		/* Something in the core code broke! Survive gracefully */
 		pr_err("Managed startup for irq %u, but no CPU\n", irqd->irq);
-		return EINVAL;
+		return -EINVAL;
 	}
 
 	ret = assign_managed_vector(irqd, vector_searchmask);
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 0624957aa068..07b5fc00b188 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -504,6 +504,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	struct microcode_amd *mc_amd;
 	struct ucode_cpu_info *uci;
 	struct ucode_patch *p;
+	enum ucode_state ret;
 	u32 rev, dummy;
 
 	BUG_ON(raw_smp_processor_id() != cpu);
@@ -521,9 +522,8 @@ static enum ucode_state apply_microcode_amd(int cpu)
 
 	/* need to apply patch? */
 	if (rev >= mc_amd->hdr.patch_id) {
-		c->microcode = rev;
-		uci->cpu_sig.rev = rev;
-		return UCODE_OK;
+		ret = UCODE_OK;
+		goto out;
 	}
 
 	if (__apply_microcode_amd(mc_amd)) {
@@ -531,13 +531,21 @@ static enum ucode_state apply_microcode_amd(int cpu)
 			cpu, mc_amd->hdr.patch_id);
 		return UCODE_ERROR;
 	}
-	pr_info("CPU%d: new patch_level=0x%08x\n", cpu,
-		mc_amd->hdr.patch_id);
 
-	uci->cpu_sig.rev = mc_amd->hdr.patch_id;
-	c->microcode = mc_amd->hdr.patch_id;
+	rev = mc_amd->hdr.patch_id;
+	ret = UCODE_UPDATED;
+
+	pr_info("CPU%d: new patch_level=0x%08x\n", cpu, rev);
 
-	return UCODE_UPDATED;
+out:
+	uci->cpu_sig.rev = rev;
+	c->microcode	 = rev;
+
+	/* Update boot_cpu_data's revision too, if we're on the BSP: */
+	if (c->cpu_index == boot_cpu_data.cpu_index)
+		boot_cpu_data.microcode = rev;
+
+	return ret;
 }
 
 static int install_equiv_cpu_table(const u8 *buf)
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 97ccf4c3b45b..16936a24795c 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -795,6 +795,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct microcode_intel *mc;
+	enum ucode_state ret;
 	static int prev_rev;
 	u32 rev;
 
@@ -817,9 +818,8 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	 */
 	rev = intel_get_microcode_revision();
 	if (rev >= mc->hdr.rev) {
-		uci->cpu_sig.rev = rev;
-		c->microcode = rev;
-		return UCODE_OK;
+		ret = UCODE_OK;
+		goto out;
 	}
 
 	/*
@@ -848,10 +848,17 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		prev_rev = rev;
 	}
 
+	ret = UCODE_UPDATED;
+
+out:
 	uci->cpu_sig.rev = rev;
-	c->microcode = rev;
+	c->microcode	 = rev;
+
+	/* Update boot_cpu_data's revision too, if we're on the BSP: */
+	if (c->cpu_index == boot_cpu_data.cpu_index)
+		boot_cpu_data.microcode = rev;
 
-	return UCODE_UPDATED;
+	return ret;
 }
 
 static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index f56895106ccf..2b5886401e5f 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -146,7 +146,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 	 * they can be printed in the right context.
 	 */
 	if (!partial && on_stack(info, regs, sizeof(*regs))) {
-		__show_regs(regs, 0);
+		__show_regs(regs, SHOW_REGS_SHORT);
 
 	} else if (partial && on_stack(info, (void *)regs + IRET_FRAME_OFFSET,
 				       IRET_FRAME_SIZE)) {
@@ -344,7 +344,7 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	oops_exit();
 
 	/* Executive summary in case the oops scrolled away */
-	__show_regs(&exec_summary_regs, true);
+	__show_regs(&exec_summary_regs, SHOW_REGS_ALL);
 
 	if (!signr)
 		return;
@@ -407,14 +407,9 @@ void die(const char *str, struct pt_regs *regs, long err)
 
 void show_regs(struct pt_regs *regs)
 {
-	bool all = true;
-
 	show_regs_print_info(KERN_DEFAULT);
 
-	if (IS_ENABLED(CONFIG_X86_32))
-		all = !user_mode(regs);
-
-	__show_regs(regs, all);
+	__show_regs(regs, user_mode(regs) ? SHOW_REGS_USER : SHOW_REGS_ALL);
 
 	/*
 	 * When in-kernel, we also print out the stack at the time of the fault..
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 2924fd447e61..5046a3c9dec2 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -59,7 +59,7 @@
 #include <asm/intel_rdt_sched.h>
 #include <asm/proto.h>
 
-void __show_regs(struct pt_regs *regs, int all)
+void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
 	unsigned long d0, d1, d2, d3, d6, d7;
@@ -85,7 +85,7 @@ void __show_regs(struct pt_regs *regs, int all)
 	printk(KERN_DEFAULT "DS: %04x ES: %04x FS: %04x GS: %04x SS: %04x EFLAGS: %08lx\n",
 	       (u16)regs->ds, (u16)regs->es, (u16)regs->fs, gs, ss, regs->flags);
 
-	if (!all)
+	if (mode != SHOW_REGS_ALL)
 		return;
 
 	cr0 = read_cr0();
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index a451bc374b9b..ea5ea850348d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -62,7 +62,7 @@
 __visible DEFINE_PER_CPU(unsigned long, rsp_scratch);
 
 /* Prints also some state that isn't saved in the pt_regs */
-void __show_regs(struct pt_regs *regs, int all)
+void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L, fs, gs, shadowgs;
 	unsigned long d0, d1, d2, d3, d6, d7;
@@ -87,9 +87,17 @@ void __show_regs(struct pt_regs *regs, int all)
 	printk(KERN_DEFAULT "R13: %016lx R14: %016lx R15: %016lx\n",
 	       regs->r13, regs->r14, regs->r15);
 
-	if (!all)
+	if (mode == SHOW_REGS_SHORT)
 		return;
 
+	if (mode == SHOW_REGS_USER) {
+		rdmsrl(MSR_FS_BASE, fs);
+		rdmsrl(MSR_KERNEL_GS_BASE, shadowgs);
+		printk(KERN_DEFAULT "FS:  %016lx GS:  %016lx\n",
+		       fs, shadowgs);
+		return;
+	}
+
 	asm("movl %%ds,%0" : "=r" (ds));
 	asm("movl %%cs,%0" : "=r" (cs));
 	asm("movl %%es,%0" : "=r" (es));
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 1463468ba9a0..6490f618e096 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1415,7 +1415,7 @@ static bool __init determine_cpu_tsc_frequencies(bool early)
 
 static unsigned long __init get_loops_per_jiffy(void)
 {
-	unsigned long lpj = tsc_khz * KHZ;
+	u64 lpj = (u64)tsc_khz * KHZ;
 
 	do_div(lpj, HZ);
 	return lpj;
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index e848a4811785..ae394552fb94 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -269,7 +269,7 @@ static void mop_up_one_pmd(struct mm_struct *mm, pgd_t *pgdp)
 	if (pgd_val(pgd) != 0) {
 		pmd_t *pmd = (pmd_t *)pgd_page_vaddr(pgd);
 
-		*pgdp = native_make_pgd(0);
+		pgd_clear(pgdp);
 
 		paravirt_release_pmd(pgd_val(pgd) >> PAGE_SHIFT);
 		pmd_free(mm, pmd);
@@ -494,7 +494,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 	int changed = !pte_same(*ptep, entry);
 
 	if (changed && dirty)
-		*ptep = entry;
+		set_pte(ptep, entry);
 
 	return changed;
 }
@@ -509,7 +509,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
 	if (changed && dirty) {
-		*pmdp = entry;
+		set_pmd(pmdp, entry);
 		/*
 		 * We had a write-protection fault here and changed the pmd
 		 * to to more permissive. No need to flush the TLB for that,
@@ -529,7 +529,7 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
 
 	if (changed && dirty) {
-		*pudp = entry;
+		set_pud(pudp, entry);
 		/*
 		 * We had a write-protection fault here and changed the pud
 		 * to to more permissive. No need to flush the TLB for that,
