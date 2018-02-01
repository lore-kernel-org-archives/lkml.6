Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeBANca (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:32:30 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50288 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751467AbeBANc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:32:28 -0500
Date: Thu, 1 Feb 2018 13:32:30 +0000
From: Will Deacon <will.deacon@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Stafford Horne <shorne@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: asm-generic: Disallow no-op mb() for SMP systems
Message-ID: <20180201133229.GB9182@arm.com>
References: <20180131130034.GR2269@hirez.programming.kicks-ass.net>
 <20180131131737.GA5097@arm.com>
 <20180131132610.GT2269@hirez.programming.kicks-ass.net>
 <20180201122750.GE30895@lianli.shorne-pla.net>
 <20180201132909.GW2249@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201132909.GW2249@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
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

That's ok from a correctness perspective, though, as long as store buffers
are guaranteed to drain.

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

Agreed, especially as a software person reading the spec may end up thinking
that they don't need to use l.msync if they never set WOM. At least, I read
it this way despite knowing that it's probably not what you intended.

Will
