Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E83CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5493A21473
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sewRqrK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5493A21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391275AbeGLCjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:39:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41078 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390354AbeGLCjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:39:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so1965879pgu.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 19:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=me5K91H+DhPMTRgX432675GLbmMcAt+6VcyLXySnwBs=;
        b=sewRqrK6P0t2emWbJvCSqDGIzB6MyNfwk6clZEg3uofdyx5KPTuZHMrKChgU5AB49L
         tNKWQSNJM+3urJ8LLpFV3BuX/qQjIBSZ9BOvm6IO9OH0JN2zLGlyn/IGf9uz2zqk/N7a
         +VkwqB4PuEetM/GWDef6ZoZb3O7FHTGYN+d2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=me5K91H+DhPMTRgX432675GLbmMcAt+6VcyLXySnwBs=;
        b=mSPCYYno00Dv7cMah1sXvEt53T5YwQORCbwNFm6xlewUducD4GDPpTW2qRdiMJKCyX
         g8sClpApOzQfYvxAuxH6ypy3O5BUUUe2FGxRhouysSmF/u5b+WAr0bpXuZK2zkc9oYWX
         fUCnmxELtaXUQZpiuYNsqw1bWlLmqGrHd85rg2WHADUlz94QAWslcizsWSkmp4QzTqok
         LNZfUeSo80i83uB/CmKNRqZEaXB23VBUt04om2IsJ+MfgT+cJPiPFrrauKyIQleSZOs3
         95rOswcBwTYa//Hjcd5I74dprBiuE2H7lefb7wi+QaHFd4+tTcn1Sn2bKtJ8poXiu4qy
         jfXg==
X-Gm-Message-State: AOUpUlE8SKNL5PwVHvGpzqj6mpkHJGn8dqDAIz1VQRf2LOT8Gxw7Xx79
        GzuQ0+wQlj45Sab10xoTdmRz1Q==
X-Google-Smtp-Source: AAOMgpffk1CaQuEWI/UqHA+SLXWcYRy02JBnzWOwBiS9l/JfQzQZDXCRVlkK/TyRAVffI2pbNGCmCA==
X-Received: by 2002:a62:1f06:: with SMTP id f6-v6mr424061pff.140.1531362758574;
        Wed, 11 Jul 2018 19:32:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id l4-v6sm21697941pgn.46.2018.07.11.19.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 19:32:38 -0700 (PDT)
Date:   Wed, 11 Jul 2018 19:32:37 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 4/7] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180712023237.GA122777@joelaf.mtv.corp.google.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
 <20180628182149.226164-5-joel@joelfernandes.org>
 <20180711125322.GF2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711125322.GF2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 02:53:22PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 11:21:46AM -0700, Joel Fernandes wrote:
> > -		rcu_read_lock_sched_notrace();				\
> > -		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
> > +									\
> > +		/*							\
> > +		 * For rcuidle callers, use srcu since sched-rcu	\
> > +		 * doesn't work from the idle path.			\
> > +		 */							\
> > +		if (rcuidle) {						\
> > +			if (in_nmi()) {					\
> > +				WARN_ON_ONCE(1);			\
> > +				return; /* no srcu from nmi */		\
> > +			}						\
> > +									\
> > +			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
> > +			it_func_ptr =					\
> > +				srcu_dereference_notrace((tp)->funcs,	\
> > +						&tracepoint_srcu);	\
> > +			/* To keep it consistent with !rcuidle path */	\
> > +			preempt_disable_notrace();			\
> > +		} else {						\
> > +			rcu_read_lock_sched_notrace();			\
> > +			it_func_ptr =					\
> > +				rcu_dereference_sched((tp)->funcs);	\
> > +		}							\
> > +									\
> >  		if (it_func_ptr) {					\
> >  			do {						\
> >  				it_func = (it_func_ptr)->func;		\
> > @@ -148,9 +177,13 @@ extern void syscall_unregfunc(void);
> >  				((void(*)(proto))(it_func))(args);	\
> >  			} while ((++it_func_ptr)->func);		\
> >  		}							\
> > -		rcu_read_unlock_sched_notrace();			\
> > -		if (rcucheck)						\
> > -			rcu_irq_exit_irqson();				\
> > +									\
> > +		if (rcuidle) {						\
> > +			preempt_enable_notrace();			\
> > +			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
> > +		} else {						\
> > +			rcu_read_unlock_sched_notrace();		\
> > +		}							\
> >  	} while (0)
> 
> In fact, I would write the thing like:
> 
> 		preempt_disable_notrace();
> 		if (rcuidle)
> 			idx = srcu_read_lock_notrace(&tracepoint_srcu);
> 
> 		it_func_ptr = rcu_dereference_raw((tp)->funcs);
> 
> 		/* ... */
> 
> 		if (rcu_idle)
> 			srcu_read_unlock_notrace(&tracepoint_srcu, idx);
> 		preempt_enable_notrace();
> 
> Much simpler and very much the same.

Cool, thanks! I will do it this way and resend.

- Joel

