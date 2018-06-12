Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4CE62C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09142208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09142208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934909AbeFLBXZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 21:23:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:36981 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932893AbeFLBXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 21:23:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 18:23:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,212,1526367600"; 
   d="scan'208";a="49117070"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga006.jf.intel.com with ESMTP; 11 Jun 2018 18:23:20 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -mm -V3 03/21] mm, THP, swap: Support PMD swap mapping in swap_duplicate()
References: <20180523082625.6897-1-ying.huang@intel.com>
        <20180523082625.6897-4-ying.huang@intel.com>
        <20180611204231.ojhlyrbmda6pouxb@ca-dmjordan1.us.oracle.com>
Date:   Tue, 12 Jun 2018 09:23:19 +0800
In-Reply-To: <20180611204231.ojhlyrbmda6pouxb@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Mon, 11 Jun 2018 13:42:31 -0700")
Message-ID: <87o9ggpzlk.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel,

Thanks for your effort to review this series.

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> Hi,
>
> The series up to and including this patch doesn't build.  For this patch we
> need:
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index c6b3eab73fde..2f2d07627113 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -433,7 +433,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>                 /*
>                  * Swap entry may have been freed since our caller observed it.
>                  */
> -               err = swapcache_prepare(entry);
> +               err = swapcache_prepare(entry, false);
>                 if (err == -EEXIST) {
>                         radix_tree_preload_end();
>                         /*

Thanks for pointing this out!  Will change in the next version.

>
> On Wed, May 23, 2018 at 04:26:07PM +0800, Huang, Ying wrote:
>> @@ -3516,11 +3512,39 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
>
> Two comments about this part of __swap_duplicate as long as you're moving it to
> another function:
>
>    } else if (count || has_cache) {
>    
>    	if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)          /* #1   */
>    		count += usage;
>    	else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)     /* #2   */
>    		err = -EINVAL;
>
> #1:  __swap_duplicate_locked might use
>
>     VM_BUG_ON(usage != SWAP_HAS_CACHE && usage != 1);
>
> to document the unstated assumption that usage is 1 (otherwise count could
> overflow).

Sounds good.  Will do this.

> #2:  We've masked off SWAP_HAS_CACHE and COUNT_CONTINUED, and already checked
> for SWAP_MAP_BAD, so I think condition #2 always fails and can just be removed.

I think this is used to check some software bug.  For example,
SWAP_MAP_SHMEM will yield true here.

>> +#ifdef CONFIG_THP_SWAP
>> +static int __swap_duplicate_cluster(swp_entry_t *entry, unsigned char usage)
> ...
>> +	} else {
>> +		for (i = 0; i < SWAPFILE_CLUSTER; i++) {
>> +retry:
>> +			err = __swap_duplicate_locked(si, offset + i, 1);
>
> I guess usage is assumed to be 1 at this point (__swap_duplicate_locked makes
> the same assumption).  Maybe make this explicit with
>
> 			err = __swap_duplicate_locked(si, offset + i, usage);
>
> , use 'usage' in cluster_set_count and __swap_entry_free too, and then
> earlier have a
>
>        VM_BUG_ON(usage != SWAP_HAS_CACHE && usage != 1);
>
> ?

Yes.  I will fix this.  And we can just check it in
__swap_duplicate_locked() and all these will be covered.

>> +#else
>> +static inline int __swap_duplicate_cluster(swp_entry_t *entry,
>
> This doesn't need inline.

Why not?  This is just a one line stub.

> Not related to your changes, but while we're here, the comment with
> SWAP_HAS_CONT in swap_count() could be deleted: I don't think there ever was a
> SWAP_HAS_CONT.

Yes.  We should correct this.  Because this should go to a separate patch,
would you mind to submit a patch to fix it?

> The rest looks ok up to this point.

Thanks!

Best Regards,
Huang, Ying
