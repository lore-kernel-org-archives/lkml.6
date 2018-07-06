Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C73C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2920A20878
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2920A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932720AbeGFOgI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:36:08 -0400
Received: from foss.arm.com ([217.140.101.70]:37788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753763AbeGFOgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:36:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 964DB15B2;
        Fri,  6 Jul 2018 07:36:06 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.206.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A2AC3F2EA;
        Fri,  6 Jul 2018 07:36:06 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/7] KVM: arm64: Support PUD hugepage in stage2_is_exec()
References: <20180705140850.5801-1-punit.agrawal@arm.com>
        <20180705140850.5801-5-punit.agrawal@arm.com>
        <442d0f4b-cb23-9788-1ebd-b14c89c52c45@arm.com>
Date:   Fri, 06 Jul 2018 15:36:04 +0100
In-Reply-To: <442d0f4b-cb23-9788-1ebd-b14c89c52c45@arm.com> (Suzuki
        K. Poulose's message of "Thu, 5 Jul 2018 17:48:37 +0100")
Message-ID: <87fu0wqvmz.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suzuki K Poulose <Suzuki.Poulose@arm.com> writes:

> Hi Punit,
>
> On 05/07/18 15:08, Punit Agrawal wrote:
>> In preparation for creating PUD hugepages at stage 2, add support for
>> detecting execute permissions on PUD page table entries. Faults due to
>> lack of execute permissions on page table entries is used to perform
>> i-cache invalidation on first execute.
>>
>> Provide trivial implementations of arm32 helpers to allow sharing of
>> code.
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>   arch/arm/include/asm/kvm_mmu.h         |  6 ++++++
>>   arch/arm64/include/asm/kvm_mmu.h       |  5 +++++
>>   arch/arm64/include/asm/pgtable-hwdef.h |  2 ++
>>   virt/kvm/arm/mmu.c                     | 10 +++++++++-
>>   4 files changed, 22 insertions(+), 1 deletion(-)
>>

[...]

>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index db04b18218c1..ccdea0edabb3 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1040,10 +1040,18 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
>>     static bool stage2_is_exec(struct kvm *kvm, phys_addr_t addr)
>>   {
>> +	pud_t *pudp;
>>   	pmd_t *pmdp;
>>   	pte_t *ptep;
>>   -	pmdp = stage2_get_pmd(kvm, NULL, addr);
>> +	pudp = stage2_get_pud(kvm, NULL, addr);
>> +	if (!pudp || pud_none(*pudp) || !pud_present(*pudp))
>> +		return false;
>> +
>> +	if (pud_huge(*pudp))
>> +		return kvm_s2pud_exec(pudp);
>> +
>> +	pmdp = stage2_pmd_offset(pudp, addr);
>>   	if (!pmdp || pmd_none(*pmdp) || !pmd_present(*pmdp))
>>   		return false;
>
> I am wondering if we need a slightly better way to deal with this
> kind of operation. We seem to duplicate the above operation (here and
> in the following patches), i.e, finding the "leaf entry" for a given
> address and follow the checks one level up at a time.

We definitely need a better way to walk the page tables - for stage 2
but also stage 1 and hugetlbfs. As things stands, there is a lot of
repetitive pattern with small differences at some levels (hugepage
and/or THP, p*d_none(), p*d_present(), ...)

> So instead of doing, stage2_get_pud() and walking down everywhere this
> is needed, how about adding :
>
> /* Returns true if the leaf entry is found and updates the relevant pointer */
> found = stage2_get_leaf_entry(kvm, NULL, addr, &pudp, &pmdp, &ptep)
>
> which could set the appropriate entry and we could check the result
> here.

I prototyped with the above approach but found that it could not be used
in all places due to the specific semantics of the walk. Also, then we
end up with the following pattern.

    if (pudp) {
            ...
    } else if (pmdp) {
            ...
    } else {
            ...
    }

At the end of the conversion, the resulting code is the same size as
well (see diff below for changes).

Another idea might be to build a page table walker passing in callbacks
- but this makes more sense if we have unified modifiers for the
levels. I think this is something we should explore but would like to do
outside the context of this series.

Hope thats ok.

Thanks for having a look,
Punit

-- >8 --
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index eddb74a7fac3..ea5c99f6dfab 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1077,31 +1077,56 @@ static int stage2_set_pud_huge(struct kvm *kvm, struct kvm_mmu_memory_cache *cac
 	return 0;
 }
 
-static bool stage2_is_exec(struct kvm *kvm, phys_addr_t addr)
+static bool stage2_get_leaf_entry(struct kvm *kvm, phys_addr_t addr, pud_t **pudp,
+				  pmd_t **pmdp, pte_t **ptep)
 {
-	pud_t *pudp;
-	pmd_t *pmdp;
-	pte_t *ptep;
+	pud_t *lpudp;
+	pmd_t *lpmdp;
+	pte_t *lptep;
 
-	pudp = stage2_get_pud(kvm, NULL, addr);
-	if (!pudp || pud_none(*pudp) || !pud_present(*pudp))
+	lpudp = stage2_get_pud(kvm, NULL, addr);
+	if (!lpudp || pud_none(*lpudp) || !pud_present(*lpudp))
 		return false;
 
-	if (pud_huge(*pudp))
-		return kvm_s2pud_exec(pudp);
+	if (pud_huge(*lpudp)) {
+		*pudp = lpudp;
+		return true;
+	}
 
-	pmdp = stage2_pmd_offset(pudp, addr);
-	if (!pmdp || pmd_none(*pmdp) || !pmd_present(*pmdp))
+	lpmdp = stage2_pmd_offset(lpudp, addr);
+	if (!lpmdp || pmd_none(*lpmdp) || !pmd_present(*lpmdp))
 		return false;
 
-	if (pmd_thp_or_huge(*pmdp))
-		return kvm_s2pmd_exec(pmdp);
+	if (pmd_thp_or_huge(*lpmdp)) {
+		*pmdp = lpmdp;
+		return true;
+	}
 
-	ptep = pte_offset_kernel(pmdp, addr);
-	if (!ptep || pte_none(*ptep) || !pte_present(*ptep))
+	lptep = pte_offset_kernel(lpmdp, addr);
+	if (!lptep || pte_none(*lptep) || !pte_present(*lptep))
 		return false;
 
-	return kvm_s2pte_exec(ptep);
+	*ptep = lptep;
+	return true;
+}
+
+static bool stage2_is_exec(struct kvm *kvm, phys_addr_t addr)
+{
+	pud_t *pudp = NULL;
+	pmd_t *pmdp = NULL;
+	pte_t *ptep = NULL;
+	bool found;
+
+	found = stage2_get_leaf_entry(kvm, addr, &pudp, &pmdp, &ptep);
+	if (!found)
+		return false;
+
+	if (pudp)
+		return kvm_s2pud_exec(pudp);
+	else if (pmdp)
+		return kvm_s2pmd_exec(pmdp);
+	else
+		return kvm_s2pte_exec(ptep);
 }
 
 static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
@@ -1681,45 +1706,36 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
  */
 static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 {
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
+	pud_t *pud = NULL;
+	pmd_t *pmd = NULL;
+	pte_t *pte = NULL;
 	kvm_pfn_t pfn;
-	bool pfn_valid = false;
+	bool found, pfn_valid = false;
 
 	trace_kvm_access_fault(fault_ipa);
 
 	spin_lock(&vcpu->kvm->mmu_lock);
 
-	pud = stage2_get_pud(vcpu->kvm, NULL, fault_ipa);
-	if (!pud || pud_none(*pud))
-		goto out;		/* Nothing there */
+	found = stage2_get_leaf_entry(kvm, fault_ipa, &pud, &pmd, &pte);
+	if (!found)
+		goto out;
 
-	if (pud_huge(*pud)) {		/* HugeTLB */
+	if (pud) {		/* HugeTLB */
 		*pud = kvm_s2pud_mkyoung(*pud);
 		pfn = kvm_pud_pfn(*pud);
 		pfn_valid = true;
 		goto out;
-	}
-
-	pmd = stage2_pmd_offset(pud, fault_ipa);
-	if (!pmd || pmd_none(*pmd))	/* Nothing there */
-		goto out;
-
-	if (pmd_thp_or_huge(*pmd)) {	/* THP, HugeTLB */
+	} else 	if (pmd) {	/* THP, HugeTLB */
 		*pmd = pmd_mkyoung(*pmd);
 		pfn = pmd_pfn(*pmd);
 		pfn_valid = true;
 		goto out;
+	} else {
+		*pte = pte_mkyoung(*pte);	/* Just a page... */
+		pfn = pte_pfn(*pte);
+		pfn_valid = true;
 	}
 
-	pte = pte_offset_kernel(pmd, fault_ipa);
-	if (pte_none(*pte))		/* Nothing there either */
-		goto out;
-
-	*pte = pte_mkyoung(*pte);	/* Just a page... */
-	pfn = pte_pfn(*pte);
-	pfn_valid = true;
 out:
 	spin_unlock(&vcpu->kvm->mmu_lock);
 	if (pfn_valid)
@@ -1932,58 +1948,42 @@ void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 
 static int kvm_age_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *data)
 {
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
+	pud_t *pud = NULL;
+	pmd_t *pmd = NULL;
+	pte_t *pte = NULL;
+	bool found;
 
 	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
-	pud = stage2_get_pud(kvm, NULL, gpa);
-	if (!pud || pud_none(*pud))	/* Nothing there */
+	found = stage2_get_leaf_entry(kvm, gpa, &pud, &pmd, &pte);
+	if (!found)
 		return 0;
 
-	if (pud_huge(*pud))		/* HugeTLB */
+	if (pud)
 		return stage2_pudp_test_and_clear_young(pud);
-
-	pmd = stage2_pmd_offset(pud, gpa);
-	if (!pmd || pmd_none(*pmd))	/* Nothing there */
-		return 0;
-
-	if (pmd_thp_or_huge(*pmd))	/* THP, HugeTLB */
+	else if (pmd)
 		return stage2_pmdp_test_and_clear_young(pmd);
-
-	pte = pte_offset_kernel(pmd, gpa);
-	if (pte_none(*pte))
-		return 0;
-
-	return stage2_ptep_test_and_clear_young(pte);
+	else
+		return stage2_ptep_test_and_clear_young(pte);
 }
 
 static int kvm_test_age_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *data)
 {
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
+	pud_t *pud = NULL;
+	pmd_t *pmd = NULL;
+	pte_t *pte = NULL;
+	bool found;
 
 	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
-	pud = stage2_get_pud(kvm, NULL, gpa);
-	if (!pud || pud_none(*pud))	/* Nothing there */
+	found = stage2_get_leaf_entry(kvm, gpa, &pud, &pmd, &pte);
+	if (!found)
 		return 0;
 
-	if (pud_huge(*pud))		/* HugeTLB */
+	if (pud)
 		return kvm_s2pud_young(*pud);
-
-	pmd = stage2_pmd_offset(pud, gpa);
-	if (!pmd || pmd_none(*pmd))	/* Nothing there */
-		return 0;
-
-	if (pmd_thp_or_huge(*pmd))		/* THP, HugeTLB */
+	else if (pmd)
 		return pmd_young(*pmd);
-
-	pte = pte_offset_kernel(pmd, gpa);
-	if (!pte_none(*pte))		/* Just a page... */
+	else
 		return pte_young(*pte);
-
-	return 0;
 }
 
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
