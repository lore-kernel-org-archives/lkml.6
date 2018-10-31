Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0607C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8572C2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xItPczqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8572C2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbeKADo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:44:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42674 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730087AbeKADo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bthulb2HGfO4IV6nzJ1hbBGGuiM1/LLCqnuMNPPB4qE=; b=xItPczqo/TfvRwMZwhEZp61mC
        x8ZWngUYn+wyacvhx/ky1I1EPpDW8qVMpsy9L30QdbL8rNsnMAmsWyT1vXt9K6VTLfcLpBWMHXFTg
        Q9xu3NWfYRqiBHtJg2ilF4LbZ5mGNEZDVp+JuoOtgPHQ6UB4elVnLQE6efNoQXTgazfPSfc0qBnFF
        uegDXUvsS7FPeqfQcF9LcpLD1m6OhuZMo4CWqe2b19RVKEFLMelu5LPBxDap3lfyoIrEYREE7m6Nr
        vBj67GORwcT92Mzm4TWI0hNTEd1ibPXjlh0ZalKcA/dNrhb382Z55S4+ixg8FtsLHtP9sQQhvmlx2
        wY1EUgFIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHvUh-0006KB-Hh; Wed, 31 Oct 2018 18:45:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BDCD20297604; Wed, 31 Oct 2018 19:45:28 +0100 (CET)
Date:   Wed, 31 Oct 2018 19:45:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched/fair: util_est: fix cpu_util_wake for execl
Message-ID: <20181031184527.GA3178@hirez.programming.kicks-ass.net>
References: <20181030160947.19581-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030160947.19581-1-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 04:09:47PM +0000, Patrick Bellasi wrote:

> Let's fix this by ensuring to always discount the task estimated
> utilization from the CPU's estimated utilization when the task is also
> the current one. The same benchmark of the bug report, executed on a
> dual socket 40 CPUs Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz machine,
> reports these "Execl Throughput" figures (higher the better):

Before this we have:

	/* Discount task's blocked util from CPU's util */
	util -= min_t(unsigned int, util, task_util(p));

at the very least that comment is now inaccurate, since @p might not be
blocked.

> @@ -6258,8 +6267,17 @@ static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
>  	 * covered by the following code when estimated utilization is
>  	 * enabled.
>  	 */
> -	if (sched_feat(UTIL_EST))
> -		util = max(util, READ_ONCE(cfs_rq->avg.util_est.enqueued));
> +	if (sched_feat(UTIL_EST)) {
> +		unsigned int estimated =
> +			READ_ONCE(cfs_rq->avg.util_est.enqueued);
> +
> +		if (unlikely(current == p || task_on_rq_queued(p))) {

I'm confused by the need for 'current == p', afaict task_on_rq_queued(p)
is sufficient -- we've already established task_cpu(p) == cpu earlier.

> +			estimated -= min_t(unsigned int, estimated,
> +				(_task_util_est(p) | UTIL_AVG_UNCHANGED));
> +		}
> +
> +		util = max(util, estimated);
> +	}

Also, I think it is about time we find a suitable name for:

#define xxx(_var, _val) do { \
	typeof(_var) var = (_var); \
	typeof(_var) val = (_val); \
	typeof(_var) res = var - val; \
	if (res > var) \
		res = 0; \
	(_var) = res; \
} while (0)

Which is basically sub_positive() but without the READ_ONCE/WRITE_ONCE
stuff. We do that:

	var -= min_t(typeof(var), var, val);

pattern _all_ over.
