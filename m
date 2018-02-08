Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeBHUcK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:32:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33242 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752179AbeBHUcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:32:08 -0500
Date: Thu, 8 Feb 2018 21:31:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Message-ID: <20180208203146.GF577@pd.tnic>
References: <20180207184933.GA25201@hirez.programming.kicks-ass.net>
 <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
 <20180207191451.GC25201@hirez.programming.kicks-ass.net>
 <20180207192816.GA19536@pd.tnic>
 <CA+55aFzSZzdVZXatze=xjGSwpOPO7kvbWnz7JiZ3sTx_2Pohjw@mail.gmail.com>
 <20180208091302.GD25201@hirez.programming.kicks-ass.net>
 <CA+55aFySLxYkUQyNf5YcEvitjm2O1whEp4-iKNASPaOpxG1j9w@mail.gmail.com>
 <20180208180357.GC25181@hirez.programming.kicks-ass.net>
 <CA+55aFx7=cw0myoidwzhEfKd_L2Q6u0=AdcH_ZBmXu2_nD=4Jw@mail.gmail.com>
 <20180208194406.GD25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180208194406.GD25181@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 08:44:06PM +0100, Peter Zijlstra wrote:
>  /*
> - * Since some emulators terminate on UD2, we cannot use it for WARN.
> - * Since various instruction decoders disagree on the length of UD1,
> - * we cannot use it either. So use UD0 for WARN.
> + * Despite that some emulators terminate on UD2, we use it for WARN.
>   *
> - * (binutils knows about "ud1" but {en,de}codes it as 2 bytes, whereas
> - *  our kernel decoder thinks it takes a ModRM byte, which seems consistent
> - *  with various things like the Intel SDM instruction encoding rules)
> + * Since various instruction decoders/specs disagree on the encoding of
> + * UD0/UD1,
	     ^

Does that comma mean the sentence continues somewhere?

>   */
>  
> -#define ASM_UD0		".byte 0x0f, 0xff"
> +#define ASM_UD0		".byte 0x0f, 0xff" /* + ModRM (for Intel) */



>  #define ASM_UD1		".byte 0x0f, 0xb9" /* + ModRM */
>  #define ASM_UD2		".byte 0x0f, 0x0b"
>  
>  #define INSN_UD0	0xff0f
>  #define INSN_UD2	0x0b0f
>  
> -#define LEN_UD0		2
> +#define LEN_UD2		2
>  
>  #ifdef CONFIG_GENERIC_BUG
>  
> @@ -77,7 +74,7 @@ do {								\
>  	unreachable();						\
>  } while (0)
>  
> -#define __WARN_FLAGS(flags)	_BUG_FLAGS(ASM_UD0, BUGFLAG_WARNING|(flags))
> +#define __WARN_FLAGS(flags)	_BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags))
>  
>  #include <asm-generic/bug.h>
>  
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 446c9ef8cfc3..3d9b2308e7fa 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -181,7 +181,7 @@ int fixup_bug(struct pt_regs *regs, int trapnr)
>  		break;
>  
>  	case BUG_TRAP_TYPE_WARN:
> -		regs->ip += LEN_UD0;
> +		regs->ip += LEN_UD2;
>  		return 1;

So patch looks ok but it broke objtool:

init/main.o: warning: objtool: do_one_initcall()+0x13b: unreachable instruction
/bin/sh: line 1: 25800 Segmentation fault      ./tools/objtool/objtool orc generate --no-fp "arch/x86/kernel/process_64.o"
make[2]: *** [arch/x86/kernel/process_64.o] Error 139
make[1]: *** [arch/x86/kernel] Error 2
make[1]: *** Waiting for unfinished jobs....
arch/x86/entry/common.o: warning: objtool: prepare_exit_to_usermode()+0x7b: unreachable instruction
arch/x86/events/core.o: warning: objtool: perf_assign_events()+0x24e: unreachable instruction
kernel/fork.o: warning: objtool: free_task()+0x4b: unreachable instruction
arch/x86/events/amd/core.o: warning: objtool: amd_pmu_cpu_starting()+0xcc: unreachable instruction
arch/x86/events/amd/ibs.o: warning: objtool: perf_ibs_start()+0x10e: unreachable instruction
arch/x86/events/amd/iommu.o: warning: objtool: perf_iommu_start()+0x1c0: unreachable instruction
arch/x86/events/amd/power.o: warning: objtool: __pmu_event_start()+0x8e: unreachable instruction
...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
