Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0474EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33F424050
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oGLbuyrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33F424050
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753757AbeGER3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:29:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753363AbeGER3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E2KBvkq0TOiFbIf5nPZ8uUzqborJEO2rBvk4iLVws8Q=; b=oGLbuyrZpufjRJy+KBaGrrZOo
        XBpWL323R1tJa5lplrEmCehwBx5Isj8kF7A4KDT/D5n3GqMAkkVMTChY06JW8C5JcfR1dLmWTRdLS
        vs1B1nc3dazAlW1uHyfdwMumbDIL/K7NwhwKqyAyQXTHPQxtvsKN5XNavb6180nhAOHZ1oVtvypsj
        7tBpBFm9Hnvu00ousEJBAS08zoQdiP4VIEZc10YYltW4iGcLI42IGNHZsXnnqfz/u89zQaupFGX3w
        MjjRyjXZL7dySkruJ0gopnX84tDU6MG3xmbIe+3qw3i/IAEMLyc+/8RyQzCnYd5fnTDE4qRVDd4lw
        f6UX3sOyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb84J-0005x8-Vq; Thu, 05 Jul 2018 17:29:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 784CA20298BAE; Thu,  5 Jul 2018 19:29:22 +0200 (CEST)
Date:   Thu, 5 Jul 2018 19:29:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v4 05/12] sched/topology: Reference the Energy Model
 of CPUs when available
Message-ID: <20180705172922.GQ2458@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-6-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628114043.24724-6-quentin.perret@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:40:36PM +0100, Quentin Perret wrote:
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 61a1125c1ae4..357eff55c1a7 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -201,6 +201,19 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
>  	return 1;
>  }
>  
> +#ifdef CONFIG_ENERGY_MODEL
> +static void free_fd(struct freq_domain *fd)
> +{
> +	struct freq_domain *tmp;
> +
> +	while (fd) {
> +		tmp = fd->next;
> +		kfree(fd);
> +		fd = tmp;
> +	}
> +}
> +#endif
> +
>  static void free_rootdomain(struct rcu_head *rcu)
>  {
>  	struct root_domain *rd = container_of(rcu, struct root_domain, rcu);
> @@ -211,6 +224,9 @@ static void free_rootdomain(struct rcu_head *rcu)
>  	free_cpumask_var(rd->rto_mask);
>  	free_cpumask_var(rd->online);
>  	free_cpumask_var(rd->span);
> +#ifdef CONFIG_ENERGY_MODEL
> +	free_fd(rd->fd);
> +#endif

If you provide a stub function, you can reduce #ifdef.

>  	kfree(rd);
>  }
>  
> @@ -1635,6 +1651,104 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>  	return sd;
>  }
>  
> +#ifdef CONFIG_ENERGY_MODEL

  < snip content >

> +#endif

And is there any reason this #ifdef cannot be merged with the one above?

That is, try and do a pass of #ifdef reduction on this file.
