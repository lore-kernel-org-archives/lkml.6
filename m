Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1528C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDD82086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDD82086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbeKOVR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:17:57 -0500
Received: from foss.arm.com ([217.140.101.70]:60240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbeKOVR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:17:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B83C2A78;
        Thu, 15 Nov 2018 03:10:33 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87EF33F718;
        Thu, 15 Nov 2018 03:10:32 -0800 (PST)
Subject: Re: [PATCH] kvm: arm/arm64 : fix vm's hanging at startup time
To:     peng.hao2@zte.com.cn
Cc:     christoffer.dall@arm.com, marc.zyngier@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
References: <201811151822532422079@zte.com.cn>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <8a602e2d-54bb-6c47-fcb0-4a7f750d9fcf@arm.com>
Date:   Thu, 15 Nov 2018 11:10:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <201811151822532422079@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/11/18 10:22, peng.hao2@zte.com.cn wrote:
>> Hi Peng,
>>
>> On 15/11/18 15:14, Peng Hao wrote:
>>> When virtual machine starts, hang up. The kernel version of guest
>>> is 4.16. Host support vgic_v3.
>>
>> I don't understand the issue here. the vgic_irq->group field does not
>> exist in 4.16 (neither in the first nor the last version). Nor does the
>> line you are modifying.
> Guest's kernel version is 4.16 and Host's kernel version is mainline.
> vgic_irq is a structure of Host's kvm.
>>
>> Both exist in mainline, but what you are mentioning shouldn't be an
>> issue in mainline since vgic_irq->group gets initialized in
>> kvm_vgic_vcpu_init for SGIs and PPIs (i.e. intid < 32) which includes
>> your interrupt.
> Initialization sequence of several components is like this;
> 1.       kvm_vgic_vcpu_init ---- here, dist is not initialized at this time.
>                                               and the value of irq->group depends on
>                                                dist->vgic_model. but now dist->vgic_model = 0
>                                                 and irq->group=0.
>   2.      vgic_create         -----  assign to dist->vgic_model.
>   3.     kvm_vgic_dist_init
> 

I see, thanks for explaining.

This means the initialization in kvm_vgic_vcpu_init depends on whether 
userland creates the GIC device first or the vcpus first...

I don't think the issue lies in vgic_v3_populate_lr, but in 
kvm_vgic_vcpu_init which clearly expects dist->vgic_model to be 
initialized in two places. However, the comment at the top of 
vgic-init.c states:

  * CPU Interface: 
 
 

  * 
 
 

  * - kvm_vgic_vcpu_init(): initialization of static data that 
 
 

  *   doesn't depend on any sizing information or emulation type. No 
 
 

  *   allocation is allowed there.

So I don't think we're supposed to check for dist->vgic_model here. 
Those two checks should probably be moved elsewhere (maybe in 
kvm_vgic_vcpu_enable?) once the gic type has been set.

Thanks,

> thanks.
>>
>> Cheers,
>>
>>> It was mainly due to the incorrect vgic_irq's(intid=27) group value
>>> during injection interruption. when kvm_vgic_vcpu_init is called,
>>> dist is not initialized at this time. Unable to get vgic V3 or V2
>>> correctly, so group is not set.
>>> group is setted to 1 when vgic_mmio_write_group is invoked at some
>>> time.
>>> when irq->group=0 (intid=27), No ICH_LR_GROUP flag was set and
>>> interrupt injection failed.
>>>
>>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>>> ---
>>>    virt/kvm/arm/vgic/vgic-v3.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
>>> index 9c0dd23..d101000 100644
>>> --- a/virt/kvm/arm/vgic/vgic-v3.c
>>> +++ b/virt/kvm/arm/vgic/vgic-v3.c
>>> @@ -198,7 +198,7 @@ void vgic_v3_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
>>>        if (vgic_irq_is_mapped_level(irq) && (val & ICH_LR_PENDING_BIT))
>>>            irq->line_level = false;
>>>
>>> -    if (irq->group)
>>> +    if (model == KVM_DEV_TYPE_ARM_VGIC_V3)
>>>            val |= ICH_LR_GROUP;
>>>
>>>        val |= (u64)irq->priority << ICH_LR_PRIORITY_SHIFT;
>>>
>>
>> --
>> Julien Thierry

-- 
Julien Thierry
