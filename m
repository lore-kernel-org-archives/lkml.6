Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C5BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E94420857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E94420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbeHAAuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:50:13 -0400
Received: from foss.arm.com ([217.140.101.70]:33176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732635AbeHAAuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:50:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEFCD80D;
        Tue, 31 Jul 2018 16:07:36 -0700 (PDT)
Received: from [10.37.10.25] (unknown [10.37.10.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E09803F5BA;
        Tue, 31 Jul 2018 16:07:34 -0700 (PDT)
Subject: Re: [PATCH v3 05/13] coresight: perf: Allow tracing on hotplugged
 CPUs
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org
References: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
 <1532609691-16863-6-git-send-email-suzuki.poulose@arm.com>
 <20180731174643.GB11692@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <182ebcb4-dece-d6d0-965e-aa0d560bc6b7@arm.com>
Date:   Wed, 1 Aug 2018 00:08:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180731174643.GB11692@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 06:46 PM, Mathieu Poirier wrote:
> On Thu, Jul 26, 2018 at 01:54:43PM +0100, Suzuki K Poulose wrote:
>> At the moment, if there is no CPU specified for a given
>> event, we use cpu_online_mask and try to build path for
>> each of the CPUs in the mask. This could prevent any CPU
>> that is turned online later to be used for the tracing.
>>
>> This patch changes to use the cpu_present_mask and tries
>> to build path for as much CPUs as possible ignoring the
>> failures in building path for some of the CPUs. If ever
>> we try to trace on those CPUs, we fail the operation.
>>
>> Based on a patch from Mathieu Poirier.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm-perf.c | 46 +++++++++++++++---------
>>   1 file changed, 30 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index 6beb662..afe7e7f 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -127,11 +127,9 @@ static void free_event_data(struct work_struct *work)
>>   
>>   	event_data = container_of(work, struct etm_event_data, work);
>>   	mask = &event_data->mask;
>> -	/*
>> -	 * First deal with the sink configuration.  See comment in
>> -	 * etm_setup_aux() about why we take the first available path.
>> -	 */
>> -	if (event_data->snk_config) {
>> +
>> +	/* Free the sink buffers, if there are any */
>> +	if (event_data->snk_config && !WARN_ON(cpumask_empty(mask))) {
> 
> I'm not sure the WARN_ON() is required.
> 
> Here @mask can't be empty since you've added a check in setup_aux().  So if
> @mask does end up being empty something has trampled the memory and we have
> far bigger problems.

And thats exactly why I have a WARN_ON(). The issue is, we can't free 
the sink_config unless we are able to find the sink device. So, if we
ever end up with a sink_config with an empty mask, there is something
seriously wrong and hence the WARN_ON().


> 
> 
>>   		cpu = cpumask_first(mask);
>>   		sink = coresight_get_sink(etm_event_cpu_path(event_data, cpu));
>>   		if (sink_ops(sink)->free_buffer)
>> @@ -166,7 +164,7 @@ static void *alloc_event_data(int cpu)

...

>> -	if (!sink_ops(sink)->alloc_buffer)
>> -		goto err;
>> -
>> +	/* If we don't have any CPUs ready for tracing, abort */
>>   	cpu = cpumask_first(mask);
>> -	/* Get the AUX specific data from the sink buffer */
>> +	if (cpu >= nr_cpu_ids)
>> +		goto err;
>> +
>> +	/* Allocate the sink buffer for this session */
>>   	event_data->snk_config =
>>   			sink_ops(sink)->alloc_buffer(sink, cpu, pages,
>>   						     nr_pages, overwrite);

Suzuki


