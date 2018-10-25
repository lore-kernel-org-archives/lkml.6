Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7FEECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998BA204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998BA204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeJYJNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:13:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:18265 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbeJYJNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:13:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 17:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,422,1534834800"; 
   d="scan'208";a="83932225"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.27])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2018 17:42:52 -0700
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
Subject: Re: [PATCH -V6 00/21] swap: Swapout/swapin THP in one piece
References: <20181010071924.18767-1-ying.huang@intel.com>
        <20181023122738.a5j2vk554tsx4f6i@ca-dmjordan1.us.oracle.com>
        <87sh0wuijl.fsf@yhuang-dev.intel.com>
        <20181024172410.a3pibijoc2u2awwo@ca-dmjordan1.us.oracle.com>
Date:   Thu, 25 Oct 2018 08:42:51 +0800
In-Reply-To: <20181024172410.a3pibijoc2u2awwo@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Wed, 24 Oct 2018 10:24:10 -0700")
Message-ID: <87ftwuvotw.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Wed, Oct 24, 2018 at 11:31:42AM +0800, Huang, Ying wrote:
>> Hi, Daniel,
>> 
>> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
>> 
>> > On Wed, Oct 10, 2018 at 03:19:03PM +0800, Huang Ying wrote:
>> >> And for all, Any comment is welcome!
>> >> 
>> >> This patchset is based on the 2018-10-3 head of mmotm/master.
>> >
>> > There seems to be some infrequent memory corruption with THPs that have been
>> > swapped out: page contents differ after swapin.
>> 
>> Thanks a lot for testing this!  I know there were big effort behind this
>> and it definitely will improve the quality of the patchset greatly!
>
> You're welcome!  Hopefully I'll have more results and tests to share in the
> next two weeks.
>
>> 
>> > Reproducer at the bottom.  Part of some tests I'm writing, had to separate it a
>> > little hack-ily.  Basically it writes the word offset _at_ each word offset in
>> > a memory blob, tries to push it to swap, and verifies the offset is the same
>> > after swapin.
>> >
>> > I ran with THP enabled=always.  THP swapin_enabled could be always or never, it
>> > happened with both.  Every time swapping occurred, a single THP-sized chunk in
>> > the middle of the blob had different offsets.  Example:
>> >
>> > ** > word corruption gap
>> > ** corruption detected 14929920 bytes in (got 15179776, expected 14929920) **
>> > ** corruption detected 14929928 bytes in (got 15179784, expected 14929928) **
>> > ** corruption detected 14929936 bytes in (got 15179792, expected 14929936) **
>> > ...pattern continues...
>> > ** corruption detected 17027048 bytes in (got 15179752, expected 17027048) **
>> > ** corruption detected 17027056 bytes in (got 15179760, expected 17027056) **
>> > ** corruption detected 17027064 bytes in (got 15179768, expected 17027064) **
>> 
>> 15179776 < 15179xxx <= 17027064
>> 
>> 15179776 % 4096 = 0
>> 
>> And 15179776 = 15179768 + 8
>> 
>> So I guess we have some alignment bug.  Could you try the patches
>> attached?  It deal with some alignment issue.
>
> That fixed it.  And removed three lines of code.  Nice :)

Thanks!  I will merge the fixes into the patchset.

Best Regards,
Huang, Ying
