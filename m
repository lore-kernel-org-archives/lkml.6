Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeCTI1C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:27:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33320 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeCTI04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:26:56 -0400
X-Google-Smtp-Source: AG47ELt1adXYPO44Hf0CxpIICn0oRXT16vCIPoWh3atY73OcrY7lxcLKdDwcTc3cg4zYaU+7V1e0Lg==
Date: Tue, 20 Mar 2018 09:26:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Laight <David.Laight@ACULAB.COM>,
        "'Rahul Lakkireddy'" <rahul.lakkireddy@chelsio.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>, Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Message-ID: <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > Useful also for code that needs AVX-like registers to do things like CRCs.
> 
> x86/crypto/ has a lot of AVX optimized code.

Yeah, that's true, but the crypto code is processing fundamentally bigger blocks 
of data, which amortizes the cost of using kernel_fpu_begin()/_end().

kernel_fpu_begin()/_end() is a pretty heavy operation because it does a full FPU 
save/restore via the XSAVE[S] and XRSTOR[S] instructions, which can easily copy a 
thousand bytes around! So kernel_fpu_begin()/_end() is probably a non-starter for 
something small, like a single 256-bit or 512-bit word access.

But there's actually a new thing in modern kernels: we got rid of (most of) lazy 
save/restore FPU code, our new x86 FPU model is very "direct" with no FPU faults 
taken normally.

So assuming the target driver will only load on modern FPUs I *think* it should 
actually be possible to do something like (pseudocode):

	vmovdqa %ymm0, 40(%rsp)
	vmovdqa %ymm1, 80(%rsp)

	...
	# use ymm0 and ymm1
	...

	vmovdqa 80(%rsp), %ymm1
	vmovdqa 40(%rsp), %ymm0

... without using the heavy XSAVE/XRSTOR instructions.

Note that preemption probably still needs to be disabled and possibly there are 
other details as well, but there should be no 'heavy' FPU operations.

I think this should still preserve all user-space FPU state and shouldn't muck up 
any 'weird' user-space FPU state (such as pending exceptions, legacy x87 running 
code, NaN registers or weird FPU control word settings) we might have interrupted 
either.

But I could be wrong, it should be checked whether this sequence is safe. 
Worst-case we might have to save/restore the FPU control and tag words - but those 
operations should still be much faster than a full XSAVE/XRSTOR pair.

So I do think we could do more in this area to improve driver performance, if the 
code is correct and if there's actual benchmarks that are showing real benefits.

Thanks,

	Ingo
