Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC6AC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F2B214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KgYHFLkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F2B214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJRRtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:49:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeJRRtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uJZ5rRBzU9/M15ru97mTJlkbfqXgg+Jj5ja5EWlv7q4=; b=KgYHFLkKgXuv4LFvcw7BVprhm
        6dFzPW3IWJ+Jq41tfThEM+hO5NIqF6eqxhfgC0Pl6GiOhetg/q5Zc4+yjz2kLpSWJ1nIxyn+h+kn8
        MXaWQizlv3HFEwUQcK6xF3UMUrNrW9bHS05n6fnE0bKkO+QktpdJmGaZUhIN5egj5yu0PfG15A7rZ
        nAuwLMf3QcbaecgSTlcRTieOo9jgddyYmJIApjmqnTy0kwHLuX/yRQ42sCza8fe5UhZgLQ5F2+Bpj
        AX/Mojw5TdVT6dAE9FwnSOmKiaLPHWMJqjTlPghCuDXz8WsTinL/D98PA1mnStmqMpfZi0sjnBr7t
        43lflaLew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gD4vE-0001Tf-Pq; Thu, 18 Oct 2018 09:48:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8221120297B7F; Thu, 18 Oct 2018 11:48:50 +0200 (CEST)
Date:   Thu, 18 Oct 2018 11:48:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com,
        Luca Abeni <luca.abeni@santannapisa.it>, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181018094850.GW3121@hirez.programming.kicks-ass.net>
References: <000000000000a4ee200578172fde@google.com>
 <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
 <20181016140322.GB3121@hirez.programming.kicks-ass.net>
 <20181016144045.GF9130@localhost.localdomain>
 <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
 <20181016153608.GH9130@localhost.localdomain>
 <20181018082838.GA21611@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018082838.GA21611@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 10:28:38AM +0200, Juri Lelli wrote:

> Another side problem seems also to be that with such tiny parameters we
> spend lot of time in the while (dl_se->runtime <= 0) loop of replenish_dl_
> entity() (actually uselessly, as deadline is most probably going to
> still be in the past when eventually runtime becomes positive again), as
> delta_exec is huge w.r.t. runtime and runtime has to keep up with tiny
> increments of dl_runtime. I guess we could ameliorate things here by
> limiting the number of time we execute the loop before bailing out.

That's the "DL replenish lagged too much" case, right? Yeah, there is
only so much we can recover from.

Funny that GCC actually emits that loop; sometimes we've had to fight
GCC not to turn that into a division.

But yes, I suppose we can put a limit on how many periods we can lag
before just giving up.

> So, I tend to think that we might want to play safe and put some higher
> minimum value for dl_runtime (it's currently at 1ULL << DL_SCALE).
> Guess the problem is to pick a reasonable value, though. Maybe link it
> someway to HZ? Then we might add a sysctl (or similar) thing with which
> knowledgeable users can do whatever they think their platform/config can
> support?

Yes, a HZ related limit sounds like something we'd want. But if we're
going to do a minimum sysctl, we should also consider adding a maximum,
if you set a massive period/deadline, you can, even with a relatively
low u, incur significant delays.

And do we want to put the limit on runtime or on period ?

That is, something like:

  TICK_NSEC/2 < period < 10*TICK_NSEC

and/or

  TICK_NSEC/2 < runtime < 10*TICK_NSEC

Hmm, for HZ=1000 that ends up with a max period of 10ms, that's far too
low, 24Hz needs ~41ms. We can of course also limit the runtime by
capping u for users (as we should anyway).



