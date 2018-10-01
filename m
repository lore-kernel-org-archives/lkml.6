Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DA7C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9350208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9350208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbeJAU1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:27:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49386 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729298AbeJAU1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:27:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FC231596;
        Mon,  1 Oct 2018 06:49:09 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.Emea.Arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 012E33F774;
        Mon,  1 Oct 2018 06:49:06 -0700 (PDT)
Subject: Re: [PATCH v5 3/6] arm64/mm: Create the initial page table in the
 init_pg_dir.
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jun Yao <yaojun8558363@gmail.com>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180917044333.30051-4-yaojun8558363@gmail.com>
 <20180924133437.zr2u5c42rfmhro6o@lakrids.cambridge.arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <d3e8eae0-3429-d0ab-9e77-a56e26791450@arm.com>
Date:   Mon, 1 Oct 2018 14:49:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924133437.zr2u5c42rfmhro6o@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 24/09/18 14:34, Mark Rutland wrote:
> On Mon, Sep 17, 2018 at 12:43:30PM +0800, Jun Yao wrote:
>> Create the initial page table in the init_pg_dir. And update the
>> init_mm.pgd to make sure that pgd_offset_k() works correctly. When
>> the final page table is created, we redirect the init_mm.pgd to the
>> swapper_pg_dir.

>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index de2aaea00bd2..cf8a58211b80 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -376,7 +376,7 @@ __create_page_tables:
>>  	/*
>>  	 * Map the kernel image (starting with PHYS_OFFSET).
>>  	 */
>> -	adrp	x0, swapper_pg_dir
>> +	adrp	x0, init_pg_dir
>>  	mov_q	x5, KIMAGE_VADDR + TEXT_OFFSET	// compile time __va(_text)
>>  	add	x5, x5, x23			// add KASLR displacement
>>  	mov	x4, PTRS_PER_PGD
>> @@ -439,6 +439,11 @@ __primary_switched:
>>  	bl	__pi_memset
>>  	dsb	ishst				// Make zero page visible to PTW
>>  
>> +	// Update init_mm.pgd
>> +	adrp	x0, init_pg_dir
>> +	adr_l	x1, init_mm
>> +	str	x0, [x1, #MM_PGD]
>> +
> 
> We should be able to set this up statically with INIT_MM_CONTEXT(). i.e.
> in <asm/mmu.h> have:
> 
> #define INIT_MM_CONTEXT(name)	\
> 	.pgd = init_pg_dir

Aha, I didn't think this would be possible because we end up setting .pgd twice,
but gcc says that's fine, it gets the last value:
https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html

(and it looks like clang has a test for this)


Thanks,

James
