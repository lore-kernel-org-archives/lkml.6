Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752714AbeEUCeb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 22:34:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:38859 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeEUCe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 22:34:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,425,1520924400";
   d="scan'208";a="56961644"
From: "Huang\, Ying" <ying.huang@intel.com>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Andi Kleen <andi.kleen@intel.com>,
        Jan Kara <jack@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Shaohua Li <shli@fb.com>, Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH -mm] mm, huge page: Copy to access sub-page last when copy huge page
References: <20180518030316.31019-1-ying.huang@intel.com>
        <20180518062430.GB21711@dhcp22.suse.cz>
        <64430ed4-4019-d597-ccb3-8bf6b04ee464@oracle.com>
Date: Mon, 21 May 2018 10:34:25 +0800
In-Reply-To: <64430ed4-4019-d597-ccb3-8bf6b04ee464@oracle.com> (Mike Kravetz's
        message of "Fri, 18 May 2018 09:41:04 -0700")
Message-ID: <87bmd9ka8e.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 05/17/2018 11:24 PM, Michal Hocko wrote:
>> On Fri 18-05-18 11:03:16, Huang, Ying wrote:
>> [...]
>>> The patch is a generic optimization which should benefit quite some
>>> workloads, not for a specific use case.  To demonstrate the performance
>>> benefit of the patch, we tested it with vm-scalability run on
>>> transparent huge page.
>> 
>> It is also adds quite some non-intuitive code. So is this worth? Does
>> any _real_ workload benefits from the change?
>
> One way to 'add less code' would be to create a helper routine that
> indicates the order in which sub-pages are to be copied.  IIUC, you
> added the same algorithm for sub-page ordering to copy_huge_page()
> that was previously added to clear_huge_page().  Correct?

Yes.

> If so, then perhaps a common helper could be used by both the clear
> and copy huge page routines.  It would also make maintenance easier.

That's a good idea.  But this may need to turn
copy_user_highpage()/clear_user_highpage() calling in
copy_user_huge_page()/clear_huge_page() from direct call to indirect
call.  I don't know whether this will incur some overhead.  Will try to
measure this.

Best Regards,
Huang, Ying
