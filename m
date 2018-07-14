Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2C8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2E6208CE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2E6208CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbeGNNMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 09:12:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:8251 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730897AbeGNNMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 09:12:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2018 05:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,352,1526367600"; 
   d="scan'208";a="215988230"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga004.jf.intel.com with ESMTP; 14 Jul 2018 05:53:13 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 3/6] swap: Unify normal/huge code path in swap_page_trans_huge_swapped()
References: <20180712233636.20629-1-ying.huang@intel.com>
        <20180712233636.20629-4-ying.huang@intel.com>
        <20180713201557.bjt4tj26nisgdmmi@ca-dmjordan1.us.oracle.com>
Date:   Sat, 14 Jul 2018 20:53:12 +0800
In-Reply-To: <20180713201557.bjt4tj26nisgdmmi@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Fri, 13 Jul 2018 13:15:57 -0700")
Message-ID: <87efg6dlmv.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Fri, Jul 13, 2018 at 07:36:33AM +0800, Huang, Ying wrote:
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 75c84aa763a3..160f78072667 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -270,7 +270,10 @@ static inline void cluster_set_null(struct swap_cluster_info *info)
>>  
>>  static inline bool cluster_is_huge(struct swap_cluster_info *info)
>>  {
>> -	return info->flags & CLUSTER_FLAG_HUGE;
>> +	if (IS_ENABLED(CONFIG_THP_SWAP))
>> +		return info->flags & CLUSTER_FLAG_HUGE;
>> +	else
>> +		return false;
>>  }
>>  
>>  static inline void cluster_clear_huge(struct swap_cluster_info *info)
>> @@ -1489,9 +1492,6 @@ static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
>>  	int i;
>>  	bool ret = false;
>>  
>> -	if (!IS_ENABLED(CONFIG_THP_SWAP))
>> -		return swap_swapcount(si, entry) != 0;
>
> This tests the value returned from swap_count,
>
>> -
>>  	ci = lock_cluster_or_swap_info(si, offset);
>>  	if (!ci || !cluster_is_huge(ci)) {
>>  		if (map[roffset] != SWAP_HAS_CACHE)
>
> and now we're testing
>
>                     map[roffset] != SWAP_HAS_CACHE
>
> instead.  The two seem to mean the same thing here, since the swap slot hasn't
> been freed to the global pool and so can't be 0, but it might be better for
> consistency and clarity to use swap_count here, and a few lines down too
>
>         for (i = 0; i < SWAPFILE_CLUSTER; i++) {                                     
>                 if (map[offset + i] != SWAP_HAS_CACHE) {                             
>
> since swap_count seems to be used everywhere else for this.

Yes.  swap_count() looks better here.  Will change this.

Best Regards,
Huang, Ying
