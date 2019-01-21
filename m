Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB32C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE1121726
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079278;
	bh=ifxP1m7e5A/l8QwWH495QB2mBnz4J/aLxQJQMK5nzM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bO1WO2fl2Og1KFZ/otwBidNkvvdjSQHRRK8iUFXtGmjEZnAu1i54I2vaMLrxyMwGq
	 Jzk/R9y09V1wPgtPiULK6OUqGHqm64/c7nFCnnG6Y5TasClo/pJ5qag+u3p0RuLkFC
	 tb2zKVOI1rzI8VBgBVQeFwi2WxkprmBNzwEfSt2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbfAUOBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:01:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732131AbfAUOBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:01:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59322214D8;
        Mon, 21 Jan 2019 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079272;
        bh=ifxP1m7e5A/l8QwWH495QB2mBnz4J/aLxQJQMK5nzM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jl5ZbzvHS7Fv6fnmhPQA5OgykzIeG/ye3FyyTrzFMvCuKPNDSnlciD2YlFSyJ8eCB
         T2DxfPIV7PKueGCV83hDzttko5kGbUnoOb8Jq5qAJlY7OYqLw7l++yQ4Cfi9tYbfcn
         sy1nyha8D45+VHHrHYLV2OKFxNsP6wPZq9QL0hlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Mason <clm@fb.com>,
        ethanlien <ethanlien@synology.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 40/99] Revert "btrfs: balance dirty metadata pages in btrfs_finish_ordered_io"
Date:   Mon, 21 Jan 2019 14:48:32 +0100
Message-Id: <20190121134915.423786941@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

From: David Sterba <dsterba@suse.com>

commit 77b7aad195099e7c6da11e94b7fa6ef5e6fb0025 upstream.

This reverts commit e73e81b6d0114d4a303205a952ab2e87c44bd279.

This patch causes a few problems:

- adds latency to btrfs_finish_ordered_io
- as btrfs_finish_ordered_io is used for free space cache, generating
  more work from btrfs_btree_balance_dirty_nodelay could end up in the
  same workque, effectively deadlocking

12260 kworker/u96:16+btrfs-freespace-write D
[<0>] balance_dirty_pages+0x6e6/0x7ad
[<0>] balance_dirty_pages_ratelimited+0x6bb/0xa90
[<0>] btrfs_finish_ordered_io+0x3da/0x770
[<0>] normal_work_helper+0x1c5/0x5a0
[<0>] process_one_work+0x1ee/0x5a0
[<0>] worker_thread+0x46/0x3d0
[<0>] kthread+0xf5/0x130
[<0>] ret_from_fork+0x24/0x30
[<0>] 0xffffffffffffffff

Transaction commit will wait on the freespace cache:

838 btrfs-transacti D
[<0>] btrfs_start_ordered_extent+0x154/0x1e0
[<0>] btrfs_wait_ordered_range+0xbd/0x110
[<0>] __btrfs_wait_cache_io+0x49/0x1a0
[<0>] btrfs_write_dirty_block_groups+0x10b/0x3b0
[<0>] commit_cowonly_roots+0x215/0x2b0
[<0>] btrfs_commit_transaction+0x37e/0x910
[<0>] transaction_kthread+0x14d/0x180
[<0>] kthread+0xf5/0x130
[<0>] ret_from_fork+0x24/0x30
[<0>] 0xffffffffffffffff

And then writepages ends up waiting on transaction commit:

9520 kworker/u96:13+flush-btrfs-1 D
[<0>] wait_current_trans+0xac/0xe0
[<0>] start_transaction+0x21b/0x4b0
[<0>] cow_file_range_inline+0x10b/0x6b0
[<0>] cow_file_range.isra.69+0x329/0x4a0
[<0>] run_delalloc_range+0x105/0x3c0
[<0>] writepage_delalloc+0x119/0x180
[<0>] __extent_writepage+0x10c/0x390
[<0>] extent_write_cache_pages+0x26f/0x3d0
[<0>] extent_writepages+0x4f/0x80
[<0>] do_writepages+0x17/0x60
[<0>] __writeback_single_inode+0x59/0x690
[<0>] writeback_sb_inodes+0x291/0x4e0
[<0>] __writeback_inodes_wb+0x87/0xb0
[<0>] wb_writeback+0x3bb/0x500
[<0>] wb_workfn+0x40d/0x610
[<0>] process_one_work+0x1ee/0x5a0
[<0>] worker_thread+0x1e0/0x3d0
[<0>] kthread+0xf5/0x130
[<0>] ret_from_fork+0x24/0x30
[<0>] 0xffffffffffffffff

Eventually, we have every process in the system waiting on
balance_dirty_pages(), and nobody is able to make progress on page
writeback.

The original patch tried to fix an OOM condition, that happened on 4.4 but no
success reproducing that on later kernels (4.19 and 4.20). This is more likely
a problem in OOM itself.

Link: https://lore.kernel.org/linux-btrfs/20180528054821.9092-1-ethanlien@synology.com/
Reported-by: Chris Mason <clm@fb.com>
CC: stable@vger.kernel.org # 4.18+
CC: ethanlien <ethanlien@synology.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3151,9 +3151,6 @@ out:
 	/* once for the tree */
 	btrfs_put_ordered_extent(ordered_extent);
 
-	/* Try to release some metadata so we don't get an OOM but don't wait */
-	btrfs_btree_balance_dirty_nodelay(fs_info);
-
 	return ret;
 }
 


