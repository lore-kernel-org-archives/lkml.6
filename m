Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606C6C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E742146E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E742146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403817AbeGLB3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 21:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbeGLB3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 21:29:41 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE7620BEC;
        Thu, 12 Jul 2018 01:22:38 +0000 (UTC)
Date:   Wed, 11 Jul 2018 21:22:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 4/7] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180711212237.3eff418f@vmware.local.home>
In-Reply-To: <20180711205639.GB32091@joelaf.mtv.corp.google.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
        <20180628182149.226164-5-joel@joelfernandes.org>
        <20180711124954.GE2476@hirez.programming.kicks-ass.net>
        <20180711090003.42596c2b@gandalf.local.home>
        <20180711142744.GN3593@linux.vnet.ibm.com>
        <20180711104618.05dc4b46@gandalf.local.home>
        <20180711151559.GR3593@linux.vnet.ibm.com>
        <20180711205639.GB32091@joelaf.mtv.corp.google.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 13:56:39 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> > > #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
> > > 	extern struct tracepoint __tracepoint_##name;			\
> > > 	static inline void trace_##name(proto)				\
> > > 	{								\
> > > 		if (static_key_false(&__tracepoint_##name.key))		\
> > > 			__DO_TRACE(&__tracepoint_##name,		\
> > > 				TP_PROTO(data_proto),			\
> > > 				TP_ARGS(data_args),			\
> > > 				TP_CONDITION(cond), 0);			\
> > > 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> > > 			rcu_read_lock_sched_notrace();			\
> > > 			rcu_dereference_sched(__tracepoint_##name.funcs);\
> > > 			rcu_read_unlock_sched_notrace();		\
> > > 		}							\
> > > 	}
> > > 
> > > Because lockdep would only trigger warnings when the tracepoint was
> > > enabled and used in a place it shouldn't be, we added the above
> > > IS_ENABLED(CONFIG_LOCKDEP) part to test regardless if the the
> > > tracepoint was enabled or not. Because we do this, we don't need to
> > > have the test in the __DO_TRACE() code itself. That means we can clean
> > > up the code as per Peter's suggestion.  
> > 
> > Indeed, the rcu_dereference_sched() would catch it in that case, so
> > agreed, Peter's suggestion isn't losing any debuggability.  
> 
> Hmm, but if we are doing the check later anyway, then why not do it in
> __DO_TRACE itself?

Because __DO_TRACE is only called if the trace event is enabled. If we
never enable a trace event, we never know if it has a potential of
doing it wrong. The second part is to trigger the warning immediately
regardless if the trace event is enabled or not.

> 
> Also I guess we are discussing about changing the rcu_dereference_sched which
> I think should go into a separate patch since my patch isn't touching how the
> rcuidle==0 paths use the RCU API. So I think this is an existing issue
> independent of this series.

But the code you added made it much more complex to keep the checks as
is. If we remove the checks then this patch doesn't need to have all
the if statements, and we can do it the way Peter suggested.

But sure, go ahead and make a separate patch first that removes the
checks from __DO_TRACE() first if you want to.

-- Steve
