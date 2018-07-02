Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EAEC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6152C2560A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="spptR3mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6152C2560A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753020AbeGBAhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:37:36 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33750 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752613AbeGBAhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:37:33 -0400
Received: by mail-pf0-f194.google.com with SMTP id b17-v6so6649631pfi.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 17:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nA/VDgVWg12acYHWKaPET1UODL/TgZSBh7LTtQwqxh4=;
        b=spptR3mxjQAUs17uH491aBcpZbPuJoVKJDbkih/zOiblqN7uUazimcU6+HhYTW9l1T
         Y7ZlXMYU7uaY/vPyS0muhpyXK0H7+9Z5jqqIp9JOlKj+LycWD2uFEZpcaqGzlDSsftas
         aA0jj7PFXdKO6dFOpt+tGmcfKsjRHD23eLGMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nA/VDgVWg12acYHWKaPET1UODL/TgZSBh7LTtQwqxh4=;
        b=oHNmLTQEN3j+dr3lBV/V3VogOR9NZ1t/zdkDW6DSdMdqcusnjmoMJLwpI4pbs4qVAH
         vTiOUIY9t8/zbU+2+eROw7hpXPvWIOCso4jdCFAHuVlL1orOPHfXiel/yCgDpTt+WwCC
         u5L84UGUM56ZPvYjEX0QI9SKXLu/1UwRsNvL73z4H2cO3t+w6c47XV2pc5l2B7pMb9Y+
         87L4OllxdpseX4Vp8CEMhTByrftFo9YiFlcfzXwlusvkS3lSVx8DpIQkiFNZp7ThyLzi
         55tjhZps55QmkO6/1PUkloGNpsTHxhbdNsVdNy8YqbzPqWVzIjjh8gndG9rr77QHuLIC
         rEfA==
X-Gm-Message-State: APt69E1KWg12+YWTIngpaVwVR9NQwxMi0tVNUPbij5JAsd1WoJUK+CoZ
        A955U/RK9OaaYY8108Dj1ua4Qg==
X-Google-Smtp-Source: AAOMgpeX3z2tRoWBZ84zYikVyUKtEbO5pjr6Zd+pYNhFXMwOeAI7IEttA0vaZgojKACwE51wm6cTcg==
X-Received: by 2002:a65:6102:: with SMTP id z2-v6mr6603466pgu.46.1530491853431;
        Sun, 01 Jul 2018 17:37:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id m134-v6sm15141819pga.20.2018.07.01.17.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 17:37:32 -0700 (PDT)
Date:   Sun, 1 Jul 2018 17:37:32 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH RFC tip/core/rcu 1/2] rcu: Defer reporting RCU-preempt
 quiescent states when disabled
Message-ID: <20180702003732.GB95395@joelaf.mtv.corp.google.com>
References: <20180627204835.GA25456@linux.vnet.ibm.com>
 <20180627204915.27253-1-paulmck@linux.vnet.ibm.com>
 <20180701174045.GA111992@joelaf.mtv.corp.google.com>
 <20180701222501.GC3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180701222501.GC3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 03:25:01PM -0700, Paul E. McKenney wrote:
[...]
> > > @@ -602,6 +589,66 @@ static void rcu_read_unlock_special(struct task_struct *t)
> > >  	}
> > >  }
> > >  
> > > +/*
> > > + * Is a deferred quiescent-state pending, and are we also not in
> > > + * an RCU read-side critical section?  It is the caller's responsibility
> > > + * to ensure it is otherwise safe to report any deferred quiescent
> > > + * states.  The reason for this is that it is safe to report a
> > > + * quiescent state during context switch even though preemption
> > > + * is disabled.  This function cannot be expected to understand these
> > > + * nuances, so the caller must handle them.
> > > + */
> > > +static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
> > > +{
> > > +	return (this_cpu_ptr(&rcu_preempt_data)->deferred_qs ||
> > > +		READ_ONCE(t->rcu_read_unlock_special.s)) &&
> > > +	       !t->rcu_read_lock_nesting;
> > > +}
> > > +
> > > +/*
> > > + * Report a deferred quiescent state if needed and safe to do so.
> > > + * As with rcu_preempt_need_deferred_qs(), "safe" involves only
> > > + * not being in an RCU read-side critical section.  The caller must
> > > + * evaluate safety in terms of interrupt, softirq, and preemption
> > > + * disabling.
> > > + */
> > > +static void rcu_preempt_deferred_qs(struct task_struct *t)
> > > +{
> > > +	unsigned long flags;
> > > +
> > > +	if (!rcu_preempt_need_deferred_qs(t))
> > > +		return;
> > > +	local_irq_save(flags);
> > > +	rcu_preempt_deferred_qs_irqrestore(t, flags);
> > > +}
> > > +
> > > +/*
> > > + * Handle special cases during rcu_read_unlock(), such as needing to
> > > + * notify RCU core processing or task having blocked during the RCU
> > > + * read-side critical section.
> > > + */
> > > +static void rcu_read_unlock_special(struct task_struct *t)
> > > +{
> > > +	unsigned long flags;
> > > +	bool preempt_bh_were_disabled = !!(preempt_count() & ~HARDIRQ_MASK);
> > 
> > Would it be better to just test for those bits just to be safe the higher
> > order bits don't bleed in, such as PREEMPT_NEED_RESCHED, something like the
> > following based on the 'dev' branch?
> 
> Good point!  My plan is to merge it into the original commit with
> attribution.  Please let me know if you have objections.
> 

Sure! That sounds good to me.

thanks!

- Joel

