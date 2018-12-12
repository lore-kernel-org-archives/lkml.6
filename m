Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13547C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65852084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65852084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeLLWMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:12:19 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:56054 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728376AbeLLWMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:12:19 -0500
Received: (qmail 6510 invoked by uid 2102); 12 Dec 2018 17:12:18 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Dec 2018 17:12:18 -0500
Date:   Wed, 12 Dec 2018 17:12:18 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     David Goldblatt <davidtgoldblatt@gmail.com>,
        <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, <triegel@redhat.com>,
        <libc-alpha@sourceware.org>, <andrea.parri@amarulasolutions.com>,
        <will.deacon@arm.com>, <peterz@infradead.org>,
        <boqun.feng@gmail.com>, <npiggin@gmail.com>, <dhowells@redhat.com>,
        <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>, <akiyks@gmail.com>,
        <dlustig@nvidia.com>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux: Implement membarrier function
In-Reply-To: <20181212215245.GC4170@linux.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1812121710350.1543-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018, Paul E. McKenney wrote:

> > > I believe that this ordering forbids the cycle:
> > > 
> > > 	Wa=1 > membs -> [m01] -> Rc=0 -> Wc=2 -> rcu_read_unlock() ->
> > > 		return from synchronize_rcu() -> Ra
> > > 
> > > Does this make sense, or am I missing something?
> > 
> > It's hard to tell.  What you have written here isn't justified by the
> > litmus test source code, since the position of m01 in P1's program
> > order is undetermined.  How do you justify m01 -> Rc, for example?
> 
> ... justifies Rc=0 following [m01].
> 
> > Write it this way instead, using the relations defined in the 
> > sys_membarrier patch for linux-kernel.cat:
> > 
> > 	memb ->memb-gp memb ->rcu-link Rc ->memb-rscsi Rc ->rcu-link
> > 		
> > 		rcu_read_unlock ->rcu-rscsi rcu_read_lock ->rcu-link 
> > 
> > 		synchronize_rcu ->rcu-gp synchronize_rcu ->rcu-link memb
> > 
> > Recall that:
> > 
> > 	memb-gp is the identity relation on sys_membarrier events,
> > 
> > 	rcu-link includes (po? ; fre ; po),
> > 
> > 	memb-rscsi is the identity relation on all events,
> > 
> > 	rcu-rscsi links unlocks to their corresponding locks, and
> > 
> > 	rcu-gp is the identity relation on synchronize_rcu events.
> > 
> > These facts justify the cycle above.
> > 
> > Leaving off the final rcu-link step, the sequence matches the
> > definition of rcu-fence (the relations are memb-gp, memb-rscsi, 
> > rcu-rscsi, rcu-gp with rcu-links in between).  Therefore the cycle is 
> > forbidden.
> 
> Understood, but that would be using the model to check the model.  ;-)

Well, what are you trying to accomplish?  Do you want to find an 
argument similar to the one I posted for the 6-CPU test to show that 
this test should be forbidden?

Alan

