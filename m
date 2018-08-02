Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B450DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605822150B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W8Nd/s3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605822150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbeHBORl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:17:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732034AbeHBORl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=09Y+oiJ6OuY7A5bT81gZvt+MplKry8zPB717wEAV2O0=; b=W8Nd/s3d+tii55H20I5/Tns16
        X153NbdzBIUJxQTXi6P5HWrMU+Z/v9RLQ+GqFywWraKjd5pwAZp9tSW92oKoqKTULHaXKA2/U8jXu
        UOsIo6W4o7CaTWHQ8O9CN2LuK+Wa4vBb1vdwdKhD9WcAomjtmvEzrx0xp2MpaNbDatFLrqrHR4PeU
        oYey/jzwxR5iIrzmv0lhr/0TqzwEY2//ISNKLonK2po4cs/D8Lk3JugfsI4kbU2b+Bmrn5Kwa6E6f
        0NWDTYVbOHpN1PSxoyOCfhwF/xW+5QYT887fXbfukhHfFdu1qDw2+UJ2MwxWT8sSRlSOq0OWdopXM
        0qUu9HzPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flCga-0002BJ-0N; Thu, 02 Aug 2018 12:26:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A667D20268263; Thu,  2 Aug 2018 14:26:29 +0200 (CEST)
Date:   Thu, 2 Aug 2018 14:26:29 +0200
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
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180802122629.GU2476@hirez.programming.kicks-ass.net>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-10-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724122521.22109-10-quentin.perret@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 01:25:16PM +0100, Quentin Perret wrote:
> @@ -5100,8 +5118,17 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		update_cfs_group(se);
>  	}
>  
> -	if (!se)
> +	if (!se) {
>  		add_nr_running(rq, 1);
> +		/*
> +		 * The utilization of a new task is 'wrong' so wait for it
> +		 * to build some utilization history before trying to detect
> +		 * the overutilized flag.
> +		 */
> +		if (flags & ENQUEUE_WAKEUP)
> +			update_overutilized_status(rq);
> +
> +	}
>  
>  	hrtick_update(rq);
>  }

That is a somewhat dodgy hack. There is no guarantee what so ever that
when the task wakes next its history is any better. The comment doesn't
reflect this I feel.
