Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeBBL4B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 06:56:01 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42475 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeBBLzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 06:55:54 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bo Yan <byan@nvidia.com>
Cc: viresh.kumar@linaro.org, sgurrappadi@nvidia.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: skip cpufreq resume if it's not suspended
Date: Fri, 02 Feb 2018 12:54:17 +0100
Message-ID: <17447147.z6jfkRxuEB@aspire.rjw.lan>
In-Reply-To: <913f1715-bdd0-1c03-ad76-38be9d3d2298@nvidia.com>
References: <1516744675-21233-1-git-send-email-byan@nvidia.com> <1744712.rO4QOLozun@aspire.rjw.lan> <913f1715-bdd0-1c03-ad76-38be9d3d2298@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, January 24, 2018 9:53:14 PM CET Bo Yan wrote:
> 
> On 01/23/2018 06:02 PM, Rafael J. Wysocki wrote:
> > On Tuesday, January 23, 2018 10:57:55 PM CET Bo Yan wrote:
> >>   drivers/cpufreq/cpufreq.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index 41d148af7748..95b1c4afe14e 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -1680,6 +1680,10 @@ void cpufreq_resume(void)
> >>   	if (!cpufreq_driver)
> >>   		return;
> >>   
> >> +	if (unlikely(!cpufreq_suspended)) {
> >> +		pr_warn("%s: resume after failing suspend\n", __func__);
> >> +		return;
> >> +	}
> >>   	cpufreq_suspended = false;
> >>   
> >>   	if (!has_target() && !cpufreq_driver->resume)
> >>
> > Good catch, but rather than doing this it would be better to avoid
> > calling cpufreq_resume() at all if cpufreq_suspend() has not been called.
> Yes, I thought about that, but there is no good way to skip over it 
> without introducing another flag. cpufreq_resume is called by 
> dpm_resume, cpufreq_suspend is called by dpm_suspend. In the failure 
> case, dpm_resume is called, but dpm_suspend is not. So on a higher level 
> it's already unbalanced.
> 
> One possibility is to rely on the pm_transition flag. So something like:
> 
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index dc259d20c967..8469e6fc2b2c 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -842,6 +842,7 @@ static void async_resume(void *data, async_cookie_t 
> cookie)
>   void dpm_resume(pm_message_t state)
>   {
>          struct device *dev;
> +       bool suspended = (pm_transition.event != PM_EVENT_ON);
>          ktime_t starttime = ktime_get();
> 
>          trace_suspend_resume(TPS("dpm_resume"), state.event, true);
> @@ -885,7 +886,8 @@ void dpm_resume(pm_message_t state)
>          async_synchronize_full();
>          dpm_show_time(starttime, state, NULL);
> 
> -       cpufreq_resume();
> +       if (likely(suspended))
> +               cpufreq_resume();
>          trace_suspend_resume(TPS("dpm_resume"), state.event, false);
>   }

I was thinking about something else.

Anyway, I think your original patch is OK too, but without printing the
message.  Just combine the cpufreq_suspended check with the cpufreq_driver
one and the unlikely() thing is not necessary.

Thanks,
Rafael
