Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF91DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECF920836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfBUQTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:19:51 -0500
Received: from foss.arm.com ([217.140.101.70]:47406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfBUQTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:19:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7D71A78;
        Thu, 21 Feb 2019 08:19:50 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B4F83F690;
        Thu, 21 Feb 2019 08:19:48 -0800 (PST)
Subject: Re: [RFC][PATCH 15/16] sched: Trivial forced-newidle balancer
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com
References: <20190218165620.383905466@infradead.org>
 <20190218173514.796920915@infradead.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d7a408c0-b86a-da56-5440-d7cb380708c6@arm.com>
Date:   Thu, 21 Feb 2019 16:19:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218173514.796920915@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/02/2019 16:56, Peter Zijlstra wrote:
[...]
> +static bool try_steal_cookie(int this, int that)
> +{
> +	struct rq *dst = cpu_rq(this), *src = cpu_rq(that);
> +	struct task_struct *p;
> +	unsigned long cookie;
> +	bool success = false;
> +
> +	local_irq_disable();
> +	double_rq_lock(dst, src);
> +
> +	cookie = dst->core->core_cookie;
> +	if (!cookie)
> +		goto unlock;
> +
> +	if (dst->curr != dst->idle)
> +		goto unlock;
> +
> +	p = sched_core_find(src, cookie);
> +	if (p == src->idle)
> +		goto unlock;
> +
> +	do {
> +		if (p == src->core_pick || p == src->curr)
> +			goto next;
> +
> +		if (!cpumask_test_cpu(this, &p->cpus_allowed))
> +			goto next;
> +
> +		if (p->core_occupation > dst->idle->core_occupation)
> +			goto next;
> +

IIUC, we're trying to find/steal tasks matching the core_cookie from other
rqs because dst has been cookie-forced-idle.

If the p we find isn't running, what's the meaning of core_occupation?
I would have expected it to be 0, but we don't seem to be clearing it when
resetting the state in pick_next_task().

If it is running, we prevent the stealing if the core it's on is running
more matching tasks than the core of the pulling rq. It feels to me as if
that's a balancing tweak to try to cram as many matching tasks as possible
in a single core, so to me this reads as "don't steal my tasks if I'm
running more than you are, but I will steal tasks from you if I'm given
the chance". Is that correct?

[...]
