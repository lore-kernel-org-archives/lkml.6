Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E553C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6FE20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6FE20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbeGKNLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732420AbeGKNLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:11:08 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D78082089B;
        Wed, 11 Jul 2018 13:06:50 +0000 (UTC)
Date:   Wed, 11 Jul 2018 09:06:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 4/7] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180711090649.68af40f9@gandalf.local.home>
In-Reply-To: <20180711125647.GG2476@hirez.programming.kicks-ass.net>
References: <20180628182149.226164-1-joel@joelfernandes.org>
        <20180628182149.226164-5-joel@joelfernandes.org>
        <20180711125647.GG2476@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 14:56:47 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jun 28, 2018 at 11:21:46AM -0700, Joel Fernandes wrote:
> >  static inline void tracepoint_synchronize_unregister(void)
> >  {
> > +	synchronize_srcu(&tracepoint_srcu);
> >  	synchronize_sched();
> >  }  
> 
> Given you below do call_rcu_sched() and then call_srcu(), isn't the
> above the wrong way around?

Good catch!

	release_probes()
		call_rcu_sched()
			---> rcu_free_old_probes() queued

	tracepoint_synchronize_unregister()
		synchronize_srcu(&tracepoint_srcu);
			< finishes right away >
		synchronize_sched()
			--> rcu_free_old_probes()
				--> srcu_free_old_probes() queued
	
Here tracepoint_synchronize_unregister() returned before the srcu
portion ran.


> 
> Also, does the above want to be barrier instead of synchronize, so as to
> guarantee completion of the callbacks.

Not sure what you mean here.

-- Steve

> 
> > +static void srcu_free_old_probes(struct rcu_head *head)
> >  {
> >  	kfree(container_of(head, struct tp_probes, rcu));
> >  }
> >  
> > +static void rcu_free_old_probes(struct rcu_head *head)
> > +{
> > +	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> > +}
> > +
> >  static inline void release_probes(struct tracepoint_func *old)
> >  {
> >  	if (old) {
> >  		struct tp_probes *tp_probes = container_of(old,
> >  			struct tp_probes, probes[0]);
> > +		/*
> > +		 * Tracepoint probes are protected by both sched RCU and SRCU,
> > +		 * by calling the SRCU callback in the sched RCU callback we
> > +		 * cover both cases. So let us chain the SRCU and sched RCU
> > +		 * callbacks to wait for both grace periods.
> > +		 */
> >  		call_rcu_sched(&tp_probes->rcu, rcu_free_old_probes);
> >  	}
> >  }  

