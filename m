Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55225C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB602070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbfAIOuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:50:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15115 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732080AbfAIOuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:50:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A573C07DE99;
        Wed,  9 Jan 2019 14:50:17 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (dhcp-10-65-161-12.pnq.redhat.com [10.65.161.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B4A45D76B;
        Wed,  9 Jan 2019 14:49:45 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Cc:     jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com,
        riel@surriel.com, nilal@redhat.com, kwolf@redhat.com,
        pbonzini@redhat.com, zwisler@kernel.org, vishal.l.verma@intel.com,
        dave.jiang@intel.com, david@redhat.com, jmoyer@redhat.com,
        xiaoguangrong.eric@gmail.com, hch@infradead.org, mst@redhat.com,
        jasowang@redhat.com, lcapitulino@redhat.com, imammedo@redhat.com,
        eblake@redhat.com, willy@infradead.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        rjw@rjwysocki.net, pagupta@redhat.com
Subject: [PATCH v3 5/5] xfs: disable map_sync for virtio pmem
Date:   Wed,  9 Jan 2019 20:17:36 +0530
Message-Id: <20190109144736.17452-6-pagupta@redhat.com>
In-Reply-To: <20190109144736.17452-1-pagupta@redhat.com>
References: <20190109144736.17452-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 09 Jan 2019 14:50:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtio pmem provides asynchronous host page cache flush
mechanism. we don't support 'MAP_SYNC' with virtio pmem 
and xfs.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 fs/xfs/xfs_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e474250..eae4aa4 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1190,6 +1190,14 @@ xfs_file_mmap(
 	if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
 		return -EOPNOTSUPP;
 
+	/* We don't support synchronous mappings with guest direct access
+	 * and virtio based host page cache mechanism.
+	 */
+	if (IS_DAX(file_inode(filp)) && virtio_pmem_host_cache_enabled(
+		xfs_find_daxdev_for_inode(file_inode(filp))) &&
+					(vma->vm_flags & VM_SYNC))
+		return -EOPNOTSUPP;
+
 	file_accessed(filp);
 	vma->vm_ops = &xfs_file_vm_ops;
 	if (IS_DAX(file_inode(filp)))
-- 
2.9.3

