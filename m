Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C70AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5C324018
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5C324018
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbeGEOnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:43:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51182 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753483AbeGEOnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:43:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12B7F18A;
        Thu,  5 Jul 2018 07:43:45 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D78063F5BA;
        Thu,  5 Jul 2018 07:43:44 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 20F701AE3638; Thu,  5 Jul 2018 15:44:25 +0100 (BST)
Date:   Thu, 5 Jul 2018 15:44:25 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        dlustig@nvidia.com
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180705144424.GE14470@arm.com>
References: <20180625081920.GA5619@andrea>
 <Pine.LNX.4.44L0.1807031228250.1513-100000@iolanthe.rowland.org>
 <20180704121103.GB26941@arm.com>
 <20180705140029.GA5346@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705140029.GA5346@andrea>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

On Thu, Jul 05, 2018 at 04:00:29PM +0200, Andrea Parri wrote:
> On Wed, Jul 04, 2018 at 01:11:04PM +0100, Will Deacon wrote:
> > On Tue, Jul 03, 2018 at 01:28:17PM -0400, Alan Stern wrote:
> > > There's also read-write ordering, in the form of the LB pattern:
> > > 
> > > P0(int *x, int *y, int *z)
> > > {
> > > 	r0 = READ_ONCE(*x);
> > > 	smp_store_release(z, 1);
> > > 	r1 = smp_load_acquire(z);
> > > 	WRITE_ONCE(*y, 1);
> > > }
> > > 
> > > P1(int *x, int *y)
> > > {
> > > 	r2 = READ_ONCE(*y);
> > > 	smp_mp();
> > > 	WRITE_ONCE(*x, 1);
> > > }
> > > 
> > > exists (0:r0=1 /\ 1:r2=1)
> > 
> > The access types are irrelevant to the acquire/release primitives, so yes
> > that's also allowed.
> > 
> > > Would this be allowed if smp_load_acquire() was implemented with LDAPR?
> > > If the answer is yes then we will have to remove the rfi-rel-acq and
> > > rel-rf-acq-po relations from the memory model entirely.
> > 
> > I don't understand what you mean by "rfi-rel-acq-po", and I assume you mean
> > rel-rfi-acq-po for the other? Sounds like I'm confused here.
> 
> [Your reply about 1/2 suggests that you've figured this out now, IAC ...]

Yeah, the naming threw me because it's not the same order as the composition
in the actual definition (why not?). I typoed an extra 'po' suffix. Well
done for spotting it.

> "rfi-rel-acq" (as Alan wrote, and as I wrote before my question above...)
> is defined and currently used in linux-kernel.cat (and, FWIW, it has been
> so since when we upstreamed LKMM).
> 
> My point is that, as exemplified by the two tests I reported above, this
> relation already prevents you from implementing your acquire with LDAPR;
> so my/our question was not "can you run herd7 for me?" but rather "do you
> think that changes are needed to the .cat file?".

I mean, you can run herd on the armv8 memory model and see the answer to the
litmus test. So we have two options for the LKMM .cat file (the Arm one is
baked in silicon):

  1. Say that architectures with RCpc acquire/release instructions must
     instead use RCsc instructions (if they have them) or full fences

  2. Change the LKMM .cat file to allow RCpc acquire/release (note that I'd
     still like RCsc lock/unlock semantics, and I think that's actually the
     real case that matters here, but the currently difficulty in
     distinguishing the two in the .cat file has led to this broader
     ordering being enforced as a side-effect)

I prefer (2), because I think it's a safe and sensible relaxation to make
and accomodates what I consider to be a likely extension to weakly ordered
architectures that we might want to support efficiently. So yes, I think
changes are needed to the LKMM .cat file, but please don't view that as a
criticism. We change stuff all the time as long as it doesn't break userspace.

> This question goes back _at least_ to:
> 
>   http://lkml.kernel.org/r/1519301990-11766-1-git-send-email-parri.andrea@gmail.com
> 
> (see, in part., the "IMPORTANT" note at the bottom of the commit message)
> and that discussion later resulted in:
> 
>   0123f4d76ca63b ("riscv/spinlock: Strengthen implementations with fences")
>   5ce6c1f3535fa8 ("riscv/atomic: Strengthen implementations with fences")
> 
> (the latest _draft_ of the RISC-V specification, as pointed out by Daniel,
> 
>   https://github.com/riscv/riscv-isa-manual, Appendix A.5
> 
>  includes our "Linux mapping", although the currently-recommended mapping
>  differs and involves a "fence.tso [+ any acquire, including RCpc .aq]").

[I think the discussion at hand is broader than RISC-V, and I looped in
 Daniel already]

> My understanding is that your answer to this question is "Yes", but I am
> not sure about the "How/Which changes?"; of course, an answer his question
> _in the form_ of PATCHes would be appreciated! (but please also consider
> that I'll be offline for most of the time until next Monday.)

C'mon, I'm reviewing patches here. The onus shouldn't be on the reviewer to
come back with the correct version of the patch. I'm also not terribly
worried if LKMM says the wrong thing whilst we work out what the right
thing should be, but I /would/ be worried if we started adding full fences to
an architecture that has acquire/release instructions just because they're
RCpc. If it turns out that no other arch maintainers care, then fine,
because frankly this doesn't affect me, but so far it's basically been
silence and I'd really like some more input before we close the door on
them.

Will
