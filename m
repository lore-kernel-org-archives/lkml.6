Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C291C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D204020842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfBYIdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:33:46 -0500
Received: from foss.arm.com ([217.140.101.70]:57878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfBYIdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:33:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F6E7A78;
        Mon, 25 Feb 2019 00:33:45 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EA903F703;
        Mon, 25 Feb 2019 00:33:41 -0800 (PST)
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <99aab8c6-0000-b06b-71c0-bd36e0d39768@arm.com>
Date:   Mon, 25 Feb 2019 08:33:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190222222635.GK14054@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/02/2019 22:26, Peter Zijlstra wrote:
> On Fri, Feb 22, 2019 at 07:10:34PM +0100, Thomas Gleixner wrote:
> 
>> But correct :)
> 
>> I agree, that a function which is doing the actual copy should be callable,
>> but random other functions? NO!
> 
> So find the below patch -- which spotted fail in ptrace.c
> 
> It has an AC_SAFE(func) annotation which allows marking specific
> functions as safe to call. The patch includes 2 instances which were
> required to make arch/x86 'build':
> 
>   arch/x86/ia32/ia32_signal.o: warning: objtool: ia32_restore_sigcontext()+0x3d: call to native_load_gs_index() with AC set
>   arch/x86/kernel/ptrace.o: warning: objtool: genregs_get()+0x8e: call to getreg() with AC set
> 
> It also screams (provided one has CONFIG_FUNCTION_TRACE=y) about the
> lack of notrace annotations on functions marked AC_SAFE():
> 
>   arch/x86/kernel/ptrace.o: warning: objtool: getreg()+0x0: call to __fentry__() with AC set
> 
> It builds arch/x86 relatively clean; it only complains about some
> redundant CLACs in entry_64.S because it doesn't understand interrupts
> and I've not bothered creating an annotation for them yet.
> 
>   arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0x4d: redundant CLAC
>   arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0x5a: redundant CLAC
>   ...
>   arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0xb1: redundant CLAC
> 
> Also, I realized we don't need special annotations for preempt_count;
> preempt_disable() emits a CALL instruction which should readily trigger
> the warnings added here.
> 
> The VDSO thing is a bit of a hack, but I couldn't quickly find anything
> better.
> 
> Comments?

I haven't looked at all the details. But could the annotation be called
UACCESS_SAFE() (and corresponding naming in the objtool checks)? Since
this is not an x86 only issue and the AC flags only exists for x86.

Cheers,

Julien

> 
> ---
>  arch/x86/include/asm/special_insns.h |  2 ++
>  arch/x86/kernel/ptrace.c             |  3 +-
>  include/linux/frame.h                | 23 ++++++++++++++
>  tools/objtool/arch.h                 |  4 ++-
>  tools/objtool/arch/x86/decode.c      | 14 ++++++++-
>  tools/objtool/check.c                | 59 ++++++++++++++++++++++++++++++++++++
>  tools/objtool/check.h                |  3 +-
>  tools/objtool/elf.h                  |  1 +
>  8 files changed, 105 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 43c029cdc3fe..cd31e4433f4c 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -5,6 +5,7 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <linux/frame.h>
>  #include <asm/nops.h>
>  
>  /*
> @@ -135,6 +136,7 @@ static inline void native_wbinvd(void)
>  }
>  
>  extern asmlinkage void native_load_gs_index(unsigned);
> +AC_SAFE(native_load_gs_index);
>  
>  static inline unsigned long __read_cr4(void)
>  {
> diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> index 4b8ee05dd6ad..e278b4055a8b 100644
> --- a/arch/x86/kernel/ptrace.c
> +++ b/arch/x86/kernel/ptrace.c
> @@ -420,7 +420,7 @@ static int putreg(struct task_struct *child,
>  	return 0;
>  }
>  
> -static unsigned long getreg(struct task_struct *task, unsigned long offset)
> +static notrace unsigned long getreg(struct task_struct *task, unsigned long offset)
>  {
>  	switch (offset) {
>  	case offsetof(struct user_regs_struct, cs):
> @@ -444,6 +444,7 @@ static unsigned long getreg(struct task_struct *task, unsigned long offset)
>  
>  	return *pt_regs_access(task_pt_regs(task), offset);
>  }
> +AC_SAFE(getreg);
>  
>  static int genregs_get(struct task_struct *target,
>  		       const struct user_regset *regset,
> diff --git a/include/linux/frame.h b/include/linux/frame.h
> index 02d3ca2d9598..5d354cf42a56 100644
> --- a/include/linux/frame.h
> +++ b/include/linux/frame.h
> @@ -21,4 +21,27 @@
>  
>  #endif /* CONFIG_STACK_VALIDATION */
>  
> +#if defined(CONFIG_STACK_VALIDATION) && !defined(BUILD_VDSO) && !defined(BUILD_VDSO32)
> +/*
> + * This macro marks functions as AC-safe, that is, it is safe to call from an
> + * EFLAGS.AC enabled region (typically user_access_begin() /
> + * user_access_end()).
> + *
> + * These functions in turn will only call AC-safe functions themselves (which
> + * precludes tracing, including __fentry__ and scheduling, including
> + * preempt_enable).
> + *
> + * AC-safe functions will obviously also not change EFLAGS.AC themselves.
> + *
> + * Since STAC/CLAC are OPL-0 only, this is all irrelevant for VDSO builds
> + * (and the generated symbol reference will in fact cause link failures).
> + */
> +#define AC_SAFE(func) \
> +	static void __used __section(.discard.ac_safe) \
> +		*__func_ac_safe_##func = func
> +
> +#else
> +#define AC_SAFE(func)
> +#endif
> +
>  #endif /* _LINUX_FRAME_H */
> diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
> index b0d7dc3d71b5..48327099466d 100644
> --- a/tools/objtool/arch.h
> +++ b/tools/objtool/arch.h
> @@ -33,7 +33,9 @@
>  #define INSN_STACK		8
>  #define INSN_BUG		9
>  #define INSN_NOP		10
> -#define INSN_OTHER		11
> +#define INSN_STAC		11
> +#define INSN_CLAC		12
> +#define INSN_OTHER		13
>  #define INSN_LAST		INSN_OTHER
>  
>  enum op_dest_type {
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index 540a209b78ab..d1e99d1460a5 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -369,7 +369,19 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
>  
>  	case 0x0f:
>  
> -		if (op2 >= 0x80 && op2 <= 0x8f) {
> +		if (op2 == 0x01) {
> +
> +			if (modrm == 0xca) {
> +
> +				*type = INSN_CLAC;
> +
> +			} else if (modrm == 0xcb) {
> +
> +				*type = INSN_STAC;
> +
> +			}
> +
> +		} else if (op2 >= 0x80 && op2 <= 0x8f) {
>  
>  			*type = INSN_JUMP_CONDITIONAL;
>  
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 0414a0d52262..01852602ca31 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -127,6 +127,24 @@ static bool ignore_func(struct objtool_file *file, struct symbol *func)
>  	return false;
>  }
>  
> +static bool ac_safe_func(struct objtool_file *file, struct symbol *func)
> +{
> +	struct rela *rela;
> +
> +	/* check for AC_SAFE */
> +	if (file->ac_safe && file->ac_safe->rela)
> +		list_for_each_entry(rela, &file->ac_safe->rela->rela_list, list) {
> +			if (rela->sym->type == STT_SECTION &&
> +			    rela->sym->sec == func->sec &&
> +			    rela->addend == func->offset)
> +				return true;
> +			if (/* rela->sym->type == STT_FUNC && */ rela->sym == func)
> +				return true;
> +		}
> +
> +	return false;
> +}
> +
>  /*
>   * This checks to see if the given function is a "noreturn" function.
>   *
> @@ -439,6 +457,8 @@ static void add_ignores(struct objtool_file *file)
>  
>  	for_each_sec(file, sec) {
>  		list_for_each_entry(func, &sec->symbol_list, list) {
> +			func->ac_safe = ac_safe_func(file, func);
> +
>  			if (func->type != STT_FUNC)
>  				continue;
>  
> @@ -1902,6 +1922,11 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
>  		switch (insn->type) {
>  
>  		case INSN_RETURN:
> +			if (state.ac) {
> +				WARN_FUNC("return with AC set", sec, insn->offset);
> +				return 1;
> +			}
> +
>  			if (func && has_modified_stack_frame(&state)) {
>  				WARN_FUNC("return with modified stack frame",
>  					  sec, insn->offset);
> @@ -1917,6 +1942,12 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
>  			return 0;
>  
>  		case INSN_CALL:
> +			if ((state.ac_safe || state.ac) && !insn->call_dest->ac_safe) {
> +				WARN_FUNC("call to %s() with AC set", sec, insn->offset,
> +						insn->call_dest->name);
> +				return 1;
> +			}
> +
>  			if (is_fentry_call(insn))
>  				break;
>  
> @@ -1928,6 +1959,11 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
>  
>  			/* fallthrough */
>  		case INSN_CALL_DYNAMIC:
> +			if ((state.ac_safe || state.ac) && !insn->call_dest->ac_safe) {
> +				WARN_FUNC("call to %s() with AC set", sec, insn->offset,
> +						insn->call_dest->name);
> +				return 1;
> +			}
>  			if (!no_fp && func && !has_valid_stack_frame(&state)) {
>  				WARN_FUNC("call without frame pointer save/setup",
>  					  sec, insn->offset);
> @@ -1980,6 +2016,26 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
>  
>  			break;
>  
> +		case INSN_STAC:
> +			if (state.ac_safe || state.ac) {
> +				WARN_FUNC("recursive STAC", sec, insn->offset);
> +				return 1;
> +			}
> +			state.ac = true;
> +			break;
> +
> +		case INSN_CLAC:
> +			if (!state.ac) {
> +				WARN_FUNC("redundant CLAC", sec, insn->offset);
> +				return 1;
> +			}
> +			if (state.ac_safe) {
> +				WARN_FUNC("AC-safe clears AC", sec, insn->offset);
> +				return 1;
> +			}
> +			state.ac = false;
> +			break;
> +
>  		default:
>  			break;
>  		}
> @@ -2141,6 +2197,8 @@ static int validate_functions(struct objtool_file *file)
>  			if (!insn || insn->ignore)
>  				continue;
>  
> +			state.ac_safe = func->ac_safe;
> +
>  			ret = validate_branch(file, insn, state);
>  			warnings += ret;
>  		}
> @@ -2198,6 +2256,7 @@ int check(const char *_objname, bool orc)
>  	INIT_LIST_HEAD(&file.insn_list);
>  	hash_init(file.insn_hash);
>  	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
> +	file.ac_safe = find_section_by_name(file.elf, ".discard.ac_safe");
>  	file.c_file = find_section_by_name(file.elf, ".comment");
>  	file.ignore_unreachables = no_unreachable;
>  	file.hints = false;
> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> index e6e8a655b556..c31ec3ca78f3 100644
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -31,7 +31,7 @@ struct insn_state {
>  	int stack_size;
>  	unsigned char type;
>  	bool bp_scratch;
> -	bool drap, end;
> +	bool drap, end, ac, ac_safe;
>  	int drap_reg, drap_offset;
>  	struct cfi_reg vals[CFI_NUM_REGS];
>  };
> @@ -61,6 +61,7 @@ struct objtool_file {
>  	struct list_head insn_list;
>  	DECLARE_HASHTABLE(insn_hash, 16);
>  	struct section *whitelist;
> +	struct section *ac_safe;
>  	bool ignore_unreachables, c_file, hints, rodata;
>  };
>  
> diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
> index bc97ed86b9cd..064c3df31e40 100644
> --- a/tools/objtool/elf.h
> +++ b/tools/objtool/elf.h
> @@ -62,6 +62,7 @@ struct symbol {
>  	unsigned long offset;
>  	unsigned int len;
>  	struct symbol *pfunc, *cfunc;
> +	bool ac_safe;
>  };
>  
>  struct rela {
> 

-- 
Julien Thierry
