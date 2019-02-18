Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1BBC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8875821902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390276AbfBROTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:19:36 -0500
Received: from foss.arm.com ([217.140.101.70]:59640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389442AbfBROTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:19:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B64AF15AB;
        Mon, 18 Feb 2019 06:19:33 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 770F73F589;
        Mon, 18 Feb 2019 06:19:15 -0800 (PST)
Subject: Re: [PATCH 03/13] mm: Add generic p?d_large() macros
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kirill@shutemov.name, Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, kan.liang@linux.intel.com
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-4-steven.price@arm.com>
 <20190218113134.GU32477@hirez.programming.kicks-ass.net>
From:   Steven Price <steven.price@arm.com>
Message-ID: <aad21496-a86b-ca91-70b7-0c23ea6fefd3@arm.com>
Date:   Mon, 18 Feb 2019 14:19:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190218113134.GU32477@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2019 11:31, Peter Zijlstra wrote:
> On Fri, Feb 15, 2019 at 05:02:24PM +0000, Steven Price wrote:
>> From: James Morse <james.morse@arm.com>
>>
>> Exposing the pud/pgd levels of the page tables to walk_page_range() means
>> we may come across the exotic large mappings that come with large areas
>> of contiguous memory (such as the kernel's linear map).
>>
>> For architectures that don't provide p?d_large() macros, provided a
>> does nothing default.
> 
> Kan was going to fix that for all archs I think..

The latest series I can find from Kan is still x86 specific. I'm happy
to rebase onto something else if Kan has an implementation already
(please point me in the right direction). Otherwise Kan is obviously
free to base on these changes.

Steve

> See:
> 
>   http://lkml.kernel.org/r/20190204105409.GA17550@hirez.programming.kicks-ass.net
> 
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>  include/asm-generic/pgtable.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
>> index 05e61e6c843f..7630d663cd51 100644
>> --- a/include/asm-generic/pgtable.h
>> +++ b/include/asm-generic/pgtable.h
>> @@ -1186,4 +1186,14 @@ static inline bool arch_has_pfn_modify_check(void)
>>  #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
>>  #endif
>>  
>> +#ifndef pgd_large
>> +#define pgd_large(x)	0
>> +#endif
>> +#ifndef pud_large
>> +#define pud_large(x)	0
>> +#endif
>> +#ifndef pmd_large
>> +#define pmd_large(x)	0
>> +#endif
>> +
>>  #endif /* _ASM_GENERIC_PGTABLE_H */
>> -- 
>> 2.20.1
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

