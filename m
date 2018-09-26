Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514C5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16005214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16005214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeIZTI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:08:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:8058 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbeIZTI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:08:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 05:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="77425141"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.13])
  by orsmga006.jf.intel.com with ESMTP; 26 Sep 2018 05:56:00 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -V5 RESEND 03/21] swap: Support PMD swap mapping in swap_duplicate()
References: <20180925071348.31458-1-ying.huang@intel.com>
        <20180925071348.31458-4-ying.huang@intel.com>
        <20180925191953.4ped5ki7u3ymafmd@ca-dmjordan1.us.oracle.com>
Date:   Wed, 26 Sep 2018 20:55:59 +0800
In-Reply-To: <20180925191953.4ped5ki7u3ymafmd@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Tue, 25 Sep 2018 12:19:53 -0700")
Message-ID: <874lecifj4.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Tue, Sep 25, 2018 at 03:13:30PM +0800, Huang Ying wrote:
>> @@ -3487,35 +3521,66 @@ static int __swap_duplicate_locked(struct swap_info_struct *p,
>>  }
>>  
>>  /*
>> - * Verify that a swap entry is valid and increment its swap map count.
>> + * Verify that the swap entries from *entry is valid and increment their
>> + * PMD/PTE swap mapping count.
>>   *
>>   * Returns error code in following case.
>>   * - success -> 0
>>   * - swp_entry is invalid -> EINVAL
>> - * - swp_entry is migration entry -> EINVAL
>
> I'm assuming it wasn't possible to hit this error before this patch, and you're
> just removing it now since you're in the area?

Yes.

>>   * - swap-cache reference is requested but there is already one. -> EEXIST
>>   * - swap-cache reference is requested but the entry is not used. -> ENOENT
>>   * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
>> + * - the huge swap cluster has been split. -> ENOTDIR
>
> Strangely intuitive choice of error code :)

Thanks!  It doesn't match the error exactly, but I have no better choice
now.  Matthew Wilcox have suggested to use an swap specific enum
instead.  I think that is good in general, but we need only one extra
error code, and we need to change the interface of several swap
functions.  So I think that should be in a separate patchset if
necessary.

>>  /*
>>   * Increase reference count of swap entry by 1.
>> - * Returns 0 for success, or -ENOMEM if a swap_count_continuation is required
>> - * but could not be atomically allocated.  Returns 0, just as if it succeeded,
>> - * if __swap_duplicate() fails for another reason (-EINVAL or -ENOENT), which
>> - * might occur if a page table entry has got corrupted.
>> + *
>> + * Return error code in following case.
>> + * - success -> 0
>> + * - swap_count_continuation is required but could not be atomically allocated.
>> + *   *entry is used to return swap entry to call add_swap_count_continuation().
>> + *								      -> ENOMEM
>> + * - otherwise same as __swap_duplicate()
>>   */
>> -int swap_duplicate(swp_entry_t entry)
>> +int swap_duplicate(swp_entry_t *entry, int entry_size)
>>  {
>>  	int err = 0;
>>  
>> -	while (!err && __swap_duplicate(entry, 1) == -ENOMEM)
>> -		err = add_swap_count_continuation(entry, GFP_ATOMIC);
>> +	while (!err &&
>> +	       (err = __swap_duplicate(entry, entry_size, 1)) == -ENOMEM)
>> +		err = add_swap_count_continuation(*entry, GFP_ATOMIC);
>>  	return err;
>
> Now we're returning any error we get from __swap_duplicate, apparently to
> accommodate ENOTDIR later in the series, which is a change from the behavior
> introduced in 570a335b8e22 ("swap_info: swap count continuations").  This might
> belong in a separate patch given its potential for side effects.

I have checked all the calls of the function and found there will be no
bad effect.  Do you have any side effect?

> Although, I don't understand why 570a335b8e22 ignored errors other than -ENOMEM
> when both swap_duplicate callers _seem_ from a quick read to be able to respond
> gracefully to any error.

Before 570a335b8e22, all errors are ignored in swap_duplicate() (its
type is void).  If my understanding were correct, all errors except
-ENOMEM are impossible before changes in this patchset.  So they are
ignored.

Best Regards,
Huang, Ying
