Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26846ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC84C20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC84C20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeGTJaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:30:22 -0400
Received: from foss.arm.com ([217.140.101.70]:59524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbeGTJaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:30:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3626480D;
        Fri, 20 Jul 2018 01:43:09 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 268D73F5B3;
        Fri, 20 Jul 2018 01:43:08 -0700 (PDT)
Subject: Re: [PATCH v2 08/10] coresight: perf: Add helper to retrieve sink
 configuration
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@linaro.org,
        coresight@lists.linaro.org
References: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
 <1531847501-22226-9-git-send-email-suzuki.poulose@arm.com>
 <20180719200739.GB9421@xps15>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <ed621d62-a1d2-abe1-3763-60ea6e5f615f@arm.com>
Date:   Fri, 20 Jul 2018 09:43:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719200739.GB9421@xps15>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/18 21:07, Mathieu Poirier wrote:
> On Tue, Jul 17, 2018 at 06:11:39PM +0100, Suzuki K Poulose wrote:
>> We can always find the sink configuration for a given perf_output_handle.
>> Add a helper to retrieve the sink configuration for a given
>> perf_output_handle. This will be used to get rid of the set_buffer()
>> call back.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm-perf.c | 14 -------------
>>   drivers/hwtracing/coresight/coresight-etm-perf.h | 26 ++++++++++++++++++++++++
>>   2 files changed, 26 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index 6a4252b..3cc4a0b 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -23,20 +23,6 @@
>>   static struct pmu etm_pmu;
>>   static bool etm_perf_up;
>>   
>> -/**
>> - * struct etm_event_data - Coresight specifics associated to an event
>> - * @work:		Handle to free allocated memory outside IRQ context.
>> - * @mask:		Hold the CPU(s) this event was set for.
>> - * @snk_config:		The sink configuration.
>> - * @path:		An array of path, each slot for one CPU.
>> - */
>> -struct etm_event_data {
>> -	struct work_struct work;
>> -	cpumask_t mask;
>> -	void *snk_config;
>> -	struct list_head * __percpu *path;
>> -};
>> -
> 
> If this is moved to coresight-etm-perf.h, the #include <linux/percpu-defs.h> can
> be removed.

Actually, we do have the PER_CPU variables in the file already, which is why I left
them there.  See the next line.
> 
>>   static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
>>   static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
>>   


>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
>> index 4197df4..da7d933 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
>> @@ -7,6 +7,7 @@
>>   #ifndef _CORESIGHT_ETM_PERF_H
>>   #define _CORESIGHT_ETM_PERF_H
>>   
>> +#include <linux/percpu-defs.h>
>>   #include "coresight-priv.h"
>>   
>>   struct coresight_device;
>> @@ -42,14 +43,39 @@ struct etm_filters {
>>   	bool			ssstatus;
>>   };
>>   
>> +/**
>> + * struct etm_event_data - Coresight specifics associated to an event
>> + * @work:		Handle to free allocated memory outside IRQ context.
>> + * @mask:		Hold the CPU(s) this event was set for.
>> + * @snk_config:		The sink configuration.
>> + * @path:		An array of path, each slot for one CPU.
>> + */
>> +struct etm_event_data {
>> +	struct work_struct work;
>> +	cpumask_t mask;
>> +	void *snk_config;
>> +	struct list_head * __percpu *path;
>> +};
>>   
>>   #ifdef CONFIG_CORESIGHT
>>   int etm_perf_symlink(struct coresight_device *csdev, bool link);
>> +static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
>> +{
>> +	struct etm_event_data *data = perf_get_aux(handle);
>>   
>> +	if (data)
>> +		return data->snk_config;
>> +	return NULL;
>> +}
>>   #else
>>   static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
>>   { return -EINVAL; }
>>   
>> +static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
>> +{
>> +	return NULL;
>> +}
>> +
> 
> I think we can do without those... See my comment in the next patch.

Sure
