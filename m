Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EDBC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23F420850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107920;
	bh=O7TC8EftALK3d30GHslNvFmseALI6fgmVU09LMfsDhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pfGXWlwXkXbIRmHyNblIFZM5iBZa8WGqiCtvpaamgbfXM/0MPhMwDp0vJpDUwW5B3
	 VCQxUwn8FDp7W8mbRxdEwkyBh5Y6MjA8GtHr31T0A/j+cTCx3Zuwurv+C/4iNGfwmn
	 6K66UcKAUPu+EeLfkZlxveJu/I3LpVIDLm8z22bo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23F420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeLFOv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:51:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731250AbeLFOq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:46:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E716421479;
        Thu,  6 Dec 2018 14:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107587;
        bh=O7TC8EftALK3d30GHslNvFmseALI6fgmVU09LMfsDhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3UImsNtQLPltgHJzZMvraUK8So5uU6GpYg2Mk2gxEoKFx/xv7EBfhCXcYtJIlCWk
         NmeAyr4oBEA9NWtuxGIlUj5o0GOkMmoLwRGdcxKnOUE/7kDkc+3qFJrqDFQxQsHUql
         Z1viE/3kq6W4zInUa5g+D/icbs9ANmhx2JXLdgwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hillf Danton <hillf.zj@alibaba-inc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 062/101] mm/hugetlb.c: dont call region_abort if region_chg fails
Date:   Thu,  6 Dec 2018 15:39:01 +0100
Message-Id: <20181206143015.213389051@linuxfoundation.org>
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

commit ff8c0c53c47530ffea82c22a0a6df6332b56c957 upstream.

Changes to hugetlbfs reservation maps is a two step process.  The first
step is a call to region_chg to determine what needs to be changed, and
prepare that change.  This should be followed by a call to call to
region_add to commit the change, or region_abort to abort the change.

The error path in hugetlb_reserve_pages called region_abort after a
failed call to region_chg.  As a result, the adds_in_progress counter in
the reservation map is off by 1.  This is caught by a VM_BUG_ON in
resv_map_release when the reservation map is freed.

syzkaller fuzzer (when using an injected kmalloc failure) found this
bug, that resulted in the following:

 kernel BUG at mm/hugetlb.c:742!
 Call Trace:
  hugetlbfs_evict_inode+0x7b/0xa0 fs/hugetlbfs/inode.c:493
  evict+0x481/0x920 fs/inode.c:553
  iput_final fs/inode.c:1515 [inline]
  iput+0x62b/0xa20 fs/inode.c:1542
  hugetlb_file_setup+0x593/0x9f0 fs/hugetlbfs/inode.c:1306
  newseg+0x422/0xd30 ipc/shm.c:575
  ipcget_new ipc/util.c:285 [inline]
  ipcget+0x21e/0x580 ipc/util.c:639
  SYSC_shmget ipc/shm.c:673 [inline]
  SyS_shmget+0x158/0x230 ipc/shm.c:657
  entry_SYSCALL_64_fastpath+0x1f/0xc2
 RIP: resv_map_release+0x265/0x330 mm/hugetlb.c:742

Link: http://lkml.kernel.org/r/1490821682-23228-1-git-send-email-mike.kravetz@oracle.com
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Hillf Danton <hillf.zj@alibaba-inc.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/hugetlb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4259,7 +4259,9 @@ int hugetlb_reserve_pages(struct inode *
 	return 0;
 out_err:
 	if (!vma || vma->vm_flags & VM_MAYSHARE)
-		region_abort(resv_map, from, to);
+		/* Don't call region_abort if region_chg failed */
+		if (chg >= 0)
+			region_abort(resv_map, from, to);
 	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
 		kref_put(&resv_map->refs, resv_map_release);
 	return ret;


