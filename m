Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939269AbeE1NyL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:54:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37384 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162961AbeE1Klb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:41:31 -0400
X-Google-Smtp-Source: ADUXVKJFWO3tYGbija4z9L9gN8vCUORKePIV0BhIMyiZBkxfiheH34nPTHRbxMGf6DipwK8xkXdVsw==
Date: Mon, 28 May 2018 12:41:27 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com,
        quentin.perret@arm.com
Subject: Re: [PATCH v5 08/10] cpufreq/schedutil: take into account interrupt
Message-ID: <20180528104127.GB1293@localhost.localdomain>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-9-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527253951-22709-9-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 25/05/18 15:12, Vincent Guittot wrote:
> The time spent under interrupt can be significant but it is not reflected
> in the utilization of CPU when deciding to choose an OPP. Now that we have
> access to this metric, schedutil can take it into account when selecting
> the OPP for a CPU.
> The CPU utilization is :
>   irq util_avg + (1 - irq util_avg / max capacity ) * /Sum rq util_avg

IIUC the code below you actually propose that

 util = [(max_cap - util_irq) * util_rq] / max_cap + util_irq

where

 util_rq  = /Sum rq util_avg
 util_irq = irq util_avg

So, which one is what you have in mind? Or am I wrong? :)

[...]

>  static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> @@ -190,9 +192,17 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>  	if (rq->rt.rt_nr_running) {
>  		util = sg_cpu->max;
>  	} else {
> +		/* Sum rq utilization*/
>  		util = sg_cpu->util_dl;
>  		util += sg_cpu->util_cfs;
>  		util += sg_cpu->util_rt;
> +
> +		/* Weight rq's utilization to the normal context */
> +		util *= (sg_cpu->max - sg_cpu->util_irq);
> +		util /= sg_cpu->max;
> +
> +		/* Add interrupt utilization */
> +		util += sg_cpu->util_irq;

Thanks,

- Juri
