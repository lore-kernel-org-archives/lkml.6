Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369CAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930D5214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930D5214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeJJLm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:42:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56401 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbeJJLm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:42:59 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 01944186D29EE;
        Wed, 10 Oct 2018 12:22:43 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Wed, 10 Oct 2018
 12:22:42 +0800
Subject: Re: [PATCH v2 2/2] arm/arm64: KVM: enable 32 bits kvm vcpu events
 support
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <christoffer.dall@arm.com>, <marc.zyngier@arm.com>,
        <peter.maydell@linaro.org>, <drjones@redhat.com>,
        <james.morse@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>
References: <1539002088-21215-1-git-send-email-gengdongjiu@huawei.com>
 <1539002088-21215-3-git-send-email-gengdongjiu@huawei.com>
 <3e6a7a5f-3ff9-b7db-b1f6-87a8fdf5c20c@arm.com>
From:   gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <f733b63b-b949-9082-3b23-aba47774d734@huawei.com>
Date:   Wed, 10 Oct 2018 12:22:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3e6a7a5f-3ff9-b7db-b1f6-87a8fdf5c20c@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki

On 2018/10/10 1:22, Suzuki K Poulose wrote:
> 
> 
> On 08/10/18 13:34, Dongjiu Geng wrote:
>> The commit 539aee0edb9f ("KVM: arm64: Share the parts of
>> get/set events useful to 32bit") shares the get/set events
>> helper for arm64 and arm32, it is better also share the check
>> for vcpu events capability to enable 32 bit kvm vcpu events
>> support.
>>
>> User space will check whether KVM supports vcpu events through
>> KVM_CAP_VCPU_EVENTS IOCTL.
> 
> nit: User space will check whether KVM supports vcpu events by checking
> the KVM_CAP_VCPU_EVENTS extension.

  Thanks for the pointing out, I will update it.

> 
>>
>> Cc: James Morse <james.morse@arm.com>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> 
> Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>
> 
>> ---
>> For the 32 bits kvm migration, it needs to enable the vcpu events,
>> this patch will enable it. The user space QEMU patch is here:
>> https://patchwork.ozlabs.org/patch/975615/
>> ---
>>   arch/arm64/kvm/reset.c | 1 -
>>   virt/kvm/arm/arm.c     | 1 +
>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index fd37c53..e50245e 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -82,7 +82,6 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>           break;
>>       case KVM_CAP_SET_GUEST_DEBUG:
>>       case KVM_CAP_VCPU_ATTRIBUTES:
>> -    case KVM_CAP_VCPU_EVENTS:
>>           r = 1;
>>           break;
>>       default:
>> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
>> index 40e79ea..64e5d97 100644
>> --- a/virt/kvm/arm/arm.c
>> +++ b/virt/kvm/arm/arm.c
>> @@ -212,6 +212,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>       case KVM_CAP_READONLY_MEM:
>>       case KVM_CAP_MP_STATE:
>>       case KVM_CAP_IMMEDIATE_EXIT:
>> +    case KVM_CAP_VCPU_EVENTS:
>>           r = 1;
>>           break;
>>       case KVM_CAP_ARM_SET_DEVICE_ADDR:
>>
> 
> .
> 

