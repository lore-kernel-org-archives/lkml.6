Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B286CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656FD208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656FD208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbeGKBaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:30:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:38325 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732304AbeGKBaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:30:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 18:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,336,1526367600"; 
   d="scan'208";a="56702276"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2018 18:28:14 -0700
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
Subject: Re: [PATCH -mm -v4 05/21] mm, THP, swap: Support PMD swap mapping in free_swap_and_cache()/swap_free()
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180622035151.6676-6-ying.huang@intel.com>
        <49178f48-6635-353c-678d-3db436d3f9c3@linux.intel.com>
        <87y3ejh8ax.fsf@yhuang-dev.intel.com>
        <836c95a7-5f03-6d9e-6f0a-839b5fb8ba99@linux.intel.com>
Date:   Wed, 11 Jul 2018 09:28:13 +0800
In-Reply-To: <836c95a7-5f03-6d9e-6f0a-839b5fb8ba99@linux.intel.com> (Dave
        Hansen's message of "Tue, 10 Jul 2018 07:07:39 -0700")
Message-ID: <87h8l6h87m.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

> On 07/10/2018 12:13 AM, Huang, Ying wrote:
>> Dave Hansen <dave.hansen@linux.intel.com> writes:
>>> The code non-resuse was, and continues to be, IMNHO, one of the largest
>>> sources of bugs with the original THP implementation.  It might be
>>> infeasible to do here, but let's at least give it as much of a go as we can.
>> 
>> I totally agree that we should unify the code path for huge and normal
>> page/swap if possible.  One concern is code size for !CONFIG_THP_SWAP.
>
> I've honestly never heard that as an argument before.  In general, our
> .c files implement *full* functionality: the most complex case.  The
> headers #ifdef that functionality down because of our .config or
> architecture.
>
> The thing that matters here is debugging and reviewing the _complicated_
> case, IMNHO.

I agree with your point here.  I will try it and measure the code size
change too.

>> The original method is good for that.  The new method may introduce some
>> huge swap related code that is hard to be eliminated for
>> !CONFIG_THP_SWAP.  Andrew Morton pointed this out for the patchset of
>> the first step of the THP swap optimization.
>> 
>> This may be mitigated at least partly via,
>> 
>> `
>> #ifdef CONFIG_THP_SWAP
>> #define nr_swap_entries(nr)          (nr)
>> #else
>> #define nr_swap_entries(nr)          1
>> #endif
>> 
>> void do_something(swp_entry_t entry, int __nr_entries)
>> {
>>         int i, nr_entries = nr_swap_entries(__nr_entries);
>> 
>>         if (nr_entries = SWAPFILE_CLUSTER)
>>                 ; /* huge swap specific */
>>         else
>>                 ; /* normal swap specific */
>> 
>>         for (i = 0; i < nr_entries; i++) {
>>                 ; /* do something for each entry */
>>         }
>> 
>>         /* ... */
>> }
>> `
>
> While that isn't perfect, it's better than the current state of things.
>
> While you are refactoring things, I think you also need to take a good
> look at roughly chopping this series in half by finding another stopping
> point.  You've done a great job so far of trickling this functionality
> in so far, but 21 patches is quite a bit, and the set is only going to
> get larger.

Yes.  The patchset is too large.  I will try to reduce it if possible.
At least [21/21] can be separated.  [02/21] may be sent separately
too.  Other parts are hard, THP swapin and creating/supporting PMD swap
mapping need to be in one patchset.

Best Regards,
Huang, Ying
