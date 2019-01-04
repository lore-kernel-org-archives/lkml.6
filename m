Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C90C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2378D218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfADRu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:50:28 -0500
Received: from foss.arm.com ([217.140.101.70]:47310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728938AbfADRu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:50:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA596EBD;
        Fri,  4 Jan 2019 09:50:25 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A8553F5D4;
        Fri,  4 Jan 2019 09:50:23 -0800 (PST)
Date:   Fri, 4 Jan 2019 17:50:18 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
Message-ID: <20190104175017.GA7157@lakrids.cambridge.arm.com>
References: <20190104141053.360F768D93@newverein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104141053.360F768D93@newverein.lst.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Torsten,

On Fri, Jan 04, 2019 at 03:10:53PM +0100, Torsten Duwe wrote:
> Use -fpatchable-function-entry (gcc8) to add 2 NOPs at the beginning
> of each function. Replace the first NOP thus generated with a quick LR
> saver (move it to scratch reg x9), so the 2nd replacement insn, the call
> to ftrace, does not clobber the value. Ftrace will then generate the
> standard stack frames.
> 
> Note that patchable-function-entry in GCC disables IPA-RA, which means
> ABI register calling conventions are obeyed *and* scratch registers
> such as x9 are available.
> 
> Introduce and handle an ftrace_regs_trampoline for module PLTs, right
> after ftrace_trampoline, and double the size of this special section.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> ---
> 
> This patch applies on 4.20 with the additional changes
> bdb85cd1d20669dfae813555dddb745ad09323ba
> (arm64/module: switch to ADRP/ADD sequences for PLT entries)
> and
> 7dc48bf96aa0fc8aa5b38cc3e5c36ac03171e680
> (arm64: ftrace: always pass instrumented pc in x0)
> along with their respective series, or alternatively on Linus' master,
> which already has these.
> 
> changes since v5:
> 
> * fix mentioned pc in x0 to hold the start address of the call site,
>   not the return address or the branch address.
>   This resolves the problem found by Amit.
> 
> ---
>  arch/arm64/Kconfig                    |    2 
>  arch/arm64/Makefile                   |    4 +
>  arch/arm64/include/asm/assembler.h    |    1 
>  arch/arm64/include/asm/ftrace.h       |   13 +++
>  arch/arm64/include/asm/module.h       |    3 
>  arch/arm64/kernel/Makefile            |    6 -
>  arch/arm64/kernel/entry-ftrace.S      |  131 ++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/ftrace.c            |  125 ++++++++++++++++++++++++--------
>  arch/arm64/kernel/module-plts.c       |    3 
>  arch/arm64/kernel/module.c            |    2 
>  drivers/firmware/efi/libstub/Makefile |    3 
>  include/asm-generic/vmlinux.lds.h     |    1 
>  include/linux/compiler_types.h        |    4 +
>  13 files changed, 262 insertions(+), 36 deletions(-)
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -131,6 +131,8 @@ config ARM64
>  	select HAVE_DEBUG_KMEMLEAK
>  	select HAVE_DMA_CONTIGUOUS
>  	select HAVE_DYNAMIC_FTRACE
> +	select HAVE_DYNAMIC_FTRACE_WITH_REGS \
> +		if $(cc-option,-fpatchable-function-entry=2)
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_FUNCTION_TRACER
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -79,6 +79,10 @@ ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
>  KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm64/kernel/module.lds
>  endif
>  
> +ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
> +  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
> +endif
> +
>  # Default value
>  head-y		:= arch/arm64/kernel/head.o
>  
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -17,6 +17,19 @@
>  #define MCOUNT_ADDR		((unsigned long)_mcount)
>  #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
>  
> +/*
> + * DYNAMIC_FTRACE_WITH_REGS is implemented by adding 2 NOPs at the beginning
> + * of each function, with the second NOP actually calling ftrace. In contrary
> + * to a classic _mcount call, the call instruction to be modified is thus
> + * the second one, and not the only one.
> + */
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#define ARCH_SUPPORTS_FTRACE_OPS 1
> +#define REC_IP_BRANCH_OFFSET AARCH64_INSN_SIZE
> +#else
> +#define REC_IP_BRANCH_OFFSET 0
> +#endif

At Linux Plumbers, I had a conversation with Steve Rostedt, and we came
to the conclusion that (withut heavyweight synchronization) patching two
NOPs at runtime isn't safe, since a CPU might have executed the first
NOP as a NOP before another CPU patches both instructions. So a CPU
might execute:

	NOP
	BL	ftrace_regs_caller

... rather than the expected:

	MOV	X9, X30
	BL	ftrace_regs_caller

... and therefore X9 contains some UNKNOWN value, rather than the
original LR value.

I wonder if we could solve that by patching the kernel at build-time, to
add the MOV X9, X30 in place of the first NOP. If we were to do that, we
could also update the addresses to pooint at the second NOP, simplifying
the changes to the runtime code.

> +
>  #ifndef __ASSEMBLY__
>  #include <linux/compat.h>
>  
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -7,9 +7,9 @@ CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(
>  AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>  CFLAGS_armv8_deprecated.o := -I$(src)
>  
> -CFLAGS_REMOVE_ftrace.o = -pg
> -CFLAGS_REMOVE_insn.o = -pg
> -CFLAGS_REMOVE_return_address.o = -pg
> +CFLAGS_REMOVE_ftrace.o = -pg $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_insn.o = -pg $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_return_address.o = -pg $(CC_FLAGS_FTRACE)
>  
>  # Object file lists.
>  arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -13,7 +13,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__K
>  
>  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
>  # disable the stackleak plugin
> -cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie \
> +cflags-$(CONFIG_ARM64)		:= $(filter-out -pg $(CC_FLAGS_FTRACE)\
> +				  ,$(KBUILD_CFLAGS)) -fpie \
>  				   $(DISABLE_STACKLEAK_PLUGIN)
>  cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
>  				   -fno-builtin -fpic \

Could you please split the CC_FLAGS_FTRACE changes into preparatory
patches? I think those are good regardless of the FTRACE_WITH_REGS
parts, and it would simplify review.

> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -13,6 +13,8 @@
>  #include <asm/assembler.h>
>  #include <asm/ftrace.h>
>  #include <asm/insn.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/assembler.h>

Nit: please keep includes ordered alphabetically.

>  
>  /*
>   * Gcc with -pg will put the following code in the beginning of each function:
> @@ -122,6 +124,7 @@ skip_ftrace_call:			// }
>  ENDPROC(_mcount)
>  
>  #else /* CONFIG_DYNAMIC_FTRACE */
> +#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  /*
>   * _mcount() is used to build the kernel with -pg option, but all the branch
>   * instructions to _mcount() are replaced to NOP initially at kernel start up,
> @@ -159,6 +162,124 @@ GLOBAL(ftrace_graph_call)		// ftrace_gra
>  
>  	mcount_exit
>  ENDPROC(ftrace_caller)
> +#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> +
> +/*
> + * Since no -pg or similar compiler flag is used, there should really be
> + * no reference to _mcount; so do not define one. Only some value for
> + * MCOUNT_ADDR is needed for comparison. Let it point here to have some
> + * sort of magic value that can be recognised when debugging.
> + */
> +GLOBAL(_mcount)
> +	ret	/* make it differ from regs caller */

This is just because of ftrace_code_disable(), right?

Can't we just move the ifdeffery, into that, so that nothing refers to
MCOUNT_ADDR?

I really don't like defining a symbol that should never be used.

> +
> +ENTRY(ftrace_regs_caller)
> +	/* callee's preliminary stack frame: */
> +	stp	fp, x9, [sp, #-16]!
> +	mov	fp, sp

Please s/fp/x29/. That will be consistent with the rest of the arm64
assembly, and won't need the .req, so we'll have fewer surprises.

> +
> +	/* our stack frame: */
> +	stp	fp, lr, [sp, #-S_FRAME_SIZE]!
> +	add	x9, sp, #16	/* offset to pt_regs */

The way you create the two stackframes here is incredibly confusing. It
implicitly relies on the layout of pt_regs, and doesn't follow the
conventions used by the other arm64 entry assembly.

To use the embedded stackframe, please explicitly use S_STACKFRAME,
rather than assuming this is the last element in pt_regs, e.g.

	sub	sp, sp, #S_FRAME_SIZE

	stp	x29, x9, [sp, #S_STACKFRAME]
	add	x29, sp, #S_STACKFRAME

Since we need two stackframes, we can do something like:

	sub	sp, sp, #(S_FRAME_SIZE + 16)

	stp	x29, x9, [sp, #S_FRAME_SIZE]
	add	x29, sp, #S_FRAME_SIZE

	stp	x29, fp, [sp, #S_STACKFRAME]
	add	x29, sp, #S_STACKFRAME

... which also leaves the SP pointing at the pt_regs, which is the
convention followed by all the other entry assembly that we have.

> +
> +	/* along with the _common code below, dump the complete
> +	 * register set for inspection.
> +	 */

Nit: comment style violation. The '/*' should be on its own line.

Please fix that throughout the entire patch.

> +	stp	x10, x11, [x9, #S_X10]
> +	stp	x12, x13, [x9, #S_X12]
> +	stp	x14, x15, [x9, #S_X14]
> +	stp	x16, x17, [x9, #S_X16]
> +	stp	x18, x19, [x9, #S_X18]
> +	stp	x20, x21, [x9, #S_X20]
> +	stp	x22, x23, [x9, #S_X22]
> +	stp	x24, x25, [x9, #S_X24]
> +	stp	x26, x27, [x9, #S_X26]

... with the changes above, the sp can be the base here.

> +
> +	b	ftrace_common
> +ENDPROC(ftrace_regs_caller)
> +
> +ENTRY(ftrace_caller)
> +	/* callee's preliminary stack frame: */
> +	stp	fp, x9, [sp, #-16]!
> +	mov	fp, sp
> +
> +	/* our stack frame: */
> +	stp	fp, lr, [sp, #-S_FRAME_SIZE]!
> +	add	x9, sp, #16	/* offset to pt_regs */
> +

Same comments here for the stackframe creation.

> +ftrace_common:
> +	/*
> +	 * At this point we have 2 new stack frames, and x9 pointing
> +	 * at a pt_regs which we can populate as needed. At least the
> +	 * argument registers need to be preserved, see
> +	 * ftrace_common_return below. pt_regs at x9 is layed out so
> +	 * that pt_regs.stackframe[] (last 16 bytes) maps to the
> +	 * preliminary frame we created for the callee.
> +	 */
> +
> +	/* save function arguments */
> +	stp	x0, x1, [x9]
> +	stp	x2, x3, [x9, #S_X2]
> +	stp	x4, x5, [x9, #S_X4]
> +	stp	x6, x7, [x9, #S_X6]
> +	str	x8, [x9, #S_X8]
> +
> +	ldr	x0, [fp]
> +	stp	x28, x0, [x9, #S_X28]	/* FP in pt_regs + "our" x28 */
> +
> +	/* The program counter just after the ftrace call site */
> +	str	lr, [x9, #S_PC]
> +	/* The stack pointer as it was on ftrace_caller entry... */
> +	add	x28, fp, #16
> +	str	x28, [x9, #S_SP]
> +	/* The link Register at callee entry */
> +	ldr	x28, [fp, 8]
> +	str	x28, [x9, #S_LR]	/* to pt_regs.r[30] */
> +
> +	ldr_l	x2, function_trace_op, x0
> +	ldr	x1, [fp, #8]
> +	sub	x0, lr, #8	/* function entry == IP */
> +	mov	x3, x9		/* pt_regs are @x9 */
> +
> +	mov	fp, sp

I think it would be worth putting the entry logic into an assembly
macro, e.g.

	.macro	ftrace_regs_entry, allregs=0
	sub	sp, sp, #(S_FRAME_SIZE + 16)

	stp	x0, x1, [sp, #S_X0]
	<store x2-x7>
	stp	x8, x9, [sp, #S_X8]

	.if \allregs == 1
	stp	x10, x11, [sp, #S_X10]
	<store x12-x25>
	stp	x26, x27, [sp, #S_X26]
	.endif

	stp	x28, x29, [sp, #S_X28]
	
	< store other common bits here >

	/* Callee's stackframe */
	stp	x29, x9, [sp, #S_FRAME_SIZE]
	add	x29, sp, #S_FRAME_SIZE

	/* Our stackframe */
	stp	x29, x30, [sp, #S_STACKFRAME]
	add	x29, sp, #S_STACKFRAME
	.endm

... which makes it obvious that the two entry paths will only differ in
terms of registers saved. That also minimizes regsiter juggling, since
we creat the stack records last.

To use that, we'd have something like:

ENTRY(ftrace_regs_caller)
	ftrace_regs_entry	1
	b	ftrace_regs_common
ENDPROC(ftrace_regs_caller)

ENTRY(ftrace_caller)
	ftrace_regs_entry	0
	b       ftrace_regs_common
ENDPROC(ftrace_regs_caller)

ftrace_regs_common:
	<ftrace calls and return here>
ENDPROC(ftrace_regs_common)

> +
> +GLOBAL(ftrace_call)
> +	bl	ftrace_stub
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +GLOBAL(ftrace_graph_call)		// ftrace_graph_caller();
> +	nop				// If enabled, this will be replaced
> +					// "b ftrace_graph_caller"
> +#endif
> +
> +/*
> + * GCC's patchable-function-entry implicitly disables IPA-RA,
> + * so all non-argument registers are either scratch / dead
> + * or callee-saved (within the ftrace framework). Function
> + * arguments of the call we are intercepting right now however
> + * need to be preserved in any case.
> + */
> +ftrace_common_return:
> +	add	x9, sp, #16	/* advance to pt_regs for restore */
> +
> +	ldp	x0, x1, [x9]
> +	ldp	x2, x3, [x9, #S_X2]
> +	ldp	x4, x5, [x9, #S_X4]
> +	ldp	x6, x7, [x9, #S_X6]
> +	ldr	x8, [x9, #S_X8]
> +
> +	ldp	x28, fp, [x9, #S_X28]
> +
> +	ldr	lr, [x9, #S_LR]
> +	ldr	x9, [x9, #S_PC]
> +	/* clean up both frames, ours and callee preliminary */
> +	add	sp, sp, #S_FRAME_SIZE + 16

With the cahnges above, we can remove the first add, and use SP as the
base for all the loads.

> +
> +	ret	x9
> +
> +ENDPROC(ftrace_caller)
> +
> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>  #endif /* CONFIG_DYNAMIC_FTRACE */
>  
>  ENTRY(ftrace_stub)
> @@ -176,12 +297,22 @@ ENDPROC(ftrace_stub)
>   * and run return_to_handler() later on its exit.
>   */
>  ENTRY(ftrace_graph_caller)
> +#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  	mcount_get_pc		  x0	//     function's pc
>  	mcount_get_lr_addr	  x1	//     pointer to function's saved lr
>  	mcount_get_parent_fp	  x2	//     parent's fp
>  	bl	prepare_ftrace_return	// prepare_ftrace_return(pc, &lr, fp)
>  
>  	mcount_exit
> +#else
> +	add	x9, sp, #16	/* advance to pt_regs to gather args */
> +	ldr	x0, [x9, #S_PC]		   /* pc */
> +	sub	x0, x0, #8	/* start of the ftrace call site */
> +	add	x1, x9, #S_LR		   /* &lr */
> +	ldr	x2, [x9, #S_STACKFRAME]	   /* fp */
> +	bl	prepare_ftrace_return
> +	b	ftrace_common_return
> +#endif
>  ENDPROC(ftrace_graph_caller)

Can we move this into the same ifdeffery?

e.g.

#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS

...

ENTRY(ftrace_graph_caller)
	<regs version here>
ENDPROC(ftrace_graph_caller)

#else

...

ENTRY(ftrace_graph_caller)
	<mcount version here>
ENDPROC(ftrace_graph_caller)
#endif

That would be a cleaner split of the FTRACE_WITH_REGS and mcount-based
code.

>  
>  /*
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -65,18 +65,66 @@ int ftrace_update_ftrace_func(ftrace_fun
>  	return ftrace_modify_code(pc, 0, new, false);
>  }
>  
> +#ifdef CONFIG_ARM64_MODULE_PLTS
> +static int install_ftrace_trampoline(struct module *mod, unsigned long *addr)
> +{
> +	struct plt_entry trampoline, *mod_trampoline;
> +
> +	/* Iterate over
> +	 * mod->arch.ftrace_trampolines[MOD_ARCH_NR_FTRACE_TRAMPOLINES]
> +	 * The assignment to various ftrace functions happens here.
> +	 */

Nit: comment style violation.

> +	if (*addr == FTRACE_ADDR)
> +		mod_trampoline = &mod->arch.ftrace_trampolines[0];
> +	else if (*addr == FTRACE_REGS_ADDR)
> +		mod_trampoline = &mod->arch.ftrace_trampolines[1];
> +	else
> +		return -EINVAL;
> +
> +	trampoline = get_plt_entry(*addr, mod_trampoline);
> +
> +	if (!plt_entries_equal(mod_trampoline, &trampoline)) {
> +
> +			/* point the trampoline at our ftrace entry point */
> +			module_disable_ro(mod);
> +			*mod_trampoline = trampoline;
> +			module_enable_ro(mod, true);
> +
> +			/* update trampoline before patching in the branch */
> +			smp_wmb();
> +		}
> +	*addr = (unsigned long)(void *)mod_trampoline;
> +
> +	return 0;
> +}
> +#endif
> +
> +/*
> + * Ftrace with regs generates the tracer calls as close as possible to
> + * the function entry; no stack frame has been set up at that point.
> + * In order to make another call e.g to ftrace_caller, the LR must be
> + * saved from being overwritten.
> + * Between two functions, and with IPA-RA turned off, the scratch registers
> + * are available, so move the LR to x9 before calling into ftrace.
> + * "mov x9, lr" is officially aliased from "orr x9, xzr, lr".
> + */
> +#define QUICK_LR_SAVE aarch64_insn_gen_logical_shifted_reg( \
> +			AARCH64_INSN_REG_9, AARCH64_INSN_REG_ZR, \
> +			AARCH64_INSN_REG_LR, 0, AARCH64_INSN_VARIANT_64BIT, \
> +			AARCH64_INSN_LOGIC_ORR)

Please call this something like MOV_X9_X30. The "QUICK_LR_SAVE" name is
not all that helpful.

That said, if we patch this at build time, we don't need this at all.

> +
>  /*
>   * Turn on the call to ftrace_caller() in instrumented function
>   */
>  int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  {
> -	unsigned long pc = rec->ip;
> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
> +	int ret;
>  	u32 old, new;
>  	long offset = (long)pc - (long)addr;
>  
>  	if (offset < -SZ_128M || offset >= SZ_128M) {
>  #ifdef CONFIG_ARM64_MODULE_PLTS
> -		struct plt_entry trampoline;
>  		struct module *mod;
>  
>  		/*
> @@ -96,54 +144,65 @@ int ftrace_make_call(struct dyn_ftrace *
>  		if (WARN_ON(!mod))
>  			return -EINVAL;
>  
> -		/*
> -		 * There is only one ftrace trampoline per module. For now,
> -		 * this is not a problem since on arm64, all dynamic ftrace
> -		 * invocations are routed via ftrace_caller(). This will need
> -		 * to be revisited if support for multiple ftrace entry points
> -		 * is added in the future, but for now, the pr_err() below
> -		 * deals with a theoretical issue only.
> -		 */
> -		trampoline = get_plt_entry(addr, mod->arch.ftrace_trampoline);
> -		if (!plt_entries_equal(mod->arch.ftrace_trampoline,
> -				       &trampoline)) {
> -			if (!plt_entries_equal(mod->arch.ftrace_trampoline,
> -					       &(struct plt_entry){})) {
> -				pr_err("ftrace: far branches to multiple entry points unsupported inside a single module\n");
> -				return -EINVAL;
> -			}
> -
> -			/* point the trampoline to our ftrace entry point */
> -			module_disable_ro(mod);
> -			*mod->arch.ftrace_trampoline = trampoline;
> -			module_enable_ro(mod, true);
> -
> -			/* update trampoline before patching in the branch */
> -			smp_wmb();
> +		/* Check against our well-known list of ftrace entry points */
> +		if (addr == FTRACE_ADDR || addr == FTRACE_REGS_ADDR) {
> +			ret = install_ftrace_trampoline(mod, &addr);
> +			if (ret < 0)
> +				return ret;
>  		}
> -		addr = (unsigned long)(void *)mod->arch.ftrace_trampoline;
> +		else
> +			return -EINVAL;
> +
>  #else /* CONFIG_ARM64_MODULE_PLTS */
>  		return -EINVAL;
>  #endif /* CONFIG_ARM64_MODULE_PLTS */
>  	}
>  
>  	old = aarch64_insn_gen_nop();
> +	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS)) {
> +		new = QUICK_LR_SAVE;
> +		ret = ftrace_modify_code(pc - AARCH64_INSN_SIZE,
> +					 old, new, true);
> +		if (ret)
> +			return ret;
> +	}
>  	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
>  
>  	return ftrace_modify_code(pc, old, new, true);
>  }
>  
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
> +			unsigned long addr)
> +{
> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
> +	u32 old, new;
> +
> +	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
> +	new = aarch64_insn_gen_branch_imm(pc, addr, true);
> +
> +	return ftrace_modify_code(pc, old, new, true);
> +}
> +#endif
> +
>  /*
>   * Turn off the call to ftrace_caller() in instrumented function
>   */
>  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>  		    unsigned long addr)
>  {
> -	unsigned long pc = rec->ip;
> +	unsigned long pc = rec->ip + REC_IP_BRANCH_OFFSET;
>  	bool validate = true;
> +	int ret;
>  	u32 old = 0, new;
>  	long offset = (long)pc - (long)addr;
>  
> +	/* -fpatchable-function-entry= does not generate a profiling call
> +	 *  initially; the NOPs are already there.
> +	 */

Nit: comment style violation.

> +	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS) && addr == MCOUNT_ADDR)
> +		return 0;
> +
>  	if (offset < -SZ_128M || offset >= SZ_128M) {
>  #ifdef CONFIG_ARM64_MODULE_PLTS
>  		u32 replaced;
> @@ -188,7 +247,15 @@ int ftrace_make_nop(struct module *mod,
>  
>  	new = aarch64_insn_gen_nop();
>  
> -	return ftrace_modify_code(pc, old, new, validate);
> +	ret = ftrace_modify_code(pc, old, new, validate);
> +	if (ret)
> +		return ret;
> +	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS)) {
> +		old = QUICK_LR_SAVE;
> +		ret = ftrace_modify_code(pc - AARCH64_INSN_SIZE,
> +					 old, new, true);
> +	}
> +	return ret;
>  }
>  
>  void arch_ftrace_update_code(int command)
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -113,6 +113,7 @@
>  #define MCOUNT_REC()	. = ALIGN(8);				\
>  			__start_mcount_loc = .;			\
>  			KEEP(*(__mcount_loc))			\
> +			KEEP(*(__patchable_function_entries))	\
>  			__stop_mcount_loc = .;
>  #else
>  #define MCOUNT_REC()
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -113,8 +113,12 @@ struct ftrace_likely_data {
>  #if defined(CC_USING_HOTPATCH)
>  #define notrace			__attribute__((hotpatch(0, 0)))
>  #else
> +#if defined(CONFIG_ARM64) && defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
> +#define notrace __attribute__((patchable_function_entry(0)))
> +#else
>  #define notrace			__attribute__((__no_instrument_function__))
>  #endif
> +#endif

Please don't make this specific to arm64.

In a preparatory patch, add something like CC_USING_PATCHABLE_FENTRY,
and have:

#if defined(CC_USING_HOTPATCH)
#define notrace			__attribute__((hotpatch(0, 0)))
#elif defined(CC_USING_PATCHABLE_FENTRY)
#define notrace			__attribute__((patchable_function_entry(0)))
#else
#define notrace			__attribute__((__no_instrument_function__))
#endif

... then you can have arm64 define CC_USING_HOTPATCH when that's in use.
Any other architecture that ends up using patchable_function_entry can
do the same thing.

>  
>  /*
>   * it doesn't make sense on ARM (currently the only user of __naked)
> --- a/arch/arm64/include/asm/module.h
> +++ b/arch/arm64/include/asm/module.h
> @@ -32,7 +32,8 @@ struct mod_arch_specific {
>  	struct mod_plt_sec	init;
>  
>  	/* for CONFIG_DYNAMIC_FTRACE */
> -	struct plt_entry 	*ftrace_trampoline;
> +	struct plt_entry 	*ftrace_trampolines;
> +#define MOD_ARCH_NR_FTRACE_TRAMPOLINES	2
>  };
>  #endif
>  
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -451,7 +451,7 @@ int module_finalize(const Elf_Ehdr *hdr,
>  #ifdef CONFIG_ARM64_MODULE_PLTS
>  		if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
>  		    !strcmp(".text.ftrace_trampoline", secstrs + s->sh_name))
> -			me->arch.ftrace_trampoline = (void *)s->sh_addr;
> +			me->arch.ftrace_trampolines = (void *)s->sh_addr;
>  #endif
>  	}
>  
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -323,7 +323,8 @@ int module_frob_arch_sections(Elf_Ehdr *
>  		tramp->sh_type = SHT_NOBITS;
>  		tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
>  		tramp->sh_addralign = __alignof__(struct plt_entry);
> -		tramp->sh_size = sizeof(struct plt_entry);
> +		tramp->sh_size = MOD_ARCH_NR_FTRACE_TRAMPOLINES
> +				 * sizeof(struct plt_entry);
>  	}
>  
>  	return 0;
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -159,6 +159,7 @@
>  /*
>   * Register aliases.
>   */
> +fp	.req	x29		// frame pointer

As above, please use 'x29' consistently, and don't bother adding this
alias.

Thanks,
Mark.
