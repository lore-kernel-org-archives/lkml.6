Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372D0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8A7260DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J8t0nXNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8A7260DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbeFZUIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:08:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbeFZUH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2KwjFI0WfqHFZrRjTq3BfJkBFtR1fu+yQxjXOxNAh0I=; b=J8t0nXNdCD5YnxTFh+Jcrp6iJ
        iWoCu6qkvbrUIipactZ3TPNDH+YlwwdgFMzKHroKv4V7Tv0aSoTHvp8830KGUQ51evZYo3Azd+l0r
        cIyZJ80KxHe9IYecGR+rlzIoQ/jABEiY4DRfEKo9MlJHrsFVqWHUkCv5UQL/gaMBLb0RbQBcfwN7w
        +bWYtRiuG81PFc0UhNpePG4EqaPhk4e9TCU61YSmbd88dUv5nizV1JBBGst3S57FsdeDaz0JyhQ8a
        +255AZnyMmQK88BGy9kbfVntJaape7zY7g9x46TA3SzACVdrHvon+V8VIqGr0ys1AS72OcdmTfEnS
        foipNTqRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXuFe-0005jM-K0; Tue, 26 Jun 2018 20:07:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1878A2029FA0A; Tue, 26 Jun 2018 22:07:45 +0200 (CEST)
Date:   Tue, 26 Jun 2018 22:07:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 13/22] rcu: Fix grace-period hangs due to
 race with CPU offline
Message-ID: <20180626200745.GR2494@hirez.programming.kicks-ass.net>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
 <20180626171048.2181-13-paulmck@linux.vnet.ibm.com>
 <20180626175119.GL2494@hirez.programming.kicks-ass.net>
 <20180626182950.GH3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626182950.GH3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:29:50AM -0700, Paul E. McKenney wrote:
> On Tue, Jun 26, 2018 at 07:51:19PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 26, 2018 at 10:10:39AM -0700, Paul E. McKenney wrote:
> > > Without special fail-safe quiescent-state-propagation checks, grace-period
> > > hangs can result from the following scenario:
> > > 
> > > 1.	CPU 1 goes offline.
> > > 
> > > 2.	Because CPU 1 is the only CPU in the system blocking the current
> > > 	grace period, as soon as rcu_cleanup_dying_idle_cpu()'s call to
> > > 	rcu_report_qs_rnp() returns.
> > > 
> > > 3.	At this point, the leaf rcu_node structure's ->lock is no longer
> > > 	held: rcu_report_qs_rnp() has released it, as it must in order
> > > 	to awaken the RCU grace-period kthread.
> > > 
> > > 4.	At this point, that same leaf rcu_node structure's ->qsmaskinitnext
> > > 	field still records CPU 1 as being online.  This is absolutely
> > > 	necessary because the scheduler uses RCU, and ->qsmaskinitnext
> > 
> > Can you expand a bit on this, where does the scheduler care about the
> > online state of the CPU that's about to call into arch_cpu_idle_dead()?
> 
> Because the CPU does a context switch between the time that the CPU gets
> marked offline from the viewpoint of cpu_offline() and the time that
> the CPU finally makes it to arch_cpu_idle_dead().  Plus reporting the
> quiescent state (rcu_report_qs_rnp()) can result in waking up RCU's
> grace-period kthread.  During that context switch and that wakeup,
> the scheduler needs RCU to continue paying attention to the outgoing
> CPU, right?

What you say is right, but I'm confused to its relevance. Afaict 2 above is:

	do_idle()
	  if (cpu_offline()) // true
	    cpuhp_report_idle_dead()
	      rcu_report_dead()
	        rcu_cleanup_dying_idle_cpu()
	    arch_cpu_idle_dead()

There is no scheduling between that and the slightly later call to
arch_cpu_idle_dead(), we're in the middle of the idle task, preemption
is firmly disabled.

AFAICT rcu_cleanup_dying_idle_cpu() can mark your CPU as offline, it's
about to die. Also, we have a comment in cpuhp_report_idle_dead() that
we can't use complete() because RCU just took our CPU out.

