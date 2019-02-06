Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AB5C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78601218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfBFUXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:23:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:62768 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfBFUXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:23:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 12:23:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,341,1544515200"; 
   d="scan'208";a="273028567"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 06 Feb 2019 12:23:54 -0800
Received: from [10.254.83.189] (kliang2-mobl1.ccr.corp.intel.com [10.254.83.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9BBD8580478;
        Wed,  6 Feb 2019 12:23:52 -0800 (PST)
From:   "Liang, Kan" <kan.liang@linux.intel.com>
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
 <9fbb7bd3-b150-1ed1-bf03-c44d789172d0@linux.intel.com>
 <20190204105409.GA17550@hirez.programming.kicks-ass.net>
Message-ID: <57c48ebb-029c-1192-e30e-c546742ae311@linux.intel.com>
Date:   Wed, 6 Feb 2019 15:23:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204105409.GA17550@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/2019 5:54 AM, Peter Zijlstra wrote:
> On Fri, Feb 01, 2019 at 11:16:51AM -0500, Liang, Kan wrote:
> 
>>> 	if (p4d_large(*p4d)) {
>>
>> This one looks like x86 specific?
> 
>>> 	if (pud_large(*pud)) {
> 
>>> 	if (pmd_large(*pmd)) {
> 
> Kirill did indeed note that p*_large() isn't universally availale (but
> there's definitely !x86 archs that have them). He also said it would
> probably make sense to have them universally available and might help
> clean up mm/gup.c a little.
> 
> A quick grep shows that: ARM, PowerPC, S390, Sparc and x86 have
> 'pmd_large'.
> 
> Anyway; it probably makes sense (and shouldn't be too hard) to fix up
> all architectures to provide this.
> 
Hi Peter and Kirill,

It looks like it's not easy to support get_page_size() universally.
Even the 'pmd_large' you mentioned is not universal. I got error message 
when building with ARCH=riscv.
There is even less support for pud_large and p4d_large.
We have to check and add something like "#define p*d_large(a) 0" in the 
pg headers for each ARCH. I think it's ugly.


> +               if (PageHuge(page)) {
> +                       page = compound_head(page);
> +                       shift = PAGE_SHIFT + compound_order(page);
> +               }

PageHuge() only returns true for hugetlbfs. I think the transparent huge 
pages should also use compound pages, right? Besides hugetlbfs and THP, 
are there any other cases which also use compound pages?
Can the codes handle all these cases?

> +static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long
> +addr) {
> +	pgd_t *pgd;
> +	p4d_t *p4d;

An universal get_page_size() function should not be implemented in perf. 
It will be a problem for future maintenance.

All in all, I think we are far away from an universal get_page_size(). A 
__weak function + x86 implementation solution proposed in this patch 
series should be a better choice.
- Other ARCH can have their own implementation later if they want this 
feature.
- Standard pg table helper functions are used for x86. Maintenance will 
not be a problem.

What do you think?

Thanks,
Kan
