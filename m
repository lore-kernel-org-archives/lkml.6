Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C171C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B5121917
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391855AbfBROLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:11:48 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59382 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391837AbfBROLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:11:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EB10A78;
        Mon, 18 Feb 2019 06:11:45 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACC763F589;
        Mon, 18 Feb 2019 06:11:42 -0800 (PST)
Subject: Re: [PATCH 01/13] arm64: mm: Add p?d_large() definitions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190215170235.23360-1-steven.price@arm.com>
 <20190215170235.23360-2-steven.price@arm.com>
 <20190218112922.GT32477@hirez.programming.kicks-ass.net>
From:   Steven Price <steven.price@arm.com>
Message-ID: <fe36ed1c-b90d-8062-f7a9-e52d940733c4@arm.com>
Date:   Mon, 18 Feb 2019 14:11:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190218112922.GT32477@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2019 11:29, Peter Zijlstra wrote:
> On Fri, Feb 15, 2019 at 05:02:22PM +0000, Steven Price wrote:
> 
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index de70c1eabf33..09d308921625 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -428,6 +428,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>>  				 PMD_TYPE_TABLE)
>>  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
>>  				 PMD_TYPE_SECT)
>> +#define pmd_large(x)		pmd_sect(x)
>>  
>>  #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
>>  #define pud_sect(pud)		(0)
>> @@ -435,6 +436,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>>  #else
>>  #define pud_sect(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
>>  				 PUD_TYPE_SECT)
>> +#define pud_large(x)		pud_sect(x)
>>  #define pud_table(pud)		((pud_val(pud) & PUD_TYPE_MASK) == \
>>  				 PUD_TYPE_TABLE)
>>  #endif
> 
> So on x86 p*d_large() also matches p*d_huge() and thp, But it is not
> clear to me this p*d_sect() thing does so, given your definitions.
> 
> See here why I care:
> 
>   http://lkml.kernel.org/r/20190201124741.GE31552@hirez.programming.kicks-ass.net
> 

pmd_huge()/pud_huge() unfortunately are currently defined as '0' if
!CONFIG_HUGETLB_PAGE and for this reason I was avoiding using them.
While most code would reasonably not care about huge pages in that build
configuration, the likes of the debugfs page table dump code needs to be
able to recognise them in all build configurations. I believe the
situation is the same on arm64 and x86.

The other quirk is that higher levels are not supported for HUGETLB on
some arch implementations. For example arm64 provides no definition for
pgd_huge() so falls back to the generic defined as '0' implementation.
The only architecture I can see that defines this is powerpc. Keeping
this as '0' ensures that the otherwise dead code in other places is
compiled out.

Where p?d_huge is defined by the arch code the intention is that
p?d_large(x)==p?d_huge(x).

Thanks,

Steve
