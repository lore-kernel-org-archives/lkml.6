Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeBVW1r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 17:27:47 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43139 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbeBVW1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 17:27:46 -0500
X-Google-Smtp-Source: AH8x224dEcXngWsxFkp3a9FDdxArV7gnUTv/vBDd/X3ak1E6/pFiGuD24SlGSTQnKUHMNPKHuv4zeQ1g+o4lCKCh/vY=
MIME-Version: 1.0
In-Reply-To: <20180220111057.14756-1-dietmar.eggemann@arm.com>
References: <20180220111057.14756-1-dietmar.eggemann@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2018 23:27:45 +0100
X-Google-Sender-Auth: 8PeC8iZLMMhxN9cgXYQYv_soujU
Message-ID: <CAJZ5v0hB+Uk8SNVqUH3fr1y0SXbY1Rd26b84P-8PPV8FiPbnWw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: scpi: invoke frequency-invariance setter function
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 12:10 PM, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
> Commit 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> changed the cpufreq driver on juno from arm_big_little to scpi.
>
> The scpi set_target function does not call the frequency-invariance
> setter function arch_set_freq_scale() like the arm_big_little set_target
> function does. As a result the task scheduler load and utilization
> signals are not frequency-invariant on this platform anymore.
>
> Fix this by adding a call to arch_set_freq_scale() into
> scpi_cpufreq_set_target().
>
> Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

This is really minor, but I would reorder this slightly.

> ---
>  drivers/cpufreq/scpi-cpufreq.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index c32a833e1b00..3101d4e9c2de 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -51,13 +51,19 @@ static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
>  static int
>  scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
>  {
> +       unsigned long freq = policy->freq_table[index].frequency;
>         struct scpi_data *priv = policy->driver_data;
> -       u64 rate = policy->freq_table[index].frequency * 1000;
> +       u64 rate = freq * 1000;
>         int ret;
>
>         ret = clk_set_rate(priv->clk, rate);
> -       if (!ret && (clk_get_rate(priv->clk) != rate))
> -               ret = -EIO;
> +       if (!ret) {

I would do:

if (ret)
        return ret;

arch_set_freq_scale(policy->related_cpus, freq, policy->cpuinfo.max_freq);

if (clk_get_rate(priv->clk) != rate)
        return -EIO;

return 0;

That's somewhat easier to follow for me.

> +               if (clk_get_rate(priv->clk) != rate)
> +                       ret = -EIO;
> +
> +               arch_set_freq_scale(policy->related_cpus, freq,
> +                                   policy->cpuinfo.max_freq);
> +       }
>
>         return ret;
>  }
> --

I also am not sure why you want to call arch_set_freq_scale() even if
the new clock rate didn't stick.
