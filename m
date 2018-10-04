Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D23C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECA3213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l7TBU4kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECA3213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeJDO7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:59:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48492 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbeJDO7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gc89tC4v2nRmPdkfJKn7N6U6PYd8zOaipSbS9oiaUMM=; b=l7TBU4kq34gIeQW6HPH0DLZ/b
        nOcFz3VXpGhJ2UFzb/QDCc5Bn4crSZaeFES0IzvmA4yLj4QiZo6Rtusn3AvlHCYy6eKaz/4EFoirr
        sXiKt5pstUbX9a41FU833ivZc3B53b5pJOUyNq/HsqBSnmjiQGri03kqbfaAWAXfBvv1/ybNbPhBX
        KHnbRUBPOq3Kc/eE0Ti2ogiUPA3UY6wqGlaHcTMelhePPCkVZ+WhENoUwkRi2YG7q3EJkcHWkOwT/
        o+qVFte7e4GjG0TSsADSDOis3Ey6wmY8n1A/8oayIxGbiHUOT40nl7r1+oNxhZ1RATgtsEHExYpgT
        zbAZJqRNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7yfP-00078H-0s; Thu, 04 Oct 2018 08:07:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73E33202C1A0F; Thu,  4 Oct 2018 09:57:03 +0200 (CEST)
Date:   Thu, 4 Oct 2018 09:57:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@android.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Shi <alex.shi@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
Message-ID: <20181004075703.GG19272@hirez.programming.kicks-ass.net>
References: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
 <1538638927-26846-2-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538638927-26846-2-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 09:42:07AM +0200, Daniel Lezcano wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b88a145..5605f03 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2873,25 +2873,12 @@ unsigned long long nr_context_switches(void)
>  
>  	return sum;
>  }
> -/*
> - * Consumers of these two interfaces, like for example the cpufreq menu
> - * governor are using nonsensical data. Boosting frequency for a CPU that has
> - * IO-wait which might not even end up running the task when it does become
> - * runnable.
> - */
>  
>  unsigned long nr_iowait_cpu(int cpu)
 
+static

>  {
>  	return atomic_read(&cpu_rq(cpu)->nr_iowait);
>  }
>  
> -void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
> -{
> -	struct rq *rq = this_rq();
> -	*nr_waiters = atomic_read(&rq->nr_iowait);
> -	*load = rq->load.weight;
> -}
> -
>  /*
>   * IO-wait accounting, and how its mostly bollocks (on SMP).
>   *

I'm obviously all for this :-)
