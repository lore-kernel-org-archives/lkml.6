Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE66AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B05F21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MSi3ddBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfAVRN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:13:27 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34346 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729316AbfAVRN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5mX3uOPs0Ea+SwmTP+PBPfXEY8NCxY+CmKxc5I2qaOQ=; b=MSi3ddBEszx/AT5tjeydVGqNX
        tb5FTrpkTlVofYEyYaDyR8nxzQ849MjwLx3ujFBjgbgFuO/ld7LbJLFQmXAP+Vwg3XbUM06mIUVNL
        zwj+qNOmkXFl8WhR2N/Cgugkylhdt9rRkiBRskFn0fc3Jv9QV4o12Y/oTT0ypoHbSnkKlWFKU2DyW
        kOd0oiiN5pEzvwD1ZLMIR6W5efudpaKChjPn16V14lc3AHyfIWdwZpQqGng/xhTtqSItpW+1WibvY
        V7ukLeMloMwGBz3s7h1QTzDv0lpZb9oVG/zJ3uxjWAGC1kwR1Fah/ECkmVwIL+u6Ce4SMdLC0lYzR
        9Swbt2apg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glzbw-0005Al-LX; Tue, 22 Jan 2019 17:13:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 213042042CFC2; Tue, 22 Jan 2019 18:13:14 +0100 (CET)
Date:   Tue, 22 Jan 2019 18:13:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v6 08/16] sched/cpufreq: uclamp: Add utilization clamping
 for FAIR tasks
Message-ID: <20190122171314.GS27931@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-9-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115101513.2822-9-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:15:05AM +0000, Patrick Bellasi wrote:
> @@ -342,11 +350,24 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>  		return;
>  	sg_cpu->iowait_boost_pending = true;
>  
> +	/*
> +	 * Boost FAIR tasks only up to the CPU clamped utilization.
> +	 *
> +	 * Since DL tasks have a much more advanced bandwidth control, it's
> +	 * safe to assume that IO boost does not apply to those tasks.

I'm not buying that argument. IO-boost isn't related to b/w management.

IO-boot is more about compensating for hidden dependencies, and those
don't get less hidden for using a different scheduling class.

Now, arguably DL should not be doing IO in the first place, but that's a
whole different discussion.

> +	 * Instead, since RT tasks are not utilization clamped, we don't want
> +	 * to apply clamping on IO boost while there is blocked RT
> +	 * utilization.
> +	 */
> +	max_boost = sg_cpu->iowait_boost_max;
> +	if (!cpu_util_rt(cpu_rq(sg_cpu->cpu)))
> +		max_boost = uclamp_util(cpu_rq(sg_cpu->cpu), max_boost);
> +
>  	/* Double the boost at each request */
>  	if (sg_cpu->iowait_boost) {
>  		sg_cpu->iowait_boost <<= 1;
> -		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
> -			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
> +		if (sg_cpu->iowait_boost > max_boost)
> +			sg_cpu->iowait_boost = max_boost;
>  		return;
>  	}

Hurmph...  so I'm not sold on this bit.
