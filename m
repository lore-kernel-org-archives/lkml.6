Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D8EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7606C208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ul+rtrIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7606C208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbeKLL6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:58:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbeKLL6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n4x0JQIDgYsZMqYxMLcRzz/KLTwieUnDwyzO35zu4m0=; b=Ul+rtrIt1YZj50KE0KoJp9ckU
        e3G1zLDpgEJJKbU66cTerzgx7s2I0+QjKrRxSGuS8b4atgVIDJexID56WTactXVcFUCewsktcykOn
        WsF5olZPjUoXKc0BfpmhHtGnlAnRSMqncjZLMmSWUZVELEpplADB40fUamzvEatc9rkb2723WTc6j
        z26j2GsyOkgvykyG9l+BDpzZEV/IFn26aoF/DI6vqCkZxKGvE90d0CWA4/AovSbK4iRPp1EEP2H7e
        Zna6MKvsjjO4cHlp/baNJRtZHdy7U1dw5G1O25CzjYjBvcq99Lv/KTvtW7FS4u4lV3YxkBu2yg37m
        OovhtVgfg==;
Received: from [64.114.255.114] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gM1d8-0000jF-VY; Mon, 12 Nov 2018 02:07:11 +0000
Received: by worktop (Postfix, from userid 1000)
        id 542EA6E0795; Mon, 12 Nov 2018 03:07:10 +0100 (CET)
Date:   Mon, 12 Nov 2018 03:07:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 23/41] sched: Replace synchronize_sched()
 with synchronize_rcu()
Message-ID: <20181112020710.GJ3056@worktop>
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-23-paulmck@linux.ibm.com>
 <20181112001233.GC3056@worktop>
 <20181112004528.GA4170@linux.ibm.com>
 <20181112005329.GG3056@worktop>
 <20181112014736.GB4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112014736.GB4170@linux.ibm.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 05:47:36PM -0800, Paul E. McKenney wrote:
> On Mon, Nov 12, 2018 at 01:53:29AM +0100, Peter Zijlstra wrote:
> > On Sun, Nov 11, 2018 at 04:45:28PM -0800, Paul E. McKenney wrote:
> > > On Mon, Nov 12, 2018 at 01:12:33AM +0100, Peter Zijlstra wrote:
> > > > On Sun, Nov 11, 2018 at 11:43:52AM -0800, Paul E. McKenney wrote:
> > > > > Now that synchronize_rcu() waits for preempt-disable regions of code
> > > > > as well as RCU read-side critical sections, synchronize_sched() can be
> > > > > replaced by synchronize_rcu().  This commit therefore makes this change.
> > > > 
> > > > Yes, but it also waits for an actual RCU quiestent state, which makes
> > > > synchoinize_rcu() potentially much more expensive than an actual
> > > > synchronize_sched().
> > > 
> > > None of the readers have changed.
> > > 
> > > For the updaters, if CONFIG_PREEMPT=n, synchronize_rcu() and
> > > synchronize_sched() always were one and the same.  When CONFIG_PREEMPT=y,
> > > synchronize_rcu() and synchronize_sched() are now one and the same.
> > 
> > The Changelog does not state this; and does the commit that makes that
> > happen state the regression potential?
> 
> The Changelog says this:
> 
> 	Now that synchronize_rcu() waits for preempt-disable
> 	regions of code as well as RCU read-side critical sections,
> 	synchronize_sched() can be replaced by synchronize_rcu().
> 	This commit therefore makes this change.
> 
> The "synchronize_rcu() waits for preempt-disable regions of code as
> well as RCU read-side critical sections" seems pretty unambiguous to me.
> Exactly what more are you wanting said there?

The quoted bit only states that synchronize_rcu() is sufficient; it does
not say it is equivalent and the patch is a nop. It also doesn't say
that the purpose is to get rid of the synchronize_sched() function.

> There were quite a few commits involved in making this happen.  Perhaps
> the most pertinent are these:
> 
> 3e3100989869 ("rcu: Defer reporting RCU-preempt quiescent states when disabled")
> 45975c7d21a1 ("rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds")

The latter; it does not mention that this will possible make
synchronize_sched() quite a bit more expensive on PREEMPT=y builds :/

> Normal grace periods are almost always quite long compared to typical
> read-side critical sections, preempt-disable regions of code, and so on.
> So in the common case this should be OK.  Or are you instead worried
> about synchronize_sched_expedited()?

No, I still feel expedited should not exist at all ;-)

But for PREEMPT=y synchronize_sched() can be quite a bit shorter than
synchronize_rcu(), since we don't have to wait for preempted read side
stuff.

> > > > So why are we doing this?
> > > 
> > > Given that synchronize_rcu() and synchronize_sched() are now always one
> > > and the same, this is a distinction without a difference.
> > 
> > The Changelog did not state a reason for the patch. Therefore it is a
> > bad patch.
> 
> ???  Here is the current definition of synchronize_sched() in mainline:
> 
> 	static inline void synchronize_sched(void)
> 	{
> 		synchronize_rcu();
> 	}

Again, the patch didn't say that.

If the Changelog would've read something like:

"Since synchronize_sched() is now equivalent to synchronize_rcu(),
replace the synchronize_sched() usage such that we can eventually remove
the interface."

It would've been clear that the patch is a nop and what the purpose
was.
