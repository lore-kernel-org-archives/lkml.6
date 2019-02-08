Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A69C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31A621919
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfBHGbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 01:31:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45640 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfBHGbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 01:31:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69734EBD;
        Thu,  7 Feb 2019 22:31:33 -0800 (PST)
Received: from [10.162.40.126] (p8cg001049571a15.blr.arm.com [10.162.40.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2D753F719;
        Thu,  7 Feb 2019 22:31:30 -0800 (PST)
Subject: Re: [LSF/MM TOPIC] Non standard size THP
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org
References: <dcb0b2cf-ba5c-e6ef-0b05-c6006227b6a9@arm.com>
 <20190208042448.GB21860@bombadil.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a563592f-c01c-8dee-d743-6a1eb0b3f9d9@arm.com>
Date:   Fri, 8 Feb 2019 12:01:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190208042448.GB21860@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2019 09:54 AM, Matthew Wilcox wrote:
> On Fri, Feb 08, 2019 at 07:43:57AM +0530, Anshuman Khandual wrote:
>> How non-standard huge pages can be supported for THP
>>
>> 	- THP starts recognizing non standard huge page (exported by arch) like HPAGE_CONT_(PMD|PTE)_SIZE
>> 	- THP starts operating for either on HPAGE_PMD_SIZE or HPAGE_CONT_PMD_SIZE or HPAGE_CONT_PTE_SIZE
>> 	- set_pmd_at() only recognizes HPAGE_PMD_SIZE hence replace set_pmd_at() with set_huge_pmd_at()
>> 	- set_huge_pmd_at() could differentiate between HPAGE_PMD_SIZE or HPAGE_CONT_PMD_SIZE
>> 	- In case for HPAGE_CONT_PTE_SIZE extend page table walker till PTE level
>> 	- Use set_huge_pte_at() which can operate on multiple contiguous PTE bits
> 
> I think your proposed solution reflects thinking like a hardware person
> rather than like a software person.  Or maybe like an MM person rather
> than a FS person.  I see the same problem with Kirill's solutions ;-)

You might be right on this :) I was trying to derive a solution based on
all existing semantics with limited code addition rather than inventing
something completely different.

> 
> Perhaps you don't realise that using larger pages when appropriate
> would also benefit filesystems as well as CPUs.  You didn't include
> linux-fsdevel on this submission, so that's a plausible explanation.

Yes that was an omission. Thanks for adding linux-fsdevel to the thread.

> 
> The XArray currently supports arbitrary power-of-two-naturally-aligned
> page sizes, and conveniently so does the page allocator [1].  The problem
> is that various bits of the MM have a very fixed mindset that pages are
> PTE, PMD or PUD in size.

I agree. But in general it works as allocated page with required order do
reside in one of these levels in the page table.

> 
> We should enhance routines like vmf_insert_page() to handle
> arbitrary sized pages rather than having separate vmf_insert_pfn()
> and vmf_insert_pfn_pmd().  We probably need to enhance the set_pxx_at()
> API to pass in an order, rather than explicitly naming pte/pmd/pud/...

I agree. set_huge_pte_at() actually does that to some extent on ARM64.
But thats just for HugeTLB.

> 
> First, though, we need to actually get arbitrary sized pages handled
> correctly in the page cache.  So if anyone's interested in talking about
> this, but hasn't been reviewing or commenting on the patches I've been
> sending to make this happen, I'm going to seriously question their actual
> commitment to wanting this to happen, rather than wanting a nice holiday
> in Puerto Rico.
> 
> Sorry to be so blunt about this, but I've only had review from Kirill,
> which makes me think that nobody else actually cares about getting
> this fixed.

To be honest I have not been following your work in this regard. I started
looking into this problem late last year and my goal has been more focused 
towards a THP solution for intermediate page table level sized huge pages.

But I agree to your point that there should be an wider solution which can
make generic MM deal with page sizes of any order rather than page table
level ones like PTE/PMD/PUD etc.

> 
> [1] Support for arbitrary sized and aligned entries is in progress for
> the XArray, but I don't think there's any appetite for changing the buddy
> allocator to let us allocate "pages" that are an arbitrary extent in size.
> 
> 
