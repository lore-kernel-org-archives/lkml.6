Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeBBNsx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:48:53 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:38714 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBBNsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:48:46 -0500
X-Google-Smtp-Source: AH8x225il7L4yH7upvf6RH6PT9NajalAAXJND7yx5QmMDOeLhKVclNLXn8Bw9AWXzSyL0moic1tKNw==
Date: Fri, 2 Feb 2018 22:48:43 +0900
From: Stafford Horne <shorne@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: asm-generic: Disallow no-op mb() for SMP systems
Message-ID: <20180202134843.GF30895@lianli.shorne-pla.net>
References: <20180131130034.GR2269@hirez.programming.kicks-ass.net>
 <20180131131737.GA5097@arm.com>
 <20180131132610.GT2269@hirez.programming.kicks-ass.net>
 <20180201122750.GE30895@lianli.shorne-pla.net>
 <20180201132909.GW2249@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201132909.GW2249@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 02:29:09PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 01, 2018 at 09:27:50PM +0900, Stafford Horne wrote:
> > I tried to clarify some of this in the spec v1.2 [0] which help formalize some of
> > the techniques we used for the SMP implementation.  Its probably not perfect,
> > but I added a section "10. Multicore support" and tried to clarify some things
> > in section 7 on Atomicity.  But it seems I dont cover exactly what are are
> > mentioning here.  In general:
> > 
> >   1 Secondary cores have memory snooping enabled meaning that any write to a
> >     cached address will cause the cache line to be invalidated.
> >   2 l.swa (store atomic word) implies a store buffer flush.
> 
> What about l.lwa? Can that observe 'old' values, or rather, miss values
> stuck in a remote store buffer?
> 
> This will then cause the first l.swa to fail, which, per the above,
> would then sync things up? Which means you get that one extra
> merry-go-round.

Sorry, I remembered incorrectly, l.lwa also implies a (l.msync) store buffer
flush for the local cpu.  However, in order to see something stuch in the remote
store buffer a flush would need to be inititiated on the remote core.  I think
that is what we would expect though right?

> >   3 l.msync is used to flush the store buffer
> > 
> > Also, during the IPI controller review [1] Marc Z asked many similar questions.
> > I believe he was ok in the end.
> > 
> > Anyway,
> > Thanks for thanks for spotting the issue here.  For some reason I remember we
> > did have an l.msync for our mb().  Let me think about and test out this patch
> > (and the fix to actually define mb) to see if anything comes up.
> > 
> > Also, I haven't seen any implementations that use WOM.  Stefan might know better.
> 
> So if the strong model has a store buffer, as I think the above says,
> then it is _NOT_ correct for l.msync to be treated as a NOP, it _must_
> flush the store buffer.
> 
> At which point I think your 'strong' model is basically TSO. So it would
> be very good to get that spelled out somewhere.

Yes, I think the original author did not think of PSO/TSO and store buffers.
Its not clear of the authors intention.  It should be cleared up.

I would say:
  1 Weak order model with store buffers is PSO (must implement l.msync)
  2 Strong model with store buffers is TSO (must implement l.msync)
  3 Implementations without store buffers could be weak or strong?
     a weak meaning cpu could schedule loads stores out of order l.msync would
       cause all pending load/store instructions to be retired.
     b strong meaning loads/stores would happen in instruction order, in this
       case l.msync could be a no-op as there is no buffering of stores or
       loads.

1 doesnt exist as far as I know. So its probably better to remove.
2 is what we have now in mor1kx.
3.b it possible, but we always have a l.msync implementation. But maybe it
doesnt make sense when there is no store buffer.

-Stafford
