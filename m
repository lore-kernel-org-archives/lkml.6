Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4131DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7D920877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7D920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933952AbeGJOss (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:48:48 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:33874 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S933256AbeGJOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:48:45 -0400
Received: (qmail 2894 invoked by uid 2102); 10 Jul 2018 10:48:44 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jul 2018 10:48:44 -0400
Date:   Tue, 10 Jul 2018 10:48:44 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
In-Reply-To: <20180710093821.GA5414@andrea>
Message-ID: <Pine.LNX.4.44L0.1807101039310.1449-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018, Andrea Parri wrote:

> On Mon, Jul 09, 2018 at 04:01:57PM -0400, Alan Stern wrote:
> > More than one kernel developer has expressed the opinion that the LKMM
> > should enforce ordering of writes by locking.  In other words, given
> 
> I'd like to step back on this point: I still don't have a strong opinion
> on this, but all this debating made me curious about others' opinion ;-)
> I'd like to see the above argument expanded: what's the rationale behind
> that opinion? can we maybe add references to actual code relying on that
> ordering? other that I've been missing?
> 
> I'd extend these same questions to the "ordering of reads" snippet below
> (and discussed since so long...).
> 
> 
> > the following code:
> > 
> > 	WRITE_ONCE(x, 1);
> > 	spin_unlock(&s):
> > 	spin_lock(&s);
> > 	WRITE_ONCE(y, 1);
> > 
> > the stores to x and y should be propagated in order to all other CPUs,
> > even though those other CPUs might not access the lock s.  In terms of
> > the memory model, this means expanding the cumul-fence relation.
> > 
> > Locks should also provide read-read (and read-write) ordering in a
> > similar way.  Given:
> > 
> > 	READ_ONCE(x);
> > 	spin_unlock(&s);
> > 	spin_lock(&s);
> > 	READ_ONCE(y);		// or WRITE_ONCE(y, 1);
> > 
> > the load of x should be executed before the load of (or store to) y.
> > The LKMM already provides this ordering, but it provides it even in
> > the case where the two accesses are separated by a release/acquire
> > pair of fences rather than unlock/lock.  This would prevent
> > architectures from using weakly ordered implementations of release and
> > acquire, which seems like an unnecessary restriction.  The patch
> > therefore removes the ordering requirement from the LKMM for that
> > case.
> 
> IIUC, the same argument could be used to support the removal of the new
> unlock-rf-lock-po (we already discussed riscv .aq/.rl, it doesn't seem
> hard to imagine an arm64 LDAPR-exclusive, or the adoption of ctrl+isync
> on powerpc).  Why are we effectively preventing their adoption?  Again,
> I'd like to see more details about the underlying motivations...
> 
> 
> > 
> > All the architectures supported by the Linux kernel (including RISC-V)
> > do provide this ordering for locks, albeit for varying reasons.
> > Therefore this patch changes the model in accordance with the
> > developers' wishes.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > ---
> > 
> > v.2: Restrict the ordering to lock operations, not general release
> > and acquire fences.
> 
> This is another controversial point, and one that makes me shivering ...
> 
> I have the impression that we're dismissing the suggestion "RMW-acquire
> at par with LKR" with a bit of rush.  So, this patch is implying that:
> 
> 	while (cmpxchg_acquire(&s, 0, 1) != 0)
> 		cpu_relax();
> 
> is _not_ a valid implementation of spin_lock()! or, at least, it is not
> when paired with an smp_store_release().

At least, it's not a valid general-purpose implementation.  For a lot 
of architectures it would be okay, but it might not be okay (for 
example) on RISC-V.

> Will was anticipating inserting
> arch hooks into the (generic) qspinlock code,  when we know that similar
> patterns are spread all over in (q)rwlocks, mutexes, rwsem, ... (please
> also notice that the informal documentation is currently treating these
> synchronization mechanisms equally as far as "ordering" is concerned...).
> 
> This distinction between locking operations and "other acquires" appears
> to me not only unmotivated but also extremely _fragile (difficult to use
> /maintain) when considering the analysis of synchronization mechanisms
> such as those mentioned above or their porting for new arch.

I will leave these points for others to discuss.


> memory-barriers.txt seems to also need an update on this regard:  e.g.,
> "VARIETIES OF MEMORY BARRIERS" currently has:
> 
>   ACQUIRE operations include LOCK operations and both smp_load_acquire()
>   and smp_cond_acquire() operations.  [BTW, the latter was replaced by
>   smp_cond_load_acquire() in 1f03e8d2919270 ...]
> 
>   RELEASE operations include UNLOCK operations and smp_store_release()
>   operations. [...]
> 
>   [...] after an ACQUIRE on a given variable, all memory accesses
>   preceding any prior RELEASE on that same variable are guaranteed
>   to be visible.

As far as I can see, these statements remain valid.

> Please see also "LOCK ACQUISITION FUNCTIONS".

The (3) and (4) entries in that section's list seem redundant.  
However, we should point out that one of the reorderings discussed
later on in that section would be disallowed if the RELEASE and ACQUIRE
were locking actions.

> > +
> > +	int x, y;
> > +	spinlock_t x;
> > +
> > +	P0()
> > +	{
> > +		spin_lock(&s);
> > +		WRITE_ONCE(x, 1);
> > +		spin_unlock(&s);
> > +	}
> > +
> > +	P1()
> > +	{
> > +		int r1;
> > +
> > +		spin_lock(&s);
> > +		r1 = READ_ONCE(x);
> > +		WRITE_ONCE(y, 1);
> > +		spin_unlock(&s);
> > +	}
> > +
> > +	P2()
> > +	{
> > +		int r2, r3;
> > +
> > +		r2 = READ_ONCE(y);
> > +		smp_rmb();
> > +		r3 = READ_ONCE(x);
> > +	}
> 
> Commit 047213158996f2 in -rcu/dev used the above test to illustrate a
> property of smp_mb__after_spinlock(), c.f., its header comment; if we
> accept this patch, we should consider updating that comment.

Indeed, the use of smb_mp__after_spinlock() illustrated in that comment
would become unnecessary.

Alan

