Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95FAC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776EA24001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776EA24001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933183AbeGFMtT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:49:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:57888 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932569AbeGFMtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:49:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 05:49:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,316,1526367600"; 
   d="scan'208";a="69174603"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2018 05:49:05 -0700
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
Subject: Re: [PATCH -mm -v4 05/21] mm, THP, swap: Support PMD swap mapping in free_swap_and_cache()/swap_free()
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180622035151.6676-6-ying.huang@intel.com>
        <20180705183318.je4gd32awgh2tnb5@ca-dmjordan1.us.oracle.com>
Date:   Fri, 06 Jul 2018 20:49:05 +0800
In-Reply-To: <20180705183318.je4gd32awgh2tnb5@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Thu, 5 Jul 2018 11:33:18 -0700")
Message-ID: <877em8msvy.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Fri, Jun 22, 2018 at 11:51:35AM +0800, Huang, Ying wrote:
>> +static unsigned char swap_free_cluster(struct swap_info_struct *si,
>> +				       swp_entry_t entry)
> ...
>> +	/* Cluster has been split, free each swap entries in cluster */
>> +	if (!cluster_is_huge(ci)) {
>> +		unlock_cluster(ci);
>> +		for (i = 0; i < SWAPFILE_CLUSTER; i++, entry.val++) {
>> +			if (!__swap_entry_free(si, entry, 1)) {
>> +				free_entries++;
>> +				free_swap_slot(entry);
>> +			}
>> +		}
>
> Is is better on average to use __swap_entry_free_locked instead of
> __swap_entry_free here?  I'm not sure myself, just asking.
>
> As it's written, if the cluster's been split, we always take and drop the
> cluster lock 512 times, but if we don't expect to call free_swap_slot that
> often, then we could just drop and retake the cluster lock inside the innermost
> 'if' against the possibility that free_swap_slot eventually makes us take the
> cluster lock again.

Yes.  This is a good idea.  Thanks for your suggestion!  I will change
this in the next version.

Best Regards,
Huang, Ying

> ...
>> +		return !(free_entries == SWAPFILE_CLUSTER);
>
>                 return free_entries != SWAPFILE_CLUSTER;
