Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17810C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F3D21773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfAJKKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:10:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbfAJKKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:10:21 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 756594B3E1E80B3A0F09;
        Thu, 10 Jan 2019 18:10:18 +0800 (CST)
Received: from localhost.localdomain (10.109.166.44) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Thu, 10 Jan 2019 18:10:10 +0800
From:   Zhikang Zhang <zhangzhikang1@huawei.com>
To:     <adobriyan@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <heyunlei@huawei.com>
Subject: [PATCH] procfs: remove unused parameter in proc_pid_lookup
Date:   Thu, 10 Jan 2019 18:10:14 +0800
Message-ID: <1547115014-12885-1-git-send-email-zhangzhikang1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.109.166.44]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct inode *dir argument in proc_pid_lookup doesn't needed anymore

Fixes: 0168b9e38c42 ("procfs: switch instantiate_t to d_splice_alias()")

Signed-off-by: Zhikang Zhang <zhangzhikang1@huawei.com>
---
 fs/proc/base.c     | 2 +-
 fs/proc/internal.h | 2 +-
 fs/proc/root.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index d7fd1ca..ac44398 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3157,7 +3157,7 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
 	return d_splice_alias(inode, dentry);
 }
 
-struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, unsigned int flags)
+struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
 {
 	struct task_struct *task;
 	unsigned tgid;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 5185d7f..80d55e8 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -161,7 +161,7 @@ extern struct inode *proc_pid_make_inode(struct super_block *, struct task_struc
 extern void pid_update_inode(struct task_struct *, struct inode *);
 extern int pid_delete_dentry(const struct dentry *);
 extern int proc_pid_readdir(struct file *, struct dir_context *);
-extern struct dentry *proc_pid_lookup(struct inode *, struct dentry *, unsigned int);
+extern struct dentry *proc_pid_lookup(struct dentry *, unsigned int);
 extern loff_t mem_lseek(struct file *, loff_t, int);
 
 /* Lookups */
diff --git a/fs/proc/root.c b/fs/proc/root.c
index f4b1a9d..621e6ec 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -154,7 +154,7 @@ static int proc_root_getattr(const struct path *path, struct kstat *stat,
 
 static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry, unsigned int flags)
 {
-	if (!proc_pid_lookup(dir, dentry, flags))
+	if (!proc_pid_lookup(dentry, flags))
 		return NULL;
 	
 	return proc_lookup(dir, dentry, flags);
-- 
2.7.4

