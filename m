Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56807C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278DB20665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865811;
	bh=qI2ewgQsKioDBsVTfh6/rrR+1JkPUGmnlNj1LZ6ODc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ne301bMA07Yz0UIdRWNsZ0lEUGITvzTQJIOM6Kzw9/Y7rLT9bPHk98/WTMr7/LnyH
	 o4bEinXTgDMgODuER5qcFxHFOrHmmjE9cB/lNaN+iIqp+NI25r6t58puFgAVviUbxJ
	 wUBR/Neom48fLU64rvCrArpE/xquW8MV8qV1QROk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfAGM4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:56:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfAGM4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:56:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6AFF20665;
        Mon,  7 Jan 2019 12:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865806;
        bh=qI2ewgQsKioDBsVTfh6/rrR+1JkPUGmnlNj1LZ6ODc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkwXV2U0QAbhlOlAi9wF14Cflma962GnWKEkIyvKobRSslPMFEwnNLCbiFzA+//KC
         +97H93YjCuLW3b7S8M55p6d34fGlWdCCTleHi9ujsMgZId9KeeRXzTG/z/y7X4qhtN
         uKRUUqrwlWqsGclRFQ13n1v7zYFN6vJ2zuzvrLjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 128/170] btrfs: skip file_extent generation check for free_space_inode in run_delalloc_nocow
Date:   Mon,  7 Jan 2019 13:32:35 +0100
Message-Id: <20190107104508.040017626@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>

commit 27a7ff554e8d349627a90bda275c527b7348adae upstream.

The test case btrfs/001 with inode_cache mount option will encounter the
following warning:

  WARNING: CPU: 1 PID: 23700 at fs/btrfs/inode.c:956 cow_file_range.isra.19+0x32b/0x430 [btrfs]
  CPU: 1 PID: 23700 Comm: btrfs Kdump: loaded Tainted: G        W  O      4.20.0-rc4-custom+ #30
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:cow_file_range.isra.19+0x32b/0x430 [btrfs]
  Call Trace:
   ? free_extent_buffer+0x46/0x90 [btrfs]
   run_delalloc_nocow+0x455/0x900 [btrfs]
   btrfs_run_delalloc_range+0x1a7/0x360 [btrfs]
   writepage_delalloc+0xf9/0x150 [btrfs]
   __extent_writepage+0x125/0x3e0 [btrfs]
   extent_write_cache_pages+0x1b6/0x3e0 [btrfs]
   ? __wake_up_common_lock+0x63/0xc0
   extent_writepages+0x50/0x80 [btrfs]
   do_writepages+0x41/0xd0
   ? __filemap_fdatawrite_range+0x9e/0xf0
   __filemap_fdatawrite_range+0xbe/0xf0
   btrfs_fdatawrite_range+0x1b/0x50 [btrfs]
   __btrfs_write_out_cache+0x42c/0x480 [btrfs]
   btrfs_write_out_ino_cache+0x84/0xd0 [btrfs]
   btrfs_save_ino_cache+0x551/0x660 [btrfs]
   commit_fs_roots+0xc5/0x190 [btrfs]
   btrfs_commit_transaction+0x2bf/0x8d0 [btrfs]
   btrfs_mksubvol+0x48d/0x4d0 [btrfs]
   btrfs_ioctl_snap_create_transid+0x170/0x180 [btrfs]
   btrfs_ioctl_snap_create_v2+0x124/0x180 [btrfs]
   btrfs_ioctl+0x123f/0x3030 [btrfs]

The file extent generation of the free space inode is equal to the last
snapshot of the file root, so the inode will be passed to cow_file_rage.
But the inode was created and its extents were preallocated in
btrfs_save_ino_cache, there are no cow copies on disk.

The preallocated extent is not yet in the extent tree, and
btrfs_cross_ref_exist will ignore the -ENOENT returned by
check_committed_ref, so we can directly write the inode to the disk.

Fixes: 78d4295b1eee ("btrfs: lift some btrfs_cross_ref_exist checks in nocow path")
CC: stable@vger.kernel.org # 4.18+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1373,7 +1373,8 @@ next_slot:
 			 * Do the same check as in btrfs_cross_ref_exist but
 			 * without the unnecessary search.
 			 */
-			if (btrfs_file_extent_generation(leaf, fi) <=
+			if (!nolock &&
+			    btrfs_file_extent_generation(leaf, fi) <=
 			    btrfs_root_last_snapshot(&root->root_item))
 				goto out_check;
 			if (extent_type == BTRFS_FILE_EXTENT_REG && !force)


