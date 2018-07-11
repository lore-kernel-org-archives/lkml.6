Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16963C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6512146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Z66NBm3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6512146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbeGKU67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:58:59 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45591 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbeGKU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:58:59 -0400
Received: by mail-pl0-f66.google.com with SMTP id a17-v6so3825618plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yKIUC/FI2nnX1UG5YYDIuJ1BU6DtcutLnKI9FKrsbA4=;
        b=Z66NBm3LZDuAveisRrScVnvU0EgJqBH11OjpCIvV+8oBhowV11pT8OcDA5yUAVHQU/
         VhYgWH5kMzZgySeoCGseNAXXKNSjxy0x3eGx8deeU5J/mNrz1JR/Lf0KXAECCHZegcBO
         3pViNAw2fZI4bYy70nOI29g8wP5DcXaO4jW2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yKIUC/FI2nnX1UG5YYDIuJ1BU6DtcutLnKI9FKrsbA4=;
        b=oTaRS5wVAGgo+QBV0v0tCxKxWoguufDg7NDrAfIuRjjrjuvd781tLr+kqFqy26x4qR
         kzkkl+Xc4tzYmsvNErb2KjUQJ85pnRSYvbSXxMFUCA2N9WdDw5eobVLlFmCK6T+tw1tj
         q1aUu5jRWpcqRpZ5U7UBWkqSpHq4sQNRQXmZ4YWpAEuqpXYcihNCIAIVM57UGL6a4rND
         Qw5+XwXFf2zG3K2BbeoEK4l5x4iN1p75ogXSmfr7VYUY3dctEw6dcVN6y+RMK1cqNafI
         EThhH+lBi3lB6MxT5zd9g54rVk8G1pfJuErLAPSwU+LersJBb234BuVzndZhvXjFtaOY
         GQnw==
X-Gm-Message-State: AOUpUlHnzc9jEpdDEoQcUfZQ67yhYndDQymzAzsSxvNwkEgzEJdTaPPy
        W7LdnUMmUVWLokxXgPJR1Mcqmg==
X-Google-Smtp-Source: AAOMgpe6VDb10xvVolZwFBDg4TOBVBtGRpHKg0dr3vUgqab1M9/l39OC3R1BhMInxs95yB6VBMYfZQ==
X-Received: by 2002:a17:902:758c:: with SMTP id j12-v6mr156333pll.195.1531342370631;
        Wed, 11 Jul 2018 13:52:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id x87-v6sm28256200pfa.143.2018.07.11.13.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:52:50 -0700 (PDT)
Date:   Wed, 11 Jul 2018 13:52:49 -0700
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
Message-ID: <20180711205249.GA32091@joelaf.mtv.corp.google.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
 <20180628182149.226164-5-joel@joelfernandes.org>
 <20180711124954.GE2476@hirez.programming.kicks-ass.net>
 <20180711090003.42596c2b@gandalf.local.home>
 <20180711142744.GN3593@linux.vnet.ibm.com>
 <20180711104618.05dc4b46@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711104618.05dc4b46@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:46:18AM -0400, Steven Rostedt wrote:
> On Wed, 11 Jul 2018 07:27:44 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Wed, Jul 11, 2018 at 09:00:03AM -0400, Steven Rostedt wrote:
> > > On Wed, 11 Jul 2018 14:49:54 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > >   
> > > > On Thu, Jun 28, 2018 at 11:21:46AM -0700, Joel Fernandes wrote:  
> > > > > -		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\    
> > > > 
> > > > I would convert to rcu_dereference_raw() to appease sparse. The fancy
> > > > stuff below is pointless if you then turn off all checking.  
> > > 
> > > The problem with doing this is if we use a trace event without the
> > > proper _idle() or whatever, we wont get a warning that it is used
> > > incorrectly with lockdep. Or does lockdep still check if "rcu is
> > > watching" with rcu_dereference_raw()?  
> > 
> > No lockdep checking is done by rcu_dereference_raw().
> 
> Correct, but I think we can do this regardless. So Joel please resend
> with Peter's suggestion.
> 
> The reason being is because of this:
> 
> 
> #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
> 	extern struct tracepoint __tracepoint_##name;			\
> 	static inline void trace_##name(proto)				\
> 	{								\
> 		if (static_key_false(&__tracepoint_##name.key))		\
> 			__DO_TRACE(&__tracepoint_##name,		\
> 				TP_PROTO(data_proto),			\
> 				TP_ARGS(data_args),			\
> 				TP_CONDITION(cond), 0);			\
> 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> 			rcu_read_lock_sched_notrace();			\
> 			rcu_dereference_sched(__tracepoint_##name.funcs);\
> 			rcu_read_unlock_sched_notrace();		\
> 		}							\
> 	}
> 
> Because lockdep would only trigger warnings when the tracepoint was
> enabled and used in a place it shouldn't be, we added the above
> IS_ENABLED(CONFIG_LOCKDEP) part to test regardless if the the
> tracepoint was enabled or not. Because we do this, we don't need to
> have the test in the __DO_TRACE() code itself. That means we can clean
> up the code as per Peter's suggestion.

Sounds good, I'm Ok with making this change.

Just to clarify, are you proposing to change the rcu_dereference_sched to
rcu_dereference_raw in both __DECLARE_TRACE and __DO_TRACE?

thanks!

- Joel

