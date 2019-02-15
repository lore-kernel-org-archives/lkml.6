Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB6BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3052073D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197539;
	bh=4HOsD54m5O9dFe7sXAZgxMGg9V5wBSI53XHaWeo07CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cFYmv32Zj0rRJCQ3OhvpNtoJ4AiD+H8EKeHLUSoAHv3odSAedLe3M1jPf2S6x/xTm
	 ujuasCWSCl7daHeGqtUOm+B6epWOy9LDpssPABawZYrZvf4ziS28FIWh1i4EsETyv5
	 rsPOGU21q3bMjfij0LnIRM5AsQqmWmt7wdZrwH74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfBOCZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:25:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391479AbfBOCOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:14:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8E0020643;
        Fri, 15 Feb 2019 02:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196843;
        bh=4HOsD54m5O9dFe7sXAZgxMGg9V5wBSI53XHaWeo07CQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=18v3JiU0KCa2/MZ0ygorlj1JFqFbXR1XjNbHjSKMOTgRrdFP41G0nqUgGliDGZcn3
         V3GzMbX38xSBLMG8BXmWmYEjpnouPrud1BOZGKNy1HcyQJAqk93KM0ea1O7j8n14Ql
         Enw6vdBTABroYzVom6MUcWc7y+hI1S7Geab6TSbI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.14 27/40] writeback: synchronize sync(2) against cgroup writeback membership switches
Date:   Thu, 14 Feb 2019 21:13:00 -0500
Message-Id: <20190215021313.178476-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021313.178476-1-sashal@kernel.org>
References: <20190215021313.178476-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 7fc5854f8c6efae9e7624970ab49a1eac2faefb1 ]

sync_inodes_sb() can race against cgwb (cgroup writeback) membership
switches and fail to writeback some inodes.  For example, if an inode
switches to another wb while sync_inodes_sb() is in progress, the new
wb might not be visible to bdi_split_work_to_wbs() at all or the inode
might jump from a wb which hasn't issued writebacks yet to one which
already has.

This patch adds backing_dev_info->wb_switch_rwsem to synchronize cgwb
switch path against sync_inodes_sb() so that sync_inodes_sb() is
guaranteed to see all the target wbs and inodes can't jump wbs to
escape syncing.

v2: Fixed misplaced rwsem init.  Spotted by Jiufei.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Jiufei Xue <xuejiufei@gmail.com>
Link: http://lkml.kernel.org/r/dc694ae2-f07f-61e1-7097-7c8411cee12d@gmail.com
Acked-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fs-writeback.c                | 40 ++++++++++++++++++++++++++++++--
 include/linux/backing-dev-defs.h |  1 +
 mm/backing-dev.c                 |  1 +
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 3244932f4d5c..6a76616c9401 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -331,11 +331,22 @@ struct inode_switch_wbs_context {
 	struct work_struct	work;
 };
 
+static void bdi_down_write_wb_switch_rwsem(struct backing_dev_info *bdi)
+{
+	down_write(&bdi->wb_switch_rwsem);
+}
+
+static void bdi_up_write_wb_switch_rwsem(struct backing_dev_info *bdi)
+{
+	up_write(&bdi->wb_switch_rwsem);
+}
+
 static void inode_switch_wbs_work_fn(struct work_struct *work)
 {
 	struct inode_switch_wbs_context *isw =
 		container_of(work, struct inode_switch_wbs_context, work);
 	struct inode *inode = isw->inode;
+	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	struct address_space *mapping = inode->i_mapping;
 	struct bdi_writeback *old_wb = inode->i_wb;
 	struct bdi_writeback *new_wb = isw->new_wb;
@@ -343,6 +354,12 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	bool switched = false;
 	void **slot;
 
+	/*
+	 * If @inode switches cgwb membership while sync_inodes_sb() is
+	 * being issued, sync_inodes_sb() might miss it.  Synchronize.
+	 */
+	down_read(&bdi->wb_switch_rwsem);
+
 	/*
 	 * By the time control reaches here, RCU grace period has passed
 	 * since I_WB_SWITCH assertion and all wb stat update transactions
@@ -435,6 +452,8 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	spin_unlock(&new_wb->list_lock);
 	spin_unlock(&old_wb->list_lock);
 
+	up_read(&bdi->wb_switch_rwsem);
+
 	if (switched) {
 		wb_wakeup(new_wb);
 		wb_put(old_wb);
@@ -475,9 +494,18 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	if (inode->i_state & I_WB_SWITCH)
 		return;
 
+	/*
+	 * Avoid starting new switches while sync_inodes_sb() is in
+	 * progress.  Otherwise, if the down_write protected issue path
+	 * blocks heavily, we might end up starting a large number of
+	 * switches which will block on the rwsem.
+	 */
+	if (!down_read_trylock(&bdi->wb_switch_rwsem))
+		return;
+
 	isw = kzalloc(sizeof(*isw), GFP_ATOMIC);
 	if (!isw)
-		return;
+		goto out_unlock;
 
 	/* find and pin the new wb */
 	rcu_read_lock();
@@ -511,12 +539,14 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	 * Let's continue after I_WB_SWITCH is guaranteed to be visible.
 	 */
 	call_rcu(&isw->rcu_head, inode_switch_wbs_rcu_fn);
-	return;
+	goto out_unlock;
 
 out_free:
 	if (isw->new_wb)
 		wb_put(isw->new_wb);
 	kfree(isw);
+out_unlock:
+	up_read(&bdi->wb_switch_rwsem);
 }
 
 /**
@@ -894,6 +924,9 @@ fs_initcall(cgroup_writeback_init);
 
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
+static void bdi_down_write_wb_switch_rwsem(struct backing_dev_info *bdi) { }
+static void bdi_up_write_wb_switch_rwsem(struct backing_dev_info *bdi) { }
+
 static struct bdi_writeback *
 locked_inode_to_wb_and_lock_list(struct inode *inode)
 	__releases(&inode->i_lock)
@@ -2408,8 +2441,11 @@ void sync_inodes_sb(struct super_block *sb)
 		return;
 	WARN_ON(!rwsem_is_locked(&sb->s_umount));
 
+	/* protect against inode wb switch, see inode_switch_wbs_work_fn() */
+	bdi_down_write_wb_switch_rwsem(bdi);
 	bdi_split_work_to_wbs(bdi, &work, false);
 	wb_wait_for_completion(bdi, &done);
+	bdi_up_write_wb_switch_rwsem(bdi);
 
 	wait_sb_inodes(sb);
 }
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 19240379637f..b186c4b464e0 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -165,6 +165,7 @@ struct backing_dev_info {
 	struct radix_tree_root cgwb_tree; /* radix tree of active cgroup wbs */
 	struct rb_root cgwb_congested_tree; /* their congested states */
 	struct mutex cgwb_release_mutex;  /* protect shutdown of wb structs */
+	struct rw_semaphore wb_switch_rwsem; /* no cgwb switch while syncing */
 #else
 	struct bdi_writeback_congested *wb_congested;
 #endif
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 9386c98dac12..6fa31754eadd 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -684,6 +684,7 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 	INIT_RADIX_TREE(&bdi->cgwb_tree, GFP_ATOMIC);
 	bdi->cgwb_congested_tree = RB_ROOT;
 	mutex_init(&bdi->cgwb_release_mutex);
+	init_rwsem(&bdi->wb_switch_rwsem);
 
 	ret = wb_init(&bdi->wb, bdi, 1, GFP_KERNEL);
 	if (!ret) {
-- 
2.19.1

