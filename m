Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FEBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B1B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oWt1VcQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfBZKqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:46:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50008 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZKqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aLtDm31IFnhB2t121sovdtLqgXBuVk+B8akRv5BTmCc=; b=oWt1VcQtHFdljFP0FRbOrpKwp
        6zAWOYHJVKwa/rf5AxrKrwbv76+zDtMag9krqky20oqEHwKTJEE+tSZxPDfo9AYcMLpP45k+rOZa5
        twTLBvHGgLPuKo6RGojMXDqRyO4NFRxCcDmcRSvHN6xQlaI5oaBuSB7P1KXrjsDgmLuls4DYSXrEw
        Azo6XDbtaMX3U3jEswHBJeCvuK5mSlsUec9ZY2SD8yEwLjJcsHiSzRJE1xyj+X1fTRPftzR/WNlvu
        IXS76BmCE6TW5edd5oVR30Ywjkz9aZgWZJjjaMaPHI/2U2mqVyp9w7b/9zpUGkhSqX7ExlJCN23+x
        imFt6UkUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyaFG-0004zv-Gj; Tue, 26 Feb 2019 10:45:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA4EB20269AFC; Tue, 26 Feb 2019 11:45:51 +0100 (CET)
Date:   Tue, 26 Feb 2019 11:45:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190226104551.GF32534@hirez.programming.kicks-ass.net>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
 <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226093009.GS32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:30:09AM +0100, Peter Zijlstra wrote:
> On Mon, Feb 25, 2019 at 09:55:17AM -0800, Paul E. McKenney wrote:
> > But if you know of any code in the Linux kernel that needs to compare
> > pointers, one of which might be in the process of being freed, please
> > do point me at it.
> 
> I'm having the utmost difficulty of understanding why that would be a
> problem. It's just a value. Freeing memory does not affect the actual
> memory or any pointers to it.
> 
> *confusion*
> 
> None of this makes any kind of sense.

I found and started to read:

  www.open-std.org/jtc1/sc22/wg14/www/docs/n2311.pdf

and that's all massive bong-hits. That's utterly insane.

Even the proposed semantics are crazy; they include UB and are therefore
broken on principle. But also; the provenance ID has words like:
"allocated storage duration", how is that well defined in the context of
concurrent execution?

Also, isn't the kernel filled with inter-object pointer arithmetic?

PNVI also looks like something that simply cannot work; how are we at
compile time supposed to know the active (concurrent modified) heap
layout. What is a 'live' object?




