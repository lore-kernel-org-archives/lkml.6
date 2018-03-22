Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeCVJdw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:33:52 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:45400 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbeCVJds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:33:48 -0400
X-Google-Smtp-Source: AG47ELtBIBLLW6Z5501dp1HNl5mUGHnjan6I9r9PtN4giQFLTQ3n6Eot0NK+HfTFR6PhewNKb1gW5Q==
Date: Thu, 22 Mar 2018 10:33:43 +0100
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
Message-ID: <20180322093343.aatl3prhheha4dlm@gmail.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
 <CA+55aFybTvLz47mw=AG21jCJv_hE2vaVyiJP_F-4vAD-3Gnc7Q@mail.gmail.com>
 <20180321074634.dzpyjz3ia46snodh@gmail.com>
 <CA+55aFyK6uJopBjZGyeDz0O+qzCac6AwPkJyOpuaT69inPgVgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyK6uJopBjZGyeDz0O+qzCac6AwPkJyOpuaT69inPgVgw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And the real worry is things like AVX-512 etc, which is exactly when
> things like "save and restore one ymm register" will quite likely
> clear the upper bits of the zmm register.

Yeah, I think the only valid save/restore pattern is to 100% correctly enumerate 
the width of the vector registers, and use full width instructions.

Using partial registers, even though it's possible in some cases is probably a bad 
idea not just due to most instructions auto-zeroing the upper portion to reduce 
false dependencies, but also because 'mixed' use of partial and full register 
access is known to result in penalties on a wide range of Intel CPUs, at least 
according to the Agner PDFs. On AMD CPUs there's no penalty.

So what I think could be done at best is to define a full register save/restore 
API, which falls back to XSAVE*/XRSTOR* if we don't have the routines for the 
native vector register width. (I.e. if old kernel is used on very new CPU.)

Note that the actual AVX code could still use partial width, it's the save/restore 
primitives that has to handle full width registers.

> And yes, we can have some statically patched code that takes that into account, 
> and saves the whole zmm register when AVX512 is on, but the whole *point* of the 
> dynamic XSAVES thing is actually that Intel wants to be able enable new 
> user-space features without having to wait for OS support. Literally. That's why 
> and how it was designed.

This aspect wouldn't be hurt AFAICS: to me it appears that due to glibc using 
vector instructions in its memset() the AVX bits get used early on and to the 
maximum, so the XINUSE for them is set for every task.

The optionality of other XSAVE based features like MPX wouldn't be hurt if the 
kernel only uses vector registers.

> And saving a couple of zmm registers is actually pretty hard. They're big. Do 
> you want to allocate 128 bytes of stack space, preferably 64-byte aligned, for a 
> save area? No. So now it needs to be some kind of per-thread (or maybe per-CPU, 
> if we're willing to continue to not preempt) special save area too.

Hm, that's indeed a nasty complication:

 - While a single 128 bytes slot might work - in practice at least two vector
   registers are needed to have enough parallelism and hide latencies.

 - &current->thread.fpu.state.xsave is available almost all the time: with our 
   current 'direct' FPU context switching code the only time there's live data in
   &current->thread.fpu is when the task is not running. But it's not IRQ-safe.

We could probably allow irq save/restore sections to use it, as 
local_irq_save()/restore() is still *much* faster than a 1-1.5K FPU context 
save/restore pattern.

But I was hoping for a less restrictive model ... :-/

To have a better model and avoid the local_irq_save()/restore we could perhaps 
change the IRQ model to have a per IRQ 'current' value (we have separate IRQ 
stacks already), but that's quite a bit of work to transform all code that 
operates on the interrupted task (scheduler and timer code).

But it's work that would be useful for other reasons as well.

With such a separation in place &current->thread.fpu.state.xsave would become a 
generic, natural vector register save area.

> And even then, it doesn't solve the real worry of "maybe there will be odd 
> interactions with future extensions that we don't even know of".

Yes, that's true, but I think we could avoid these dangers by using CPU model 
based enumeration. The cost would be that vector ops would only be available on 
new CPU models after an explicit opt-in. In many cases it will be a single new 
constant to an existing switch() statement, easily backported as well.

> All this to do a 32-byte PIO access, with absolutely zero data right
> now on what the win is?

Ok, so that's not what I'd use it for, I'd use it:

 - Speed up existing AVX (crypto, RAID) routines for smaller buffer sizes.
   Right now the XSAVE*+XRSTOR* cost is significant:

     x86/fpu: Cost of: XSAVE   insn:   104 cycles
     x86/fpu: Cost of: XRSTOR  insn:    80 cycles

   ... and that's with just 128-bit AVX and a ~0.8K XSAVE area. The Agner PDF 
   lists Skylake XSAVE+XRSTOR costs at 107+122 cycles, plus there's probably a
   significant amount of L1 cache churn caused by XSAVE/XRSTOR.

   Most of the relevant vector instructions have a single cycle cost
   on the other hand.

 - To use vector ops in bulk, well-aligned memcpy(), which in many workloads
   is a fair chunk of all memset() activity. A usage profile on a typical system:

            galatea:~> cat /proc/sched_debug  | grep hist | grep -E '[[:digit:]]{4,}$' | grep '0\]'
            hist[0x0000]:    1514272
            hist[0x0010]:    1905248
            hist[0x0020]:      99471
            hist[0x0030]:     343309
            hist[0x0040]:     177874
            hist[0x0080]:     190052
            hist[0x00a0]:       5258
            hist[0x00b0]:       2387
            hist[0x00c0]:       6975
            hist[0x00d0]:       5872
            hist[0x0100]:       3229
            hist[0x0140]:       4813
            hist[0x0160]:       9323
            hist[0x0200]:      12540
            hist[0x0230]:      37488
            hist[0x1000]:      17136
            hist[0x1d80]:     225199

   First column is length of the area copied, the column is usage count.

   To do this I wouldn't complicate the main memset() interface in any way to 
   branch it off to vector ops, I'd isolate specific memcpy()'s and memset()s
   (such as page table copying and page clearing) and use the simpler
   vector register based primitives there.

   For example we have clear_page() which is used by GFP_ZERO and by other places
   is implemented on modern x86 CPUs as:

     ENTRY(clear_page_erms)
        movl $4096,%ecx
        xorl %eax,%eax
        rep stosb
        ret

   While for such buffer sizes the enhanced-REP string instructions are supposed 
   to be slightly faster than 128-bit AVX ops, for such exact page granular ops 
   I'm pretty sure 256-bit (and 512-bit) vector ops are faster.

 - For page granular memset/memcpy it would also be interesting to investigate 
   whether non-temporal, cache-preserving vector ops for such known-large bulk 
   ops, such as VMOVNTQA, are beneficial in certain circumstances.

   On x86 there's only a single non-temporal instruction to GP registers: 
   MOVNTI, and for stores only.

   The vector instructions space is a lot richer in that regard, allowing 
   non-temporal loads as well which utilize fill buffers to move chunks of memory 
   into vector registers.

   Random example: in do_cow_fault() we use copy_user_highpage() to copy the page, 
   which uses copy_user_page() -> copy_page(), which uses:

     ENTRY(copy_page)
        ALTERNATIVE "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD
        movl    $4096/8, %ecx
        rep     movsq
        ret

   But in this COW copy case it's pretty obvious that we shouldn't keep the 
   _source_ page in cache. So we could use non-temporal load, which appear to make 
   a difference on more recent uarchs even on write-back memory ranges:

      https://stackoverflow.com/questions/40096894/do-current-x86-architectures-support-non-temporal-loads-from-normal-memory

   See the final graph in that entry and now the 'NT load' variant results in the 
   best execution time in the 4K case - and this is a limited benchmark that
   doesn't measure the lower cache eviction pressure by NT loads.

   ( The store part is probably better done into the cache, not just due to the
     SFENCE cost (which is relatively low at 40 cycles), but because it's probably
     beneficial to prime the cache with a freshly COW-ed page, it's going to get
     used in the near future once we return from the fault. )

   etc.

 - But more broadly, if we open up vector ops for smaller buffer sizes as well
   then I think other kernel code would start using them as well:

 - I think the BPF JIT, whose byte code machine languge is used by an
   increasing number of kernel subsystems, could benefit from having vector ops.
   It would possibly allow the handling of floating point types.

 - We could consider implementing vector ops based copy-to-user and copy-from-user 
   primitives as well, for cases where we know that the dominant usage pattern is 
   for larger, well-aligned chunks of memory.

 - Maybe we could introduce a floating point library (which falls back to a C 
   implementation) and simplify scheduler math. We go to ridiculous lengths to 
   maintain precision across a wide range of parameters, essentially implementing 
   128-bit fixed point math. Even 32-bit floating point math would possibly be 
   better than that, even if it was done via APIs.

etc.: I think the large vector processor available in modern x86 CPUs could be 
utilized by the kernel as well for various purposes.

But I think that's only worth doing if vector registers and their save areas are 
easily accessibly and the accesses are fundamentally IRQ safe.

> Yes, yes, I can find an Intel white-paper that talks about setting WC and then 
> using xmm and ymm instructions to write a single 64-byte burst over PCIe, and I 
> assume that is where the code and idea came from. But I don't actually see any 
> reason why a burst of 8 regular quad-word bytes wouldn't cause a 64-byte burst 
> write too.

Yeah, I'm not too convinced about the wide readq/writeq usecase either, I just 
used the opportunity to outline these (very vague) plans about utilizing vector 
instructions more broadly within the kernel.

> So as far as I can tell, there are basically *zero* upsides, and a lot of 
> potential downsides.

I agree about the potential downsides and I think most of them can be addressed 
adequately - and I think my list of upsides above is potentially significant, 
especially once we have lightweight APIs to utilize individual vector registers 
without having to do a full save/restore of ~1K large vector register context.

Thanks,

	Ingo
