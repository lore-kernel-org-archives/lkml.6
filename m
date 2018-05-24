Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935362AbeEXBAb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:00:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:34349 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935196AbeEXBA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:00:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,435,1520924400";
   d="scan'208";a="42362508"
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Shaohua Li <shli@fb.com>, Christopher Lameter <cl@linux.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH -V2 -mm 0/4] mm, huge page: Copy target sub-page last when copy huge page
Date: Thu, 24 May 2018 08:58:47 +0800
Message-Id: <20180524005851.4079-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

Huge page helps to reduce TLB miss rate, but it has higher cache
footprint, sometimes this may cause some issue.  For example, when
copying huge page on x86_64 platform, the cache footprint is 4M.  But
on a Xeon E5 v3 2699 CPU, there are 18 cores, 36 threads, and only 45M
LLC (last level cache).  That is, in average, there are 2.5M LLC for
each core and 1.25M LLC for each thread.

If the cache contention is heavy when copying the huge page, and we
copy the huge page from the begin to the end, it is possible that the
begin of huge page is evicted from the cache after we finishing
copying the end of the huge page.  And it is possible for the
application to access the begin of the huge page after copying the
huge page.

In commit c79b57e462b5d ("mm: hugetlb: clear target sub-page last when
clearing huge page"), to keep the cache lines of the target subpage
hot, the order to clear the subpages in the huge page in
clear_huge_page() is changed to clearing the subpage which is furthest
from the target subpage firstly, and the target subpage last.  The
similar order changing helps huge page copying too.  That is
implemented in this patchset.

The patchset is a generic optimization which should benefit quite some
workloads, not for a specific use case.  To demonstrate the
performance benefit of the patchset, we have tested it with
vm-scalability run on transparent huge page.

With this patchset, the throughput increases ~16.6% in vm-scalability
anon-cow-seq test case with 36 processes on a 2 socket Xeon E5 v3 2699
system (36 cores, 72 threads).  The test case set
/sys/kernel/mm/transparent_hugepage/enabled to be always, mmap() a big
anonymous memory area and populate it, then forked 36 child processes,
each writes to the anonymous memory area from the begin to the end, so
cause copy on write.  For each child process, other child processes
could be seen as other workloads which generate heavy cache pressure.
At the same time, the IPC (instruction per cycle) increased from 0.63
to 0.78, and the time spent in user space is reduced ~7.2%.

Changelog:

V2:

- As suggested by Mike Kravetz, put subpage order algorithm into a
  separate patch to avoid code duplication and reduce maintenance
  overhead.

- Add hugetlbfs support

Best Regards,
Huang, Ying
