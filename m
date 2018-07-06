Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD4EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160FE23F40
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160FE23F40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753522AbeGFJYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:24:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33560 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753061AbeGFJYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:24:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 527C2ED1;
        Fri,  6 Jul 2018 02:24:49 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 245333F2EA;
        Fri,  6 Jul 2018 02:24:49 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 9F81C1AE3AF0; Fri,  6 Jul 2018 10:25:29 +0100 (BST)
Date:   Fri, 6 Jul 2018 10:25:29 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Daniel Lustig <dlustig@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180706092529.GB17733@arm.com>
References: <20180704121103.GB26941@arm.com>
 <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
 <20180705153140.GO3593@linux.vnet.ibm.com>
 <b41849a8-76cd-2375-dd80-c1bdeb9ea7d2@nvidia.com>
 <20180705162225.GH14470@arm.com>
 <20180705165602.GQ3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705165602.GQ3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 09:56:02AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 05, 2018 at 05:22:26PM +0100, Will Deacon wrote:
> > On Thu, Jul 05, 2018 at 08:44:39AM -0700, Daniel Lustig wrote:
> > > On 7/5/2018 8:31 AM, Paul E. McKenney wrote:
> > > > On Thu, Jul 05, 2018 at 10:21:36AM -0400, Alan Stern wrote:
> > > >> At any rate, it looks like instead of strengthening the relation, I
> > > >> should write a patch that removes it entirely.  I also will add new,
> > > >> stronger relations for use with locking, essentially making spin_lock
> > > >> and spin_unlock be RCsc.
> > > > 
> > > > Only in the presence of smp_mb__after_unlock_lock() or
> > > > smp_mb__after_spinlock(), correct?  Or am I confused about RCsc?
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > 
> > > In terms of naming...is what you're asking for really RCsc?  To me,
> > > that would imply that even stores in the first critical section would
> > > need to be ordered before loads in the second critical section.
> > > Meaning that even x86 would need an mfence in either lock() or unlock()?
> > 
> > I think a LOCK operation always implies an atomic RmW, which will give
> > full ordering guarantees on x86. I know there have been interesting issues
> > involving I/O accesses in the past, but I think that's still out of scope
> > for the memory model.
> > 
> > Peter will know.
> 
> Agreed, x86 locked operations imply full fences, so x86 will order the
> accesses in consecutive critical sections with respect to an observer
> not holding the lock, even stores in earlier critical sections against
> loads in later critical sections.  We have been discussing tightening
> LKMM to make an unlock-lock pair order everything except earlier stores
> vs. later loads.  (Of course, if everyone holds the lock, they will see
> full ordering against both earlier and later critical sections.)
> 
> Or are you pushing for something stronger?

I (and I think Peter) would like something stronger, but we can't have
nice things ;)

Anyhow, that's not really related to this patch series, so sorry for
mis-speaking and thanks to everybody who piled on with corrections! I got
a bit arm-centric for a moment. I think Alan got the gist of it, so I'll
wait to see what he posts.

Will
