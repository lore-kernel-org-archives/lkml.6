Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AC1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBC920871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1M94fPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBC920871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391388AbeKLI1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:27:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405154AbeKLIZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:25:22 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2254D223C8;
        Sun, 11 Nov 2018 22:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975723;
        bh=0rM7yahSBuOVsZZWLLl96iZrSjw9S52LgdD0tficSXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1M94fPoluw3g72KJlGtHyomsy8HDVO52vRpekUW01tcdGl9uIwabRWte7k31vXyw
         +EeW9kVmIH3/r3xfLEkajlTE7ZiPA8NTVNzN6UsoSw5Xgw9CZChQF1jCC+mnwLTHXr
         lD0249R7cz3DRI2xwE05Ijb2ncRmY7i3sf+bGjRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Wen <wen.xu@gatech.edu>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 131/141] btrfs: locking: Add extra check in btrfs_init_new_buffer() to avoid deadlock
Date:   Sun, 11 Nov 2018 14:26:30 -0800
Message-Id: <20181111221645.917233816@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
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

From: Qu Wenruo <wqu@suse.com>

commit b72c3aba09a53fc7c1824250d71180ca154517a7 upstream.

[BUG]
For certain crafted image, whose csum root leaf has missing backref, if
we try to trigger write with data csum, it could cause deadlock with the
following kernel WARN_ON():

  WARNING: CPU: 1 PID: 41 at fs/btrfs/locking.c:230 btrfs_tree_lock+0x3e2/0x400
  CPU: 1 PID: 41 Comm: kworker/u4:1 Not tainted 4.18.0-rc1+ #8
  Workqueue: btrfs-endio-write btrfs_endio_write_helper
  RIP: 0010:btrfs_tree_lock+0x3e2/0x400
  Call Trace:
   btrfs_alloc_tree_block+0x39f/0x770
   __btrfs_cow_block+0x285/0x9e0
   btrfs_cow_block+0x191/0x2e0
   btrfs_search_slot+0x492/0x1160
   btrfs_lookup_csum+0xec/0x280
   btrfs_csum_file_blocks+0x2be/0xa60
   add_pending_csums+0xaf/0xf0
   btrfs_finish_ordered_io+0x74b/0xc90
   finish_ordered_fn+0x15/0x20
   normal_work_helper+0xf6/0x500
   btrfs_endio_write_helper+0x12/0x20
   process_one_work+0x302/0x770
   worker_thread+0x81/0x6d0
   kthread+0x180/0x1d0
   ret_from_fork+0x35/0x40

[CAUSE]
That crafted image has missing backref for csum tree root leaf.  And
when we try to allocate new tree block, since there is no
EXTENT/METADATA_ITEM for csum tree root, btrfs consider it's free slot
and use it.

The extent tree of the image looks like:

  Normal image                      |       This fuzzed image
  ----------------------------------+--------------------------------
  BG 29360128                       | BG 29360128
   One empty slot                   |  One empty slot
  29364224: backref to UUID tree    | 29364224: backref to UUID tree
   Two empty slots                  |  Two empty slots
  29376512: backref to CSUM tree    |  One empty slot (bad type) <<<
  29380608: backref to D_RELOC tree | 29380608: backref to D_RELOC tree
  ...                               | ...

Since bytenr 29376512 has no METADATA/EXTENT_ITEM, when btrfs try to
alloc tree block, it's an valid slot for btrfs.

And for finish_ordered_write, when we need to insert csum, we try to CoW
csum tree root.

By accident, empty slots at bytenr BG_OFFSET, BG_OFFSET + 8K,
BG_OFFSET + 12K is already used by tree block COW for other trees, the
next empty slot is BG_OFFSET + 16K, which should be the backref for CSUM
tree.

But due to the bad type, btrfs can recognize it and still consider it as
an empty slot, and will try to use it for csum tree CoW.

Then in the following call trace, we will try to lock the new tree
block, which turns out to be the old csum tree root which is already
locked:

btrfs_search_slot() called on csum tree root, which is at 29376512
|- btrfs_cow_block()
   |- btrfs_set_lock_block()
   |  |- Now locks tree block 29376512 (old csum tree root)
   |- __btrfs_cow_block()
      |- btrfs_alloc_tree_block()
         |- btrfs_reserve_extent()
            | Now it returns tree block 29376512, which extent tree
            | shows its empty slot, but it's already hold by csum tree
            |- btrfs_init_new_buffer()
               |- btrfs_tree_lock()
                  | Triggers WARN_ON(eb->lock_owner == current->pid)
                  |- wait_event()
                     Wait lock owner to release the lock, but it's
                     locked by ourself, so it will deadlock

[FIX]
This patch will do the lock_owner and current->pid check at
btrfs_init_new_buffer().
So above deadlock can be avoided.

Since such problem can only happen in crafted image, we will still
trigger kernel warning for later aborted transaction, but with a little
more meaningful warning message.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200405
Reported-by: Xu Wen <wen.xu@gatech.edu>
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -8263,6 +8263,19 @@ btrfs_init_new_buffer(struct btrfs_trans
 	if (IS_ERR(buf))
 		return buf;
 
+	/*
+	 * Extra safety check in case the extent tree is corrupted and extent
+	 * allocator chooses to use a tree block which is already used and
+	 * locked.
+	 */
+	if (buf->lock_owner == current->pid) {
+		btrfs_err_rl(root->fs_info,
+"tree block %llu owner %llu already locked by pid=%d, extent tree corruption detected",
+			buf->start, btrfs_header_owner(buf), current->pid);
+		free_extent_buffer(buf);
+		return ERR_PTR(-EUCLEAN);
+	}
+
 	btrfs_set_header_generation(buf, trans->transid);
 	btrfs_set_buffer_lockdep_class(root->root_key.objectid, buf, level);
 	btrfs_tree_lock(buf);


