Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFDEECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C3F208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C3F208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbeGMJse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:48:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60506 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbeGMJsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:48:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8B77ED1;
        Fri, 13 Jul 2018 02:34:42 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B95823F5AD;
        Fri, 13 Jul 2018 02:34:42 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 5A5371AE35DD; Fri, 13 Jul 2018 10:35:25 +0100 (BST)
Date:   Fri, 13 Jul 2018 10:35:25 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Daniel Lustig <dlustig@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180713093524.GC32020@arm.com>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
 <20180712172838.GU3593@linux.vnet.ibm.com>
 <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com>
 <20180713090637.GA10601@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713090637.GA10601@andrea>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:07:11AM +0200, Andrea Parri wrote:
> On Thu, Jul 12, 2018 at 07:05:39PM -0700, Daniel Lustig wrote:
> > On 7/12/2018 11:10 AM, Linus Torvalds wrote:
> > > On Thu, Jul 12, 2018 at 11:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >>
> > >> The locking pattern is fairly simple and shows where RCpc comes apart
> > >> from expectation real nice.
> > > 
> > > So who does RCpc right now for the unlock-lock sequence? Somebody
> > > mentioned powerpc. Anybody else?
> > > 
> > > How nasty would be be to make powerpc conform? I will always advocate
> > > tighter locking and ordering rules over looser ones..
> > > 
> > >             Linus
> > 
> > RISC-V probably would have been RCpc if we weren't having this discussion.
> > Depending on how we map atomics/acquire/release/unlock/lock, we can end up
> > producing RCpc, "RCtso" (feel free to find a better name here...), or RCsc
> > behaviors, and we're trying to figure out which we actually need.
> > 
> > I think the debate is this:
> > 
> > Obviously programmers would prefer just to have RCsc and not have to figure out
> > all the complexity of the other options.  On x86 or architectures with native
> > RCsc operations (like ARMv8), that's generally easy enough to get.
> > 
> > For weakly-ordered architectures that use fences for ordering (including
> > PowerPC and sometimes RISC-V, see below), though, it takes extra fences to go
> > from RCpc to either "RCtso" or RCsc.  People using these architectures are
> > concerned about whether there's a negative performance impact from those extra
> > fences.
> > 
> > However, some scheduler code, some RCU code, and probably some other examples
> > already implicitly or explicitly assume unlock()/lock() provides stronger
> > ordering than RCpc.  So, we have to decide whether to:
> > 1) define unlock()/lock() to enforce "RCtso" or RCsc, insert more fences on
> > PowerPC and RISC-V accordingly, and probably negatively regress PowerPC
> > 2) leave unlock()/lock() as enforcing only RCpc, fix any code that currently
> > assumes something stronger than RCpc is being provided, and hope people don't
> > get it wrong in the future
> > 3) some mixture like having unlock()/lock() be "RCtso" but smp_store_release()/
> > smp_cond_load_acquire() be only RCpc
> > 
> > Also, FWIW, if other weakly-ordered architectures come along in the future and
> > also use any kind of lightweight fence rather than native RCsc operations,
> > they'll likely be in the same boat as RISC-V and Power here, in the sense of
> > not providing RCsc by default either.
> > 
> > Is that a fair assessment everyone?
> 
> It's for me, thank you!  And as we've seen, there are arguments for each of
> the above three choices.  I'm afraid that (despite Linus's statement  ;-)),
> my preference would currently go to (2).

And, since we're stating preferences, I'll reiterate my preference towards:

	* RCsc unlock/lock
	* RCpc release/acquire
	* Not fussed about atomic rmws, but having them closer to RCsc would
	  make it easier to implement and reason about generic locking
	  implementations (i.e. reduce the number of special ordering cases
	  and/or magic barrier macros)

Will
