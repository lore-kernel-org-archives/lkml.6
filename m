Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57971C5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3768220850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3768220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937215AbeFSCvE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:51:04 -0400
Received: from icp-osb-irony-out7.external.iinet.net.au ([203.59.1.107]:56078
        "EHLO icp-osb-irony-out7.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934644AbeFSCvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:51:02 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DFEwAObyhb/6c80XZcHgEGDINJgU8SK?=
 =?us-ascii?q?IN5lFZGAQEBAQEGgUGWWB4YAYRAgmEhNxUBAgEBAQEBAQJtBCSFUgRSKAEMAhg?=
 =?us-ascii?q?OAkkWE4UYDKpRgWkzGgKILYFogQuHSYEMgQeMEYJVAo0gi3YJjwmIGIUjkyQig?=
 =?us-ascii?q?VJNLgqCfoFsAY5vMjB6AQGQUgEB?=
X-IPAS-Result: =?us-ascii?q?A2DFEwAObyhb/6c80XZcHgEGDINJgU8SKIN5lFZGAQEBAQE?=
 =?us-ascii?q?GgUGWWB4YAYRAgmEhNxUBAgEBAQEBAQJtBCSFUgRSKAEMAhgOAkkWE4UYDKpRg?=
 =?us-ascii?q?WkzGgKILYFogQuHSYEMgQeMEYJVAo0gi3YJjwmIGIUjkyQigVJNLgqCfoFsAY5?=
 =?us-ascii?q?vMjB6AQGQUgEB?=
X-IronPort-AV: E=Sophos;i="5.51,241,1526313600"; 
   d="scan'208";a="90291035"
Received: from unknown (HELO pluto.themaw.net) ([118.209.60.167])
  by icp-osb-irony-out7.iinet.net.au with ESMTP; 19 Jun 2018 10:50:18 +0800
Subject: [PATCH 1/7] autofs - fix directory and symlink access
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Jun 2018 10:50:18 +0800
Message-ID: <152937661793.20656.604490449672006599.stgit@pluto.themaw.net>
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

Signed-off-by: Ian Kent <raven@themaw.net>
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

