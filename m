Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B49AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F14A20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eLEA9iNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F14A20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbeKACiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:38:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41182 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729754AbeKACiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g/hPSRx+4EAfAyglcnx58y5eNBIaMBgVR8dSmawj/2E=; b=eLEA9iNGhfPnoTgUX6Om+gmYA
        D2ZydFVb+9xLmRTPyQyXfvhjRw34UXgB8bPAHpKNNKdkGC4C97vByCCNqajeYHNRwlmH1Za193WjP
        PJ5YABaTMjPJzAtKbi2JAsmleV2Y4CoxnRgKffnO7RZkblBdkp0mDXR/NmJuu0MeUhqIEA+YGei53
        n9J62SH39E1zqOuDw5a3LtlL4IcsEgUh7Xu0n/LTv+cCuuTa+mESG32AXbMAraz4BsEFe2OMuGL1r
        sjvBpw+9WYs2gGpShb8CoSZZw7W3iNIRaydCZS5dZNEqzzCtBxTaI7kyElKybw0S2JljrmVMc9DIC
        xrRc+5Y6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHuS7-0005ot-R8; Wed, 31 Oct 2018 17:38:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AA5F2029F87F; Wed, 31 Oct 2018 18:38:46 +0100 (CET)
Date:   Wed, 31 Oct 2018 18:38:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181031173846.GD13219@hirez.programming.kicks-ass.net>
References: <20181018082838.GA21611@localhost.localdomain>
 <20181018122331.50ed3212@luca64>
 <20181018104713.GC21611@localhost.localdomain>
 <20181018130811.61337932@luca64>
 <20181019113942.GH3121@hirez.programming.kicks-ass.net>
 <20181019225005.61707c64@nowhere>
 <20181024120335.GE29272@localhost.localdomain>
 <20181030104554.GB8177@hirez.programming.kicks-ass.net>
 <20181030120804.2f30c2da@sweethome>
 <2942706f-db18-6d38-02f7-ef21205173ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2942706f-db18-6d38-02f7-ef21205173ca@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 05:18:00PM +0100, Daniel Bristot de Oliveira wrote:
> Brazilian part of the Ph.D we are dealing with probabilistic worst case
> execution time, and to be able to use probabilistic methods, we need to remove
> the noise of the IRQs in the execution time [1]. So, IMHO, using
> CONFIG_IRQ_TIME_ACCOUNTING is a good thing.

> With this in mind: we do *not* use/have an exact admission test for all cases.
> By not having an exact admission test, we assume the user knows what he/she is
> doing. In this case, if they have a high load of IRQs... they need to know that:

So I mostly agree with the things you said; IRQs are a different
'context' or 'task' from the normal scheduled task. For AC we can
consider an average IRQ load etc..

But even if we get AC sufficient with an average IRQ load, there are
still the cases where the IRQs cluster. So, esp. for very short
runtimes, you can get this scenario.

> 1) Their periods should be consistent with the "interference" they might receive.
> 2) Their tasks can miss the deadline because of IRQs (and there is no way to
> avoid this without "throttling" IRQs...)

True.

> So, is it worth to put a duct tape for this case?

My point was mostly to to not misbehave. Maybe I got it wrong, that
happens ;-)

> >> @@ -1171,6 +1162,17 @@ static void update_curr_dl(struct rq *rq)
> >>  		return;
> >>  	}
> >>  
> >> +	wall = rq_clock();
> >> +	delta_wall = wall - dl_se->wallstamp;
> >> +	if (delta_wall > 0) {
> >> +		dl_se->walltime += delta_wall;
> >> +		dl_se->wallstamp = wall;
> >> +	}
> >> +
> >> +	/* check if rq_clock_task() has been too slow */
> >> +	if (unlikely(dl_se->walltime > dl_se->period))
> >> +		goto throttle;
> >> +
> 
> If I got it correctly, it can be the case that we would throttle a thread that,
> because of IRQs, received less CPU time than expected, right?

So the thinking was that when the actual walltime runtime (which
includes IRQs) exceeds the period, our whole CBS model breaks and we
need to replenish and push forward the deadline.

Maybe it should do that and not throttle.

Also, the walltime -= period thing should be fixed to never go negative
I think.
