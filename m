Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EB1ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 04:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846C4208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 04:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846C4208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbeGNEZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 00:25:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:34727 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbeGNEZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 00:25:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 21:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,350,1526367600"; 
   d="scan'208";a="57576891"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by orsmga006.jf.intel.com with ESMTP; 13 Jul 2018 21:07:44 -0700
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
Subject: Re: [PATCH 1/6] swap: Add comments to lock_cluster_or_swap_info()
References: <20180712233636.20629-1-ying.huang@intel.com>
        <20180712233636.20629-2-ying.huang@intel.com>
        <3c3a4dce-980d-0405-d269-1da9e62b1344@linux.intel.com>
Date:   Sat, 14 Jul 2018 12:07:43 +0800
In-Reply-To: <3c3a4dce-980d-0405-d269-1da9e62b1344@linux.intel.com> (Dave
        Hansen's message of "Fri, 13 Jul 2018 03:48:28 -0700")
Message-ID: <87in5ie9yo.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

>> +/*
>> + * At most times, fine grained cluster lock is sufficient to protect
>
> Can we call out those times, please?

To protect si->swap_map[], if HDD, si->lock is used, otherwise cluster
lock is used.  "at most times" is ambiguous here, I will fix it.

>> + * the operations on sis->swap_map.  
>
> Please be careful with the naming.  You can call it 'si' because that's
> what the function argument is named.  Or, swap_info_struct because
> that's the struct name.  Calling it 'sis' is a bit sloppy, no?
>
>> 					No need to acquire gross grained
>
> "coarse" is a conventional antonym for "fine".

Sorry for my poor English, will change this.

>> + * sis->lock.  But cluster and cluster lock isn't available for HDD,
>> + * so sis->lock will be instead for them.
>> + */
>>  static inline struct swap_cluster_info *lock_cluster_or_swap_info(
>>  	struct swap_info_struct *si,
>>  	unsigned long offset)
>
> What I already knew was: there are two locks.  We use one sometimes and
> the other at other times.
>
> What I don't know is why there are two locks, and the heuristics why we
> choose between them.  This comment doesn't help explain the things I
> don't know.

cluster lock is used to protect fields of struct swap_cluster_info, and
si->swap_map[], this is described in comments of struct
swap_cluster_info.  si->lock is used to protect other fields of si.  If
two locks need to be held, hold si->lock first.  This is for non-HDD.
For HDD, there are no cluster, so si->lock is used to protect
si->swap_map[].

Best Regards,
Huang, Ying
