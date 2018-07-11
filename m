Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FF8C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C0A20C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yparj+AL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C0A20C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbeGKVCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:02:50 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35820 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbeGKVCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:02:50 -0400
Received: by mail-pf0-f193.google.com with SMTP id q7-v6so18064977pff.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sE2x50FFLciyvqRDFi5ub6kyQefdc0KUgqaTHlYnASY=;
        b=yparj+ALmTAHDRN5S3JtbbZh6JW4g5colb0AvqKLSSLqpK4iAQQ2Sx3iq9vM80R+Mo
         PZmBg71oQlwQmnfTRCEqnGUpd5376vKgmzKDciKQ2PVPITaM+taHbuzzYjR/UgmhiO9x
         Zn90Feyt4Z1xPsGS5BMsILox1AHD3DiM2mdLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sE2x50FFLciyvqRDFi5ub6kyQefdc0KUgqaTHlYnASY=;
        b=epOYySVOMCww4O1tqxSsadhWRfSfjbfdM+9r0yUvyiN1NRzEPHzF50pD0G2ZlI3vzE
         pUdWjXWKy0xdMt5UNhCC9sjVaQtedKg8z3xdRi44ZWQ88B4iSNQ62COp0mcnhr29oXS7
         FIMOCLLj4D+KlYHdvNhj4glJhqn2tqK9htnPFJmHX7xfNrfi729QJKnE/FGItdi+3WcO
         FWzkLBKuXv6hGCzm+t6uTCdUCJIbz+KWR8PBuP5nWwxp7aWYHXJJeG1fETeL6CytyU+j
         nBtwAwzYbSFEGv10RY1y/RYIdHWlF8GuLHDPaIw9NDpTydjLO6dmmbL1anZRU4ya/WZ5
         q9jA==
X-Gm-Message-State: AOUpUlHOImcCoEytZqRMpDX2zHoc7QUhsWzFovFZOX8WnmsLUuhHDfMm
        eurAAeVAEzQc8QL8pmtnwl2YgQ==
X-Google-Smtp-Source: AAOMgpf0tIuLAvY2GuXylme172GnVrQVvL1xX7ud33o0cmf4aYRmUcugYy0ssKFInTJfCGfKDOIOVA==
X-Received: by 2002:a63:1403:: with SMTP id u3-v6mr174570pgl.13.1531342600720;
        Wed, 11 Jul 2018 13:56:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id e81-v6sm49976930pfb.62.2018.07.11.13.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:56:40 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:56:39 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20180711205639.GB32091@joelaf.mtv.corp.google.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
 <20180628182149.226164-5-joel@joelfernandes.org>
 <20180711124954.GE2476@hirez.programming.kicks-ass.net>
 <20180711090003.42596c2b@gandalf.local.home>
 <20180711142744.GN3593@linux.vnet.ibm.com>
 <20180711104618.05dc4b46@gandalf.local.home>
 <20180711151559.GR3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711151559.GR3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 08:15:59AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 11, 2018 at 10:46:18AM -0400, Steven Rostedt wrote:
> > On Wed, 11 Jul 2018 07:27:44 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > > On Wed, Jul 11, 2018 at 09:00:03AM -0400, Steven Rostedt wrote:
> > > > On Wed, 11 Jul 2018 14:49:54 +0200
> > > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > >   
> > > > > On Thu, Jun 28, 2018 at 11:21:46AM -0700, Joel Fernandes wrote:  
> > > > > > -		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\    
> > > > > 
> > > > > I would convert to rcu_dereference_raw() to appease sparse. The fancy
> > > > > stuff below is pointless if you then turn off all checking.  
> > > > 
> > > > The problem with doing this is if we use a trace event without the
> > > > proper _idle() or whatever, we wont get a warning that it is used
> > > > incorrectly with lockdep. Or does lockdep still check if "rcu is
> > > > watching" with rcu_dereference_raw()?  
> > > 
> > > No lockdep checking is done by rcu_dereference_raw().
> > 
> > Correct, but I think we can do this regardless. So Joel please resend
> > with Peter's suggestion.
> > 
> > The reason being is because of this:
> > 
> > 
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
> Indeed, the rcu_dereference_sched() would catch it in that case, so
> agreed, Peter's suggestion isn't losing any debuggability.

Hmm, but if we are doing the check later anyway, then why not do it in
__DO_TRACE itself?

Also I guess we are discussing about changing the rcu_dereference_sched which
I think should go into a separate patch since my patch isn't touching how the
rcuidle==0 paths use the RCU API. So I think this is an existing issue
independent of this series.

thanks!

- Joel





