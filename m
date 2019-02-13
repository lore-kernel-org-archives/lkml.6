Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94480C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6862A222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbfBMMuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:50:07 -0500
Received: from foss.arm.com ([217.140.101.70]:53132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731306AbfBMMuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:50:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB34780D;
        Wed, 13 Feb 2019 04:50:06 -0800 (PST)
Received: from [10.162.43.147] (p8cg001049571a15.blr.arm.com [10.162.43.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 132273F557;
        Wed, 13 Feb 2019 04:50:03 -0800 (PST)
Subject: Re: [LSF/MM TOPIC] Non standard size THP
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     lsf-pc@lists.linux-foundation.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <dcb0b2cf-ba5c-e6ef-0b05-c6006227b6a9@arm.com>
 <20190212083331.dtch7xubjxlmz5tf@kshutemo-mobl1>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <282f6d89-bcc2-2622-1205-7c43ba85c37e@arm.com>
Date:   Wed, 13 Feb 2019 18:20:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190212083331.dtch7xubjxlmz5tf@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2019 02:03 PM, Kirill A. Shutemov wrote:
> On Fri, Feb 08, 2019 at 07:43:57AM +0530, Anshuman Khandual wrote:
>> Hello,
>>
>> THP is currently supported for
>>
>> - PMD level pages (anon and file)
>> - PUD level pages (file - DAX file system)
>>
>> THP is a single entry mapping at standard page table levels (either PMD or PUD)
>>
>> But architectures like ARM64 supports non-standard page table level huge pages
>> with contiguous bits.
>>
>> - These are created as multiple entries at either PTE or PMD level
>> - These multiple entries carry pages which are physically contiguous
>> - A special PTE bit (PTE_CONT) is set indicating single entry to be contiguous
>>
>> These multiple contiguous entries create a huge page size which is different
>> than standard PMD/PUD level but they provide benefits of huge memory like
>> less number of faults, bigger TLB coverage, less TLB miss etc.
>>
>> Currently they are used as HugeTLB pages because
>>
>> 	- HugeTLB page sizes is carried in the VMA
>> 	- Page table walker can operate on multiple PTE or PMD entries given its size in VMA
>> 	- Irrespective of HugeTLB page size its operated with set_huge_pte_at() at any level
>> 	- set_huge_pte_at() is arch specific which knows how to encode multiple consecutive entries
>> 	
>> But not as THP huge pages because
>>
>> 	- THP size is not encoded any where like VMA
>> 	- Page table walker expects it to be either at PUD (HPAGE_PUD_SIZE) or at PMD (HPAGE_PMD_SIZE)
>> 	- Page table operates directly with set_pmd_at() or set_pud_at()
>> 	- Direct faulted or promoted huge pages is verified with [pmd|pud]_trans_huge()
>>
>> How non-standard huge pages can be supported for THP
>>
>> 	- THP starts recognizing non standard huge page (exported by arch) like HPAGE_CONT_(PMD|PTE)_SIZE
>> 	- THP starts operating for either on HPAGE_PMD_SIZE or HPAGE_CONT_PMD_SIZE or HPAGE_CONT_PTE_SIZE
>> 	- set_pmd_at() only recognizes HPAGE_PMD_SIZE hence replace set_pmd_at() with set_huge_pmd_at()
>> 	- set_huge_pmd_at() could differentiate between HPAGE_PMD_SIZE or HPAGE_CONT_PMD_SIZE
>> 	- In case for HPAGE_CONT_PTE_SIZE extend page table walker till PTE level
>> 	- Use set_huge_pte_at() which can operate on multiple contiguous PTE bits
> 
> You only listed trivial things. All tricky stuff is what make THP
> transparent.

Agreed. I was trying to draw an analogy from HugeTLB with respect to page
table creation and it's walking. Huge page collapse and split on such non
standard huge pages will involve taking care of much details.

> 
> To consider it seriously we need to understand what it means for
> split_huge_p?d()/split_huge_page()? How khugepaged will deal with this?

Absolutely. Can these operate on non standard probably multi entry based
huge pages ? How to handle atomicity etc.

> 
> In particular, I'm worry to expose (to user or CPU) page table state in
> the middle of conversion (huge->small or small->huge). Handling this on
> page table level provides a level atomicity that you will not have.

I understand it might require a software based lock instead of standard HW
atomicity constructs which will make it slow but is that even possible ?

> 
> Honestly, I'm very skeptical about the idea. It took a lot of time to
> stabilize THP for singe page size, equal to PMD page table, but this looks
> like a new can of worms. :P

I understand your concern here but HW providing some more TLB sizes beyond
standard page table level (PMD/PUD/PGD) based huge pages can help achieve
performance improvement when the buddy is already fragmented enough not to
provide higher order pages. PUD THP file mapping is already supported for
DAX and PUD THP anon mapping might be supported in near future (it is not
much challenging other than allocating HPAGE_PUD_SIZE huge page at runtime
will be much difficult). Around PMD sizes like HPAGE_CONT_PMD_SIZE or
HPAGE_CONT_PTE_SIZE really have better chances as future non-PMD level anon
mapping than a PUD size anon mapping support in THP.

> 
> It *might* be possible to support it for DAX, but beyond that...
>

Did not get that. Why would you think that this is possible or appropriate
only for DAX file mapping but not for anon mapping ?
