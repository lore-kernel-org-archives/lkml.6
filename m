Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6C1C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655EC20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PThL+liw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655EC20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeJCPKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:10:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35428 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbeJCPKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EqcydC+Kb/4R8R9Cy4tSMAa3r/GGF2dvZWG1AJCCv5s=; b=PThL+liw8s/usXx44dzIqU1nI
        gMQzJN5vdmqaHmx5rjQ9+Az6NqcHeUiBHOfV9MovFJDDh//KgMJyl7XOzxffLzvH7p6S2WB5J1ant
        bU2ZBSBcZxDUWEEuWVaq5M+girEyTwXJLkd50HT1YiDViOvxAZiCBDO9NBfbRJt8op7aNfJW93ber
        3YDhTOkvNFGZ7yZ46UtXviqXSDtZyQDDJjQUl2E/X/0+Ib7oTYYIFYeaTBVmv/tgAkHf7jGd8uzk2
        UVqf7VOdE3YLzP/nE8Iu54jJmfqXXUJD5Z2bN3y/tVWbD7/5N/B2PwV7KhE+VmsAxM3tQIeWgOesq
        zUKki7C6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7cR2-0003ZH-9m; Wed, 03 Oct 2018 08:23:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D3B5202C1A1E; Wed,  3 Oct 2018 10:23:04 +0200 (CEST)
Date:   Wed, 3 Oct 2018 10:23:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     bigeasy@linutronix.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        daniel.wagner@siemens.com, Will Deacon <will.deacon@arm.com>,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, boqun.feng@gmail.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [Problem] Cache line starvation
Message-ID: <20181003082304.GL26858@hirez.programming.kicks-ass.net>
References: <20180921120226.6xjgr4oiho22ex75@linutronix.de>
 <20180921122058.GB24124@hirez.programming.kicks-ass.net>
 <CAHkRjk4Vvv5rc+habecu2xPiFGZ37onRzy1kCnFcBH2115U8jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHkRjk4Vvv5rc+habecu2xPiFGZ37onRzy1kCnFcBH2115U8jQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 08:51:50AM +0100, Catalin Marinas wrote:
> On Fri, 21 Sep 2018 at 13:22, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Fri, Sep 21, 2018 at 02:02:26PM +0200, Sebastian Andrzej Siewior wrote:
> > > We reproducibly observe cache line starvation on a Core2Duo E6850 (2
> > > cores), a i5-6400 SKL (4 cores) and on a NXP LS2044A ARM Cortex-A72 (4
> > > cores).
> > >
> > > The problem can be triggered with a v4.9-RT kernel by starting
> >
> > > Daniel reported that disabling ticket locks on 4.4 makes the problem go
> > > away, but he hasn't run a long time test yet and as we saw with 4.14 it can
> > > take quite a while.
> >
> > On 4.4 and 4.9 ARM64 still uses ticket locks. So I'm very interested to
> > know if the ticket locks on x86 really fix or just make it harder.
> >
> > I've been looking at qspinlock in the light of this and there is indeed
> > room for improvement. The ticket lock certainly is much simpler.
> 
> FWIW, in the qspinlock TLA+ model [1], if I replace the
> atomic_fetch_or() model with a try_cmpxchg loop, it violates the
> liveness properties with only 2 CPUs as one keeps locking/unlocking,
> hence changing the lock value, while the other repeatedly fails the
> cmpxchg. Your latest qspinlock patches seem to address this (couldn't
> get it to fail but the model is only sequentially consistent). Not
> sure that's what Sebastian is seeing but without your proposed
> qspinlock changes, ticket spinlocks may be a better bet for RT.

Right, and agreed. I did raise that point when you initially proposed
that fetch_or() for liveliness.

