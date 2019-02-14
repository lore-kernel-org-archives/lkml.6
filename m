Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0706BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51D0222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395381AbfBNDll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:41:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36668 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389764AbfBNDlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:41:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E79D80D;
        Wed, 13 Feb 2019 19:41:39 -0800 (PST)
Received: from [10.162.42.113] (p8cg001049571a15.blr.arm.com [10.162.42.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C89953F589;
        Wed, 13 Feb 2019 19:41:36 -0800 (PST)
Subject: Re: [LSF/MM TOPIC] Non standard size THP
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        lsf-pc@lists.linux-foundation.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <dcb0b2cf-ba5c-e6ef-0b05-c6006227b6a9@arm.com>
 <20190212083331.dtch7xubjxlmz5tf@kshutemo-mobl1>
 <282f6d89-bcc2-2622-1205-7c43ba85c37e@arm.com>
 <20190213133827.GN4525@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <3088cb22-a304-16d8-d97a-5e1e840a7f55@arm.com>
Date:   Thu, 14 Feb 2019 09:11:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190213133827.GN4525@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/13/2019 07:08 PM, Michal Hocko wrote:
> On Wed 13-02-19 18:20:03, Anshuman Khandual wrote:
>> On 02/12/2019 02:03 PM, Kirill A. Shutemov wrote:
>>> Honestly, I'm very skeptical about the idea. It took a lot of time to
>>> stabilize THP for singe page size, equal to PMD page table, but this looks
>>> like a new can of worms. :P
>>
>> I understand your concern here but HW providing some more TLB sizes beyond
>> standard page table level (PMD/PUD/PGD) based huge pages can help achieve
>> performance improvement when the buddy is already fragmented enough not to
>> provide higher order pages. PUD THP file mapping is already supported for
>> DAX and PUD THP anon mapping might be supported in near future (it is not
>> much challenging other than allocating HPAGE_PUD_SIZE huge page at runtime
>> will be much difficult). Around PMD sizes like HPAGE_CONT_PMD_SIZE or
>> HPAGE_CONT_PTE_SIZE really have better chances as future non-PMD level anon
>> mapping than a PUD size anon mapping support in THP.
> 
> I do not think our page allocator is really ready to provide >PMD huge
> pages. So even if we deal with all the nasty things wrt locking and page
> table handling the crux becomes the allocation side. The current
> CMA/contig allocator is everything but useful for THP. It can barely
> handle hugetlb cases which are mostly pre-allocate based.

I understand the point for > PMD size. Hence first we can just narrow the
focus on contiguous PTE level huge pages which are < PMD but could offer
THP benefits on arm64 for 64K config page sizes.

> 
> Besides that is there any real world usecase driving this or it is
> merely "this is possible so let's just do it"?

64K config arm64 kernel is mostly unable to use THP at PMD level of 512 MB.
But it should be able benefit from THP if we have support at cont PTE level
of 2MB which is way less than 512MB.
