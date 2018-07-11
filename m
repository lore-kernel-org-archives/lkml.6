Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B27C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825B0208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825B0208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732360AbeGKBBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:01:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:8207 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732263AbeGKBBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:01:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 17:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,336,1526367600"; 
   d="scan'208";a="56696218"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2018 17:59:40 -0700
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
Subject: Re: [PATCH -mm -v4 03/21] mm, THP, swap: Support PMD swap mapping in swap_duplicate()
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180622035151.6676-4-ying.huang@intel.com>
        <92b86ab6-6f51-97b0-337c-b7e98a30b6cb@linux.intel.com>
        <878t6jio7x.fsf@yhuang-dev.intel.com>
        <1b8a9fa8-79a3-c515-26b1-cea6d9eb9aeb@linux.intel.com>
Date:   Wed, 11 Jul 2018 08:59:40 +0800
In-Reply-To: <1b8a9fa8-79a3-c515-26b1-cea6d9eb9aeb@linux.intel.com> (Dave
        Hansen's message of "Tue, 10 Jul 2018 06:50:33 -0700")
Message-ID: <87pnzuh9j7.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

>> Yes.  Boolean parameter isn't good at most times.  Matthew Wilcox
>> suggested to use
>> 
>>         swap_duplicate(&entry, HPAGE_PMD_NR);
>> 
>> vs.
>> 
>>         swap_duplicate(&entry, 1);
>> 
>> He thinks this makes the interface more flexible to support other swap
>> entry size in the future.  What do you think about that?
>
> That looks great to me too.
>
>>>>  		if (likely(!non_swap_entry(entry))) {
>>>> -			if (swap_duplicate(entry) < 0)
>>>> +			if (swap_duplicate(&entry, false) < 0)
>>>>  				return entry.val;
>>>>  
>>>>  			/* make sure dst_mm is on swapoff's mmlist. */
>>>
>>> I'll also point out that in a multi-hundred-line patch, adding arguments
>>> to a existing function would not be something I'd try to include in the
>>> patch.  I'd break it out separately unless absolutely necessary.
>> 
>> You mean add another patch, which only adds arguments to the function,
>> but not change the body of the function?
>
> Yes.  Or, just add the non-THP-swap version first.

OK, will do this.

Best Regards,
Huang, Ying
