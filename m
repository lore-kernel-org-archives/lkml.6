Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3672BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAF121479
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAF121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeLJK0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:26:48 -0500
Received: from foss.arm.com ([217.140.101.70]:50564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbeLJK0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:26:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D91F15AB;
        Mon, 10 Dec 2018 02:26:45 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 356EA3F6A8;
        Mon, 10 Dec 2018 02:26:44 -0800 (PST)
Subject: Re: [PATCH v9 1/8] KVM: arm/arm64: Share common code in
 user_mem_abort()
To:     Christoffer Dall <christoffer.dall@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        punitagrawal@gmail.com, linux-arm-kernel@lists.infradead.org
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-2-punit.agrawal@arm.com>
 <ad4b316a-054f-24d9-d32d-8fbe7972b5ad@arm.com>
 <8fd34e5f-7d75-4de2-3fee-d6d70805685c@arm.com>
 <20181210085616.GB30263@e113682-lin.lund.arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <525e88a4-b3af-3d7c-ac08-5461b8aa9e51@arm.com>
Date:   Mon, 10 Dec 2018 10:26:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210085616.GB30263@e113682-lin.lund.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2018 08:56, Christoffer Dall wrote:
> On Mon, Dec 03, 2018 at 01:37:37PM +0000, Suzuki K Poulose wrote:
>> Hi Anshuman,
>>
>> On 03/12/2018 12:11, Anshuman Khandual wrote:
>>>
>>>
>>> On 10/31/2018 11:27 PM, Punit Agrawal wrote:
>>>> The code for operations such as marking the pfn as dirty, and
>>>> dcache/icache maintenance during stage 2 fault handling is duplicated
>>>> between normal pages and PMD hugepages.
>>>>
>>>> Instead of creating another copy of the operations when we introduce
>>>> PUD hugepages, let's share them across the different pagesizes.
>>>>
>>>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>>>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>   virt/kvm/arm/mmu.c | 49 ++++++++++++++++++++++++++++------------------
>>>>   1 file changed, 30 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>>>> index 5eca48bdb1a6..59595207c5e1 100644
>>>> --- a/virt/kvm/arm/mmu.c
>>>> +++ b/virt/kvm/arm/mmu.c
>>>> @@ -1475,7 +1475,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>>   			  unsigned long fault_status)
>>>>   {
>>>>   	int ret;
>>>> -	bool write_fault, exec_fault, writable, hugetlb = false, force_pte = false;
>>>> +	bool write_fault, exec_fault, writable, force_pte = false;
>>>>   	unsigned long mmu_seq;
>>>>   	gfn_t gfn = fault_ipa >> PAGE_SHIFT;
>>>>   	struct kvm *kvm = vcpu->kvm;
>>>> @@ -1484,7 +1484,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>>   	kvm_pfn_t pfn;
>>>>   	pgprot_t mem_type = PAGE_S2;
>>>>   	bool logging_active = memslot_is_logging(memslot);
>>>> -	unsigned long flags = 0;
>>>> +	unsigned long vma_pagesize, flags = 0;
>>>
>>> A small nit s/vma_pagesize/pagesize. Why call it VMA ? Its implicit.
>>
>> May be we could call it mapsize. pagesize is confusing.
>>
> 
> I'm ok with mapsize.  I see the vma_pagesize name coming from the fact
> that this is initially set to the return value from vma_kernel_pagesize.
> 
> I have not problems with either vma_pagesize or mapsize.

Ok, I will retain the vma_pagesize to avoid unnecessary changes to the patch.

Thanks
Suzuki
