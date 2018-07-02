Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F9AC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C832438D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C832438D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932664AbeGCFba (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:31:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:34174 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932499AbeGCFb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:31:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 22:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,302,1526367600"; 
   d="scan'208";a="53657024"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga007.jf.intel.com with ESMTP; 02 Jul 2018 22:31:25 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Shaohua Li" <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 08/21] mm, THP, swap: Support to read a huge swap cluster for swapin a THP
Date:   Mon, 02 Jul 2018 14:02:47 +0800
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180622035151.6676-9-ying.huang@intel.com>
        <20180629062126.GJ7646@bombadil.infradead.org>
Message-ID: <87y3esvqab.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Jun 22, 2018 at 11:51:38AM +0800, Huang, Ying wrote:
>> +++ b/mm/swap_state.c
>> @@ -426,33 +447,37 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>>  		/*
>>  		 * call radix_tree_preload() while we can wait.
>>  		 */
>> -		err = radix_tree_maybe_preload(gfp_mask & GFP_KERNEL);
>> +		err = radix_tree_maybe_preload_order(gfp_mask & GFP_KERNEL,
>> +						     compound_order(new_page));
>>  		if (err)
>>  			break;
>
> There's no more preloading in the XArray world, so this can just be dropped.

Sure.

>>  		/*
>>  		 * Swap entry may have been freed since our caller observed it.
>>  		 */
>> +		err = swapcache_prepare(hentry, huge_cluster);
>> +		if (err) {
>>  			radix_tree_preload_end();
>> -			break;
>> +			if (err == -EEXIST) {
>> +				/*
>> +				 * We might race against get_swap_page() and
>> +				 * stumble across a SWAP_HAS_CACHE swap_map
>> +				 * entry whose page has not been brought into
>> +				 * the swapcache yet.
>> +				 */
>> +				cond_resched();
>> +				continue;
>> +			} else if (err == -ENOTDIR) {
>> +				/* huge swap cluster is split under us */
>> +				continue;
>> +			} else		/* swp entry is obsolete ? */
>> +				break;
>
> I'm not entirely happy about -ENOTDIR being overloaded to mean this.
> Maybe we can return a new enum rather than an errno?

Can we use -ESTALE instead?  The "huge swap cluster is split under us"
means the swap entry is kind of "staled".

> Also, I'm not sure that a true/false parameter is the right approach for
> "is this a huge page".  I think we'll have usecases for swap entries which
> are both larger and smaller than PMD_SIZE.

OK.  I can change the interface to number of swap entries style to make
it more flexible.

> I was hoping to encode the swap entry size into the entry; we only need one
> extra bit to do that (no matter the size of the entry).  I detailed the
> encoding scheme here:
>
> https://plus.google.com/117536210417097546339/posts/hvctn17WUZu
>
> (let me know if that doesn't work for you; I'm not very experienced with
> this G+ thing)

The encoding method looks good.  To use it, we need to

- Encode swap entry and size into swap_entry_size
- Call function with swap_entry_size
- Decode swap_entry_size to swap entry and size

It appears that there is no real benefit?

Best Regards,
Huang, Ying
