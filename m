Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83003C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345F320671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="diNn5scx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="diNn5scx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345F320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJWOVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:21:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57808 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeJWOVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:21:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DDA3860CEC; Tue, 23 Oct 2018 05:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540274384;
        bh=ah3AYubnT7CWj12YwSCCCanSszEDXUFxDQJBseUvbNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=diNn5scxWI2i3cG/Ua8fAUj2DqbgRAJDlIAPSPKqtH33s0EiSzDXkIBMIHDHQ+Uh2
         G+f3uMIWsMen9bKbhatC9IZm9hhcxIeathy/A/8N+jXCPoD7a1G30D3tR1iqYM/GEb
         7Pi2mz+3r3iqEO2dAnRPOkN0lMlJWC9jISXIuCb8=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC27C60C1B;
        Tue, 23 Oct 2018 05:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540274384;
        bh=ah3AYubnT7CWj12YwSCCCanSszEDXUFxDQJBseUvbNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=diNn5scxWI2i3cG/Ua8fAUj2DqbgRAJDlIAPSPKqtH33s0EiSzDXkIBMIHDHQ+Uh2
         G+f3uMIWsMen9bKbhatC9IZm9hhcxIeathy/A/8N+jXCPoD7a1G30D3tR1iqYM/GEb
         7Pi2mz+3r3iqEO2dAnRPOkN0lMlJWC9jISXIuCb8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC27C60C1B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 23 Oct 2018 11:29:37 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        patrick.bellasi@arm.com, pjt@google.com, bsegall@google.com,
        thara.gopinath@linaro.org
Subject: Re: [PATCH v4 2/2] sched/fair: update scale invariance of PELT
Message-ID: <20181023055937.GC27587@codeaurora.org>
References: <1539965871-22410-1-git-send-email-vincent.guittot@linaro.org>
 <1539965871-22410-3-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539965871-22410-3-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Fri, Oct 19, 2018 at 06:17:51PM +0200, Vincent Guittot wrote:
>  
>  /*
> + * The clock_pelt scales the time to reflect the effective amount of
> + * computation done during the running delta time but then sync back to
> + * clock_task when rq is idle.
> + *
> + *
> + * absolute time   | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|14|15|16
> + * @ max capacity  ------******---------------******---------------
> + * @ half capacity ------************---------************---------
> + * clock pelt      | 1| 2|    3|    4| 7| 8| 9|   10|   11|14|15|16
> + *
> + */
> +void update_rq_clock_pelt(struct rq *rq, s64 delta)
> +{
> +
> +	if (is_idle_task(rq->curr)) {
> +		u32 divider = (LOAD_AVG_MAX - 1024 + rq->cfs.avg.period_contrib) << SCHED_CAPACITY_SHIFT;
> +		u32 overload = rq->cfs.avg.util_sum + LOAD_AVG_MAX;
> +		overload += rq->avg_rt.util_sum;
> +		overload += rq->avg_dl.util_sum;
> +
> +		/*
> +		 * Reflecting some stolen time makes sense only if the idle
> +		 * phase would be present at max capacity. As soon as the
> +		 * utilization of a rq has reached the maximum value, it is
> +		 * considered as an always runnnig rq without idle time to
> +		 * steal. This potential idle time is considered as lost in
> +		 * this case. We keep track of this lost idle time compare to
> +		 * rq's clock_task.
> +		 */
> +		if (overload >= divider)
> +			rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
> +

I am trying to understand this better. I believe we run into this scenario, when
the frequency is limited due to thermal/userspace constraints. Lets say
frequency is limited to Fmax/2. A 50% task at Fmax, becomes 100% running at
Fmax/2. The utilization is built up to 100% after several periods.
The clock_pelt runs at 1/2 speed of the clock_task. We are loosing the idle time
all along. What happens when the CPU enters idle for a short duration and comes
back to run this 100% utilization task?

If the above block is not present i.e lost_idle_time is not tracked, we
stretch the idle time (since clock_pelt is synced to clock_task) and the
utilization is dropped. Right?

With the above block, we don't stretch the idle time. In fact we don't
consider the idle time at all. Because,

idle_time = now - last_time;

idle_time = (rq->clock_pelt - rq->lost_idle_time) - last_time
idle_time = (rq->clock_task - rq_clock_task + rq->clock_pelt_old) - last_time
idle_time = rq->clock_pelt_old - last_time

The last time is nothing but the last snapshot of the rq->clock_pelt when the
task entered sleep due to which CPU entered idle.

Can you please explain the significance of the above block with an example?

> +
> +		/* The rq is idle, we can sync to clock_task */
> +		rq->clock_pelt  = rq_clock_task(rq);
> +
> +
> +	} else {
> +		/*
> +		 * When a rq runs at a lower compute capacity, it will need
> +		 * more time to do the same amount of work than at max
> +		 * capacity: either because it takes more time to compute the
> +		 * same amount of work or because taking more time means
> +		 * sharing more often the CPU between entities.
> +		 * In order to be invariant, we scale the delta to reflect how
> +		 * much work has been really done.
> +		 * Running at lower capacity also means running longer to do
> +		 * the same amount of work and this results in stealing some
> +		 * idle time that will disturb the load signal compared to
> +		 * max capacity; This stolen idle time will be automaticcally
> +		 * reflected when the rq will be idle and the clock will be
> +		 * synced with rq_clock_task.
> +		 */
> +
> +		/*
> +		 * scale the elapsed time to reflect the real amount of
> +		 * computation
> +		 */
> +		delta = cap_scale(delta, arch_scale_freq_capacity(cpu_of(rq)));
> +		delta = cap_scale(delta, arch_scale_cpu_capacity(NULL, cpu_of(rq)));
> +
> +		rq->clock_pelt += delta;

AFAICT, the rq->clock_pelt is used for both utilization and load. So the load
also becomes a function of CPU uarch now. Is this intentional?

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

