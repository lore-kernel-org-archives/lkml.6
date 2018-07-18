Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88356ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492FE2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492FE2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbeGRWLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:11:06 -0400
Received: from foss.arm.com ([217.140.101.70]:40396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbeGRWLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:11:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CBC918A;
        Wed, 18 Jul 2018 14:31:18 -0700 (PDT)
Received: from [10.37.8.139] (unknown [10.37.8.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E2DA3FAA1;
        Wed, 18 Jul 2018 14:31:17 -0700 (PDT)
Subject: Re: [PATCH] coresight: etm_perf: Rework alloc/free methods to avoid
 lockep warning
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
References: <1531942988-20901-1-git-send-email-mathieu.poirier@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d648155e-0486-7d7c-5e29-2bda6c536dba@arm.com>
Date:   Wed, 18 Jul 2018 22:31:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1531942988-20901-1-git-send-email-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 07/18/2018 08:43 PM, Mathieu Poirier wrote:
> When enabling the lockdep mechanic and working with CPU-wide scenarios we
> get the following console output:
> 

> This is fixed by working with the cpu_present_mask, avoinding at the same
> the need to use get/put_online_cpus() that triggers lockdep.

The patch looks correct to me. In fact I have a patch [1], which
does the same thing and switches to using per-cpu variable for the
paths.

> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 39 +++++++++++++-----------
>   1 file changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 677695635211..16b9c87d9d00 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -108,26 +108,32 @@ static int etm_event_init(struct perf_event *event)
>   static void free_event_data(struct work_struct *work)
>   {
>   	int cpu;
> +	void *snk_config;
>   	cpumask_t *mask;
>   	struct etm_event_data *event_data;
>   	struct coresight_device *sink;
>   
>   	event_data = container_of(work, struct etm_event_data, work);
>   	mask = &event_data->mask;
> -	/*
> -	 * First deal with the sink configuration.  See comment in
> -	 * etm_setup_aux() about why we take the first available path.
> -	 */
> -	if (event_data->snk_config) {
> -		cpu = cpumask_first(mask);
> -		sink = coresight_get_sink(event_data->path[cpu]);
> -		if (sink_ops(sink)->free_buffer)
> -			sink_ops(sink)->free_buffer(event_data->snk_config);
> -	}
> +	snk_config = event_data->snk_config;
>   
>   	for_each_cpu(cpu, mask) {
> -		if (!(IS_ERR_OR_NULL(event_data->path[cpu])))
> -			coresight_release_path(event_data->path[cpu]);
> +		if (IS_ERR_OR_NULL(event_data->path[cpu]))
> +			continue;
> +
> +		/*
> +		 * Free sink configuration - there can only be one sink
> +		 * per event.
> +		 */
> +		if (snk_config) {
> +			sink = coresight_get_sink(event_data->path[cpu]);
> +			if (sink_ops(sink)->free_buffer) {
> +				sink_ops(sink)->free_buffer(snk_config);
> +				snk_config = NULL;
> +			}
> +		}
> +
> +		coresight_release_path(event_data->path[cpu]);
>   	}

>   
>   	kfree(event_data->path);
> @@ -145,16 +151,13 @@ static void *alloc_event_data(int cpu)
>   	if (!event_data)
>   		return NULL;
>   
> -	/* Make sure nothing disappears under us */
> -	get_online_cpus();
> -	size = num_online_cpus();
> -
>   	mask = &event_data->mask;
> +	size = num_present_cpus();
> +
>   	if (cpu != -1)
>   		cpumask_set_cpu(cpu, mask);
>   	else
> -		cpumask_copy(mask, cpu_online_mask);
> -	put_online_cpus();
> +		cpumask_copy(mask, cpu_present_mask);

I think it is safe to use cpu_online_mask outside the
get/put_online_cpus(). Using present_mask may fail as
we could fail to create a path for a CPU that is not online.


Please could you check if [1] fixes the problem for you ?

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/591606.html

Cheers
Suzuki
