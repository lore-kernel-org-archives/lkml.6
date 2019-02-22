Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB22C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471E92077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ObTYcYa8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfBVW0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:26:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50188 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfBVW0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tqWV73Mb2/SsBWItwuNS8t9Drb2Hy4e7P1//y0Dr96g=; b=ObTYcYa88LWFzZE/e0BvvYuTh
        8d6BiXF2TVNai6W7znBigXSmHp9LrXLU+NCaHHchKrKEF1G9rWEcbMUtSS+AAIO3QkXooJxkPZveu
        tK4Pc0Eb/AhAwOHwpRvotzUZLGMX0ncH6XAKhOAZMl0F3IG2P5jQDeQ0Jx9NzsvNPm2KSzB23i+P0
        eHhVKRMUMOcP9bwL/w72syF7zgo3KKo7HEtTdtdNziJJErE8BXNvrgJJB7QKMN22HaQ3xTAKP7PFy
        lBIpaqIpRlXtAyBvQ4FH9E6vTHUYl+Lw+7bWpLQXb30A/ullkZvlFvFb9sneUvRFUewD4BSVASKnq
        4xzLJdUbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxJHB-0006ZU-Cd; Fri, 22 Feb 2019 22:26:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDF4B984351; Fri, 22 Feb 2019 23:26:35 +0100 (CET)
Date:   Fri, 22 Feb 2019 23:26:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Julien Thierry <julien.thierry@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: [RFC][PATCH] objtool: STAC/CLAC validation
Message-ID: <20190222222635.GK14054@worktop.programming.kicks-ass.net>
References: <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 07:10:34PM +0100, Thomas Gleixner wrote:

> But correct :)

> I agree, that a function which is doing the actual copy should be callable,
> but random other functions? NO!

So find the below patch -- which spotted fail in ptrace.c

It has an AC_SAFE(func) annotation which allows marking specific
functions as safe to call. The patch includes 2 instances which were
required to make arch/x86 'build':

  arch/x86/ia32/ia32_signal.o: warning: objtool: ia32_restore_sigcontext()+0x3d: call to native_load_gs_index() with AC set
  arch/x86/kernel/ptrace.o: warning: objtool: genregs_get()+0x8e: call to getreg() with AC set

It also screams (provided one has CONFIG_FUNCTION_TRACE=y) about the
lack of notrace annotations on functions marked AC_SAFE():

  arch/x86/kernel/ptrace.o: warning: objtool: getreg()+0x0: call to __fentry__() with AC set

It builds arch/x86 relatively clean; it only complains about some
redundant CLACs in entry_64.S because it doesn't understand interrupts
and I've not bothered creating an annotation for them yet.

  arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0x4d: redundant CLAC
  arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0x5a: redundant CLAC
  ...
  arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0xb1: redundant CLAC

Also, I realized we don't need special annotations for preempt_count;
preempt_disable() emits a CALL instruction which should readily trigger
the warnings added here.

The VDSO thing is a bit of a hack, but I couldn't quickly find anything
better.

Comments?

---
 arch/x86/include/asm/special_insns.h |  2 ++
 arch/x86/kernel/ptrace.c             |  3 +-
 include/linux/frame.h                | 23 ++++++++++++++
 tools/objtool/arch.h                 |  4 ++-
 tools/objtool/arch/x86/decode.c      | 14 ++++++++-
 tools/objtool/check.c                | 59 ++++++++++++++++++++++++++++++++++++
 tools/objtool/check.h                |  3 +-
 tools/objtool/elf.h                  |  1 +
 8 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 43c029cdc3fe..cd31e4433f4c 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -5,6 +5,7 @@
 
 #ifdef __KERNEL__
 
+#include <linux/frame.h>
 #include <asm/nops.h>
 
 /*
@@ -135,6 +136,7 @@ static inline void native_wbinvd(void)
 }
 
 extern asmlinkage void native_load_gs_index(unsigned);
+AC_SAFE(native_load_gs_index);
 
 static inline unsigned long __read_cr4(void)
 {
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 4b8ee05dd6ad..e278b4055a8b 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -420,7 +420,7 @@ static int putreg(struct task_struct *child,
 	return 0;
 }
 
-static unsigned long getreg(struct task_struct *task, unsigned long offset)
+static notrace unsigned long getreg(struct task_struct *task, unsigned long offset)
 {
 	switch (offset) {
 	case offsetof(struct user_regs_struct, cs):
@@ -444,6 +444,7 @@ static unsigned long getreg(struct task_struct *task, unsigned long offset)
 
 	return *pt_regs_access(task_pt_regs(task), offset);
 }
+AC_SAFE(getreg);
 
 static int genregs_get(struct task_struct *target,
 		       const struct user_regset *regset,
diff --git a/include/linux/frame.h b/include/linux/frame.h
index 02d3ca2d9598..5d354cf42a56 100644
--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -21,4 +21,27 @@
 
 #endif /* CONFIG_STACK_VALIDATION */
 
+#if defined(CONFIG_STACK_VALIDATION) && !defined(BUILD_VDSO) && !defined(BUILD_VDSO32)
+/*
+ * This macro marks functions as AC-safe, that is, it is safe to call from an
+ * EFLAGS.AC enabled region (typically user_access_begin() /
+ * user_access_end()).
+ *
+ * These functions in turn will only call AC-safe functions themselves (which
+ * precludes tracing, including __fentry__ and scheduling, including
+ * preempt_enable).
+ *
+ * AC-safe functions will obviously also not change EFLAGS.AC themselves.
+ *
+ * Since STAC/CLAC are OPL-0 only, this is all irrelevant for VDSO builds
+ * (and the generated symbol reference will in fact cause link failures).
+ */
+#define AC_SAFE(func) \
+	static void __used __section(.discard.ac_safe) \
+		*__func_ac_safe_##func = func
+
+#else
+#define AC_SAFE(func)
+#endif
+
 #endif /* _LINUX_FRAME_H */
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index b0d7dc3d71b5..48327099466d 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -33,7 +33,9 @@
 #define INSN_STACK		8
 #define INSN_BUG		9
 #define INSN_NOP		10
-#define INSN_OTHER		11
+#define INSN_STAC		11
+#define INSN_CLAC		12
+#define INSN_OTHER		13
 #define INSN_LAST		INSN_OTHER
 
 enum op_dest_type {
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 540a209b78ab..d1e99d1460a5 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -369,7 +369,19 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 	case 0x0f:
 
-		if (op2 >= 0x80 && op2 <= 0x8f) {
+		if (op2 == 0x01) {
+
+			if (modrm == 0xca) {
+
+				*type = INSN_CLAC;
+
+			} else if (modrm == 0xcb) {
+
+				*type = INSN_STAC;
+
+			}
+
+		} else if (op2 >= 0x80 && op2 <= 0x8f) {
 
 			*type = INSN_JUMP_CONDITIONAL;
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0414a0d52262..01852602ca31 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -127,6 +127,24 @@ static bool ignore_func(struct objtool_file *file, struct symbol *func)
 	return false;
 }
 
+static bool ac_safe_func(struct objtool_file *file, struct symbol *func)
+{
+	struct rela *rela;
+
+	/* check for AC_SAFE */
+	if (file->ac_safe && file->ac_safe->rela)
+		list_for_each_entry(rela, &file->ac_safe->rela->rela_list, list) {
+			if (rela->sym->type == STT_SECTION &&
+			    rela->sym->sec == func->sec &&
+			    rela->addend == func->offset)
+				return true;
+			if (/* rela->sym->type == STT_FUNC && */ rela->sym == func)
+				return true;
+		}
+
+	return false;
+}
+
 /*
  * This checks to see if the given function is a "noreturn" function.
  *
@@ -439,6 +457,8 @@ static void add_ignores(struct objtool_file *file)
 
 	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
+			func->ac_safe = ac_safe_func(file, func);
+
 			if (func->type != STT_FUNC)
 				continue;
 
@@ -1902,6 +1922,11 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 		switch (insn->type) {
 
 		case INSN_RETURN:
+			if (state.ac) {
+				WARN_FUNC("return with AC set", sec, insn->offset);
+				return 1;
+			}
+
 			if (func && has_modified_stack_frame(&state)) {
 				WARN_FUNC("return with modified stack frame",
 					  sec, insn->offset);
@@ -1917,6 +1942,12 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			return 0;
 
 		case INSN_CALL:
+			if ((state.ac_safe || state.ac) && !insn->call_dest->ac_safe) {
+				WARN_FUNC("call to %s() with AC set", sec, insn->offset,
+						insn->call_dest->name);
+				return 1;
+			}
+
 			if (is_fentry_call(insn))
 				break;
 
@@ -1928,6 +1959,11 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 
 			/* fallthrough */
 		case INSN_CALL_DYNAMIC:
+			if ((state.ac_safe || state.ac) && !insn->call_dest->ac_safe) {
+				WARN_FUNC("call to %s() with AC set", sec, insn->offset,
+						insn->call_dest->name);
+				return 1;
+			}
 			if (!no_fp && func && !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
@@ -1980,6 +2016,26 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 
 			break;
 
+		case INSN_STAC:
+			if (state.ac_safe || state.ac) {
+				WARN_FUNC("recursive STAC", sec, insn->offset);
+				return 1;
+			}
+			state.ac = true;
+			break;
+
+		case INSN_CLAC:
+			if (!state.ac) {
+				WARN_FUNC("redundant CLAC", sec, insn->offset);
+				return 1;
+			}
+			if (state.ac_safe) {
+				WARN_FUNC("AC-safe clears AC", sec, insn->offset);
+				return 1;
+			}
+			state.ac = false;
+			break;
+
 		default:
 			break;
 		}
@@ -2141,6 +2197,8 @@ static int validate_functions(struct objtool_file *file)
 			if (!insn || insn->ignore)
 				continue;
 
+			state.ac_safe = func->ac_safe;
+
 			ret = validate_branch(file, insn, state);
 			warnings += ret;
 		}
@@ -2198,6 +2256,7 @@ int check(const char *_objname, bool orc)
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
 	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
+	file.ac_safe = find_section_by_name(file.elf, ".discard.ac_safe");
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index e6e8a655b556..c31ec3ca78f3 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -31,7 +31,7 @@ struct insn_state {
 	int stack_size;
 	unsigned char type;
 	bool bp_scratch;
-	bool drap, end;
+	bool drap, end, ac, ac_safe;
 	int drap_reg, drap_offset;
 	struct cfi_reg vals[CFI_NUM_REGS];
 };
@@ -61,6 +61,7 @@ struct objtool_file {
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 16);
 	struct section *whitelist;
+	struct section *ac_safe;
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index bc97ed86b9cd..064c3df31e40 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -62,6 +62,7 @@ struct symbol {
 	unsigned long offset;
 	unsigned int len;
 	struct symbol *pfunc, *cfunc;
+	bool ac_safe;
 };
 
 struct rela {
