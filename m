Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF85DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2E7218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfB0BNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:13:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:43123 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbfB0BNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:13:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2019 17:13:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,417,1544515200"; 
   d="scan'208";a="129624334"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Feb 2019 17:13:14 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH -mm -V8] mm, swap: fix race between swapoff and some swap operations
References: <20190218070142.5105-1-ying.huang@intel.com>
        <87mumjt57i.fsf@yhuang-dev.intel.com>
        <20190226230729.bz2ukzlub3rbdoqp@ca-dmjordan1.us.oracle.com>
Date:   Wed, 27 Feb 2019 09:13:14 +0800
In-Reply-To: <20190226230729.bz2ukzlub3rbdoqp@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Tue, 26 Feb 2019 18:07:29 -0500")
Message-ID: <87imx6rq39.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Tue, Feb 26, 2019 at 02:49:05PM +0800, Huang, Ying wrote:
>> Do you have time to take a look at this patch?
>
> Hi Ying, is this handling all places where swapoff might cause a task to read
> invalid data?  For example, why don't other reads of swap_map (for example
> swp_swapcount, page_swapcount, swap_entry_free) need to be synchronized like
> this?

I have checked these places.  They are safe because there are some locks
(like page lock, page table lock, etc.) held to prevent swapoff.  I
found another place in the kernel that is unsafe: the mincore.  I have a
patch for that and will post it (in fact again) after this one is
merged.

Best Regards,
Huang, Ying
