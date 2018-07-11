Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AD2C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4F22083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4F22083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbeGKJp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:45:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60276 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbeGKJp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:45:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A113ED1;
        Wed, 11 Jul 2018 02:42:29 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A74D3F318;
        Wed, 11 Jul 2018 02:42:29 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 2EF6A1AE3828; Wed, 11 Jul 2018 10:43:11 +0100 (BST)
Date:   Wed, 11 Jul 2018 10:43:11 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180711094310.GA13963@arm.com>
References: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
 <20180710093821.GA5414@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710093821.GA5414@andrea>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 11:38:21AM +0200, Andrea Parri wrote:
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
> when paired with an smp_store_release(). Will was anticipating inserting
> arch hooks into the (generic) qspinlock code,  when we know that similar
> patterns are spread all over in (q)rwlocks, mutexes, rwsem, ... (please
> also notice that the informal documentation is currently treating these
> synchronization mechanisms equally as far as "ordering" is concerned...).
> 
> This distinction between locking operations and "other acquires" appears
> to me not only unmotivated but also extremely _fragile (difficult to use
> /maintain) when considering the analysis of synchronization mechanisms
> such as those mentioned above or their porting for new arch.

The main reason for this is because developers use spinlocks all of the
time, including in drivers. It's less common to use explicit atomics and
extremely rare to use explicit acquire/release operations. So let's make
locks as easy to use as possible, by giving them the strongest semantics
that we can whilst remaining a good fit for the instructions that are
provided by the architectures we support.

If you want to extend this to atomic rmws, go for it, but I don't think
it's nearly as important and there will still be ways to implement locks
with insufficient ordering guarantees if you want to.

Will
