Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EDBC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABF622BC4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABF622BC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753585AbeF0LXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:23:06 -0400
Received: from foss.arm.com ([217.140.101.70]:58360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752144AbeF0LXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:23:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C3D67A9;
        Wed, 27 Jun 2018 04:23:05 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4C023F5C0;
        Wed, 27 Jun 2018 04:23:03 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] arm64/mm: Move {tramp_pg_dir, swapper_pg_dir} to
 .rodata section
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <20180625113921.21854-1-yaojun8558363@gmail.com>
 <20180625113921.21854-3-yaojun8558363@gmail.com>
 <82f3bf16-cf3a-9b2d-a7d2-789a4abb0bf2@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <ceb6135a-4e4d-d597-85aa-7639a044d097@arm.com>
Date:   Wed, 27 Jun 2018 12:23:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <82f3bf16-cf3a-9b2d-a7d2-789a4abb0bf2@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki, Jun,

On 27/06/18 12:07, Suzuki K Poulose wrote:
> On 25/06/18 12:39, Jun Yao wrote:
>> When CONFIG_ARM64_VA_BITS_36/CONFIG_ARM64_VA_BITS_39/
>> CONFIG_ARM64_VA_BITS_42 are selected, a block-mapping can be
>> written to swapper_pg_dir. To defend 'KSMA', we move swapper_pg_dir
>> to .rodata section when these configurations are selected. At the
>> same time, we update swapper_pg_dir by fixmap.

>> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
>> index 2e05bcd944c8..62512ad9c310 100644
>> --- a/arch/arm64/include/asm/pgalloc.h
>> +++ b/arch/arm64/include/asm/pgalloc.h
>> @@ -49,6 +49,22 @@ static inline void __pud_populate(pud_t *pudp, phys_addr_t
>> pmdp, pudval_t prot)
>>     static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t
>> *pmdp)
>>   {
>> +#ifdef CONFIG_ARM64_VA_BITS_39
> 
> Could we please use
> 
> #ifdef __PAGETABLE_PUD_FOLDED ^^

>> @@ -142,6 +158,23 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
>> pte_t *ptep)
>>       /*
>>        * The pmd must be loaded with the physical address of the PTE table
>>        */
>> +#if defined(CONFIG_ARM64_VA_BITS_42) || \
>> +    defined(CONFIG_ARM64_VA_BITS_36)
> 
> and
> 
> #ifdef __PGTABLE_PMD_FOLDED here ^^
> 
> 
>> +#if defined(CONFIG_ARM64_VA_BITS_39) || \
>> +    defined(CONFIG_ARM64_VA_BITS_36) || \
>> +    defined(CONFIG_ARM64_VA_BITS_42)
> 
> and
> 
> #ifdef __PGTABLE_PMD_FOLDED ^^ (as it implies
> __PGTABLE_PUD_FOLDED )
> 
> instead ?

Aha, I didn't know these existed. As we are only interested in matching one
level for now, this is even clearer.


Thanks,

James
