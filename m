Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753505AbeAaN0Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 08:26:25 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:57453 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeAaN0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 08:26:23 -0500
Date: Wed, 31 Jan 2018 14:26:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Stafford Horne <shorne@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: asm-generic: Disallow no-op mb() for SMP systems
Message-ID: <20180131132610.GT2269@hirez.programming.kicks-ass.net>
References: <20180131130034.GR2269@hirez.programming.kicks-ass.net>
 <20180131131737.GA5097@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131131737.GA5097@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 01:17:37PM +0000, Will Deacon wrote:
> On Wed, Jan 31, 2018 at 02:00:34PM +0100, Peter Zijlstra wrote:
> > 
> > While looking through the qspinlock users, I stumbled upon openrisc and
> > being curious, I wanted to have a look at its memory model.
> > 
> > To my surprise it doesn't have asm/barrier.h. It does however support
> > SMP. This lead me to wonder why it would compile, turns out we provide a
> > no-op mb() if the architecture does not provide one.
> > 
> > With the obvious exception of Sequentially Consistent SMP systems, this
> > is terribly broken. And seeing how SC SMP is really rather unusual (and
> > unlikely), change the asm-generic/barrier.h to not provide this.
> > 
> > This _will_ break openrisc builds, they had better clarify their
> > position by writing their own barrier.h with a comment in.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/asm-generic/barrier.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> One comment below...
> 
> > diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> > index fe297b599b0a..7a10748615ff 100644
> > --- a/include/asm-generic/barrier.h
> > +++ b/include/asm-generic/barrier.h
> > @@ -30,9 +30,15 @@
> >   * Fall back to compiler barriers if nothing better is provided.
> >   */
> >  
> > +#ifndef CONFIG_SMP
> > +/*
> > + * If your SMP architecture really is Sequentially Consistent, you get
> > + * barrier.h to write a nice big comment about it.
> > + */
> 
> I couldn't find any documentation about the openrisc memory model other
> than:
> 
> https://openrisc.io/or1k.html#__RefHeading__504775_595890882
> 
> which talks about the WOM bit in the page table being used to select a weak
> memory model for the page being mapped as opposed to the strong memory
> model. Furthermore, the only fence instruction (l.msync) is permitted to
> be a NOP for the strong model, which implies that the strong model is SC
> and things like write buffers are forbidden. However, Google suggests that
> there are implementations of openrisc with write buffers so I'm not sure I
> understand what's going on here (maybe they force WOM and/or l.msync isn't
> actually a NOP?)

Right, so by that document they need:

#define mb() asm volatile ("l.msync":::"memory)

but yes, that document raises more questions than it answers. It would
be very good to get clarification on how strong their strong model
really is. SMP without store buffers is, as I wrote above, 'unusual'.
