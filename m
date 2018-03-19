Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755927AbeCSPhc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:37:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60579 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755897AbeCSPh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:37:28 -0400
Date: Mon, 19 Mar 2018 16:37:21 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Laight <David.Laight@ACULAB.COM>
cc: "'Rahul Lakkireddy'" <rahul.lakkireddy@chelsio.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>,
        "indranil@chelsio.com" <indranil@chelsio.com>
Subject: RE: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
In-Reply-To: <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com> <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com> <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de> <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2018, David Laight wrote:
> From: Thomas Gleixner
> > Sent: 19 March 2018 15:05
> > 
> > On Mon, 19 Mar 2018, David Laight wrote:
> > > From: Rahul Lakkireddy
> > > In principle it ought to be possible to get access to one or two
> > > (eg) AVX registers by saving them to stack and telling the fpu
> > > save code where you've put them.
> > 
> > No. We have functions for this and we are not adding new ad hoc magic.
> 
> I was thinking that a real API might do this...

We have a real API and that's good enough for the stuff we have using AVX
in the kernel.

> Useful also for code that needs AVX-like registers to do things like CRCs.

x86/crypto/ has a lot of AVX optimized code.

> > > OTOH, for x86, if the code always runs in process context (eg from a
> > > system call) then, since the ABI defines them all as caller-saved
> > > the AVX(2) registers, it is only necessary to ensure that the current
> > > FPU registers belong to the current process once.
> > > The registers can be set to zero by an 'invalidate' instruction on
> > > system call entry (hope this is done) and after use.
> > 
> > Why would a system call touch the FPU registers? The kernel normally does
> > not use FPU instructions and the code which explicitely does has to take
> > care of save/restore. It would be performance madness to fiddle with the
> > FPU stuff unconditionally if nothing uses it.
> 
> If system call entry reset the AVX registers then any FP save/restore
> would be faster because the AVX registers wouldn't need to be saved
> (and the cpu won't save them).
> I believe the instruction to reset the AVX registers is fast.
> The AVX registers only ever need saving if the process enters the
> kernel through an interrupt.

Wrong. The x8664 ABI clearly states:

   Linux Kernel code is not allowed to change the x87 and SSE units. If
   those are changed by kernel code, they have to be restored properly
   before sleeping or leav- ing the kernel.

That means the syscall interface relies on FPU state being not changed by
the kernel. So if you want to clear AVX on syscall entry you need to save
it first and then restore before returning. That would be a huge
performance hit.

Thanks,

	tglx
