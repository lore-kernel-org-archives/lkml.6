Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06BFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8973B2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8973B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbeKACyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:54:20 -0400
Received: from foss.arm.com ([217.140.101.70]:44704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729745AbeKACyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:54:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B15080D;
        Wed, 31 Oct 2018 10:55:17 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCDC63F6A8;
        Wed, 31 Oct 2018 10:55:14 -0700 (PDT)
Subject: Re: [PATCH v6 18/18] kvm: arm64: Allow tuning the physical address
 size for VM
To:     Christoffer Dall <christoffer.dall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, cdall@kernel.org,
        kvm@vger.kernel.org, marc.zyngier@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, dave.martin@arm.com,
        pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu,
        Punit Agrawal <punit.agrawal@arm.com>
References: <20180926163258.20218-1-suzuki.poulose@arm.com>
 <20180926163258.20218-19-suzuki.poulose@arm.com>
 <20181031142216.GD12057@e113682-lin.lund.arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ebfbc17a-5954-7a67-0ae4-b911ba5f8b9e@arm.com>
Date:   Wed, 31 Oct 2018 17:55:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181031142216.GD12057@e113682-lin.lund.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoffer,

On 31/10/18 14:22, Christoffer Dall wrote:
> On Wed, Sep 26, 2018 at 05:32:54PM +0100, Suzuki K Poulose wrote:
>> Allow specifying the physical address size limit for a new
>> VM via the kvm_type argument for the KVM_CREATE_VM ioctl. This
>> allows us to finalise the stage2 page table as early as possible
>> and hence perform the right checks on the memory slots
>> without complication. The size is encoded as Log2(PA_Size) in
>> bits[7:0] of the type field. For backward compatibility the
>> value 0 is reserved and implies 40bits. Also, lift the limit
>> of the IPA to host limit and allow lower IPA sizes (e.g, 32).
>>
>> The userspace could check the extension KVM_CAP_ARM_VM_IPA_SIZE
>> for the availability of this feature. The cap check returns the
>> maximum limit for the physical address shift supported by the host.
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---

>> @@ -192,17 +195,23 @@ int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
>>   	u32 parange, phys_shift;
>>   	u8 lvls;
>>   
>> -	if (type)
>> +	if (type & ~KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
>>   		return -EINVAL;
>>   
>> +	phys_shift = KVM_VM_TYPE_ARM_IPA_SIZE(type);
>> +	if (phys_shift) {
>> +		if (phys_shift > kvm_ipa_limit ||
>> +		    phys_shift < 32)
>> +			return -EINVAL;
> 
> I am concerned here that if we allow the user to set the phys_size to 32
> bits, then we end up with 2 levels of stage2 page tables, which means
> that the size of a stage2 pmd mapping becomes the size of a stage2 pgd
> mapping, yet we can still decide in user_mem_abort() that a stage2 fault
> is backed by PMD size mappings on the host, and attempt a huge mapping
> at stage2, which then becomes a PGD level block map, I think.

Yes, you're right. We will have a pgd-level block map in that case.
This should work transparently as PMD at stage2 is folded into PGD and
we endup marking the PGD entry as huge and the stage2 accessors deal
with it appropriately. This is similar to having a PMD huge page with
64K + 42bit VA (2 level page table) on stage1.

> 
> Is this handled somehow?  If so, how?

We don't prevent this. We have a guaranteed minimum number of levels
at 2, which implies you can map a stage1 PMD huge page at stage2.
I acknowledge that the Linux naming convention does cause some confusion
for a "level" at stage1 and stage2 levels. But if you think of it
from the hardware level (and like the ARM ARM defines it , Level 0-3),
it is much simpler. i.e, you can map a huge page at level N in stage1
into stage2 if you have that level N. It doesn't matter if stage2 has
more or less number of levels than stage1, as long as stage2 table can
deal with it.

> 
> I can't see user_mem_abort() being modified to explicitly handle this
> in your code, but perhaps the stage2_set_pmd_huge() call ends up
> actually mapping at the stage2 pte level, but I can't tell that it does.

The stage2_set_pmd_huge() installs it at the PGD (level 2, which would
have been PMD if we had levels > 2) slot.

pmd = stage2_get_pmd(addr)
        \-> pud = stage2_get_pud(addr)
              \-> pgd = kvm->arch.pgd + stage2_pgd_index(addr);
              \-> (we have stage2_pgd_none(x) = 0 and
              \-> stage2_pud_offset(pgd, addr) = pgd
              \->returns (kvm->arch.pgd + stage2_pgd_index(addr);
        \->  stage_pud_none(x) = 0 & stage2_pmd_offset(pud, addr) = pud
        \->  returns pud (kvm->arch.pgd + stage2_pgd_index(addr))

and we install the PMD huge mapping at the location.

> In any case, I think user_mem_abort() should give up on pmd/pud huge
> mappings if the size mapped by the stage2/stage1 pmd/pud levels don't
> line up.  What do you think?

Does it matter ? Personally I don't think it matters much as long as we
are able to map the "huge" page at stage1 in the stage2 as huge, even if
the stage2 has lesser levels and manage it well. Given that PMD huge
pages are quite common, it would be good to exploit it when we can.

On the other hand, for stage2 PUD we are checking if the stage2 has a
PUD level (kvm_has_stage2_pud()). May be we should relax it just like
we do for PMD to check (kvm_stage2_levels > 2).


Thanks
Suzuki

> 
> Thanks,
> 
>      Christoffer
> 
>> +	} else {
>> +		phys_shift = KVM_PHYS_SHIFT;
>> +	}
>> +
>>   	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 7;
>>   	if (parange > ID_AA64MMFR0_PARANGE_MAX)
>>   		parange = ID_AA64MMFR0_PARANGE_MAX;
>>   	vtcr |= parange << VTCR_EL2_PS_SHIFT;
>>   
>> -	phys_shift = id_aa64mmfr0_parange_to_phys_shift(parange);
>> -	if (phys_shift > KVM_PHYS_SHIFT)
>> -		phys_shift = KVM_PHYS_SHIFT;
>>   	vtcr |= VTCR_EL2_T0SZ(phys_shift);
>>   	/*
>>   	 * Use a minimum 2 level page table to prevent splitting
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 07548de5c988..9b949efcfd32 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -750,6 +750,15 @@ struct kvm_ppc_resize_hpt {
>>   
>>   #define KVM_S390_SIE_PAGE_OFFSET 1
>>   
>> +/*
>> + * On arm64, machine type can be used to request the physical
>> + * address size for the VM. Bits[7-0] are reserved for the guest
>> + * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
>> + * value 0 implies the default IPA size, 40bits.
>> + */
>> +#define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
>> +#define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
>> +	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
>>   /*
>>    * ioctls for /dev/kvm fds:
>>    */
>> @@ -952,6 +961,7 @@ struct kvm_ppc_resize_hpt {
>>   #define KVM_CAP_S390_HPAGE_1M 156
>>   #define KVM_CAP_NESTED_STATE 157
>>   #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
>> +#define KVM_CAP_ARM_VM_IPA_SIZE 159 /* returns maximum IPA bits for a VM */
>>   
>>   #ifdef KVM_CAP_IRQ_ROUTING
>>   
>> -- 
>> 2.19.0
>>
>> _______________________________________________
>> kvmarm mailing list
>> kvmarm@lists.cs.columbia.edu
>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
