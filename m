Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C48ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6622087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gmmPGm+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6622087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeGMLX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:23:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40424 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbeGMLX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LK1lMaYvGAuJC8yzEKLN8/ei2zhXm+LDYeKU4YFEbgQ=; b=gmmPGm+85vbV/9QPNSK0izc+z
        pA4D645tH3FLzdITvOi0yCQCsjzSMx04Gl46SOdafcG4a51pUdOUVK0i54t//pmCWCihXn25gmfep
        aeDmAx7OrZtGRIYhngQU2YMHuDp5lFpNUIfaF86zjjbtcPGRTa4zLG/bCeqHE8ZmqQvlHFtVOokS6
        Q3ix1QH74zYMjnK+wTkraHPJnjdmh2y4PqmNQAoBFJJfYihEGf7rLre1ai/vl0LittlVHbv91o2ob
        SqgBMBtN5+PvyLCKFQAQsuyc2xDK4Ic4SeDG5uk5UT2y/Wn9yHn/SGDuXgx6rWsSf+uDioiKtgYMW
        Rzq15bFQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdvwT-0006t3-8r; Fri, 13 Jul 2018 11:08:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6F9D20298BAC; Fri, 13 Jul 2018 13:08:51 +0200 (CEST)
Date:   Fri, 13 Jul 2018 13:08:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180713110851.GY2494@hirez.programming.kicks-ass.net>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
 <20180712172838.GU3593@linux.vnet.ibm.com>
 <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 11:10:58AM -0700, Linus Torvalds wrote:
> On Thu, Jul 12, 2018 at 11:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > The locking pattern is fairly simple and shows where RCpc comes apart
> > from expectation real nice.
> 
> So who does RCpc right now for the unlock-lock sequence? Somebody
> mentioned powerpc. Anybody else?

RISC-V followed, because the LKMM currently states it is allowed, in
fact LKMM is currently weaker than even PowerPC, which is what this
current discussion is about.

A number of people, including myself, are arguing for stronger lock
ordering (RCsc) but getting the LKMM to be at least as strong as Power
(RCtsc as coined by Daniel) which disallows full RCpc.

> How nasty would be be to make powerpc conform? I will always advocate
> tighter locking and ordering rules over looser ones..

mpe did a micro-bench a little while ago:

  http://lkml.iu.edu/hypermail/linux/kernel/1804.0/01990.html

which says 30% more expensive for uncontended lock+unlock. Which I admit
is fairly yuck. No macro bench results though.

