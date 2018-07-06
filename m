Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF4BC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03397208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03397208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934180AbeGFUhX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:37:23 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:38216 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S932884AbeGFUhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:37:22 -0400
Received: (qmail 4838 invoked by uid 2102); 6 Jul 2018 16:37:21 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jul 2018 16:37:21 -0400
Date:   Fri, 6 Jul 2018 16:37:21 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
cc:     Will Deacon <will.deacon@arm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <dlustig@nvidia.com>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by release-acquire
 and by locks
In-Reply-To: <20180705150945.GA3699@andrea>
Message-ID: <Pine.LNX.4.44L0.1807061629280.1396-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2018, Andrea Parri wrote:

> > At any rate, it looks like instead of strengthening the relation, I
> > should write a patch that removes it entirely.  I also will add new,
> > stronger relations for use with locking, essentially making spin_lock
> > and spin_unlock be RCsc.
> 
> Thank you.
> 
> Ah let me put this forward: please keep an eye on the (generic)
> 
>   queued_spin_lock()
>   queued_spin_unlock()
> 
> (just to point out an example). Their implementation (in part.,
> the fast-path) suggests that if we will stick to RCsc lock then
> we should also stick to RCsc acq. load from RMW and rel. store.

A very good point.  The implementation of those routines uses
atomic_cmpxchg_acquire() to acquire the lock.  Unless this is
implemented with an operation or fence that provides write-write
ordering (in conjunction with a suitable release), qspinlocks won't
have the ordering properties that we want.

I'm going to assume that the release operations used for unlocking
don't need to have any extra properties; only the lock-acquire
operations need to be special (i.e., stronger than a normal
smp_load_acquire). This suggests that atomic RMW functions with acquire
semantics should also use this stronger form of acquire.

Does anybody have a different suggestion?

Alan

