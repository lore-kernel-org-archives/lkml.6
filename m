Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AIpwx48INp3JHG/9MncK3W0R0LPNACgd9LyQpYnhoacoVOVfVixSMaT6hhTUnMoVuVUma/3RSTfA
ARC-Seal: i=1; a=rsa-sha256; t=1523275836; cv=none;
        d=google.com; s=arc-20160816;
        b=xS2fQ8SQxoZIiUMxPV2KQrN9Kj/A18G5f7b14rTYK2K8JvZx754B3C0rhA6hBfFQ5h
         0gMrn0RSHDIsCf6BuxRnA127i07+Y24WE+rkgCiAFVcIrW526kkLaqI2B4HJ+abGiGoM
         sNoS33n0WQCCHFegZumyuIf2tFxY2xTtDkGlacoeLXzkL5cmFyukdkgZAoO60iHb8jce
         V9zn4xlfMNAAXaau1KiLSRqXRfMQg2kQFp+qRnCHiS4lAMH7/SJtvahKw/PkK009NwUV
         F6mR1zFDrYR2aW23Fg/I+fn8IiErHo3YU41u+TXl8X5a0moZhE8q4T4SSR2wmbDhXruy
         EtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Q1xujVIDNvsLz+1ny7Onm/7i2+/C4EWiu47K87U8J58=;
        b=zzaIDSP6C/nTSEeJSykG0dHrF7ZbAM6UN/YOtnd6+M7Q4ovDrK08GiH8+ytRqeUU4w
         JrHMT1mpmVE3WND4yuJSbFVSo6RUefiy6GZZiZMF18xQ3Ot3FPyxCK0DaicGaf/8XgSY
         ayxNCIPbQrjlI/ARevyNFuYuCDg163i0bmalkfbHdUVGM2C6ru4tHYk64f5yaPDAIs5R
         FGAMEm9TeAFKSDhnk3RX2Kl4k1LhoVdCFVMn4WcdxJbAtKgfc1xi7KgHyD8B52kddNwx
         W3BC+gkHVAw9DifUT5KGCG5sSyspkWhC/TTV1JwR2qKHQpJkCCJCjZ8DXxosJBtF6Ftn
         4ssQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [RFC PATCH 2/2] ACPI/IORT: use swiotlb_dma_ops when smmu probe
 failed
To: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "Zheng, Joey" <yu.zheng@hxt-semitech.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <63635b42529a48d39f36112a031e3655@HXTBJIDCEMVIW02.hxtcorp.net>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3fca23a7-8fe9-6832-9267-ebab73d48f68@arm.com>
Date: Mon, 9 Apr 2018 13:10:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <63635b42529a48d39f36112a031e3655@HXTBJIDCEMVIW02.hxtcorp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596265798784882877?=
X-GMAIL-MSGID: =?utf-8?q?1597270483884046809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 08/04/18 09:10, Wang, Dongsheng wrote:
> 
>> -----Original Message-----
>> From: Robin Murphy [mailto:robin.murphy@arm.com]
>> Sent: Thursday, April 05, 2018 2:57 AM
>> To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Wang, Dongsheng
>> <dongsheng.wang@hxt-semitech.com>
>> Cc: rjw@rjwysocki.net; gregkh@linuxfoundation.org; hanjun.guo@linaro.org;
>> sudeep.holla@arm.com; Zheng, Joey <yu.zheng@hxt-semitech.com>;
>> linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [此邮件可能存在风险] Re: [RFC PATCH 2/2] ACPI/IORT: use
>> swiotlb_dma_ops when smmu probe failed
>>
>> On 04/04/18 17:01, Lorenzo Pieralisi wrote:
>>> [+cc Robin]
>>>
>>> On Thu, Mar 29, 2018 at 03:01:00AM -0700, Wang Dongsheng wrote:
>>>> If SMMU probe failed, master should use swiotlb as dma ops.
>>>> SMMU may probe failed with specified environment, so there
>>>> are not any iommu resources in iommu_device_list.
>>>>
>>>> The master will always get EPROBE_DEFER from really_probe
>>>> (dma_configure) but in fact SMMU has probe failed. The issue
>>>> causes all of masters failed to be driven.
>>
>> Let's just take a step back - why is SMMU probe failing? That seems to
>> be the primary issue here, because it implies that either your hardware,
>> firmware or kernel is broken, any of which would make boot failure
>> somewhat unsurprising anyway.
>>
> It's actually not a hardware issue. This is my test case, just return
> -EINVAL in arm_smmu_device_probe. The HW probe(arm_smmu_device_hw_probe)
> is just part of SMMU driver probe and the failure may be caused by SW. So
> I design this case, just make sure even if SMMU probe failed that cause by SW,
> the MASTER also can work. _Because of our SMMU default mode is bypass._

I don't think it's particularly justifiable to make core API changes for 
the sake of contrived testcases. On real systems, the SMMU is a 
fundamental system component which is no more expected to fail probe 
than, say, the GIC, and as such if it *does* fail then further progress 
is on a best-effort basis at most. Just because *your* system happens to 
work fine in this state doesn't make it true for every SMMU 
implementation and integration that Linux may ever run on.

If you want the kernel to ignore an SMMU, either configure out the 
driver, or don't describe that SMMU in firmware in the first place.

>>> I added Robin to pick his brain. An alternative would consist
>>> in using a bus notifier to prevent deferred probing once the SMMU
>>> driver probing failed but that seems backwards given that a major
>>> reason to move to deferred probing was to remove the bus notifiers
>>> dependency in the first place.
>>>
>>> It seems to me this is both an OF/ACPI issue - it is not an IORT
>>> only problem.
>>
>> Yes, this is just an instance of the general probe-deferral problem,
>> e.g. once you have multiple dependencies it's possible to end up in a
>> stalemate where everything including the IOMMU ends up on the deferred
>> probe list with nothing to kick it and make progress again.
>>
>> Furthermore it seems to me that the whole premise in this patch is
>> flawed,
> Ditto. :)
> 
> 
>> since even genuine probe failure may well be transient - just
>> because one attempt failed doesn't mean a later attempt can't succeed.
>> Thus "the most recent probe attempt failed" cannot be considered a
>> fundamentally different state from "no driver is currently bound".
>>
> Agree, the genuine probe failure may well be transient. But there is
> depend on SMMU probe(IOMMU instance) status. There are two situations:
> 
> 1. MASTER probing, SMMU doesn't probe yet.
> 	This case will match "the transient failure".
> 	really_probe get an EPROBE_DEFER from IORT and the MASTER probe will be
> 	delayed until SMMU probe successful.
> 2. MASTER probing, SMMU probe has failed.
> 	really_probe will always get an EPROBE_DEFER from IORT, because kernel
> 	has build in SMMU driver.(iort_iommu_driver_enabled) And the master
> 	never cannot do probe.
> 
> The case 2 is I want to handle.

Handle it by not deliberately breaking the SMMU driver. In all other 
cases, either re-triggering SMMU probe might make it succeed (i.e. the 
DL_DEV_PROBE_FAILED state is meaningless), or things are so broken that 
you're probably dead in the water anyway.

Robin.

> 
> Cheers,
> -Dongsheng
> 
>> Robin.
>>
>>>
>>> Lorenzo
>>>
>>>> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
>>>> ---
>>>>    drivers/acpi/arm64/iort.c | 39
>> +++++++++++++++++++++++++++++++++------
>>>>    1 file changed, 33 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>>> index e2f7bdd..a6f4c27 100644
>>>> --- a/drivers/acpi/arm64/iort.c
>>>> +++ b/drivers/acpi/arm64/iort.c
>>>> @@ -774,17 +774,45 @@ static int arm_smmu_iort_xlate(struct device
>> *dev, u32 streamid,
>>>>    	return ret;
>>>>    }
>>>>
>>>> -static inline bool iort_iommu_driver_enabled(u8 type)
>>>> +static int iort_check_dev_dl_status(struct device *dev, void *data)
>>>>    {
>>>> +	struct fwnode_handle *fwnode = data;
>>>> +
>>>> +	if (dev->fwnode != fwnode)
>>>> +		return 0;
>>>> +
>>>> +	if (dev->links.status == DL_DEV_PROBE_FAILED)
>>>> +		return -ENODEV;
>>>> +
>>>> +	return -EPROBE_DEFER;
>>>> +}
>>>> +
>>>> +static int iort_iommu_driver_enabled(u8 type, struct fwnode_handle
>> *fwnode)
>>>> +{
>>>> +	bool buildin;
>>>> +	int ret;
>>>> +
>>>>    	switch (type) {
>>>>    	case ACPI_IORT_NODE_SMMU_V3:
>>>> -		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
>>>> +		buildin = IS_BUILTIN(CONFIG_ARM_SMMU_V3);
>>>> +		break;
>>>>    	case ACPI_IORT_NODE_SMMU:
>>>> -		return IS_BUILTIN(CONFIG_ARM_SMMU);
>>>> +		buildin = IS_BUILTIN(CONFIG_ARM_SMMU);
>>>> +		break;
>>>>    	default:
>>>>    		pr_warn("IORT node type %u does not describe an SMMU\n",
>> type);
>>>> -		return false;
>>>> +		buildin = false;
>>>>    	}
>>>> +
>>>> +	if (!buildin)
>>>> +		return -ENODEV;
>>>> +
>>>> +	ret = bus_for_each_dev(&platform_bus_type, NULL, fwnode,
>>>> +			       iort_check_dev_dl_status);
>>>> +	if (!ret)
>>>> +		return -EPROBE_DEFER;
>>>> +
>>>> +	return ret;
>>>>    }
>>>>
>>>>    #ifdef CONFIG_IOMMU_API
>>>> @@ -919,8 +947,7 @@ static int iort_iommu_xlate(struct device *dev,
>> struct acpi_iort_node *node,
>>>>    	 */
>>>>    	ops = iommu_ops_from_fwnode(iort_fwnode);
>>>>    	if (!ops)
>>>> -		return iort_iommu_driver_enabled(node->type) ?
>>>> -		       -EPROBE_DEFER : -ENODEV;
>>>> +		return iort_iommu_driver_enabled(node->type, iort_fwnode);
>>>>
>>>>    	return arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
>>>>    }
>>>> --
>>>> 2.7.4
>>>>
