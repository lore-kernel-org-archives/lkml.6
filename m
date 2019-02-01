Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97965C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7054D21726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfBAQQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:16:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:34101 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfBAQQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:16:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 08:16:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,549,1539673200"; 
   d="scan'208";a="114532242"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 01 Feb 2019 08:16:54 -0800
Received: from [10.254.84.202] (kliang2-mobl1.ccr.corp.intel.com [10.254.84.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 348615804BB;
        Fri,  1 Feb 2019 08:16:53 -0800 (PST)
Subject: Re: [PATCH V4 01/13] perf/core, x86: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     acme@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, luto@amacapital.net,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will.deacon@arm.com>
References: <1548966486-49963-1-git-send-email-kan.liang@linux.intel.com>
 <20190201092240.GB31498@hirez.programming.kicks-ass.net>
 <20190201100358.GD31552@hirez.programming.kicks-ass.net>
 <20190201103600.uflrwzgwj2tadhey@kshutemo-mobl1>
 <20190201124348.GC31534@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <9fbb7bd3-b150-1ed1-bf03-c44d789172d0@linux.intel.com>
Date:   Fri, 1 Feb 2019 11:16:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190201124348.GC31534@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/2019 7:43 AM, Peter Zijlstra wrote:
> On Fri, Feb 01, 2019 at 01:36:00PM +0300, Kirill A. Shutemov wrote:
>> On Fri, Feb 01, 2019 at 11:03:58AM +0100, Peter Zijlstra wrote:
> 
>>> Will just mentioned a lovely feature where some archs have multi entry
>>> large pages.
>>>
>>> Possible something like:
>>>
>>> 	if (pud_large(*pud)) {
>>> 		struct page *page = pud_page(*pud);
>>> 		int order = PUD_SHIFT;
>>>
>>> 		if (PageHuge(page)) {
>>> 			page = compound_head(page);
>>> 			order += compound_order(page);
>>> 		}
>>>
>>> 		return 1ULL << order;
>>> 	}
>>>
>>> works correctly.
>>
>> For more fun: some compound pages can be mapped withe page table entries
>> not matching it's compound size, i.e. 2M pages mapped with PTE.
> 
> Surely not for PageHuge() ?! I thought the point of hugetlbfs was to
> guarantee page granularity.
> 
> How is the below?
> 
> static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
> {
> 	pgd_t *pgd;
> 	p4d_t *p4d;
> 	pud_t *pud;
> 	pmd_t *pmd;
> 	pte_t *pte;
> 
> 	pgd = pgd_offset(mm, addr);
> 	if (pgd_none(*pgd))
> 		return 0;
> 
> 	p4d = p4d_offset(pgd, addr);
> 	if (!p4d_present(*p4d))
> 		return 0;
> 
> 	if (p4d_large(*p4d)) {

This one looks like x86 specific?

Kan

> 		struct page *page = p4d_page(*p4d);
> 		int shift = P4D_SHIFT;
> 
> 		if (PageHuge(page)) {
> 			page = compound_head(page);
> 			shift = PAGE_SHIFT + compound_order(page);
> 		}
> 
> 		return 1ULL << shift;
> 	}
> 
> 	if (!p4d_present(*p4d))
> 		return 0;
> 
> 	pud = pud_offset(p4d, addr);
> 	if (!pud_present(*pud))
> 		return 0;
> 
> 	if (pud_large(*pud)) {
> 		struct page *page = pud_page(*pud);
> 		int shift = P4D_SHIFT;
> 
> 		if (PageHuge(page)) {
> 			page = compound_head(page);
> 			shift = PAGE_SHIFT + compound_order(page);
> 		}
> 
> 		return 1ULL << shift;
> 	}
> 
> 	pmd = pmd_offset(pud, addr);
> 	if (!pmd_present(*pmd))
> 		return 0;
> 
> 	if (pmd_large(*pmd)) {
> 		struct page *page = pud_page(*pud);
> 		int shift = P4D_SHIFT;
> 
> 		if (PageHuge(page)) {
> 			page = compound_head(page);
> 			shift = PAGE_SHIFT + compound_order(page);
> 		}
> 
> 		return 1ULL << shift;
> 	}
> 
> 	pte = pte_offset_map(pmd, addr);
> 	if (!pte_present(*pte)) {
> 		pte_unmap(pte);
> 		return 0;
> 	}
> 
> 	pte_unmap(pte);
> 	return PAGE_SIZE;
> }
> 
