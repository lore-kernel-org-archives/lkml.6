Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0531C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 17:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F102206B7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 17:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDQp5gGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F102206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeLBESc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 23:18:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37337 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeLBESc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 23:18:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so3863606pge.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 09:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ynCA87DkwG3M2bBezc8mrLfEFGoImTBN9IMPWdymWBc=;
        b=oDQp5gGTLfgcuIcCb2dxokpZQy3gBC0DFJvK0mGXaYp58icinGkaEKTHxw2SoBnofB
         ARM0dGHHnrMwMiS/uLfr+9yrlyAoWbTN4PEq0o2tsYzcPIgnpXYrMkrhmiYon/aPKt7F
         GTPUfATjduVnI9msCRW9WQRr82OVWg1dPHOkYz4TwQCyhYRWyNwnVbWhXkpSyTg7zaHf
         sriBQ+k1w1wWOJadRS67Nl9OdVRB8ZIIRGx8mLD2/J0gz+pifoInv2EhiQGAEvqE/v+N
         zt//vVvdU9/BWVosyCHjUqWR6QrK6D36RtgFgpahMNo0N1L8fPslY0XrtuIUs0UurXD4
         0t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ynCA87DkwG3M2bBezc8mrLfEFGoImTBN9IMPWdymWBc=;
        b=UXlxzUfINv4l/hga/Qcszz//ISkjNOhYqtwtctDHZTAEZ6wQ7z25WdrJ32KkEP58bG
         Z4xRTVHCFTVggnCtz2w/62X4muSbUkmhOJ5cCDkh37O8nKTVAMB8ZTcOEopanshGCR4D
         fNWlJoumJCat+ez0Y8Z6q3O71MU6g+NsaHe/nAo4Jvg2rIN4J1DytOiLgzvAk20505CP
         seWFKo0EbpEPjqo8U9h2Ywp8hQZ0P6U8TA8lD+ekVGwAqDToyXKDeloVDjSgpZXLby9t
         LtBbPYhcBqVjhvge9j2diOdYPZpoGDTYL35w+8Hnja5+9w/jCZjhcutk+0SGjvEUJM/J
         Sbng==
X-Gm-Message-State: AA+aEWanpBRho4unkD/X1MNXOq0BXQPxptl6ZXlBnqeiEW3BjTChVoGs
        zK/emnN8HIhoUlKV1F6+8uYObHrDvKE=
X-Google-Smtp-Source: AFSGD/VF7kE+Jq4lTpIxpDXSrd5+7+vCr6WFh6bYmcKE97td+Pgqn7HVUK6KxNk3Z9c1rq66YrkdGw==
X-Received: by 2002:a63:9a09:: with SMTP id o9mr8049580pge.94.1543683933155;
        Sat, 01 Dec 2018 09:05:33 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l11sm10946336pff.65.2018.12.01.09.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 09:05:32 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     haver@linux.vnet.ibm.com, gpiccoli@linux.vnet.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, xdeguillard@vmware.com, namit@vmware.com,
        pv-drivers@vmware.com, baijiaju1990@gmail.com,
        colin.king@canonical.com, vasilyev@ispras.ru
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] misc: remove GENWQE_DEBUGFS_RO()
Date:   Sat,  1 Dec 2018 12:05:30 -0500
Message-Id: <20181201170530.8778-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have the DEFINE_SHOW_ATTRIBUTE.There is no need to define
such a macro,so remove GENWQE_DEBUGFS_RO.Also use DEFINE_SHOW_ATTRIBUTE
to simplify some code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/misc/genwqe/card_debugfs.c   | 85 ++++++++++++----------------
 drivers/misc/mic/card/mic_debugfs.c  | 24 ++------
 drivers/misc/mic/cosm/cosm_debugfs.c | 39 +++----------
 drivers/misc/mic/host/mic_debugfs.c  | 62 +++-----------------
 drivers/misc/mic/scif/scif_debugfs.c | 44 ++------------
 drivers/misc/mic/vop/vop_debugfs.c   | 40 ++-----------
 drivers/misc/ti-st/st_kim.c          | 34 ++---------
 drivers/misc/vmw_balloon.c           | 13 +----
 8 files changed, 73 insertions(+), 268 deletions(-)

diff --git a/drivers/misc/genwqe/card_debugfs.c b/drivers/misc/genwqe/card_debugfs.c
index c6b82f09b3ba..7c713e01d198 100644
--- a/drivers/misc/genwqe/card_debugfs.c
+++ b/drivers/misc/genwqe/card_debugfs.c
@@ -33,19 +33,6 @@
 #include "card_base.h"
 #include "card_ddcb.h"
 
-#define GENWQE_DEBUGFS_RO(_name, _showfn)				\
-	static int genwqe_debugfs_##_name##_open(struct inode *inode,	\
-						 struct file *file)	\
-	{								\
-		return single_open(file, _showfn, inode->i_private);	\
-	}								\
-	static const struct file_operations genwqe_##_name##_fops = {	\
-		.open = genwqe_debugfs_##_name##_open,			\
-		.read = seq_read,					\
-		.llseek = seq_lseek,					\
-		.release = single_release,				\
-	}
-
 static void dbg_uidn_show(struct seq_file *s, struct genwqe_reg *regs,
 			  int entries)
 {
@@ -87,26 +74,26 @@ static int curr_dbg_uidn_show(struct seq_file *s, void *unused, int uid)
 	return 0;
 }
 
-static int genwqe_curr_dbg_uid0_show(struct seq_file *s, void *unused)
+static int curr_dbg_uid0_show(struct seq_file *s, void *unused)
 {
 	return curr_dbg_uidn_show(s, unused, 0);
 }
 
-GENWQE_DEBUGFS_RO(curr_dbg_uid0, genwqe_curr_dbg_uid0_show);
+DEFINE_SHOW_ATTRIBUTE(curr_dbg_uid0);
 
-static int genwqe_curr_dbg_uid1_show(struct seq_file *s, void *unused)
+static int curr_dbg_uid1_show(struct seq_file *s, void *unused)
 {
 	return curr_dbg_uidn_show(s, unused, 1);
 }
 
-GENWQE_DEBUGFS_RO(curr_dbg_uid1, genwqe_curr_dbg_uid1_show);
+DEFINE_SHOW_ATTRIBUTE(curr_dbg_uid1);
 
-static int genwqe_curr_dbg_uid2_show(struct seq_file *s, void *unused)
+static int curr_dbg_uid2_show(struct seq_file *s, void *unused)
 {
 	return curr_dbg_uidn_show(s, unused, 2);
 }
 
-GENWQE_DEBUGFS_RO(curr_dbg_uid2, genwqe_curr_dbg_uid2_show);
+DEFINE_SHOW_ATTRIBUTE(curr_dbg_uid2);
 
 static int prev_dbg_uidn_show(struct seq_file *s, void *unused, int uid)
 {
@@ -116,28 +103,28 @@ static int prev_dbg_uidn_show(struct seq_file *s, void *unused, int uid)
 	return 0;
 }
 
-static int genwqe_prev_dbg_uid0_show(struct seq_file *s, void *unused)
+static int prev_dbg_uid0_show(struct seq_file *s, void *unused)
 {
 	return prev_dbg_uidn_show(s, unused, 0);
 }
 
-GENWQE_DEBUGFS_RO(prev_dbg_uid0, genwqe_prev_dbg_uid0_show);
+DEFINE_SHOW_ATTRIBUTE(prev_dbg_uid0);
 
-static int genwqe_prev_dbg_uid1_show(struct seq_file *s, void *unused)
+static int prev_dbg_uid1_show(struct seq_file *s, void *unused)
 {
 	return prev_dbg_uidn_show(s, unused, 1);
 }
 
-GENWQE_DEBUGFS_RO(prev_dbg_uid1, genwqe_prev_dbg_uid1_show);
+DEFINE_SHOW_ATTRIBUTE(prev_dbg_uid1);
 
-static int genwqe_prev_dbg_uid2_show(struct seq_file *s, void *unused)
+static int prev_dbg_uid2_show(struct seq_file *s, void *unused)
 {
 	return prev_dbg_uidn_show(s, unused, 2);
 }
 
-GENWQE_DEBUGFS_RO(prev_dbg_uid2, genwqe_prev_dbg_uid2_show);
+DEFINE_SHOW_ATTRIBUTE(prev_dbg_uid2);
 
-static int genwqe_curr_regs_show(struct seq_file *s, void *unused)
+static int curr_regs_show(struct seq_file *s, void *unused)
 {
 	struct genwqe_dev *cd = s->private;
 	unsigned int i;
@@ -164,9 +151,9 @@ static int genwqe_curr_regs_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-GENWQE_DEBUGFS_RO(curr_regs, genwqe_curr_regs_show);
+DEFINE_SHOW_ATTRIBUTE(curr_regs);
 
-static int genwqe_prev_regs_show(struct seq_file *s, void *unused)
+static int prev_regs_show(struct seq_file *s, void *unused)
 {
 	struct genwqe_dev *cd = s->private;
 	unsigned int i;
@@ -188,9 +175,9 @@ static int genwqe_prev_regs_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-GENWQE_DEBUGFS_RO(prev_regs, genwqe_prev_regs_show);
+DEFINE_SHOW_ATTRIBUTE(prev_regs);
 
-static int genwqe_jtimer_show(struct seq_file *s, void *unused)
+static int jtimer_show(struct seq_file *s, void *unused)
 {
 	struct genwqe_dev *cd = s->private;
 	unsigned int vf_num;
@@ -209,9 +196,9 @@ static int genwqe_jtimer_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-GENWQE_DEBUGFS_RO(jtimer, genwqe_jtimer_show);
+DEFINE_SHOW_ATTRIBUTE(jtimer);
 
-static int genwqe_queue_working_time_show(struct seq_file *s, void *unused)
+static int queue_working_time_show(struct seq_file *s, void *unused)
 {
 	struct genwqe_dev *cd = s->private;
 	unsigned int vf_num;
@@ -227,9 +214,9 @@ static int genwqe_queue_working_time_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-GENWQE_DEBUGFS_RO(queue_working_time, genwqe_queue_working_time_show);
+DEFINE_SHOW_ATTRIBUTE(queue_working_time);
 
-static int genwqe_ddcb_info_show(struct seq_file *s, void *unused)
+static int ddcb_info_show(struct seq_file *s, void *unused)
 {
 	struct genwqe_dev *cd = s->private;
 	unsigned int i;
@@ -300,9 +287,9 @@ static int genwqe_ddcb_info_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-GENWQE_DEBUGFS_RO(ddcb_info, genwqe_ddcb_info_show);
+DEFINE_SHOW_ATTRIBUTE(ddcb_info);
 
-static int genwqe_info_show(struct seq_file *s, void *unused)
+static int info_show(struct seq_file *s, void *unused)
 {
 	struct genwqe_dev *cd = s->private;
 	u64 app_id, slu_id, bitstream = -1;
@@ -335,7 +322,7 @@ static int genwqe_info_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-GENWQE_DEBUGFS_RO(info, genwqe_info_show);
+DEFINE_SHOW_ATTRIBUTE(info);
 
 int genwqe_init_debugfs(struct genwqe_dev *cd)
 {
@@ -356,14 +343,14 @@ int genwqe_init_debugfs(struct genwqe_dev *cd)
 
 	/* non privileged interfaces are done here */
 	file = debugfs_create_file("ddcb_info", S_IRUGO, root, cd,
-				   &genwqe_ddcb_info_fops);
+				   &ddcb_info_fops);
 	if (!file) {
 		ret = -ENOMEM;
 		goto err1;
 	}
 
 	file = debugfs_create_file("info", S_IRUGO, root, cd,
-				   &genwqe_info_fops);
+				   &info_fops);
 	if (!file) {
 		ret = -ENOMEM;
 		goto err1;
@@ -396,56 +383,56 @@ int genwqe_init_debugfs(struct genwqe_dev *cd)
 	}
 
 	file = debugfs_create_file("curr_regs", S_IRUGO, root, cd,
-				   &genwqe_curr_regs_fops);
+				   &curr_regs_fops);
 	if (!file) {
 		ret = -ENOMEM;
 		goto err1;
 	}
 
 	file = debugfs_create_file("curr_dbg_uid0", S_IRUGO, root, cd,
-				   &genwqe_curr_dbg_uid0_fops);
+				   &curr_dbg_uid0_fops);
 	if (!file) {
 		ret = -ENOMEM;
 		goto err1;
 	}
 
 	file = debugfs_create_file("curr_dbg_uid1", S_IRUGO, root, cd,
-				   &genwqe_curr_dbg_uid1_fops);
+				   &curr_dbg_uid1_fops);
 	if (!file) {
 		ret = -ENOMEM;
 		goto err1;
 	}
 
 	file = debugfs_create_file("curr_dbg_uid2", S_IRUGO, root, cd,
-				   &genwqe_curr_dbg_uid2_fops);
+				   &curr_dbg_uid2_fops);
 	if (!file) {
 		ret = -ENOMEM;
 		goto err1;
 	}
 
 	file = debugfs_create_file("prev_regs", S_IRUGO, root, cd,
-				   &genwqe_prev_regs_fops);
+				   &prev_regs_fops);
 	if (!file) {
 		ret = -ENOMEM;
 		goto err1;
 	}
 
 	file = debugfs_create_file("prev_dbg_uid0", S_IRUGO, root, cd,
-				   &genwqe_prev_dbg_uid0_fops);
+				   &prev_dbg_uid0_fops);
 	if (!file) {
 		ret = -ENOMEM;
 		goto err1;
 	}
 
 	file = debugfs_create_file("prev_dbg_uid1", S_IRUGO, root, cd,
-				   &genwqe_prev_dbg_uid1_fops);
+				   &prev_dbg_uid1_fops);
 	if (!file) {
 		ret = -ENOMEM;
 		goto err1;
 	}
 
 	file = debugfs_create_file("prev_dbg_uid2", S_IRUGO, root, cd,
-				   &genwqe_prev_dbg_uid2_fops);
+				   &prev_dbg_uid2_fops);
 	if (!file) {
 		ret = -ENOMEM;
 		goto err1;
@@ -463,14 +450,14 @@ int genwqe_init_debugfs(struct genwqe_dev *cd)
 	}
 
 	file = debugfs_create_file("jobtimer", S_IRUGO, root, cd,
-				   &genwqe_jtimer_fops);
+				   &jtimer_fops);
 	if (!file) {
 		ret = -ENOMEM;
 		goto err1;
 	}
 
 	file = debugfs_create_file("queue_working_time", S_IRUGO, root, cd,
-				   &genwqe_queue_working_time_fops);
+				   &queue_working_time_fops);
 	if (!file) {
 		ret = -ENOMEM;
 		goto err1;
diff --git a/drivers/misc/mic/card/mic_debugfs.c b/drivers/misc/mic/card/mic_debugfs.c
index 421b3d7911df..7a4140874888 100644
--- a/drivers/misc/mic/card/mic_debugfs.c
+++ b/drivers/misc/mic/card/mic_debugfs.c
@@ -37,9 +37,9 @@
 static struct dentry *mic_dbg;
 
 /**
- * mic_intr_test - Send interrupts to host.
+ * mic_intr_show - Send interrupts to host.
  */
-static int mic_intr_test(struct seq_file *s, void *unused)
+static int mic_intr_show(struct seq_file *s, void *unused)
 {
 	struct mic_driver *mdrv = s->private;
 	struct mic_device *mdev = &mdrv->mdev;
@@ -56,23 +56,7 @@ static int mic_intr_test(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int mic_intr_test_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mic_intr_test, inode->i_private);
-}
-
-static int mic_intr_test_release(struct inode *inode, struct file *file)
-{
-	return single_release(inode, file);
-}
-
-static const struct file_operations intr_test_ops = {
-	.owner   = THIS_MODULE,
-	.open    = mic_intr_test_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = mic_intr_test_release
-};
+DEFINE_SHOW_ATTRIBUTE(mic_intr);
 
 /**
  * mic_create_card_debug_dir - Initialize MIC debugfs entries.
@@ -91,7 +75,7 @@ void __init mic_create_card_debug_dir(struct mic_driver *mdrv)
 	}
 
 	d = debugfs_create_file("intr_test", 0444, mdrv->dbg_dir,
-		mdrv, &intr_test_ops);
+		mdrv, &mic_intr_fops);
 
 	if (!d) {
 		dev_err(mdrv->dev,
diff --git a/drivers/misc/mic/cosm/cosm_debugfs.c b/drivers/misc/mic/cosm/cosm_debugfs.c
index 216cb3cd2fe3..71c216d0504d 100644
--- a/drivers/misc/mic/cosm/cosm_debugfs.c
+++ b/drivers/misc/mic/cosm/cosm_debugfs.c
@@ -28,12 +28,12 @@
 static struct dentry *cosm_dbg;
 
 /**
- * cosm_log_buf_show - Display MIC kernel log buffer
+ * log_buf_show - Display MIC kernel log buffer
  *
  * log_buf addr/len is read from System.map by user space
  * and populated in sysfs entries.
  */
-static int cosm_log_buf_show(struct seq_file *s, void *unused)
+static int log_buf_show(struct seq_file *s, void *unused)
 {
 	void __iomem *log_buf_va;
 	int __iomem *log_buf_len_va;
@@ -78,26 +78,15 @@ static int cosm_log_buf_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int cosm_log_buf_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, cosm_log_buf_show, inode->i_private);
-}
-
-static const struct file_operations log_buf_ops = {
-	.owner   = THIS_MODULE,
-	.open    = cosm_log_buf_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release
-};
+DEFINE_SHOW_ATTRIBUTE(log_buf);
 
 /**
- * cosm_force_reset_show - Force MIC reset
+ * force_reset_show - Force MIC reset
  *
  * Invokes the force_reset COSM bus op instead of the standard reset
  * op in case a force reset of the MIC device is required
  */
-static int cosm_force_reset_show(struct seq_file *s, void *pos)
+static int force_reset_show(struct seq_file *s, void *pos)
 {
 	struct cosm_device *cdev = s->private;
 
@@ -105,18 +94,7 @@ static int cosm_force_reset_show(struct seq_file *s, void *pos)
 	return 0;
 }
 
-static int cosm_force_reset_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, cosm_force_reset_show, inode->i_private);
-}
-
-static const struct file_operations force_reset_ops = {
-	.owner   = THIS_MODULE,
-	.open    = cosm_force_reset_debug_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release
-};
+DEFINE_SHOW_ATTRIBUTE(force_reset);
 
 void cosm_create_debug_dir(struct cosm_device *cdev)
 {
@@ -130,9 +108,10 @@ void cosm_create_debug_dir(struct cosm_device *cdev)
 	if (!cdev->dbg_dir)
 		return;
 
-	debugfs_create_file("log_buf", 0444, cdev->dbg_dir, cdev, &log_buf_ops);
+	debugfs_create_file("log_buf", 0444, cdev->dbg_dir, cdev,
+			    &log_buf_fops);
 	debugfs_create_file("force_reset", 0444, cdev->dbg_dir, cdev,
-			    &force_reset_ops);
+			    &force_reset_fops);
 }
 
 void cosm_delete_debug_dir(struct cosm_device *cdev)
diff --git a/drivers/misc/mic/host/mic_debugfs.c b/drivers/misc/mic/host/mic_debugfs.c
index 0a9daba8bb5d..c6e3c764699f 100644
--- a/drivers/misc/mic/host/mic_debugfs.c
+++ b/drivers/misc/mic/host/mic_debugfs.c
@@ -54,23 +54,7 @@ static int mic_smpt_show(struct seq_file *s, void *pos)
 	return 0;
 }
 
-static int mic_smpt_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mic_smpt_show, inode->i_private);
-}
-
-static int mic_smpt_debug_release(struct inode *inode, struct file *file)
-{
-	return single_release(inode, file);
-}
-
-static const struct file_operations smpt_file_ops = {
-	.owner   = THIS_MODULE,
-	.open    = mic_smpt_debug_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = mic_smpt_debug_release
-};
+DEFINE_SHOW_ATTRIBUTE(mic_smpt);
 
 static int mic_post_code_show(struct seq_file *s, void *pos)
 {
@@ -81,23 +65,7 @@ static int mic_post_code_show(struct seq_file *s, void *pos)
 	return 0;
 }
 
-static int mic_post_code_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mic_post_code_show, inode->i_private);
-}
-
-static int mic_post_code_debug_release(struct inode *inode, struct file *file)
-{
-	return single_release(inode, file);
-}
-
-static const struct file_operations post_code_ops = {
-	.owner   = THIS_MODULE,
-	.open    = mic_post_code_debug_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = mic_post_code_debug_release
-};
+DEFINE_SHOW_ATTRIBUTE(mic_post_code);
 
 static int mic_msi_irq_info_show(struct seq_file *s, void *pos)
 {
@@ -143,24 +111,7 @@ static int mic_msi_irq_info_show(struct seq_file *s, void *pos)
 	return 0;
 }
 
-static int mic_msi_irq_info_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mic_msi_irq_info_show, inode->i_private);
-}
-
-static int
-mic_msi_irq_info_debug_release(struct inode *inode, struct file *file)
-{
-	return single_release(inode, file);
-}
-
-static const struct file_operations msi_irq_info_ops = {
-	.owner   = THIS_MODULE,
-	.open    = mic_msi_irq_info_debug_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = mic_msi_irq_info_debug_release
-};
+DEFINE_SHOW_ATTRIBUTE(mic_msi_irq_info);
 
 /**
  * mic_create_debug_dir - Initialize MIC debugfs entries.
@@ -177,13 +128,14 @@ void mic_create_debug_dir(struct mic_device *mdev)
 	if (!mdev->dbg_dir)
 		return;
 
-	debugfs_create_file("smpt", 0444, mdev->dbg_dir, mdev, &smpt_file_ops);
+	debugfs_create_file("smpt", 0444, mdev->dbg_dir, mdev,
+			    &mic_smpt_fops);
 
 	debugfs_create_file("post_code", 0444, mdev->dbg_dir, mdev,
-			    &post_code_ops);
+			    &mic_post_code_fops);
 
 	debugfs_create_file("msi_irq_info", 0444, mdev->dbg_dir, mdev,
-			    &msi_irq_info_ops);
+			    &mic_msi_irq_info_fops);
 }
 
 /**
diff --git a/drivers/misc/mic/scif/scif_debugfs.c b/drivers/misc/mic/scif/scif_debugfs.c
index 6884dad97e17..cca5e980c710 100644
--- a/drivers/misc/mic/scif/scif_debugfs.c
+++ b/drivers/misc/mic/scif/scif_debugfs.c
@@ -24,7 +24,7 @@
 /* Debugfs parent dir */
 static struct dentry *scif_dbg;
 
-static int scif_dev_test(struct seq_file *s, void *unused)
+static int scif_dev_show(struct seq_file *s, void *unused)
 {
 	int node;
 
@@ -44,23 +44,7 @@ static int scif_dev_test(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int scif_dev_test_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, scif_dev_test, inode->i_private);
-}
-
-static int scif_dev_test_release(struct inode *inode, struct file *file)
-{
-	return single_release(inode, file);
-}
-
-static const struct file_operations scif_dev_ops = {
-	.owner   = THIS_MODULE,
-	.open    = scif_dev_test_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = scif_dev_test_release
-};
+DEFINE_SHOW_ATTRIBUTE(scif_dev);
 
 static void scif_display_window(struct scif_window *window, struct seq_file *s)
 {
@@ -104,7 +88,7 @@ static void scif_display_all_windows(struct list_head *head, struct seq_file *s)
 	}
 }
 
-static int scif_rma_test(struct seq_file *s, void *unused)
+static int scif_rma_show(struct seq_file *s, void *unused)
 {
 	struct scif_endpt *ep;
 	struct list_head *pos;
@@ -123,23 +107,7 @@ static int scif_rma_test(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int scif_rma_test_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, scif_rma_test, inode->i_private);
-}
-
-static int scif_rma_test_release(struct inode *inode, struct file *file)
-{
-	return single_release(inode, file);
-}
-
-static const struct file_operations scif_rma_ops = {
-	.owner   = THIS_MODULE,
-	.open    = scif_rma_test_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = scif_rma_test_release
-};
+DEFINE_SHOW_ATTRIBUTE(scif_rma);
 
 void __init scif_init_debugfs(void)
 {
@@ -150,8 +118,8 @@ void __init scif_init_debugfs(void)
 		return;
 	}
 
-	debugfs_create_file("scif_dev", 0444, scif_dbg, NULL, &scif_dev_ops);
-	debugfs_create_file("scif_rma", 0444, scif_dbg, NULL, &scif_rma_ops);
+	debugfs_create_file("scif_dev", 0444, scif_dbg, NULL, &scif_dev_fops);
+	debugfs_create_file("scif_rma", 0444, scif_dbg, NULL, &scif_rma_fops);
 	debugfs_create_u8("en_msg_log", 0666, scif_dbg, &scif_info.en_msg_log);
 	debugfs_create_u8("p2p_enable", 0666, scif_dbg, &scif_info.p2p_enable);
 }
diff --git a/drivers/misc/mic/vop/vop_debugfs.c b/drivers/misc/mic/vop/vop_debugfs.c
index ab43884e5cd7..2ccef52aca23 100644
--- a/drivers/misc/mic/vop/vop_debugfs.c
+++ b/drivers/misc/mic/vop/vop_debugfs.c
@@ -101,23 +101,7 @@ static int vop_dp_show(struct seq_file *s, void *pos)
 	return 0;
 }
 
-static int vop_dp_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, vop_dp_show, inode->i_private);
-}
-
-static int vop_dp_debug_release(struct inode *inode, struct file *file)
-{
-	return single_release(inode, file);
-}
-
-static const struct file_operations dp_ops = {
-	.owner   = THIS_MODULE,
-	.open    = vop_dp_debug_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = vop_dp_debug_release
-};
+DEFINE_SHOW_ATTRIBUTE(vop_dp);
 
 static int vop_vdev_info_show(struct seq_file *s, void *unused)
 {
@@ -194,23 +178,7 @@ static int vop_vdev_info_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int vop_vdev_info_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, vop_vdev_info_show, inode->i_private);
-}
-
-static int vop_vdev_info_debug_release(struct inode *inode, struct file *file)
-{
-	return single_release(inode, file);
-}
-
-static const struct file_operations vdev_info_ops = {
-	.owner   = THIS_MODULE,
-	.open    = vop_vdev_info_debug_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = vop_vdev_info_debug_release
-};
+DEFINE_SHOW_ATTRIBUTE(vop_vdev_info);
 
 void vop_init_debugfs(struct vop_info *vi)
 {
@@ -222,8 +190,8 @@ void vop_init_debugfs(struct vop_info *vi)
 		pr_err("can't create debugfs dir vop\n");
 		return;
 	}
-	debugfs_create_file("dp", 0444, vi->dbg, vi, &dp_ops);
-	debugfs_create_file("vdev_info", 0444, vi->dbg, vi, &vdev_info_ops);
+	debugfs_create_file("dp", 0444, vi->dbg, vi, &vop_dp_fops);
+	debugfs_create_file("vdev_info", 0444, vi->dbg, vi, &vop_vdev_info_fops);
 }
 
 void vop_exit_debugfs(struct vop_info *vi)
diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index 1874ac922166..e47abf173626 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -564,7 +564,7 @@ long st_kim_stop(void *kim_data)
 /* functions called from subsystems */
 /* called when debugfs entry is read from */
 
-static int show_version(struct seq_file *s, void *unused)
+static int version_show(struct seq_file *s, void *unused)
 {
 	struct kim_data_s *kim_gdata = (struct kim_data_s *)s->private;
 	seq_printf(s, "%04X %d.%d.%d\n", kim_gdata->version.full,
@@ -573,7 +573,7 @@ static int show_version(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int show_list(struct seq_file *s, void *unused)
+static int list_show(struct seq_file *s, void *unused)
 {
 	struct kim_data_s *kim_gdata = (struct kim_data_s *)s->private;
 	kim_st_list_protocols(kim_gdata->core_data, s);
@@ -688,30 +688,8 @@ void st_kim_ref(struct st_data_s **core_data, int id)
 	*core_data = NULL;
 }
 
-static int kim_version_open(struct inode *i, struct file *f)
-{
-	return single_open(f, show_version, i->i_private);
-}
-
-static int kim_list_open(struct inode *i, struct file *f)
-{
-	return single_open(f, show_list, i->i_private);
-}
-
-static const struct file_operations version_debugfs_fops = {
-	/* version info */
-	.open = kim_version_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-static const struct file_operations list_debugfs_fops = {
-	/* protocols info */
-	.open = kim_list_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(version);
+DEFINE_SHOW_ATTRIBUTE(list);
 
 /**********************************************************************/
 /* functions called from platform device driver subsystem
@@ -789,9 +767,9 @@ static int kim_probe(struct platform_device *pdev)
 	}
 
 	debugfs_create_file("version", S_IRUGO, kim_debugfs_dir,
-				kim_gdata, &version_debugfs_fops);
+				kim_gdata, &version_fops);
 	debugfs_create_file("protocols", S_IRUGO, kim_debugfs_dir,
-				kim_gdata, &list_debugfs_fops);
+				kim_gdata, &list_fops);
 	return 0;
 
 err_sysfs_group:
diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 9b0b3fa4f836..e43cec7f3a86 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1470,18 +1470,7 @@ static int vmballoon_debug_show(struct seq_file *f, void *offset)
 	return 0;
 }
 
-static int vmballoon_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, vmballoon_debug_show, inode->i_private);
-}
-
-static const struct file_operations vmballoon_debug_fops = {
-	.owner		= THIS_MODULE,
-	.open		= vmballoon_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(vmballoon_debug);
 
 static int __init vmballoon_debugfs_init(struct vmballoon *b)
 {
-- 
2.17.0

