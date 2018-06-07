Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id t5CEJKlYGVsgAwAAmS7hNA
	; Thu, 07 Jun 2018 16:12:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B6F046074D; Thu,  7 Jun 2018 16:12:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D9247605A2;
	Thu,  7 Jun 2018 16:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9247605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934376AbeFGQMK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:12:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39166 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932969AbeFGOJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:01 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0005Zn-C5; Thu, 07 Jun 2018 15:08:59 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002iG-Ts; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Michal Hocko" <mhocko@suse.com>,
        "Nic Losby" <blurbdust@gmail.com>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Yisheng Xie" <xieyisheng1@huawei.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.350847749@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 028/410] hugetlbfs: check for pgoff value overflow
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Kravetz <mike.kravetz@oracle.com>

commit 63489f8e821144000e0bdca7e65a8d1cc23a7ee7 upstream.

A vma with vm_pgoff large enough to overflow a loff_t type when
converted to a byte offset can be passed via the remap_file_pages system
call.  The hugetlbfs mmap routine uses the byte offset to calculate
reservations and file size.

A sequence such as:

  mmap(0x20a00000, 0x600000, 0, 0x66033, -1, 0);
  remap_file_pages(0x20a00000, 0x600000, 0, 0x20000000000000, 0);

will result in the following when task exits/file closed,

  kernel BUG at mm/hugetlb.c:749!
  Call Trace:
    hugetlbfs_evict_inode+0x2f/0x40
    evict+0xcb/0x190
    __dentry_kill+0xcb/0x150
    __fput+0x164/0x1e0
    task_work_run+0x84/0xa0
    exit_to_usermode_loop+0x7d/0x80
    do_syscall_64+0x18b/0x190
    entry_SYSCALL_64_after_hwframe+0x3d/0xa2

The overflowed pgoff value causes hugetlbfs to try to set up a mapping
with a negative range (end < start) that leaves invalid state which
causes the BUG.

The previous overflow fix to this code was incomplete and did not take
the remap_file_pages system call into account.

[mike.kravetz@oracle.com: v3]
  Link: http://lkml.kernel.org/r/20180309002726.7248-1-mike.kravetz@oracle.com
[akpm@linux-foundation.org: include mmdebug.h]
[akpm@linux-foundation.org: fix -ve left shift count on sh]
Link: http://lkml.kernel.org/r/20180308210502.15952-1-mike.kravetz@oracle.com
Fixes: 045c7a3f53d9 ("hugetlbfs: fix offset overflow in hugetlbfs mmap")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reported-by: Nic Losby <blurbdust@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16:
 - Use a conditional WARN() instead of VM_WARN()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/hugetlbfs/inode.c | 17 ++++++++++++++---
 mm/hugetlb.c         |  7 +++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -97,6 +97,16 @@ static void huge_pagevec_release(struct
 	pagevec_reinit(pvec);
 }
 
+/*
+ * Mask used when checking the page offset value passed in via system
+ * calls.  This value will be converted to a loff_t which is signed.
+ * Therefore, we want to check the upper PAGE_SHIFT + 1 bits of the
+ * value.  The extra bit (- 1 in the shift value) is to take the sign
+ * bit into account.
+ */
+#define PGOFF_LOFFT_MAX \
+	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))
+
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
@@ -116,12 +126,13 @@ static int hugetlbfs_file_mmap(struct fi
 	vma->vm_ops = &hugetlb_vm_ops;
 
 	/*
-	 * Offset passed to mmap (before page shift) could have been
-	 * negative when represented as a (l)off_t.
+	 * page based offset in vm_pgoff could be sufficiently large to
+	 * overflow a (l)off_t when converted to byte offset.
 	 */
-	if (((loff_t)vma->vm_pgoff << PAGE_SHIFT) < 0)
+	if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
 		return -EINVAL;
 
+	/* must be huge page aligned */
 	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
 		return -EINVAL;
 
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -19,6 +19,7 @@
 #include <linux/bootmem.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
+#include <linux/mmdebug.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
@@ -3504,6 +3505,14 @@ int hugetlb_reserve_pages(struct inode *
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
 
+	/* This should never happen */
+	if (from > to) {
+#ifdef CONFIG_DEBUG_VM
+		WARN(1, "%s called with a negative range\n", __func__);
+#endif
+		return -EINVAL;
+	}
+
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
 	 * attempt will be made for VM_NORESERVE to allocate a page
