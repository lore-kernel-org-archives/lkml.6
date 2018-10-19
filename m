Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67643ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121D421470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aWygRHnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121D421470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeJSVUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:20:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbeJSVUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f0mS9vA2ZdzRHix5CzYQhdZZWlCbtc4+gB0pxQ4uYv0=; b=aWygRHntyRxumVms7gx2uU26U
        /66zFa5khIAPIWj13zE+A0CGpbbH9fDhDc9a5PgQHtSmL9GvLEeZuTvcHoxNpCuK5/0POhZPQOyRz
        N2k3mdGNwHWsVEwq8NWYQa+uOPtUeOzN0Wz+7NvaGHkTvAgp+sMGmpAa5qK7OhYOA5okCgSrp5N+D
        vf+dHyvT3rUaxmtuhV/OnBW4wzaz62SAackqHa7txBgR1dlKJNzyJMuos2dlvH8E1xcQ8VzS74V+d
        IQ5dZtPgBq31EBQsHzHHr0vRwyExFaLp4ezWLfwrv1YypVhpXWNR3ZfdjE2sO9+Pw2PQ1YFx6qXb8
        jfN9w2hVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDUbd-00008Y-Fg; Fri, 19 Oct 2018 13:14:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EBBE520298568; Fri, 19 Oct 2018 15:14:18 +0200 (CEST)
Date:   Fri, 19 Oct 2018 15:14:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181019131418.GI3121@hirez.programming.kicks-ass.net>
References: <000000000000a4ee200578172fde@google.com>
 <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
 <20181016140322.GB3121@hirez.programming.kicks-ass.net>
 <20181016144045.GF9130@localhost.localdomain>
 <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
 <20181016153608.GH9130@localhost.localdomain>
 <20181018082838.GA21611@localhost.localdomain>
 <20181018094850.GW3121@hirez.programming.kicks-ass.net>
 <20181018123332.6f33f715@luca64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018123332.6f33f715@luca64>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 12:33:32PM +0200, luca abeni wrote:
> Hi Peter,
> 
> On Thu, 18 Oct 2018 11:48:50 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> [...]
> > > So, I tend to think that we might want to play safe and put some
> > > higher minimum value for dl_runtime (it's currently at 1ULL <<
> > > DL_SCALE). Guess the problem is to pick a reasonable value, though.
> > > Maybe link it someway to HZ? Then we might add a sysctl (or
> > > similar) thing with which knowledgeable users can do whatever they
> > > think their platform/config can support?  
> > 
> > Yes, a HZ related limit sounds like something we'd want. But if we're
> > going to do a minimum sysctl, we should also consider adding a
> > maximum, if you set a massive period/deadline, you can, even with a
> > relatively low u, incur significant delays.
> 
> I agree with this.
> 
> 
> > And do we want to put the limit on runtime or on period ?
> 
> I think we should have a minimum allowed runtime, a maximum allowed
> runtime, a minimum allowed period and a (per-user? per-control
> group?) maximum allowed utilization.

I was talking about a global !root max-u, but yes the cgroup max-u makes
definite sense as well.

> I suspect having a maximum period is useless, if we already enforce a
> maximum runtime.

Probably; yes. The asymmetry is unfortunate of course.

> > That is, something like:
> > 
> >   TICK_NSEC/2 < period < 10*TICK_NSEC
> 
> As written above I would not enforce a maximum period.

I'm confused: 'period < 10*TICK_NSEC' reads like a max to me.

(irrespective of the argument on wether the max should be HZ related;
and I think you and Juri made good argument for it not to be)

> > and/or
> > 
> >   TICK_NSEC/2 < runtime < 10*TICK_NSEC
> 
> I think (but I might be wrong) that "TICK_NSEC/2" is too large... I
> would divide the tick for a larger number (how many time do we want to
> allow the loop to run?)

It depends on how strict we want to enforce the no-interference rule.
The smaller we make this, the less accurate we enforce, the worse the
interference between tasks.

Note that we're only talking about a default; and HZ=100 is daft in any
case.

> And I think the maximum runtime should not be TICK-dependent... It is
> the maximum amount of time for which we allow the dealdine task to
> starve non-deadline tasks, so it should be an absolute time, not
> something HZ-dependent... No?

Agreed.

> > Hmm, for HZ=1000 that ends up with a max period of 10ms, that's far
> > too low, 24Hz needs ~41ms. We can of course also limit the runtime by
> > capping u for users (as we should anyway).
> 
> Regarding capping u for users: some time ago, with Juri we discussed
> the idea of having per-cgroup limits on the deadline utilization... I
> think this is a good idea (and if the userspace creates a cgroup per
> user, this results in per-user capping - but it is more flexible in
> general)

Agreed, that makes sense.
