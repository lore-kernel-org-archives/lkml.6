Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A66C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07B420657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfAOOLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:11:35 -0500
Received: from foss.arm.com ([217.140.101.70]:52154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbfAOOLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:11:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B198A78;
        Tue, 15 Jan 2019 06:11:34 -0800 (PST)
Received: from [10.163.1.4] (unknown [10.163.1.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FFAC3F739;
        Tue, 15 Jan 2019 06:11:25 -0800 (PST)
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, mpe@ellerman.id.au,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, christoffer.dall@arm.com,
        marc.zyngier@arm.com, kirill@shutemov.name,
        rppt@linux.vnet.ibm.com, ard.biesheuvel@linaro.org,
        mark.rutland@arm.com, steve.capper@arm.com, james.morse@arm.com,
        robin.murphy@arm.com, aneesh.kumar@linux.ibm.com, vbabka@suse.cz,
        shakeelb@google.com, rientjes@google.com
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190113173555.GC1578@dhcp22.suse.cz>
 <f9f333a5-5533-996a-dc8e-1ff1096c1d19@arm.com>
 <20190114070137.GB21345@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a81dd27a-b7d1-ddad-e104-4ce51699ac3d@arm.com>
Date:   Tue, 15 Jan 2019 19:41:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190114070137.GB21345@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/14/2019 12:31 PM, Michal Hocko wrote:
> On Mon 14-01-19 09:30:55, Anshuman Khandual wrote:
>>
>>
>> On 01/13/2019 11:05 PM, Michal Hocko wrote:
>>> On Sat 12-01-19 15:56:38, Anshuman Khandual wrote:
>>>> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
>>>> __GFP_ZERO) and using it for allocating page table pages. This causes some
>>>> code duplication which can be easily avoided. GFP_KERNEL allocated and
>>>> cleared out pages (__GFP_ZERO) are required for page tables on any given
>>>> architecture. This creates a new generic GFP flag flag which can be used
>>>> for any page table page allocation. Does not cause any functional change.
>>>
>>> I agree that some unification is due but GFP_PGTABLE is not something to
>>> expose in generic gfp.h IMHO. It just risks an abuse. I would be looking
>>
>> Why would you think that it risks an abuse ? It does not create new semantics
>> of allocation in the buddy. Its just uses existing GFP_KERNEL allocation which
>> is then getting zeroed out. The risks (if any) is exactly same as GFP_KERNEL.
> 
> Beucase my experience just tells me that people tend to use whatever
> they find and name fits what they think they need.
> 
>>> at providing asm-generic implementation and reuse it to remove the code
>>
>> Does that mean GFP_PGTABLE can be created but not in gfp.h but in some other
>> memory related header file ?
> 
> I would just keep it close to its users. If that is a single arch
> generic place then only better. But I suspect some arches have special
> requirements.

We can move the definition into include/asm-generic/pgtable.h which can be
used by all archs. If there any special requirements those can be added on
this generic and common minimum allocation flag. The minimum required flag
should not be duplicated every where.

> 
>>> duplication. But I haven't tried that to know that it will work out due
>>> to small/subtle differences between arches.
>>
>> IIUC from the allocation perspective GFP_ACCOUNT is the only thing which gets
>> added with GFP_PGTABLE for user page table for memcg accounting purpose. There
>> does not seem to be any other differences unless I am missing something.
> 
> It's been some time since I've checked the last time. Some arches were
> using GPF_REPEAT (__GFP_RETRY_MAYFAIL) back then. I have removed most of
> those but some were doing a higher order allocations so they probably
> have stayed.

A simple grep shows that still there are some places which use the flag
__GFP_RETRY_MAYFAIL. But that can be added on GFP_PGTABLE for these archs.

arch/nds32/include/asm/pgalloc.h:           (pte_t *) __get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL |
arch/nds32/include/asm/pgalloc.h:       pte = alloc_pages(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO, 0);
arch/powerpc/include/asm/book3s/64/pgalloc.h:   page = alloc_pages(pgtable_gfp_flags(mm, PGALLOC_GFP | __GFP_RETRY_MAYFAIL),
arch/powerpc/kvm/book3s_64_mmu_hv.c:            hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_RETRY_MAYFAIL
arch/riscv/include/asm/pgalloc.h:               GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO);
arch/riscv/include/asm/pgalloc.h:               GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO);
arch/riscv/include/asm/pgalloc.h:       pte = alloc_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO);
arch/sparc/kernel/mdesc.c:      base = kmalloc(handle_size + 15, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
