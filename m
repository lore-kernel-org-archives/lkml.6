Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00326C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CD2246DE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CD2246DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933138AbeGDCZA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:25:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:50129 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932853AbeGDCY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:24:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 19:24:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="68474445"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jul 2018 19:24:46 -0700
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
Subject: Re: [PATCH -mm -v4 08/21] mm, THP, swap: Support to read a huge swap cluster for swapin a THP
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180622035151.6676-9-ying.huang@intel.com>
        <20180704001235.w7xexi3jp6ostas5@ca-dmjordan1.us.oracle.com>
Date:   Wed, 04 Jul 2018 10:24:46 +0800
In-Reply-To: <20180704001235.w7xexi3jp6ostas5@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Tue, 3 Jul 2018 17:12:35 -0700")
Message-ID: <874lhfvitt.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Fri, Jun 22, 2018 at 11:51:38AM +0800, Huang, Ying wrote:
>> @@ -411,14 +414,32 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
> ...
>> +			if (thp_swap_supported() && huge_cluster) {
>> +				gfp_t gfp = alloc_hugepage_direct_gfpmask(vma);
>> +
>> +				new_page = alloc_hugepage_vma(gfp, vma,
>> +						addr, HPAGE_PMD_ORDER);
>
> When allocating a huge page, we ignore the gfp_mask argument.
>
> That doesn't matter right now since AFAICT we're not losing any flags: gfp_mask
> from existing callers of __read_swap_cache_async seems to always be a subset of
> GFP_HIGHUSER_MOVABLE and alloc_hugepage_direct_gfpmask always returns a
> superset of that.
>
> But maybe we should warn here in case we end up violating a restriction from a
> future caller.  Something like this?:
>
>> +				gfp_t gfp = alloc_hugepage_direct_gfpmask(vma);
>                                 VM_WARN_ONCE((gfp | gfp_mask) != gfp,
> 					     "ignoring gfp_mask bits");

This looks good!  Thanks!  Will add this.

Best Regards,
Huang, Ying
