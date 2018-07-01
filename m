Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95576C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D23325171
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D23325171
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964989AbeGAQZH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:25:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33608 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932790AbeGAQZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:25:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2E46AAE0;
        Sun,  1 Jul 2018 16:25:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+32c236387d66c4516827@syzkaller.appspotmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.9 023/101] fuse: fix control dir setup and teardown
Date:   Sun,  1 Jul 2018 18:21:09 +0200
Message-Id: <20180701160758.070967043@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit 6becdb601bae2a043d7fb9762c4d48699528ea6e upstream.

syzbot is reporting NULL pointer dereference at fuse_ctl_remove_conn() [1].
Since fc->ctl_ndents is incremented by fuse_ctl_add_conn() when new_inode()
failed, fuse_ctl_remove_conn() reaches an inode-less dentry and tries to
clear d_inode(dentry)->i_private field.

Fix by only adding the dentry to the array after being fully set up.

When tearing down the control directory, do d_invalidate() on it to get rid
of any mounts that might have been added.

[1] https://syzkaller.appspot.com/bug?id=f396d863067238959c91c0b7cfc10b163638cac6
Reported-by: syzbot <syzbot+32c236387d66c4516827@syzkaller.appspotmail.com>
Fixes: bafa96541b25 ("[PATCH] fuse: add control filesystem")
Cc: <stable@vger.kernel.org> # v2.6.18
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/control.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -211,10 +211,11 @@ static struct dentry *fuse_ctl_add_dentr
 	if (!dentry)
 		return NULL;
 
-	fc->ctl_dentry[fc->ctl_ndents++] = dentry;
 	inode = new_inode(fuse_control_sb);
-	if (!inode)
+	if (!inode) {
+		dput(dentry);
 		return NULL;
+	}
 
 	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
@@ -228,6 +229,9 @@ static struct dentry *fuse_ctl_add_dentr
 	set_nlink(inode, nlink);
 	inode->i_private = fc;
 	d_add(dentry, inode);
+
+	fc->ctl_dentry[fc->ctl_ndents++] = dentry;
+
 	return dentry;
 }
 
@@ -284,7 +288,10 @@ void fuse_ctl_remove_conn(struct fuse_co
 	for (i = fc->ctl_ndents - 1; i >= 0; i--) {
 		struct dentry *dentry = fc->ctl_dentry[i];
 		d_inode(dentry)->i_private = NULL;
-		d_drop(dentry);
+		if (!i) {
+			/* Get rid of submounts: */
+			d_invalidate(dentry);
+		}
 		dput(dentry);
 	}
 	drop_nlink(d_inode(fuse_control_sb->s_root));


