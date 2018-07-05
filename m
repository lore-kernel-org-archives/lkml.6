Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1F0C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EA32156B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EA32156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932168AbeGEPPO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:15:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51734 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754040AbeGEPPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:15:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DB3318A;
        Thu,  5 Jul 2018 08:15:13 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2A923F5BA;
        Thu,  5 Jul 2018 08:15:12 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 20F321AE3638; Thu,  5 Jul 2018 16:15:53 +0100 (BST)
Date:   Thu, 5 Jul 2018 16:15:53 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
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
Message-ID: <20180705151552.GG14470@arm.com>
References: <20180705144656.GF14470@arm.com>
 <Pine.LNX.4.44L0.1807051051110.1697-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807051051110.1697-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 10:57:28AM -0400, Alan Stern wrote:
> On Thu, 5 Jul 2018, Will Deacon wrote:
> > On Thu, Jul 05, 2018 at 10:21:36AM -0400, Alan Stern wrote:
> > > On Wed, 4 Jul 2018, Will Deacon wrote:
> > > > On Tue, Jul 03, 2018 at 01:28:17PM -0400, Alan Stern wrote:
> > > > > Would this be allowed if smp_load_acquire() was implemented with LDAPR?
> > > > > If the answer is yes then we will have to remove the rfi-rel-acq and
> > > > > rel-rf-acq-po relations from the memory model entirely.
> > > > 
> > > > I don't understand what you mean by "rfi-rel-acq-po", and I assume you mean
> > > > rel-rfi-acq-po for the other? Sounds like I'm confused here.
> > > 
> > > "rfi-rel-acq" is the relation which was removed by the first of my two
> > > patches (it is now back in business since Paul reverted the commits),
> > > and "rel-rf-acq-po" is the relation that was introduced to replace it.
> > 
> > Sorry, yes, I realised this after I'd replied. Curious: but why do you name
> > the relations this way around, as opposed to e.g. rel-rfi-acq? It's
> > obviously up to you, but I just couldn't figure out what inspired the
> > ordering.
> 
> I no longer remember the reason for naming "rfi-rel-acq" the way I did.  
> As you say, it doesn't make a lot of sense.

Fair enough!

> The reason for "rel-rf-acq-po" instead of "rel-rfi-acq-po" was because 
> the second of the two patches uses that relation in a context where the 
> release and the acquire might very well run on different CPUs.

Ok, that makes sense. I realised that I've only been thinking about RCpc
making a difference in the rfi case, because Armv8 is multi-copy atomic
so we don't allow early forwarding from a release to an RCpc acquire
if they are from different CPUs.

Again, I'd be interested in what other architectures have to say here (i.e.
whether RCpc acquire/release instructions are likely to exist in a non
multi-copy atomic architecture).

Will
