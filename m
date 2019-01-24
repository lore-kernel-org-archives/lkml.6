Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0F1C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC64E218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357853;
	bh=lZhTJAenG2O5az024YYu1FzygnGEigmOktELJqIndlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RWCJ+9or+LR9SUC3Lbwq7fkUTNAMD4iQkYjW3GzRICuSmltke6+JKsM8FWpyghJzL
	 ceXXiVmXrCUwT1oAMEdaT9UTA4wiULRDWBlEdylL2mxx+C3H6Ve5bfyz/BhXJslMTY
	 9pgoGpsmr1hT8OWMDus40pCBdHMC5lbZ6Vt8fHDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfAXTYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:24:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729497AbfAXTYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:24:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A180218D2;
        Thu, 24 Jan 2019 19:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357848;
        bh=lZhTJAenG2O5az024YYu1FzygnGEigmOktELJqIndlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHBLuRCXVBdEeFnYHbn6qxaHLsv02LkeKx+IQLsKBIl4q0DNtmZnehoD6Vwg4a0xE
         OpR51VWui69x9iRiVBS8nNFlw3xE4I65ezehQICK5nsncxROxpxhyupWXwR+pKgFq9
         z0d0zEOjY7dQ9LA4M/gpue10uWQ0OfyR8B3nVPmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 010/104] f2fs: fix inode cache leak
Date:   Thu, 24 Jan 2019 20:18:59 +0100
Message-Id: <20190124190156.040273008@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

From: Chao Yu <yuchao0@huawei.com>

commit f61cce5b81f91ba336184008b24baec84afbb3dd upstream.

When testing f2fs with inline_dentry option, generic/342 reports:
VFS: Busy inodes after unmount of dm-0. Self-destruct in 5 seconds.  Have a nice day...

After rmmod f2fs module, kenrel shows following dmesg:
 =============================================================================
 BUG f2fs_inode_cache (Tainted: G           O   ): Objects remaining in f2fs_inode_cache on __kmem_cache_shutdown()
 -----------------------------------------------------------------------------

 Disabling lock debugging due to kernel taint
 INFO: Slab 0xf51ca0e0 objects=22 used=1 fp=0xd1e6fc60 flags=0x40004080
 CPU: 3 PID: 7455 Comm: rmmod Tainted: G    B      O    4.6.0-rc4+ #16
 Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
  00000086 00000086 d062fe18 c13a83a0 f51ca0e0 d062fe38 d062fea4 c11c7276
  c1981040 f51ca0e0 00000016 00000001 d1e6fc60 40004080 656a624f 20737463
  616d6572 6e696e69 6e692067 66326620 6e695f73 5f65646f 68636163 6e6f2065
 Call Trace:
  [<c13a83a0>] dump_stack+0x5f/0x8f
  [<c11c7276>] slab_err+0x76/0x80
  [<c11cbfc0>] ? __kmem_cache_shutdown+0x100/0x2f0
  [<c11cbfc0>] ? __kmem_cache_shutdown+0x100/0x2f0
  [<c11cbfe5>] __kmem_cache_shutdown+0x125/0x2f0
  [<c1198a38>] kmem_cache_destroy+0x158/0x1f0
  [<c176b43d>] ? mutex_unlock+0xd/0x10
  [<f8f15aa3>] exit_f2fs_fs+0x4b/0x5a8 [f2fs]
  [<c10f596c>] SyS_delete_module+0x16c/0x1d0
  [<c1001b10>] ? do_fast_syscall_32+0x30/0x1c0
  [<c13c59bf>] ? __this_cpu_preempt_check+0xf/0x20
  [<c10afa7d>] ? trace_hardirqs_on_caller+0xdd/0x210
  [<c10ad50b>] ? trace_hardirqs_off+0xb/0x10
  [<c1001b81>] do_fast_syscall_32+0xa1/0x1c0
  [<c176d888>] sysenter_past_esp+0x45/0x74
 INFO: Object 0xd1e6d9e0 @offset=6624
 kmem_cache_destroy f2fs_inode_cache: Slab cache still has objects
 CPU: 3 PID: 7455 Comm: rmmod Tainted: G    B      O    4.6.0-rc4+ #16
 Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
  00000286 00000286 d062fef4 c13a83a0 f174b000 d062ff14 d062ff28 c1198ac7
  c197fe18 f3c5b980 d062ff20 000d04f2 d062ff0c d062ff0c d062ff14 d062ff14
  f8f20dc0 fffffff5 d062e000 d062ff30 f8f15aa3 d062ff7c c10f596c 73663266
 Call Trace:
  [<c13a83a0>] dump_stack+0x5f/0x8f
  [<c1198ac7>] kmem_cache_destroy+0x1e7/0x1f0
  [<f8f15aa3>] exit_f2fs_fs+0x4b/0x5a8 [f2fs]
  [<c10f596c>] SyS_delete_module+0x16c/0x1d0
  [<c1001b10>] ? do_fast_syscall_32+0x30/0x1c0
  [<c13c59bf>] ? __this_cpu_preempt_check+0xf/0x20
  [<c10afa7d>] ? trace_hardirqs_on_caller+0xdd/0x210
  [<c10ad50b>] ? trace_hardirqs_off+0xb/0x10
  [<c1001b81>] do_fast_syscall_32+0xa1/0x1c0
  [<c176d888>] sysenter_past_esp+0x45/0x74

The reason is: in recovery flow, we use delayed iput mechanism for directory
which has recovered dentry block. It means the reference of inode will be
held until last dirty dentry page being writebacked.

But when we mount f2fs with inline_dentry option, during recovery, dirent
may only be recovered into dir inode page rather than dentry page, so there
are no chance for us to release inode reference in ->writepage when
writebacking last dentry page.

We can call paired iget/iput explicityly for inline_dentry case, but for
non-inline_dentry case, iput will call writeback_single_inode to write all
data pages synchronously, but during recovery, ->writepages of f2fs skips
writing all pages, result in losing dirent.

This patch fixes this issue by obsoleting old mechanism, and introduce a
new dir_list to hold all directory inodes which has recovered datas until
finishing recovery.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 4.4:
 - Deleted add_dirty_dir_inode() function is different
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/checkpoint.c |   24 ---------------------
 fs/f2fs/f2fs.h       |    2 -
 fs/f2fs/recovery.c   |   56 ++++++++++++++++++++++++++++-----------------------
 3 files changed, 31 insertions(+), 51 deletions(-)

--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -771,24 +771,6 @@ out:
 	f2fs_trace_pid(page);
 }
 
-void add_dirty_dir_inode(struct inode *inode)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct inode_entry *new =
-			f2fs_kmem_cache_alloc(inode_entry_slab, GFP_NOFS);
-	int ret = 0;
-
-	new->inode = inode;
-	INIT_LIST_HEAD(&new->list);
-
-	spin_lock(&sbi->dir_inode_lock);
-	ret = __add_dirty_inode(inode, new);
-	spin_unlock(&sbi->dir_inode_lock);
-
-	if (ret)
-		kmem_cache_free(inode_entry_slab, new);
-}
-
 void remove_dirty_dir_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -811,12 +793,6 @@ void remove_dirty_dir_inode(struct inode
 	stat_dec_dirty_dir(sbi);
 	spin_unlock(&sbi->dir_inode_lock);
 	kmem_cache_free(inode_entry_slab, entry);
-
-	/* Only from the recovery routine */
-	if (is_inode_flag_set(F2FS_I(inode), FI_DELAY_IPUT)) {
-		clear_inode_flag(F2FS_I(inode), FI_DELAY_IPUT);
-		iput(inode);
-	}
 }
 
 void sync_dirty_dir_inodes(struct f2fs_sb_info *sbi)
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1402,7 +1402,6 @@ enum {
 	FI_NO_ALLOC,		/* should not allocate any blocks */
 	FI_FREE_NID,		/* free allocated nide */
 	FI_UPDATE_DIR,		/* should update inode block for consistency */
-	FI_DELAY_IPUT,		/* used for the recovery */
 	FI_NO_EXTENT,		/* not to use the extent cache */
 	FI_INLINE_XATTR,	/* used for inline xattr */
 	FI_INLINE_DATA,		/* used for inline data*/
@@ -1828,7 +1827,6 @@ void remove_orphan_inode(struct f2fs_sb_
 int recover_orphan_inodes(struct f2fs_sb_info *);
 int get_valid_checkpoint(struct f2fs_sb_info *);
 void update_dirty_page(struct inode *, struct page *);
-void add_dirty_dir_inode(struct inode *);
 void remove_dirty_dir_inode(struct inode *);
 void sync_dirty_dir_inodes(struct f2fs_sb_info *);
 void write_checkpoint(struct f2fs_sb_info *, struct cp_control *);
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -89,7 +89,8 @@ static void del_fsync_inode(struct fsync
 	kmem_cache_free(fsync_entry_slab, entry);
 }
 
-static int recover_dentry(struct inode *inode, struct page *ipage)
+static int recover_dentry(struct inode *inode, struct page *ipage,
+						struct list_head *dir_list)
 {
 	struct f2fs_inode *raw_inode = F2FS_INODE(ipage);
 	nid_t pino = le32_to_cpu(raw_inode->i_pino);
@@ -97,18 +98,29 @@ static int recover_dentry(struct inode *
 	struct qstr name;
 	struct page *page;
 	struct inode *dir, *einode;
+	struct fsync_inode_entry *entry;
 	int err = 0;
 
-	dir = f2fs_iget(inode->i_sb, pino);
-	if (IS_ERR(dir)) {
-		err = PTR_ERR(dir);
-		goto out;
+	entry = get_fsync_inode(dir_list, pino);
+	if (!entry) {
+		dir = f2fs_iget(inode->i_sb, pino);
+		if (IS_ERR(dir)) {
+			err = PTR_ERR(dir);
+			goto out;
+		}
+
+		entry = add_fsync_inode(dir_list, dir);
+		if (!entry) {
+			err = -ENOMEM;
+			iput(dir);
+			goto out;
+		}
 	}
 
-	if (file_enc_name(inode)) {
-		iput(dir);
+	dir = entry->inode;
+
+	if (file_enc_name(inode))
 		return 0;
-	}
 
 	name.len = le32_to_cpu(raw_inode->i_namelen);
 	name.name = raw_inode->i_name;
@@ -116,7 +128,7 @@ static int recover_dentry(struct inode *
 	if (unlikely(name.len > F2FS_NAME_LEN)) {
 		WARN_ON(1);
 		err = -ENAMETOOLONG;
-		goto out_err;
+		goto out;
 	}
 retry:
 	de = f2fs_find_entry(dir, &name, &page);
@@ -142,23 +154,12 @@ retry:
 		goto retry;
 	}
 	err = __f2fs_add_link(dir, &name, inode, inode->i_ino, inode->i_mode);
-	if (err)
-		goto out_err;
-
-	if (is_inode_flag_set(F2FS_I(dir), FI_DELAY_IPUT)) {
-		iput(dir);
-	} else {
-		add_dirty_dir_inode(dir);
-		set_inode_flag(F2FS_I(dir), FI_DELAY_IPUT);
-	}
 
 	goto out;
 
 out_unmap_put:
 	f2fs_dentry_kunmap(dir, page);
 	f2fs_put_page(page, 0);
-out_err:
-	iput(dir);
 out:
 	f2fs_msg(inode->i_sb, KERN_NOTICE,
 			"%s: ino = %x, name = %s, dir = %lx, err = %d",
@@ -479,7 +480,8 @@ out:
 	return err;
 }
 
-static int recover_data(struct f2fs_sb_info *sbi, struct list_head *head)
+static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
+						struct list_head *dir_list)
 {
 	unsigned long long cp_ver = cur_cp_version(F2FS_CKPT(sbi));
 	struct curseg_info *curseg;
@@ -506,7 +508,7 @@ static int recover_data(struct f2fs_sb_i
 			break;
 		}
 
-		entry = get_fsync_inode(head, ino_of_node(page));
+		entry = get_fsync_inode(inode_list, ino_of_node(page));
 		if (!entry)
 			goto next;
 		/*
@@ -517,7 +519,7 @@ static int recover_data(struct f2fs_sb_i
 		if (entry->last_inode == blkaddr)
 			recover_inode(entry->inode, page);
 		if (entry->last_dentry == blkaddr) {
-			err = recover_dentry(entry->inode, page);
+			err = recover_dentry(entry->inode, page, dir_list);
 			if (err) {
 				f2fs_put_page(page, 1);
 				break;
@@ -545,6 +547,7 @@ int recover_fsync_data(struct f2fs_sb_in
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
 	struct list_head inode_list;
+	struct list_head dir_list;
 	block_t blkaddr;
 	int err;
 	int ret = 0;
@@ -556,6 +559,7 @@ int recover_fsync_data(struct f2fs_sb_in
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&inode_list);
+	INIT_LIST_HEAD(&dir_list);
 
 	/* prevent checkpoint */
 	mutex_lock(&sbi->cp_mutex);
@@ -575,12 +579,11 @@ int recover_fsync_data(struct f2fs_sb_in
 	need_writecp = true;
 
 	/* step #2: recover data */
-	err = recover_data(sbi, &inode_list);
+	err = recover_data(sbi, &inode_list, &dir_list);
 	if (!err)
 		f2fs_bug_on(sbi, !list_empty(&inode_list));
 out:
 	destroy_fsync_dnodes(&inode_list);
-	kmem_cache_destroy(fsync_entry_slab);
 
 	/* truncate meta pages to be used by the recovery */
 	truncate_inode_pages_range(META_MAPPING(sbi),
@@ -618,5 +621,8 @@ out:
 	} else {
 		mutex_unlock(&sbi->cp_mutex);
 	}
+
+	destroy_fsync_dnodes(&dir_list);
+	kmem_cache_destroy(fsync_entry_slab);
 	return ret ? ret: err;
 }


