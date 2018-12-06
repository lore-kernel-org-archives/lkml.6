Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE61C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8096B20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107914;
	bh=QWoFiP/RLOsDMaadl0975nB55fX4r6E2+SPtINFCxs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QKsIBXtG6uQYVTM/kkpCB/6RSKZ6Tg1+9mMLSzbyjNg3JCA0bapF84NYEsdv0q1cg
	 Aoo06oiAyuRtFhrHHcz6gZl3d3KXSxkT3lOHMpnq4XivLgiZ/dtP9tKYIKxhQOUA6H
	 t33beRP5ZB/u1zRIb4PBx0bsitIooGXsDHMwoCDc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8096B20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbeLFOqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:46:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729944AbeLFOqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:46:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56722214DE;
        Thu,  6 Dec 2018 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107589;
        bh=QWoFiP/RLOsDMaadl0975nB55fX4r6E2+SPtINFCxs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXxKAsA/7q8SmcvZ2vL/quL7p0RiN5a+ZmV76tq13pfuF8qTtmkZnjWNFlax+83Jl
         jWb5zpgelABLoHfbHFZoVMFtuTXCRlWaEwPyVRTmmz5LJuXgbGmEuvbAIp7GanBRT4
         DJJ6lcT5ygIvl7a8Kc2nyVkEfsKriPfJsfKKNzQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hillf Danton <hillf.zj@alibaba-inc.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 063/101] hugetlbfs: fix offset overflow in hugetlbfs mmap
Date:   Thu,  6 Dec 2018 15:39:02 +0100
Message-Id: <20181206143015.275040390@linuxfoundation.org>
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
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/hugetlbfs/inode.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -136,17 +136,26 @@ static int hugetlbfs_file_mmap(struct fi
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
 
 	inode_lock(inode);
 	file_accessed(file);
 
 	ret = -ENOMEM;
-	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-
 	if (hugetlb_reserve_pages(inode,
 				vma->vm_pgoff >> huge_page_order(h),
 				len >> huge_page_shift(h), vma,
@@ -155,7 +164,7 @@ static int hugetlbfs_file_mmap(struct fi
 
 	ret = 0;
 	if (vma->vm_flags & VM_WRITE && inode->i_size < len)
-		inode->i_size = len;
+		i_size_write(inode, len);
 out:
 	inode_unlock(inode);
 


