Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965767AbeBUNZH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:25:07 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35676 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932152AbeBUNZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:25:05 -0500
X-Google-Smtp-Source: AH8x226WZMPPyWT4GUbrE/yrZUtr5MOTkw6rJMFaVqdXUlYtr1J3DmIDnGK8Hd5x3N5SoHn15pmUSA==
Date: Wed, 21 Feb 2018 14:24:55 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xchg/alpha: Add unconditional memory barrier to cmpxchg
Message-ID: <20180221132455.GA16111@andrea>
References: <1519152356-4804-1-git-send-email-parri.andrea@gmail.com>
 <20180221112137.GA6165@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221112137.GA6165@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 11:21:38AM +0000, Will Deacon wrote:
> Hi Andrea,
> 
> On Tue, Feb 20, 2018 at 07:45:56PM +0100, Andrea Parri wrote:
> > Continuing along with the fight against smp_read_barrier_depends() [1]
> > (or rather, against its improper use), add an unconditional barrier to
> > cmpxchg.  This guarantees that dependency ordering is preserved when a
> > dependency is headed by an unsuccessful cmpxchg.  As it turns out, the
> > change could enable further simplification of LKMM as proposed in [2].
> > 
> > [1] https://marc.info/?l=linux-kernel&m=150884953419377&w=2
> >     https://marc.info/?l=linux-kernel&m=150884946319353&w=2
> >     https://marc.info/?l=linux-kernel&m=151215810824468&w=2
> >     https://marc.info/?l=linux-kernel&m=151215816324484&w=2
> > 
> > [2] https://marc.info/?l=linux-kernel&m=151881978314872&w=2
> > 
> > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> > Acked-by: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> > Cc: Matt Turner <mattst88@gmail.com>
> > Cc: linux-alpha@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  arch/alpha/include/asm/xchg.h | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/alpha/include/asm/xchg.h b/arch/alpha/include/asm/xchg.h
> > index 68dfb3cb71454..e2660866ce972 100644
> > --- a/arch/alpha/include/asm/xchg.h
> > +++ b/arch/alpha/include/asm/xchg.h
> > @@ -128,10 +128,9 @@ ____xchg(, volatile void *ptr, unsigned long x, int size)
> >   * store NEW in MEM.  Return the initial value in MEM.  Success is
> >   * indicated by comparing RETURN with OLD.
> >   *
> > - * The memory barrier should be placed in SMP only when we actually
> > - * make the change. If we don't change anything (so if the returned
> > - * prev is equal to old) then we aren't acquiring anything new and
> > - * we don't need any memory barrier as far I can tell.
> > + * The memory barrier is placed in SMP unconditionally, in order to
> > + * guarantee that dependency ordering is preserved when a dependency
> > + * is headed by an unsuccessful operation.
> >   */
> >  
> >  static inline unsigned long
> > @@ -150,8 +149,8 @@ ____cmpxchg(_u8, volatile char *m, unsigned char old, unsigned char new)
> >  	"	or	%1,%2,%2\n"
> >  	"	stq_c	%2,0(%4)\n"
> >  	"	beq	%2,3f\n"
> > -		__ASM__MB
> >  	"2:\n"
> > +		__ASM__MB
> >  	".subsection 2\n"
> >  	"3:	br	1b\n"
> >  	".previous"
> 
> It might be better just to add smp_read_barrier_depends() into the cmpxchg
> macro, then remove all of the __ASM__MB stuff.

Mmh, it might be better to add smp_mb() into the cmpxchg macro (after the
operation), then remove all the __ASM__MB stuff.


> 
> That said, I don't actually understand how the Alpha cmpxchg or xchg
> implementations satisfy the memory model, since they only appear to have
> a barrier after the operation.
> 
> So MP using xchg:
> 
> WRITE_ONCE(x, 1)
> xchg(y, 1)
> 
> smp_load_acquire(y) == 1
> READ_ONCE(x) == 0
> 
> would be allowed. What am I missing?

Good question ;-)  The absence of an smp_mb() (or of an __ASM__MB) before
the operation did upset me.

If this question remains pending, I'll send a patch to add these barriers.


> 
> Since I'm in the mood for dumb questions, do we need to care about
> this_cpu_cmpxchg? I'm sure I've seen code that allows concurrent access to
> per-cpu variables, but the asm-generic implementation of this_cpu_cmpxchg
> doesn't use READ_ONCE.

Frankly, I'm not sure if this's an issue in the generic implementation of
this_cpu_* or, rather, in that code.  let me dig a bit more into this ...

  Andrea


> 
> Will
