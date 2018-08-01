Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE611C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127B520851
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127B520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeHAFMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:12:46 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:55506 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbeHAFMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:12:46 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 7336AE789105E71BF2FD;
        Wed,  1 Aug 2018 11:29:04 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w713SxwW060402;
        Wed, 1 Aug 2018 11:28:59 +0800 (GMT-8)
        (envelope-from liu.song11@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018080111290448-2795477 ;
          Wed, 1 Aug 2018 11:29:04 +0800 
From:   Liu Song <liu.song11@zte.com.cn>
To:     dwmw2@infradead.org
Cc:     linux-mtd@lists.infradead.org, liu.song11@zte.com.cn,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/jffs2 : prevent gc to pick block which includes inode with I_NEW state
Date:   Wed, 1 Aug 2018 11:27:26 +0800
Message-Id: <1533094046-132789-1-git-send-email-liu.song11@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-01 11:29:04,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-01 11:28:52,
        Serialize complete at 2018-08-01 11:28:52
X-MAIL: mse01.zte.com.cn w713SxwW060402
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In JFFS2, the process of creating a new file is split into two parts.
First, create the inode, name it "Part A", then create the dirent,
named it "Part B", both need reserve space. In Part A, a inode with
I_NEW state has been written in the block, we name it "block_a".
The inode I_NEW state will be cleared after Part B finished.

After "Part A" finished, alloc_sem lock is released. Other waiting
process able to run and write data in "block_a" until no more space
in the block. Next, if reserve space trigger gc, then "block_a" is
possible been picked by gc to collect.

Then, there is an inode with state I_NEW in "block_a", and gc collect
will find that inode and wait on I_NEW clear. Because gc holds alloc_sem
lock, so Part B waiting alloc_sem forever. System enter a deadlock state.

The call trace is as follows:
-----------------------------
[43850.832264] Call trace:
[43850.834700] [<ffff0000080853fc>] __switch_to+0xcc/0xd8
[43850.839834] [<ffff000008875d28>] __schedule+0x180/0x468
[43850.845048] [<ffff000008876048>] schedule+0x38/0xb8
[43850.849920] [<ffff0000088767d4>] bit_wait+0x14/0x68
[43850.854787] [<ffff0000088764bc>] __wait_on_bit+0xa4/0xe0
[43850.860093] [<ffff000008876558>] out_of_line_wait_on_bit+0x60/0x68
[43850.866263] [<ffff0000081cb9f8>] iget_locked+0xd8/0x1a8
[43850.871483] [<ffff0000082f2c24>] jffs2_iget+0x14/0x330
[43850.876610] [<ffff0000082f348c>] jffs2_gc_fetch_inode+0x5c/0x148
[43850.882611] [<ffff0000082f0f50>] jffs2_garbage_collect_pass+0x678/0x810
[43850.889219] [<ffff0000082ec240>] jffs2_reserve_space+0x170/0x338
[43850.895215] [<ffff0000082eeea4>] jffs2_do_unlink+0x5c/0x240
[43850.900782] [<ffff0000082e8878>] jffs2_rename+0x108/0x298
[43850.906169] [<ffff0000081bd228>] vfs_rename+0x840/0x858
[43850.911389] [<ffff0000081c2308>] SyS_renameat2+0x430/0x4a0
[43850.916863] [<ffff0000081c2388>] SyS_renameat+0x10/0x18
[43850.922083] [<ffff000008082e8c>] __sys_trace_return+0x0/0x4

This patch add "block_a" into a prevent list, which prevent gc to pick
for collecting. After testing, it can effectively solve the deadlock
bug.

Reported-by: Yang Yi <yang.yi@zte.com.cn>
Signed-off-by: Liu Song <liu.song11@zte.com.cn>
Tested-by: Yang Yi <yang.yi@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 fs/jffs2/build.c       |  1 +
 fs/jffs2/dir.c         | 22 +++++++++++++++++++++-
 fs/jffs2/gc.c          |  4 ++++
 fs/jffs2/jffs2_fs_sb.h |  1 +
 fs/jffs2/nodelist.h    | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/jffs2/write.c       |  5 ++++-
 6 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/fs/jffs2/build.c b/fs/jffs2/build.c
index b288c8a..bee6521 100644
--- a/fs/jffs2/build.c
+++ b/fs/jffs2/build.c
@@ -403,6 +403,7 @@ int jffs2_do_mount_fs(struct jffs2_sb_info *c)
 	INIT_LIST_HEAD(&c->free_list);
 	INIT_LIST_HEAD(&c->bad_list);
 	INIT_LIST_HEAD(&c->bad_used_list);
+	INIT_LIST_HEAD(&c->prevent_gc_list);
 	c->highest_ino = 1;
 	c->summary = NULL;
 
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index b2944f9..b6782f1 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -164,6 +164,7 @@ static int jffs2_create(struct inode *dir_i, struct dentry *dentry,
 	struct jffs2_inode_info *f, *dir_f;
 	struct jffs2_sb_info *c;
 	struct inode *inode;
+	struct prevent_block pb;
 	int ret;
 
 	ri = jffs2_alloc_raw_inode();
@@ -197,7 +198,7 @@ static int jffs2_create(struct inode *dir_i, struct dentry *dentry,
 	   no chance of AB-BA deadlock involving its f->sem). */
 	mutex_unlock(&f->sem);
 
-	ret = jffs2_do_create(c, dir_f, f, ri, &dentry->d_name);
+	ret = jffs2_do_create(c, dir_f, f, ri, &dentry->d_name, &pb);
 	if (ret)
 		goto fail;
 
@@ -210,10 +211,12 @@ static int jffs2_create(struct inode *dir_i, struct dentry *dentry,
 		  f->inocache->pino_nlink, inode->i_mapping->nrpages);
 
 	d_instantiate_new(dentry, inode);
+	remove_prevent_gc_list(c, &pb);
 	return 0;
 
  fail:
 	iget_failed(inode);
+	remove_prevent_gc_list(c, &pb);
 	jffs2_free_raw_inode(ri);
 	return ret;
 }
@@ -285,6 +288,7 @@ static int jffs2_symlink (struct inode *dir_i, struct dentry *dentry, const char
 	struct jffs2_raw_dirent *rd;
 	struct jffs2_full_dnode *fn;
 	struct jffs2_full_dirent *fd;
+	struct prevent_block pb;
 	int namelen;
 	uint32_t alloclen;
 	int ret, targetlen = strlen(target);
@@ -346,6 +350,8 @@ static int jffs2_symlink (struct inode *dir_i, struct dentry *dentry, const char
 		goto fail;
 	}
 
+	add_prevent_gc_list(c, &pb);
+
 	/* We use f->target field to store the target path. */
 	f->target = kmemdup(target, targetlen + 1, GFP_KERNEL);
 	if (!f->target) {
@@ -430,10 +436,12 @@ static int jffs2_symlink (struct inode *dir_i, struct dentry *dentry, const char
 	jffs2_complete_reservation(c);
 
 	d_instantiate_new(dentry, inode);
+	remove_prevent_gc_list(c, &pb);
 	return 0;
 
  fail:
 	iget_failed(inode);
+	remove_prevent_gc_list(c, &pb);
 	return ret;
 }
 
@@ -447,6 +455,7 @@ static int jffs2_mkdir (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	struct jffs2_raw_dirent *rd;
 	struct jffs2_full_dnode *fn;
 	struct jffs2_full_dirent *fd;
+	struct prevent_block pb;
 	int namelen;
 	uint32_t alloclen;
 	int ret;
@@ -503,6 +512,9 @@ static int jffs2_mkdir (struct inode *dir_i, struct dentry *dentry, umode_t mode
 		ret = PTR_ERR(fn);
 		goto fail;
 	}
+
+	add_prevent_gc_list(c, &pb);
+
 	/* No data here. Only a metadata node, which will be
 	   obsoleted by the first data write
 	*/
@@ -574,10 +586,12 @@ static int jffs2_mkdir (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	jffs2_complete_reservation(c);
 
 	d_instantiate_new(dentry, inode);
+	remove_prevent_gc_list(c, &pb);
 	return 0;
 
  fail:
 	iget_failed(inode);
+	remove_prevent_gc_list(c, &pb);
 	return ret;
 }
 
@@ -614,6 +628,7 @@ static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	struct jffs2_raw_dirent *rd;
 	struct jffs2_full_dnode *fn;
 	struct jffs2_full_dirent *fd;
+	struct prevent_block pb;
 	int namelen;
 	union jffs2_device_node dev;
 	int devlen = 0;
@@ -672,6 +687,9 @@ static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, umode_t mode
 		ret = PTR_ERR(fn);
 		goto fail;
 	}
+
+	add_prevent_gc_list(c, &pb);
+
 	/* No data here. Only a metadata node, which will be
 	   obsoleted by the first data write
 	*/
@@ -745,10 +763,12 @@ static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	jffs2_complete_reservation(c);
 
 	d_instantiate_new(dentry, inode);
+	remove_prevent_gc_list(c, &pb);
 	return 0;
 
  fail:
 	iget_failed(inode);
+	remove_prevent_gc_list(c, &pb);
 	return ret;
 }
 
diff --git a/fs/jffs2/gc.c b/fs/jffs2/gc.c
index 9ed0f26..1fe4b11 100644
--- a/fs/jffs2/gc.c
+++ b/fs/jffs2/gc.c
@@ -95,6 +95,10 @@ static struct jffs2_eraseblock *jffs2_find_gc_block(struct jffs2_sb_info *c)
 	}
 
 	ret = list_entry(nextlist->next, struct jffs2_eraseblock, list);
+	if (is_prevented_block(c, ret)) {
+		n = jiffies % 128;
+		goto again;
+	}
 	list_del(&ret->list);
 	c->gcblock = ret;
 	ret->gc_node = ret->first_node;
diff --git a/fs/jffs2/jffs2_fs_sb.h b/fs/jffs2/jffs2_fs_sb.h
index 778275f..a018fbf 100644
--- a/fs/jffs2/jffs2_fs_sb.h
+++ b/fs/jffs2/jffs2_fs_sb.h
@@ -106,6 +106,7 @@ struct jffs2_sb_info {
 	struct list_head free_list;		/* Blocks which are free and ready to be used */
 	struct list_head bad_list;		/* Bad blocks. */
 	struct list_head bad_used_list;		/* Bad blocks with valid data in. */
+	struct list_head prevent_gc_list;	/* Prevent blocks picked for gc. */
 
 	spinlock_t erase_completion_lock;	/* Protect free_list and erasing_list
 						   against erase completion handler */
diff --git a/fs/jffs2/nodelist.h b/fs/jffs2/nodelist.h
index 0637271..d54b634 100644
--- a/fs/jffs2/nodelist.h
+++ b/fs/jffs2/nodelist.h
@@ -98,6 +98,12 @@ struct jffs2_raw_node_ref
 /* Use blocks of about 256 bytes */
 #define REFS_PER_BLOCK ((255/sizeof(struct jffs2_raw_node_ref))-1)
 
+struct prevent_block {
+	struct list_head list;
+	struct jffs2_eraseblock *jeb;
+	int in_use;
+};
+
 static inline struct jffs2_raw_node_ref *ref_next(struct jffs2_raw_node_ref *ref)
 {
 	ref++;
@@ -405,7 +411,7 @@ int jffs2_write_inode_range(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 			    struct jffs2_raw_inode *ri, unsigned char *buf,
 			    uint32_t offset, uint32_t writelen, uint32_t *retlen);
 int jffs2_do_create(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f, struct jffs2_inode_info *f,
-		    struct jffs2_raw_inode *ri, const struct qstr *qstr);
+		    struct jffs2_raw_inode *ri, const struct qstr *qstr, struct prevent_block *pb);
 int jffs2_do_unlink(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f, const char *name,
 		    int namelen, struct jffs2_inode_info *dead_f, uint32_t time);
 int jffs2_do_link(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f, uint32_t ino,
@@ -479,6 +485,44 @@ int jffs2_check_nand_cleanmarker(struct jffs2_sb_info *c, struct jffs2_erasebloc
 int jffs2_write_nand_cleanmarker(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb);
 #endif
 
+static inline void add_prevent_gc_list(struct jffs2_sb_info *c, struct prevent_block *pb)
+{
+	BUG_ON(!mutex_is_locked(&c->alloc_sem));
+	pb->jeb = c->nextblock;
+	pb->in_use = 1;
+	list_add(&pb->list, &c->prevent_gc_list);
+}
+
+static inline void remove_prevent_gc_list(struct jffs2_sb_info *c, struct prevent_block *pb)
+{
+	if (pb->in_use == 1) {
+		mutex_lock(&c->alloc_sem);
+		list_del(&pb->list);
+		mutex_unlock(&c->alloc_sem);
+	}
+	pb->in_use = 0;
+}
+
+static inline int is_prevented_block(struct jffs2_sb_info *c, struct jffs2_eraseblock *jeb)
+{
+	int ret = 0;
+	struct list_head *this = NULL;
+	struct prevent_block *pb = NULL;
+
+	BUG_ON(!mutex_is_locked(&c->alloc_sem));
+	if (list_empty(&c->prevent_gc_list))
+		goto out;
+
+	list_for_each(this, &c->prevent_gc_list) {
+		pb = list_entry(this, struct prevent_block, list);
+		if (pb->jeb != NULL && pb->jeb->offset == jeb->offset) {
+			ret = 1;
+			break;
+		}
+	}
+out:
+	return ret;
+}
 #include "debug.h"
 
 #endif /* __JFFS2_NODELIST_H__ */
diff --git a/fs/jffs2/write.c b/fs/jffs2/write.c
index cda9a36..bd95d3b 100644
--- a/fs/jffs2/write.c
+++ b/fs/jffs2/write.c
@@ -440,7 +440,7 @@ int jffs2_write_inode_range(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 
 int jffs2_do_create(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f,
 		    struct jffs2_inode_info *f, struct jffs2_raw_inode *ri,
-		    const struct qstr *qstr)
+		    const struct qstr *qstr, struct prevent_block *pb)
 {
 	struct jffs2_raw_dirent *rd;
 	struct jffs2_full_dnode *fn;
@@ -474,6 +474,9 @@ int jffs2_do_create(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f,
 		jffs2_complete_reservation(c);
 		return PTR_ERR(fn);
 	}
+
+	add_prevent_gc_list(c, pb);
+
 	/* No data here. Only a metadata node, which will be
 	   obsoleted by the first data write
 	*/
-- 
2.1.0.GIT

