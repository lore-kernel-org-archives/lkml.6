Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D057C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F9D20C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F9D20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbeGKQCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:02:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39296 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbeGKQCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:02:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9B737A9;
        Wed, 11 Jul 2018 08:57:09 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB0E63F5B1;
        Wed, 11 Jul 2018 08:57:09 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id D381B1AE53F8; Wed, 11 Jul 2018 16:57:51 +0100 (BST)
Date:   Wed, 11 Jul 2018 16:57:51 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180711155751.GC18477@arm.com>
References: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
 <20180710093821.GA5414@andrea>
 <20180711094310.GA13963@arm.com>
 <20180711123421.GA9673@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711123421.GA9673@andrea>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 02:34:21PM +0200, Andrea Parri wrote:
> On Wed, Jul 11, 2018 at 10:43:11AM +0100, Will Deacon wrote:
> > On Tue, Jul 10, 2018 at 11:38:21AM +0200, Andrea Parri wrote:
> > > This distinction between locking operations and "other acquires" appears
> > > to me not only unmotivated but also extremely _fragile (difficult to use
> > > /maintain) when considering the analysis of synchronization mechanisms
> > > such as those mentioned above or their porting for new arch.
> > 
> > The main reason for this is because developers use spinlocks all of the
> > time, including in drivers. It's less common to use explicit atomics and
> > extremely rare to use explicit acquire/release operations. So let's make
> > locks as easy to use as possible, by giving them the strongest semantics
> > that we can whilst remaining a good fit for the instructions that are
> > provided by the architectures we support.
> 
> Simplicity is the eye of the beholder.  From my POV (LKMM maintainer), the
> simplest solution would be to get rid of rfi-rel-acq and unlock-rf-lock-po
> (or its analogous in v3) all together:

It might be simple to model, but I worry this weakens our locking
implementations to a point where they will not be understood by the average
kernel developer. As I've said before, I would prefer "full" RCsc locking,
but that's not the case with architectures we currently support today, so
the next best thing is this "everything apart from W->R in the
inter-thread case" ordering, which isn't going to crop up unless you're
doing weird stuff anyway afaict.

> > If you want to extend this to atomic rmws, go for it, but I don't think
> > it's nearly as important and there will still be ways to implement locks
> > with insufficient ordering guarantees if you want to.
> 
> I don't want to "implement locks with insufficient ordering guarantees"
> (w.r.t. LKMM).  ;-)

I didn't mean you personally; I mean that somebody could write a lock that
mixes rmws and acquire/release, so they'd still have to deal with the
fallout even with your proposed changes.

Will
