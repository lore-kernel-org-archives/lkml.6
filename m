Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4CEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664942054F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664942054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbeHORzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:55:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55888 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729436AbeHORzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:55:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52A0A80D;
        Wed, 15 Aug 2018 08:02:47 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E5333F5BD;
        Wed, 15 Aug 2018 08:02:43 -0700 (PDT)
Subject: Re: [PATCH v3 04/14] sched/core: uclamp: update CPU's refcount on
 clamp changes
To:     Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-5-patrick.bellasi@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4023267d-be06-c599-136e-1f70bf376d5d@arm.com>
Date:   Wed, 15 Aug 2018 17:02:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806163946.28380-5-patrick.bellasi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 06:39 PM, Patrick Bellasi wrote:

[...]

> +/**
> + * uclamp_task_active: check if a task is currently clamping a CPU
> + * @p: the task to check
> + *
> + * A task actively affects the utilization clamp of a CPU if:
> + * - it's currently enqueued or running on that CPU
> + * - it's refcounted in at least one clamp group of that CPU
> + *
> + * Return: true if p is currently clamping the utilization of its CPU.
> + */
> +static inline bool uclamp_task_active(struct task_struct *p)
> +{
> +	struct rq *rq = task_rq(p);
> +	int clamp_id;
> +
> +	lockdep_assert_held(&p->pi_lock);
> +	lockdep_assert_held(&rq->lock);
> +
> +	if (!task_on_rq_queued(p) && !p->on_cpu)
> +		return false;
> +
> +	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> +		if (uclamp_task_affects(p, clamp_id))
> +			return true;
> +	}
> +
> +	return false;
> +}

Looks like that uclamp_task_active() is only used once (in 
uclamp_task_update_active()). Can you not code the if condition and the 
for loop directly in uclamp_task_update_active()? This would save code 
(lockdep_assert_held() etc.) and comment lines.

[...]

