Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBAPjx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:39:53 -0500
Received: from foss.arm.com ([217.140.101.70]:51704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751472AbeBAPju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:39:50 -0500
Date: Thu, 1 Feb 2018 15:39:51 +0000
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Stafford Horne <shorne@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: asm-generic: Disallow no-op mb() for SMP systems
Message-ID: <20180201153951.GG9182@arm.com>
References: <20180131130034.GR2269@hirez.programming.kicks-ass.net>
 <20180131131737.GA5097@arm.com>
 <20180131132610.GT2269@hirez.programming.kicks-ass.net>
 <20180201122750.GE30895@lianli.shorne-pla.net>
 <20180201132909.GW2249@hirez.programming.kicks-ass.net>
 <20180201133229.GB9182@arm.com>
 <20180201135329.GB2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201135329.GB2269@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 02:53:29PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 01, 2018 at 01:32:30PM +0000, Will Deacon wrote:
> > On Thu, Feb 01, 2018 at 02:29:09PM +0100, Peter Zijlstra wrote:
> > > On Thu, Feb 01, 2018 at 09:27:50PM +0900, Stafford Horne wrote:
> > > > I tried to clarify some of this in the spec v1.2 [0] which help formalize some of
> > > > the techniques we used for the SMP implementation.  Its probably not perfect,
> > > > but I added a section "10. Multicore support" and tried to clarify some things
> > > > in section 7 on Atomicity.  But it seems I dont cover exactly what are are
> > > > mentioning here.  In general:
> > > > 
> > > >   1 Secondary cores have memory snooping enabled meaning that any write to a
> > > >     cached address will cause the cache line to be invalidated.
> > > >   2 l.swa (store atomic word) implies a store buffer flush.
> > > 
> > > What about l.lwa? Can that observe 'old' values, or rather, miss values
> > > stuck in a remote store buffer?
> > > 
> > > This will then cause the first l.swa to fail, which, per the above,
> > > would then sync things up? Which means you get that one extra
> > > merry-go-round.
> > 
> > That's ok from a correctness perspective, though, as long as store buffers
> > are guaranteed to drain.
> 
> Depends a bit if you can build control dependencies off of l.swa
> succeding or not I think :-) Otherwise you get into that dodgy state you
> suffer from where bits can leak right through.
> 
> That is, I was thinking what we need for smp_mb__before_atomic.
> 
> I could've gotten my brain in a twist or course, which isn't _that_
> unusual. I never seem to be able to quite remember the holes you have
> with ll/sc on arm64 :-)

Is smp_mb__before_atomic supposed to provide ordering guarantees if it's
used before a failed cmpxchg? If so, I think it's needed here because the
l.swa might not even execute. Or did I just invent another problem?

Will
