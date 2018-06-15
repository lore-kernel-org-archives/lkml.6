Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7B2A8C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C865208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C865208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965210AbeFOAGl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 20:06:41 -0400
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:60347
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965096AbeFOAGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 20:06:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AKEACSAiNb/0cq0XZdHgEGDINIgU8Sh?=
 =?us-ascii?q?CGUVkUBAQEBAQEGgQ00llMeGAGEQIJLITcVAQIBAQEBAQECbQQkhVIEUigBDAI?=
 =?us-ascii?q?YDgJJFoUpDKk9gWkzGgKILIFogQuHQYEMgQeBP4pSglUCjR2LcQmPAYgXhR8Bk?=
 =?us-ascii?q?xgigVJNLgqCf4FrAY5vMoEqAQGQAAEB?=
X-IPAS-Result: =?us-ascii?q?A2AKEACSAiNb/0cq0XZdHgEGDINIgU8ShCGUVkUBAQEBAQE?=
 =?us-ascii?q?GgQ00llMeGAGEQIJLITcVAQIBAQEBAQECbQQkhVIEUigBDAIYDgJJFoUpDKk9g?=
 =?us-ascii?q?WkzGgKILIFogQuHQYEMgQeBP4pSglUCjR2LcQmPAYgXhR8BkxgigVJNLgqCf4F?=
 =?us-ascii?q?rAY5vMoEqAQGQAAEB?=
X-IronPort-AV: E=Sophos;i="5.51,224,1526313600"; 
   d="scan'208";a="81277956"
Received: from unknown (HELO pluto.themaw.net) ([118.209.42.71])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 15 Jun 2018 08:06:32 +0800
Subject: [PATCH] autofs - fix directory and symlink access
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 15 Jun 2018 08:06:30 +0800
Message-ID: <152902119090.4144.9561910674530214291.stgit@pluto.themaw.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on how it is configured the autofs user space daemon can
leave in use mounts mounted at exit and re-connect to them at start
up. But for this to work best the state of the autofs file system
needs to be left intact over the restart.

Also, at system shutdown, mounts in an autofs file system might be
umounted exposing a mount point trigger for which subsequent access
can lead to a hang. So recent versions of automount(8) now does its
best to set autofs file system mounts catatonic at shutdown.

When autofs file system mounts are catatonic it's currently possible
to create and remove directories and symlinks which can be a problem
at restart, as described above.

So return EACCES in the directory, symlink and unlink methods if the
autofs file system is catatonic.
---
 fs/autofs/root.c |   33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index a3d414150578..782e57b911ab 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -559,6 +559,13 @@ static int autofs_dir_symlink(struct inode *dir,
 	if (!autofs_oz_mode(sbi))
 		return -EACCES;
 
+	/* autofs_oz_mode() needs to allow path walks when the
+	 * autofs mount is catatonic but the state of an autofs
+	 * file system needs to be preserved over restarts.
+	 */
+	if (sbi->catatonic)
+		return -EACCES;
+
 	BUG_ON(!ino);
 
 	autofs_clean_ino(ino);
@@ -612,9 +619,15 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 
-	/* This allows root to remove symlinks */
-	if (!autofs_oz_mode(sbi) && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
+	if (!autofs_oz_mode(sbi))
+		return -EACCES;
+
+	/* autofs_oz_mode() needs to allow path walks when the
+	 * autofs mount is catatonic but the state of an autofs
+	 * file system needs to be preserved over restarts.
+	 */
+	if (sbi->catatonic)
+		return -EACCES;
 
 	if (atomic_dec_and_test(&ino->count)) {
 		p_ino = autofs_dentry_ino(dentry->d_parent);
@@ -697,6 +710,13 @@ static int autofs_dir_rmdir(struct inode *dir, struct dentry *dentry)
 	if (!autofs_oz_mode(sbi))
 		return -EACCES;
 
+	/* autofs_oz_mode() needs to allow path walks when the
+	 * autofs mount is catatonic but the state of an autofs
+	 * file system needs to be preserved over restarts.
+	 */
+	if (sbi->catatonic)
+		return -EACCES;
+
 	spin_lock(&sbi->lookup_lock);
 	if (!simple_empty(dentry)) {
 		spin_unlock(&sbi->lookup_lock);
@@ -735,6 +755,13 @@ static int autofs_dir_mkdir(struct inode *dir,
 	if (!autofs_oz_mode(sbi))
 		return -EACCES;
 
+	/* autofs_oz_mode() needs to allow path walks when the
+	 * autofs mount is catatonic but the state of an autofs
+	 * file system needs to be preserved over restarts.
+	 */
+	if (sbi->catatonic)
+		return -EACCES;
+
 	pr_debug("dentry %p, creating %pd\n", dentry, dentry);
 
 	BUG_ON(!ino);

