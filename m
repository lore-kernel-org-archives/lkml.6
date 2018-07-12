Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C23DECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F5B208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F5B208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbeGLUzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:55:01 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:55156 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726966AbeGLUzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:55:01 -0400
Received: (qmail 553 invoked by uid 2102); 12 Jul 2018 16:43:46 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jul 2018 16:43:46 -0400
Date:   Thu, 12 Jul 2018 16:43:46 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
In-Reply-To: <20180712175228.GB3533@andrea>
Message-ID: <Pine.LNX.4.44L0.1807121637050.1306-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018, Andrea Parri wrote:

> > It seems reasonable to ask people to learn that locks have stronger
> > ordering guarantees than RMW atomics do.  Maybe not the greatest
> > situation in the world, but one I think we could live with.
> 
> Yeah, this was one of my main objections.

Does this mean you don't think you could live with it?

> > > Hence my proposal to strenghten rmw-acquire, because that is the basic
> > > primitive used to implement lock.
> > 
> > That was essentially what the v2 patch did.  (And my reasoning was
> > basically the same as what you have just outlined.  There was one
> > additional element: smp_store_release() is already strong enough for
> > TSO; the acquire is what needs to be stronger in the memory model.)
> 
> Mmh? see my comments to v2 (and your reply, in part., the part "At
> least, it's not a valid general-purpose implementation".).
> 
> 
> > > Another, and I like this proposal least, is to introduce a new barrier
> > > to make this all work.
> > 
> > This apparently boils down to two questions:
> > 
> > 	Should spin_lock/spin_unlock be RCsc?
> > 
> > 	Should rmw-acquire be strong enough so that smp_store_release + 
> > 	rmw-acquire is RCtso?
> > 
> > If both answers are No, we end up with the v3 patch.  If the first
> > answer is No and the second is Yes, we end up with the v2 patch.  The
> > problem is that different people seem to want differing answers.
> 
> Again, maybe you're confonding v2 with v1?

Oops, yes, I was.  v1 was the version that made RMW updates be RCtso.  
v2 and v3 affected only locking, the difference being that v2 used 
unlock-rf-lock-po and v3 used po-unlock-rf-lock-po.

Alan

