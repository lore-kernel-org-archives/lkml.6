Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF61C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0F920854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O2BLh53s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0F920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeILWkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:40:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeILWkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dX480bcLnCd6kp6XnnY5LIUs706onB0a8fVNc6iO7sA=; b=O2BLh53sHRI09HIrR5QgKsi2/
        QClFRyXN4eDr38A7RVTuGO0eS/FgFPeiqDaZr140Jl0IsBpS62WilQFBkyftLCrOx5pZAX7sFSJY6
        m1KNgS9kIu+JTVOhzfy9zJrZvZBCOEtyLpV3mBNb1t0ym+eR9YUTivR6dLctF5TQAou7x6AsAwPjp
        n7c2khgdZ6b3dnoEhPel8fg99TBEIodKWuLYVcl9oME5P/X8peP5GXO60KM0BYqAG0DOOcM2u9ICc
        ulEkvU1k+KgZL7DHuT8kW7afR0PkqCjxolgLjUarbDK/Hp+dnnnz82lu1/HFBWe0AFLBmKrWgWo2Y
        Yi/keeAZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0920-00035l-70; Wed, 12 Sep 2018 17:34:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA4D9202C1A2E; Wed, 12 Sep 2018 19:34:21 +0200 (CEST)
Date:   Wed, 12 Sep 2018 19:34:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 03/16] sched/core: uclamp: add CPU's clamp groups
 accounting
Message-ID: <20180912173421.GX24082@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 02:53:11PM +0100, Patrick Bellasi wrote:
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 72df2dc779bc..513608ae4908 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -764,6 +764,50 @@ extern void rto_push_irq_work_func(struct irq_work *work);
>  #endif
>  #endif /* CONFIG_SMP */
>  
> +#ifdef CONFIG_UCLAMP_TASK
> +/**
> + * struct uclamp_group - Utilization clamp Group
> + * @value: utilization clamp value for tasks on this clamp group
> + * @tasks: number of RUNNABLE tasks on this clamp group
> + *
> + * Keep track of how many tasks are RUNNABLE for a given utilization
> + * clamp value.
> + */
> +struct uclamp_group {
> +	int value;
> +	int tasks;
> +};

We could use bit fields again to compress in 10:22 bits I suppose. 4M
tasks is quite a lot to have runnable on a single CPU ;-)
