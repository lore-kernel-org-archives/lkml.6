Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbeDRAiW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 20:38:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:19725 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751248AbeDRAiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 20:38:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="44118498"
From: "Huang\, Ying" <ying.huang@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@intel.com>, Andi Kleen <ak@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, "Shaohua Li" <shli@kernel.org>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH -mm 06/21] mm, THP, swap: Support PMD swap mapping when splitting huge PMD
References: <20180417020230.26412-1-ying.huang@intel.com>
        <20180417020230.26412-7-ying.huang@intel.com>
        <7ae64b5e-79ee-5768-34a3-75e33ea45246@infradead.org>
Date: Wed, 18 Apr 2018 08:38:16 +0800
In-Reply-To: <7ae64b5e-79ee-5768-34a3-75e33ea45246@infradead.org> (Randy
        Dunlap's message of "Tue, 17 Apr 2018 14:12:05 -0700")
Message-ID: <87tvs9z6vb.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 04/16/18 19:02, Huang, Ying wrote:
>> From: Huang Ying <ying.huang@intel.com>
>> 
>> A huge PMD need to be split when zap a part of the PMD mapping etc.
>> If the PMD mapping is a swap mapping, we need to split it too.  This
>> patch implemented the support for this.  This is similar as splitting
>> the PMD page mapping, except we need to decrease the PMD swap mapping
>> count for the huge swap cluster too.  If the PMD swap mapping count
>> becomes 0, the huge swap cluster will be split.
>> 
>> Notice: is_huge_zero_pmd() and pmd_page() doesn't work well with swap
>> PMD, so pmd_present() check is called before them.
>
> FWIW, I would prefer to see that comment in the source code, not just
> in the commit description.

Sure.  I will add comment in source code too.

Best Regards,
Huang, Ying

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
>> ---
>>  include/linux/swap.h |  6 +++++
>>  mm/huge_memory.c     | 54 ++++++++++++++++++++++++++++++++++++++++----
>>  mm/swapfile.c        | 28 +++++++++++++++++++++++
>>  3 files changed, 83 insertions(+), 5 deletions(-)
