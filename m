Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10C2C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8A521473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8A521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeJDOii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:38:38 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40389 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeJDOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:38:38 -0400
Received: by mail-oi1-f194.google.com with SMTP id j68-v6so6709351oib.7;
        Thu, 04 Oct 2018 00:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuJbEDr6zitVW+HxPpoH9p/G2TBopwr0q6XrRNQmWIA=;
        b=aE/zYZuDapxiECwoM7NRtI7lQSciuqyjFlCRVdEWr9Sl+SZcf7jQDbkKVz525sZhtH
         ElEdEKBcad9cDNCS/VU80yrGmb0eUtsO/d/1qzXqUjFyiDZ/OT/vh0ny3dR8VUxAqs4H
         h2o/kzk6S/HRXbMmZEPb5Q3GLRUhLrYLcpGGNSLA4rD8jVg2tM2n8733UPgTSG0xiTMS
         NO3VpnlTwvzdHLYJfv4BOI6DtXVCj7j32tu6QIqV/H0HdxyJZJe69yGEWWPO7wHqKwtD
         IDndUog7pyohVeKhd2OMxl55WrfHGu4iCjZX+7TIoYziLPQlYUR1qo4ObJoaFL9mWb2A
         K5FQ==
X-Gm-Message-State: ABuFfog12c8gCSXrIjuOilK7sox3e6/94uASo/QEdxVe6C5CarZ0VoVf
        jgsqCyD8Tb0TDzXL9+HhO3YML+CruGsOA/VmLIM=
X-Google-Smtp-Source: ACcGV63j84aGuT0YNsQYKnZvwasdQwtStEb8IKoIN5d5zj20KZtmFdokUc/rySBuOVYYK39Yi1166YhMN+geXBX3MlY=
X-Received: by 2002:aca:c444:: with SMTP id u65-v6mr2557207oif.8.1538639201527;
 Thu, 04 Oct 2018 00:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
In-Reply-To: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Oct 2018 09:46:30 +0200
Message-ID: <CAJZ5v0jEGB6iwK5nc3VRNcrPRvoQUk0qRn-W-y6nRTB0uoRTHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched: Factor out nr_iowait and nr_iowait_cpu
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 9:42 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The function nr_iowait_cpu() can be used directly by nr_iowait() instead
> of duplicating code.
>
> Call nr_iowait_cpu() from nr_iowait()
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  kernel/sched/core.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 625bc98..b88a145 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2873,6 +2873,24 @@ unsigned long long nr_context_switches(void)
>
>         return sum;
>  }
> +/*
> + * Consumers of these two interfaces, like for example the cpufreq menu
> + * governor are using nonsensical data. Boosting frequency for a CPU that has
> + * IO-wait which might not even end up running the task when it does become
> + * runnable.
> + */
> +
> +unsigned long nr_iowait_cpu(int cpu)
> +{
> +       return atomic_read(&cpu_rq(cpu)->nr_iowait);
> +}
> +
> +void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
> +{
> +       struct rq *rq = this_rq();
> +       *nr_waiters = atomic_read(&rq->nr_iowait);
> +       *load = rq->load.weight;
> +}
>
>  /*
>   * IO-wait accounting, and how its mostly bollocks (on SMP).
> @@ -2909,31 +2927,11 @@ unsigned long nr_iowait(void)
>         unsigned long i, sum = 0;
>
>         for_each_possible_cpu(i)
> -               sum += atomic_read(&cpu_rq(i)->nr_iowait);
> +               sum += nr_iowait_cpu(i);
>
>         return sum;
>  }
>
> -/*
> - * Consumers of these two interfaces, like for example the cpufreq menu
> - * governor are using nonsensical data. Boosting frequency for a CPU that has
> - * IO-wait which might not even end up running the task when it does become
> - * runnable.
> - */
> -
> -unsigned long nr_iowait_cpu(int cpu)
> -{
> -       struct rq *this = cpu_rq(cpu);
> -       return atomic_read(&this->nr_iowait);
> -}
> -
> -void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
> -{
> -       struct rq *rq = this_rq();
> -       *nr_waiters = atomic_read(&rq->nr_iowait);
> -       *load = rq->load.weight;
> -}
> -
>  #ifdef CONFIG_SMP
>
>  /*
> --
> 2.7.4
>
