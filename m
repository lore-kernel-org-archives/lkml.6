Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4EFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54482147A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdhE8+pW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54482147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390983AbeKTDSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390256AbeKTDSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:18:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4957206BA;
        Mon, 19 Nov 2018 16:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646461;
        bh=0KBF25V6uuIiAWjujCsWPt+ABKxf3GKAXaqSW1cc1EA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XdhE8+pWiQTj57W3dxJ/0dxgK4tK8uxEJkIAvrc/lk0bMYTXpFy/HI1PsC2nXD/Ik
         QG1i3AcdN5ijry/v5CG0WiwpiaW8gUeh4ehdvDvH8Je+lTCtgLrXH5WbRkmj4HfO5S
         NHNdbSNsoaPDzdsAqLAVI0ghvpJ1U4ZjtolH73rg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Robbie Ko <robbieko@synology.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 50/83] Btrfs: fix cur_offset in the error case for nocow
Date:   Mon, 19 Nov 2018 17:29:16 +0100
Message-Id: <20181119162622.388614463@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1548,12 +1548,11 @@ out_check:
 	}
 	btrfs_release_path(path);
 
-	if (cur_offset <= end && cow_start == (u64)-1) {
+	if (cur_offset <= end && cow_start == (u64)-1)
 		cow_start = cur_offset;
-		cur_offset = end;
-	}
 
 	if (cow_start != (u64)-1) {
+		cur_offset = end;
 		ret = cow_file_range(inode, locked_page, cow_start, end, end,
 				     page_started, nr_written, 1, NULL);
 		if (ret)


