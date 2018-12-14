Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67C8C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEB72148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789935;
	bh=+fFZYIsVisaR+hBFseAAARSOP0juSggeFIXe7miH+/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lFl2I33e8hF8WjXBWRZsI8Aa/Q3WW3bcElHH6qTbzgWNmsNv2L1PTHyvvibrUcFEd
	 4duGLEHikcL4oGWu5JdN49OZG9neMoRJttMf4y7MRfM7WJ2MPW2GyLvcDtzWhjM4EV
	 uKw+0vV1XjvN8DqtXN0MmJGADm+ZYzc4tUofNTws=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEB72148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbeLNMSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:18:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732690AbeLNMQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:16:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABF21214DE;
        Fri, 14 Dec 2018 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789768;
        bh=+fFZYIsVisaR+hBFseAAARSOP0juSggeFIXe7miH+/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tgj5/B5IEmgJAjc5PIcx89IFN4iobUTnxVI/UT1Akf8cf+x7kaSIntGf0I3sDEFw4
         RjCR6/NkZ3M//cO4MtTbIXRnMc+xUubrq1v3DpZEz/Tyg3fuY0jTg0n66n9RzE208I
         pvFVIzNOSNiH6YxI2plHsn1xt9QVMcqgZKkM/xuE=
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
Subject: [PATCH 4.4 70/88] hugetlbfs: check for pgoff value overflow
Date:   Fri, 14 Dec 2018 13:00:44 +0100
Message-Id: <20181214115708.011941415@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 4.4: Use a conditional WARN() instead of VM_WARN()]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/hugetlbfs/inode.c |   17 ++++++++++++++---
 mm/hugetlb.c         |    8 ++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

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
@@ -4053,6 +4053,14 @@ int hugetlb_reserve_pages(struct inode *
 	struct resv_map *resv_map;
 	long gbl_reserve;
 
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


