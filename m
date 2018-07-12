Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05D8C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED0321471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED0321471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403878AbeGLBdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 21:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403839AbeGLBdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 21:33:32 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A51472146F;
        Thu, 12 Jul 2018 01:26:28 +0000 (UTC)
Date:   Wed, 11 Jul 2018 21:26:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20180711212626.5992e2c8@vmware.local.home>
In-Reply-To: <20180712003100.GC32091@joelaf.mtv.corp.google.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
        <20180628182149.226164-5-joel@joelfernandes.org>
        <20180711125647.GG2476@hirez.programming.kicks-ass.net>
        <20180711090649.68af40f9@gandalf.local.home>
        <20180712003100.GC32091@joelaf.mtv.corp.google.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 17:31:00 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Wed, Jul 11, 2018 at 09:06:49AM -0400, Steven Rostedt wrote:
> > On Wed, 11 Jul 2018 14:56:47 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > On Thu, Jun 28, 2018 at 11:21:46AM -0700, Joel Fernandes wrote:  
> > > >  static inline void tracepoint_synchronize_unregister(void)
> > > >  {
> > > > +	synchronize_srcu(&tracepoint_srcu);
> > > >  	synchronize_sched();
> > > >  }    
> > > 
> > > Given you below do call_rcu_sched() and then call_srcu(), isn't the
> > > above the wrong way around?  
> > 
> > Good catch!
> > 
> > 	release_probes()
> > 		call_rcu_sched()  
> > 			---> rcu_free_old_probes() queued  
> > 
> > 	tracepoint_synchronize_unregister()
> > 		synchronize_srcu(&tracepoint_srcu);
> > 			< finishes right away >
> > 		synchronize_sched()  
> > 			--> rcu_free_old_probes()
> > 				--> srcu_free_old_probes() queued  
> > 	
> > Here tracepoint_synchronize_unregister() returned before the srcu
> > portion ran.  
> 
> But isn't the point of synchronize_rcu to make sure that we're no longer in
> an RCU read-side section, not that *all* queued callbacks already ran? So in that
> case, I think it doesn't matter which order the 2 synchronize functions are
> called in. Please let me know if if I missed something!
> 
> I believe what we're trying to guarantee here is that no tracepoints using
> either flavor of RCU are active after tracepoint_synchronize_unregister
> returns.

Yes you are correct. If tracepoint_synchronize_unregister() is only to
make sure that there is no more trace events using the probes, then
this should work. I was focused on looking at it with release_probes()
too. So the patch is fine as is.

-- Steve
