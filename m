Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F549C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D1A20844
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aCeKFXWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfA3OBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:01:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfA3OBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6lzVh2wvlfXGZu2kPTyjkTFUgAx0VCpukN6yuZ4veas=; b=aCeKFXWMSolq8OiQfhIrjcPKq
        kZK30vfBnuFN7cSjYXbNNJD1iWGUEntrHV4mIG3e1FcIkRHG40/5NHclz1pKGy2zIaGhs2uSe4AMT
        oQFfQ0/57/7qt2Fre3dH2NA0LbTZdJKVs82Jt5MeACi2HqWV/6u4NWGeI9ujUBaa11++GFWUQv7uK
        8ZrbvE8L1RlyEuu1RU/P8GlR2zZcDphnQSUE8mkHgfvP+vunR9Rkm9Xvo1/cE3vjXxo8XDcqF6wvr
        0GQEIsXG2tXUGtnjywBqmOSXVrapBBaIZBmEIRr80pItZaFg4TrWFiE8ei/M4T8yFtf4/7xr4W8bN
        0M/1MT9Lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goqR0-0005Px-21; Wed, 30 Jan 2019 14:01:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D5D6200E2F88; Wed, 30 Jan 2019 15:01:44 +0100 (CET)
Date:   Wed, 30 Jan 2019 15:01:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tj@kernel.org,
        sargun@sargun.me
Subject: Re: [PATCH v2] sched/fair: Fix insertion in rq->leaf_cfs_rq_list
Message-ID: <20190130140144.GD3103@hirez.programming.kicks-ass.net>
References: <1548782332-18591-1-git-send-email-vincent.guittot@linaro.org>
 <1548825767-10799-1-git-send-email-vincent.guittot@linaro.org>
 <20190130140104.GB2296@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130140104.GB2296@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 03:01:04PM +0100, Peter Zijlstra wrote:
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -282,13 +282,15 @@ static inline struct cfs_rq *group_cfs_r
>  	return grp->my_q;
>  }
>  
> -static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> +static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>  	struct rq *rq = rq_of(cfs_rq);
>  	int cpu = cpu_of(rq);
>  
>  	if (cfs_rq->on_list)
> -		return;
> +		return rq->tmp_alone_branch == &rq->leaf_cfs_rq_list;

And I'm almost certain that can be: return true, but got my brain in a
twist.

> +
> +	cfs_rq->on_list = 1;
>  
>  	/*
>  	 * Ensure we either appear before our parent (if already
