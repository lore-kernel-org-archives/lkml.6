Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8610CECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F40E2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rhXTGAl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F40E2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbeGMQ6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:58:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731972AbeGMQ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gy8pDiKzZTUCeNJYIlT1RtKr2J6ltkl0oC11SnsZcbA=; b=rhXTGAl9KpvajFikYYMyZu8Mj
        t3r7QDqM/pFy7vcad5xklklsLHLHQRVnwY26CJl36g21uWjD4ceyMNzgvu0KDLyZ5tO2Y/XtbUm2T
        xdrKyQdI2qQmOVpzljkPbW7qSJZmbgDIopbT+PSYQFoILaqhpKSbSxY80Cn/xn5GrU7Shazf9iJKK
        cX3JTMeY1PJQO1uflp4B3L4PYLmUEq1QXKtmusxBuJ4RE4UjT1TeV4GFPRHJhMki1rW0ihKCl4VvQ
        p6ZG9JQirfBk8CIXYhMbV7d2FCBSaj8P1ZJE2prHq2xqYLj5NawFvnP5Ck1U+TKn7H5Jj6JGndQyF
        TuZVIevhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fe19V-0005V1-Mr; Fri, 13 Jul 2018 16:42:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E78720289CB2; Fri, 13 Jul 2018 18:42:39 +0200 (CEST)
Date:   Fri, 13 Jul 2018 18:42:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180713164239.GZ2494@hirez.programming.kicks-ass.net>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
 <20180712172838.GU3593@linux.vnet.ibm.com>
 <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <20180713110851.GY2494@hirez.programming.kicks-ass.net>
 <87tvp3xonl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvp3xonl.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Michael,

On Fri, Jul 13, 2018 at 11:15:26PM +1000, Michael Ellerman wrote:
> I reran some numbers today with some slightly updated tests.
> 
> It varies quite a bit across machines and CPU revisions.
> 
> On one I get:
> 
> Lock/Unlock    Time             Time %    Total Cycles     Cycles  Cycles Delta
> lwsync/lwsync   79,290,859,955  100.0 %   290,160,065,087  145     -
> lwsync/sync    104,903,703,237  132.3 %   383,966,199,430  192     47
> 
> Another:
> 
> Lock/Unlock    Time             Time %    Total Cycles     Cycles  Cycles Delta
> lwsync/lwsync  71,662,395,722   100.0 %   252,403,777,715  126     -
> lwsync/sync    84,932,987,977   118.5 %   299,141,951,285  150     23
> 
> 
> So 18-32% slower, or 23-47 cycles.

Very good info. Note that another option is to put the SYNC in lock() it
doesn't really matter which of the two primitives gets it. I don't
suppose it really matters for timing either way around.

> Next week I can do some macro benchmarks, to see if it's actually
> detectable at all.
> 
> The other question is how they behave on a heavily loaded system.
> 
> 
> My personal preference would be to switch to sync, we don't want to be
> the only arch finding (or not finding!) exotic ordering bugs.
> 
> But we'd also rather not make our slow locks any slower than they have
> to be.

I completely understand, but I'll get you beer (lots) if you do manage
to make SYNC happen :-) :-)
