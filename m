Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD642ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709182075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709182075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbeGREBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:01:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:39758 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725721AbeGREBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:01:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 20:26:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,368,1526367600"; 
   d="scan'208";a="67892378"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jul 2018 20:25:57 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/7] mm/swapfile.c: Replace some #ifdef with IS_ENABLED()
References: <20180717005556.29758-1-ying.huang@intel.com>
        <20180717005556.29758-3-ying.huang@intel.com>
        <10878744-8db0-1d2c-e899-7c132d78e153@linux.intel.com>
Date:   Wed, 18 Jul 2018 11:25:56 +0800
In-Reply-To: <10878744-8db0-1d2c-e899-7c132d78e153@linux.intel.com> (Dave
        Hansen's message of "Tue, 17 Jul 2018 11:32:48 -0700")
Message-ID: <877eltgr7f.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

>> @@ -878,6 +877,11 @@ static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
>>  	unsigned long offset, i;
>>  	unsigned char *map;
>>  
>> +	if (!IS_ENABLED(CONFIG_THP_SWAP)) {
>> +		VM_WARN_ON_ONCE(1);
>> +		return 0;
>> +	}
>
> I see you seized the opportunity to keep this code gloriously
> unencumbered by pesky comments.  This seems like a time when you might
> have slipped up and been temped to add a comment or two.  Guess not. :)
>
> Seriously, though, does it hurt us to add a comment or two to say
> something like:
>
> 	/*
> 	 * Should not even be attempting cluster allocations when
> 	 * huge page swap is disabled.  Warn and fail the allocation.
> 	 */
> 	if (!IS_ENABLED(CONFIG_THP_SWAP)) {
> 		VM_WARN_ON_ONCE(1);
> 		return 0;
> 	}

I totally agree with you that we should add more comments for THP swap
to improve the code readability.  As for this specific case,
VM_WARN_ON_ONCE() here is just to capture some programming error during
development.  Do we really need comments here?

I will try to add more comments for other places in code regardless this
one.

Best Regards,
Huang, Ying
