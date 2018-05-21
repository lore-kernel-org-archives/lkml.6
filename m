Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeEURUm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:20:42 -0400
Received: from foss.arm.com ([217.140.101.70]:54058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752872AbeEURUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:20:41 -0400
Date: Mon, 21 May 2018 18:21:08 +0100
From: Will Deacon <will.deacon@arm.com>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dave.martin@arm.com, robin.murphy@arm.com, peterz@infradead.org
Subject: Re: arm64: add missing early clobber in atomic64_dec_if_positive()
Message-ID: <20180521172108.GH21034@arm.com>
References: <20180520001726.27808-1-msalter@redhat.com>
 <20180521170022.GD21034@arm.com>
 <c540dd519065316c859e5cb1290de7f5041cb816.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c540dd519065316c859e5cb1290de7f5041cb816.camel@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 01:18:39PM -0400, Mark Salter wrote:
> On Mon, 2018-05-21 at 18:00 +0100, Will Deacon wrote:
> > Hi Mark,
> > 
> > Thanks for reporting this.
> > 
> > On Sat, May 19, 2018 at 08:17:26PM -0400, Mark Salter wrote:
> > > When running a kernel compiled with gcc8 on a machine using LSE, I
> > > get:
> > > 
> > >  Unable to handle kernel paging request at virtual address 11111122222221
> > 
> > [...]
> > 
> > > The fault happens at the casal insn of inlined atomic64_dec_if_positive().
> > > The inline asm code in that function has:
> > > 
> > > 	"1:	ldr	x30, %[v]\n"
> > > 	"	subs	%[ret], x30, #1\n"
> > > 	"	b.lt	2f\n"
> > > 	"	casal	x30, %[ret], %[v]\n"
> > > 	"	sub	x30, x30, #1\n"
> > > 	"	sub	x30, x30, %[ret]\n"
> > > 	"	cbnz	x30, 1b\n"
> > > 	"2:")
> > > 	: [ret] "+r" (x0), [v] "+Q" (v->counter)
> > > 
> > > gcc8 used register x0 for both [ret] and [v] and the subs was
> > > clobbering [v] before it was used for casal. Gcc is free to do
> > > this because [ret] lacks an early clobber modifier. So add one
> > > to tell gcc a separate register is needed for [v].
> > 
> > Oh blimey, it looks like GCC is realising that counter is at offset 0
> > of atomic_t and therefore assigns the same register for [ret] and [v],
> > which is actually forced to be x0 by the 'register' local variable in
> > C code. The "+Q" constraint only says that the memory is read/write, so
> > the pointer is fair game.
> > 
> > I agree with your fix, but we also need to fix up the other places relying
> > on this. Patch below -- please yell if you think I missed any.
> 
> I looked at the other places but figured they were okay because we're
> explicitly using separate registers. But I suppose the early clobber
> is the right thing to do in any case.

I was worried about silly things like a caller doing:

  atomic64_and((long)v, v);

and then GCC figuring out that the two values were equal and allocating
the same register..

Will
