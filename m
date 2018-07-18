Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC32FECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6020E20657
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6020E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbeGRDpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:45:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:37826 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731193AbeGRDpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:45:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 20:09:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,368,1526367600"; 
   d="scan'208";a="73248859"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2018 20:09:26 -0700
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
Subject: Re: [PATCH v2 1/7] swap: Add comments to lock_cluster_or_swap_info()
References: <20180717005556.29758-1-ying.huang@intel.com>
        <20180717005556.29758-2-ying.huang@intel.com>
        <0b478120-1af2-1251-361a-58c30b258ca3@linux.intel.com>
Date:   Wed, 18 Jul 2018 11:09:25 +0800
In-Reply-To: <0b478120-1af2-1251-361a-58c30b258ca3@linux.intel.com> (Dave
        Hansen's message of "Tue, 17 Jul 2018 11:27:27 -0700")
Message-ID: <87bmb5gryy.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

> On 07/16/2018 05:55 PM, Huang, Ying wrote:
>> +/*
>> + * For non-HDD swap devices, the fine grained cluster lock is used to
>> + * protect si->swap_map.  But cluster and cluster locks isn't
>> + * available for HDD, so coarse grained si->lock will be used instead
>> + * for that.
>> + */
>>  static inline struct swap_cluster_info *lock_cluster_or_swap_info(
>>  	struct swap_info_struct *si,
>>  	unsigned long offset)
>
> This nomenclature is not consistent with the rest of the file.  We call
> a "non-HDD" device an "ssd" absolutely everywhere else in the file.  Why
> are you calling it a non-HDD here?  (fwiw, HDD _barely_ hits my acronym
> cache anyway).
>
> How about this?
>
> /*
>  * Determine the locking method in use for this device.  Return
>  * swap_cluster_info if SSD-style cluster-based locking is in place.
>  */
> static inline struct swap_cluster_info *lock_cluster_or_swap_info(
>         struct swap_info_struct *si,
>         unsigned long offset)
> {
>         struct swap_cluster_info *ci;
>
> 	/* Try to use fine-grained SSD-style locking if available: */
>         ci = lock_cluster(si, offset);
>
> 	/* Otherwise, fall back to traditional, coarse locking: */
>         if (!ci)
>                 spin_lock(&si->lock);
>
>         return ci;
> }

This is better than my one, will use this.  Thanks!

> Which reminds me?  Why do we even bother having two locking models?

Because si->cluster_info is NULL for non-SSD, so we cannot use cluster
lock.

About why not use struct swap_cluster_info for non-SSD?  Per my
understanding, struct swap_cluster_info is optimized for SSD.
Especially it assumes seeking is cheap.  So different free swap slot
scanning policy is used for SSD and non-SSD.

Best Regards,
Huang, Ying
