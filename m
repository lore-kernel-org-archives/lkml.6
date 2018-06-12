Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7817DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35488208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35488208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754082AbeFLDPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:15:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:31608 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751050AbeFLDPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:15:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 20:15:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="66239368"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga002.jf.intel.com with ESMTP; 11 Jun 2018 20:15:29 -0700
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
Date:   Tue, 12 Jun 2018 11:15:28 +0800
In-Reply-To: <87o9ggpzlk.fsf@yhuang-dev.intel.com> (Ying Huang's message of
        "Tue, 12 Jun 2018 09:23:19 +0800")
Message-ID: <87k1r4puen.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:
>> On Wed, May 23, 2018 at 04:26:07PM +0800, Huang, Ying wrote:
>>> @@ -3516,11 +3512,39 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
>>
>> Two comments about this part of __swap_duplicate as long as you're moving it to
>> another function:
>>
>>    } else if (count || has_cache) {
>>    
>>    	if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)          /* #1   */
>>    		count += usage;
>>    	else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)     /* #2   */
>>    		err = -EINVAL;
>>
>> #1:  __swap_duplicate_locked might use
>>
>>     VM_BUG_ON(usage != SWAP_HAS_CACHE && usage != 1);
>>
>> to document the unstated assumption that usage is 1 (otherwise count could
>> overflow).
>
> Sounds good.  Will do this.

Found usage parameter of __swap_duplicate() could be SWAP_MAP_SHMEM too.
We can improve the parameter checking.  But that appears not belong to
this series.

Best Regards,
Huang, Ying
