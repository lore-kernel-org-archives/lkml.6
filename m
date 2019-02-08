Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006FCC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38B420823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PHgRzu29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfBHQbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:31:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHQbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=83jpPxJM486akqxuTBC53+NOQe+tt70tmrEbbWB+MAg=; b=PHgRzu29beAh1wwp3aex8lZ0v
        VHuMGCuxAc2HbX9EyJI3/G/MF6gCDUQX/ub0CAzBElc13i9FJXTu66j7PhqMzAxqJ1BLkv6cZyUNz
        vk1FQEEqjfvGfQMXyWTcwsD0NBbLETc0gyTkJ/XLwM6eMMVULDs1X0jsMz8ZOBcOAicAxG9X6W/5D
        YgM2zZcjmeyNE0EZpLEPWkCby7fs7qaMXAQ0+LnYrbr8oFuC7yu+EO24URJj7NZNnxWPtiz081ueW
        qHXeKd1dhxFTkkKFhe7dpnaEM4PO9PKnVXkoKr1oi2tPjjFMXH0ESrGEu43//bUw+NLOwbLpQR+qx
        V8yI/EMOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gs93N-0005AS-8n; Fri, 08 Feb 2019 16:31:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDF0621441088; Fri,  8 Feb 2019 17:30:58 +0100 (CET)
Date:   Fri, 8 Feb 2019 17:30:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tj@kernel.org,
        sargun@sargun.me, xiexiuqi@huawei.com, xiezhipeng1@huawei.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] sched/fair: optimization of update_blocked_averages()
Message-ID: <20190208163058.GL32511@hirez.programming.kicks-ass.net>
References: <1549469662-13614-1-git-send-email-vincent.guittot@linaro.org>
 <1549469662-13614-2-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549469662-13614-2-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 05:14:21PM +0100, Vincent Guittot wrote:
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -346,6 +346,18 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>  static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>  	if (cfs_rq->on_list) {
> +		struct rq *rq = rq_of(cfs_rq);
> +
> +		/*
> +		 * With cfs_rq being unthrottled/throttled during an enqueue,
> +		 * it can happen the tmp_alone_branch points the a leaf that
> +		 * we finally want to del. In this case, tmp_alone_branch moves
> +		 * to the prev element but it will point to rq->leaf_cfs_rq_list
> +		 * at the end of the enqueue.
> +		 */
> +		if (rq->tmp_alone_branch == &cfs_rq->leaf_cfs_rq_list)
> +			rq->tmp_alone_branch = cfs_rq->leaf_cfs_rq_list.prev;
> +
>  		list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
>  		cfs_rq->on_list = 0;
>  	}

So that is:

  enqueue_task_fair()
    enqueue_entity()
      list_add_lead_cfs_rq()
      check_enqueue_throttle()
        throttle_cfs_rq()
	  walk_tg_tree_from()
	    tg_throttle_down()
	      list_del_leaf_cfs_rq()

Which can try and remove a cfs_rq which we just added.

And because the list is a bottom-up order, and the deletion is a
downward operation, we must go back (prev) in the list.

So far so good I suppose.

> @@ -4449,8 +4465,10 @@ static int tg_throttle_down(struct task_group *tg, void *data)
>  	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>  
>  	/* group is entering throttled state, stop time */
> -	if (!cfs_rq->throttle_count)
> +	if (!cfs_rq->throttle_count) {
>  		cfs_rq->throttled_clock_task = rq_clock_task(rq);
> +		list_del_leaf_cfs_rq(cfs_rq);
> +	}
>  	cfs_rq->throttle_count++;
>  
>  	return 0;


