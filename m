Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED58C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34637217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="seWEhqnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfBFRTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:19:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57904 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfBFRTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y+2h2GT1Gqq2JTag6qDKHu3RpH9WqfItfAsAxRanGMU=; b=seWEhqnOouAOZbRtBM+ubpyZU
        TFD8m0PizYdgrbi9EpGDarYzTUFJwL/ZskDzmfF07v5HTDz9k/2fC7rmLUmJWyS9sv52CFt0O5LvQ
        iFSoutKtjFN13BonCcYUlq1FEYW/9Dy5FR5DSh3RiFNJ3ySH6EK1GjFOUVyBngur/k+Mq7XZtPpeU
        oKPQakk595bbvBMMkC1JmWK647c07gVSewAV1wHkezAYsCzlxBKkRkR87MSVC26RXOh91zA1jSNLt
        iNallJGX7sKmBoJExKqQ4ABpTFeHTNC5ljUD4pAi6/P0hco3H3DZqMkAMzoCtpgAWi4xAbHMiQ+dW
        lP4vdEoPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grQr1-00044g-IT; Wed, 06 Feb 2019 17:19:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5510C2029E070; Wed,  6 Feb 2019 18:19:15 +0100 (CET)
Date:   Wed, 6 Feb 2019 18:19:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     ufo19890607@gmail.com
Cc:     mingo@redhat.com, yun.wang@linux.alibaba.com,
        yuzhoujian@didichuxing.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/debug: Show intergroup and hierarchy sum wait time
 of a task group
Message-ID: <20190206171915.GJ17564@hirez.programming.kicks-ass.net>
References: <1548236816-18712-1-git-send-email-ufo19890607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548236816-18712-1-git-send-email-ufo19890607@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 05:46:56PM +0800, ufo19890607@gmail.com wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e2ff4b6..35e89ca 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -858,6 +858,19 @@ static void update_curr_fair(struct rq *rq)
>  }
>  
>  static inline void
> +update_hierarchy_wait_sum(struct sched_entity *se,
> +			u64 delta_wait)
> +{
> +	for_each_sched_entity(se) {
> +		struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +
> +		if (cfs_rq->tg != &root_task_group)
> +			__schedstat_add(cfs_rq->hierarchy_wait_sum,
> +					delta_wait);
> +	}
> +}
> +
> +static inline void
>  update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
>  	struct task_struct *p;
> @@ -880,6 +893,7 @@ static void update_curr_fair(struct rq *rq)
>  			return;
>  		}
>  		trace_sched_stat_wait(p, delta);
> +		update_hierarchy_wait_sum(se, delta);
>  	}
>  
>  	__schedstat_set(se->statistics.wait_max,

The problem I have with this is that it will make schedstats even more
expensive :/
