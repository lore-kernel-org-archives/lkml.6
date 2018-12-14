Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31A4C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AD92086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AD92086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbeLNC0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 21:26:48 -0500
Received: from netrider.rowland.org ([192.131.102.5]:58087 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728517AbeLNC0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 21:26:48 -0500
Received: (qmail 27930 invoked by uid 500); 13 Dec 2018 21:26:47 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Dec 2018 21:26:47 -0500
Date:   Thu, 13 Dec 2018 21:26:47 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     David Goldblatt <davidtgoldblatt@gmail.com>,
        <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, <triegel@redhat.com>,
        <libc-alpha@sourceware.org>, <andrea.parri@amarulasolutions.com>,
        <will.deacon@arm.com>, <peterz@infradead.org>,
        <boqun.feng@gmail.com>, <npiggin@gmail.com>, <dhowells@redhat.com>,
        <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>, <akiyks@gmail.com>,
        <dlustig@nvidia.com>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux: Implement membarrier function
In-Reply-To: <20181214002043.GP4170@linux.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1812132110100.26937-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018, Paul E. McKenney wrote:

> > > A good next step would be to automatically generate random tests along
> > > with an automatically generated prediction, like I did for RCU a few
> > > years back.  I should be able to generalize my time-based cheat for RCU to
> > > also cover SRCU, though sys_membarrier() will require a bit more thought.
> > > (The time-based cheat was to have fixed duration RCU grace periods and
> > > RCU read-side critical sections, with the grace period duration being
> > > slightly longer than that of the critical sections.  The number of
> > > processes is of course limited by the chosen durations, but that limit
> > > can easily be made insanely large.)
> > 
> > Imagine that each sys_membarrier call takes a fixed duration and each 
> > other instruction takes slightly less (the idea being that each 
> > instruction is a critical section).  Instructions can be reordered 
> > (although not across a sys_membarrier call), but no matter how the 
> > reordering is done, the result is disallowed.

This turns out not to be right.  Instead, imagine that each 
sys_membarrier call takes a fixed duration, T.  Other instructions can 
take arbitrary amounts of time and can be reordered abitrarily, with 
two restrictions:

	Instructions cannot be reordered past a sys_membarrier call;

	If instructions A and B are reordered then the time duration
	from B to A must be less than T.

If you prefer, you can replace the second restriction with something a 
little more liberal:

	If A and B are reordered and A ends up executing after a 
	sys_membarrier call (on any CPU) then B cannot execute before 
	that sys_membarrier call.

Of course, this form is a consequence of the more restrictive form.

> It gets a bit trickier with interleavings of different combinations
> of RCU, SRCU, and sys_membarrier().  Yes, your cat code very elegantly
> sorts this out, but my goal is to be able to explain a given example
> to someone.

I don't think you're going to be able to fit different combinations of
RCU, SRCU, and sys_membarrier into this picture.  How would you allow
tests with incorrect interleaving, such as GP - memb - RSCS - nothing,
while forbidding similar tests with correct interleaving?

Alan

