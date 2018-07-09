Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5C7C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61910208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61910208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbeGIFku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:40:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:52396 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750846AbeGIFkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:40:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2018 22:40:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,329,1526367600"; 
   d="scan'208";a="63225381"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.118])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jul 2018 22:40:46 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <n-horiguchi@ah.jp.nec.com>, <zi.yan@cs.rutgers.edu>,
        <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH -mm -v4 01/21] mm, THP, swap: Enable PMD swap operations for CONFIG_THP_SWAP
References: <20180622035151.6676-1-ying.huang@intel.com>
        <20180622035151.6676-2-ying.huang@intel.com>
        <CAA9_cmcwczyEb=+3F7HtDDqZA-3rdqgw=gkYipDtx5r+4Kd5Tw@mail.gmail.com>
Date:   Mon, 09 Jul 2018 13:40:45 +0800
In-Reply-To: <CAA9_cmcwczyEb=+3F7HtDDqZA-3rdqgw=gkYipDtx5r+4Kd5Tw@mail.gmail.com>
        (Dan Williams's message of "Sat, 7 Jul 2018 14:11:18 -0700")
Message-ID: <87muv1kluq.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Thu, Jun 21, 2018 at 8:55 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> From: Huang Ying <ying.huang@intel.com>
>>
>> Previously, the PMD swap operations are only enabled for
>> CONFIG_ARCH_ENABLE_THP_MIGRATION.  Because they are only used by the
>> THP migration support.  We will support PMD swap mapping to the huge
>> swap cluster and swapin the THP as a whole.  That will be enabled via
>> CONFIG_THP_SWAP and needs these PMD swap operations.  So enable the
>> PMD swap operations for CONFIG_THP_SWAP too.
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Shaohua Li <shli@kernel.org>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Rik van Riel <riel@redhat.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>> Cc: Zi Yan <zi.yan@cs.rutgers.edu>
>> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
>> ---
>>  arch/x86/include/asm/pgtable.h |  2 +-
>>  include/asm-generic/pgtable.h  |  2 +-
>>  include/linux/swapops.h        | 44 ++++++++++++++++++++++--------------------
>>  3 files changed, 25 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>> index 99ecde23c3ec..13bf58838daf 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -1224,7 +1224,7 @@ static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
>>         return pte_clear_flags(pte, _PAGE_SWP_SOFT_DIRTY);
>>  }
>>
>> -#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>> +#if defined(CONFIG_ARCH_ENABLE_THP_MIGRATION) || defined(CONFIG_THP_SWAP)
>
> How about introducing a new config symbol representing the common
> infrastructure between the two and have them select that symbol.

The common infrastructure shared by two mechanisms is PMD swap entry.
But I didn't find there are many places where the common infrastructure
is used.  So I think it may be over-engineering to introduce a new
config symbol but use it for so few times.

> Would that also allow us to clean up the usage of
> CONFIG_ARCH_ENABLE_THP_MIGRATION in fs/proc/task_mmu.c? In other
> words, what's the point of having nice ifdef'd alternatives in header
> files when ifdefs are still showing up in C files, all of it should be
> optionally determined by header files.

Unfortunately, I think it is not a easy task to wrap all C code via
#ifdef in header files.  And it may be over-engineering to wrap them
all.  I guess this is why there are still some #ifdef in C files.

Best Regards,
Huang, Ying
