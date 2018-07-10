Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48600C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22182083B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22182083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeGJHuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:50:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:20189 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeGJHuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:50:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 00:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,333,1526367600"; 
   d="scan'208";a="55346431"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga007.jf.intel.com with ESMTP; 10 Jul 2018 00:49:58 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
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
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -mm -v4 14/21] mm, cgroup, THP, swap: Support to move swap account for PMD swap mapping
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180622035151.6676-15-ying.huang@intel.com>
        <20180709172037.254zyuadep2hj5po@ca-dmjordan1.us.oracle.com>
Date:   Tue, 10 Jul 2018 15:49:58 +0800
In-Reply-To: <20180709172037.254zyuadep2hj5po@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Mon, 9 Jul 2018 10:20:37 -0700")
Message-ID: <87tvp7h6mx.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Fri, Jun 22, 2018 at 11:51:44AM +0800, Huang, Ying wrote:
>> Because there is no way to prevent a huge swap cluster from being
>> split except when it has SWAP_HAS_CACHE flag set.
>
> What about making get_mctgt_type_thp take the cluster lock?  That function
> would be the first lock_cluster user outside of swapfile.c, but it would
> serialize with split_swap_cluster.
>
>> It is possible for
>> the huge swap cluster to be split and the charge for the swap slots
>> inside to be changed, after we check the PMD swap mapping and the huge
>> swap cluster before we commit the charge moving.  But the race window
>> is so small, that we will just ignore the race.
>
> Moving the charges is a slow path, so can't we just be correct here and not
> leak?

Check the code and thought about this again, found the race may not
exist.  Because the PMD is locked when get_mctgt_type_thp() is called
until charge is completed for the PMD.  So the charge of the huge swap
cluster cannot be changed at the same time even if the huge swap cluster
is split by other processes.  Right?

Will update the comments for this.

Best Regards,
Huang, Ying
