Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeELUa3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 16:30:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47567 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeELUa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 16:30:27 -0400
Date: Sat, 12 May 2018 22:30:02 +0200 (CEST)
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
In-Reply-To: <CAADnVQKVEmD4RrcTAiuMn-uua5TP0N-buvRHXq6Mgp1ZeF=G_Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1805122110230.1582@nanos.tec.linutronix.de>
References: <CAADnVQKVEmD4RrcTAiuMn-uua5TP0N-buvRHXq6Mgp1ZeF=G_Q@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 May 2018, Alexei Starovoitov wrote:
> On Thu, May 10, 2018 at 10:58 AM, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > I see no option, but to fix the kernel.
> > Regardless whether it's called user space breakage or kernel breakage.

There is a big difference. If you are abusing a kernel internal header in a
user space tool, then there is absolutely ZERO excuse for requesting that
the header in question has to be modified.

But yes, the situation is slightly different here because tools which
create trace event magic _HAVE_ to pull in kernel headers. At the same time
these tools depend on a compiler which failed to implement asm_goto for
fricking 8 years.

So while Boris is right, that nothing has to fiddle with a kernel only
header, I grumpily agree with you that we need a workaround in the kernel
for this particular issue.

> could you please ack the patch or better yet take it into tip tree
> and send to Linus asap ?

Nope. The patch is a horrible hack.

Why the heck do we need that extra fugly define? That has exactly zero
value simply because we already have a define which denotes availablity of
ASM GOTO: CC_HAVE_ASM_GOTO.

In case of samples/bpf/ and libbcc the compile does not go through the
arch/x86 Makefile which stops the build anyway when ASM_GOTO is
missing. Those builds merily pull in the headers and have their own build
magic, which is broken btw: Changing a kernel header which gets pulled into
the build does not rebuild anything in samples/bpf. Qualitee..

So we can just use CC_HAVE_ASM_GOTO and be done with it.

But we also want the tools which needs this to be aware of this. Peter
requested -D __BPF__ several times which got ignored. It's not too much of
a request to add that.

Find a patch which deos exactly this for samples/bpf, but also allows other
tools to build with a warning emitted so they get fixed.

Thanks,

	tglx

8<----------------
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -140,6 +140,20 @@ extern void clear_cpu_cap(struct cpuinfo
 
 #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
 
+#ifndef CC_HAVE_ASM_GOTO
+
+/*
+ * Workaround for the sake of BPF compilation which utilizes kernel
+ * headers, but clang does not support ASM GOTO and fails the build.
+ */
+#ifndef __BPF__
+#warning "Compiler lacks ASM_GOTO support. Add -D __BPF__ to your compiler arguments"
+#endif
+
+#define static_cpu_has(bit)		boot_cpu_has(bit)
+
+#else
+
 /*
  * Static testing of CPU features.  Used the same as boot_cpu_has().
  * These will statically patch the target code for additional
@@ -195,6 +209,7 @@ static __always_inline __pure bool _stat
 		boot_cpu_has(bit) :				\
 		_static_cpu_has(bit)				\
 )
+#endif
 
 #define cpu_has_bug(c, bit)		cpu_has(c, (bit))
 #define set_cpu_bug(c, bit)		set_cpu_cap(c, (bit))
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -255,7 +255,7 @@ verify_target_bpf: verify_cmds
 $(obj)/%.o: $(src)/%.c
 	$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) -I$(obj) \
 		-I$(srctree)/tools/testing/selftests/bpf/ \
-		-D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
+		-D__KERNEL__ -D__BPF__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(ARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
 		-Wno-address-of-packed-member -Wno-tautological-compare \
