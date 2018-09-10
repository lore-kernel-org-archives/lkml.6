Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45446C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE80B20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z2hdUhYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE80B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeIJTGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:06:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49440 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbeIJTGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=armGffEA1/M7pRn3Mqd4oa4RAnQ93pcaX/gQ46mjXeI=; b=Z2hdUhYOl6jZJpeudWjSrwWrW
        AfCUMN66T2nPAjEyMl4RKvHALCPIsPrHYkOWOq3VxZhXUDdMHzrByPDg6tYmTRV7pRd0CcZo47jVl
        b102Cd6NFLsonGekO+JuPexLwyJtTkYlvGoBdsgYYatHh1oGEmLgxCFBl8fXBNjRbFSmdQZIAcG5d
        H5LbET/46arpEOFXrzF77yWeZ/yUVXkBvkomEOanhOj9eU8iYdp7JQiiSEJ4LXHYQhkEOXpANb3pN
        yZy8N0PCMp8yFpz7DEy/zdairDjjU5EQKR1OMI44Ve5K2+9JR0FdWl2Vq02N1yQlau5HYFwi4Cs2M
        U+29e/6nA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzMv9-0001Uf-R8; Mon, 10 Sep 2018 14:12:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EDF6202C1A02; Mon, 10 Sep 2018 16:12:05 +0200 (CEST)
Date:   Mon, 10 Sep 2018 16:12:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Li Zhijian <zhijianx.li@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Disable LB_BIAS by default
Message-ID: <20180910141205.GM24106@hirez.programming.kicks-ass.net>
References: <20180809135753.21077-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809135753.21077-1-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 02:57:53PM +0100, Dietmar Eggemann wrote:
> LB_BIAS allows the adjustment on how conservative load should be
> balanced.

> It is very likely that LB_BIAS' influence on load balancing can be
> neglected (see test results below). This is further supported by:
> 
> (1) Weighted CPU load today is by itself a decayed average value (PELT)
>     (cfs_rq->avg->runnable_load_avg) and not the instantaneous load
>     (rq->load.weight) it was when LB_BIAS was introduced.
> 
> (2) Sd imbalance_pct is used for CPU_NEWLY_IDLE and CPU_NOT_IDLE (relate
>     to sd's newidle and busy idx) in find_busiest_group() when comparing
>     busiest and local avg load to make load balancing even more
>     conservative.
> 
> (3) The sd forkexec and newidle idx are always set to 0 so there is no
>     adjustment on how conservatively load balancing is done here.
> 
> (4) Affine wakeup based on weight (wake_affine_weight()) will not be
>     impacted since the sd wake idx is always set to 0.
> 
> Let's disable LB_BIAS by default for a few kernel releases to make sure
> that no workload and no scheduler topology is affected. The benefit of
> being able to remove the LB_BIAS dependency from source_load() and
> target_load() is that the entire rq->cpu_load[idx] code could be removed
> in this case.

Certainly worth a try; as I've written somewhere in a comment; it would
be very nice to get rid of that load tracking crud.

And it is trivial to revert if something does show up.

Ingo, what do you think?

> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/features.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 85ae8488039c..858589b83377 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -39,7 +39,7 @@ SCHED_FEAT(WAKEUP_PREEMPTION, true)
>  
>  SCHED_FEAT(HRTICK, false)
>  SCHED_FEAT(DOUBLE_TICK, false)
> -SCHED_FEAT(LB_BIAS, true)
> +SCHED_FEAT(LB_BIAS, false)
>  
>  /*
>   * Decrement CPU capacity based on time not spent running tasks
> -- 
> 2.11.0
> 
