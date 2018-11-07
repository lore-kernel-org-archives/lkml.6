Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FDDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611BB20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611BB20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeKGVIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:08:54 -0500
Received: from foss.arm.com ([217.140.101.70]:49404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbeKGVIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:08:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B7F780D;
        Wed,  7 Nov 2018 03:38:55 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CA533F5CF;
        Wed,  7 Nov 2018 03:38:52 -0800 (PST)
Date:   Wed, 7 Nov 2018 11:38:49 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v5 09/15] sched/cpufreq: uclamp: add utilization clamping
 for FAIR tasks
Message-ID: <20181107113849.GC14309@e110439-lin>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-11-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029183311.29175-11-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-Oct 18:33, Patrick Bellasi wrote:

[...]

> +#ifdef CONFIG_UCLAMP_TASK
> +/**
> + * clamp_util: clamp a utilization value for a specified CPU
> + * @rq: the CPU's RQ to get the clamp values from
> + * @util: the utilization signal to clamp
> + *
> + * Each CPU tracks util_{min,max} clamp values depending on the set of its
> + * currently RUNNABLE tasks. Given a utilization signal, i.e a signal in
> + * the [0..SCHED_CAPACITY_SCALE] range, this function returns a clamped
> + * utilization signal considering the current clamp values for the
> + * specified CPU.
> + *
> + * Return: a clamped utilization signal for a given CPU.
> + */
> +static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
> +{
> +	unsigned int min_util = rq->uclamp.value[UCLAMP_MIN];
> +	unsigned int max_util = rq->uclamp.value[UCLAMP_MAX];

Just notice here we can have an issue.

For each scheduling entity, we always ensure that:

    util_min <= util_max

However, since CPU's {min,max}_util clamps are always MAX aggregated
considering the corresponding clamps of RUNNABLE tasks with
_different_ clamps, we can end up with CPU clamps where:

    util_min > util_max

Thus, we need to add the following sanity check here:

+       if (unlikely(min_util > max_util))
+               return min_util;

> +
> +	return clamp(util, min_util, max_util);
> +}

-- 
#include <best/regards.h>

Patrick Bellasi
