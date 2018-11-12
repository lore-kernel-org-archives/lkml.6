Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5BDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CAF223C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uwgjpo1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CAF223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeKLSxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:53:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39374 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbeKLSxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VTRX66HXL1eoQPasuf74XvFsWBt0U52yRurmwc48kbA=; b=Uwgjpo1EfhAPUdN6QtBDiTxFd
        xxXUbFJAqSQFpF0eSSkWFrDvx88scxx9u+m8cN3AXAFktvHWeXrbk3FfNO77xvZoMNe+4RIyJO88X
        MbPkJW0Tn0Z82SA+FMXyiDTvSVk35quJGiock5C9QZfPFt3gPexh2gRU1iqjsdgD60e0aUVABkTSG
        NzljVMJ2iAmYjm9xaOutTXQTSHl2lL//O/cskCO0WmZQmxfmT18H33L9e09l7ygzHt1ieSTyxyG2z
        1BV3Fj0T2UQcA4j4lB6S/flzqIcIp6s8QEnSpaI0cUQYMhXjkLU0rnURXkgjOhEmrU1f1PW1sq7v8
        P8QQslfsA==;
Received: from [64.114.255.114] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gM85R-0006rF-2K; Mon, 12 Nov 2018 09:00:49 +0000
Received: by worktop (Postfix, from userid 1000)
        id E7CD46E03B0; Mon, 12 Nov 2018 10:00:47 +0100 (CET)
Date:   Mon, 12 Nov 2018 10:00:47 +0100
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
Message-ID: <20181112090047.GN3056@worktop>
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-23-paulmck@linux.ibm.com>
 <20181112001233.GC3056@worktop>
 <20181112004528.GA4170@linux.ibm.com>
 <20181112005329.GG3056@worktop>
 <20181112014736.GB4170@linux.ibm.com>
 <20181112020710.GJ3056@worktop>
 <20181112022455.GD4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112022455.GD4170@linux.ibm.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 06:24:55PM -0800, Paul E. McKenney wrote:

> > > There were quite a few commits involved in making this happen.  Perhaps
> > > the most pertinent are these:
> > > 
> > > 3e3100989869 ("rcu: Defer reporting RCU-preempt quiescent states when disabled")
> > > 45975c7d21a1 ("rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds")
> > 
> > The latter; it does not mention that this will possible make
> > synchronize_sched() quite a bit more expensive on PREEMPT=y builds :/
> 
> In theory, sure.  In practice, people have switched any number of
> things from RCU-sched to RCU and back without problems.

Still, better safe than sorry. It was a rather big change in behaviour,
so it wouldn't have been strange to call that out.

> > But for PREEMPT=y synchronize_sched() can be quite a bit shorter than
> > synchronize_rcu(), since we don't have to wait for preempted read side
> > stuff.
> 
> Again, there are quite a few places that have managed that transition
> without issue.  Why do you expect this change to have problems that have
> not been seen elsewhere?

I'm not, I'm just taking issue with the Changelog.

> > Again, the patch didn't say that.
> > 
> > If the Changelog would've read something like:
> > 
> > "Since synchronize_sched() is now equivalent to synchronize_rcu(),
> > replace the synchronize_sched() usage such that we can eventually remove
> > the interface."
> > 
> > It would've been clear that the patch is a nop and what the purpose
> > was.
> 
> I can easily make that change.

Please, sufficient doesn't imply necessary etc.. A changelog should
always clarify why we do the patch.
