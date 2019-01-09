Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D4EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF64206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbfAIOtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:49:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731755AbfAIOtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:49:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E58EDC057E2C;
        Wed,  9 Jan 2019 14:49:44 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (dhcp-10-65-161-12.pnq.redhat.com [10.65.161.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8011C5D762;
        Wed,  9 Jan 2019 14:49:20 +0000 (UTC)
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
Subject: [PATCH v3 4/5] ext4: disable map_sync for virtio pmem
Date:   Wed,  9 Jan 2019 20:17:35 +0530
Message-Id: <20190109144736.17452-5-pagupta@redhat.com>
In-Reply-To: <20190109144736.17452-1-pagupta@redhat.com>
References: <20190109144736.17452-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 09 Jan 2019 14:49:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtio pmem provides asynchronous host page cache flush
mechanism. We don't support 'MAP_SYNC' with virtio pmem 
and ext4. 

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 fs/ext4/file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 69d65d4..e54f48b 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -360,8 +360,10 @@ static const struct vm_operations_struct ext4_file_vm_ops = {
 static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_mapping->host;
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct dax_device *dax_dev = sbi->s_daxdev;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(sbi)))
 		return -EIO;
 
 	/*
@@ -371,6 +373,13 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!IS_DAX(file_inode(file)) && (vma->vm_flags & VM_SYNC))
 		return -EOPNOTSUPP;
 
+	/* We don't support synchronous mappings with guest direct access
+	 * and virtio based host page cache flush mechanism.
+	 */
+	if (IS_DAX(file_inode(file)) && virtio_pmem_host_cache_enabled(dax_dev)
+						&& (vma->vm_flags & VM_SYNC))
+		return -EOPNOTSUPP;
+
 	file_accessed(file);
 	if (IS_DAX(file_inode(file))) {
 		vma->vm_ops = &ext4_dax_vm_ops;
-- 
2.9.3

