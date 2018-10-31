Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC8CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364702054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364702054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbeJaXun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:50:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42274 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbeJaXun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:50:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 102B4341;
        Wed, 31 Oct 2018 07:52:22 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 834003F71D;
        Wed, 31 Oct 2018 07:52:21 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Christoffer Dall <christoffer.dall@arm.com>
Cc:     <kvmarm@lists.cs.columbia.edu>, <marc.zyngier@arm.com>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH v8 1/9] KVM: arm/arm64: Ensure only THP is candidate for adjustment
References: <20181001155443.23032-1-punit.agrawal@arm.com>
        <20181001155443.23032-2-punit.agrawal@arm.com>
        <20181031143646.GE12057@e113682-lin.lund.arm.com>
Date:   Wed, 31 Oct 2018 14:52:20 +0000
In-Reply-To: <20181031143646.GE12057@e113682-lin.lund.arm.com> (Christoffer
        Dall's message of "Wed, 31 Oct 2018 15:36:46 +0100")
Message-ID: <87h8h2rwwr.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoffer Dall <christoffer.dall@arm.com> writes:

> On Mon, Oct 01, 2018 at 04:54:35PM +0100, Punit Agrawal wrote:
>> PageTransCompoundMap() returns true for hugetlbfs and THP
>> hugepages. This behaviour incorrectly leads to stage 2 faults for
>> unsupported hugepage sizes (e.g., 64K hugepage with 4K pages) to be
>> treated as THP faults.
>> 
>> Tighten the check to filter out hugetlbfs pages. This also leads to
>> consistently mapping all unsupported hugepage sizes as PTE level
>> entries at stage 2.
>> 
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Reviewed-by: Suzuki Poulose <suzuki.poulose@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: stable@vger.kernel.org # v4.13+
>
>
> Hmm, this function is only actually called from user_mem_abort() if we
> have (!hugetlb), so I'm not sure the cc stable here was actually
> warranted, nor that this patch is strictly necessary.
>
> It doesn't hurt, and makes the code potentially more robust for the
> future though.
>
> Am I missing something?

!hugetlb is only true for hugepage sizes supported at stage 2. The
function also got called for unsupported hugepage size at stage 2, e.g.,
64k hugepage with 4k page size, which then ended up doing the wrong
thing.

Hope that adds some context. I should've added this to the commit log.

>
> Thanks,
>
>     Christoffer
>
>> ---
>>  virt/kvm/arm/mmu.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index 7e477b3cae5b..c23a1b323aad 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1231,8 +1231,14 @@ static bool transparent_hugepage_adjust(kvm_pfn_t *pfnp, phys_addr_t *ipap)
>>  {
>>  	kvm_pfn_t pfn = *pfnp;
>>  	gfn_t gfn = *ipap >> PAGE_SHIFT;
>> +	struct page *page = pfn_to_page(pfn);
>>  
>> -	if (PageTransCompoundMap(pfn_to_page(pfn))) {
>> +	/*
>> +	 * PageTransCompoungMap() returns true for THP and
>> +	 * hugetlbfs. Make sure the adjustment is done only for THP
>> +	 * pages.
>> +	 */
>> +	if (!PageHuge(page) && PageTransCompoundMap(page)) {
>>  		unsigned long mask;
>>  		/*
>>  		 * The address we faulted on is backed by a transparent huge
>> -- 
>> 2.18.0
>> 
