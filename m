Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F08AC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E823020882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E823020882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeILT3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:29:22 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:52162 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726672AbeILT3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:29:22 -0400
Received: (qmail 2376 invoked by uid 2102); 12 Sep 2018 10:24:37 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Sep 2018 10:24:37 -0400
Date:   Wed, 12 Sep 2018 10:24:37 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc:     Daniel Lustig <dlustig@nvidia.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <mingo@kernel.org>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>, <akiyks@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
In-Reply-To: <20180911200328.GA4225@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1809121014050.1570-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Paul E. McKenney wrote:

> > I think what you meant to write in the second and third sentences was 
> > something more like this:
> > 
> > 	Any code in an RCU critical section that extends beyond the 
> > 	end of a given RCU grace period is guaranteed to see the 
> > 	effects of all accesses which were visible to the grace 
> > 	period's CPU before the start of the grace period.  Similarly, 
> > 	any code that follows an RCU grace period (on the grace 
> > 	period's CPU) is guaranteed to see the effects of all accesses 
> > 	which were visible to an RCU critical section that began
> > 	before the start of the grace period.
> 
> That looks to me to be an improvement, other than that the "(on the
> grace period's CPU)" seems a bit restrictive -- you could for example
> have a release-acquire chain starting after the grace period, right?

The restriction was deliberate.  Without the restriction people might 
think it applies to any code that happens after a grace period, which 
is not true (depending on what you mean by "happens after").

The business about a release-acquire chain is derivable from what I
wrote.  Since the chain starts on the grace period's CPU, the effect is
guaranteed to be visible there.  Then since release-acquire chains
preserve visibility, the effect is guaranteed to be visible to the code 
at the end of the chain.

> > Also, the document doesn't seem to explain how Tree RCU relies on the
> > lock-ordering guarantees of raw_spin_lock_rcu_node() and friends.  It
> > _says_ that these guarantees are used, but not how or where.  (Unless I 
> > missed something; I didn't read the document all that carefully.)
> 
> The closest is this sentence: "But the only part of rcu_prepare_for_idle()
> that really matters for this discussion are lines 37–39", which
> refers to this code:
> 
> 37     raw_spin_lock_rcu_node(rnp);
> 38     needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
> 39     raw_spin_unlock_rcu_node(rnp);
> 
> I could add a sentence explaining the importance of the
> smp_mb__after_unlock_lock() -- is that what you are getting at?

What I was really asking is for the document to explain what could go
wrong if the smp_mb__after_unlock_lock() call was omitted from
raw_spin_lock_rcu_node().  What assumptions or requirements in the Tree
RCU code might fail, and how/where in the code are these assumptions or
requirements used?


> > In any case, you should bear in mind that the lock ordering provided by
> > Peter's raw_spin_lock_rcu_node() and friends is not the same as what we
> > have been discussing for the LKMM:
> > 
> > 	Peter's routines are meant for the case where you release
> > 	one lock and then acquire another (for example, locks in 
> > 	two different levels of the RCU tree).
> > 
> > 	The LKMM patch applies only to cases where one CPU releases
> > 	a lock and then that CPU or another acquires the _same_ lock 
> > 	again.
> > 
> > As another difference, the litmus test given near the start of the
> > "Tree RCU Grace Period Memory Ordering Building Blocks" section would
> > not be forbidden by the LKMM, even with RCtso locks, if it didn't use
> > raw_spin_lock_rcu_node().  This is because the litmus test is forbidden
> > only when locks are RCsc, which is what raw_spin_lock_rcu_node()  
> > provides.
> 
> Agreed.
> 
> > So I don't see how the RCU code can be held up as an example either for
> > or against requiring locks to be RCtso.
> 
> Agreed again.  The use of smp_mb__after_unlock_lock() instead
> provides RCsc.  But this use case is deemed sufficiently rare that
> smp_mb__after_unlock_lock() is defined within RCU.

So let me repeat the original question which started this train of
thought: Can anybody point to any actual code in the kernel that relies
on locks being RCtso, or that could be simplified if locks were
guaranteed to be RCtso?

There have been claims that such code exists somewhere in RCU and the 
scheduler.  Where is it?

Alan

