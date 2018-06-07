Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ANZQELVYGVuTAwAAmS7hNA
	; Thu, 07 Jun 2018 16:10:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7F0AC6089E; Thu,  7 Jun 2018 16:10:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 89F7D605A2;
	Thu,  7 Jun 2018 16:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89F7D605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934429AbeFGQJI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:09:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39219 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932993AbeFGOJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:02 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0005Zm-Cp; Thu, 07 Jun 2018 15:08:59 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002iC-T9; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Hillf Danton" <hillf.zj@alibaba-inc.com>,
        "Vegard Nossum" <vegard.nossum@oracle.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.79589622@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 027/410] hugetlbfs: fix offset overflow in hugetlbfs mmap
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

commit 045c7a3f53d9403b62d396b6d051c4be5044cdb4 upstream.

If mmap() maps a file, it can be passed an offset into the file at which
the mapping is to start.  Offset could be a negative value when
represented as a loff_t.  The offset plus length will be used to update
the file size (i_size) which is also a loff_t.

Validate the value of offset and offset + length to make sure they do
not overflow and appear as negative.

Found by syzcaller with commit ff8c0c53c475 ("mm/hugetlb.c: don't call
region_abort if region_chg fails") applied.  Prior to this commit, the
overflow would still occur but we would luckily return ENOMEM.

To reproduce:

   mmap(0, 0x2000, 0, 0x40021, 0xffffffffffffffffULL, 0x8000000000000000ULL);

Resulted in,

  kernel BUG at mm/hugetlb.c:742!
  Call Trace:
   hugetlbfs_evict_inode+0x80/0xa0
   evict+0x24a/0x620
   iput+0x48f/0x8c0
   dentry_unlink_inode+0x31f/0x4d0
   __dentry_kill+0x292/0x5e0
   dput+0x730/0x830
   __fput+0x438/0x720
   ____fput+0x1a/0x20
   task_work_run+0xfe/0x180
   exit_to_usermode_loop+0x133/0x150
   syscall_return_slowpath+0x184/0x1c0
   entry_SYSCALL_64_fastpath+0xab/0xad

Fixes: ff8c0c53c475 ("mm/hugetlb.c: don't call region_abort if region_chg fails")
Link: http://lkml.kernel.org/r/1491951118-30678-1-git-send-email-mike.kravetz@oracle.com
Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Hillf Danton <hillf.zj@alibaba-inc.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/hugetlbfs/inode.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -115,17 +115,26 @@ static int hugetlbfs_file_mmap(struct fi
 	vma->vm_flags |= VM_HUGETLB | VM_DONTEXPAND;
 	vma->vm_ops = &hugetlb_vm_ops;
 
+	/*
+	 * Offset passed to mmap (before page shift) could have been
+	 * negative when represented as a (l)off_t.
+	 */
+	if (((loff_t)vma->vm_pgoff << PAGE_SHIFT) < 0)
+		return -EINVAL;
+
 	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
 		return -EINVAL;
 
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
+	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
+	/* check for overflow */
+	if (len < vma_len)
+		return -EINVAL;
 
 	mutex_lock(&inode->i_mutex);
 	file_accessed(file);
 
 	ret = -ENOMEM;
-	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-
 	if (hugetlb_reserve_pages(inode,
 				vma->vm_pgoff >> huge_page_order(h),
 				len >> huge_page_shift(h), vma,
@@ -135,7 +144,7 @@ static int hugetlbfs_file_mmap(struct fi
 	ret = 0;
 	hugetlb_prefault_arch_hook(vma->vm_mm);
 	if (vma->vm_flags & VM_WRITE && inode->i_size < len)
-		inode->i_size = len;
+		i_size_write(inode, len);
 out:
 	mutex_unlock(&inode->i_mutex);
 
