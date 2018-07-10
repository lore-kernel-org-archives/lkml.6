Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E94C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6249020873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6249020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933388AbeGJBJL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:09:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:24917 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933129AbeGJBJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:09:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 18:09:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,332,1526367600"; 
   d="scan'208";a="214679233"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga004.jf.intel.com with ESMTP; 09 Jul 2018 18:08:43 -0700
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
Subject: Re: [PATCH -mm -v4 01/21] mm, THP, swap: Enable PMD swap operations for CONFIG_THP_SWAP
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180622035151.6676-2-ying.huang@intel.com>
        <11735e2e-781f-492f-7a1a-71b91e0876dc@linux.intel.com>
Date:   Tue, 10 Jul 2018 09:08:42 +0800
In-Reply-To: <11735e2e-781f-492f-7a1a-71b91e0876dc@linux.intel.com> (Dave
        Hansen's message of "Mon, 9 Jul 2018 08:59:20 -0700")
Message-ID: <871scbkicl.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

> On 06/21/2018 08:51 PM, Huang, Ying wrote:
>> From: Huang Ying <ying.huang@intel.com>
>> 
>> Previously, the PMD swap operations are only enabled for
>> CONFIG_ARCH_ENABLE_THP_MIGRATION.  Because they are only used by the
>> THP migration support.  We will support PMD swap mapping to the huge
>> swap cluster and swapin the THP as a whole.  That will be enabled via
>> CONFIG_THP_SWAP and needs these PMD swap operations.  So enable the
>> PMD swap operations for CONFIG_THP_SWAP too.
>
> This commit message kinda skirts around the real reasons for this patch.
>  Shouldn't we just say something like:
>
> 	Currently, "swap entries" in the page tables are used for a
> 	number of things outside of actual swap, like page migration.
> 	We support THP/PMD "swap entries" for page migration currently
> 	and the functions behind this are tied to page migration's
> 	config option (CONFIG_ARCH_ENABLE_THP_MIGRATION).
>
> 	But, we also need them for THP swap.
> 	...
>
> It would also be nice to explain a bit why you are moving code around.

This looks much better than my original words.  Thanks for help!

> Would this look any better if we made a Kconfig option:
>
> 	config HAVE_THP_SWAP_ENTRIES
> 		def_bool n
> 		# "Swap entries" in the page tables are used
> 		# both for migration and actual swap.
> 		depends on THP_SWAP || ARCH_ENABLE_THP_MIGRATION
>
> You logically talked about this need for PMD swap operations in your
> commit message, so I think it makes sense to codify that in a single
> place where it can be coherently explained.

Because both you and Dan thinks it's better to add new Kconfig option, I
will do that.

Best Regards,
Huang, Ying
