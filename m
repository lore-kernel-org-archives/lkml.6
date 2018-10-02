Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B99C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855D320878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855D320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeJBPe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:34:56 -0400
Received: from foss.arm.com ([217.140.101.70]:60928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbeJBPe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:34:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3765F18A;
        Tue,  2 Oct 2018 01:52:45 -0700 (PDT)
Received: from localhost (e105922-lin.Emea.Arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDDE93F5B3;
        Tue,  2 Oct 2018 01:52:44 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     <kvmarm@lists.cs.columbia.edu>, <marc.zyngier@arm.com>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v8 9/9] KVM: arm64: Add support for creating PUD hugepages at stage 2
References: <20181001155443.23032-1-punit.agrawal@arm.com>
        <20181001155443.23032-10-punit.agrawal@arm.com>
        <3bd022cd-e470-479a-d7a5-680810db6a42@arm.com>
Date:   Tue, 02 Oct 2018 09:52:43 +0100
In-Reply-To: <3bd022cd-e470-479a-d7a5-680810db6a42@arm.com> (Suzuki
        K. Poulose's message of "Mon, 1 Oct 2018 22:30:00 +0100")
Message-ID: <87y3bgk9wk.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

> On 10/01/2018 04:54 PM, Punit Agrawal wrote:
>> KVM only supports PMD hugepages at stage 2. Now that the various page
>> handling routines are updated, extend the stage 2 fault handling to
>> map in PUD hugepages.
>>
>> Addition of PUD hugepage support enables additional page sizes (e.g.,
>> 1G with 4K granule) which can be useful on cores that support mapping
>> larger block sizes in the TLB entries.
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>   arch/arm/include/asm/kvm_mmu.h         |  20 +++++
>>   arch/arm/include/asm/stage2_pgtable.h  |   9 +++
>>   arch/arm64/include/asm/kvm_mmu.h       |  16 ++++
>>   arch/arm64/include/asm/pgtable-hwdef.h |   2 +
>>   arch/arm64/include/asm/pgtable.h       |   2 +
>>   virt/kvm/arm/mmu.c                     | 106 +++++++++++++++++++++++--
>>   6 files changed, 149 insertions(+), 6 deletions(-)
>>
>
> ...
>
>> diff --git a/arch/arm/include/asm/stage2_pgtable.h b/arch/arm/include/asm/stage2_pgtable.h
>> index f6a7ea805232..a4ec25360e50 100644
>> --- a/arch/arm/include/asm/stage2_pgtable.h
>> +++ b/arch/arm/include/asm/stage2_pgtable.h
>> @@ -68,4 +68,13 @@ stage2_pmd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>>   #define stage2_pmd_table_empty(kvm, pmdp)	kvm_page_empty(pmdp)
>>   #define stage2_pud_table_empty(kvm, pudp)	false
>>   +static inline bool kvm_stage2_has_pud(struct kvm *kvm)
>> +{
>> +#if CONFIG_PGTABLE_LEVELS > 3
>> +	return true;
>> +#else
>> +	return false;
>> +#endif
>
> nit: We can only have PGTABLE_LEVELS=3 on ARM with LPAE.
> AFAIT, this can be set to false always for ARM.

I debated this and veered towards being generic but not committed either
ways.

I've updated this locally but will wait for further comments before
re-posting.

>
>> +}
>> +
>
> ...
>
>> @@ -1669,7 +1752,18 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	needs_exec = exec_fault ||
>>   		(fault_status == FSC_PERM && stage2_is_exec(kvm, fault_ipa));
>>   -	if (hugetlb && vma_pagesize == PMD_SIZE) {
>> +	if (hugetlb && vma_pagesize == PUD_SIZE) {
>> +		pud_t new_pud = kvm_pfn_pud(pfn, mem_type);
>> +
>> +		new_pud = kvm_pud_mkhuge(new_pud);
>> +		if (writable)
>> +			new_pud = kvm_s2pud_mkwrite(new_pud);
>> +
>> +		if (needs_exec)
>> +			new_pud = kvm_s2pud_mkexec(new_pud);
>> +
>> +		ret = stage2_set_pud_huge(kvm, memcache, fault_ipa, &new_pud);
>> +	} else if (hugetlb && vma_pagesize == PMD_SIZE) {
>>   		pmd_t new_pmd = kvm_pfn_pmd(pfn, mem_type);
>>     		new_pmd = kvm_pmd_mkhuge(new_pmd);
>>
>
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks a lot for going through the series.
