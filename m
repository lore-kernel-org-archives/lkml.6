Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CB1C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB1C25DA4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="epB0SYbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB1C25DA4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934291AbeFZJir (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:38:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35046 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932206AbeFZJiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FIiVtCr1PGtxn9E7KPr2HNRbrWMOr6X5klzP2dE7yYo=; b=epB0SYbgFYwuFJEXmjkFn+bFJ
        6BwT+hDtiumnv/F61UBZMPsoOuKVzXnuUZ2L7Ow+MF69FXEbqzNTGYXJW0l3NZ1pFycKBbGkaA6Ls
        kGysBghdlgPxGGEvYryOfaSgKuPgEsC2neVfg6vXvOT5ECEcqzofwdgn3CY2KEOaNRt8Y9uMORBMj
        JU9cYtvDSkHTh+CIaBucpn9R2YXF5Ew5PTD4SPHr8rP3CBFcpMclMAs+ebwHDM8cbTFf9QyW/Dkqg
        nY3EWKaN41pJ9WXCObNAocoAfzCvART9NhUBVcr4JG3S4QGJ+4mx16lIupjLXcevTjl73uCM9mdKF
        6pgI7MMSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXkQZ-0007Ha-9Z; Tue, 26 Jun 2018 09:38:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E91062029FA0A; Tue, 26 Jun 2018 11:38:20 +0200 (CEST)
Date:   Tue, 26 Jun 2018 11:38:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH tip/core/rcu 2/2] rcu: Make expedited GPs handle CPU 0
 being offline
Message-ID: <20180626093820.GG2494@hirez.programming.kicks-ass.net>
References: <20180625224308.GA10064@linux.vnet.ibm.com>
 <20180625224332.10596-2-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625224332.10596-2-paulmck@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 03:43:32PM -0700, Paul E. McKenney wrote:
> +		preempt_disable();
> +		for_each_leaf_node_possible_cpu(rnp, cpu) {
> +			if (cpu_is_offline(cpu)) /* Preemption disabled. */
> +				continue;

Create for_each_node_online_cpu() instead? Seems a bit pointless to
iterate possible mask only to then check it against the online mask.
Just iterate the online mask directly.

Or better yet, write this as:

	preempt_disable();
	cpu = cpumask_next(rnp->grplo - 1, cpu_online_mask);
	if (cpu > rnp->grphi)
		cpu = WORK_CPU_UNBOUND;
	queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
	preempt_enable();

Which is what it appears to be doing.

> +			queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> +			rnp->exp_need_flush = true;
> +			break;
> +		}
> +		preempt_enable();
> +		if (!rnp->exp_need_flush) { /* All offline, report QSes. */
> +			queue_work(rcu_par_gp_wq, &rnp->rew.rew_work);
> +			rnp->exp_need_flush = true;
> +		}
>  	}
>  
>  	/* Wait for workqueue jobs (if any) to complete. */
> -- 
> 2.17.1
> 
