Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2FDC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1702083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1702083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJBUFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:05:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37354 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeJBUFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:05:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BF687A9;
        Tue,  2 Oct 2018 06:21:45 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1BBD23F5B3;
        Tue,  2 Oct 2018 06:21:45 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 1C9081AE2DE4; Tue,  2 Oct 2018 14:22:09 +0100 (BST)
Date:   Tue, 2 Oct 2018 14:22:09 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        tglx@linutronix.de
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Message-ID: <20181002132208.GF16422@arm.com>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
 <20181001171700.GC13918@arm.com>
 <20181002123152.GA10055@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002123152.GA10055@andrea>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 02:31:52PM +0200, Andrea Parri wrote:
> > consider this scenario with your patch:
> > 
> > 1. CPU0 sees a locked val, and is about to do your xchg_relaxed() to set
> >    pending.
> > 
> > 2. CPU1 comes in and sets pending, spins on locked
> > 
> > 3. CPU2 sees a pending and locked val, and is about to enter the head of
> >    the waitqueue (i.e. it's right before xchg_tail()).
> > 
> > 4. The locked holder unlock()s, CPU1 takes the lock() and then unlock()s
> >    it, so pending and locked are now 0.
> > 
> > 5. CPU0 sets pending and reads back zeroes for the other fields
> > 
> > 6. CPU0 clears pending and sets locked -- it now has the lock
> > 
> > 7. CPU2 updates tail, sees it's at the head of the waitqueue and spins
> >    for locked and pending to go clear. However, it reads a stale value
> >    from step (4) and attempts the atomic_try_cmpxchg() to take the lock.
> > 
> > 8. CPU2 will fail the cmpxchg(), but then go ahead and set locked. At this
> >    point we're hosed, because both CPU2 and CPU0 have the lock.
> 
> Thanks for pointing this out.   I am wondering: can't we have a similar
> scenario with the current code (i.e., w/o these patches): what prevents
> the scenario reported below, following Peter's diagram, from happening?

The xchg_tail() in step (7) reads from the fetch_or_acquire() in step (5),
so I don't think we can see a stale value in the subsequent (overlapping)
acquire load.

Will

>   CPU0		CPU1		CPU2		CPU3
> 
> 0)						lock
> 						  trylock -> (0,0,1)
> 1)lock
>     trylock /* fail */
> 
> 2)		lock
> 		  trylock /* fail */
> 		  fetch_or_acquire -> (0,1,1)
> 		  wait-locked
> 
> 3)				lock
> 				  trylock /* fail */
> 				  goto queue
> 
> 4)						unlock -> (0,1,0)
> 		  clr_pnd_set_lck -> (0,0,1)
> 		  unlock -> (0,0,0)
> 
> 5)  fetch_or_acquire -> (0,1,0)
> 6)  clr_pnd_set_lck -> (0,0,1)
> 7)				  xchg_tail -> (n,0,1)
> 				  load_acquire <- (n,0,0) (from-4)
> 8)				  cmpxchg /* fail */
> 				  set_locked()
