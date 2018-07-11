Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB37AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CB520C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CB520C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388747AbeGKOvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeGKOvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:51:03 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B6420C0C;
        Wed, 11 Jul 2018 14:46:20 +0000 (UTC)
Date:   Wed, 11 Jul 2018 10:46:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
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
Message-ID: <20180711104618.05dc4b46@gandalf.local.home>
In-Reply-To: <20180711142744.GN3593@linux.vnet.ibm.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
        <20180628182149.226164-5-joel@joelfernandes.org>
        <20180711124954.GE2476@hirez.programming.kicks-ass.net>
        <20180711090003.42596c2b@gandalf.local.home>
        <20180711142744.GN3593@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 07:27:44 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Wed, Jul 11, 2018 at 09:00:03AM -0400, Steven Rostedt wrote:
> > On Wed, 11 Jul 2018 14:49:54 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > On Thu, Jun 28, 2018 at 11:21:46AM -0700, Joel Fernandes wrote:  
> > > > -		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\    
> > > 
> > > I would convert to rcu_dereference_raw() to appease sparse. The fancy
> > > stuff below is pointless if you then turn off all checking.  
> > 
> > The problem with doing this is if we use a trace event without the
> > proper _idle() or whatever, we wont get a warning that it is used
> > incorrectly with lockdep. Or does lockdep still check if "rcu is
> > watching" with rcu_dereference_raw()?  
> 
> No lockdep checking is done by rcu_dereference_raw().

Correct, but I think we can do this regardless. So Joel please resend
with Peter's suggestion.

The reason being is because of this:


#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
	extern struct tracepoint __tracepoint_##name;			\
	static inline void trace_##name(proto)				\
	{								\
		if (static_key_false(&__tracepoint_##name.key))		\
			__DO_TRACE(&__tracepoint_##name,		\
				TP_PROTO(data_proto),			\
				TP_ARGS(data_args),			\
				TP_CONDITION(cond), 0);			\
		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
			rcu_read_lock_sched_notrace();			\
			rcu_dereference_sched(__tracepoint_##name.funcs);\
			rcu_read_unlock_sched_notrace();		\
		}							\
	}

Because lockdep would only trigger warnings when the tracepoint was
enabled and used in a place it shouldn't be, we added the above
IS_ENABLED(CONFIG_LOCKDEP) part to test regardless if the the
tracepoint was enabled or not. Because we do this, we don't need to
have the test in the __DO_TRACE() code itself. That means we can clean
up the code as per Peter's suggestion.

-- Steve
