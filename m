Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC68C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD6B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UqbS6SFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfAUMsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:48:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbfAUMr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=akg9NsvOQxTB9iYhH8J6QqrRyUnPPq1AyWBBeBRuxeM=; b=UqbS6SFn+or342kSXSaiQ2QGw
        dpz1wIcmX5tsk+ctQEAtlApUjsxzvzu0dzQ5Ct8DusNeBAo2NYn2ScXT4G5iwQf2YjwlzXp84/zEJ
        LXBbcgpdVXqeS31DBA54304NPtdgwwKwjks03I7WpjtZBvF/tp0LuXrKo+98nXT0bRx7FFENDQVTo
        eKfr2uHVfrXZLVl6J5TRXjmE5Mc2ssFdhciYD0a+Ktp1IM1P6MlXPWjGvzxaWc/jzdIGP9EFF1Kel
        +Zg/6XUu0ZqVffr5e6cLmwKa3vh2pGE6oZCYEfRWYnkFsl73VcqhSziza64FSzuBTkWq4jDZLrHjw
        UTfdXf5GA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glYza-0008U5-EF; Mon, 21 Jan 2019 12:47:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B0BC20267E54; Mon, 21 Jan 2019 13:47:52 +0100 (CET)
Date:   Mon, 21 Jan 2019 13:47:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, tglx@linutronix.de, hpa@zytor.com,
        torvalds@linux-foundation.org
Cc:     linux-tip-commits@vger.kernel.org, valentin.schneider@arm.com
Subject: Re: [tip:sched/core] sched/fair: Fix rounding bug for asym packing
Message-ID: <20190121124752.GA17749@hirez.programming.kicks-ass.net>
References: <tip-8d2ef665a9bbee36a2a9d855eb4e97d87953fee5@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-8d2ef665a9bbee36a2a9d855eb4e97d87953fee5@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry guys, I seem to have messed this up :/

Valentin pointed me out that I missed v3 and v4 of these patches; v3 got
lost in the x-mas pile and v4 was actually on my todo list for this
week, but I'd forgotten I'd already queued v2.

I'll go queue delta patches.

On Mon, Jan 21, 2019 at 03:33:53AM -0800, tip-bot for Vincent Guittot wrote:
> index 50aa2aba69bd..2ccd6e093326 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8190,6 +8190,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  	/* Adjust by relative CPU capacity of the group */
>  	sgs->group_capacity = group->sgc->capacity;
>  	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
> +	/*
> +	 * Prevent division rounding to make the computation of imbalance
> +	 * slightly less than original value and to prevent the rq to be then
> +	 * selected as busiest queue:
> +	 */
> +	sgs->avg_load += 1;
>  
>  	if (sgs->sum_nr_running)
>  		sgs->load_per_task = sgs->sum_weighted_load / sgs->sum_nr_running;


