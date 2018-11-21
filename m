Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAE8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3647E214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KOY5BEKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3647E214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbeKVBCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:02:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbeKVBCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RGgf+RGYgeOH6bNPQ8M/PQp4i4mIU1zC+ATlh14g5rU=; b=KOY5BEKfu5V/UyY83VM5pJ6ll
        KBK1fjfZzhaMHMOqrnCn4SWhmYy/wf2ZsmAmT3NwSlNqsvqsJewQPUUk/+tM6FG8bEbWq5ciUOPpJ
        LH3785hgZ4hPs2vMdkHf58aQwmAT144sf65d02W+Dyi5/Vp2HNultbp/wyciWqspRWlHSSHzAFwrL
        K5qrYRIexO4HE7FV+23tAi0UQ+M5tWe3HHxjpEQRQom3iP8qSKJiwa0UgqzSRCaD7brpcCiuq1Av4
        sWBKOTF9zHqM1acfLK84qd+r2KQXhQm6f6Z6y250BOCl4ilSSX3GnSc5EL+1IA/NqaSZWYtcDdB0b
        gPTuEIQzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPTU5-00026z-B0; Wed, 21 Nov 2018 14:28:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6BE012029FD58; Wed, 21 Nov 2018 15:28:03 +0100 (CET)
Date:   Wed, 21 Nov 2018 15:28:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v9 13/15] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20181121142803.GF2113@hirez.programming.kicks-ass.net>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-14-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119141857.8625-14-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 02:18:55PM +0000, Quentin Perret wrote:
> +static long
> +compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
> +{
> +	long util, max_util, sum_util, energy = 0;
> +	int cpu;
> +
> +	for (; pd; pd = pd->next) {
> +		max_util = sum_util = 0;
> +		/*
> +		 * The capacity state of CPUs of the current rd can be driven by
> +		 * CPUs of another rd if they belong to the same performance
> +		 * domain. So, account for the utilization of these CPUs too
> +		 * by masking pd with cpu_online_mask instead of the rd span.
> +		 *
> +		 * If an entire performance domain is outside of the current rd,
> +		 * it will not appear in its pd list and will not be accounted
> +		 * by compute_energy().
> +		 */
> +		for_each_cpu_and(cpu, perf_domain_span(pd), cpu_online_mask) {

Should that not be cpu_active_mask ?

> +			util = cpu_util_next(cpu, p, dst_cpu);
> +			util = schedutil_energy_util(cpu, util);
> +			max_util = max(util, max_util);
> +			sum_util += util;
> +		}
> +
> +		energy += em_pd_energy(pd->em_pd, max_util, sum_util);
> +	}
> +
> +	return energy;
> +}
