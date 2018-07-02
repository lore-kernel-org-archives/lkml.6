Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A930C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B6425E30
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B6425E30
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeGBNxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:53:12 -0400
Received: from foss.arm.com ([217.140.101.70]:32848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbeGBNxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:53:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6299880D;
        Mon,  2 Jul 2018 06:53:10 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F4E73F2EA;
        Mon,  2 Jul 2018 06:53:08 -0700 (PDT)
Subject: Re: [PATCH v3 16/20] kvm: arm64: Switch to per VM IPA limit
To:     Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-17-git-send-email-suzuki.poulose@arm.com>
 <98b1fa06-d026-52b2-09de-87ec1dfdbfb2@arm.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <bab97403-bc60-d71a-72d6-3ca5c3fe6fd1@arm.com>
Date:   Mon, 2 Jul 2018 14:53:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <98b1fa06-d026-52b2-09de-87ec1dfdbfb2@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

On 02/07/18 14:32, Marc Zyngier wrote:
> On 29/06/18 12:15, Suzuki K Poulose wrote:
>> Now that we can manage the stage2 page table per VM, switch the
>> configuration details to per VM instance. We keep track of the
>> IPA bits, number of page table levels and the VTCR bits (which
>> depends on the IPA and the number of levels). While at it, remove
>> unused pgd_lock field from kvm_arch for arm64.
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>


>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 328f472..9a15860 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -61,13 +61,23 @@ struct kvm_arch {
>>   	u64    vmid_gen;
>>   	u32    vmid;
>>   
>> -	/* 1-level 2nd stage table and lock */
>> -	spinlock_t pgd_lock;
>> +	/* stage-2 page table */
>>   	pgd_t *pgd;
>>   
>>   	/* VTTBR value associated with above pgd and vmid */
>>   	u64    vttbr;
>>   
>> +	/* Private bits of VTCR_EL2 for this VM */
>> +	u64    vtcr_private;
> 
> As I said in another email, this should become a full VTCR_EL2 copy.
> 

OK

>> +	/* Size of the PA size for this guest */
>> +	u8     phys_shift;
>> +	/*
>> +	 * Number of levels in page table. We could always calculate
>> +	 * it from phys_shift above. We cache it for faster switches
>> +	 * in stage2 page table helpers.
>> +	 */
>> +	u8     s2_levels;
> 
> And these two fields feel like they should be derived from the VTCR
> itself, instead of being there on their own. Any chance you could look
> into this?

Yes, the VTCR is computed from the above two values and we could compute
them back from the VTCR. I will give it a try.

>> diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
>> index ffc37cc..91d7936 100644
>> --- a/arch/arm64/include/asm/stage2_pgtable.h
>> +++ b/arch/arm64/include/asm/stage2_pgtable.h
>> @@ -65,7 +65,6 @@
>>   #define __s2_pgd_ptrs(pa, lvls)	(1 << ((pa) - pt_levels_pgdir_shift((lvls))))
>>   #define __s2_pgd_size(pa, lvls)	(__s2_pgd_ptrs((pa), (lvls)) * sizeof(pgd_t))
>>   
>> -#define kvm_stage2_levels(kvm)		stage2_pt_levels(kvm_phys_shift(kvm))
>>   #define stage2_pgdir_shift(kvm)	\
>>   		pt_levels_pgdir_shift(kvm_stage2_levels(kvm))
>>   #define stage2_pgdir_size(kvm)		(_AC(1, UL) << stage2_pgdir_shift((kvm)))
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index a339e00..d7822e1 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -867,6 +867,10 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
>>   		return -EINVAL;
>>   	}
>>   
>> +	/* Make sure we have the stage2 configured for this VM */
>> +	if (WARN_ON(!kvm_phys_shift(kvm)))
> 
> Can this be triggered from userspace?

No. As we initialise the phys shift before we get here. If type is left
blank (i.e, 0), we default to 40bits. So there should be something there.
The check is to make sure we have indeed past the configuration step.

>> +		return -EINVAL;
>> +
>>   	/* Allocate the HW PGD, making sure that each page gets its own refcount */
>>   	pgd = stage2_alloc_pgd(kvm);
>>   	if (!pgd)
>>
> 

Cheers
Suzuki
