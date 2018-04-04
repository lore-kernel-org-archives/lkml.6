Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AIpwx49tf5F2URpzhaE5tniTw/F762KwHgI8xVmN06vW8QqRdwYI+3LgpCmDrRQCJMGrDAwpmdiH
ARC-Seal: i=1; a=rsa-sha256; t=1522868249; cv=none;
        d=google.com; s=arc-20160816;
        b=BrkM0hINGtlnAEInVnx3HOHhaynzzYpTupQuagvNK5XTgSy1s+BH2aSbpbbehZYkK5
         LNratixNxnrFhtcp4yRnoJ2+Cu3fkN0VLr/LdUhaoJgniTLayPLo4PZFM0JGMyIBVEho
         GOtm2gC9IA1eCysn1zaCPYasqSkM6H7sVAwiSAtKxw62MhW4mMzoAV2hpW/CuG2hm+3s
         nXr+wzyOAc3DkxkaAzzRpJs0mGD/RWjHJ6+cSnh8p9rfRrh/AjUwbJ/SAjLsDr9Hfdo1
         WFi5Bk7+q/35Xx/G/aMd8TlP7G1/5XMQ2x9EZUn7yl0xG8tHddhwEccmyGXd1lpCSXcQ
         nYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=gd2+ehufWzbYrkXZCfycSmyWU2pVwMJ6s07z1v0Ndxg=;
        b=0KYFvy1w0LPIyTMGaNLa8WdreigNV3LYHdhwPY4KT/mirwRSucY8msNzTqaBToka4k
         4gK58RItRs0WSXEqCJPsR4MGkMeTj0no3rLoHaAnB4pAQLbJPi7DGyelr4yNyhIF/bzp
         df3YUvOlAO7ATQRWQrPCAuoUpSzzchMEb2xWBryQxSGUxBSa57m7nOrexWWJUhlJ82iL
         XXat/JExguzFfezpHvmJCulrJ5JT771/Tw9VavqGHaJIpOav1cv42HgA/Fk5h+l51t6t
         GWtkNv9SfK2z0ak0dy/gcK5+tcqPJliILNd1vv4y/vD+bOdtisPQIcmzuHbBdkClYW8I
         ruZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [RFC PATCH 2/2] ACPI/IORT: use swiotlb_dma_ops when smmu probe
 failed
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Cc: rjw@rjwysocki.net, gregkh@linuxfoundation.org, hanjun.guo@linaro.org,
 sudeep.holla@arm.com, yu.zheng@hxt-semitech.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1522317660-11080-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <1522317660-11080-3-git-send-email-dongsheng.wang@hxt-semitech.com>
 <20180404160138.GA9317@e107981-ln.cambridge.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a3f1186f-15f5-188b-c62f-439ab34c2b64@arm.com>
Date: Wed, 4 Apr 2018 19:57:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180404160138.GA9317@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596265798784882877?=
X-GMAIL-MSGID: =?utf-8?q?1596843098198171392?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/04/18 17:01, Lorenzo Pieralisi wrote:
> [+cc Robin]
> 
> On Thu, Mar 29, 2018 at 03:01:00AM -0700, Wang Dongsheng wrote:
>> If SMMU probe failed, master should use swiotlb as dma ops.
>> SMMU may probe failed with specified environment, so there
>> are not any iommu resources in iommu_device_list.
>>
>> The master will always get EPROBE_DEFER from really_probe
>> (dma_configure) but in fact SMMU has probe failed. The issue
>> causes all of masters failed to be driven.

Let's just take a step back - why is SMMU probe failing? That seems to 
be the primary issue here, because it implies that either your hardware, 
firmware or kernel is broken, any of which would make boot failure 
somewhat unsurprising anyway.

> I added Robin to pick his brain. An alternative would consist
> in using a bus notifier to prevent deferred probing once the SMMU
> driver probing failed but that seems backwards given that a major
> reason to move to deferred probing was to remove the bus notifiers
> dependency in the first place.
> 
> It seems to me this is both an OF/ACPI issue - it is not an IORT
> only problem.

Yes, this is just an instance of the general probe-deferral problem, 
e.g. once you have multiple dependencies it's possible to end up in a 
stalemate where everything including the IOMMU ends up on the deferred 
probe list with nothing to kick it and make progress again.

Furthermore it seems to me that the whole premise in this patch is 
flawed, since even genuine probe failure may well be transient - just 
because one attempt failed doesn't mean a later attempt can't succeed. 
Thus "the most recent probe attempt failed" cannot be considered a 
fundamentally different state from "no driver is currently bound".

Robin.

> 
> Lorenzo
> 
>> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
>> ---
>>   drivers/acpi/arm64/iort.c | 39 +++++++++++++++++++++++++++++++++------
>>   1 file changed, 33 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index e2f7bdd..a6f4c27 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -774,17 +774,45 @@ static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
>>   	return ret;
>>   }
>>   
>> -static inline bool iort_iommu_driver_enabled(u8 type)
>> +static int iort_check_dev_dl_status(struct device *dev, void *data)
>>   {
>> +	struct fwnode_handle *fwnode = data;
>> +
>> +	if (dev->fwnode != fwnode)
>> +		return 0;
>> +
>> +	if (dev->links.status == DL_DEV_PROBE_FAILED)
>> +		return -ENODEV;
>> +
>> +	return -EPROBE_DEFER;
>> +}
>> +
>> +static int iort_iommu_driver_enabled(u8 type, struct fwnode_handle *fwnode)
>> +{
>> +	bool buildin;
>> +	int ret;
>> +
>>   	switch (type) {
>>   	case ACPI_IORT_NODE_SMMU_V3:
>> -		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
>> +		buildin = IS_BUILTIN(CONFIG_ARM_SMMU_V3);
>> +		break;
>>   	case ACPI_IORT_NODE_SMMU:
>> -		return IS_BUILTIN(CONFIG_ARM_SMMU);
>> +		buildin = IS_BUILTIN(CONFIG_ARM_SMMU);
>> +		break;
>>   	default:
>>   		pr_warn("IORT node type %u does not describe an SMMU\n", type);
>> -		return false;
>> +		buildin = false;
>>   	}
>> +
>> +	if (!buildin)
>> +		return -ENODEV;
>> +
>> +	ret = bus_for_each_dev(&platform_bus_type, NULL, fwnode,
>> +			       iort_check_dev_dl_status);
>> +	if (!ret)
>> +		return -EPROBE_DEFER;
>> +
>> +	return ret;
>>   }
>>   
>>   #ifdef CONFIG_IOMMU_API
>> @@ -919,8 +947,7 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
>>   	 */
>>   	ops = iommu_ops_from_fwnode(iort_fwnode);
>>   	if (!ops)
>> -		return iort_iommu_driver_enabled(node->type) ?
>> -		       -EPROBE_DEFER : -ENODEV;
>> +		return iort_iommu_driver_enabled(node->type, iort_fwnode);
>>   
>>   	return arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
>>   }
>> -- 
>> 2.7.4
>>
