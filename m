Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B21DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B57B20878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B57B20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeGJHOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:14:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:18769 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeGJHOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:14:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 00:14:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,333,1526367600"; 
   d="scan'208";a="63538422"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2018 00:13:58 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
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
Date:   Tue, 10 Jul 2018 15:13:58 +0800
In-Reply-To: <49178f48-6635-353c-678d-3db436d3f9c3@linux.intel.com> (Dave
        Hansen's message of "Mon, 9 Jul 2018 10:19:25 -0700")
Message-ID: <87y3ejh8ax.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

> I'm seeing a pattern here.
>
> old code:
>
> foo()
> {
> 	do_swap_something()
> }
>
> new code:
>
> foo(bool cluster)
> {
> 	if (cluster)
> 		do_swap_cluster_something();
> 	else
> 		do_swap_something();
> }
>
> That make me fear that we have:
> 1. Created a new, wholly untested code path
> 2. Created two places to patch bugs
> 3. Are not reusing code when possible
>
> The code non-resuse was, and continues to be, IMNHO, one of the largest
> sources of bugs with the original THP implementation.  It might be
> infeasible to do here, but let's at least give it as much of a go as we can.

I totally agree that we should unify the code path for huge and normal
page/swap if possible.  One concern is code size for !CONFIG_THP_SWAP.
The original method is good for that.  The new method may introduce some
huge swap related code that is hard to be eliminated for
!CONFIG_THP_SWAP.  Andrew Morton pointed this out for the patchset of
the first step of the THP swap optimization.

This may be mitigated at least partly via,

`
#ifdef CONFIG_THP_SWAP
#define nr_swap_entries(nr)          (nr)
#else
#define nr_swap_entries(nr)          1
#endif

void do_something(swp_entry_t entry, int __nr_entries)
{
        int i, nr_entries = nr_swap_entries(__nr_entries);

        if (nr_entries = SWAPFILE_CLUSTER)
                ; /* huge swap specific */
        else
                ; /* normal swap specific */

        for (i = 0; i < nr_entries; i++) {
                ; /* do something for each entry */
        }

        /* ... */
}
`

and rely on compiler to do the dirty work for us if possible.

Hi, Andrew,

What do you think about this?

> Can I ask that you take another round through this set and:
>
> 1. Consolidate code refactoring into separate patches

Sure.

> 2. Add comments to code, and avoid doing it solely in changelogs

Sure.

> 3. Make an effort to share more code between the old code and new
>    code.  Where code can not be shared, call that out in the changelog.

Will do that if we resolve the code size concern.

> This is a *really* hard-to-review set at the moment.  Doing those things
> will make it much easier to review and hopefully give us more
> maintainable code going forward.
>
> My apologies for not having done this review sooner.

Thanks a lot for your comments!

Best Regards,
Huang, Ying
