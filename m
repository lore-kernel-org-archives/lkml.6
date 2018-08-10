Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF691C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EBC22453
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EBC22453
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeHJVWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 17:22:25 -0400
Received: from foss.arm.com ([217.140.101.70]:40878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbeHJVWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 17:22:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 662E980D;
        Fri, 10 Aug 2018 11:51:19 -0700 (PDT)
Received: from localhost (e105922-lin.Emea.Arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D730D3F90E;
        Fri, 10 Aug 2018 11:51:18 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm/arm64: Skip updating page table entry if no change
References: <20180810111300.17144-1-punit.agrawal@arm.com>
        <86mutup9mu.wl-marc.zyngier@arm.com>
Date:   Fri, 10 Aug 2018 19:51:17 +0100
In-Reply-To: <86mutup9mu.wl-marc.zyngier@arm.com> (Marc Zyngier's message of
        "Fri, 10 Aug 2018 15:40:57 +0100")
Message-ID: <871sb62gyi.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <marc.zyngier@arm.com> writes:

> Hi Punit,
>
> On Fri, 10 Aug 2018 12:13:00 +0100,
> Punit Agrawal <punit.agrawal@arm.com> wrote:
>> 
>> Contention on updating a page table entry by a large number of vcpus
>> can lead to duplicate work when handling stage 2 page faults. As the
>> page table update follows the break-before-make requirement of the
>> architecture, it can lead to repeated refaults due to clearing the
>> entry and flushing the tlbs.
>> 
>> This problem is more likely when -
>> 
>> * there are large number of vcpus
>> * the mapping is large block mapping
>>  
>> such as when using PMD hugepages (512MB) with 64k pages.
>> 
>> Fix this by skipping the page table update if there is no change in
>> the entry being updated.
>> 
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
>
> This definitely deserves a Cc to stable, and a Fixes: tag.

Agreed.

For PMD the issue exists since commit ad361f093c1e ("KVM: ARM: Support
hugetlbfs backed huge pages") when the file lived in arch/arm/kvm. (v3.12+)

For PTE the issue exists since commit d5d8184d35c9 ("KVM: ARM: Memory
virtualization setup"). (v3.8+)

I'll split the fix into two patches and add a cc to stable.

>> --
>> Hi,
>> 
>> This problem was reported by a user when testing PUD hugepages. During
>> VM restore when all threads are running cpu intensive workload, the
>> refauting was causing the VM to not make any forward progress.
>> 
>> This patch fixes the problem for PMD and PTE page fault handling.
>> 
>> Thanks,
>> Punit
>> 
>> Change-Id: I04c9aa8b9fbada47deb1a171c9959f400a0d2a21

Just noticed this. Looks like the commit hook has escaped it's worktree.

>> ---
>>  virt/kvm/arm/mmu.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>> 
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index 1d90d79706bd..a66a5441ca2f 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1027,6 +1027,18 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
>>  	VM_BUG_ON(pmd_present(*pmd) && pmd_pfn(*pmd) != pmd_pfn(*new_pmd));
>>  
>>  	old_pmd = *pmd;
>> +	/*
>> +	 * Multiple vcpus faulting on the same PMD entry, can lead to
>> +	 * them sequentially updating the PMD with the same
>> +	 * value. Following the break-before-make (pmd_clear()
>> +	 * followed by tlb_flush()) process can hinder forward
>> +	 * progress due to refaults generated on missing translations.
>> +	 *
>> +	 * Skip updating the page table if the entry is unchanged.
>> +	 */
>> +	if (pmd_val(old_pmd) == pmd_val(*new_pmd))
>> +		return 0;
>
> Shouldn't you take this opportunity to also refactor it with the above
> VM_BUG_ON and the below pmd_present? At the moment, we end-up testing
> pmd_present twice, and your patch is awfully similar to the VM_BUG_ON
> one.

I went for the minimal change keeping a backport in mind.

The VM_BUG_ON() is enabled only when CONFIG_DEBUG_VM is selected and
checks for pfn ignoring the attributes, while this fix checks for the
entire entry. Maybe I'm missing something, but I can't see an obvious
way to combine the checks.

I've eliminated the duplicate pmd_present() check and will post the
updated patches.

Thanks,
Punit

>> +
>>  	if (pmd_present(old_pmd)) {
>>  		pmd_clear(pmd);
>>  		kvm_tlb_flush_vmid_ipa(kvm, addr);
>> @@ -1101,6 +1113,10 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>>  
>>  	/* Create 2nd stage page table mapping - Level 3 */
>>  	old_pte = *pte;
>> +	/* Skip page table update if there is no change */
>> +	if (pte_val(old_pte) == pte_val(*new_pte))
>> +		return 0;
>> +
>>  	if (pte_present(old_pte)) {
>>  		kvm_set_pte(pte, __pte(0));
>>  		kvm_tlb_flush_vmid_ipa(kvm, addr);
>
> Thanks,
>
> 	M.
