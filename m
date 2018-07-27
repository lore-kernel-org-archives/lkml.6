Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDAEC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080B5205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="am236P1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080B5205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389119AbeG0UOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:14:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46868 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388899AbeG0UOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:14:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id p23-v6so3715793pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vHFL81bsTzOufFTHvXiHMWKxiVScoLLWo4Bs4KOFLIw=;
        b=am236P1AYjnI+ufRWaQP+rWX0E7eMiBWtZzVKThdfUJpnFVXOKZA+j4icLJmSHy9+Y
         3VQPVWJnQcgDDiSsu7tF8dYHXoS+NMb8lGO2p9PScWtq3g+NxLGcBaAgNY1R6axi6gi5
         euTK1HHvrRgjlSpmdFUCK4fM0JpX38h5pGV8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vHFL81bsTzOufFTHvXiHMWKxiVScoLLWo4Bs4KOFLIw=;
        b=jOvyxl/XT6b1gIedrFX9tD+OUnc+1hOFrIKZlOsvedX1/SbdSi38b5PD4diU8nxm9H
         z0BqaoGKGUp49rKfTj617iSCEYzKhwKN+jTixLU27CNSr2SgWoOMYs7OQya1ZSbosfl9
         s6b3HbmemUuNFzP3Mg8kx56RMnwI/KwHV12bYo5RhqutXm4KHRBaTqLpBKCiNdYttAK5
         k8AGmN9vbEERbD4/hLUWniSDWCkItvtG9woesqvciD66giK56OiMtpeMZ9eKS7Et8j/S
         blXsfw3zC0r3N5GtbuG0d2ay/o8NLcU8FfBCh6+u4fm34fegpiVhNM6IsjywuVz2iYXn
         gr7g==
X-Gm-Message-State: AOUpUlGZcvNrV4kEM9T33uRe+Cf9PkapCIkmJRR22uM5Zjf4GuSNxvWd
        EaHQmQkZ+w5HFPDRlraevYVQYQ==
X-Google-Smtp-Source: AAOMgpc5qH3f7P2oz+/AaFBmu0BVSJtDrwZGnof5tyj0x/7OFe70EcgxmNxiagjVoufet8YOcL+Gow==
X-Received: by 2002:a62:1157:: with SMTP id z84-v6mr7885410pfi.66.1532717474695;
        Fri, 27 Jul 2018 11:51:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id i62-v6sm7417099pge.66.2018.07.27.11.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 11:51:13 -0700 (PDT)
Date:   Fri, 27 Jul 2018 11:51:13 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v11 2/3] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180727185113.GA83926@joelaf.mtv.corp.google.com>
References: <20180726235044.10195-1-joel@joelfernandes.org>
 <20180726235044.10195-3-joel@joelfernandes.org>
 <20180727122659.524dd13f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727122659.524dd13f@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:26:59PM -0400, Steven Rostedt wrote:
> On Thu, 26 Jul 2018 16:50:43 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > F
> >  include/linux/tracepoint.h | 41 ++++++++++++++++++++++++++++++--------
> >  kernel/tracepoint.c        | 16 ++++++++++++++-
> >  2 files changed, 48 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index 19a690b559ca..6e7bc6ebfcd8 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -15,6 +15,7 @@
> >   */
> >  
> >  #include <linux/smp.h>
> > +#include <linux/srcu.h>
> >  #include <linux/errno.h>
> >  #include <linux/types.h>
> >  #include <linux/cpumask.h>
> > @@ -33,6 +34,8 @@ struct trace_eval_map {
> >  
> >  #define TRACEPOINT_DEFAULT_PRIO	10
> >  
> > +extern struct srcu_struct tracepoint_srcu;
> > +
> >  extern int
> >  tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
> >  extern int
> > @@ -75,10 +78,16 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
> >   * probe unregistration and the end of module exit to make sure there is no
> >   * caller executing a probe when it is freed.
> >   */
> > +#ifdef CONFIG_TRACEPOINTS
> >  static inline void tracepoint_synchronize_unregister(void)
> >  {
> > +	synchronize_srcu(&tracepoint_srcu);
> >  	synchronize_sched();
> >  }
> > +#else
> > +static inline void tracepoint_synchronize_unregister(void)
> > +{ }
> > +#endif
> >  
> >  #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
> >  extern int syscall_regfunc(void);
> > @@ -129,18 +138,32 @@ extern void syscall_unregfunc(void);
> >   * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
> >   * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
> >   */
> > -#define __DO_TRACE(tp, proto, args, cond, rcucheck)			\
> > +#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
> >  	do {								\
> >  		struct tracepoint_func *it_func_ptr;			\
> >  		void *it_func;						\
> >  		void *__data;						\
> > +		int __maybe_unused idx = 0;				\
> >  									\
> >  		if (!(cond))						\
> >  			return;						\
> > -		if (rcucheck)						\
> > -			rcu_irq_enter_irqson();				\
> > -		rcu_read_lock_sched_notrace();				\
> > -		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
> > +									\
> > +		/* srcu can't be used from NMI */			\
> > +		if (rcuidle && in_nmi())				\
> > +			WARN_ON_ONCE(1);				\
> 
> Why isn't the above:
> 
> 		WARN_ON_ONCE(rcuidle && in_nmi());
> 
> ?
> 
> The rest looks fine.

When I refactored the code as Peter suggested I happen to move the warning
out but didn't simplify it further (I had it at the back of my head to do
that but missed it).

Since its quite a simple change I can send a follow up patch doing so later,
or can resend this one. What do you suggest?

thanks,

- Joel

