Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeBEJWh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:22:37 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64114 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752798AbeBEJVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:21:35 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bo Yan <byan@nvidia.com>
Cc: viresh.kumar@linaro.org, sgurrappadi@nvidia.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: skip cpufreq resume if it's not suspended
Date: Mon, 05 Feb 2018 10:19:55 +0100
Message-ID: <1563547.VDOW1Ixonm@aspire.rjw.lan>
In-Reply-To: <1516744675-21233-1-git-send-email-byan@nvidia.com>
References: <1516744675-21233-1-git-send-email-byan@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 23, 2018 10:57:55 PM CET Bo Yan wrote:
> cpufreq_resume can be called even without preceding cpufreq_suspend.
> This can happen in following scenario:
> 
>     suspend_devices_and_enter
>        --> dpm_suspend_start
>           --> dpm_prepare
>               --> device_prepare : this function errors out
>           --> dpm_suspend: this is skipped due to dpm_prepare failure
>                            this means cpufreq_suspend is skipped over
>        --> goto Recover_platform, due to previous error
>        --> goto Resume_devices
>        --> dpm_resume_end
>            --> dpm_resume
>                --> cpufreq_resume
> 
> In case schedutil is used as frequency governor, cpufreq_resume will
> eventually call sugov_start, which does following:
> 
>     memset(sg_cpu, 0, sizeof(*sg_cpu));
>     ....
> 
> This effectively erases function pointer for frequency update, causing
> crash later on. The function pointer would have been set correctly if
> subsequent cpufreq_add_update_util_hook runs successfully, but that
> function returns earlier because cpufreq_suspend was not called:
> 
>     if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
> 		return;
> 
> Ideally, suspend should succeed, then things will be fine. But even
> in case of suspend failure, system should not crash.
> 
> The fix is to check cpufreq_suspended first, if it's false, that means
> cpufreq_suspend was not called in the first place, so do not resume
> cpufreq.
> 
> Signed-off-by: Bo Yan <byan@nvidia.com>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 41d148af7748..95b1c4afe14e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1680,6 +1680,10 @@ void cpufreq_resume(void)
>  	if (!cpufreq_driver)
>  		return;
>  
> +	if (unlikely(!cpufreq_suspended)) {
> +		pr_warn("%s: resume after failing suspend\n", __func__);
> +		return;
> +	}
>  	cpufreq_suspended = false;
>  
>  	if (!has_target() && !cpufreq_driver->resume)

I've just edited this patch somewhat (mostly by dropping the pr_warn())
and queued it up.

Thanks,
Rafael
