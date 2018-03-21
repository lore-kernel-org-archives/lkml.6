Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeCUHqn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:46:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54771 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeCUHqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:46:39 -0400
X-Google-Smtp-Source: AG47ELtmeRWIfPYhNbMyHpy+Ga3ydYW/BoK1R9/SJeQaGeSuNiBljW7BWskHkVHdv0J/5yvmfGE6GQ==
Date: Wed, 21 Mar 2018 08:46:34 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        David Laight <David.Laight@aculab.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>,
        "indranil@chelsio.com" <indranil@chelsio.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Fenghua Yu <fenghua.yu@intel.com>, Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Message-ID: <20180321074634.dzpyjz3ia46snodh@gmail.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
 <CA+55aFybTvLz47mw=AG21jCJv_hE2vaVyiJP_F-4vAD-3Gnc7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFybTvLz47mw=AG21jCJv_hE2vaVyiJP_F-4vAD-3Gnc7Q@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


So I poked around a bit and I'm having second thoughts:

* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Mar 20, 2018 at 1:26 AM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > So assuming the target driver will only load on modern FPUs I *think* it should
> > actually be possible to do something like (pseudocode):
> >
> >         vmovdqa %ymm0, 40(%rsp)
> >         vmovdqa %ymm1, 80(%rsp)
> >
> >         ...
> >         # use ymm0 and ymm1
> >         ...
> >
> >         vmovdqa 80(%rsp), %ymm1
> >         vmovdqa 40(%rsp), %ymm0
> >
> > ... without using the heavy XSAVE/XRSTOR instructions.
> 
> No. The above is buggy. It may *work*, but it won't work in the long run.
> 
> Pretty much every single vector extension has traditionally meant that
> touching "old" registers breaks any new register use. Even if you save
> the registers carefully like in your example code, it will do magic
> and random things to the "future extended" version.

This should be relatively straightforward to solve via a proper CPU features 
check: for example by only patching in the AVX routines for 'known compatible' 
fpu_kernel_xstate_size values. Future extensions of register width will extend
the XSAVE area.

It's not fool-proof: in theory there could be semantic extensions to the vector 
unit that does not increase the size of the context - but the normal pattern is to 
increase the number of XINUSE bits and bump up the maximum context area size.

If that's a worry then an even safer compatibility check would be to explicitly 
list CPU models - we do track them pretty accurately anyway these days, mostly due 
to perf PMU support defaulting to a safe but dumb variant if a CPU model is not 
specifically listed.

That method, although more maintenance-intense, should be pretty fool-proof 
AFAICS.

> So I absolutely *refuse* to have anything to do with the vector unit.
> You can only touch it in the kernel if you own it entirely (ie that
> "kernel_fpu_begin()/_end()" thing). Anything else is absolutely
> guaranteed to cause problems down the line.
> 
> And even if you ignore that "maintenance problems down the line" issue
> ("we can fix them when they happen") I don't want to see games like
> this, because I'm pretty sure it breaks the optimized xsave by tagging
> the state as being dirty.

So I added a bit of instrumentation and the current state of things is that on 
64-bit x86 every single task has an initialized FPU, every task has the exact 
same, fully filled in xfeatures (XINUSE) value:

 [root@galatea ~]# grep -h fpu /proc/*/task/*/fpu | sort | uniq -c
    504 x86/fpu: initialized                             :                    1
    504 x86/fpu: xfeatures_mask                          :                    7

So our latest FPU model is *really* simple and user-space should not be able to 
observe any changes in the XINUSE bits of the XSAVE header, because (at least for 
the basic vector CPU features) all bits are maxed out all the time.

Note that this is with an AVX (128-bit) supporting CPU:

[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.

But note that it probably wouldn't make sense to make use of XINUSE optimizations 
on most systems for the AVX space, as glibc will use the highest-bitness vector 
ops for its regular memcpy(), and every user task makes use of memcpy.

It does make sense for some of the more optional XSAVE based features such as 
pkeys. But I don't have any newer Intel system with a wider xsave feature set to 
check.

> So no. Don't use vector stuff in the kernel. It's not worth the pain.

That might still be true, but still I'm torn:

 - Broad areas of user-space has seemlessly integrated vector ops and is using 
   them all the time they can find an excuse to use them.

 - The vector registers are fundamentally callee-saved, so in most synchronous 
   calls the vector unit registers are unused. Asynchronous interruptions of 
   context (interrupts, faults, preemption, etc.) can still use them as well, as 
   long as they save/restore register contents.

So other than Intel not making it particularly easy to make a forwards compatible 
vector register granular save/restore pattern (but see above for how we could 
handle that) for asynchronous contexts, I don't see too many other complications.

Thanks,

	Ingo
