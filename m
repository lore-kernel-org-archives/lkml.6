Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753760AbeE3Li3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:38:29 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60753 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752144AbeE3LHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:01 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Shaohua Li" <shli@fb.com>,
        "chenjie" <chenjie6@huawei.com>, "Rik van Riel" <riel@redhat.com>,
        "Mel Gorman" <mgorman@techsingularity.net>,
        "Michal Hocko" <mhocko@suse.com>, "Carsten Otte" <cotte@de.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Minchan Kim" <minchan@kernel.org>, "Miao Xie" <miaoxie@huawei.com>,
        "Mike Rapoport" <rppt@linux.vnet.ibm.com>,
        "David Rientjes" <rientjes@google.com>,
        "guoxuenan" <guoxuenan@huawei.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "Anshuman Khandual" <khandual@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.821584807@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 002/153] mm/madvise.c: fix madvise() infinite loop
 under special circumstances
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: chenjie <chenjie6@huawei.com>

commit 6ea8d958a2c95a1d514015d4e29ba21a8c0a1a91 upstream.

MADVISE_WILLNEED has always been a noop for DAX (formerly XIP) mappings.
Unfortunately madvise_willneed() doesn't communicate this information
properly to the generic madvise syscall implementation.  The calling
convention is quite subtle there.  madvise_vma() is supposed to either
return an error or update &prev otherwise the main loop will never
advance to the next vma and it will keep looping for ever without a way
to get out of the kernel.

It seems this has been broken since introduction.  Nobody has noticed
because nobody seems to be using MADVISE_WILLNEED on these DAX mappings.

[mhocko@suse.com: rewrite changelog]
Link: http://lkml.kernel.org/r/20171127115318.911-1-guoxuenan@huawei.com
Fixes: fe77ba6f4f97 ("[PATCH] xip: madvice/fadvice: execute in place")
Signed-off-by: chenjie <chenjie6@huawei.com>
Signed-off-by: guoxuenan <guoxuenan@huawei.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: zhangyi (F) <yi.zhang@huawei.com>
Cc: Miao Xie <miaoxie@huawei.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Shaohua Li <shli@fb.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -128,6 +128,7 @@ static long madvise_willneed(struct vm_a
 {
 	struct file *file = vma->vm_file;
 
+	*prev = vma;
 	if (!file)
 		return -EBADF;
 
@@ -136,7 +137,6 @@ static long madvise_willneed(struct vm_a
 		return 0;
 	}
 
-	*prev = vma;
 	start = ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
 	if (end > vma->vm_end)
 		end = vma->vm_end;
