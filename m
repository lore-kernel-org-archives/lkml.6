Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755243AbeCGX7n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:59:43 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755151AbeCGX7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:59:40 -0500
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bugzilla-daemon@bugzilla.kernel.org
Cc: Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hillf Danton <hillf.zj@alibaba-inc.com>,
        Nic Losby <blurbdust@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] hugetlbfs: check for pgoff value overflow
Date: Wed,  7 Mar 2018 15:59:23 -0800
Message-Id: <20180307235923.12469-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180306133135.4dc344e478d98f0e29f47698@linux-foundation.org>
References: <20180306133135.4dc344e478d98f0e29f47698@linux-foundation.org>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8825 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803070272
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A vma with vm_pgoff large enough to overflow a loff_t type when
converted to a byte offset can be passed via the remap_file_pages
system call.  The hugetlbfs mmap routine uses the byte offset to
calculate reservations and file size.

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

The overflowed pgoff value causes hugetlbfs to try to set up a
mapping with a negative range (end < start) that leaves invalid
state which causes the BUG.

Reported-by: Nic Losby <blurbdust@gmail.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 8fe1b0aa2896..cb288dec5564 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -127,12 +127,13 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_ops = &hugetlb_vm_ops;
 
 	/*
-	 * Offset passed to mmap (before page shift) could have been
-	 * negative when represented as a (l)off_t.
+	 * page based offset in vm_pgoff could be sufficiently large to
+	 * overflow a (l)off_t when converted to byte offset.
 	 */
-	if (((loff_t)vma->vm_pgoff << PAGE_SHIFT) < 0)
+	if (vma->vm_pgoff && ((loff_t)vma->vm_pgoff << PAGE_SHIFT) <= 0)
 		return -EINVAL;
 
+	/* must be huge page aligned */
 	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
 		return -EINVAL;
 
-- 
2.13.6
