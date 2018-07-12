Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255A9ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8842208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VHG9zDIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8842208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeGLT15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:27:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36707 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbeGLT14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:27:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id m19-v6so4185607pgv.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eb9dZSKMoZpOZp4Ps1JeXoJyoHR6QDQL1zZK4YZQWBQ=;
        b=VHG9zDIcGlNdu0ZzAZWLiMm9zswuYdbJlzhq4BrWWbHZ5oO9rAtTkaTbXDOK6TO6zZ
         TrC/ebPsxXeafvmwj1mZQhs8XB/xqjHAYYk05S/msIBjLYCNj3HUgiY9eqrjX/uzoBAa
         rYZpNonYjMmkS1Ykl8vHI4guPeF1Vx0AoFW0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eb9dZSKMoZpOZp4Ps1JeXoJyoHR6QDQL1zZK4YZQWBQ=;
        b=Dt/8kTq0EpV+3m6QvH+l9L0gj5S3BqTdKnfkGg9E2eGMS3pM3lf0wnpJQWviVrDTSN
         MqoLVVU8I7CjxdljIQ3p2TVQaDPmr5SkK011x+B2+sNQg6y/+NdVaA9GwItI9PN6pxIp
         y4smfB2OuNEL0jEcbxJbRVp/W5WTUnKoSCrwYTxFTimhFZE6f0d/RjzFmVovtnqxj/B3
         B+hzTAytZn/kp7H4ZHAwWsYJIsAtS8I0h/prhJASvatxudzl67ydNoqnVJXkYAwV505z
         /ED+NcGn3nTxvexnPcH0FtU71ncTuv1lN/AENShns6PaNnrZMvL9XTflcR5j6qHrO0AP
         R+lg==
X-Gm-Message-State: AOUpUlFf5ajbENCSCZOQSqAmuRnw1MNKc09sADMOFW2vvcXmtgj4GUFo
        GbaphlnEP3t62HSisKpvGFVJ2A==
X-Google-Smtp-Source: AAOMgpdQbbZ7SY3EAPDuGwdJnm8rB15ewhzwSnRmt4MRN4RVR7up6CrHGpWB8Da/HXP6uP7dDhOOVQ==
X-Received: by 2002:a63:66c7:: with SMTP id a190-v6mr3160570pgc.411.1531423022936;
        Thu, 12 Jul 2018 12:17:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id f6-v6sm32545839pgp.13.2018.07.12.12.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 12:17:02 -0700 (PDT)
Date:   Thu, 12 Jul 2018 12:17:01 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20180712191701.GA107829@joelaf.mtv.corp.google.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
 <20180628182149.226164-5-joel@joelfernandes.org>
 <20180711124954.GE2476@hirez.programming.kicks-ass.net>
 <20180711090003.42596c2b@gandalf.local.home>
 <20180711142744.GN3593@linux.vnet.ibm.com>
 <20180711104618.05dc4b46@gandalf.local.home>
 <20180711205249.GA32091@joelaf.mtv.corp.google.com>
 <20180711232120.5dbfa1c7@vmware.local.home>
 <20180712042825.GA154647@joelaf.mtv.corp.google.com>
 <20180712093512.1f612a24@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712093512.1f612a24@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 09:35:12AM -0400, Steven Rostedt wrote:

> On Wed, 11 Jul 2018 21:28:25 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Wed, Jul 11, 2018 at 11:21:20PM -0400, Steven Rostedt wrote:
> > > On Wed, 11 Jul 2018 13:52:49 -0700
> > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > >   
> > > > > #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
> > > > > 	extern struct tracepoint __tracepoint_##name;			\
> > > > > 	static inline void trace_##name(proto)				\
> > > > > 	{								\
> > > > > 		if (static_key_false(&__tracepoint_##name.key))		\
> > > > > 			__DO_TRACE(&__tracepoint_##name,		\
> > > > > 				TP_PROTO(data_proto),			\
> > > > > 				TP_ARGS(data_args),			\
> > > > > 				TP_CONDITION(cond), 0);			\
> > > > > 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> > > > > 			rcu_read_lock_sched_notrace();			\
> > > > > 			rcu_dereference_sched(__tracepoint_##name.funcs);\
> > > > > 			rcu_read_unlock_sched_notrace();		\
> > > > > 		}							\
> > > > > 	}
> > > > > 
> > > > > Because lockdep would only trigger warnings when the tracepoint was
> > > > > enabled and used in a place it shouldn't be, we added the above
> > > > > IS_ENABLED(CONFIG_LOCKDEP) part to test regardless if the the
> > > > > tracepoint was enabled or not. Because we do this, we don't need to
> > > > > have the test in the __DO_TRACE() code itself. That means we can clean
> > > > > up the code as per Peter's suggestion.    
> > > > 
> > > > Sounds good, I'm Ok with making this change.
> > > > 
> > > > Just to clarify, are you proposing to change the rcu_dereference_sched to
> > > > rcu_dereference_raw in both __DECLARE_TRACE and __DO_TRACE?  
> > > 
> > > No, just in __DO_TRACE(). The rcu_dereference_sched() above in
> > > __DECLARE_TRACE() in the if (IS_ENABLED(CONFIG_LOCKDEP) block is
> > > required to show the warnings if trace_##name() is used wrong, and is
> > > the reason we can use rcu_dereference_raw() in __DO_TRACE() in the
> > > first place ;-)
> > > 
> > > This brings up another point. We should probably add to
> > > __DECLARE_TRACE_RCU() this:
> > > 
> > > #ifndef MODULE
> > > #define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_args) \
> > > 	static inline void trace_##name##_rcuidle(proto)		\
> > > 	{								\
> > > 		if (static_key_false(&__tracepoint_##name.key))		\
> > > 			__DO_TRACE(&__tracepoint_##name,		\
> > > 				TP_PROTO(data_proto),			\
> > > 				TP_ARGS(data_args),			\
> > > 				TP_CONDITION(cond), 1);			\
> > > +		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> > > +			int idx;					\
> > > +			idx = srcu_read_lock_notrace(&tracepoint_srcu); \
> > > +			srcu_dereference_notrace(__tracepoint_##name.funcs, \
> > > +						&tracepoint_srcu);	\
> > > +			srcu_read_unlock_notrace(&tracepoint_srcu, idx); \
> > > +		}							\
> > > 	}
> > > #else
> > > 
> > > 
> > > So that lockdep works with trace_##name##__rcuidle() when the trace
> > > event is not enabled.
> > > 
> > > But that should be a separate patch and not part of this series. I may
> > > write that up tomorrow.  
> > 
> > Yes, that sounds good to me and would be good to add the safe guard there.
> > But you meant srcu_dereference above, not srcu_dereference_notrace right?
> 
> We don't need to trace them. I believe that the "srcu_*_notrace" still
> performs the lockdep checks. That's what we want. If they don't then we
> should not use notrace. But I believe they still do lockdep.

AFAICT, _notrace doesn't call into lockdep or tracing (there's also a comment
that says so):

/**
 * srcu_dereference_notrace - no tracing and no lockdep calls from here
 */

So then, we should use the regular variant for this additional check you're
suggesting.

thanks,

- Joel

