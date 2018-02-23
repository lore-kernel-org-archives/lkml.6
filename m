Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbeBWFfE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 00:35:04 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:38022 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeBWFfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 00:35:02 -0500
X-Google-Smtp-Source: AG47ELtCTzLNYQUdSMI6iUlGHz1RPi6aBZwSPc1ZFN/NIH2P0Emo+FXvYljEPGHnFrbgh2eBTYkcZjaiNWLUDOkdKn4=
MIME-Version: 1.0
In-Reply-To: <1519226968-19821-8-git-send-email-daniel.lezcano@linaro.org>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org> <1519226968-19821-8-git-send-email-daniel.lezcano@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 23 Feb 2018 11:05:01 +0530
X-Google-Sender-Auth: d4XUgBFCx1W7a-PhIDMeDQpXsAg
Message-ID: <CAOh2x==FUO32YJeP3veLmkSKv4a_75oxKnyRWa9HzqWLgngknQ@mail.gmail.com>
Subject: Re: [PATCH V2 7/7] cpuidle/drivers/cpuidle-arm: Register the cooling device
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, kevin.wangtao@linaro.org,
        Leo Yan <leo.yan@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, amit.kachhap@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        javi.merino@kernel.org, Zhang Rui <rui.zhang@intel.com>,
        daniel.thompson@linaro.org, Linux PM list <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 8:59 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> Register the ARM generic cpuidle driver as a cooling device.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-arm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index ddee1b6..c100915 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -11,6 +11,7 @@
>
>  #define pr_fmt(fmt) "CPUidle arm: " fmt
>
> +#include <linux/cpu_cooling.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -172,6 +173,10 @@ static int __init arm_idle_init(void)
>                         goto out_fail;
>         }
>
> +       ret = cpuidle_cooling_register();
> +       if (ret)
> +               pr_warn("Failed to register the cpuidle cooling device\n");
> +

Because you aren't going to use the return value here, it might be better
to change return type of cpuidle_cooling_register() as "void" and do
error printing from within that routine.
