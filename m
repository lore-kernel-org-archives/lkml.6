Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8351AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2592B268B5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M6r8Fe+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2592B268B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbeFZRoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:44:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52778 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754619AbeFZRon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aLWR/usDDFr41rmAa4XuO+UBc83YZTmcKS8kpV9VQ4k=; b=M6r8Fe+njxuSA8eFrQ1nJgCtI
        IIQafm88vnBFo0GhH4Nen6VkV6ZaN2Tfm+y/bCMxIvIH5MfO40vLpl4XYToyiIPN1JMjHqllIKImT
        H6am5sZUmo5kAARuxf7NF88+jUghfhCR1OYKTtSGWXQNEWBHMUVEVd/akS+yqxdRNsQCxNTxAEi9O
        t79fgqqj4egwf9yPwSe4sqwRVNZ8zXAb2JB51EbPioIAk/zZSNwEY0kAeWD3a7b6JFZZp5V4Fxfeg
        iMS74O+gOBEcxQZlj45h1WRjn0hdcQ9oJOuzjceyALfxONUrbg+ihxYC/5PnqGT5utH+cUm5bqGnm
        8qVaHWWnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXs0w-0004Sd-9r; Tue, 26 Jun 2018 17:44:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A28FA2029F1DB; Tue, 26 Jun 2018 19:44:24 +0200 (CEST)
Date:   Tue, 26 Jun 2018 19:44:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 13/22] rcu: Fix grace-period hangs due to
 race with CPU offline
Message-ID: <20180626174424.GK2494@hirez.programming.kicks-ass.net>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
 <20180626171048.2181-13-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626171048.2181-13-paulmck@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:10:39AM -0700, Paul E. McKenney wrote:
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 3def94fc9c74..6683da6e4ecc 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -363,6 +363,10 @@ struct rcu_state {
>  	const char *name;			/* Name of structure. */
>  	char abbr;				/* Abbreviated name. */
>  	struct list_head flavors;		/* List of RCU flavors. */
> +
> +	spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;

Are you really sure you didn't mean to use ____cacheline_aligned_in_smp
? This internode crap gives you full page alignment under certain rare
configs.
