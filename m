Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52148C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C4B21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C4B21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeGLD2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 23:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbeGLD2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 23:28:54 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12DEB20BF2;
        Thu, 12 Jul 2018 03:21:21 +0000 (UTC)
Date:   Wed, 11 Jul 2018 23:21:20 -0400
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
Message-ID: <20180711232120.5dbfa1c7@vmware.local.home>
In-Reply-To: <20180711205249.GA32091@joelaf.mtv.corp.google.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
        <20180628182149.226164-5-joel@joelfernandes.org>
        <20180711124954.GE2476@hirez.programming.kicks-ass.net>
        <20180711090003.42596c2b@gandalf.local.home>
        <20180711142744.GN3593@linux.vnet.ibm.com>
        <20180711104618.05dc4b46@gandalf.local.home>
        <20180711205249.GA32091@joelaf.mtv.corp.google.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 13:52:49 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> > #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
> > 	extern struct tracepoint __tracepoint_##name;			\
> > 	static inline void trace_##name(proto)				\
> > 	{								\
> > 		if (static_key_false(&__tracepoint_##name.key))		\
> > 			__DO_TRACE(&__tracepoint_##name,		\
> > 				TP_PROTO(data_proto),			\
> > 				TP_ARGS(data_args),			\
> > 				TP_CONDITION(cond), 0);			\
> > 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> > 			rcu_read_lock_sched_notrace();			\
> > 			rcu_dereference_sched(__tracepoint_##name.funcs);\
> > 			rcu_read_unlock_sched_notrace();		\
> > 		}							\
> > 	}
> > 
> > Because lockdep would only trigger warnings when the tracepoint was
> > enabled and used in a place it shouldn't be, we added the above
> > IS_ENABLED(CONFIG_LOCKDEP) part to test regardless if the the
> > tracepoint was enabled or not. Because we do this, we don't need to
> > have the test in the __DO_TRACE() code itself. That means we can clean
> > up the code as per Peter's suggestion.  
> 
> Sounds good, I'm Ok with making this change.
> 
> Just to clarify, are you proposing to change the rcu_dereference_sched to
> rcu_dereference_raw in both __DECLARE_TRACE and __DO_TRACE?

No, just in __DO_TRACE(). The rcu_dereference_sched() above in
__DECLARE_TRACE() in the if (IS_ENABLED(CONFIG_LOCKDEP) block is
required to show the warnings if trace_##name() is used wrong, and is
the reason we can use rcu_dereference_raw() in __DO_TRACE() in the
first place ;-)

This brings up another point. We should probably add to
__DECLARE_TRACE_RCU() this:

#ifndef MODULE
#define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_args) \
	static inline void trace_##name##_rcuidle(proto)		\
	{								\
		if (static_key_false(&__tracepoint_##name.key))		\
			__DO_TRACE(&__tracepoint_##name,		\
				TP_PROTO(data_proto),			\
				TP_ARGS(data_args),			\
				TP_CONDITION(cond), 1);			\
+		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
+			int idx;					\
+			idx = srcu_read_lock_notrace(&tracepoint_srcu); \
+			srcu_dereference_notrace(__tracepoint_##name.funcs, \
+						&tracepoint_srcu);	\
+			srcu_read_unlock_notrace(&tracepoint_srcu, idx); \
+		}							\
	}
#else


So that lockdep works with trace_##name##__rcuidle() when the trace
event is not enabled.

But that should be a separate patch and not part of this series. I may
write that up tomorrow.

-- Steve
