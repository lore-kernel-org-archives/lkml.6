Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401A1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DEA20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DEA20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeJPVHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:07:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36260 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPVHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:07:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52C8580D;
        Tue, 16 Oct 2018 06:16:53 -0700 (PDT)
Received: from [10.163.1.73] (unknown [10.163.1.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F0203F59C;
        Tue, 16 Oct 2018 06:16:50 -0700 (PDT)
Subject: Re: [PATCH] mm/thp: Correctly differentiate between mapped THP and
 PMD migration entry
To:     "Aneesh Kumar K.V" <aneeshkumar.opensource@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        mhocko@suse.com, zi.yan@cs.rutgers.edu
References: <1539057538-27446-1-git-send-email-anshuman.khandual@arm.com>
 <20181009130421.bmus632ocurn275u@kshutemo-mobl1>
 <20181009131803.GH6248@arm.com>
 <fb0ee5dd-5799-f5af-891a-992dd9a16a9f@arm.com>
 <4bf3951d-410f-fac4-dfb2-7dee5568e6ff@linux.ibm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7e11e5b0-fad5-01fb-6b01-66bbd50b6a2e@arm.com>
Date:   Tue, 16 Oct 2018 18:46:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4bf3951d-410f-fac4-dfb2-7dee5568e6ff@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/2018 02:02 PM, Aneesh Kumar K.V wrote:
> On 10/12/18 1:32 PM, Anshuman Khandual wrote:
>>
>>
>> On 10/09/2018 06:48 PM, Will Deacon wrote:
>>> On Tue, Oct 09, 2018 at 04:04:21PM +0300, Kirill A. Shutemov wrote:
>>>> On Tue, Oct 09, 2018 at 09:28:58AM +0530, Anshuman Khandual wrote:
>>>>> A normal mapped THP page at PMD level should be correctly differentiated
>>>>> from a PMD migration entry while walking the page table. A mapped THP would
>>>>> additionally check positive for pmd_present() along with pmd_trans_huge()
>>>>> as compared to a PMD migration entry. This just adds a new conditional test
>>>>> differentiating the two while walking the page table.
>>>>>
>>>>> Fixes: 616b8371539a6 ("mm: thp: enable thp migration in generic path")
>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>> ---
>>>>> On X86, pmd_trans_huge() and is_pmd_migration_entry() are always mutually
>>>>> exclusive which makes the current conditional block work for both mapped
>>>>> and migration entries. This is not same with arm64 where pmd_trans_huge()
>>>>> returns positive for both mapped and migration entries. Could some one
>>>>> please explain why pmd_trans_huge() has to return false for migration
>>>>> entries which just install swap bits and its still a PMD ?
>>>>
>>>> I guess it's just a design choice. Any reason why arm64 cannot do the
>>>> same?
>>>
>>> Anshuman, would it work to:
>>>
>>> #define pmd_trans_huge(pmd)     (pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
>> yeah this works but some how does not seem like the right thing to do
>> but can be the very last option.
>>
> 
> 
> There can be other code paths that makes that assumption. I ended up doing the below for pmd_trans_huge on ppc64.
>

Yeah, did see that in one of the previous proposals.

https://patchwork.kernel.org/patch/10544291/

But the existing semantics does not look right and makes vague assumptions.
Zi Yan has already asked Andrea for his input in this regard on the next
thread. So I guess while being here, its a good idea to revisit existing
semantics and it's assumptions before fixing it in arch specific helpers.

- Anshuman 


> /*
>  * Only returns true for a THP. False for pmd migration entry.
>  * We also need to return true when we come across a pte that
>  * in between a thp split. While splitting THP, we mark the pmd
>  * invalid (pmdp_invalidate()) before we set it with pte page
>  * address. A pmd_trans_huge() check against a pmd entry during that time
>  * should return true.
>  * We should not call this on a hugetlb entry. We should check for HugeTLB
>  * entry using vma->vm_flags
>  * The page table walk rule is explained in Documentation/vm/transhuge.rst
>  */
> static inline int pmd_trans_huge(pmd_t pmd)
> {
>     if (!pmd_present(pmd))
>         return false;
> 
>     if (radix_enabled())
>         return radix__pmd_trans_huge(pmd);
>     return hash__pmd_trans_huge(pmd);
> }
> 
> -aneesh
> 
