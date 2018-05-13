Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeEMSCf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 14:02:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50765 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeEMSCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 14:02:34 -0400
Date: Sun, 13 May 2018 20:02:09 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf v3] x86/cpufeature: bpf hack for clang not supporting
 asm goto
In-Reply-To: <20180513174348.eoh2lrhzqbmqb5nc@ast-mbp>
Message-ID: <alpine.DEB.2.21.1805131953410.1582@nanos.tec.linutronix.de>
References: <CAADnVQKVEmD4RrcTAiuMn-uua5TP0N-buvRHXq6Mgp1ZeF=G_Q@mail.gmail.com> <alpine.DEB.2.21.1805122110230.1582@nanos.tec.linutronix.de> <20180513174348.eoh2lrhzqbmqb5nc@ast-mbp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 May 2018, Alexei Starovoitov wrote:
> On Sat, May 12, 2018 at 10:30:02PM +0200, Thomas Gleixner wrote:
> > But yes, the situation is slightly different here because tools which
> > create trace event magic _HAVE_ to pull in kernel headers. At the same time
> > these tools depend on a compiler which failed to implement asm_goto for
> > fricking 8 years.
> 
> As a maintainer of a piece of llvm codebase I have to say that
> this bullying tactic has the opposite effect.

I'm not bullying at all. Its a fact that the discussion about asm goto is
dragging out 8 years now. We've stayed away from mandating it for quite
some time, but at some point it just doesn't make sense anymore.

> The inline asm is processed by gcc and llvm very differently.  gcc is
> leaking internal backend implementation details into inline asm
> syntax. It makes little sense for llvm to do the same, since compiler
> codegen is completely different. gcc doesn't have integrated assembler
> whereas llvm not only can parse asm, but can potentially optimize it as
> well.  Instead of demanding asm-goto that matches gcc one to one it's
> better to work with the community to define the syntax that works for
> both kernel and llvm.

Come on, we surely are open for discussions, but what I've seen so far is
just 'oh we can't do this because' instead of a sane proposal how it can be
done w/o rewriting the whole ASM GOTO stuff in the kernel or even
duplicating it.

> > + * Workaround for the sake of BPF compilation which utilizes kernel
> > + * headers, but clang does not support ASM GOTO and fails the build.
> > + */
> > +#ifndef __BPF__
> > +#warning "Compiler lacks ASM_GOTO support. Add -D __BPF__ to your compiler arguments"
> > +#endif
> 
> Agree.
> The warning makes sense to me, but it has to be different macro name.
> How about -D__BPF_TRACING__ or -D__BPF_KPROBES__ or something similar ?

Fair enough.

> Such name will also make it clear that only tracing bpf programs
> need this. Networking programs shouldn't be including kernel headers.
> There was never a need, but since the tracing progs are often used
> as an example people copy paste makefiles too.
> We tried to document it as much as possible, but people still use
> 'clang -target native -I/kernel/includes bpf_prog.c -emit-llvm | llc -march=bpf'
> in their builds.
> (sometimes as a workaround for setups where clang is older version,
> but llc/llvm is new)
> Now they will see this warning and it will force them to think whether
> they actually need the kernel headers.

Makes sense.

> > +
> > +#define static_cpu_has(bit)		boot_cpu_has(bit)
> > +
> > +#else
> > +
> >  /*
> >   * Static testing of CPU features.  Used the same as boot_cpu_has().
> >   * These will statically patch the target code for additional
> > @@ -195,6 +209,7 @@ static __always_inline __pure bool _stat
> >  		boot_cpu_has(bit) :				\
> >  		_static_cpu_has(bit)				\
> >  )
> > +#endif
> >  
> >  #define cpu_has_bug(c, bit)		cpu_has(c, (bit))
> >  #define set_cpu_bug(c, bit)		set_cpu_cap(c, (bit))
> > --- a/samples/bpf/Makefile
> > +++ b/samples/bpf/Makefile
> > @@ -255,7 +255,7 @@ verify_target_bpf: verify_cmds
> >  $(obj)/%.o: $(src)/%.c
> >  	$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) -I$(obj) \
> >  		-I$(srctree)/tools/testing/selftests/bpf/ \
> > -		-D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
> > +		-D__KERNEL__ -D__BPF__ -Wno-unused-value -Wno-pointer-sign \
> 
> Yep. In samples/bpf and libbcc we can selectively add -D__BPF_TRACING__
> I think sysdig and other folks can live with that as well.
> Agree?

Sure. Care to send an updated patch?

Thanks,

	tglx
