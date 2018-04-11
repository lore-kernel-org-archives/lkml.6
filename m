Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755248AbeDKVWI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 17:22:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754281AbeDKSjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 14:39:06 -0400
Date: Wed, 11 Apr 2018 15:39:02 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Yonghong Song <yhs@fb.com>
Cc: Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        acme@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bpf: handling non BPF register names in inline assembly with
 -target bpf
Message-ID: <20180411183902.GC12166@redhat.com>
References: <c8b0b3c0-6687-1be2-66d0-95b20662145d@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8b0b3c0-6687-1be2-66d0-95b20662145d@fb.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 11, 2018 at 09:37:46AM -0700, Yonghong Song escreveu:
> Hi, Arnaldo,
 
> When I studied the bpf compilation issue with latest linus/net-next
> kernel (https://patchwork.kernel.org/patch/10333829/), an alternative
> approach I tried is to use __BPF__ macro.

You mean you used an alternative approach that does _not_ use the
__BPF__ macro, right? I looked at the patch and yeah, looks sane as
well, since the kernel build process already defines that
CC_HAVE_ASM_GOTO, checking if gcc has that feature, etc.

> The following patch introduced "#ifndef __BPF__" in
> arch/x86/include/asm/asm.h for some inline assembly related to x86
> "esp" register name.
 

> ==========
>  commit ca26cffa4e4aaeb09bb9e308f95c7835cb149248
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Mon Dec 4 13:08:47 2017 -0300
> 
>     x86/asm: Allow again using asm.h when building for the 'bpf'
> clang target
> 
>     Up to f5caf621ee35 ("x86/asm: Fix inline asm call constraints
> for Clang")
>     we were able to use x86 headers to build to the 'bpf' clang target, as
>     done by the BPF code in tools/perf/.
>  ...
> diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
> index 219faae..386a690 100644
> --- a/arch/x86/include/asm/asm.h
> +++ b/arch/x86/include/asm/asm.h
> @@ -136,6 +136,7 @@
>  #endif
> 
>  #ifndef __ASSEMBLY__
> +#ifndef __BPF__
>  /*
>   * This output constraint should be used for any inline asm which
> has a "call"
>   * instruction.  Otherwise the asm may be inserted before the frame
> pointer
> @@ -145,5 +146,6 @@
>  register unsigned long current_stack_pointer asm(_ASM_SP);
>  #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
>  #endif
> +#endif
> ...
> ==========
> 
> I just landed a clang patch (clang 7.0.0 trunk)
> https://reviews.llvm.org/rL329823
> which will permit bpf clang target to accept ANY register
> names. In this case, the inline assembly will be accepted by clang
> and will be thrown away since variable current_stack_pointer is
> not used in bpf programs.

Ok, then that ifndef __BPF__ above will not be needed anymore, but only
people with clang > that version will be able to build tools/perf/
 
> If the inline assembly is indeed for BPF program, later llc
> AsmParser will do syntax and semantics checking again.
> 
> With the above clang patch, the above "#ifndef __BPF__" can be removed.
> You can decide when is the appropriate time to use latest clang compiler
> and remove the above "#ifndef __BPF__".

So are you proposing that we have something similar to that
CC_HAVE_ASM_GOTO check in the kernel main Makefile, to define something
like CC_HAVE_ASM_REGS (or some better name), i.e. something like:

# check for 'asm(_ASM_SP)'
ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/cc-asm-regs.sh
$(CC) $(KBUILD_CFLAGS)), y)
  CC_HAVE_ASM_REGS := 1
  KBUILD_CFLAGS += -DCC_HAVE_ASM_REGS
  KBUILD_AFLAGS += -DCC_HAVE_ASM_REGS
endif

?

- Arnaldo
