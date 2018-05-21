Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeEUBv4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 21:51:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:43850 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751727AbeEUBvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 21:51:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,425,1520924400";
   d="scan'208";a="40853571"
From: "Huang\, Ying" <ying.huang@intel.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Andi Kleen <andi.kleen@intel.com>,
        Jan Kara <jack@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Shaohua Li <shli@fb.com>, Christopher Lameter <cl@linux.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH -mm] mm, huge page: Copy to access sub-page last when copy huge page
References: <20180518030316.31019-1-ying.huang@intel.com>
        <20180518062430.GB21711@dhcp22.suse.cz>
Date: Mon, 21 May 2018 09:51:50 +0800
In-Reply-To: <20180518062430.GB21711@dhcp22.suse.cz> (Michal Hocko's message
        of "Fri, 18 May 2018 08:24:30 +0200")
Message-ID: <87fu2lkc7d.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michal,

Michal Hocko <mhocko@kernel.org> writes:

> On Fri 18-05-18 11:03:16, Huang, Ying wrote:
> [...]
>> The patch is a generic optimization which should benefit quite some
>> workloads, not for a specific use case.  To demonstrate the performance
>> benefit of the patch, we tested it with vm-scalability run on
>> transparent huge page.
>
> It is also adds quite some non-intuitive code. So is this worth? Does
> any _real_ workload benefits from the change?

I don't have any _real_ workload which benefits from this.  But I think
this is the right way to copy the huge page.  It should benefit many
workloads with heavy cache contention, as illustrated in the
micro-benchmark.  But the performance benefit may be small or
non-measurable for the _real_ workload.

The code does become not as intuitive as before.  But fortunately, all
non-intuitive code are in copy_user_huge_page(), which is a leaf
function with well defined interface and semantics.  And with the help
of the code comments, at least the intention of the code is clear.

Best Regards,
Huang, Ying

>>  include/linux/mm.h |  3 ++-
>>  mm/huge_memory.c   |  3 ++-
>>  mm/memory.c        | 43 +++++++++++++++++++++++++++++++++++++++----
>>  3 files changed, 43 insertions(+), 6 deletions(-)
