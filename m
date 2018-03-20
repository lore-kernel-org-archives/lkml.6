Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeCTIiv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:38:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33990 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbeCTIir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:38:47 -0400
Date: Tue, 20 Mar 2018 09:38:38 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
cc: David Laight <David.Laight@ACULAB.COM>,
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
        Fenghua Yu <fenghua.yu@intel.com>, Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
In-Reply-To: <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
Message-ID: <alpine.DEB.2.21.1803200933320.6506@nanos.tec.linutronix.de>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com> <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com> <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de> <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de> <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > Useful also for code that needs AVX-like registers to do things like CRCs.
> > 
> > x86/crypto/ has a lot of AVX optimized code.
> 
> Yeah, that's true, but the crypto code is processing fundamentally bigger blocks 
> of data, which amortizes the cost of using kernel_fpu_begin()/_end().

Correct.

> So assuming the target driver will only load on modern FPUs I *think* it should 
> actually be possible to do something like (pseudocode):
> 
> 	vmovdqa %ymm0, 40(%rsp)
> 	vmovdqa %ymm1, 80(%rsp)
> 
> 	...
> 	# use ymm0 and ymm1
> 	...
> 
> 	vmovdqa 80(%rsp), %ymm1
> 	vmovdqa 40(%rsp), %ymm0
> 
> ... without using the heavy XSAVE/XRSTOR instructions.
> 
> Note that preemption probably still needs to be disabled and possibly there are 
> other details as well, but there should be no 'heavy' FPU operations.

Emphasis on should :)

> I think this should still preserve all user-space FPU state and shouldn't muck up 
> any 'weird' user-space FPU state (such as pending exceptions, legacy x87 running 
> code, NaN registers or weird FPU control word settings) we might have interrupted 
> either.
> 
> But I could be wrong, it should be checked whether this sequence is safe. 
> Worst-case we might have to save/restore the FPU control and tag words - but those 
> operations should still be much faster than a full XSAVE/XRSTOR pair.

Fair enough.

> So I do think we could do more in this area to improve driver performance, if the 
> code is correct and if there's actual benchmarks that are showing real benefits.

If it's about hotpath performance I'm all for it, but the use case here is
a debug facility...

And if we go down that road then we want a AVX based memcpy()
implementation which is runtime conditional on the feature bit(s) and
length dependent. Just slapping a readqq() at it and use it in a loop does
not make any sense.

Thanks,

	tglx
