Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063B4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE56A20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE56A20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeIYQaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:30:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48478 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbeIYQaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:30:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B122D80D;
        Tue, 25 Sep 2018 03:23:16 -0700 (PDT)
Received: from [192.168.0.21] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EB313F5B7;
        Tue, 25 Sep 2018 03:23:13 -0700 (PDT)
Subject: Re: [PATCH v5 18/18] kvm: arm64: Allow tuning the physical address
 size for VM
To:     Auger Eric <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, will.deacon@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com, dave.martin@arm.com, julien.grall@arm.com,
        linux-kernel@vger.kernel.org,
        Peter Maydel <peter.maydell@linaro.org>
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-19-suzuki.poulose@arm.com>
 <552680a6-23e6-001c-416e-214d1e8276c6@redhat.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <75c3abc2-6518-9a4b-ea1e-01619489d535@arm.com>
Date:   Tue, 25 Sep 2018 11:24:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <552680a6-23e6-001c-416e-214d1e8276c6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 11:00 AM, Auger Eric wrote:
> Hi Suzuki,
> On 9/17/18 12:41 PM, Suzuki K Poulose wrote:
>> Allow specifying the physical address size limit for a new
>> VM via the kvm_type argument for the KVM_CREATE_VM ioctl. This
>> allows us to finalise the stage2 page table as early as possible
>> and hence perform the right checks on the memory slots
>> without complication. The size is ecnoded as Log2(PA_Size) in
> encoded

...

>>
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index c664064f76fb..f860251ff27c 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -122,6 +122,14 @@ the default trap & emulate implementation (which changes the virtual
>>   memory layout to fit in user mode), check KVM_CAP_MIPS_VZ and use the
>>   flag KVM_VM_MIPS_VZ.
>>   
>> +To configure the physical address space size for a VM (IPA size) on arm64,
>> +check KVM_CAP_ARM_VM_PHYS_SHIFT (which returns the maximum limit for the
>> +IPA shift) and use KVM_VM_TYPE_ARM_PHYS_SHIFT(PHYS_SHIFT). Bits[7-0] of the
>> +machine type has been reserved for specifying the PHYS_SHIFT.
> are reserved to pass the PHYS_SHIFT?
>> +The supported range is [32...IPA_LIMIT], where IPA_LIMIT could be
> s/could be/is



>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 07548de5c988..2a6b29c446db 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -750,6 +750,15 @@ struct kvm_ppc_resize_hpt {
>>   
>>   #define KVM_S390_SIE_PAGE_OFFSET 1
>>   
>> +/*
>> + * On arm64, machine type can be used to request the physical
>> + * address size for the VM. Bits[7-0] has been reserved for the PA
> s/has been reserved/are?

Thanks for spotting, fixed all the above.

Suzuki
