Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFC4C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A5F20815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfBCOAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:00:31 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53480 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728225AbfBCNtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:53 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9f-0003tq-8J; Sun, 03 Feb 2019 13:49:51 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9b-00074Q-PL; Sun, 03 Feb 2019 14:49:47 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David Sterba" <dsterba@suse.com>,
        "Filipe Manana" <fdmanana@suse.com>,
        "Robbie Ko" <robbieko@synology.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.418876021@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 145/305] Btrfs: fix cur_offset in the error case for
 nocow
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Robbie Ko <robbieko@synology.com>

commit 506481b20e818db40b6198815904ecd2d6daee64 upstream.

When the cow_file_range fails, the related resources are unlocked
according to the range [start..end), so the unlock cannot be repeated in
run_delalloc_nocow.

In some cases (e.g. cur_offset <= end && cow_start != -1), cur_offset is
not updated correctly, so move the cur_offset update before
cow_file_range.

  kernel BUG at mm/page-writeback.c:2663!
  Internal error: Oops - BUG: 0 [#1] SMP
  CPU: 3 PID: 31525 Comm: kworker/u8:7 Tainted: P O
  Hardware name: Realtek_RTD1296 (DT)
  Workqueue: writeback wb_workfn (flush-btrfs-1)
  task: ffffffc076db3380 ti: ffffffc02e9ac000 task.ti: ffffffc02e9ac000
  PC is at clear_page_dirty_for_io+0x1bc/0x1e8
  LR is at clear_page_dirty_for_io+0x14/0x1e8
  pc : [<ffffffc00033c91c>] lr : [<ffffffc00033c774>] pstate: 40000145
  sp : ffffffc02e9af4f0
  Process kworker/u8:7 (pid: 31525, stack limit = 0xffffffc02e9ac020)
  Call trace:
  [<ffffffc00033c91c>] clear_page_dirty_for_io+0x1bc/0x1e8
  [<ffffffbffc514674>] extent_clear_unlock_delalloc+0x1e4/0x210 [btrfs]
  [<ffffffbffc4fb168>] run_delalloc_nocow+0x3b8/0x948 [btrfs]
  [<ffffffbffc4fb948>] run_delalloc_range+0x250/0x3a8 [btrfs]
  [<ffffffbffc514c0c>] writepage_delalloc.isra.21+0xbc/0x1d8 [btrfs]
  [<ffffffbffc516048>] __extent_writepage+0xe8/0x248 [btrfs]
  [<ffffffbffc51630c>] extent_write_cache_pages.isra.17+0x164/0x378 [btrfs]
  [<ffffffbffc5185a8>] extent_writepages+0x48/0x68 [btrfs]
  [<ffffffbffc4f5828>] btrfs_writepages+0x20/0x30 [btrfs]
  [<ffffffc00033d758>] do_writepages+0x30/0x88
  [<ffffffc0003ba0f4>] __writeback_single_inode+0x34/0x198
  [<ffffffc0003ba6c4>] writeback_sb_inodes+0x184/0x3c0
  [<ffffffc0003ba96c>] __writeback_inodes_wb+0x6c/0xc0
  [<ffffffc0003bac20>] wb_writeback+0x1b8/0x1c0
  [<ffffffc0003bb0f0>] wb_workfn+0x150/0x250
  [<ffffffc0002b0014>] process_one_work+0x1dc/0x388
  [<ffffffc0002b02f0>] worker_thread+0x130/0x500
  [<ffffffc0002b6344>] kthread+0x10c/0x110
  [<ffffffc000284590>] ret_from_fork+0x10/0x40
  Code: d503201f a9025bb5 a90363b7 f90023b9 (d4210000)

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1449,12 +1449,11 @@ out_check:
 	}
 	btrfs_release_path(path);
 
-	if (cur_offset <= end && cow_start == (u64)-1) {
+	if (cur_offset <= end && cow_start == (u64)-1)
 		cow_start = cur_offset;
-		cur_offset = end;
-	}
 
 	if (cow_start != (u64)-1) {
+		cur_offset = end;
 		ret = cow_file_range(inode, locked_page, cow_start, end,
 				     page_started, nr_written, 1);
 		if (ret)

