Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCF8C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BDC2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BDC2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeI2HQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 03:16:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:1700 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbeI2HQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 03:16:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 17:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,317,1534834800"; 
   d="scan'208";a="266925073"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.13])
  by fmsmga005.fm.intel.com with ESMTP; 28 Sep 2018 17:50:29 -0700
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
        <874lecifj4.fsf@yhuang-dev.intel.com>
        <20180926145145.6xp2kxpngyd54f6i@ca-dmjordan1.us.oracle.com>
        <87r2hfhger.fsf@yhuang-dev.intel.com>
        <20180927211238.ly3e7cyvfu3rswcv@ca-dmjordan1.us.oracle.com>
        <87lg7mf30o.fsf@yhuang-dev.intel.com>
        <20180928213224.tjff2rtfmxmnz5nq@ca-dmjordan1.us.oracle.com>
Date:   Sat, 29 Sep 2018 08:50:29 +0800
In-Reply-To: <20180928213224.tjff2rtfmxmnz5nq@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Fri, 28 Sep 2018 14:32:24 -0700")
Message-ID: <877ej5f7oq.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Fri, Sep 28, 2018 at 04:19:03PM +0800, Huang, Ying wrote:
>> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
>> > One way is to change
>> > copy_one_pte's return to int so we can just pass the error code back to
>> > copy_pte_range so it knows whether to try adding the continuation.
>> 
>> There may be even more problems.  After add_swap_count_continuation(),
>> copy_one_pte() will be retried, and the CPU may hang with dead loop.
>
> That's true, it would do that.
>
>> But before the changes in this patchset, the behavior is,
>> __swap_duplicate() return an error that isn't -ENOMEM, such as -EEXIST.
>> Then copy_one_pte() would thought the operation has been done
>> successfully, and go to call set_pte_at().  This will cause the system
>> state become inconsistent, and the system may panic or hang somewhere
>> later.
>> 
>> So per my understanding, if we thought page table corruption isn't a
>> real problem (that is, __swap_duplicate() will never return e.g. -EEXIST
>> if copied by copy_one_pte() indirectly), both the original and the new
>> code should be OK.
>> 
>> If we thought it is a real problem, we need to fix the original code and
>> keep it fixed in the new code.  Do you agree?
>
> Yes, if it was a real problem, which seems less and less the case the more I
> stare at this.
>
>> There's several ways to fix the problem.  But the page table shouldn't
>> be corrupted in practice, unless there's some programming error.  So I
>> suggest to make it as simple as possible via adding,
>> 
>> VM_BUG_ON(error != -ENOMEM);
>> 
>> in swap_duplicate().
>> 
>> Do you agree?
>
> Yes, I'm ok with that, adding in -ENOTDIR along with it.

Sure.  I will do this.

> The error handling in __swap_duplicate (before this series) still leaves
> something to be desired IMHO.  Why all the different returns when callers
> ignore them or only specifically check for -ENOMEM or -EEXIST?  Could maybe
> stand a cleanup, but outside this series.

Yes.  Maybe.  I guess you will work on this?

Best Regards,
Huang, Ying
