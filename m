Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C210C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F2725370
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bYcv/gJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F2725370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeGBMu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:50:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbeGBMu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BGq8aT8BlmdTdtvkLSydij6UmfiMSQjkCahEZ4njUTg=; b=bYcv/gJNLhdLg8K31m6mEFnwq
        /IfhkIemQfTqBQ+QG20Pmye8TaGmBBPDA4t1Yb+hDL4yNRnte+7fsOM2JeA5dXG4JEVI279Ckkc5F
        HTqBPFVt9IrbvZAM9PmMdLqJ8LCUJ1J+d3uXtokkszlll2wxKbmAzOCgpf/e0uSfQepChR+KvPd4M
        aykQtV3HgmBSGD6mwFIQxRLt2mFvb17ffiZsz73dDU7kTS2Oxmio65ZskYDvRiICDZCFNkw3/RqAB
        tEzTfKRhJHKLML84TPfkLYbkw5tQeqNfQ3HraQlKA/KbCVJn4hvYp89qYLHR+ekj6MFJ+UmYPmnGd
        wUXJspSww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZyHN-00069F-Gs; Mon, 02 Jul 2018 12:50:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D38A62029F1D9; Mon,  2 Jul 2018 14:50:03 +0200 (CEST)
Date:   Mon, 2 Jul 2018 14:50:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/3] locking: Clarify requirements for
 smp_mb__after_spinlock()
Message-ID: <20180702125003.GO2494@hirez.programming.kicks-ass.net>
References: <1530182480-13205-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1530182480-13205-3-git-send-email-andrea.parri@amarulasolutions.com>
 <20180628150550.GI2494@hirez.programming.kicks-ass.net>
 <20180628173045.GA4975@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628173045.GA4975@andrea>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 07:30:45PM +0200, Andrea Parri wrote:
> On Thu, Jun 28, 2018 at 05:05:50PM +0200, Peter Zijlstra wrote:
> > On Thu, Jun 28, 2018 at 12:41:19PM +0200, Andrea Parri wrote:
> > > - * This barrier must provide two things:
> > > - *
> > > - *   - it must guarantee a STORE before the spin_lock() is ordered against a
> > > - *     LOAD after it, see the comments at its two usage sites.
> > > - *
> > > - *   - it must ensure the critical section is RCsc.
> > > - *
> > > - * The latter is important for cases where we observe values written by other
> > > - * CPUs in spin-loops, without barriers, while being subject to scheduling.
> > > - *
> > > - * CPU0			CPU1			CPU2
> > > - *
> > > - *			for (;;) {
> > > - *			  if (READ_ONCE(X))
> > > - *			    break;
> > > - *			}
> > > - * X=1
> > > - *			<sched-out>
> > > - *						<sched-in>
> > > - *						r = X;
> > > - *
> > > - * without transitivity it could be that CPU1 observes X!=0 breaks the loop,
> > > - * we get migrated and CPU2 sees X==0.
> > 
> > Please don't remove that; that explains _why_ we need a full memory
> > barrier here.
> 
> Peter:
> 
> Both you and Boqun stated that the above snippet is "bad":
> 
>   http://lkml.kernel.org/r/20180312085646.GE4064@hirez.programming.kicks-ass.net
> 
> and I do agree with your assessment! ;-)

Right..

> I've no objection to keep that comment (together with the
> "clarification" suggested in this patch) _once_ replaced
> that snippet with something else (say, with the snippet
> Boqun suggested in:
> 
>   http://lkml.kernel.org/r/20180312085600.aczjkpn73axzs2sb@tardis ):
> 
> is this what you mean?

Yes. I much prefer to explain the why for rule than to just state them.
