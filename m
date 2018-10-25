Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D30C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C645E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sL09Y0wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C645E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbeJYWss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbeJYWsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:47 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B5142085A;
        Thu, 25 Oct 2018 14:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476949;
        bh=iG19hBEK9GwAqm5FU8Rdr9J4K/4clnKK6EYbRrflYVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sL09Y0whIyT+UPX4OrTHeEoU1ZwEYbN1sWBp527pGBezEOFz9PzALulaUPM4We8Se
         vnDq7WUIzxc5W+b9tMbTA4C/Kr7EXScFohuZcsu9jFhkMpH/PrJobtoSiqV0iQQdkd
         4Z7IEtw44WCs4mwyHJLUc/1boq/OxIV6hPRdwc1E=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Ren <zren@suse.com>, Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 58/98] ocfs2: fix deadlock caused by recursive locking in xattr
Date:   Thu, 25 Oct 2018 10:13:43 -0400
Message-Id: <20181025141423.213774-58-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Ren <zren@suse.com>

[ Upstream commit 8818efaaacb78c60a9d90c5705b6c99b75d7d442 ]

Another deadlock path caused by recursive locking is reported.  This
kind of issue was introduced since commit 743b5f1434f5 ("ocfs2: take
inode lock in ocfs2_iop_set/get_acl()").  Two deadlock paths have been
fixed by commit b891fa5024a9 ("ocfs2: fix deadlock issue when taking
inode lock at vfs entry points").  Yes, we intend to fix this kind of
case in incremental way, because it's hard to find out all possible
paths at once.

This one can be reproduced like this.  On node1, cp a large file from
home directory to ocfs2 mountpoint.  While on node2, run
setfacl/getfacl.  Both nodes will hang up there.  The backtraces:

On node1:
  __ocfs2_cluster_lock.isra.39+0x357/0x740 [ocfs2]
  ocfs2_inode_lock_full_nested+0x17d/0x840 [ocfs2]
  ocfs2_write_begin+0x43/0x1a0 [ocfs2]
  generic_perform_write+0xa9/0x180
  __generic_file_write_iter+0x1aa/0x1d0
  ocfs2_file_write_iter+0x4f4/0xb40 [ocfs2]
  __vfs_write+0xc3/0x130
  vfs_write+0xb1/0x1a0
  SyS_write+0x46/0xa0

On node2:
  __ocfs2_cluster_lock.isra.39+0x357/0x740 [ocfs2]
  ocfs2_inode_lock_full_nested+0x17d/0x840 [ocfs2]
  ocfs2_xattr_set+0x12e/0xe80 [ocfs2]
  ocfs2_set_acl+0x22d/0x260 [ocfs2]
  ocfs2_iop_set_acl+0x65/0xb0 [ocfs2]
  set_posix_acl+0x75/0xb0
  posix_acl_xattr_set+0x49/0xa0
  __vfs_setxattr+0x69/0x80
  __vfs_setxattr_noperm+0x72/0x1a0
  vfs_setxattr+0xa7/0xb0
  setxattr+0x12d/0x190
  path_setxattr+0x9f/0xb0
  SyS_setxattr+0x14/0x20

Fix this one by using ocfs2_inode_{lock|unlock}_tracker, which is
exported by commit 439a36b8ef38 ("ocfs2/dlmglue: prepare tracking logic
to avoid recursive cluster lock").

Link: http://lkml.kernel.org/r/20170622014746.5815-1-zren@suse.com
Fixes: 743b5f1434f5 ("ocfs2: take inode lock in ocfs2_iop_set/get_acl()")
Signed-off-by: Eric Ren <zren@suse.com>
Reported-by: Thomas Voegtle <tv@lio96.de>
Tested-by: Thomas Voegtle <tv@lio96.de>
Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/dlmglue.c |  4 ++++
 fs/ocfs2/xattr.c   | 23 +++++++++++++----------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 785fcc29d85d..5729d55da67d 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2599,6 +2599,10 @@ void ocfs2_inode_unlock_tracker(struct inode *inode,
 	struct ocfs2_lock_res *lockres;
 
 	lockres = &OCFS2_I(inode)->ip_inode_lockres;
+	/* had_lock means that the currect process already takes the cluster
+	 * lock previously. If had_lock is 1, we have nothing to do here, and
+	 * it will get unlocked where we got the lock.
+	 */
 	if (!had_lock) {
 		ocfs2_remove_holder(lockres, oh);
 		ocfs2_inode_unlock(inode, ex);
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 03f6ff249edb..01932763b4d1 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1330,20 +1330,21 @@ static int ocfs2_xattr_get(struct inode *inode,
 			   void *buffer,
 			   size_t buffer_size)
 {
-	int ret;
+	int ret, had_lock;
 	struct buffer_head *di_bh = NULL;
+	struct ocfs2_lock_holder oh;
 
-	ret = ocfs2_inode_lock(inode, &di_bh, 0);
-	if (ret < 0) {
-		mlog_errno(ret);
-		return ret;
+	had_lock = ocfs2_inode_lock_tracker(inode, &di_bh, 0, &oh);
+	if (had_lock < 0) {
+		mlog_errno(had_lock);
+		return had_lock;
 	}
 	down_read(&OCFS2_I(inode)->ip_xattr_sem);
 	ret = ocfs2_xattr_get_nolock(inode, di_bh, name_index,
 				     name, buffer, buffer_size);
 	up_read(&OCFS2_I(inode)->ip_xattr_sem);
 
-	ocfs2_inode_unlock(inode, 0);
+	ocfs2_inode_unlock_tracker(inode, 0, &oh, had_lock);
 
 	brelse(di_bh);
 
@@ -3539,11 +3540,12 @@ int ocfs2_xattr_set(struct inode *inode,
 {
 	struct buffer_head *di_bh = NULL;
 	struct ocfs2_dinode *di;
-	int ret, credits, ref_meta = 0, ref_credits = 0;
+	int ret, credits, had_lock, ref_meta = 0, ref_credits = 0;
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 	struct inode *tl_inode = osb->osb_tl_inode;
 	struct ocfs2_xattr_set_ctxt ctxt = { NULL, NULL, NULL, };
 	struct ocfs2_refcount_tree *ref_tree = NULL;
+	struct ocfs2_lock_holder oh;
 
 	struct ocfs2_xattr_info xi = {
 		.xi_name_index = name_index,
@@ -3574,8 +3576,9 @@ int ocfs2_xattr_set(struct inode *inode,
 		return -ENOMEM;
 	}
 
-	ret = ocfs2_inode_lock(inode, &di_bh, 1);
-	if (ret < 0) {
+	had_lock = ocfs2_inode_lock_tracker(inode, &di_bh, 1, &oh);
+	if (had_lock < 0) {
+		ret = had_lock;
 		mlog_errno(ret);
 		goto cleanup_nolock;
 	}
@@ -3672,7 +3675,7 @@ int ocfs2_xattr_set(struct inode *inode,
 		if (ret)
 			mlog_errno(ret);
 	}
-	ocfs2_inode_unlock(inode, 1);
+	ocfs2_inode_unlock_tracker(inode, 1, &oh, had_lock);
 cleanup_nolock:
 	brelse(di_bh);
 	brelse(xbs.xattr_bh);
-- 
2.17.1

