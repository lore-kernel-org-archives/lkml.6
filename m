Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6ADC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834D12075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rLzT5edO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834D12075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbeIGQNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:13:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55472 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbeIGQNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/4R8LDGIFHOEk/zRh80poFFY7bsGl6Qt3tc2oqtJhYU=; b=rLzT5edOvMgZCvXZMyAQH2sf/
        md11QTRd0WwnmJffgZiDLilY4RxBNM1DtFR/UiC/pxwAyQmLY/RJkYbyM30T4DGsarT/2xIzERTOs
        cf/sw6OXpy/pTbwqOfinHW1ggZnewurEJQ5LQ8DC3ci1L5IVLVoAw/MHxQ/f+dSIOFrUWcLfCHrjV
        QHvJn245rUbmliyUf50Fr1bs+sg4gy6lSmA08r676Mag+P7FEQbquASAcfJX+4JCbhkFoZjthxJxd
        DzOhPk8RnlG3lzLbPgLoFkSGKJHa1Uc0lap2Jar3c7jnonGUJeyuJNr7KrA85/0zcN8x/51OueiWN
        x6Ftd2oVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyF0h-0001UQ-3U; Fri, 07 Sep 2018 11:33:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE160200816FB; Fri,  7 Sep 2018 13:33:09 +0200 (CEST)
Date:   Fri, 7 Sep 2018 13:33:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/numa: Do not move imbalanced load purely on
 the basis of an idle CPU
Message-ID: <20180907113309.GU24106@hirez.programming.kicks-ass.net>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
 <20180907101139.20760-5-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907101139.20760-5-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 11:11:39AM +0100, Mel Gorman wrote:
> Commit 305c1fac3225 ("sched/numa: Evaluate move once per node")
> restructured how task_numa_compare evaluates load but there is an anomaly.
> task_numa_find_cpu() checks if the load balance between too nodes is too
> imbalanced with the intent of only swapping tasks if it would improve
> the balance overall. However, if an idle CPU is encountered, the task is
> still moved if it's the best improvement but an idle cpu is always going
> to appear to be the best improvement.
> 
> If a machine is lightly loaded such that all tasks can fit on one node then
> the idle CPUs are found and the tasks migrate to one socket.  From a NUMA
> perspective, this seems intuitively great because memory accesses are all
> local but there are two counter-intuitive effects.
> 
> First, the load balancer may move tasks so the machine is more evenly
> utilised and conflict with automatic NUMA balancing which may respond by
> scanning more frequently and increasing overhead.  Second, sockets usually
> have their own memory channels so using one socket means that fewer
> channels are available yielding less memory bandwidth overall. For
> memory-bound tasks, it can be beneficial to migrate to another socket and
> migrate the data to increase bandwidth even though the accesses are remote
> in the short term.

> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d59d3e00a480..d4c289c11012 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1560,7 +1560,7 @@ static bool task_numa_compare(struct task_numa_env *env,
>  		goto unlock;
>  
>  	if (!cur) {
> -		if (maymove || imp > env->best_imp)
> +		if (maymove)
>  			goto assign;
>  		else
>  			goto unlock;

Srikar's patch here:

  http://lkml.kernel.org/r/1533276841-16341-4-git-send-email-srikar@linux.vnet.ibm.com

Also frobs this condition, but in a less radical way. Does that yield
similar results?
