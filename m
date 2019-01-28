Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48C5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8574B20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WY88YdWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfA1N6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:58:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36820 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfA1N6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CbSKuq8gbOVSeLddKe0qvIRvpEXxj8L97la8Qvn8jgo=; b=WY88YdWO8Y8JmXcrY81y+HAPs
        G3HyBzyOtTvYMy3+V4ycOvgdjitPJwXFi1VokoGoiEPSmq1PZ7J9nHwkEIs3TiKPMyjRLviKPY/PI
        A0Yx9niNkrX32YHvV/MdlBvYlWsyszyVWHbU9MpHOL3CfZuqZ6v+QezOmOUbhYgeggOP1cjI4RHCX
        7adDwvPvL+EPKdAd52QOzl2qpnIXdAmMK/mRMYJGhObXY9p5uBFVrqEGCDqq87iplBOaBjl8iKSMI
        eBBUgglYhWe/WS0EE9ztxPbxzEnM5gMmwuBLl8vBBD1a6JOwjZ5x4hO5+tnU6KBLjAXaSqVGEfNnm
        Avk/DTWWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1go7QN-0007PX-35; Mon, 28 Jan 2019 13:58:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0C07201EC174; Mon, 28 Jan 2019 14:58:04 +0100 (CET)
Date:   Mon, 28 Jan 2019 14:58:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
Message-ID: <20190128135804.GB28878@hirez.programming.kicks-ass.net>
References: <20181127081115.GB3625@osiris>
 <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
 <20181129112321.GB3449@osiris>
 <20190128134410.GA28485@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128134410.GA28485@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 02:44:10PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 29, 2018 at 12:23:21PM +0100, Heiko Carstens wrote:
> 
> > And indeed, if I run only this test case in an endless loop and do
> > some parallel work (like kernel compile) it currently seems to be
> > possible to reproduce the warning:
> > 
> > while true; do time ./testrun.sh nptl/tst-robustpi8 --direct ; done
> > 
> > within the build directory of glibc (2.28).
> 
> Right; so that reproduces for me.
> 
> After staring at all that for a while; trying to remember how it all
> worked (or supposed to work rather), I became suspiscous of commit:
> 
>   56222b212e8e ("futex: Drop hb->lock before enqueueing on the rtmutex")
> 
> And indeed, when I revert that; the above reproducer no longer works (as
> in, it no longer triggers in minutes and has -- so far -- held up for an
> hour+ or so).
> 
> That patch in particular allows futex_unlock_pi() to 'start' early:
> 
> 
> futex_lock_pi()			futex_unlock_pi()
>   lock hb
>   queue
>   lock wait_lock
>   unlock hb
> 					lock hb
> 					futex_top_waiter
> 					get_pi_state
> 					lock wait_lock
>   rt_mutex_proxy_start // fail
>   unlock wait_lock
> 					// acquired wait_lock
					unlock hb
> 					wake_futex_pi()
> 					rt_mutex_next_owner() // whoops, no waiter
> 					WARN

and simply removing that WARN, would allow futex_unlock_pi() to spin on
retry until the futex_lock_pi() CPU comes around to doing the lock hb
below:

>   lock hb
>   unqueue_me_pi

Which seems undesirable from a determinsm POV.


