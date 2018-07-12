Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADDFC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A3F20842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A3F20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbeGLRYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:24:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53826 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732417AbeGLRYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:24:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D70F0ED1;
        Thu, 12 Jul 2018 10:14:09 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A77103F589;
        Thu, 12 Jul 2018 10:14:09 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 131661AE2F86; Thu, 12 Jul 2018 18:14:52 +0100 (BST)
Date:   Thu, 12 Jul 2018 18:14:52 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
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
Message-ID: <20180712171451.GI26935@arm.com>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Thu, Jul 12, 2018 at 01:04:27PM -0400, Alan Stern wrote:
> On Thu, 12 Jul 2018, Peter Zijlstra wrote:
> > But as you (and Will) point out, we don't so much care about rmw-acquire
> > semantics as much as that we care about unlock+lock behaviour. Another
> > way to look at this is to define:
> > 
> >   smp-store-release + rmw-acquire := TSO (ideally smp_mb)
> > 
> > But then we also have to look at:
> > 
> >   rmw-release + smp-load-acquire
> >   rmw-release + rmw-acquire
> 
> Let's assume that rmw-release is equivalent, in terms of ordering
> strength, to smp_store_release().  Then we can focus our attention on
> just the acquire part.

I can live with that, but it does add another special case, where we could
otherwise just special case acquire/release for the load/store variants
vs everything else.

> On PowerPC, for instance, if spin_lock() used a full HWSYNC fence
> then unlock+lock would become RCsc -- even with no changes to
> spin_unlock().
> 
> > for completeness sake, and I would suggest they result in (at least) the
> > same (TSO) ordering as the one we really care about.
> > 
> > One alternative is to no longer use smp_store_release() for unlock(),
> > and say define atomic_set_release() to be in the rmw-release class
> > instead of being a simple smp_store_release().
> > 
> > Another, and I like this proposal least, is to introduce a new barrier
> > to make this all work.
> 
> This apparently boils down to two questions:
> 
> 	Should spin_lock/spin_unlock be RCsc?

I would love that to be the case, but I'm not asking you to fight that
battle :)

> 	Should rmw-acquire be strong enough so that smp_store_release + 
> 	rmw-acquire is RCtso?
> 
> If both answers are No, we end up with the v3 patch.  If the first
> answer is No and the second is Yes, we end up with the v2 patch.  The
> problem is that different people seem to want differing answers.

Just to be extra unhelpful: I'm happy with either v2 or v3. I suspect Daniel
is the one to convince on v2, because it's RISC-V that's affected by this.

Will
