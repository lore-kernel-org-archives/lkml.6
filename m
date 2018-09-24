Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE2AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705D721486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705D721486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388307AbeIXSgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:36:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58408 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387489AbeIXSgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:36:07 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 76F381018;
        Mon, 24 Sep 2018 12:34:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c75f181dc8429d2eb887@syzkaller.appspotmail.com,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.18 108/235] ovl: fix oopses in ovl_fill_super() failure paths
Date:   Mon, 24 Sep 2018 13:51:34 +0200
Message-Id: <20180924113116.469311945@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit 8c25741aaad8be6fbe51510e917c740e0059cf83 upstream.

ovl_free_fs() dereferences ofs->workbasedir and ofs->upper_mnt in cases when
those might not have been initialized yet.

Fix the initialization order for these fields.

Reported-by: syzbot+c75f181dc8429d2eb887@syzkaller.appspotmail.com
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc:  <stable@vger.kernel.org> # v4.15
Fixes: 95e6d4177cb7 ("ovl: grab reference to workbasedir early")
Fixes: a9075cdb467d ("ovl: factor out ovl_free_fs() helper")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/super.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -970,16 +970,6 @@ static int ovl_get_upper(struct ovl_fs *
 	if (err)
 		goto out;
 
-	err = -EBUSY;
-	if (ovl_inuse_trylock(upperpath->dentry)) {
-		ofs->upperdir_locked = true;
-	} else if (ofs->config.index) {
-		pr_err("overlayfs: upperdir is in-use by another mount, mount with '-o index=off' to override exclusive upperdir protection.\n");
-		goto out;
-	} else {
-		pr_warn("overlayfs: upperdir is in-use by another mount, accessing files from both mounts will result in undefined behavior.\n");
-	}
-
 	upper_mnt = clone_private_mount(upperpath);
 	err = PTR_ERR(upper_mnt);
 	if (IS_ERR(upper_mnt)) {
@@ -990,6 +980,17 @@ static int ovl_get_upper(struct ovl_fs *
 	/* Don't inherit atime flags */
 	upper_mnt->mnt_flags &= ~(MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME);
 	ofs->upper_mnt = upper_mnt;
+
+	err = -EBUSY;
+	if (ovl_inuse_trylock(ofs->upper_mnt->mnt_root)) {
+		ofs->upperdir_locked = true;
+	} else if (ofs->config.index) {
+		pr_err("overlayfs: upperdir is in-use by another mount, mount with '-o index=off' to override exclusive upperdir protection.\n");
+		goto out;
+	} else {
+		pr_warn("overlayfs: upperdir is in-use by another mount, accessing files from both mounts will result in undefined behavior.\n");
+	}
+
 	err = 0;
 out:
 	return err;
@@ -1089,8 +1090,10 @@ static int ovl_get_workdir(struct ovl_fs
 		goto out;
 	}
 
+	ofs->workbasedir = dget(workpath.dentry);
+
 	err = -EBUSY;
-	if (ovl_inuse_trylock(workpath.dentry)) {
+	if (ovl_inuse_trylock(ofs->workbasedir)) {
 		ofs->workdir_locked = true;
 	} else if (ofs->config.index) {
 		pr_err("overlayfs: workdir is in-use by another mount, mount with '-o index=off' to override exclusive workdir protection.\n");
@@ -1099,7 +1102,6 @@ static int ovl_get_workdir(struct ovl_fs
 		pr_warn("overlayfs: workdir is in-use by another mount, accessing files from both mounts will result in undefined behavior.\n");
 	}
 
-	ofs->workbasedir = dget(workpath.dentry);
 	err = ovl_make_workdir(ofs, &workpath);
 	if (err)
 		goto out;


