Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352FDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BC920664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BC920664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409425AbeKWVZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:25:40 -0500
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:13399
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390243AbeKWVZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:25:39 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AcAACP2Pdb/7650XYNVRwBAQEEAQE?=
 =?us-ascii?q?HBAEBgVMFAQELAYFVgj2DeZRhAQEBAQEBBoEQg2eFV44igXqEdAMCAoQ1Ngc?=
 =?us-ascii?q?NAQMBAQEBAQEChlICAQMjBFIQGAEMAiYCAkcQBhOFFqY7cHwzGol9gQuBc4k?=
 =?us-ascii?q?ieIEHgREzimGCVwKJI4V2QzOPcwmRRwoCiWkDhxCCeJcFDYF5TS4KgyeQZ2W?=
 =?us-ascii?q?KXSuCIAEB?=
X-IPAS-Result: =?us-ascii?q?A2AcAACP2Pdb/7650XYNVRwBAQEEAQEHBAEBgVMFAQELA?=
 =?us-ascii?q?YFVgj2DeZRhAQEBAQEBBoEQg2eFV44igXqEdAMCAoQ1NgcNAQMBAQEBAQECh?=
 =?us-ascii?q?lICAQMjBFIQGAEMAiYCAkcQBhOFFqY7cHwzGol9gQuBc4kieIEHgREzimGCV?=
 =?us-ascii?q?wKJI4V2QzOPcwmRRwoCiWkDhxCCeJcFDYF5TS4KgyeQZ2WKXSuCIAEB?=
X-IronPort-AV: E=Sophos;i="5.56,269,1539619200"; 
   d="scan'208";a="122563337"
Received: from unknown (HELO [192.168.1.28]) ([118.209.185.190])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 23 Nov 2018 18:41:51 +0800
Subject: [PATCH v2 1/5] autofs - improve ioctl sbi checks
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 23 Nov 2018 18:41:50 +0800
Message-ID: <154296970987.9889.1597442413573683096.stgit@pluto-themaw-net>
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

Al Viro made some suggestions to improve the implementation
of commit 0633da48f0 "fix autofs_sbi() does not check super
block type".

The check is unnessesary in all cases except for ioctl usage
so placing the check in the super block accessor function
adds a small overhead to the common case where it isn't
needed.

So it's sufficient to do this in the ioctl code only.

Also the check in the ioctl code is needlessly complex.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
---
 fs/autofs/autofs_i.h  |    3 +--
 fs/autofs/dev-ioctl.c |   25 +++++++------------------
 fs/autofs/init.c      |    2 +-
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 9f9cadbfbd7a..c4301e33c027 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -126,8 +126,7 @@ struct autofs_sb_info {
 
 static inline struct autofs_sb_info *autofs_sbi(struct super_block *sb)
 {
-	return sb->s_magic != AUTOFS_SUPER_MAGIC ?
-		NULL : (struct autofs_sb_info *)(sb->s_fs_info);
+	return (struct autofs_sb_info *)(sb->s_fs_info);
 }
 
 static inline struct autofs_info *autofs_dentry_ino(struct dentry *dentry)
diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index 86eafda4a652..3de4f5e61caf 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -14,6 +14,8 @@
 
 #include "autofs_i.h"
 
+extern struct file_system_type autofs_fs_type;
+
 /*
  * This module implements an interface for routing autofs ioctl control
  * commands via a miscellaneous device file.
@@ -151,22 +153,6 @@ static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
 	return err;
 }
 
-/*
- * Get the autofs super block info struct from the file opened on
- * the autofs mount point.
- */
-static struct autofs_sb_info *autofs_dev_ioctl_sbi(struct file *f)
-{
-	struct autofs_sb_info *sbi = NULL;
-	struct inode *inode;
-
-	if (f) {
-		inode = file_inode(f);
-		sbi = autofs_sbi(inode->i_sb);
-	}
-	return sbi;
-}
-
 /* Return autofs dev ioctl version */
 static int autofs_dev_ioctl_version(struct file *fp,
 				    struct autofs_sb_info *sbi,
@@ -658,6 +644,8 @@ static int _autofs_dev_ioctl(unsigned int command,
 	if (cmd != AUTOFS_DEV_IOCTL_VERSION_CMD &&
 	    cmd != AUTOFS_DEV_IOCTL_OPENMOUNT_CMD &&
 	    cmd != AUTOFS_DEV_IOCTL_CLOSEMOUNT_CMD) {
+		struct super_block *sb;
+
 		fp = fget(param->ioctlfd);
 		if (!fp) {
 			if (cmd == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD)
@@ -666,12 +654,13 @@ static int _autofs_dev_ioctl(unsigned int command,
 			goto out;
 		}
 
-		sbi = autofs_dev_ioctl_sbi(fp);
-		if (!sbi || sbi->magic != AUTOFS_SBI_MAGIC) {
+		sb = file_inode(fp)->i_sb;
+		if (sb->s_type != &autofs_fs_type) {
 			err = -EINVAL;
 			fput(fp);
 			goto out;
 		}
+		sbi = autofs_sbi(sb);
 
 		/*
 		 * Admin needs to be able to set the mount catatonic in
diff --git a/fs/autofs/init.c b/fs/autofs/init.c
index 79ae07d9592f..c0c1db2cc6ea 100644
--- a/fs/autofs/init.c
+++ b/fs/autofs/init.c
@@ -16,7 +16,7 @@ static struct dentry *autofs_mount(struct file_system_type *fs_type,
 	return mount_nodev(fs_type, flags, data, autofs_fill_super);
 }
 
-static struct file_system_type autofs_fs_type = {
+struct file_system_type autofs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "autofs",
 	.mount		= autofs_mount,

