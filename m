Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeEMRn4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 13:43:56 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38862 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeEMRny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 13:43:54 -0400
X-Google-Smtp-Source: AB8JxZpoS1kGbsXSrncv+BVq/sBeHvQCUY9zBirF1zcitylF5gEdodvR1XqSvTEdsB5J15SMNGqBkQ==
Date: Sun, 13 May 2018 10:43:50 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf v3] x86/cpufeature: bpf hack for clang not supporting
 asm goto
Message-ID: <20180513174348.eoh2lrhzqbmqb5nc@ast-mbp>
References: <CAADnVQKVEmD4RrcTAiuMn-uua5TP0N-buvRHXq6Mgp1ZeF=G_Q@mail.gmail.com>
 <alpine.DEB.2.21.1805122110230.1582@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1805122110230.1582@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 10:30:02PM +0200, Thomas Gleixner wrote:
> On Sat, 12 May 2018, Alexei Starovoitov wrote:
> > On Thu, May 10, 2018 at 10:58 AM, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > I see no option, but to fix the kernel.
> > > Regardless whether it's called user space breakage or kernel breakage.
> 
> There is a big difference. If you are abusing a kernel internal header in a
> user space tool, then there is absolutely ZERO excuse for requesting that
> the header in question has to be modified.
> 
> But yes, the situation is slightly different here because tools which
> create trace event magic _HAVE_ to pull in kernel headers. At the same time
> these tools depend on a compiler which failed to implement asm_goto for
> fricking 8 years.

As a maintainer of a piece of llvm codebase I have to say that
this bullying tactic has the opposite effect.
The inline asm is processed by gcc and llvm very differently.
gcc is leaking internal backend implementation details into inline asm
syntax. It makes little sense for llvm to do the same, since compiler
codegen is completely different. gcc doesn't have integrated assembler
whereas llvm not only can parse asm, but can potentially optimize it as well.
Instead of demanding asm-goto that matches gcc one to one it's better
to work with the community to define the syntax that works for both
kernel and llvm.

> So while Boris is right, that nothing has to fiddle with a kernel only
> header, I grumpily agree with you that we need a workaround in the kernel
> for this particular issue.
> 
> > could you please ack the patch or better yet take it into tip tree
> > and send to Linus asap ?
> 
> Nope. The patch is a horrible hack.
> 
> Why the heck do we need that extra fugly define? That has exactly zero
> value simply because we already have a define which denotes availablity of
> ASM GOTO: CC_HAVE_ASM_GOTO.

I agree. That's why the v1 patch that was using CC_HAVE_ASM_GOTO was better:
https://patchwork.kernel.org/patch/10333829/
I'm fine on adding a warning to it though.

> In case of samples/bpf/ and libbcc the compile does not go through the
> arch/x86 Makefile which stops the build anyway when ASM_GOTO is
> missing. Those builds merily pull in the headers and have their own build
> magic, which is broken btw: Changing a kernel header which gets pulled into
> the build does not rebuild anything in samples/bpf. Qualitee..
> 
> So we can just use CC_HAVE_ASM_GOTO and be done with it.
> 
> But we also want the tools which needs this to be aware of this. Peter
> requested -D __BPF__ several times which got ignored. It's not too much of
> a request to add that.

quite the opposite.
It was explained already why -D__BPF__ makes little sense.
It's like saying that -D__arm__ has to be specified in command line.

clang automatically adds -D__arm__ when '-target arm' is used
and adds -D__BPF__ when '-target bpf' is used.
For samples/bpf, libbcc and other cases we have to use -target native.
If we do '-target native -D__BPF__' that's just like trying to compile
kernel headers with '-target x86 -D__arm__'. Absurd.

> Find a patch which deos exactly this for samples/bpf, but also allows other
> tools to build with a warning emitted so they get fixed.

agree

> Thanks,
> 
> 	tglx
> 
> 8<----------------
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -140,6 +140,20 @@ extern void clear_cpu_cap(struct cpuinfo
>  
>  #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
>  
> +#ifndef CC_HAVE_ASM_GOTO
> +
> +/*
> + * Workaround for the sake of BPF compilation which utilizes kernel
> + * headers, but clang does not support ASM GOTO and fails the build.
> + */
> +#ifndef __BPF__
> +#warning "Compiler lacks ASM_GOTO support. Add -D __BPF__ to your compiler arguments"
> +#endif

Agree.
The warning makes sense to me, but it has to be different macro name.
How about -D__BPF_TRACING__ or -D__BPF_KPROBES__ or something similar ?
Such name will also make it clear that only tracing bpf programs
need this. Networking programs shouldn't be including kernel headers.
There was never a need, but since the tracing progs are often used
as an example people copy paste makefiles too.
We tried to document it as much as possible, but people still use
'clang -target native -I/kernel/includes bpf_prog.c -emit-llvm | llc -march=bpf'
in their builds.
(sometimes as a workaround for setups where clang is older version,
but llc/llvm is new)
Now they will see this warning and it will force them to think whether
they actually need the kernel headers.

> +
> +#define static_cpu_has(bit)		boot_cpu_has(bit)
> +
> +#else
> +
>  /*
>   * Static testing of CPU features.  Used the same as boot_cpu_has().
>   * These will statically patch the target code for additional
> @@ -195,6 +209,7 @@ static __always_inline __pure bool _stat
>  		boot_cpu_has(bit) :				\
>  		_static_cpu_has(bit)				\
>  )
> +#endif
>  
>  #define cpu_has_bug(c, bit)		cpu_has(c, (bit))
>  #define set_cpu_bug(c, bit)		set_cpu_cap(c, (bit))
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -255,7 +255,7 @@ verify_target_bpf: verify_cmds
>  $(obj)/%.o: $(src)/%.c
>  	$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) -I$(obj) \
>  		-I$(srctree)/tools/testing/selftests/bpf/ \
> -		-D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
> +		-D__KERNEL__ -D__BPF__ -Wno-unused-value -Wno-pointer-sign \

Yep. In samples/bpf and libbcc we can selectively add -D__BPF_TRACING__
I think sysdig and other folks can live with that as well.
Agree?
