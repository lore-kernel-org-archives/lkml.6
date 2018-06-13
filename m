Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 38403C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6925208AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6925208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935088AbeFMB06 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:26:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:1172 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754407AbeFMB05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:26:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 18:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,217,1526367600"; 
   d="scan'208";a="63589137"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2018 18:26:54 -0700
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
        <87o9ggpzlk.fsf@yhuang-dev.intel.com>
        <20180612214402.cpjmcyjkkwtkgjyu@ca-dmjordan1.us.oracle.com>
Date:   Wed, 13 Jun 2018 09:26:54 +0800
In-Reply-To: <20180612214402.cpjmcyjkkwtkgjyu@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Tue, 12 Jun 2018 14:44:02 -0700")
Message-ID: <87vaano4rl.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Tue, Jun 12, 2018 at 09:23:19AM +0800, Huang, Ying wrote:
>> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
>> >> +#else
>> >> +static inline int __swap_duplicate_cluster(swp_entry_t *entry,
>> >
>> > This doesn't need inline.
>> 
>> Why not?  This is just a one line stub.
>
> Forgot to respond to this.  The compiler will likely choose to optimize out
> calls to an empty function like this.  Checking, this is indeed what it does in
> this case on my machine, with or without inline.

Yes.  I believe a decent compiler will inline the function in any way.
And it does no harm to keep "inline" too, Yes?

> By the way, when building without CONFIG_THP_SWAP, we get
>
>   linux/mm/swapfile.c:933:13: warning: ‘__swap_free_cluster’ defined but not used [-Wunused-function]
>    static void __swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>                ^~~~~~~~~~~~~~~~~~~

Thanks!  I will fix this.  Don't know why 0-Day didn't catch this.

Best Regards,
Huang, Ying
