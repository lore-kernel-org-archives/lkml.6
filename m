Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC75C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5CE217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfBLGkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 01:40:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:54549 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfBLGkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 01:40:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 22:40:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="142668988"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.151])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2019 22:40:49 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Hugh Dickins <hughd@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>,
        "Andrea Parri" <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH -mm -V7] mm, swap: fix race between swapoff and some swap operations
References: <20190211083846.18888-1-ying.huang@intel.com>
        <20190211190646.j6pdxqirc56inbbe@ca-dmjordan1.us.oracle.com>
Date:   Tue, 12 Feb 2019 14:40:48 +0800
In-Reply-To: <20190211190646.j6pdxqirc56inbbe@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Mon, 11 Feb 2019 14:06:46 -0500")
Message-ID: <87a7j1ldan.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Mon, Feb 11, 2019 at 04:38:46PM +0800, Huang, Ying wrote:
>> +struct swap_info_struct *get_swap_device(swp_entry_t entry)
>> +{
>> +	struct swap_info_struct *si;
>> +	unsigned long type, offset;
>> +
>> +	if (!entry.val)
>> +		goto out;
>
>> +	type = swp_type(entry);
>> +	si = swap_type_to_swap_info(type);
>
> These lines can be collapsed into swp_swap_info if you want.

Yes.  I can use that function to reduce another line from the patch.
Thanks!  Will do that.

>> +	if (!si)
>> +		goto bad_nofile;
>> +
>> +	preempt_disable();
>> +	if (!(si->flags & SWP_VALID))
>> +		goto unlock_out;
>
> After Hugh alluded to barriers, it seems the read of SWP_VALID could be
> reordered with the write in preempt_disable at runtime.  Without smp_mb()
> between the two, couldn't this happen, however unlikely a race it is?
>
> CPU0                                CPU1
>
> __swap_duplicate()
>     get_swap_device()
>         // sees SWP_VALID set
>                                    swapoff
>                                        p->flags &= ~SWP_VALID;
>                                        spin_unlock(&p->lock); // pair w/ smp_mb
>                                        ...
>                                        stop_machine(...)
>                                        p->swap_map = NULL;
>         preempt_disable()
>     read NULL p->swap_map

Andrea has helped to explain this.

Best Regards,
Huang, Ying
