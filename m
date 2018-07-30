Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7C9FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1EB20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mxaqkg/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1EB20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbeG3SSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:18:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbeG3SSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iX5VfYj1WB/RK77CfZFURQK/gLIX2bWiFWlZCZ9lfPk=; b=Mxaqkg/eRSNrNmkcTgPqrt6gq
        w8e1WCp6JctE6vIk4hArim46ACAO/sfWkMPpdY5mbuAYwVBYTUSACS6+Cn5+AxyYrN9WZU3ADs10i
        5pQFVhj0dcFP9+QN0FiYk/Rm4Gk5OnpYKYd8OIgGn4SNN1namORBM2Hl/8ZL8FOMbnKPOxhB5e/Jd
        RsKmczcSZn1WaEmAwmnib0lz89jCHslEoMJwN6ldqX7NDVmVVPH5x7hekM8sWCMyzK9082WmBlA3e
        hPo7paptoXASIWkUPqmjdMnpSOElmXqsd2sUQkkctzfQmCH5xl3r5fO6eEXFOnti/VhOA4NAOCfo1
        DVUYVso+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkBFw-0003OL-Ta; Mon, 30 Jul 2018 16:42:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F5DE20275F3E; Mon, 30 Jul 2018 18:42:47 +0200 (CEST)
Date:   Mon, 30 Jul 2018 18:42:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC tip/core/rcu] Avoid resched_cpu() when rescheduling
 the current CPU
Message-ID: <20180730164247.GN2494@hirez.programming.kicks-ass.net>
References: <20180727154931.GA12106@linux.vnet.ibm.com>
 <20180730092513.GD2494@hirez.programming.kicks-ass.net>
 <20180730145933.GX24813@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730145933.GX24813@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 07:59:33AM -0700, Paul E. McKenney wrote:

> > Something that might be more in line with
> > resched_curr(smp_processor_id()) would be:
> > 
> > 	preempt_disable();
> > 	if (!test_tsk_need_resched(current)) {
> > 		set_tsk_need_resched(current);
> > 		set_preempt_need_resched();
> > 	}
> > 	preempt_enable();
> > 
> > Where the preempt_enable() could of course instantly trigger the
> > reschedule if it was the outer most one.
> 
> Ah.  So should I use resched_curr() from rcu_check_callbacks(), which
> is invoked from the scheduling-clock interrupt?  Right now I have calls
> to set_tsk_need_resched() and set_preempt_need_resched().
> 
> > > @@ -2674,10 +2675,12 @@ static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused
> > 
> > > -		resched_cpu(rdp->cpu); /* Provoke future context switch. */
> > 
> > > +		set_tsk_need_resched(current);
> > > +		set_preempt_need_resched();
> > 
> > That's not obviously correct. rdp->cpu had better be smp_processor_id().
> 
> At the beginning of the function, we have:
> 
> 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
> 
> And this is in a softirq handler, so we are OK.

Agreed.

> > > @@ -672,7 +672,8 @@ static void sync_rcu_exp_handler(void *unused)
> > >  			rcu_report_exp_rdp(rdp);
> > >  		} else {
> > >  			rdp->deferred_qs = true;
> > > -			resched_cpu(rdp->cpu);
> > > +			set_tsk_need_resched(t);
> > > +			set_preempt_need_resched();
> > 
> > That only works if @t == current.
> 
> At the beginning of the function, we have:
> 
> 	struct task_struct *t = current;
> 
> So we should be OK.

Ah, the scheduler and locking code typically use to call that curr, to
be more explicit that it is the current task.


> Should I be instead using resched_curr() on some or all of these?

If, as it seems is the case, they are all targeting the current cpu and
have (soft) interrupts disabled, then what you propose is indeed fine.
