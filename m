Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971104AbeEXTZr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:25:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47156 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967823AbeEXTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:25:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 396C3602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pprakash@codeaurora.org
Subject: Re: [PATCH] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
To: George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org
References: <1526989324-4183-1-git-send-email-george.cherian@cavium.com>
From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Message-ID: <ac2eb509-c1b0-521a-07e5-2bf8eaaa55c2@codeaurora.org>
Date: Thu, 24 May 2018 13:25:39 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1526989324-4183-1-git-send-email-george.cherian@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On 5/22/2018 5:42 AM, George Cherian wrote:
> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
> feedback via set of performance counters. To determine the actual
> performance level delivered over time, OSPM may read a set of
> performance counters from the Reference Performance Counter Register
> and the Delivered Performance Counter Register.
>
> OSPM calculates the delivered performance over a given time period by
> taking a beginning and ending snapshot of both the reference and
> delivered performance counters, and calculating:
>
> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
>
> Implement the above and hook this to the cpufreq->get method.
>
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index b15115a..a046915 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -240,10 +240,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	return ret;
>  }
>  
> +static int cppc_get_rate_from_fbctrs(struct cppc_perf_fb_ctrs fb_ctrs_t0,
> +				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
> +{
> +	u64 delta_reference, delta_delivered;
> +	u64 reference_perf, ratio;
> +
> +	reference_perf = fb_ctrs_t0.reference_perf;
> +	if (fb_ctrs_t1.reference > fb_ctrs_t0.reference)
> +		delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
> +	else /* Counters would have wrapped-around */
> +		delta_reference  = ((u64)(~((u64)0)) - fb_ctrs_t0.reference) +
> +					fb_ctrs_t1.reference;
> +
> +	if (fb_ctrs_t1.delivered > fb_ctrs_t0.delivered)
> +		delta_delivered = fb_ctrs_t1.delivered - fb_ctrs_t0.delivered;
> +	else /* Counters would have wrapped-around */
> +		delta_delivered  = ((u64)(~((u64)0)) - fb_ctrs_t0.delivered) +
> +					fb_ctrs_t1.delivered;
We need to check that the wraparound time is long enough to make sure that
the counters cannot wrap around more than once. We can register a  get() api
only after checking that wraparound time value is reasonably high.

I am not aware of any platforms where wraparound time is soo short, but
wouldn't hurt to check once during init.
> +
> +	if (delta_reference)  /* Check to avoid divide-by zero */
> +		ratio = (delta_delivered * 1000) / delta_reference;
Why not just return the computed value here instead of *1000 and later /1000?
return (ref_per * delta_del) / delta_ref;
> +	else
> +		return -EINVAL;
Instead of EINVAL, i think we should return current frequency.

The counters can pause if CPUs are in idle state during our sampling interval, so
If the counters did not progress, it is reasonable to assume the delivered perf was
equal to desired perf.

Even if platform wanted to limit, since the CPUs were asleep(idle) we could not have
observed lower performance, so we will not throw off  any logic that could be driven
using the returned value.
> +
> +	return (reference_perf * ratio) / 1000;
This should be converted to KHz as cpufreq is not aware of CPPC abstract scale
> +}
> +
> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> +{
> +	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
> +	int ret;
> +
> +	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
> +	if (ret)
> +		return ret;
> +
> +	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
> +	if (ret)
> +		return ret;
> +
> +	return cppc_get_rate_from_fbctrs(fb_ctrs_t0, fb_ctrs_t1);
> +}
We need to make sure that we get a reasonably sample so make sure the reported
performance is accurate.
The counters can capture short transient throttling/limiting, so by sampling a really
short duration of time we could return quite inaccurate measure of performance.

We need to include some reasonable delay between the two calls. What is reasonable
is debatable - so this can be few(2-10) microseconds defined as default. If the same value
doesn't work for all the platforms, we might need to add a platform specific value.

> +
>  static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.flags = CPUFREQ_CONST_LOOPS,
>  	.verify = cppc_verify_policy,
>  	.target = cppc_cpufreq_set_target,
> +	.get = cppc_cpufreq_get_rate,
>  	.init = cppc_cpufreq_cpu_init,
>  	.stop_cpu = cppc_cpufreq_stop_cpu,
>  	.name = "cppc_cpufreq",
