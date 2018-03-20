Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbeCTO5b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751578AbeCTO51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:57:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D222421834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx485qK1IAmFz1MNAuKOX9ZXq8hQNWK/pFt2sxDBpMYcYu1D9SwtlBAU994XBXdPGMQA7ZfY4OY4+8axytfxoZug=
MIME-Version: 1.0
In-Reply-To: <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com> <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com> <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 20 Mar 2018 14:57:05 +0000
X-Gmail-Original-Message-ID: <CALCETrVMF140-XZLi9nARPeAmyi8QRRzLRm6SSpB0BkAUSGakg@mail.gmail.com>
Message-ID: <CALCETrVMF140-XZLi9nARPeAmyi8QRRzLRm6SSpB0BkAUSGakg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        David Laight <David.Laight@aculab.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>,
        "indranil@chelsio.com" <indranil@chelsio.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Fenghua Yu <fenghua.yu@intel.com>, Eric Biggers <ebiggers3@gmail.com>,
        Rik van Riel <riel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 8:26 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> > Useful also for code that needs AVX-like registers to do things like CRCs.
>>
>> x86/crypto/ has a lot of AVX optimized code.
>
> Yeah, that's true, but the crypto code is processing fundamentally bigger blocks
> of data, which amortizes the cost of using kernel_fpu_begin()/_end().
>
> kernel_fpu_begin()/_end() is a pretty heavy operation because it does a full FPU
> save/restore via the XSAVE[S] and XRSTOR[S] instructions, which can easily copy a
> thousand bytes around! So kernel_fpu_begin()/_end() is probably a non-starter for
> something small, like a single 256-bit or 512-bit word access.
>
> But there's actually a new thing in modern kernels: we got rid of (most of) lazy
> save/restore FPU code, our new x86 FPU model is very "direct" with no FPU faults
> taken normally.
>
> So assuming the target driver will only load on modern FPUs I *think* it should
> actually be possible to do something like (pseudocode):
>
>         vmovdqa %ymm0, 40(%rsp)
>         vmovdqa %ymm1, 80(%rsp)
>
>         ...
>         # use ymm0 and ymm1
>         ...
>
>         vmovdqa 80(%rsp), %ymm1
>         vmovdqa 40(%rsp), %ymm0
>

I think this kinda sorts works, but only kinda sorta:

 - I'm a bit worried about newer CPUs where, say, a 256-bit vector
operation will implicitly clear the high 768 bits of the regs.  (IIRC
that's how it works for the new VEX stuff.)

 - This code will cause XINUSE to be set, which is user-visible and
may have performance and correctness effects.  I think the kernel may
already have some but where it occasionally sets XINUSE on its own,
and this caused problems for rr in the past.  This might not be a
total showstopper, but it's odd.

I'd rather see us finally finish the work that Rik started to rework
this differently.  I'd like kernel_fpu_begin() to look like:

if (test_thread_flag(TIF_NEED_FPU_RESTORE)) {
  return; // we're already okay.  maybe we need to check
in_interrupt() or something, though?
} else {
  XSAVES/XSAVEOPT/XSAVE;
  set_thread_flag(TIF_NEED_FPU_RESTORE):
}

and kernel_fpu_end() does nothing at all.

We take the full performance hit for a *single* kernel_fpu_begin() on
an otherwise short syscall or interrupt, but there's no additional
cost for more of them or for long-enough-running things that we
schedule in the middle.

As I remember, the main hangup was that this interacts a bit oddly
with PKRU, but that's manageable.

--Andy
