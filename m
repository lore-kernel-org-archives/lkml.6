Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeETIVV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 04:21:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58301 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeETIVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 04:21:10 -0400
Date: Sun, 20 May 2018 10:21:07 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] core fixes for 4.17
Message-ID: <alpine.DEB.2.21.1805201014140.1599@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

The pull request provides:

 - Unbreak the BPF compilation which got broken by the unconditional
   requirement of asm-goto, which is not supported by clang.

 - Prevent probing on exception masking instructions in uprobes and kprobes
   to avoid the issues of the delayed exceptions instead of having an ugly
   workaround.

 - Prevent a double free_page() in the error path of do_kexec_load()

 - A set of objtool updates addressing various issues mostly related to
   switch tables and the noreturn detection for recursive sibling calls

 - Header sync for tools.


Thanks,

	tglx

------------------>
Alexei Starovoitov (1):
      x86/cpufeature: Guard asm_volatile_goto usage for BPF compilation

Ingo Molnar (1):
      objtool, kprobes/x86: Sync the latest <asm/insn.h> header with tools/objtool/arch/x86/include/asm/insn.h

Josh Poimboeuf (5):
      objtool: Fix "noreturn" detection for recursive sibling calls
      objtool: Support GCC 8's cold subfunctions
      objtool: Support GCC 8 switch tables
      objtool: Detect RIP-relative switch table references
      objtool: Detect RIP-relative switch table references, part 2

Masami Hiramatsu (2):
      kprobes/x86: Prohibit probing on exception masking instructions
      uprobes/x86: Prohibit probing on MOV SS instruction

Tetsuo Handa (1):
      x86/kexec: Avoid double free_page() upon do_kexec_load() failure


 arch/x86/include/asm/cpufeature.h         |  15 +++
 arch/x86/include/asm/insn.h               |  18 ++++
 arch/x86/kernel/kprobes/core.c            |   4 +
 arch/x86/kernel/machine_kexec_32.c        |   6 +-
 arch/x86/kernel/machine_kexec_64.c        |   5 +-
 arch/x86/kernel/uprobes.c                 |   4 +
 samples/bpf/Makefile                      |   2 +-
 tools/objtool/arch/x86/include/asm/insn.h |  18 ++++
 tools/objtool/check.c                     | 167 +++++++++++++++++-------------
 tools/objtool/elf.c                       |  42 +++++++-
 tools/objtool/elf.h                       |   2 +
 11 files changed, 206 insertions(+), 77 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index b27da9602a6d..aced6c9290d6 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -140,6 +140,20 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 
 #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
 
+#if defined(__clang__) && !defined(CC_HAVE_ASM_GOTO)
+
+/*
+ * Workaround for the sake of BPF compilation which utilizes kernel
+ * headers, but clang does not support ASM GOTO and fails the build.
+ */
+#ifndef __BPF_TRACING__
+#warning "Compiler lacks ASM_GOTO support. Add -D __BPF_TRACING__ to your compiler arguments"
+#endif
+
+#define static_cpu_has(bit)            boot_cpu_has(bit)
+
+#else
+
 /*
  * Static testing of CPU features.  Used the same as boot_cpu_has().
  * These will statically patch the target code for additional
@@ -195,6 +209,7 @@ static __always_inline __pure bool _static_cpu_has(u16 bit)
 		boot_cpu_has(bit) :				\
 		_static_cpu_has(bit)				\
 )
+#endif
 
 #define cpu_has_bug(c, bit)		cpu_has(c, (bit))
 #define set_cpu_bug(c, bit)		set_cpu_cap(c, (bit))
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index b3e32b010ab1..c2c01f84df75 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -208,4 +208,22 @@ static inline int insn_offset_immediate(struct insn *insn)
 	return insn_offset_displacement(insn) + insn->displacement.nbytes;
 }
 
+#define POP_SS_OPCODE 0x1f
+#define MOV_SREG_OPCODE 0x8e
+
+/*
+ * Intel SDM Vol.3A 6.8.3 states;
+ * "Any single-step trap that would be delivered following the MOV to SS
+ * instruction or POP to SS instruction (because EFLAGS.TF is 1) is
+ * suppressed."
+ * This function returns true if @insn is MOV SS or POP SS. On these
+ * instructions, single stepping is suppressed.
+ */
+static inline int insn_masking_exception(struct insn *insn)
+{
+	return insn->opcode.bytes[0] == POP_SS_OPCODE ||
+		(insn->opcode.bytes[0] == MOV_SREG_OPCODE &&
+		 X86_MODRM_REG(insn->modrm.bytes[0]) == 2);
+}
+
 #endif /* _ASM_X86_INSN_H */
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 0715f827607c..6f4d42377fe5 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -370,6 +370,10 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 	if (insn->opcode.bytes[0] == BREAKPOINT_INSTRUCTION)
 		return 0;
 
+	/* We should not singlestep on the exception masking instructions */
+	if (insn_masking_exception(insn))
+		return 0;
+
 #ifdef CONFIG_X86_64
 	/* Only x86_64 has RIP relative instructions */
 	if (insn_rip_relative(insn)) {
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 60cdec6628b0..d1ab07ec8c9a 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -57,12 +57,17 @@ static void load_segments(void)
 static void machine_kexec_free_page_tables(struct kimage *image)
 {
 	free_page((unsigned long)image->arch.pgd);
+	image->arch.pgd = NULL;
 #ifdef CONFIG_X86_PAE
 	free_page((unsigned long)image->arch.pmd0);
+	image->arch.pmd0 = NULL;
 	free_page((unsigned long)image->arch.pmd1);
+	image->arch.pmd1 = NULL;
 #endif
 	free_page((unsigned long)image->arch.pte0);
+	image->arch.pte0 = NULL;
 	free_page((unsigned long)image->arch.pte1);
+	image->arch.pte1 = NULL;
 }
 
 static int machine_kexec_alloc_page_tables(struct kimage *image)
@@ -79,7 +84,6 @@ static int machine_kexec_alloc_page_tables(struct kimage *image)
 	    !image->arch.pmd0 || !image->arch.pmd1 ||
 #endif
 	    !image->arch.pte0 || !image->arch.pte1) {
-		machine_kexec_free_page_tables(image);
 		return -ENOMEM;
 	}
 	return 0;
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a5e55d832d0a..6010449ca6d2 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -39,9 +39,13 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 static void free_transition_pgtable(struct kimage *image)
 {
 	free_page((unsigned long)image->arch.p4d);
+	image->arch.p4d = NULL;
 	free_page((unsigned long)image->arch.pud);
+	image->arch.pud = NULL;
 	free_page((unsigned long)image->arch.pmd);
+	image->arch.pmd = NULL;
 	free_page((unsigned long)image->arch.pte);
+	image->arch.pte = NULL;
 }
 
 static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
@@ -91,7 +95,6 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL_EXEC_NOENC));
 	return 0;
 err:
-	free_transition_pgtable(image);
 	return result;
 }
 
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 85c7ef23d99f..c84bb5396958 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -299,6 +299,10 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
 	if (is_prefix_bad(insn))
 		return -ENOTSUPP;
 
+	/* We should not singlestep on the exception masking instructions */
+	if (insn_masking_exception(insn))
+		return -ENOTSUPP;
+
 	if (x86_64)
 		good_insns = good_insns_64;
 	else
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4d6a6edd4bf6..092947676143 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -255,7 +255,7 @@ $(obj)/tracex5_kern.o: $(obj)/syscall_nrs.h
 $(obj)/%.o: $(src)/%.c
 	$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) -I$(obj) \
 		-I$(srctree)/tools/testing/selftests/bpf/ \
-		-D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
+		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(ARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
 		-Wno-address-of-packed-member -Wno-tautological-compare \
diff --git a/tools/objtool/arch/x86/include/asm/insn.h b/tools/objtool/arch/x86/include/asm/insn.h
index b3e32b010ab1..c2c01f84df75 100644
--- a/tools/objtool/arch/x86/include/asm/insn.h
+++ b/tools/objtool/arch/x86/include/asm/insn.h
@@ -208,4 +208,22 @@ static inline int insn_offset_immediate(struct insn *insn)
 	return insn_offset_displacement(insn) + insn->displacement.nbytes;
 }
 
+#define POP_SS_OPCODE 0x1f
+#define MOV_SREG_OPCODE 0x8e
+
+/*
+ * Intel SDM Vol.3A 6.8.3 states;
+ * "Any single-step trap that would be delivered following the MOV to SS
+ * instruction or POP to SS instruction (because EFLAGS.TF is 1) is
+ * suppressed."
+ * This function returns true if @insn is MOV SS or POP SS. On these
+ * instructions, single stepping is suppressed.
+ */
+static inline int insn_masking_exception(struct insn *insn)
+{
+	return insn->opcode.bytes[0] == POP_SS_OPCODE ||
+		(insn->opcode.bytes[0] == MOV_SREG_OPCODE &&
+		 X86_MODRM_REG(insn->modrm.bytes[0]) == 2);
+}
+
 #endif /* _ASM_X86_INSN_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5409f6f6c48d..3a31b238f885 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -59,6 +59,31 @@ static struct instruction *next_insn_same_sec(struct objtool_file *file,
 	return next;
 }
 
+static struct instruction *next_insn_same_func(struct objtool_file *file,
+					       struct instruction *insn)
+{
+	struct instruction *next = list_next_entry(insn, list);
+	struct symbol *func = insn->func;
+
+	if (!func)
+		return NULL;
+
+	if (&next->list != &file->insn_list && next->func == func)
+		return next;
+
+	/* Check if we're already in the subfunction: */
+	if (func == func->cfunc)
+		return NULL;
+
+	/* Move to the subfunction: */
+	return find_insn(file, func->cfunc->sec, func->cfunc->offset);
+}
+
+#define func_for_each_insn_all(file, func, insn)			\
+	for (insn = find_insn(file, func->sec, func->offset);		\
+	     insn;							\
+	     insn = next_insn_same_func(file, insn))
+
 #define func_for_each_insn(file, func, insn)				\
 	for (insn = find_insn(file, func->sec, func->offset);		\
 	     insn && &insn->list != &file->insn_list &&			\
@@ -149,10 +174,14 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 			if (!strcmp(func->name, global_noreturns[i]))
 				return 1;
 
-	if (!func->sec)
+	if (!func->len)
 		return 0;
 
-	func_for_each_insn(file, func, insn) {
+	insn = find_insn(file, func->sec, func->offset);
+	if (!insn->func)
+		return 0;
+
+	func_for_each_insn_all(file, func, insn) {
 		empty = false;
 
 		if (insn->type == INSN_RETURN)
@@ -167,35 +196,28 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 	 * case, the function's dead-end status depends on whether the target
 	 * of the sibling call returns.
 	 */
-	func_for_each_insn(file, func, insn) {
-		if (insn->sec != func->sec ||
-		    insn->offset >= func->offset + func->len)
-			break;
-
+	func_for_each_insn_all(file, func, insn) {
 		if (insn->type == INSN_JUMP_UNCONDITIONAL) {
 			struct instruction *dest = insn->jump_dest;
-			struct symbol *dest_func;
 
 			if (!dest)
 				/* sibling call to another file */
 				return 0;
 
-			if (dest->sec != func->sec ||
-			    dest->offset < func->offset ||
-			    dest->offset >= func->offset + func->len) {
-				/* local sibling call */
-				dest_func = find_symbol_by_offset(dest->sec,
-								  dest->offset);
-				if (!dest_func)
-					continue;
+			if (dest->func && dest->func->pfunc != insn->func->pfunc) {
 
+				/* local sibling call */
 				if (recursion == 5) {
-					WARN_FUNC("infinite recursion (objtool bug!)",
-						  dest->sec, dest->offset);
-					return -1;
+					/*
+					 * Infinite recursion: two functions
+					 * have sibling calls to each other.
+					 * This is a very rare case.  It means
+					 * they aren't dead ends.
+					 */
+					return 0;
 				}
 
-				return __dead_end_function(file, dest_func,
+				return __dead_end_function(file, dest->func,
 							   recursion + 1);
 			}
 		}
@@ -422,7 +444,7 @@ static void add_ignores(struct objtool_file *file)
 			if (!ignore_func(file, func))
 				continue;
 
-			func_for_each_insn(file, func, insn)
+			func_for_each_insn_all(file, func, insn)
 				insn->ignore = true;
 		}
 	}
@@ -782,30 +804,35 @@ static int add_special_section_alts(struct objtool_file *file)
 	return ret;
 }
 
-static int add_switch_table(struct objtool_file *file, struct symbol *func,
-			    struct instruction *insn, struct rela *table,
-			    struct rela *next_table)
+static int add_switch_table(struct objtool_file *file, struct instruction *insn,
+			    struct rela *table, struct rela *next_table)
 {
 	struct rela *rela = table;
 	struct instruction *alt_insn;
 	struct alternative *alt;
+	struct symbol *pfunc = insn->func->pfunc;
+	unsigned int prev_offset = 0;
 
 	list_for_each_entry_from(rela, &file->rodata->rela->rela_list, list) {
 		if (rela == next_table)
 			break;
 
-		if (rela->sym->sec != insn->sec ||
-		    rela->addend <= func->offset ||
-		    rela->addend >= func->offset + func->len)
+		/* Make sure the switch table entries are consecutive: */
+		if (prev_offset && rela->offset != prev_offset + 8)
 			break;
 
-		alt_insn = find_insn(file, insn->sec, rela->addend);
-		if (!alt_insn) {
-			WARN("%s: can't find instruction at %s+0x%x",
-			     file->rodata->rela->name, insn->sec->name,
-			     rela->addend);
-			return -1;
-		}
+		/* Detect function pointers from contiguous objects: */
+		if (rela->sym->sec == pfunc->sec &&
+		    rela->addend == pfunc->offset)
+			break;
+
+		alt_insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!alt_insn)
+			break;
+
+		/* Make sure the jmp dest is in the function or subfunction: */
+		if (alt_insn->func->pfunc != pfunc)
+			break;
 
 		alt = malloc(sizeof(*alt));
 		if (!alt) {
@@ -815,6 +842,13 @@ static int add_switch_table(struct objtool_file *file, struct symbol *func,
 
 		alt->insn = alt_insn;
 		list_add_tail(&alt->list, &insn->alts);
+		prev_offset = rela->offset;
+	}
+
+	if (!prev_offset) {
+		WARN_FUNC("can't find switch jump table",
+			  insn->sec, insn->offset);
+		return -1;
 	}
 
 	return 0;
@@ -869,40 +903,21 @@ static struct rela *find_switch_table(struct objtool_file *file,
 {
 	struct rela *text_rela, *rodata_rela;
 	struct instruction *orig_insn = insn;
+	unsigned long table_offset;
 
-	text_rela = find_rela_by_dest_range(insn->sec, insn->offset, insn->len);
-	if (text_rela && text_rela->sym == file->rodata->sym) {
-		/* case 1 */
-		rodata_rela = find_rela_by_dest(file->rodata,
-						text_rela->addend);
-		if (rodata_rela)
-			return rodata_rela;
-
-		/* case 2 */
-		rodata_rela = find_rela_by_dest(file->rodata,
-						text_rela->addend + 4);
-		if (!rodata_rela)
-			return NULL;
-
-		file->ignore_unreachables = true;
-		return rodata_rela;
-	}
-
-	/* case 3 */
 	/*
 	 * Backward search using the @first_jump_src links, these help avoid
 	 * much of the 'in between' code. Which avoids us getting confused by
 	 * it.
 	 */
-	for (insn = list_prev_entry(insn, list);
-
+	for (;
 	     &insn->list != &file->insn_list &&
 	     insn->sec == func->sec &&
 	     insn->offset >= func->offset;
 
 	     insn = insn->first_jump_src ?: list_prev_entry(insn, list)) {
 
-		if (insn->type == INSN_JUMP_DYNAMIC)
+		if (insn != orig_insn && insn->type == INSN_JUMP_DYNAMIC)
 			break;
 
 		/* allow small jumps within the range */
@@ -918,18 +933,29 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		if (!text_rela || text_rela->sym != file->rodata->sym)
 			continue;
 
+		table_offset = text_rela->addend;
+		if (text_rela->type == R_X86_64_PC32)
+			table_offset += 4;
+
 		/*
 		 * Make sure the .rodata address isn't associated with a
 		 * symbol.  gcc jump tables are anonymous data.
 		 */
-		if (find_symbol_containing(file->rodata, text_rela->addend))
+		if (find_symbol_containing(file->rodata, table_offset))
 			continue;
 
-		rodata_rela = find_rela_by_dest(file->rodata, text_rela->addend);
-		if (!rodata_rela)
-			continue;
+		rodata_rela = find_rela_by_dest(file->rodata, table_offset);
+		if (rodata_rela) {
+			/*
+			 * Use of RIP-relative switch jumps is quite rare, and
+			 * indicates a rare GCC quirk/bug which can leave dead
+			 * code behind.
+			 */
+			if (text_rela->type == R_X86_64_PC32)
+				file->ignore_unreachables = true;
 
-		return rodata_rela;
+			return rodata_rela;
+		}
 	}
 
 	return NULL;
@@ -943,7 +969,7 @@ static int add_func_switch_tables(struct objtool_file *file,
 	struct rela *rela, *prev_rela = NULL;
 	int ret;
 
-	func_for_each_insn(file, func, insn) {
+	func_for_each_insn_all(file, func, insn) {
 		if (!last)
 			last = insn;
 
@@ -974,8 +1000,7 @@ static int add_func_switch_tables(struct objtool_file *file,
 		 * the beginning of another switch table in the same function.
 		 */
 		if (prev_jump) {
-			ret = add_switch_table(file, func, prev_jump, prev_rela,
-					       rela);
+			ret = add_switch_table(file, prev_jump, prev_rela, rela);
 			if (ret)
 				return ret;
 		}
@@ -985,7 +1010,7 @@ static int add_func_switch_tables(struct objtool_file *file,
 	}
 
 	if (prev_jump) {
-		ret = add_switch_table(file, func, prev_jump, prev_rela, NULL);
+		ret = add_switch_table(file, prev_jump, prev_rela, NULL);
 		if (ret)
 			return ret;
 	}
@@ -1749,15 +1774,13 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 	while (1) {
 		next_insn = next_insn_same_sec(file, insn);
 
-
-		if (file->c_file && func && insn->func && func != insn->func) {
+		if (file->c_file && func && insn->func && func != insn->func->pfunc) {
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn->func->name);
 			return 1;
 		}
 
-		if (insn->func)
-			func = insn->func;
+		func = insn->func ? insn->func->pfunc : NULL;
 
 		if (func && insn->ignore) {
 			WARN_FUNC("BUG: why am I validating an ignored function?",
@@ -1778,7 +1801,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 
 				i = insn;
 				save_insn = NULL;
-				func_for_each_insn_continue_reverse(file, func, i) {
+				func_for_each_insn_continue_reverse(file, insn->func, i) {
 					if (i->save) {
 						save_insn = i;
 						break;
@@ -1865,7 +1888,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 		case INSN_JUMP_UNCONDITIONAL:
 			if (insn->jump_dest &&
 			    (!func || !insn->jump_dest->func ||
-			     func == insn->jump_dest->func)) {
+			     insn->jump_dest->func->pfunc == func)) {
 				ret = validate_branch(file, insn->jump_dest,
 						      state);
 				if (ret)
@@ -2060,7 +2083,7 @@ static int validate_functions(struct objtool_file *file)
 
 	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC)
+			if (func->type != STT_FUNC || func->pfunc != func)
 				continue;
 
 			insn = find_insn(file, sec, func->offset);
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c1c338661699..4e60e105583e 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -79,6 +79,19 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
 	return NULL;
 }
 
+struct symbol *find_symbol_by_name(struct elf *elf, const char *name)
+{
+	struct section *sec;
+	struct symbol *sym;
+
+	list_for_each_entry(sec, &elf->sections, list)
+		list_for_each_entry(sym, &sec->symbol_list, list)
+			if (!strcmp(sym->name, name))
+				return sym;
+
+	return NULL;
+}
+
 struct symbol *find_symbol_containing(struct section *sec, unsigned long offset)
 {
 	struct symbol *sym;
@@ -203,10 +216,11 @@ static int read_sections(struct elf *elf)
 
 static int read_symbols(struct elf *elf)
 {
-	struct section *symtab;
-	struct symbol *sym;
+	struct section *symtab, *sec;
+	struct symbol *sym, *pfunc;
 	struct list_head *entry, *tmp;
 	int symbols_nr, i;
+	char *coldstr;
 
 	symtab = find_section_by_name(elf, ".symtab");
 	if (!symtab) {
@@ -281,6 +295,30 @@ static int read_symbols(struct elf *elf)
 		hash_add(sym->sec->symbol_hash, &sym->hash, sym->idx);
 	}
 
+	/* Create parent/child links for any cold subfunctions */
+	list_for_each_entry(sec, &elf->sections, list) {
+		list_for_each_entry(sym, &sec->symbol_list, list) {
+			if (sym->type != STT_FUNC)
+				continue;
+			sym->pfunc = sym->cfunc = sym;
+			coldstr = strstr(sym->name, ".cold.");
+			if (coldstr) {
+				coldstr[0] = '\0';
+				pfunc = find_symbol_by_name(elf, sym->name);
+				coldstr[0] = '.';
+
+				if (!pfunc) {
+					WARN("%s(): can't find parent function",
+					     sym->name);
+					goto err;
+				}
+
+				sym->pfunc = pfunc;
+				pfunc->cfunc = sym;
+			}
+		}
+	}
+
 	return 0;
 
 err:
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index d86e2ff14466..de5cd2ddded9 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -61,6 +61,7 @@ struct symbol {
 	unsigned char bind, type;
 	unsigned long offset;
 	unsigned int len;
+	struct symbol *pfunc, *cfunc;
 };
 
 struct rela {
@@ -86,6 +87,7 @@ struct elf {
 struct elf *elf_open(const char *name, int flags);
 struct section *find_section_by_name(struct elf *elf, const char *name);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
+struct symbol *find_symbol_by_name(struct elf *elf, const char *name);
 struct symbol *find_symbol_containing(struct section *sec, unsigned long offset);
 struct rela *find_rela_by_dest(struct section *sec, unsigned long offset);
 struct rela *find_rela_by_dest_range(struct section *sec, unsigned long offset,
