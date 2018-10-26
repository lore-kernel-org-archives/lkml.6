Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EC6C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1251620824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1251620824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeJZKOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 06:14:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36616 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbeJZKOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 06:14:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39DC7341;
        Thu, 25 Oct 2018 18:39:15 -0700 (PDT)
Received: from [192.168.0.7] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA2E63F5D3;
        Thu, 25 Oct 2018 18:39:11 -0700 (PDT)
Subject: Re: [PATCH] mm/thp: Correctly differentiate between mapped THP and
 PMD migration entry
To:     Zi Yan <zi.yan@cs.rutgers.edu>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org, mhocko@suse.com, will.deacon@arm.com,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
References: <1539057538-27446-1-git-send-email-anshuman.khandual@arm.com>
 <7E8E6B14-D5C4-4A30-840D-A7AB046517FB@cs.rutgers.edu>
 <84509db4-13ce-fd53-e924-cc4288d493f7@arm.com>
 <1968F276-5D96-426B-823F-38F6A51FB465@cs.rutgers.edu>
 <5e0e772c-7eef-e75c-2921-e80d4fbe8324@arm.com>
 <2398C491-E1DA-4B3C-B60A-377A09A02F1A@cs.rutgers.edu>
 <796cb545-7376-16a2-db3e-bc9a6ca9894d@arm.com>
 <5A0A88EF-4B86-4173-A506-DE19BDB786B8@cs.rutgers.edu>
 <dcd972a6-a508-1fab-4ba9-04043ca9992c@arm.com>
 <B26B3F91-BA46-479E-8030-D581F4D90D47@cs.rutgers.edu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <bcb3a3e1-da2f-265f-82db-02b20e438bc5@arm.com>
Date:   Fri, 26 Oct 2018 07:09:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <B26B3F91-BA46-479E-8030-D581F4D90D47@cs.rutgers.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2018 12:15 AM, Zi Yan wrote:
> On 25 Oct 2018, at 4:10, Anshuman Khandual wrote:
> 
>> On 10/16/2018 08:01 PM, Zi Yan wrote:
>>> On 15 Oct 2018, at 0:06, Anshuman Khandual wrote:
>>>
>>>> On 10/15/2018 06:23 AM, Zi Yan wrote:
>>>>> On 12 Oct 2018, at 4:00, Anshuman Khandual wrote:
>>>>>
>>>>>> On 10/10/2018 06:13 PM, Zi Yan wrote:
>>>>>>> On 10 Oct 2018, at 0:05, Anshuman Khandual wrote:
>>>>>>>
>>>>>>>> On 10/09/2018 07:28 PM, Zi Yan wrote:
>>>>>>>>> cc: Naoya Horiguchi (who proposed to use !_PAGE_PRESENT && !_PAGE_PSE for x86
>>>>>>>>> PMD migration entry check)
>>>>>>>>>
>>>>>>>>> On 8 Oct 2018, at 23:58, Anshuman Khandual wrote:
>>>>>>>>>
>>>>>>>>>> A normal mapped THP page at PMD level should be correctly differentiated
>>>>>>>>>> from a PMD migration entry while walking the page table. A mapped THP would
>>>>>>>>>> additionally check positive for pmd_present() along with pmd_trans_huge()
>>>>>>>>>> as compared to a PMD migration entry. This just adds a new conditional test
>>>>>>>>>> differentiating the two while walking the page table.
>>>>>>>>>>
>>>>>>>>>> Fixes: 616b8371539a6 ("mm: thp: enable thp migration in generic path")
>>>>>>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>>>>>>> ---
>>>>>>>>>> On X86, pmd_trans_huge() and is_pmd_migration_entry() are always mutually
>>>>>>>>>> exclusive which makes the current conditional block work for both mapped
>>>>>>>>>> and migration entries. This is not same with arm64 where pmd_trans_huge()
>>>>>>>>>
>>>>>>>>> !pmd_present() && pmd_trans_huge() is used to represent THPs under splitting,
>>>>>>>>
>>>>>>>> Not really if we just look at code in the conditional blocks.
>>>>>>>
>>>>>>> Yeah, I explained it wrong above. Sorry about that.
>>>>>>>
>>>>>>> In x86, pmd_present() checks (_PAGE_PRESENT | _PAGE_PROTNONE | _PAGE_PSE),
>>>>>>> thus, it returns true even if the present bit is cleared but PSE bit is set.
>>>>>>
>>>>>> Okay.
>>>>>>
>>>>>>> This is done so, because THPs under splitting are regarded as present in the kernel
>>>>>>> but not present when a hardware page table walker checks it.
>>>>>>
>>>>>> Okay.
>>>>>>
>>>>>>>
>>>>>>> For PMD migration entry, which should be regarded as not present, if PSE bit
>>>>>>> is set, which makes pmd_trans_huge() returns true, like ARM64 does, all
>>>>>>> PMD migration entries will be regarded as present
>>>>>>
>>>>>> Okay to make pmd_present() return false pmd_trans_huge() has to return false
>>>>>> as well. Is there anything which can be done to get around this problem on
>>>>>> X86 ? pmd_trans_huge() returning true for a migration entry sounds logical.
>>>>>> Otherwise we would revert the condition block order to accommodate both the
>>>>>> implementation for pmd_trans_huge() as suggested by Kirill before or just
>>>>>> consider this patch forward.
>>>>>>
>>>>>> Because I am not really sure yet about the idea of getting pmd_present()
>>>>>> check into pmd_trans_huge() on arm64 just to make it fit into this semantics
>>>>>> as suggested by Will. If a PMD is trans huge page or not should not depend on
>>>>>> whether it is present or not.
>>>>>
>>>>> In terms of THPs, we have three cases: a present THP, a THP under splitting,
>>>>> and a THP under migration. pmd_present() and pmd_trans_huge() both return true
>>>>> for a present THP and a THP under splitting, because they discover _PAGE_PSE bit
>>>>
>>>> Then how do we differentiate between a mapped THP and a splitting THP.
>>>
>>> AFAIK, in x86, there is no distinction between a mapped THP and a splitting THP
>>> using helper functions.
>>>
>>> A mapped THP has _PAGE_PRESENT bit and _PAGE_PSE bit set, whereas a splitting THP
>>> has only _PAGE_PSE bit set. But both pmd_present() and pmd_trans_huge() return
>>> true as long as _PAGE_PSE bit is set.
>>
>> I understand that. What I was wondering was since there is a need to differentiate
>> between a mapped THP and a splitting THP at various places in generic THP, we would
>> need to way to identify each of them unambiguously some how. Is that particular
>> assumption wrong ? Dont we need to differentiate between a mapped THP and THP under
>> splitting ?
> 
> According to Andrea's explanation here: https://lore.kernel.org/patchwork/patch/997412/#1184298,
> we do not distinguish between a mapped THP and a splitting THP, because pmd_to_page()
> can return valid pages for both cases.

I have gone through Andrea's explanation but still trying to understand all those
details in there. Will get back on this.

> 
>>>
>>>>
>>>>> is set for both cases, whereas they both return false for a THP under migration.
>>>>> You want to change them to make pmd_trans_huge() returns true for a THP under migration
>>>>> instead of false to help ARM64’s support for THP migration.
>>>> I am just trying to understand the rationale behind this semantics and see where
>>>> it should be fixed.
>>>>
>>>> I think the fundamental problem here is that THP under split has been difficult
>>>> to be re-presented through the available helper functions and in turn PTE bits.
>>>>
>>>> The following checks
>>>>
>>>> 1) pmd_present()
>>>> 2) pmd_trans_huge()
>>>>
>>>> Represent three THP states
>>>>
>>>> 1) Mapped THP		(pmd_present && pmd_trans_huge)
>>>> 2) Splitting THP	(pmd_present && pmd_trans_huge)
>>>> 3) Migrating THP	(!pmd_present && !pmd_trans_huge)
>>>>
>>>> The problem is if we make pmd_trans_huge() return true for all the three states
>>>> which sounds logical because they are all still trans huge PMD, then pmd_present()
>>>> can only represent two states not three as required.
>>>
>>> We are on the same page about representing three THP states in x86.
>>> I also agree with you that it is logical to use three distinct representations
>>> for these three states, i.e. splitting THP could be changed to (!pmd_present && pmd_trans_huge
>>
>> Right. Also we need clear wrapper around them in line with is_pmd_migration_entry() to
>> represent three states all of which calling pmd_present() and pmd_trans_huge() which
>> are exported by various architectures with exact same semantics without any ambiguity.
>>
>> 1) is_pmd_mapped_entry()
>> 2) is_pmd_splitting_entry()
>> 3) is_pmd_migration_entry()
> 
> I think the semantics of pmd_trans_huge() is that the pmd entry is pointing to
> a huge page. So is_pmd_mapped_entry() is the same as is_pmd_splitting_entry()
> in terms of that.

Because in both the situations pmd_page() returns true which means PMD really points
to a huge page in the RAM which is true for a mapped and a splitting PMD entry.

> 
> According to Andrea's explanation:https://lore.kernel.org/patchwork/patch/997412/#1184298,
> the semantics can avoid pmd_lock serializations on all VM fast paths, which
> is valid IMHO.

But still I do not understand how not distinguishing between a mapped PMD entry
and splitting PMD entry can help speed up core VM paths by not taking pmd_lock.
IIUC pmd_lock has to be taken before splitting the PMD entry into constituent
pages and generic page table walk does not take the lock. Hence trying to see
how not distinguishing mapped and splitting PMD entry helps here.

> 
> 
>>>
>>>
>>>>>
>>>>> For x86, this change requires:
>>>>> 1. changing the condition in pmd_trans_huge(), so that it returns true for
>>>>> PMD migration entries;
>>>>> 2. changing the code, which calls pmd_trans_huge(), to match the new logic.
>>>> Can those be fixed with an additional check for pmd_present() as suggested here
>>>> in this patch ? Asking because in case we could not get common semantics for
>>>> these helpers on all arch that would be a fall back option for the moment.
>>>
>>> It would be OK for x86, since pmd_trans_huge() implies pmd_present() and hence
>>> adding pmd_present() to pmd_trans_huge() makes no difference. But for ARM64,
>>> from my understanding of the code described below, adding pmd_present() to
>>> pmd_trans_huge() seems to exclude splitting THPs from the original semantic.
>>>
>>>
>>>>>
>>>>> Another problem I see is that x86’s pmd_present() returns true for a THP under
>>>>> splitting but ARM64’s pmd_present() returns false for a THP under splitting.
>>>>
>>>> But how did you conclude this ? I dont see any explicit helper for splitting
>>>> THP. Could you please point me in the code ?
>>>
>>> From the code I read for ARM64
>>> (https://elixir.bootlin.com/linux/v4.19-rc8/source/arch/arm64/include/asm/pgtable.h#L360
>>> and https://elixir.bootlin.com/linux/v4.19-rc8/source/arch/arm64/include/asm/pgtable.h#L86),
>>> pmd_present() only checks _PAGE_PRESENT and _PAGE_PROTONE. During a THP splitting,
>>
>> These are PTE_VALID and PTE_PROT_NONE instead on arm64. But yes, they are equivalent
>> to __PAGE_PRESENT and __PAGE_PROTNONE on other archs.
>>
>> #define pmd_present(pmd)        pte_present(pmd_pte(pmd))
>> #define pte_present(pte)        (!!(pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)))
>>
>>> pmdp_invalidate() clears _PAGE_PRESENT (https://elixir.bootlin.com/linux/v4.19-rc8/source/mm/huge_memory.c#L2130). So pmd_present() returns false in ARM64. Let me know
>>> if I got anything wrong.
>>>
>>
>> old_pmd = pmdp_invalidate(vma, haddr, pmd);
>>
>> __split_huge_pmd_locked -> pmdp_invalidate (the above mentioned instance)
>> pmdp_invalidate -> pmd_mknotpresent
>>
>> #define pmd_mknotpresent(pmd)   (__pmd(pmd_val(pmd) & ~PMD_SECT_VALID)
>>
>> Generic pmdp invalidation removes PMD_SECT_VALID from a mapped PMD entry.
>> PMD_SECT_VALID is similar to PTE_VALID through identified separately. So you
>> are right, on arm64 pmd_present() return false for THP under splitting.
> 
> This may actually cause problems in arm64, since the kernel will miss all splitting THPs.

Now I understand why pmd_present() needs to return true for a splitting PMD entry.
Yeah, this needs to be fixed on arm64.

> 
> In sum, according to Andrea's explanation, I think it is better to adjust
> arm64's pmd_present() and pmd_trans_huge() to match what x86's semantics.
> Otherwise, arm64 might hit bugs while handling THPs.

I will look into this further. Thanks for the explanation.
