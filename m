Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E182C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297A4207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SrzmrG4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfBVM6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:58:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47398 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfBVM6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 07:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CfFko118cyzouCp4+3aL/LVdFcmqxlb4j3aW2IUziX4=; b=SrzmrG4ISF8nLIEcGAncPhtaV
        ybnvXcuYcMCu7R4mKtWKaQ10JnLORt62AWYsCRgGI0N82kVHGpf2K+WTvsrj1nrNlebAd1ypB9RNd
        By2g/22L1MaijzgNatIfslAxqpP/3ugBH3aNiZg3y2gzzWQhEqbp3DOXzeo/bJ9Xd8Yorj9gYi4gU
        dwmG4TrbvRMQfImeDnezznpgXdMP94ITivWI2Sl39VuaNCNFKIufW4GXhgpXCuoNiSF6ABKdi/k+L
        hnxYQ4KWrEkWPw7MGf2AEp5HXalN0ZDbtsqVDYmzvOybzrLX1KTr/DQ8IH9rtCRr7FqGDLvSj4Yjl
        MYCPktuqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxAPG-0002d5-7X; Fri, 22 Feb 2019 12:58:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA78D299F9ED6; Fri, 22 Feb 2019 13:58:18 +0100 (CET)
Date:   Fri, 22 Feb 2019 13:58:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190222125818.GX32494@hirez.programming.kicks-ass.net>
References: <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 02:08:11PM -0800, Linus Torvalds wrote:
> On Thu, Feb 21, 2019 at 1:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > IMNSHO any call inside a AC region is a bug lurking round the corner. The
> > only thing which is tolerable is an exception of some sort.
> >
> > Enforce that with objtool. End of story.
> 
> Not quite that simple.
> 
> There are some use cases where you really do want a call - albeit to
> special functions - inside the AC region.
> 
> The prime example of this is likely "filldir()" in fs/readdir.c, which
> is actually somewhat important for some loads (eg samba).
> 
> And the whole AC thing made it horribly horribly slow because readdir
> is one of those things that doesn't just copy one value (or one
> structure) to user space, but writes several different things.
> 
> Kind of like signal frame setup does.
> 
> You may not realize that right now signal frame setup *does* actually
> do a call with AC set. See ia32_setup_rt_frame() that does
> 
>         put_user_try {
> ...
>                 compat_save_altstack_ex(&frame->uc.uc_stack, regs->sp);
> ...
>         } put_user_catch(err);
> 
> is a macro, but inside that macro is a call to sas_ss_reset().
> 
> Now, that is an inline function, so it hopefully doesn't actually
> cause a call. But it's "only" an inline function, not "always_inline".
> We did already have (and I rejected, for now) patches that made those
> inlines not very strong...

That one does indeed not generate a call, but:

arch/x86/ia32/ia32_signal.o: warning: objtool: ia32_restore_sigcontext()+0x38: call to native_load_gs_index() with AC set

I've yet to look at detectoring __preempt_count mucking.

---
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
diff --git a/include/linux/frame.h b/include/linux/frame.h
index 02d3ca2d9598..644662d8b8e8 100644
--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -15,9 +15,14 @@
 	static void __used __section(.discard.func_stack_frame_non_standard) \
 		*__func_stack_frame_non_standard_##func = func
 
+#define AC_SAFE(func) \
+	static void __used __section(.discard.ac_safe) \
+		*__func_ac_safe_##func = func
+
 #else /* !CONFIG_STACK_VALIDATION */
 
 #define STACK_FRAME_NON_STANDARD(func)
+#define AC_SAFE(func)
 
 #endif /* CONFIG_STACK_VALIDATION */
 
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index c9d038f91af6..5a64e5fb9d7a 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -31,7 +31,7 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
-CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES)
+CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) -ggdb3
 LDFLAGS  += -lelf $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
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
index 0414a0d52262..6fef157e244b 100644
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
 
@@ -1897,11 +1917,16 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 				if (ret)
 					return 1;
 			}
-		}
+		} else printf("ponies\n");
 
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
+			if (state.ac && !insn->call_dest->ac_safe) {
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
+			if (state.ac && !insn->call_dest->ac_safe) {
+				WARN_FUNC("call to %s() with AC set", sec, insn->offset,
+						insn->call_dest->name);
+				return 1;
+			}
 			if (!no_fp && func && !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
@@ -1980,6 +2016,14 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 
 			break;
 
+		case INSN_STAC:
+			state.ac = true;
+			break;
+
+		case INSN_CLAC:
+			state.ac = false;
+			break;
+
 		default:
 			break;
 		}
@@ -2198,6 +2242,7 @@ int check(const char *_objname, bool orc)
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
 	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
+	file.ac_safe = find_section_by_name(file.elf, ".discard.ac_safe");
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index e6e8a655b556..d4ae59454fff 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -31,7 +31,7 @@ struct insn_state {
 	int stack_size;
 	unsigned char type;
 	bool bp_scratch;
-	bool drap, end;
+	bool drap, end, ac;
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
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 50af4e1274b3..72084cae8f35 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -166,8 +166,8 @@ int special_get_alts(struct elf *elf, struct list_head *alts)
 			continue;
 
 		if (sec->len % entry->size != 0) {
-			WARN("%s size not a multiple of %d",
-			     sec->name, entry->size);
+			WARN("%s size (%d) not a multiple of %d",
+			     sec->name, sec->len, entry->size);
 			return -1;
 		}
 
