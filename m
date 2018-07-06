Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7F2C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848E823C9B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n1VLgws9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848E823C9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932598AbeGFLcW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:32:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932236AbeGFLcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bhytBkaRWRt6zmNLyhwf6pbjEpXkaG1/MiG3wWdxk4M=; b=n1VLgws9XVzPXwtrZV/pHfLTu
        I3q2DOaXR7Q5lUuq/uOFUbQptxm2AEGVH9tj6A6DESF2hS6eFFtOjLBwcmhoEEtsXk9FidPq5dpD4
        hCbz2jEEcuQu30olRVPvWYnKtAV+D1DGClgnxqU0uizO1R91z4bmLFcSviDADEH4nOBYd/mAh0RAZ
        Jqcj2XeAC9i3cPiy1idMkS00cPf5rAcCneQ0uzziQDIX4MzU4zK338HFJd5aH7AJxWhey+HNyLiRv
        nyWlYMrk5CQ/BZ2bJdBvaANlYupB9nN/CF/DtCmEvKgw1P9z9Vztl3YVkZE7DALwIIqBWXgjcuYnT
        GylwN8doQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbOyA-0001Sc-0j; Fri, 06 Jul 2018 11:32:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FCD62028932F; Fri,  6 Jul 2018 13:32:08 +0200 (CEST)
Date:   Fri, 6 Jul 2018 13:32:08 +0200
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
Subject: Re: [RFC PATCH v4 08/12] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180706113208.GS2458@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-9-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628114043.24724-9-quentin.perret@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:40:39PM +0100, Quentin Perret wrote:
> @@ -5384,6 +5402,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  {
>  	struct cfs_rq *cfs_rq;
>  	struct sched_entity *se = &p->se;
> +	int task_new = !(flags & ENQUEUE_WAKEUP);
>  
>  	/*
>  	 * The code below (indirectly) updates schedutil which looks at
> @@ -5431,8 +5450,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		update_cfs_group(se);
>  	}
>  
> -	if (!se)
> +	if (!se) {
>  		add_nr_running(rq, 1);
> +		if (!task_new)
> +			update_overutilized_status(rq);

I'm confused... why only for !ENQUEUE_WAKEUP and why use a local
variable for something that's used only once?

> +	}
>  
>  	hrtick_update(rq);
>  }
