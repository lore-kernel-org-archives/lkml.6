Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C52CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32E62089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32E62089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933454AbeGJN5T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:57:19 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:33642 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S933255AbeGJN5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:57:18 -0400
Received: (qmail 1601 invoked by uid 2102); 10 Jul 2018 09:57:17 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jul 2018 09:57:17 -0400
Date:   Tue, 10 Jul 2018 09:57:17 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
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
In-Reply-To: <20180709214514.GJ3593@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1807100954490.1449-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018, Paul E. McKenney wrote:

> On Mon, Jul 09, 2018 at 04:01:57PM -0400, Alan Stern wrote:
> > More than one kernel developer has expressed the opinion that the LKMM
> > should enforce ordering of writes by locking.  In other words, given
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
> > 
> > All the architectures supported by the Linux kernel (including RISC-V)
> > do provide this ordering for locks, albeit for varying reasons.
> > Therefore this patch changes the model in accordance with the
> > developers' wishes.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Nice!
> 
> However, it doesn't apply against current -rcu.  Am I missing a patch?
> Or is this supposed to apply against origin/lkmm?

I wrote it based on 4.18-rc.  However, I can rebase it against your
current dev branch.

Alan

