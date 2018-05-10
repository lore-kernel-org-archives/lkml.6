Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934803AbeEJKGw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:06:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41308 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753944AbeEJKGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:06:50 -0400
Date: Thu, 10 May 2018 12:06:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yonghong Song <yhs@fb.com>
Cc: mingo@kernel.org, torvalds@linux-foundation.org, ast@fb.com,
        daniel@iogearbox.net, linux-kernel@vger.kernel.org, x86@kernel.org,
        netdev@vger.kernel.org, kernel-team@fb.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH bpf v3] x86/cpufeature: bpf hack for clang not supporting
 asm goto
Message-ID: <20180510100634.GZ12217@hirez.programming.kicks-ass.net>
References: <20180504033119.2130788-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504033119.2130788-1-yhs@fb.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 08:31:19PM -0700, Yonghong Song wrote:

> This approach is preferred since the already deployed bcc scripts, or
> any other bpf applicaitons utilizing LLVM JIT compilation functionality,
> will continue work with the new kernel without re-compilation and
> re-deployment.

So I really hate this and would much rather see the BPF build
environment changed. It not consistenyly having __BPF__ defined really
smells like a bug on your end.

Sometimes you just need to update tools... Is it really too hard to do
-D__BPF__ in the bpf build process that we need to mollest the kernel
for it?

> Note that this is a hack in the kernel to workaround bpf compilation issue.
> The hack will be removed once clang starts to support asm goto.

Note that that ^^ already mandates people re-deploy their bpf tools, so
why is llvm supporting asm-goto a better point to re-deploy than fixing
a consistent __BPF__ define for the bpf build environment?

> diff --git a/Makefile b/Makefile
> index 83b6c54..cfd8759 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -504,6 +504,7 @@ export RETPOLINE_CFLAGS
>  ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
>    CC_HAVE_ASM_GOTO := 1
>    KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
> +  KBUILD_CFLAGS += -D__NO_CLANG_BPF_HACK
>    KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
>  endif

I really think this is the wrong thing to do; but if the x86 maintainers
are willing to take this, I'll grudingly shut up.

Ingo, Thomas?

> diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
> index b27da96..42edd5d 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -140,6 +140,8 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
>  
>  #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
>  
> +/* this macro is a temporary hack for bpf until clang gains asm-goto support */
> +#ifdef __NO_CLANG_BPF_HACK
>  /*
>   * Static testing of CPU features.  Used the same as boot_cpu_has().
>   * These will statically patch the target code for additional
> @@ -195,6 +197,9 @@ static __always_inline __pure bool _static_cpu_has(u16 bit)
>  		boot_cpu_has(bit) :				\
>  		_static_cpu_has(bit)				\
>  )
> +#else
> +#define static_cpu_has(bit)		boot_cpu_has(bit)
> +#endif
>  
>  #define cpu_has_bug(c, bit)		cpu_has(c, (bit))
>  #define set_cpu_bug(c, bit)		set_cpu_cap(c, (bit))
> -- 
> 2.9.5
> 
