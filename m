Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB1FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B0C206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfAICBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:01:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17092 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728593AbfAICBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:01:52 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 639CB66647991744F19D;
        Wed,  9 Jan 2019 10:01:50 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Wed, 9 Jan 2019
 10:01:44 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <v9fs-developer@lists.sourceforge.net>
CC:     <asmadeus@codewreck.org>, <lucho@ionkov.net>, <ericvh@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xingaopeng@huawei.com>, <houtao1@huawei.com>
Subject: [PATCH] 9p: use inode->i_lock to protect i_size_write()
Date:   Wed, 9 Jan 2019 10:05:22 +0800
Message-ID: <20190109020522.105713-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use inode->i_lock to protect i_size_write(), else i_size_read() in
generic_fillattr() may loop infinitely when multiple processes invoke
v9fs_vfs_getattr() or v9fs_vfs_getattr_dotl() simultaneously under
32-bit SMP environment, and a soft lockup will be triggered as show below:

  watchdog: BUG: soft lockup - CPU#5 stuck for 22s! [stat:2217]
  Modules linked in:
  CPU: 5 PID: 2217 Comm: stat Not tainted 5.0.0-rc1-00005-g7f702faf5a9e #4
  Hardware name: Generic DT based system
  PC is at generic_fillattr+0x104/0x108
  LR is at 0xec497f00
  pc : [<802b8898>]    lr : [<ec497f00>]    psr: 200c0013
  sp : ec497e20  ip : ed608030  fp : ec497e3c
  r10: 00000000  r9 : ec497f00  r8 : ed608030
  r7 : ec497ebc  r6 : ec497f00  r5 : ee5c1550  r4 : ee005780
  r3 : 0000052d  r2 : 00000000  r1 : ec497f00  r0 : ed608030
  Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
  Control: 10c5387d  Table: ac48006a  DAC: 00000051
  CPU: 5 PID: 2217 Comm: stat Not tainted 5.0.0-rc1-00005-g7f702faf5a9e #4
  Hardware name: Generic DT based system
  Backtrace:
  [<8010d974>] (dump_backtrace) from [<8010dc88>] (show_stack+0x20/0x24)
  [<8010dc68>] (show_stack) from [<80a1d194>] (dump_stack+0xb0/0xdc)
  [<80a1d0e4>] (dump_stack) from [<80109f34>] (show_regs+0x1c/0x20)
  [<80109f18>] (show_regs) from [<801d0a80>] (watchdog_timer_fn+0x280/0x2f8)
  [<801d0800>] (watchdog_timer_fn) from [<80198658>] (__hrtimer_run_queues+0x18c/0x380)
  [<801984cc>] (__hrtimer_run_queues) from [<80198e60>] (hrtimer_run_queues+0xb8/0xf0)
  [<80198da8>] (hrtimer_run_queues) from [<801973e8>] (run_local_timers+0x28/0x64)
  [<801973c0>] (run_local_timers) from [<80197460>] (update_process_times+0x3c/0x6c)
  [<80197424>] (update_process_times) from [<801ab2b8>] (tick_nohz_handler+0xe0/0x1bc)
  [<801ab1d8>] (tick_nohz_handler) from [<80843050>] (arch_timer_handler_virt+0x38/0x48)
  [<80843018>] (arch_timer_handler_virt) from [<80180a64>] (handle_percpu_devid_irq+0x8c/0x240)
  [<801809d8>] (handle_percpu_devid_irq) from [<8017ac20>] (generic_handle_irq+0x34/0x44)
  [<8017abec>] (generic_handle_irq) from [<8017b344>] (__handle_domain_irq+0x6c/0xc4)
  [<8017b2d8>] (__handle_domain_irq) from [<801022e0>] (gic_handle_irq+0x4c/0x88)
  [<80102294>] (gic_handle_irq) from [<80101a30>] (__irq_svc+0x70/0x98)
  [<802b8794>] (generic_fillattr) from [<8056b284>] (v9fs_vfs_getattr_dotl+0x74/0xa4)
  [<8056b210>] (v9fs_vfs_getattr_dotl) from [<802b8904>] (vfs_getattr_nosec+0x68/0x7c)
  [<802b889c>] (vfs_getattr_nosec) from [<802b895c>] (vfs_getattr+0x44/0x48)
  [<802b8918>] (vfs_getattr) from [<802b8a74>] (vfs_statx+0x9c/0xec)
  [<802b89d8>] (vfs_statx) from [<802b9428>] (sys_lstat64+0x48/0x78)
  [<802b93e0>] (sys_lstat64) from [<80101000>] (ret_fast_syscall+0x0/0x28)

Reported-by: Xing Gaopeng <xingaopeng@huawei.com>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/9p/vfs_inode.c      | 9 ++++++---
 fs/9p/vfs_inode_dotl.c | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 85ff859d3af5..36405361c2e1 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1074,6 +1074,7 @@ v9fs_vfs_getattr(const struct path *path, struct kstat *stat,
 		 u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
+	struct inode *inode = d_inode(dentry);
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid;
 	struct p9_wstat *st;
@@ -1081,7 +1082,7 @@ v9fs_vfs_getattr(const struct path *path, struct kstat *stat,
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
-		generic_fillattr(d_inode(dentry), stat);
+		generic_fillattr(inode, stat);
 		return 0;
 	}
 	fid = v9fs_fid_lookup(dentry);
@@ -1092,8 +1093,10 @@ v9fs_vfs_getattr(const struct path *path, struct kstat *stat,
 	if (IS_ERR(st))
 		return PTR_ERR(st);
 
-	v9fs_stat2inode(st, d_inode(dentry), dentry->d_sb);
-	generic_fillattr(d_inode(dentry), stat);
+	spin_lock(&inode->i_lock);
+	v9fs_stat2inode(st, inode, dentry->d_sb);
+	spin_unlock(&inode->i_lock);
+	generic_fillattr(inode, stat);
 
 	p9stat_free(st);
 	kfree(st);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 4823e1c46999..ac7d0c9f81c9 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -474,6 +474,7 @@ v9fs_vfs_getattr_dotl(const struct path *path, struct kstat *stat,
 		 u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
+	struct inode *inode = d_inode(dentry);
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid;
 	struct p9_stat_dotl *st;
@@ -481,7 +482,7 @@ v9fs_vfs_getattr_dotl(const struct path *path, struct kstat *stat,
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
-		generic_fillattr(d_inode(dentry), stat);
+		generic_fillattr(inode, stat);
 		return 0;
 	}
 	fid = v9fs_fid_lookup(dentry);
@@ -496,8 +497,10 @@ v9fs_vfs_getattr_dotl(const struct path *path, struct kstat *stat,
 	if (IS_ERR(st))
 		return PTR_ERR(st);
 
-	v9fs_stat2inode_dotl(st, d_inode(dentry));
-	generic_fillattr(d_inode(dentry), stat);
+	spin_lock(&inode->i_lock);
+	v9fs_stat2inode_dotl(st, inode);
+	spin_unlock(&inode->i_lock);
+	generic_fillattr(inode, stat);
 	/* Change block size to what the server returned */
 	stat->blksize = st->st_blksize;
 
-- 
2.16.2.dirty

