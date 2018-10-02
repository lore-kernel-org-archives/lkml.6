Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C82C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAA12064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q7GzRv3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAA12064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeJBTNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:13:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbeJBTNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HSr3FhwV9XplMIOZboEhtSsPPSBy1VziUnZk167T0vI=; b=Q7GzRv3WrRNOvBMPSnSV7gfO6
        aWHDcHAPG9SRuUL1sRopj8TKdd4wjcyzoQ+xi7HsqwYKruJWnLL8RLp7xqqCFwONKMJExjm+lhFzl
        iuKTQZUKKWpg7E1COyULRoeQQcBywcNrCUAAbQ68+mVqeVt9AWvceVB36IKWvaE766TZh2jWmFbGN
        oYXioNdoACdMnbltvXGNaVf5ALCfNCfkncZaxsQNYoXifXeASWI4Wz/0SBThN5ndYHPAZiWLVIwrt
        Wv18/kazWmMPstIX44qCvoYy7AMBc9/LiRsPJapkvT2q8OGauXE7wVpVj3R2cb4Si+bloM9VqEQFw
        +LZoTCmjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7Jov-0005dg-R3; Tue, 02 Oct 2018 12:30:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4DAD2025A349; Tue,  2 Oct 2018 14:30:31 +0200 (CEST)
Date:   Tue, 2 Oct 2018 14:30:31 +0200
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
Subject: Re: [PATCH v7 03/14] PM: Introduce an Energy Model management
 framework
Message-ID: <20181002123031.GZ3439@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912091309.7551-4-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:12:58AM +0100, Quentin Perret wrote:
> +/**
> + * em_register_perf_domain() - Register the Energy Model of a performance domain
> + * @span	: Mask of CPUs in the performance domain
> + * @nr_states	: Number of capacity states to register
> + * @cb		: Callback functions providing the data of the Energy Model
> + *
> + * Create Energy Model tables for a performance domain using the callbacks
> + * defined in cb.
> + *
> + * If multiple clients register the same performance domain, all but the first
> + * registration will be ignored.
> + *
> + * Return 0 on success
> + */
> +int em_register_perf_domain(cpumask_t *span, unsigned int nr_states,
> +						struct em_data_callback *cb)
> +{
> +	unsigned long cap, prev_cap = 0;
> +	struct em_perf_domain *pd;
> +	int cpu, ret = 0;
> +
> +	if (!span || !nr_states || !cb)
> +		return -EINVAL;
> +
> +	/*
> +	 * Use a mutex to serialize the registration of performance domains and
> +	 * let the driver-defined callback functions sleep.
> +	 */
> +	mutex_lock(&em_pd_mutex);
> +
> +	for_each_cpu(cpu, span) {
> +		/* Make sure we don't register again an existing domain. */
> +		if (READ_ONCE(per_cpu(em_data, cpu))) {
> +			ret = -EEXIST;
> +			goto unlock;
> +		}
> +
> +		/*
> +		 * All CPUs of a domain must have the same micro-architecture
> +		 * since they all share the same table.
> +		 */
> +		cap = arch_scale_cpu_capacity(NULL, cpu);
> +		if (prev_cap && prev_cap != cap) {
> +			pr_err("CPUs of %*pbl must have the same capacity\n",
> +							cpumask_pr_args(span));
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
> +		prev_cap = cap;
> +	}
> +
> +	/* Create the performance domain and add it to the Energy Model. */
> +	pd = em_create_pd(span, nr_states, cb);
> +	if (!pd) {
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	for_each_cpu(cpu, span)
> +		WRITE_ONCE(per_cpu(em_data, cpu), pd);

It's not immediately obvious to me why this doesn't need to be
smp_store_release(). The moment you publish that pointer, it can be
read, right?

Even if you never again change the pointer value, you want to ensure the
content of pd is stable before pd itself is observable, right?

> +
> +	pr_debug("Created perf domain %*pbl\n", cpumask_pr_args(span));
> +unlock:
> +	mutex_unlock(&em_pd_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(em_register_perf_domain);
> -- 
> 2.18.0
> 
