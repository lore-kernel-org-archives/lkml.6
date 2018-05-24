Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965168AbeEXHpV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:45:21 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44491 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935502AbeEXHpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:45:19 -0400
X-Google-Smtp-Source: AB8JxZrhfb2EfqyCOReiIem1+iWHI0kQRqhRA81BmF6p6Ciin2EJHKJ3fpjod05sEsITpM0zALYQiiGstpwthPt9VrA=
MIME-Version: 1.0
In-Reply-To: <1527144234-96396-1-git-send-email-kevin.wangtao@hisilicon.com>
References: <1527144234-96396-1-git-send-email-kevin.wangtao@hisilicon.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 May 2018 09:45:17 +0200
X-Google-Sender-Auth: wPzIQ9ZemikLtjxKHesZ-2nXaOI
Message-ID: <CAJZ5v0ih6s9WviSpg9D+kSt2h8T5Vnx-MziOmYuk1H4yZOYLNg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: reinitialize new policy min/max when writing scaling_(max|min)_freq
To: Kevin Wangtao <kevin.wangtao@hisilicon.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gengyanping@hisilicon.com, sunzhaosheng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 8:43 AM, Kevin Wangtao
<kevin.wangtao@hisilicon.com> wrote:
> consider such situation, current user_policy.min is 1000000,
> current user_policy.max is 1200000, in cpufreq_set_policy,
> other driver may update policy.min to 1200000, policy.max to
> 1300000. After that, If we input "echo 1300000 > scaling_min_freq",
> then user_policy.min will be 1300000, and user_policy.max is
> still 1200000, because the input value is checked with policy.max
> not user_policy.max. if we get all related cpus offline and
> online again, it will cause cpufreq_init_policy fail because
> user_policy.min is higher than user_policy.max.

How do you reproduce this, exactly?

> The solution is when user space tries to write scaling_(max|min)_freq,
> the min/max of new_policy should be reinitialized with min/max
> of user_policy, like what cpufreq_update_policy does.
>
> Signed-off-by: Kevin Wangtao <kevin.wangtao@hisilicon.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b79c532..8b33e08 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -697,6 +697,8 @@ static ssize_t store_##file_name                                    \
>         struct cpufreq_policy new_policy;                               \
>                                                                         \
>         memcpy(&new_policy, policy, sizeof(*policy));                   \
> +       new_policy->min = policy->user_policy.min;                      \
> +       new_policy->max = policy->user_policy.max;                      \

It looks like you haven't even tried to build this, have you?

>                                                                         \
>         ret = sscanf(buf, "%u", &new_policy.object);                    \
>         if (ret != 1)                                                   \
> --
> 2.8.1
>
