Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BCDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFCE21873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeLSDPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 22:15:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:29982 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeLSDPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 22:15:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 19:15:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,371,1539673200"; 
   d="scan'208";a="99810468"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.10])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2018 19:15:18 -0800
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
        Zi Yan <zi.yan@cs.rutgers.edu>,
        <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V9 07/21] swap: Support PMD swap mapping when splitting huge PMD
References: <20181214062754.13723-1-ying.huang@intel.com>
        <20181214062754.13723-8-ying.huang@intel.com>
        <20181218205443.shqczdh3era6heaf@ca-dmjordan1.us.oracle.com>
Date:   Wed, 19 Dec 2018 11:15:17 +0800
In-Reply-To: <20181218205443.shqczdh3era6heaf@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Tue, 18 Dec 2018 12:54:44 -0800")
Message-ID: <87bm5iqkai.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel,

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> +Aneesh
>
> On Fri, Dec 14, 2018 at 02:27:40PM +0800, Huang Ying wrote:
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index bd2543e10938..49df3e7c96c7 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>
>> +int split_swap_cluster_map(swp_entry_t entry)
>         ...
>> +	VM_BUG_ON(!IS_ALIGNED(offset, SWAPFILE_CLUSTER));
>
> Hi Ying, I crashed on this in v6 as reported and it still dies on me now.

Sorry, I missed the original report for v6.  I should have been more careful.

>> @@ -2150,6 +2185,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>         ...
>> +	if (IS_ENABLED(CONFIG_THP_SWAP) && is_swap_pmd(old_pmd))
>> +		return __split_huge_swap_pmd(vma, haddr, pmd);
>
> Problem is 'pmd' is passed here, which has been pmdp_invalidate()ed under the
> assumption that it is not a swap entry.  pmd's pfn bits get inverted for L1TF,
> so the swap entry gets corrupted and this BUG is the first place that notices.
>
> I don't see a reason to invalidate so soon, so what about just moving the
> invalidation down, past the migration/swap checks?

Yes.  That can fix the issue.  I will fix this in that way.

Best Regards,
Huang, Ying
