Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C9CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2488220873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2488220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754366AbeGJGxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:53:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:17900 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751017AbeGJGxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:53:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 23:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,333,1526367600"; 
   d="scan'208";a="65628110"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2018 23:53:35 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Shaohua Li" <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 04/21] mm, THP, swap: Support PMD swap mapping in swapcache_free_cluster()
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180622035151.6676-5-ying.huang@intel.com>
        <dd7b3dd7-9e10-4b9f-b931-915298bfd627@linux.intel.com>
Date:   Tue, 10 Jul 2018 14:53:35 +0800
In-Reply-To: <dd7b3dd7-9e10-4b9f-b931-915298bfd627@linux.intel.com> (Dave
        Hansen's message of "Mon, 9 Jul 2018 10:11:57 -0700")
Message-ID: <874lh7intc.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

>> +#ifdef CONFIG_THP_SWAP
>> +static inline int cluster_swapcount(struct swap_cluster_info *ci)
>> +{
>> +	if (!ci || !cluster_is_huge(ci))
>> +		return 0;
>> +
>> +	return cluster_count(ci) - SWAPFILE_CLUSTER;
>> +}
>> +#else
>> +#define cluster_swapcount(ci)			0
>> +#endif
>
> Dumb questions, round 2:  On a CONFIG_THP_SWAP=n build, presumably,
> cluster_is_huge()=0 always, so cluster_swapout() always returns 0.  Right?
>
> So, why the #ifdef?

#ifdef here is to reduce the code size for !CONFIG_THP_SWAP.

>>  /*
>>   * It's possible scan_swap_map() uses a free cluster in the middle of free
>>   * cluster list. Avoiding such abuse to avoid list corruption.
>> @@ -905,6 +917,7 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>>  	struct swap_cluster_info *ci;
>>  
>>  	ci = lock_cluster(si, offset);
>> +	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
>>  	cluster_set_count_flag(ci, 0, 0);
>>  	free_cluster(si, idx);
>>  	unlock_cluster(ci);
>
> This is another case of gloriously comment-free code, but stuff that
> _was_ covered in the changelog.  I'd much rather have code comments than
> changelog comments.  Could we fix that?
>
> I'm generally finding it quite hard to review this because I keep having
> to refer back to the changelog to see if what you are doing matches what
> you said you were doing.

Sure.  Will fix this.

>> @@ -1288,24 +1301,30 @@ static void swapcache_free_cluster(swp_entry_t entry)
>>  
>>  	ci = lock_cluster(si, offset);
>>  	VM_BUG_ON(!cluster_is_huge(ci));
>> +	VM_BUG_ON(!is_cluster_offset(offset));
>> +	VM_BUG_ON(cluster_count(ci) < SWAPFILE_CLUSTER);
>>  	map = si->swap_map + offset;
>> -	for (i = 0; i < SWAPFILE_CLUSTER; i++) {
>> -		val = map[i];
>> -		VM_BUG_ON(!(val & SWAP_HAS_CACHE));
>> -		if (val == SWAP_HAS_CACHE)
>> -			free_entries++;
>> +	if (!cluster_swapcount(ci)) {
>> +		for (i = 0; i < SWAPFILE_CLUSTER; i++) {
>> +			val = map[i];
>> +			VM_BUG_ON(!(val & SWAP_HAS_CACHE));
>> +			if (val == SWAP_HAS_CACHE)
>> +				free_entries++;
>> +		}
>> +		if (free_entries != SWAPFILE_CLUSTER)
>> +			cluster_clear_huge(ci);
>>  	}
>
> Also, I'll point out that cluster_swapcount() continues the horrific
> naming of cluster_couunt(), not saying what the count is *of*.  The
> return value doesn't help much:
>
> 	return cluster_count(ci) - SWAPFILE_CLUSTER;

We have page_swapcount() for page, swp_swapcount() for swap entry.
cluster_swapcount() tries to mimic them for swap cluster.  But I am not
good at naming in general.  What's your suggestion?

Best Regards,
Huang, Ying
