Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB6FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B313208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B313208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934101AbeGJPer (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:34:47 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:34360 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1754384AbeGJPeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:34:46 -0400
Received: (qmail 4006 invoked by uid 2102); 10 Jul 2018 11:34:45 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jul 2018 11:34:45 -0400
Date:   Tue, 10 Jul 2018 11:34:45 -0400 (EDT)
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
In-Reply-To: <20180710152404.GA11437@andrea>
Message-ID: <Pine.LNX.4.44L0.1807101127320.1449-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018, Andrea Parri wrote:

> > >   ACQUIRE operations include LOCK operations and both smp_load_acquire()
> > >   and smp_cond_acquire() operations.  [BTW, the latter was replaced by
> > >   smp_cond_load_acquire() in 1f03e8d2919270 ...]
> > > 
> > >   RELEASE operations include UNLOCK operations and smp_store_release()
> > >   operations. [...]
> > > 
> > >   [...] after an ACQUIRE on a given variable, all memory accesses
> > >   preceding any prior RELEASE on that same variable are guaranteed
> > >   to be visible.
> > 
> > As far as I can see, these statements remain valid.
> 
> Interesting; ;-)  What does these statement tells you ;-)  when applied
> to a: and b: below?
> 
>   a: WRITE_ONCE(x, 1); // "preceding any prior RELEASE..."
>   smp_store_release(&s, 1);
>   smp_load_acquire(&s);
>   b: WRITE_ONCE(y, 1); // "after an ACQUIRE..."

The first statement tells me that b: follows an ACQUIRE.

The second tells me that a: precedes a RELEASE.

And the third tells me that any READ_ONCE(x) statements coming po-after 
b: would see x = 1 or a later value of x.  (Of course, they would have 
to see that anyway because of the cache coherency rules.)

More to the point, given:

P0()
{
	WRITE_ONCE(x, 1);
	a: smp_store_release(&s, 1);
}

P1()
{
	b: r1 = smp_load_acquire(&s);
	r2 = READ_ONCE(x);
}

the third statement tells me that if r1 = 1 (that is, if a: is prior to
b:) then r2 must be 1.

Alan

