Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E2CC2F42E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4607320879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yCzzC1HL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfAUPR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:17:27 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51456 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbfAUPR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bfbXRV3EoloQoh+a3FDSY+veVyVPBb4w+VbV/lg1eww=; b=yCzzC1HLAdzPfFTfY1IxhzLYt
        LHHS5vCiF1bN+JnjLJLUBT+4iCANQwpoe1ujrZZgZNnh/n/KpauIy5ow8PuUYWhlXQBg0Ks8mN1ri
        4nH3fO+7lNIwzbwXPp9ESidcWFAlcaZHHI5T2Ud3yVpFXenA9ioVaEwz6PUNu7IDUZhK1xHL0KpKy
        vfaK7LhoQWz36BMkujvi3ttk7t7lLcMIQLMLeXnCzX3RCLO6M78mDydyAs8k3QvEGB2qEJev+Ws8m
        22u+iha+1Y1FAkDKTwFl6NQPwEuSBnotjTsK7xWDJMgElccuDLlWY995Ad7ZPpwbQVHY3h2Q68y6G
        0lYL5jthA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glbKB-0006Z7-0y; Mon, 21 Jan 2019 15:17:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7D162846D166; Mon, 21 Jan 2019 16:17:17 +0100 (CET)
Date:   Mon, 21 Jan 2019 16:17:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 04/16] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190121151717.GK27931@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-5-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115101513.2822-5-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:15:01AM +0000, Patrick Bellasi wrote:
> +#ifdef CONFIG_UCLAMP_TASK

> +struct uclamp_bucket {
> +	unsigned long value : bits_per(SCHED_CAPACITY_SCALE);
> +	unsigned long tasks : BITS_PER_LONG - bits_per(SCHED_CAPACITY_SCALE);
> +};

> +struct uclamp_cpu {
> +	unsigned int value;

	/* 4 byte hole */

> +	struct uclamp_bucket bucket[UCLAMP_BUCKETS];
> +};

With the default of 5, this UCLAMP_BUCKETS := 6, so struct uclamp_cpu
ends up being 7 'unsigned long's, or 56 bytes on 64bit (with a 4 byte
hole).

> +#endif /* CONFIG_UCLAMP_TASK */
> +
>  /*
>   * This is the main, per-CPU runqueue data structure.
>   *
> @@ -835,6 +879,11 @@ struct rq {
>  	unsigned long		nr_load_updates;
>  	u64			nr_switches;
>  
> +#ifdef CONFIG_UCLAMP_TASK
> +	/* Utilization clamp values based on CPU's RUNNABLE tasks */
> +	struct uclamp_cpu	uclamp[UCLAMP_CNT] ____cacheline_aligned;

Which makes this 112 bytes with 8 bytes in 2 holes, which is short of 2
64 byte cachelines.

Is that the best layout?

> +#endif
> +
>  	struct cfs_rq		cfs;
>  	struct rt_rq		rt;
>  	struct dl_rq		dl;
> -- 
> 2.19.2
> 
