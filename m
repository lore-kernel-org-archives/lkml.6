Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0927C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6482084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbfALNtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 08:49:32 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:51553 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfALNtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 08:49:32 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43cLgq65Zjz9vBmP;
        Sat, 12 Jan 2019 14:49:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8olI-kILdexS; Sat, 12 Jan 2019 14:49:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43cLgq5BBkz9vBmN;
        Sat, 12 Jan 2019 14:49:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CC2268B77F;
        Sat, 12 Jan 2019 14:49:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zFSHdAazdoZD; Sat, 12 Jan 2019 14:49:30 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7A89F8B74C;
        Sat, 12 Jan 2019 14:49:29 +0100 (CET)
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
To:     Matthew Wilcox <willy@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     mark.rutland@arm.com, mhocko@suse.com, linux-sh@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kvmarm@lists.cs.columbia.edu, linux@armlinux.org.uk,
        mingo@redhat.com, vbabka@suse.cz, rientjes@google.com,
        marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com,
        kirill@shutemov.name, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, steve.capper@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190112121230.GQ6310@bombadil.infradead.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ddd59fdc-3d8f-4015-e851-e7f099193a1b@c-s.fr>
Date:   Sat, 12 Jan 2019 14:49:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190112121230.GQ6310@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/01/2019 à 13:12, Matthew Wilcox a écrit :
> On Sat, Jan 12, 2019 at 03:56:38PM +0530, Anshuman Khandual wrote:
>> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
>> __GFP_ZERO) and using it for allocating page table pages.
> 
> Except that's not true.
> 
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -13,19 +13,17 @@ phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
>>   EXPORT_SYMBOL(physical_mask);
>>   #endif
>>   
>> -#define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
>> -
>>   #ifdef CONFIG_HIGHPTE
> 
> ...
> 
>>   pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>>   {
>> -	return (pte_t *)__get_free_page(PGALLOC_GFP & ~__GFP_ACCOUNT);
>> +	return (pte_t *)__get_free_page(GFP_PGTABLE & ~__GFP_ACCOUNT);
>>   }

As far as I can see,

#define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)

So what's the difference between:

(GFP_KERNEL_ACCOUNT | __GFP_ZERO) & ~__GFP_ACCOUNT

and

(GFP_KERNEL | __GFP_ZERO) & ~__GFP_ACCOUNT

Christophe

> 
> I think x86 was the only odd one out here, but you'll need to try again ...
> 
