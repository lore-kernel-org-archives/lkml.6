Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE70C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B7120875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B7120875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933594AbeGIQvV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:51:21 -0400
Received: from foss.arm.com ([217.140.101.70]:35132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933433AbeGIQvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:51:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A3837A9;
        Mon,  9 Jul 2018 09:51:19 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BDDF3F589;
        Mon,  9 Jul 2018 09:51:19 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id D59FF1AE3B14; Mon,  9 Jul 2018 17:52:00 +0100 (BST)
Date:   Mon, 9 Jul 2018 17:52:00 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        dlustig@nvidia.com
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180709165200.GA4689@arm.com>
References: <20180705150945.GA3699@andrea>
 <Pine.LNX.4.44L0.1807061629280.1396-100000@iolanthe.rowland.org>
 <20180706211055.GN3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706211055.GN3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:10:55PM -0700, Paul E. McKenney wrote:
> On Fri, Jul 06, 2018 at 04:37:21PM -0400, Alan Stern wrote:
> > On Thu, 5 Jul 2018, Andrea Parri wrote:
> > 
> > > > At any rate, it looks like instead of strengthening the relation, I
> > > > should write a patch that removes it entirely.  I also will add new,
> > > > stronger relations for use with locking, essentially making spin_lock
> > > > and spin_unlock be RCsc.
> > > 
> > > Thank you.
> > > 
> > > Ah let me put this forward: please keep an eye on the (generic)
> > > 
> > >   queued_spin_lock()
> > >   queued_spin_unlock()
> > > 
> > > (just to point out an example). Their implementation (in part.,
> > > the fast-path) suggests that if we will stick to RCsc lock then
> > > we should also stick to RCsc acq. load from RMW and rel. store.
> > 
> > A very good point.  The implementation of those routines uses
> > atomic_cmpxchg_acquire() to acquire the lock.  Unless this is
> > implemented with an operation or fence that provides write-write
> > ordering (in conjunction with a suitable release), qspinlocks won't
> > have the ordering properties that we want.
> > 
> > I'm going to assume that the release operations used for unlocking
> > don't need to have any extra properties; only the lock-acquire
> > operations need to be special (i.e., stronger than a normal
> > smp_load_acquire). This suggests that atomic RMW functions with acquire
> > semantics should also use this stronger form of acquire.
> > 
> > Does anybody have a different suggestion?
> 
> The approach you suggest makes sense to me.  Will, Peter, Daniel, any
> reasons why this approach would be a problem for you guys?

qspinlock is very much opt-in per arch, so we can simply require that
an architecture must have RCsc RmW atomics if they want to use qspinlock.
Should an architecture arise where that isn't the case, then we could
consider an arch hook in the qspinlock code, but I don't think we have
to solve that yet.

Will
