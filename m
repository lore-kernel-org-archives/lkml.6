Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64343C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D7323F3F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D7323F3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeGBNY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:24:56 -0400
Received: from foss.arm.com ([217.140.101.70]:60364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751415AbeGBNYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:24:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7CE718A;
        Mon,  2 Jul 2018 06:24:51 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FAA53F5AD;
        Mon,  2 Jul 2018 06:24:49 -0700 (PDT)
Subject: Re: [PATCH v3 09/20] kvm: arm64: Make stage2 page table layout
 dynamic
To:     Auger Eric <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        marc.zyngier@arm.com, cdall@kernel.org, julien.grall@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-10-git-send-email-suzuki.poulose@arm.com>
 <65475ac0-d156-c16e-bd91-438377326143@redhat.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <22c070c4-aede-d699-774f-6212d05f7a59@arm.com>
Date:   Mon, 2 Jul 2018 14:24:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <65475ac0-d156-c16e-bd91-438377326143@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,


On 02/07/18 13:14, Auger Eric wrote:
> Hi Suzuki,
> 
> On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
>> So far we had a static stage2 page table handling code, based on a
>> fixed IPA of 40bits. As we prepare for a configurable IPA size per
>> VM, make our stage2 page table code dynamic, to do the right thing
>> for a given VM. We ensure the existing condition is always true even
>> when we lift the limit on the IPA. i.e,
>>
>> 	page table levels in stage1 >= page table levels in stage2
>>
>> Support for the IPA size configuration needs other changes in the way
>> we configure the EL2 registers (VTTBR and VTCR). So, the IPA is still
>> fixed to 40bits. The patch also moves the kvm_page_empty() in asm/kvm_mmu.h
>> to the top, before including the asm/stage2_pgtable.h to avoid a forward
>> declaration.
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since V2
>>   - Restrict the stage2 page table to allow reusing the host page table
>>     helpers for now, until we get stage1 independent page table helpers.
> I would move this up in the commit msg to motivate the fact we enforce
> the able condition.

This is mentioned in the commit message for the patch which lifts the limitation
on the IPA. This patch only deals with the dynamic page table level handling,
with the restriction on the levels. Nevertheless, I could add it to the
description.

>> ---
>>   arch/arm64/include/asm/kvm_mmu.h              |  14 +-
>>   arch/arm64/include/asm/stage2_pgtable-nopmd.h |  42 ------
>>   arch/arm64/include/asm/stage2_pgtable-nopud.h |  39 -----
>>   arch/arm64/include/asm/stage2_pgtable.h       | 207 +++++++++++++++++++-------
>>   4 files changed, 159 insertions(+), 143 deletions(-)
>>   delete mode 100644 arch/arm64/include/asm/stage2_pgtable-nopmd.h
>>   delete mode 100644 arch/arm64/include/asm/stage2_pgtable-nopud.h
> 
> with my very limited knowledge of S2 page table walkers I fail to
> understand why we now can get rid of stage2_pgtable-nopmd.h and
> stage2_pgtable-nopud.h and associated FOLDED config. Please could you
> explain it in the commit message?

As mentioned above, we have static page table helpers, which are decided
at compile time (just like the stage1). So these files hold the definitions
for the cases where PUD/PMD is folded and included for a given stage1 VA.
But since we are now doing this check per VM, we make the decision
by checking the kvm_stage2_levels(), instead of hard coding it.

Does that help ? A short version of that is already there. May be I could
elaborate that a bit.

>> -
>> -#define stage2_pgd_index(kvm, addr) \
>> -	(((addr) >> S2_PGDIR_SHIFT) & (PTRS_PER_S2_PGD - 1))
>> +static inline unsigned long stage2_pgd_index(struct kvm *kvm, phys_addr_t addr)
>> +{
>> +	return (addr >> stage2_pgdir_shift(kvm)) & (stage2_pgd_ptrs(kvm) - 1);
>> +}
>>   
>>   static inline phys_addr_t
>>   stage2_pgd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>>   {
>> -	phys_addr_t boundary = (addr + S2_PGDIR_SIZE) & S2_PGDIR_MASK;
>> +	phys_addr_t boundary;
>>   
>> +	boundary = (addr + stage2_pgdir_size(kvm)) & stage2_pgdir_mask(kvm);
>>   	return (boundary - 1 < end - 1) ? boundary : end;
>>   }
>>   
>>
> 
> Globally this patch is pretty hard to review. I don't know if it is
> possible to split into 2. 1) Addition of some helper macros. 2) removal
> of nopud and nopmd and implementation of the corresponding macros?

I acknowledge that. The patch redefines the "existing" macros to make the
decision at runtime based on the VM's setting. I will see if there is a
better way to do it.

Cheers
Suzuki
