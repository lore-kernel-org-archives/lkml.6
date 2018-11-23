Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F8AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF54120664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF54120664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409460AbeKWV0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:26:02 -0500
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:13399
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387769AbeKWV0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:26:01 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AMAACP2Pdb/7650XYNVRwBAQEEAQE?=
 =?us-ascii?q?HBAEBgVEHAQELAYQSg3mIGIxJAQEBAQEBBoEQg2eFV44igXqEdAMCAoQ1NAk?=
 =?us-ascii?q?NAQMBAQEBAQEChlICAQMjBFIQGAEMAiYCAkcQBhOFFqY7cHwzGol9gQuBc4k?=
 =?us-ascii?q?ieIEHgREzimGCVwKPXDOPcwmRRwoCiWkDhxCCeJZ+gg1NLgqDJ4InF44pZYp?=
 =?us-ascii?q?dK4IgAQE?=
X-IPAS-Result: =?us-ascii?q?A2AMAACP2Pdb/7650XYNVRwBAQEEAQEHBAEBgVEHAQELA?=
 =?us-ascii?q?YQSg3mIGIxJAQEBAQEBBoEQg2eFV44igXqEdAMCAoQ1NAkNAQMBAQEBAQECh?=
 =?us-ascii?q?lICAQMjBFIQGAEMAiYCAkcQBhOFFqY7cHwzGol9gQuBc4kieIEHgREzimGCV?=
 =?us-ascii?q?wKPXDOPcwmRRwoCiWkDhxCCeJZ+gg1NLgqDJ4InF44pZYpdK4IgAQE?=
X-IronPort-AV: E=Sophos;i="5.56,269,1539619200"; 
   d="scan'208";a="122563389"
Received: from unknown (HELO [192.168.1.28]) ([118.209.185.190])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 23 Nov 2018 18:42:13 +0800
Subject: [PATCH v2 4/5] autofs - change catatonic setting to a bit flag
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 23 Nov 2018 18:42:12 +0800
Message-ID: <154296973142.9889.17275721668508589639.stgit@pluto-themaw-net>
In-Reply-To: <154296962626.9889.644199825100770992.stgit@pluto-themaw-net>
References: <154296962626.9889.644199825100770992.stgit@pluto-themaw-net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the super block info. catatonic setting to be part of a
flags bit field.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h  |    7 +++++--
 fs/autofs/dev-ioctl.c |    4 ++--
 fs/autofs/inode.c     |    4 ++--
 fs/autofs/root.c      |   11 ++++++-----
 fs/autofs/waitq.c     |   10 +++++-----
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index c4301e33c027..032cbb12531a 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -101,16 +101,18 @@ struct autofs_wait_queue {
 
 #define AUTOFS_SBI_MAGIC 0x6d4a556d
 
+#define AUTOFS_SBI_CATATONIC	0x0001
+
 struct autofs_sb_info {
 	u32 magic;
 	int pipefd;
 	struct file *pipe;
 	struct pid *oz_pgrp;
-	int catatonic;
 	int version;
 	int sub_version;
 	int min_proto;
 	int max_proto;
+	unsigned int flags;
 	unsigned long exp_timeout;
 	unsigned int type;
 	struct super_block *sb;
@@ -140,7 +142,8 @@ static inline struct autofs_info *autofs_dentry_ino(struct dentry *dentry)
  */
 static inline int autofs_oz_mode(struct autofs_sb_info *sbi)
 {
-	return sbi->catatonic || task_pgrp(current) == sbi->oz_pgrp;
+	return ((sbi->flags & AUTOFS_SBI_CATATONIC) ||
+		 task_pgrp(current) == sbi->oz_pgrp);
 }
 
 struct inode *autofs_get_inode(struct super_block *, umode_t);
diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index 3de4f5e61caf..fc1caf449fa3 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -352,7 +352,7 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
 	pipefd = param->setpipefd.pipefd;
 
 	mutex_lock(&sbi->wq_mutex);
-	if (!sbi->catatonic) {
+	if (!(sbi->flags & AUTOFS_SBI_CATATONIC)) {
 		mutex_unlock(&sbi->wq_mutex);
 		return -EBUSY;
 	} else {
@@ -379,7 +379,7 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
 		swap(sbi->oz_pgrp, new_pid);
 		sbi->pipefd = pipefd;
 		sbi->pipe = pipe;
-		sbi->catatonic = 0;
+		sbi->flags &= ~AUTOFS_SBI_CATATONIC;
 	}
 out:
 	put_pid(new_pid);
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index ccedd12c1ac5..8cfd3f67af57 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -227,12 +227,12 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	sbi->magic = AUTOFS_SBI_MAGIC;
 	sbi->pipefd = -1;
 	sbi->pipe = NULL;
-	sbi->catatonic = 1;
 	sbi->exp_timeout = 0;
 	sbi->oz_pgrp = NULL;
 	sbi->sb = s;
 	sbi->version = 0;
 	sbi->sub_version = 0;
+	sbi->flags = AUTOFS_SBI_CATATONIC;
 	set_autofs_type_indirect(&sbi->type);
 	sbi->min_proto = 0;
 	sbi->max_proto = 0;
@@ -322,7 +322,7 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	if (ret < 0)
 		goto fail_fput;
 	sbi->pipe = pipe;
-	sbi->catatonic = 0;
+	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
 
 	/*
 	 * Success! Install the root dentry now to indicate completion.
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 782e57b911ab..164ccd3402cf 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -510,7 +510,8 @@ static struct dentry *autofs_lookup(struct inode *dir,
 	sbi = autofs_sbi(dir->i_sb);
 
 	pr_debug("pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d\n",
-		 current->pid, task_pgrp_nr(current), sbi->catatonic,
+		 current->pid, task_pgrp_nr(current),
+		 sbi->flags & AUTOFS_SBI_CATATONIC,
 		 autofs_oz_mode(sbi));
 
 	active = autofs_lookup_active(dentry);
@@ -563,7 +564,7 @@ static int autofs_dir_symlink(struct inode *dir,
 	 * autofs mount is catatonic but the state of an autofs
 	 * file system needs to be preserved over restarts.
 	 */
-	if (sbi->catatonic)
+	if (sbi->flags & AUTOFS_SBI_CATATONIC)
 		return -EACCES;
 
 	BUG_ON(!ino);
@@ -626,7 +627,7 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 	 * autofs mount is catatonic but the state of an autofs
 	 * file system needs to be preserved over restarts.
 	 */
-	if (sbi->catatonic)
+	if (sbi->flags & AUTOFS_SBI_CATATONIC)
 		return -EACCES;
 
 	if (atomic_dec_and_test(&ino->count)) {
@@ -714,7 +715,7 @@ static int autofs_dir_rmdir(struct inode *dir, struct dentry *dentry)
 	 * autofs mount is catatonic but the state of an autofs
 	 * file system needs to be preserved over restarts.
 	 */
-	if (sbi->catatonic)
+	if (sbi->flags & AUTOFS_SBI_CATATONIC)
 		return -EACCES;
 
 	spin_lock(&sbi->lookup_lock);
@@ -759,7 +760,7 @@ static int autofs_dir_mkdir(struct inode *dir,
 	 * autofs mount is catatonic but the state of an autofs
 	 * file system needs to be preserved over restarts.
 	 */
-	if (sbi->catatonic)
+	if (sbi->flags & AUTOFS_SBI_CATATONIC)
 		return -EACCES;
 
 	pr_debug("dentry %p, creating %pd\n", dentry, dentry);
diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index f6385c6ef0a5..15a3e31d0904 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -20,14 +20,14 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
 	struct autofs_wait_queue *wq, *nwq;
 
 	mutex_lock(&sbi->wq_mutex);
-	if (sbi->catatonic) {
+	if (sbi->flags & AUTOFS_SBI_CATATONIC) {
 		mutex_unlock(&sbi->wq_mutex);
 		return;
 	}
 
 	pr_debug("entering catatonic mode\n");
 
-	sbi->catatonic = 1;
+	sbi->flags |= AUTOFS_SBI_CATATONIC;
 	wq = sbi->queues;
 	sbi->queues = NULL;	/* Erase all wait queues */
 	while (wq) {
@@ -255,7 +255,7 @@ static int validate_request(struct autofs_wait_queue **wait,
 	struct autofs_wait_queue *wq;
 	struct autofs_info *ino;
 
-	if (sbi->catatonic)
+	if (sbi->flags & AUTOFS_SBI_CATATONIC)
 		return -ENOENT;
 
 	/* Wait in progress, continue; */
@@ -290,7 +290,7 @@ static int validate_request(struct autofs_wait_queue **wait,
 			if (mutex_lock_interruptible(&sbi->wq_mutex))
 				return -EINTR;
 
-			if (sbi->catatonic)
+			if (sbi->flags & AUTOFS_SBI_CATATONIC)
 				return -ENOENT;
 
 			wq = autofs_find_wait(sbi, qstr);
@@ -359,7 +359,7 @@ int autofs_wait(struct autofs_sb_info *sbi,
 	pid_t tgid;
 
 	/* In catatonic mode, we don't wait for nobody */
-	if (sbi->catatonic)
+	if (sbi->flags & AUTOFS_SBI_CATATONIC)
 		return -ENOENT;
 
 	/*

