Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7DCC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACA3218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfA3Kjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:39:51 -0500
Received: from foss.arm.com ([217.140.101.70]:52100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfA3Kjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:39:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84113A78;
        Wed, 30 Jan 2019 02:39:50 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5D3A3F59C;
        Wed, 30 Jan 2019 02:39:48 -0800 (PST)
Subject: Re: [PATCH] kvm: arm64: Relax the restriction on using stage2 PUD
 huge mapping
To:     marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, cdall@kernel.org,
        christoffer.dall@arm.com
References: <1548789137-4446-1-git-send-email-suzuki.poulose@arm.com>
 <ddff61a6-bc43-564e-c1ee-ed2c2764fad6@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <64c7a684-3e4b-381e-2223-f3db99963613@arm.com>
Date:   Wed, 30 Jan 2019 10:39:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ddff61a6-bc43-564e-c1ee-ed2c2764fad6@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

On 30/01/2019 10:21, Marc Zyngier wrote:
> On 29/01/2019 19:12, Suzuki K Poulose wrote:
>> We restrict mapping the PUD huge pages in stage2 to only when the
>> stage2 has 4 level page table, leaving the feature unused with
>> the default IPA size. But we could use it even with a 3
>> level page table, i.e, when the PUD level is folded into PGD,
>> just like the stage1. Relax the condition to allow using the
>> PUD huge page mappings at stage2 when it is possible.
>>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   virt/kvm/arm/mmu.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index fbdf3ac..30251e2 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1695,11 +1695,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   
>>   	vma_pagesize = vma_kernel_pagesize(vma);
>>   	/*
>> -	 * PUD level may not exist for a VM but PMD is guaranteed to
>> -	 * exist.
>> +	 * The stage2 has a minimum of 2 level table (For arm64 see
>> +	 * kvm_arm_setup_stage2()). Hence, we are guaranteed that we can
>> +	 * use PMD_SIZE huge mappings (even when the PMD is folded into PGD).
>> +	 * As for PUD huge maps, we must make sure that we have at least
>> +	 * 3 levels, i.e, PMD is not folded.
>>   	 */
>>   	if ((vma_pagesize == PMD_SIZE ||
>> -	     (vma_pagesize == PUD_SIZE && kvm_stage2_has_pud(kvm))) &&
>> +	     (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm))) &&
>>   	    !force_pte) {
>>   		gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
>>   	}
>>
> 
> For the record, it took a 10 minute discussion with Suzuki  to
> understand that the above is actually correct, even if massively
> confusing. Why is it correct:
> 
> - In a 4 level stage-2, each of PGD/PUD/PMD exists on its own, and start
> level is 0
> - In a 3 level stage-2, PGD and PUD are fused as the start level is 1,
> and PMD exists on its own
> - In a 2 level stage-2, both PGD, PUD and PMD are fused, and start level
> is 2.
> 
>  From the above, we can extract that you can always have a block mapping
> at the PUD level if you have a standalone PMD, and that's the logic this
> patch is using.

Thanks for writing it up ! :-)

> 
> Now, the *real* reason is that you can map a given size in your S2PT,
> not that some level is fused or not. What we want is probably a helper
> that says:
> 
> bool kvm_stage2_can_map_block_size(struct kvm *kvm, size_t sz)
> {
> 	return sz >= PMD_SIZE && stage2_pgdir_size(kvm) >= sz);
> }
> 
> and the above becomes:
> 
> if (kvm_stage2_can_map_block_size(kvm, vma_pagesize)) && !force_pte)
> 
> which I find much nicer.
> 
> I guess I can still take the above as a fix if Christoffer is happy with
> it, but if you think my above hack is correct, I'd like things to be
> cleaned-up in the near future.

Sure, as we discussed that makes it much simpler and generic. I could
address that.

Suzuki
