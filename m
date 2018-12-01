Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5C6C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA23720834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA23720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeLALpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:45:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:64273 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbeLALpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:45:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 16:34:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,300,1539673200"; 
   d="scan'208";a="114461925"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.27])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2018 16:34:07 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -V7 RESEND 08/21] swap: Support to read a huge swap cluster for swapin a THP
References: <20181120085449.5542-1-ying.huang@intel.com>
        <20181120085449.5542-9-ying.huang@intel.com>
        <20181130233201.6yuzbhymtjddvf3u@ca-dmjordan1.us.oracle.com>
Date:   Sat, 01 Dec 2018 08:34:06 +0800
In-Reply-To: <20181130233201.6yuzbhymtjddvf3u@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Fri, 30 Nov 2018 15:32:01 -0800")
Message-ID: <8736rirsox.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel,

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> Hi Ying,
>
> On Tue, Nov 20, 2018 at 04:54:36PM +0800, Huang Ying wrote:
>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>> index 97831166994a..1eedbc0aede2 100644
>> --- a/mm/swap_state.c
>> +++ b/mm/swap_state.c
>> @@ -387,14 +389,42 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>>  		 * as SWAP_HAS_CACHE.  That's done in later part of code or
>>  		 * else swap_off will be aborted if we return NULL.
>>  		 */
>> -		if (!__swp_swapcount(entry) && swap_slot_cache_enabled)
>> +		if (!__swp_swapcount(entry, &entry_size) &&
>> +		    swap_slot_cache_enabled)
>>  			break;
>>  
>>  		/*
>>  		 * Get a new page to read into from swap.
>>  		 */
>> -		if (!new_page) {
>> -			new_page = alloc_page_vma(gfp_mask, vma, addr);
>> +		if (!new_page ||
>> +		    (IS_ENABLED(CONFIG_THP_SWAP) &&
>> +		     hpage_nr_pages(new_page) != entry_size)) {
>> +			if (new_page)
>> +				put_page(new_page);
>> +			if (IS_ENABLED(CONFIG_THP_SWAP) &&
>> +			    entry_size == HPAGE_PMD_NR) {
>> +				gfp_t gfp;
>> +
>> +				gfp = alloc_hugepage_direct_gfpmask(vma, addr);
>
> vma is NULL when we get here from try_to_unuse, so the kernel will die on
> vma->flags inside alloc_hugepage_direct_gfpmask.

Good catch!  Thanks a lot for your help to pinpoint this bug!

> try_to_unuse swaps in before it finds vma's, but even if those were reversed,
> it seems try_to_unuse wouldn't always have a single vma to pass into this path
> since it's walking the swap_map and multiple processes mapping the same huge
> page can have different huge page advice (and maybe mempolicies?), affecting
> the result of alloc_hugepage_direct_gfpmask.  And yet
> alloc_hugepage_direct_gfpmask needs a vma to do its job.  So, I'm not sure how
> to fix this.
>
> If the entry's usage count were 1, we could find the vma in that common case to
> give read_swap_cache_async, and otherwise allocate small pages.  We'd have THPs
> some of the time and be exactly following alloc_hugepage_direct_gfpmask, but
> would also be conservative when it's uncertain.
>
> Or, if the system-wide THP settings allow it then go for it, but otherwise
> ignore vma hints and always fall back to small pages.  This requires another
> way of controlling THP allocations besides alloc_hugepage_direct_gfpmask.
>
> Or maybe try_to_unuse shouldn't allocate hugepages at all, but then no perf
> improvement for try_to_unuse.
>
> What do you think?

I think that swapoff() which is the main user of try_to_unuse() isn't a
common operation in practical.  So it's not necessary to make it more
complex for this.

In alloc_hugepage_direct_gfpmask(), the only information provided by vma
is: vma->flags & VM_HUGEPAGE.  Because we have no vma available, I think
it is OK to just assume that the flag is cleared.  That is, rely on
system-wide THP settings only.

What do you think about this proposal?

Best Regards,
Huang, Ying
