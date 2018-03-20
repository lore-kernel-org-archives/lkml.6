Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeCTJlS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:41:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34118 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeCTJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:41:17 -0400
Date: Tue, 20 Mar 2018 10:41:08 +0100 (CET)
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
In-Reply-To: <20180320090802.qw4tqjmhy6yfd6sf@gmail.com>
Message-ID: <alpine.DEB.2.21.1803201039460.6506@nanos.tec.linutronix.de>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com> <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com> <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de> <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de> <20180320082651.jmxvvii2xvmpyr2s@gmail.com> <alpine.DEB.2.21.1803200933320.6506@nanos.tec.linutronix.de> <20180320090802.qw4tqjmhy6yfd6sf@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > So I do think we could do more in this area to improve driver performance, if the 
> > > code is correct and if there's actual benchmarks that are showing real benefits.
> > 
> > If it's about hotpath performance I'm all for it, but the use case here is
> > a debug facility...
> > 
> > And if we go down that road then we want a AVX based memcpy()
> > implementation which is runtime conditional on the feature bit(s) and
> > length dependent. Just slapping a readqq() at it and use it in a loop does
> > not make any sense.
> 
> Yeah, so generic memcpy() replacement is only feasible I think if the most 
> optimistic implementation is actually correct:
> 
>  - if no preempt disable()/enable() is required
> 
>  - if direct access to the AVX[2] registers does not disturb legacy FPU state in 
>    any fashion
> 
>  - if direct access to the AVX[2] registers cannot raise weird exceptions or have
>    weird behavior if the FPU control word is modified to non-standard values by 
>    untrusted user-space
> 
> If we have to touch the FPU tag or control words then it's probably only good for 
> a specialized API.

I did not mean to have a general memcpy replacement. Rather something like
magic_memcpy() which falls back to memcpy when AVX is not usable or the
length does not justify the AVX stuff at all.

Thanks,

	tglx
