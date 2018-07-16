Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF94ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9BA208FE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9BA208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388213AbeGPIG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:06:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47324 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731241AbeGPIG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:06:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 99E7CC03;
        Mon, 16 Jul 2018 07:40:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 22/54] devpts: hoist out check for DEVPTS_SUPER_MAGIC
Date:   Mon, 16 Jul 2018 09:35:19 +0200
Message-Id: <20180716073455.006137659@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073450.534886211@linuxfoundation.org>
References: <20180716073450.534886211@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <christian.brauner@ubuntu.com>

commit 7d71109df186d630a41280670c8d71d0cf9b0da9 upstream.

Hoist the check whether we have already found a suitable devpts filesystem
out of devpts_ptmx_path() in preparation for the devpts bind-mount
resolution patch. This is a non-functional change.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/devpts/inode.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -138,10 +138,6 @@ static int devpts_ptmx_path(struct path
 	struct super_block *sb;
 	int err;
 
-	/* Has the devpts filesystem already been found? */
-	if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)
-		return 0;
-
 	/* Is a devpts filesystem at "pts" in the same directory? */
 	err = path_pts(path);
 	if (err)
@@ -159,21 +155,25 @@ static int devpts_ptmx_path(struct path
 struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
 {
 	struct path path;
-	int err;
+	int err = 0;
 
 	path = filp->f_path;
 	path_get(&path);
 
-	err = devpts_ptmx_path(&path);
+	/* Has the devpts filesystem already been found? */
+	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC)
+		err = devpts_ptmx_path(&path);
 	dput(path.dentry);
 	if (err) {
 		mntput(path.mnt);
 		return ERR_PTR(err);
 	}
+
 	if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
 		mntput(path.mnt);
 		return ERR_PTR(-ENODEV);
 	}
+
 	return path.mnt;
 }
 
@@ -182,15 +182,19 @@ struct pts_fs_info *devpts_acquire(struc
 	struct pts_fs_info *result;
 	struct path path;
 	struct super_block *sb;
-	int err;
 
 	path = filp->f_path;
 	path_get(&path);
 
-	err = devpts_ptmx_path(&path);
-	if (err) {
-		result = ERR_PTR(err);
-		goto out;
+	/* Has the devpts filesystem already been found? */
+	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) {
+		int err;
+
+		err = devpts_ptmx_path(&path);
+		if (err) {
+			result = ERR_PTR(err);
+			goto out;
+		}
 	}
 
 	/*


