Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4D5ECC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03043208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03043208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933855AbeFLIyp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:54:45 -0400
Received: from foss.arm.com ([217.140.101.70]:59292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933363AbeFLIyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:54:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62BCD1435;
        Tue, 12 Jun 2018 01:54:43 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70A303F318;
        Tue, 12 Jun 2018 01:54:40 -0700 (PDT)
Subject: Re: [PATCH v6 08/11] cpufreq/schedutil: take into account interrupt
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, juri.lelli@redhat.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com,
        patrick.bellasi@arm.com, joel@joelfernandes.org,
        daniel.lezcano@linaro.org, quentin.perret@arm.com,
        Ingo Molnar <mingo@redhat.com>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-9-git-send-email-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <cf1f65b9-26cf-24ab-e7b1-0503f2b5e65c@arm.com>
Date:   Tue, 12 Jun 2018 10:54:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528459794-13066-9-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 02:09 PM, Vincent Guittot wrote:

[...]

> @@ -182,21 +183,30 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
>   	sg_cpu->util_dl  = cpu_util_dl(rq);
>   	sg_cpu->bw_dl    = cpu_bw_dl(rq);
>   	sg_cpu->util_rt  = cpu_util_rt(rq);
> +	sg_cpu->util_irq = cpu_util_irq(rq);
>   }
>   
>   static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>   {
>   	struct rq *rq = cpu_rq(sg_cpu->cpu);
> -	unsigned long util;
> +	unsigned long util, max = sg_cpu->max;
>   
>   	if (rq->rt.rt_nr_running)
>   		return sg_cpu->max;
>   
> +	if (unlikely(sg_cpu->util_irq >= max))
> +		return max;
> +
> +	/* Sum rq utilization */
>   	util = sg_cpu->util_cfs;
>   	util += sg_cpu->util_rt;
>   
> -	if ((util + sg_cpu->util_dl) >= sg_cpu->max)
> -		return sg_cpu->max;
> :confirm b9

This didn't let me apply the patch ;-) After removing this line it worked.

[...]
