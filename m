Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeEEJ4F (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:56:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33866 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeEEJ4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:56:03 -0400
Subject: Re: [PATCH v2 03/27] coresight: Add helper device type
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-4-git-send-email-suzuki.poulose@arm.com>
 <20180503170040.GA11425@xps15>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <86778b1b-cd08-629a-b56c-20549d9d7299@arm.com>
Date: Sat, 5 May 2018 10:56:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503170040.GA11425@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 06:00 PM, Mathieu Poirier wrote:

...

>> +/*
>> + * coresight_release_device - Release this device and any of the helper
>> + * devices connected to it for trace operation.
>> + */
>> +static void coresight_release_device(struct coresight_device *csdev)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < csdev->nr_outport; i++) {
>> +		struct coresight_device *child = csdev->conns[i].child_dev;
>> +
>> +		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
>> +			pm_runtime_put(child->dev.parent);
>> +	}
> 
> There is a newline here in coresight_prepare_device().  Either add one (or not)
> in both function but please be consistent.
> 

>> @@ -480,8 +517,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
>>   
>>   	node->csdev = csdev;
>>   	list_add(&node->link, path);
>> -	pm_runtime_get_sync(csdev->dev.parent);
>> -
>> +	coresight_prepare_device(csdev);
> 
> There was a newline between pm_runtime_get_sync() and the return statement in
> the original code.
> 


>> @@ -775,6 +811,10 @@ static struct device_type coresight_dev_type[] = {
>>   		.name = "source",
>>   		.groups = coresight_source_groups,
>>   	},
>> +	{
>> +		.name = "helper",
>> +	},
>> +
> 
> Extra newline.
> 

>>   };   
>> +/**
>> + * struct coresight_ops_helper - Operations for a helper device.
>> + *
>> + * All operations could pass in a device specific data, which could
>> + * help the helper device to determine what to do.
>> + *
>> + * @enable	: Turn the device ON.
>> + * @disable	: Turn the device OFF.
> 
> There is a discrepancy between the comment and the operations, i.e enabling a
> device is not synonymous of turning it on.  Looking at patch 04/27 the ops is
> called in tmc_etr_enable/disable_catu() so the comment propably needs to be
> changed.

Sure, will fix all of them.

Cheers
Suzuki
