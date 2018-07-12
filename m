Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C93C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D679A20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Vgz6TWCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D679A20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391344AbeGLCmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:42:43 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46111 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387702AbeGLCmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:42:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id l123-v6so19617918pfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 19:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ys+0VIScvXFlw57RU/DTxKZ1PGYl/lavqc8LpndOYE=;
        b=Vgz6TWCY1V5tQ9/cug8jbbYEGhJ4ceQrCNAtWf1SNSdnltDNv0nlx2AdE2FMJ9Xk3g
         ylOwqoO4/JLwAmSI+7i3al/2DegbyNXsYsYD1GCtrGNkg1z4XgIRSsxt+80SqezUxon+
         0YibtVvl7d7qAgb81FoJG5DkM3a8UfRdrX+8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ys+0VIScvXFlw57RU/DTxKZ1PGYl/lavqc8LpndOYE=;
        b=RbTg9D6sut3rSJbm+zPxLROZRh7FBHCznvu7PFi0SJjcpkTa3487DlwlzU9FVwWBUD
         q1wlz7tLgGdOqVGMSO+TGsrCGqZnXK9FJ8sRvS5Fk7i6CMW66UWW1JqSPDtzE8MdedXi
         anyg+7BtfOIV4sraA2WzEYXmJmvihh8mxO5fkAUtwrEiHOPSWNV4zs9GgVPZlWX5NYM3
         xs0NOQjsoBoxZlc8t/P55Yi8OyeTuuxRGVGwEcmuqhwLOLRGw7+1ZWEzwfJk+iJ8q3ZQ
         +Sr2EGRa3GK47J+ZeVtvOi3ujQsvmCCfTRyV/05/7ziyCDbcf/BIwRI7kHWVkK9YNSf/
         wO1A==
X-Gm-Message-State: AOUpUlE7y3Jk7kyM/nQdnrHqDJrS8C8LlOyXgTlvVxUfEi91JPLWnwSa
        6+FHn7H+CM67drb9KkgvbnMrCA==
X-Google-Smtp-Source: AAOMgpeW9oVu8PrDsTGBvP8TMR0+TjnARjWZbyRT3e1PdxoNhHL3+YSMJcqI/xGssczFXrVP9C3N1g==
X-Received: by 2002:a62:e106:: with SMTP id q6-v6mr413446pfh.75.1531362926895;
        Wed, 11 Jul 2018 19:35:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id e82-v6sm52228441pfd.40.2018.07.11.19.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 19:35:26 -0700 (PDT)
Date:   Wed, 11 Jul 2018 19:35:25 -0700
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
Message-ID: <20180712023525.GB122777@joelaf.mtv.corp.google.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
 <20180628182149.226164-5-joel@joelfernandes.org>
 <20180711124954.GE2476@hirez.programming.kicks-ass.net>
 <20180711090003.42596c2b@gandalf.local.home>
 <20180711142744.GN3593@linux.vnet.ibm.com>
 <20180711104618.05dc4b46@gandalf.local.home>
 <20180711151559.GR3593@linux.vnet.ibm.com>
 <20180711205639.GB32091@joelaf.mtv.corp.google.com>
 <20180711212237.3eff418f@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711212237.3eff418f@vmware.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 09:22:37PM -0400, Steven Rostedt wrote:
> On Wed, 11 Jul 2018 13:56:39 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > > > #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
> > > > 	extern struct tracepoint __tracepoint_##name;			\
> > > > 	static inline void trace_##name(proto)				\
> > > > 	{								\
> > > > 		if (static_key_false(&__tracepoint_##name.key))		\
> > > > 			__DO_TRACE(&__tracepoint_##name,		\
> > > > 				TP_PROTO(data_proto),			\
> > > > 				TP_ARGS(data_args),			\
> > > > 				TP_CONDITION(cond), 0);			\
> > > > 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> > > > 			rcu_read_lock_sched_notrace();			\
> > > > 			rcu_dereference_sched(__tracepoint_##name.funcs);\
> > > > 			rcu_read_unlock_sched_notrace();		\
> > > > 		}							\
> > > > 	}
> > > > 
> > > > Because lockdep would only trigger warnings when the tracepoint was
> > > > enabled and used in a place it shouldn't be, we added the above
> > > > IS_ENABLED(CONFIG_LOCKDEP) part to test regardless if the the
> > > > tracepoint was enabled or not. Because we do this, we don't need to
> > > > have the test in the __DO_TRACE() code itself. That means we can clean
> > > > up the code as per Peter's suggestion.  
> > > 
> > > Indeed, the rcu_dereference_sched() would catch it in that case, so
> > > agreed, Peter's suggestion isn't losing any debuggability.  
> > 
> > Hmm, but if we are doing the check later anyway, then why not do it in
> > __DO_TRACE itself?
> 
> Because __DO_TRACE is only called if the trace event is enabled. If we
> never enable a trace event, we never know if it has a potential of
> doing it wrong. The second part is to trigger the warning immediately
> regardless if the trace event is enabled or not.

I see, thanks for the clarification.

> > 
> > Also I guess we are discussing about changing the rcu_dereference_sched which
> > I think should go into a separate patch since my patch isn't touching how the
> > rcuidle==0 paths use the RCU API. So I think this is an existing issue
> > independent of this series.
> 
> But the code you added made it much more complex to keep the checks as
> is. If we remove the checks then this patch doesn't need to have all
> the if statements, and we can do it the way Peter suggested.

Yes, I agree Peter's suggestion is very clean.

> But sure, go ahead and make a separate patch first that removes the
> checks from __DO_TRACE() first if you want to.

No its ok, no problem, I can just do it in the same patch now that I see the code is much simplified with what Peter is suggesting.

thanks!

- Joel


