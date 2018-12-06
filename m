Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FFDC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C0620892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107597;
	bh=q6mm40nzUNcY9waAcn891z8qE5iNGuhHAWMgXfEkoYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ofO4jtVds77bI2mfE9PD5++iqHWv1WjwG+ye0kfKmGEmmd47rsbIlU3SQ9PRJJsh3
	 Bzuvh+Z9vcNIp5XcD/QHMcX+hLm55FdYtv5CnIJzmF9+oBr+8fXdYr8ZGIm/nBvcOi
	 o9OW5/N4H8JcIbcgHDQBZ8UietUjEaTb3x0BKuA8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C0620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbeLFOqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:46:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730597AbeLFOqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:46:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B72C6214F1;
        Thu,  6 Dec 2018 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107592;
        bh=q6mm40nzUNcY9waAcn891z8qE5iNGuhHAWMgXfEkoYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1ofd0kUpldfNEI268UHJ9Y9rQNABVc73etQ4VOAwUblIWSqDqDRsNrbjdylgoU4U
         YWyn0iZ7384QffK2u+Nt4xYp1SAb4bjvKr3Y8ulaclijEeqMtiF6QJl4oLIXL/hNCd
         pMoX92uYN9IE/hkGqilEmj8+BCm+VxLfc34FJ5/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Nic Losby <blurbdust@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 064/101] hugetlbfs: check for pgoff value overflow
Date:   Thu,  6 Dec 2018 15:39:03 +0100
Message-Id: <20181206143015.340009477@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/hugetlbfs/inode.c |   17 ++++++++++++++---
 mm/hugetlb.c         |    6 ++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -118,6 +118,16 @@ static void huge_pagevec_release(struct
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
@@ -137,12 +147,13 @@ static int hugetlbfs_file_mmap(struct fi
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
@@ -4170,6 +4170,12 @@ int hugetlb_reserve_pages(struct inode *
 	struct resv_map *resv_map;
 	long gbl_reserve;
 
+	/* This should never happen */
+	if (from > to) {
+		VM_WARN(1, "%s called with a negative range\n", __func__);
+		return -EINVAL;
+	}
+
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
 	 * attempt will be made for VM_NORESERVE to allocate a page


